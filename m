Return-Path: <linux-pci+bounces-21528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A726CA367A8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 22:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F08116C3A9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 21:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA3E1B6CE3;
	Fri, 14 Feb 2025 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nOJlmxGV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B3117E;
	Fri, 14 Feb 2025 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569431; cv=fail; b=d3jB5EwSHMoNhAooMzozaUfTgELPzHhQIelAOW4p6RkZbZw46oNio8p7fB7/01/EkCSprAl8/8GG6vemnU5VujaLJrM/asniYut+EUYMOE+F8zIB82rKD07GLSyaLXq98GP3K+5S6zkk/IJhd7BRqCvC9K5iqYnVvSuBwQqHM6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569431; c=relaxed/simple;
	bh=kNRu9g+CG8+rY6NirqdQOg8QbyxXfnGIvzUppuXfkqY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xr/PBcasJsxaEosNSYQLp3kb0NQUTHUhy0vsnWww+NDVGNfUmbMBk6mlWZWu4yKNGufSqz0vtkKjioF1yki3dIw77xRcLR3PlskW5gr4AQZGOq1rNrrtgLoeOb91ejgRFXKxE/hsEpdLMxGQdT48BTO0G+i6o5TudIleaozGS1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nOJlmxGV; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1nbIiGXj4bGLYrQTXKummnJzy/BHLEWg15ScjnrnM4JPY7oBDkOQkjqrTkKQA7/qF/sxAEh1gzCz6YLIRmhjfSeyMxFJ2A+srx6GTnl/zHopQ7TSia89CUpVyfd8tCT6WiZhIgkHk8+q6kcYlCAy0x562lqZRwmH7HFQkQ0gt1W9NzgJ6z2T4NHWBkLoer0LOrUyydZd9jW3wCAiisbGpmn0y7k7Z2rBh4R9z3zJfpq1EDzuh0ocCKLtr1dvEhVO8HKrF9cHH1N+SugkoNiTMcRy6XGH1HszS9MEIfDrTSqwijKQzKc5rk/QkmEAW0P5npmX7ImqPWHeMKCYcxCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CfabDPFO+342ak4qGgyS6P3dTO9z5NsRLHjEEVtceE=;
 b=whQjWSNI/34ydvCIioPx8k2l8mqHp6vqkhRbT7HGA7AKXHaZNtz7fqYge4MEEKWAWkFKsv2qXIZYMRbcqrPlPndv2JY6hu/R2cwHmTkVLmWdSDds05bHKJRhbKoEmm2uoqeMQyOua8yUb+Tqc8/3hSsqQeBwEXz0MVy4vtyBfGsJubNTIHJupuxs/q8qGQYTlToVrlZVN3Ev2nWXw14hxRq/Q0093ULxyIcOL3qgocYSGpiGu0zSzdn2C1GyCHS+SyjoQEll9ZHcd8L42VQFoyT9dI3AsWlZBfDFgkSnSugArQ3anphaOkwtboRJu0uPw5zghIi6JRuWxiZ5tS/73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CfabDPFO+342ak4qGgyS6P3dTO9z5NsRLHjEEVtceE=;
 b=nOJlmxGVHPpLBRCzzg6ZJTbbWQ/IQJ/B342DGXPgIQVvI0O2abNE7Z38TyMGjNHgFc51+vsLsUfCc/3ivUrmdgrzXjusK74+x1Il7dFdSk2bJtSiddv5pm/TefttjBqDYzbGss/gfvlw9t8pf/hW7AX9daH5AHP3swMzmU3xXM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 21:43:46 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Fri, 14 Feb 2025
 21:43:46 +0000
