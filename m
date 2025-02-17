Return-Path: <linux-pci+bounces-21630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A68A3878C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8252A7A10BA
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 15:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CBC21CA1B;
	Mon, 17 Feb 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="knBkF2Lh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E231A2380
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806265; cv=fail; b=PFtP/YDEK39muP5oxZDzT0QHNwMy1t1FlzhCp5bp0Txd35eWG/lnbTKRv/QxlycZT1Omo9gFN/JuL6KCTS2KljU9tnqWGMDIlY+naXZ/rpjw2YhG39XIKr0Ty1nBHTf26PZVN1jMhU7WdzkQsEM9ttOgayfg4OtSLaDuwioyNK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806265; c=relaxed/simple;
	bh=s1USbP3nL6C1Ut8dqV56hNyhchvxiSW0Fx3j844z+ks=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cD5s2QlVrfSkI3UpUnRhGBTrl0itGxVg+SYjrGhxLOle14eUE91qpY7FiT6jnhVx4hC7tbDShpra3/SOVbuQqqLiZTccEabrsks+BLOVC4m9q0WlxWHNkzUwCGG0zIGS2zd6XMBSmtk1csiIaIF87n/GHHCjtp0yFjszVPnkTjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=knBkF2Lh; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9uSa9K6mY7Tfg7wk1zBn0Mgy5z1NHF+1hr5caEdgsXWbWIs53ZOoEhs4g1+JvqgJ6EjvBc4vVy/eRWYvMFzbbCDvXPSQhtoQel8YYGYYPie4rdulf5iW3HaTx1Ryq+81qrAVVWKdU1Bml8z5yYqrh4Zm0vi6OSstmMQs6HJkWhebSUr7ExOCCp8/Mw4KaJbGGVPyuMjHlxzoXXIFwS1zlSXPh9lvdm8foSw51qicuNv/6KkOS05pQUijm2b+r+hLS1KMlXfXrbq71ro879Abi4n9igi4U5AUcxDExmm+FK7QT6ZoZDO+WCcCIBiP/7YlLQHnVzqMYTjRxbJVN6hww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9SCtKwARQa49qMk1e3Cb+5zCmkBg0vTkTv4VPYfHHI=;
 b=gkv2BXtE2IBwl/QtFGivKjqDBaiE4TzIoOmOcSakMhoLYSC33mNjW2Da8KjwKMXn7FjbSe1ysjrPjFyB6IiwOtUn28A3gv33hf6Io816EaZo+kacvgSUnXpIcFA83MagyNvaO1Wk3zLbj1K78YligTxBsG7i+5lbj7Obal3FPK/TuXw2GVcThvuGMk1IdCiFXXwYZSkKqc5jPENKK8hTCuKryyOpHzg8jd7J9UkhvWiKTNy9Yguwx8i/h/jtZYM8SrcwDRq3C+8yak9a1mtOQebGf5V2B27Hp4nfq30XO6TMKp9Pqd5KnmabzGQkKL9HggkD/ySxSOlrOXCzGzJGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9SCtKwARQa49qMk1e3Cb+5zCmkBg0vTkTv4VPYfHHI=;
 b=knBkF2LhZspjoP9fjoB19Bo9Zoan1sR3CXn5BHnFX3+qKRoVxLrZ8OG+9vV+idTkg3WI5uV1/PuvutBHGxOD8JJSrQ04miJ2PskQPLV/DPBSfzhz3DtMW+Rfv4DrRKNOTtyOZyVm55O6Ryk6gQHnYb+35qhgcIs7p3nniK0D9hQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 15:31:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 15:31:00 +0000
