% todo: doc
%---Locate a white image database from one of several user inputs---
% input options:
% full path including filename
% full path no filename
% base path, with file in a subfolder -> perform search
% will not return a result in case of ambiguity, e.g. if two databases are found

function DatabasePath = LFLocateDatabaseFile( DatabasePath, DatabaseFname )
if( ~isfile( DatabasePath ) )
	if( isfolder( DatabasePath ) )
		TentativeFullPath =  ...
			fullfile( DatabasePath, DatabaseFname );
		if( ~isfile( TentativeFullPath ) )
			% try finding a database under the requested location
			FoundFiles = LFFindFilesRecursive( DatabasePath, DatabaseFname );
			NumFound = length(FoundFiles);
			if( NumFound ~= 1 )
				ErrorMessage = sprintf( ...
					'Needed 1 database file, found %d named ''%s'' under folder ''%s''\n', NumFound, ...
					DatabaseFname, DatabasePath );
				error( ErrorMessage );
			else
				TentativeFullPath = fullfile( DatabasePath, FoundFiles{1} );
			end
		end
		DatabasePath = TentativeFullPath;
		fprintf('Using %s\n', DatabasePath);
	else
		error('Unable to locate database file %s', DatabasePath); % shouldn't happen
	end
end
end