Message-ID: <408f6acb-108b-4225-81ac-4f17a6486020@amd.com>
Date: Fri, 14 Feb 2025 15:43:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/17] cxl/pci: Add error handler for CXL PCIe Port RAS
 errors
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-13-terry.bowman@amd.com>
 <67aea8002a005_2d1e29466@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67aea8002a005_2d1e29466@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:806:122::9) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc0fc5c-f003-452c-e339-08dd4d40a8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3lTSStieUtJdWhHYjFMRHljZS9KSlJjQXp5WUZQM2RRV2ZHaGlVSUdhaFlD?=
 =?utf-8?B?SEIrWmJxNXdGUnFzQ3d1TmdIYnJBMFhPQlJNNDZ3RW9jRkxpeTY3QjhxTW5C?=
 =?utf-8?B?TytzcjJDTnlmLzJuSTQ1WlhVc1pKZlovbllqWjdGNW9UR1hnTnZIQUZkVkFB?=
 =?utf-8?B?M3pBN0xTZlJ6ak5vTU9WUW1FLzB0dEJTMWN2V1JYSnFrTHY0NC9qaGd4bUVr?=
 =?utf-8?B?cG1hZUI5Sml0TlFZN1B2ZWl4NXM0QVNCYTIzUWhkRjlvN2duNFFhSWRqU2xI?=
 =?utf-8?B?bkFWcU1DcWtPcStGa24xb0FtTmZUNDdNR3pBcG5scG1BNGhUVnFUOTA2UW5y?=
 =?utf-8?B?UlBMZ1VVVUVpT3daZHJibUg3d1I3TDBsa1dscWhBcFkvR0FueWRPazJkSiti?=
 =?utf-8?B?aFNZUERNR3BWZ2NSWWdySWhEei9BWHVKRThZK1BiSk1Qc09OVUhRYWcwaFZW?=
 =?utf-8?B?cmRwd3JSZWlUTURsYUFweU8vZk14ZHpVaTFiaVcyYzZ3bmF3bkZzemxYUkcz?=
 =?utf-8?B?MDNrU05ZTnEyLzdxOG5KSkFzVzlqeUVzakRQMWJUV0RoNUZHTUNkSUx1dnYv?=
 =?utf-8?B?dVBUb21pbE5aSGhyVUIrVEVZOU9pNFZhcUREdnJQTjlCbm1pK214RUZtVWZz?=
 =?utf-8?B?QmVuTDZiUktSU2ZJRkoxN3U5RWQ2OGZPMDFMcnY2Uk43SndOeWZzSERHS09Z?=
 =?utf-8?B?bXlVdFI1ODk2RVBpSFRLbE45OWE5c0cxMGJHSHViV3JMclRzMWd1N3loWmxo?=
 =?utf-8?B?VnJ4QkpCKzM2MkIxbXNQN21YbHdwbDFNdW52NkhEQzNiejNjYjdnV2JVMndJ?=
 =?utf-8?B?YzBmTW5wcnBlMjd4Rm0rY3Fyc2VGd2pRdmxLZGkvY005M0o4VFgrU2pQVmFw?=
 =?utf-8?B?SFRPSTA2MzBucEpwWjlLZjhwclE2RzlDdW10SEY1aU5OeFBIeXJVQ1dJVUE5?=
 =?utf-8?B?MEpjYk5Ocm1JY3hPMjFCMHVJZGxhT0RpWDhSOE1jZkd3WUNXYnFocmtpbWsy?=
 =?utf-8?B?VkNjZmtjQ3JUQXBVMWRqWVl1TFA5WlIyY2I1akpES2lIN1VlTndSZFJlK3Uw?=
 =?utf-8?B?RUsrMzNicUllV1lPb1pDcEg1MVMrWkxtaDdrM2ZtQi8rZ0ZtWnhpcUgyZ1pW?=
 =?utf-8?B?SGo1ZTZwSmpzYldjYlRPMDF2M1AwVlhDVWxLTkRWZ1FNZjFYOHE0ZGRPb1Bk?=
 =?utf-8?B?aFRoWmN4TVlHUnFNRmsvQTNSU3didzhvWGYvT3BCWks2Y1E4MG5ManRXckhn?=
 =?utf-8?B?WWMvL1JYV3AxRVpKRUFBSTdZTVFOdkVaZEd4MmU1Y0JKKy9YVGhqcGJaU2Jr?=
 =?utf-8?B?NFFINEo1Y3RQUlFaTktjMWh3WFlYcCtzcUJxM2IzSG5Fd0hGMElyaFVtM2RO?=
 =?utf-8?B?bStPRkYzeFVCV0ZhblUrejI4MWtQdmJnaGwyb3FYRy93RzdLdlVuclA5Y2VC?=
 =?utf-8?B?LzNLaUNxWmxXWUZ5VXR5bWw4UVJJMHcxTXdoVGFpaHpUaTIwSER5Z0MvWXdX?=
 =?utf-8?B?Q1JFdTl4OWcyZmt0WkFIZ1ZTd3p5c3dDaVdRVDNyYjEwL012S2dvd3AyU3hW?=
 =?utf-8?B?VWRKcWdKald1Ulh5eGh4bis5RUVBRk5Hb05TLzNVUU5kSWdVTDQwZEVwc0Nn?=
 =?utf-8?B?ZmxYVkIxSnY0Tk13TjZpM1UrV01scTBEdXg0WHhWQTZTeTNEQmhhRFNXZ2Nj?=
 =?utf-8?B?MmRXWHNPU0llSDBuU2FnYXhFbDl2ZXVMaWI1b1Q1T201bDRUcFBvY1Z5SHJp?=
 =?utf-8?B?ZjVGYWFUdUJzSGd5V09OdHhSN3dGU0xQelJ1YytNcHFzWjE4THZNbEdIQi9s?=
 =?utf-8?B?YjlUTjFUd1Uxc1crajcvb1pkVk5oR1RwMmlFYlJOLzlrbE9ndVo5dStOa1ly?=
 =?utf-8?B?clcyb1MzZjhiUGZFTHpia1RUamtVWmk1TDBRQXdsSHdTckJYUmpBcktMZTN1?=
 =?utf-8?Q?eZhnORccjBE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTMyUERwRUZwR0MrRDIrbXBQSlB2SUY2ckRITHVqSEdkZHdsQnd0SXEzczhV?=
 =?utf-8?B?QXpJcjg0RFJTdDYvQklqbmNsQkpocGdQcHNHeDE2MGdBQ0ZsUVV3TjNwdWZG?=
 =?utf-8?B?ZnhQMnBKeFV3T3h0QXhMTUV0aWQ1WFVHeFNHQUhRR1VHSXNmSWdLQVBIQVNP?=
 =?utf-8?B?VHVlQnJUYUlXczFPYmovWXFqYWc5TkliTlcxTmFUQm5TNlgvRTF2MjFoKzFU?=
 =?utf-8?B?VUtvcG9tREkrdEdSNlUrRGk0dncvRnpibmpOOU43U3A5Y3c2TGIxUWUrenJ3?=
 =?utf-8?B?K3J0QlNodWpqVXR2UEdnRVppYkxzdmp1RDRvMlQ1Q3ZyK2EwYUNoREJISlZN?=
 =?utf-8?B?NS9HZS9vUUdpeS9UWk8vTUtQUjdGRHBybitaakZMSWRhTmlhMXdGWkkzOXh1?=
 =?utf-8?B?MUMxQk9mOFMvL0E3anhKWDZ6cjR2ZVlDNVg1VFdEOWRISWV1TTZvNlZSd2ZI?=
 =?utf-8?B?aDJqd2pjSS9VUnlxV3pGb0VXdmNkaFFHZzBnaGovdzdLTTJpdDlVL014bGdD?=
 =?utf-8?B?amsrVDY1THNheC9kQytvVDRGaVNNaWxjVWdkVEZGNjVXU1VxR2VOUzNCSUU4?=
 =?utf-8?B?SkxCUG1sb0VNTjUwWXZ0dm5GVnFTeFFDSm81c1FXRWpkdnJiSFBER0g0WDNZ?=
 =?utf-8?B?THg3eGV5WXpRQ0xhSW1YTEI0dmlQZk9LaHFCdmlCY3NKWXk1U0k4Z1VTZHpE?=
 =?utf-8?B?SzBHVWFTMFZmQ2k2d01EelgrMm5MU2xzKzZWUHZYWjMvc3E2eDYyWFZ1blBL?=
 =?utf-8?B?RkV4bHNGem9ucllNbnhjK2pBZVh2ekNCOHlMYjhVL0tVckVBOEhrOVJIUEx4?=
 =?utf-8?B?TXkyU1RYd0dQNXVKNDYvdk9heWRBU2tMYUNraTV5Umo1WjZhMlkrSGxLRmNx?=
 =?utf-8?B?cWlhV0dwRVYzbUV3dGYyZ21QaVlRNFBDdzFiUjlpa1l2Q0RyRVN5TkpLaVBT?=
 =?utf-8?B?RVdzcmFwVkMwa3U2UnhiUXY1aDhpQTVZY0JOdmxXMmhVSVNHdFZwVnh5cllY?=
 =?utf-8?B?d2s2NXE3djFoVjV4WFdqc2QyVGgxb2V3ZDJYUzQ5Unk5WlNpVm1ET1AzY0Zr?=
 =?utf-8?B?dU82ampGUFJtYjFHQ0thRlNEalhMckc3NmxsV0JoN0tMZW5CdXFqMzJua0Uw?=
 =?utf-8?B?YUdyYW5iaC9PQlJkLy9YdkJiRzdnVjNIanVTaThyYUhxR1pqRXNncWZuRWoz?=
 =?utf-8?B?Zi9IVFRIUG5sODRabjc4c2hDdFVVZkF2Y0JvRnBxOG1Xdy95aTFpUU04U1NJ?=
 =?utf-8?B?M0FESVd3R0tBbm9MUjkzQ3ZNOUVBL1RqQnprY2JMS2F6eFRjMzl2WU1leFZ2?=
 =?utf-8?B?aWpQZ21VTjdBZldWTnBpWG94b3lTVCs2aHRiQkc2K3FDRFJqUWorWU92N01J?=
 =?utf-8?B?eHBGQkpGTU00TTk5T3NqY2xsckNZeG0yR3VnaVptdTNlSlNnVHZtVXIwM05O?=
 =?utf-8?B?eXF2WW90ZDZUc2pZTEt5NFlBM2szMSt0TGlDZ01SY0wrVDVsTGVlZEQycWcr?=
 =?utf-8?B?bDBKSmNYUm1OSzgrdFdvU3dKdGRBUFRhekd3czB5Wi9MRE5sWXMrSzVvK0VD?=
 =?utf-8?B?WjIxZGJJaFptdW01cngvZDMwYnNZUW50dXBSL0IrZkxaMjI2TzRKSFd5YWZ6?=
 =?utf-8?B?b050YmkyWExleEFDSmxtbjlXZGNXUUJjcWlzVW1rbDhHaXhBQlBVMURzOEZP?=
 =?utf-8?B?UHJlUjJBZWlzK29DcUcxRUUrM3FKSHlCYllDSE9zbUVlWTFQZGlMZzVVWWtn?=
 =?utf-8?B?S2VjNFozQ2o3bGdKWFg2cEh2dnRxQnF3dGpnL0ZoakdDUG42RDBjMXpDaXBR?=
 =?utf-8?B?VUtFN2d6MFRIOW9sWm9sVyt0NzNsd2F5OEV6aWJQVmJyWTZmOTRIcjBpRVhm?=
 =?utf-8?B?ZGY5ZDJtOW9yWEJuTW0weDljNXFnd0hVaytpUHNEdHJBRUorVkZQNlhzMGFt?=
 =?utf-8?B?QmlpazllSDhjMjZLZkdlQnYzaVJaU29tdFlza1ZWZzVJbFowVzNmdjg2bCtB?=
 =?utf-8?B?N3BJdlNIbW51dmI3Z2s1MVFnbXY0V3lyOGxmc2FLMnhaMDFBSXJ6MmQvdTF0?=
 =?utf-8?B?aHJxMzBKZW5ieCtMdGliTWM3cHFJb2FFcDhlRnlBSjNCUnhpNDMvWjRzT2ZN?=
 =?utf-8?Q?T1Yspk8mrGTA9rwRrloJLODLM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc0fc5c-f003-452c-e339-08dd4d40a8bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 21:43:46.2327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoNvEx964Ttqxl8GrwLViQoY1l8vFsmvZEaVZfVZXSNxp8nHbqJ7gVbSpEcxEBcH+XEB2ZHOx55B3rq0i1ySeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781