Message-ID: <1654fb6c-e0e8-4dde-8554-7058cf73503d@amd.com>
Date: Mon, 17 Feb 2025 16:30:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: fix Sapphire PCI rebar quirk
To: Alex Deucher <alexander.deucher@amd.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org
Cc: Mario.Limonciello@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>
References: <20250217151053.420882-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250217151053.420882-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 141565c6-d0a6-4928-d099-08dd4f68151c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmxMSHBsaVJLMDQ5QVFUY2VseXFiYi8wUnZOa1AreHc4czVhcFo4VXpwL082?=
 =?utf-8?B?Q3R1aThEYlAvMzl6amJmWDJIVHVEdWV5bDQ0SGJQOGpvTWErSmIyVmoreDB2?=
 =?utf-8?B?VnQvZkpYWUlsMXlrYXVlWnhJZFNTOThOWXAreGdoK3BFTzFxd3VZSDZaa2Nk?=
 =?utf-8?B?T001SUpUSDRzVGdpbmRYbEEvS0ZVOWI3ZFJ4M1piOTZJSlRXUEp5NTdmemNZ?=
 =?utf-8?B?SVEzd1JwQzdiTi92NXFpSXduQ05NbnJ2a1RSTm9ySTRkTUU2cEViYkRmVDN2?=
 =?utf-8?B?QlkvY0luay9zUWRlNU9FbDNtbjJ1RXF2bU5OdjFOQVhaeUlUOE5GZ0tqN05w?=
 =?utf-8?B?dEtuVUljUGRGSjNwVmFLWDVPRGtEOVZzVWR3Yy9wMTF5ajVMdTRsdUs0dUJN?=
 =?utf-8?B?ZTBueU9lOWNoMmowWTY2STFnbUlZa3pkbm1KUEFkVlRFSjBNTmkrSm8wMktS?=
 =?utf-8?B?K2xwazhOQ0hDbkcwOTNiWk00SG0zdS8yMlBiUlQzaDF4RnMyWGMvUXNaZjVy?=
 =?utf-8?B?bHZGT25nKzFiYXBRYkpXTk11Ui81L3lpNXdtYm8zZ0plZ25NbTZ4Q3NPWXFo?=
 =?utf-8?B?ZG1wYWYwYjd5NXZuYjU0UlcwZkd2TzlVTzBaaFFibnFxSzZmeThaSFNOZ1M3?=
 =?utf-8?B?WUo5cjFuSEpXQVJ3SnQwSTZERHBkMzRFMHFNaFltTGptVUNRajJYYklMUzRL?=
 =?utf-8?B?TUk5RTV3QXJqVkE3KzFoN3g1VFpJaVpkL2FTTlM2d1lCZmtRckNEbzNJK01N?=
 =?utf-8?B?ZjVnK1pmWUI4a0FieUlYVFZzV0FnYUlMVDZVOHZRbnhSamxtYWp6SDBZU2Nv?=
 =?utf-8?B?dC9CdWF3cU03bzltbzhyWVpjNlRNa2F6OEtzSVVEb0ZGT0VIb3ZBU1MwbjFG?=
 =?utf-8?B?S3ovV3dodDk1c2hsVlkxeDZZeHJVTjZzdWRGVVlNMmlVTnMwbTNrSmlwMTVE?=
 =?utf-8?B?OGppRTFHU1plVXhpOW1EUUlFZitJS3ZscERIZGt0WmFsbVZkVDFGQ1YwL1hD?=
 =?utf-8?B?dnlSY3Qrc0t0R2o3MFhPbDRtRnM2Z2VKbEN4R09BaFpRNnhkWjRxWW1DNFNB?=
 =?utf-8?B?dzFFZFB4aUhhN2pIRTBDdHZvZDZITUFHdkw4N0dkbzlrcFI2ZnUrdklIdmJm?=
 =?utf-8?B?YkovY05MdEV3dllRWS82OGJNMEYwY0NzT3JaTXc0K3VWdThiMkN2Qi85VXlZ?=
 =?utf-8?B?RVJoU2xiTWZPRVFLc0h2QWpha3pvNHJ0d1RGYWJORUxKbnVuTUpZY24wMktF?=
 =?utf-8?B?b1J1cGNJZGhxY3lmczVkR281QVI2N2txdEZxd0pXYnhjdVR6eWxlYXJnczNk?=
 =?utf-8?B?QjdIUmI5TXBmbWZxR29HUG5nbzB0Q2xqZ29YOEo3Um41WHpycktIUWJGTkFL?=
 =?utf-8?B?R1ZjeS95aVdGbjdQd0hNTFJHMFFSYU1nWW1KUmhuNFBZQU9rdHprbEdkcHp5?=
 =?utf-8?B?bVBXa25WTUdyMGVxRERONE5YRmNmenZDZjIvWmdkeS9ZUDh0UzlrOWtCSHdS?=
 =?utf-8?B?QmU0bGZDTTBrY0FkRlltdHdvQWRJMWlRWG9Da0JkbkRuN1h4RlFBMmNTYVl2?=
 =?utf-8?B?VDBkdkNlenhobjJDdlhuNXJyVjJTRzd1NFhGRUl6L0ZFdzhKbG53bFBQZFVH?=
 =?utf-8?B?UVo5cVF2U2VZMWxLaXBJbm4yNUhmSzFaVHpDZGQrTEw4RTV0UG1aZElQbGxK?=
 =?utf-8?B?bWhFbU1PR2k1NWkyMDlDYWVPWWMvUzJvSFJpVC9qcXZHSTUzb3F1cWJRNTNh?=
 =?utf-8?B?WEFJdC9LRnJjMFY3TWlYS1Z2bUhYdmpjTnQvYmEyU0Y2NlV5RER1czgwODVv?=
 =?utf-8?B?VFV5dDBKZVhnNFYvZzk3Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3ZBekQ2OHNrM0hjb3pSdlRoRUt3bFV3VExvL0tjM05MNTZTSHNUYWkvanBM?=
 =?utf-8?B?cW93MG1HVXhiYnJUcUUyNXBtaDl6NTRLZHNsOW9UVUxzZElESE81WGR3TDFl?=
 =?utf-8?B?UFdTd3BvcjZLZUIwd1RDbXVGS3docy9OeHNBRDVaVlcyQ0Z3cC9YdWRCY1kx?=
 =?utf-8?B?eGZ2WkZVSXN2eTJNaGFQdVB5RkM4MWtuMGxYY3F2ckxDTnNqQmZocVN4M2R4?=
 =?utf-8?B?RXRGSU9iZnhYdU5vak1CZ1EyQnB4bnU1cThsNTZhUHVJeXl3ek83QSsrWHgr?=
 =?utf-8?B?QmplMGNOQm9qNGQyc1hCbytFdHZwWmg4QUhtZUJ4dGRLWjRVM1c0ZjdHNDlu?=
 =?utf-8?B?UmJ5NzBaenFTaHJQcmZGN3ZLdUxUcFRoMjNuc0pRVm92YnMyS1h3Q3k2dDBQ?=
 =?utf-8?B?d0Z5bEJTY2c1dE1raVVDSDNjOWVjYXZYVUo4aGpCdk8rYzB1cXl2c1IvWjhG?=
 =?utf-8?B?TnVseERzQ3dEVFlKOUVLZmlGekZ4OHhKay9Malh6M2F6eSt1eG1yb1hUWnU0?=
 =?utf-8?B?YVVPcnpFSnFmK1VFWkc0VlpWcExSdnlBY0hkVFkxSkZpTlJpWm1HZ1ZnTFVx?=
 =?utf-8?B?bnVLVHZnajZMVC9vYzdSaG1yVXIyVDJPR3dvelR4eVZGMk5ycnRsOFdmb29I?=
 =?utf-8?B?MzFNbytIUEh5Tis0bDlWeTUva3BuU04wdlZKT0ZHSERXY25SZll1NVZldjFI?=
 =?utf-8?B?YUVVbm5XVFZFSmNOMTdRLzZRMGJZSk9rcFVZWUVZS1RycXMycko3QmxycHNt?=
 =?utf-8?B?SHVaZExZWWdnV1NycTdZbG1xZSs2UytrQVRkNHlyR3l1WG9GL3h2Qjc2azlG?=
 =?utf-8?B?bG5qUWRFYWZ4NXVYckM5SVZrdEpaWFZOSVdwWlo4b3Z4ZmczeWRydDNVMmZ5?=
 =?utf-8?B?V1BwVGl2OFNnSFNrNWdUYUxZaVVYYllZZzA2NU9EMzh5S0VDWGhDT0ZTdjdG?=
 =?utf-8?B?Q09PN2tGTWZxY3krQ0h2djFvbkh6VmtYUWttVUFudTdvaTdGYXgzTXZUcTVC?=
 =?utf-8?B?eW4zc1F5SlJvcWFMYm95MlBWUEZaZTNnT0RETVZ3S3BCa0FtQmFib1VxYVhi?=
 =?utf-8?B?UE94ZG1yeGRjcWZrbHBydGNBSS83UFl6MkdhVjM1d1VkUXd5a082QUlwZ3JV?=
 =?utf-8?B?R2FhMjJJL0ZUYzhMWTFXOVk2MDVTYjRXT3AxSzZlWHhOd0Q3WVNNa0NMeWFS?=
 =?utf-8?B?NTZQaUNlMCtTdzhmU25HMmVnNEtwMnhMZW4wTnExU05NMGZRSXVZRUdrVTFo?=
 =?utf-8?B?T0hBYXUxN2tlMHVXKzgyZHFXZ2RaT2J2UHE2WjNOMVB4bDBDMDhQOTNKbE8w?=
 =?utf-8?B?Z3pZU3FUVUcrY0xOelRqNXRKTVpDcFBtUWRhcDAwQmlPZkJ3bVMzVlpLQjcw?=
 =?utf-8?B?TGRxbzhkN0tjVlhSVGxHbmFPVlFpV2swSGNZSlErY0QxVk0wSTAwejFtekx3?=
 =?utf-8?B?NW9vN3M3UmtNSGNsSHcwcUxrOTF5aXIvTVYzS2Q0bkNEQSt3cHAyWWJaTUMz?=
 =?utf-8?B?NlFUaWFXanIrekJRQitOVzFPWGxMUVphRUMyNTFMODNJOWlSRG5LaDhrM2dK?=
 =?utf-8?B?TzFpdStqRFBVcXlZVUpuU1c2aDhnb0s1QUhoVEZHNE5sNFlVeS9zQUNGMVIx?=
 =?utf-8?B?V0lxVitGL1VhNjVjRis2YkhVcit2TGJDdTVzc0xnSE42VWZCYWF5d1lZNGxY?=
 =?utf-8?B?TXo0KzgyVWxkWHpkTFFXZGw5TXo0cklLYS9xVjladkNOZjB2djRmeW1VV3Bk?=
 =?utf-8?B?SzgyODVLYzdoT1B2OUlKSlptbmJiSXlZRVU2K1MvWjgzKzdiNFpzL3NkVlFS?=
 =?utf-8?B?RDE2QWhkZkcyZmZrUU1zTytYT2NvL2dNU2g0cjFocmJIZ0VadVJVTzM4S1Jq?=
 =?utf-8?B?VE1rTWkwL0VxQzVWakd1OWcrWnMwOFoyZjNtQkNlL05oOHlicEE3eCt0dFZm?=
 =?utf-8?B?OFV0bFhTaHcxLzJUQmpZMVpzMHNIU2JQdWdiR2h4VTRDaFFLMW5WZ200WnVy?=
 =?utf-8?B?aHJRQUpnVmRQTHB5emd2MUFFQkF3c2tIWWM1WThJMm5qMUNma1BuTm1laER6?=
 =?utf-8?B?aWg4K2Zyc0FjVkNHN1UrMzIvay9jNmlMUXhEMlppck42a3F0NVk0eWNvNE5G?=
 =?utf-8?Q?JxL3m6g3OEpYtDIk9ZcVcpIl6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141565c6-d0a6-4928-d099-08dd4f68151c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 15:31:00.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMoieAtwX5vfrUSBZ5uD2oo/pLh4zkTHzXLUgKpn2UCr2Gh/hfoTMJbNCiTD+xgN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673

Am 17.02.25 um 16:10 schrieb Alex Deucher:
> There was a quirk added to add a workaround for a Sapphire
> RX 5600 XT Pulse.  However, the quirk only checks the vendor
> ids and not the subsystem ids.  The quirk really should
> have checked the subsystem vendor and device ids as now
> this quirk gets applied to all RX 5600 and it seems to
> cause problems on some Dell laptops.  Add a subsystem vendor
> id check to limit the quirk to Sapphire boards.

That's not correct. The issue is present on all RX 5600 boards, not just the Sapphire ones.

The problems with the Dell laptops are most likely the general instability of the RX 5600 again which this quirk just make more obvious because of the performance improvement.

Do you have a specific bug report for the Dell laptops?

Regards,
Christian.

>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
> Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
> ---
>  drivers/pci/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 225a6cd2e9ca3..dec917636974e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3766,6 +3766,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>  
>  	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
>  	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
> +	    pdev->subsystem_vendor == 0x1da2 &&




>  	    bar == 0 && cap == 0x700)
>  		return 0x3f00;
>  