On 2/13/2025 8:18 PM, Dan Williams wrote:
> Terry Bowman wrote:
>> Introduce correctable and uncorrectable (UCE) CXL PCIe Port Protocol Error
>> handlers.
>>
>> The handlers will be called with a 'struct pci_dev' parameter
>> indicating the CXL Port device requiring handling. The CXL PCIe Port
>> device's underlying 'struct device' will match the port device in the
>> CXL topology.
>>
>> Use the PCIe Port's device object to find the matching CXL Upstream Switch
>> Port, CXL Downstream Switch Port, or CXL Root Port in the CXL topology. The
>> matching CXL Port device should contain a cached reference to the RAS
>> register block. The cached RAS block will be used in handling the error.
>>
>> Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() using
>> a reference to the RAS registers as a parameter. These functions will use
>> the RAS register reference to indicate an error and clear the device's RAS
>> status.
>>
>> Update __cxl_handle_ras() to return PCI_ERS_RESULT_PANIC in the case
>> an error is present in the RAS status. Otherwise, return
>> PCI_ERS_RESULT_NONE.
> So I have been having this nagging feeling while reviewing this set that
> perhaps the CXL error handlers should not be 'struct pci_error_handlers'
> relative to a 'struct pci_driver', but instead 'struct
> cxl_error_handlers' that are added to 'struct cxl_driver', in particular
> 'cxl_port_driver'.
>
> See below for what I *think* are insurmountable problems when a PCI
> error handler is tasked with looking up @ras_base in a race free manner.
> Note I say "think" because I could be misreading or missing some other
> circumstance that makes this ok, so do please challenge if you think I
> missed something because what follows below is another major direction
> change.
>   
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/pci.c | 81 +++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 77 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index af809e7cbe3b..3f13d9dfb610 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -699,7 +699,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>>   * Log the state of the RAS status registers and prepare them to log the
>>   * next error status. Return 1 if reset needed.
>>   */
>> -static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>> +static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>>  {
>>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>>  	void __iomem *addr;
>> @@ -708,13 +708,13 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>>  
>>  	if (!ras_base) {
>>  		dev_warn_once(dev, "CXL RAS register block is not mapped");
>> -		return false;
>> +		return PCI_ERS_RESULT_NONE;
>>  	}
>>  
>>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>>  	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
>> -		return false;
>> +		return PCI_ERS_RESULT_NONE;
>>  
>>  	/* If multiple errors, log header points to first error from ctrl reg */
>>  	if (hweight32(status) > 1) {
>> @@ -733,7 +733,7 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>>  
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>> -	return true;
>> +	return PCI_ERS_RESULT_PANIC;
>>  }
>>  
>>  static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>> @@ -782,6 +782,79 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>  }
>>  
>> +static int match_uport(struct device *dev, const void *data)
>> +{
>> +	const struct device *uport_dev = data;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_cxl_port(dev))
>> +		return 0;
>> +
>> +	port = to_cxl_port(dev);
>> +
>> +	return port->uport_dev == uport_dev;
>> +}
>> +
>> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev, struct device **dev)
>> +{
>> +	void __iomem *ras_base;
>> +
>> +	if (!pdev || !*dev) {
>> +		pr_err("Failed, parameter is NULL");
>> +		return NULL;
>> +	}
>> +
>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>> +		struct cxl_port *port __free(put_cxl_port);
>> +		struct cxl_dport *dport = NULL;
>> +
>> +		port = find_cxl_port(&pdev->dev, &dport);
> side comment: please always declare and assign scope-based-cleanup
> variables on the same line, i.e.:
>
>         struct cxl_port *port __free(put_cxl_port) =
>                 find_cxl_port(&pdev->dev, &dport);
>
> Yes, that means violating the coding-style rule of preferring variable
> declarations at the top of blocks. This is for 2 reasons:
>
> * The variable is uninitialized. If future refactoring injects an early
>   exit then unitialized garbage gets passed to put_cxl_port().
>
> * The cosmetic order of the declaration is not the unwind order. If
>   future refactoring introduces other scope-based-cleanup variables it
>   requires additional cleanup to move the declaration to satisfy unwind
>   dependencies.
Got it. Thanks for pointing out.

>> +		if (!port) {
>> +			pci_err(pdev, "Failed to find root/dport in CXL topology\n");
>> +			return NULL;
>> +		}
>> +
>> +		ras_base = dport ? dport->regs.ras : NULL;
>> +		*dev = &port->dev;
> Ok, so here is where the trouble I was alluding to earlier begins. At
> this point we leave this scope which means @port will have its reference
> dropped and may be freed by the time the caller tries to use it.
>
> Additionally, @ras_base is only valid while @port->dev.driver is set. In
> this set, cxl_do_recovery() is only holding the device lock of @pdev
> which means nothing synchronizes against @ras_base pointing to garbage
> because a cxl_port was unbound / unplugged / disabled while error
> recovery was running.
>
> Both of those problems go away if upon entry to ->error_detected() it
> can already be assumed that the context holds both a 'struct cxl_port'
> object reference, and the device_lock() for that object.

I think the question is will there be much gained by taking the lock
earlier? The difference between the current implementation and the
proposed would be when the reference (or lock) is taken: cxl_report_error()
or cxl_port_error_detected()/cxl_port_cor_error_detected(). It's only a
few function calls difference but the biggest difference is in the CXL
topology search without reference or lock protection (you point at here).

> As for how to fix it, one idea is to have the AER core post CXL events
> to their own fifo for the CXL core to handle. Something like have
> aer_isr_one_error(), upon detection of an internal error on a CXL port
> device, post the 'struct aer_err_source' to a new kfifo and wake up a
> CXL core thread to run cxl_do_recovery() against the CXL port device
> topology instead of the PCI device topology.
>
> Essentially, the main point of cxl_do_recovery() is the acknowledgement
> that the PCI core does not have the context to judge the severity of
> CXL events, or fully annotate events with all the potential kernel
> objects impacted by an event. It is also the case that we need a common
> landing spot for PCI AER notified CXL error events and ACPI GHES
> notified CXL CPER records. So both PCI AER, and CPER notified errors
> need to end up in the same cxl_do_recovery() path that walks the CXL
> port topology.
Understood, it would fold in the GHES CPER too.
> The CXL Type-2 series is showing uptake on accelerators registering
> 'struct cxl_memdev' objects to report their CXL.mem capabilities. I
> imagine that effort would eventually end up with a scheme that
> accelerators can register a cxl_error_handler instance with that memdev
> to get involved in potentially recovering CXL.mem errors. For example,
> it may be the case that CXL error isolation finally has a viable use
> case when the accelerator knows it is the only device impacted by an
> isolation event and can safely reset that entire host-bridge to recover.
> That is difficult to achieve in the PCI error handler context.
Which directory do you see the CXL error handling and support landing
in: pci/pcie/ or cxl/core/ or elsewhere ?

Should we consider submitting this patchset first and then adding the CXL
kfifo changes you mention? It sounds like we need this for FW-first and
could be reused to solve the OS-first issue (time without a lock).

Or, if you like I can start to add the CXL kfifo changes now.

Terry


