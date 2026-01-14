Return-Path: <linux-pci+bounces-44838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B9D20FF7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBD593017EC8
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E38533E372;
	Wed, 14 Jan 2026 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2v2N4jhA"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B733E34D;
	Wed, 14 Jan 2026 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418421; cv=fail; b=g8/GZbCypa476cqRjdmzMnSti9ZfF2vlDu0xZGtzULPRQuQHIVUz6KuN3pxqrJL4yp2bugSadNt3Pqw1WzokxUMgnNJYPXb6BfO1/XZCNVqEhP7uNEb+jQdElxyuy4/pm7E2kHjd0QeytJuOf+nGrAqs8i+4BM3LcRAf+nFDncM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418421; c=relaxed/simple;
	bh=56CP7r8hROSFkwZSUdwZdbnoTq7yuXgnT+IpfTD2/MI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BErt9uNZRAbbukIBdwqQ46xGdoe9Tdgq9ZBomz/aU8241dKbjcpTIAdL8aItwc07ExiKz4ZpsJCK+ztDFv67ZGHWuX+XOUv5D+sAPgJin/UAzWNXoxjvjwWuNh469ZxYXGvNopM4rfTTlhoPd2qKxTJnLHxokT7mAOiKZ1uPcNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2v2N4jhA; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hk0TBEM9MxuvWsU2OkpjBqDW8bcGYKyVtfLBwkpnTxfVGZX5KdgEK9kLzhzr1OGYzgo54ccfGNh4HrD7JWPBbf+ICby2VWPtBsGsJYWLPoWejmBgWUocf95eRBvQ71lNz/Nz8ZGiPZ9zZAHIkc68pMdLlWwMxts1jZUPmSUcRgpDgT4iir7ByLNa7XpStrUO57AKRp3RIJLrkEDApr99YIG6dVr1yKyb5tfs5Qmpqi//P73cf+adnpHs4vGAC9FI64uT6/ll643s8Lj08zHYNk68GfvKFPyNAHj+SqY4lFJD5K8oW4LHId8LJu02apBNE/dPgE+CG9s8BzoSqTmuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMRHPeWh8h1pTtWc5E/zFlDYdneNfRizs35D4H/m9GA=;
 b=nSHbQnpuyerf2unZ8MKhE8DfjQ84rSx48ajvFOdlfB90xJnH3/0zw5nyZYlQ+MDBU6qTbRFNbb0UAvODh01AEJEe567jJLvISEyJgaYH2x2DX4/KUNPMycIm6YP3p3bA8E26B2ZOZkl+G8WrUfsoH5efg1L7D+EEZVF0IcM34neiMMCX7xYE8E+IT+Ecqc+Sdljg8elRc7hKhf+eDz7FG4eaGuNdRKaSrjeqB9yyLc6EGLiNeBGu0T3g9JL/pmPCb6oTZaQI/McReTQcvi6FwrPZDX5kouCHlPaBTeCIQTq4/5KfoorH/VMNBDJT3AcgCqagf3KmwTi+G8cCMbRTjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMRHPeWh8h1pTtWc5E/zFlDYdneNfRizs35D4H/m9GA=;
 b=2v2N4jhANURrTOPXD0+M9dDHvrtOW1gEWcsNBkdLaP45z6GCy4/6Z7shssffLDzjhmr02aGFg1RpSaab0jYmj0vKBoTasVyiEo2cCU2CG7Z8WUN4Qn7Vm3B/Vn7dYqM3iGKUTsug8O94BiH5z4vvlTCllWiND3XltHgi08eza/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 19:20:16 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 19:20:16 +0000
Message-ID: <d1f0f269-96f0-4739-97f5-f695137f922a@amd.com>
Date: Wed, 14 Jan 2026 13:20:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 27/34] PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com, linux-cxl@vger.kernel.org,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-28-terry.bowman@amd.com>
 <9e0d3c5a-bc80-4d19-bf7b-fbf55d140b8c@linux.intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <9e0d3c5a-bc80-4d19-bf7b-fbf55d140b8c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:806:d3::18) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: d760593d-b447-4a6d-785c-08de53a1f311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGkwTWpkb05zeGkxbVpwbUw5bi82TVZDaDVyYmxqNmdRZTVMclhpSG4waG9l?=
 =?utf-8?B?cGxyZlBwNEV0eWdLYVZLcGQxNG56RjBSZDhkS1FGWDdoRXhaYi9mdnBnTGI2?=
 =?utf-8?B?Z1pQcHUwYmlydThiVzNia05OTTFnRFBDUVdXTnVZTXF0WFMxZ0VPdWVVd01E?=
 =?utf-8?B?eGYzdUxGMEsxV0pCeHkxdHNlZEZOeEJrZHdIZjRxdllFbEk1aVNkUWdoeUxK?=
 =?utf-8?B?VWZsQ2hmK0x5NDhOWnExaFB5eUQ4eDcrUlYraTJJNWVJVk1yZW9WYkRuL3Ri?=
 =?utf-8?B?dzVobTJBMGJaMkRJVzZ0VlRHanFGQVljbFBOck5mY3BMK0hGSmZZY2EyM202?=
 =?utf-8?B?R1p3MERndzErMDhvWGxjaTVXL2tPRHZQZzFXa1ErMFhTb1ptWnlaN3JINXZa?=
 =?utf-8?B?UFF5RmtTV1Q4NWZFb3RuUTBpeE5MUGJ4Q21rOFJqWjhRLzg2YXJXdkxJeWhO?=
 =?utf-8?B?L3hMVExiaUZ0VVFqUkFzTldiWDBBQ3RmcWZUQStsbWl3N1greGJGcEFxNXJl?=
 =?utf-8?B?SmVncm0yTmtzaUxqSHh2RUtPblczSStZM2dZZ3lCM1pOSHA5cFF3enZCT0xD?=
 =?utf-8?B?dzB2UUhFaUhETFpUQWxvWTBtT1RCODFML3pXNVZMRjBzM2lWamRwVHBuejg5?=
 =?utf-8?B?ZnZyelEraGFHMlJJVzRNNzJqcXo2UmhVaFA3L3dBTlhEei9sbUFndUw4MUZW?=
 =?utf-8?B?Vk5NZ1JhUVhiN2YzdldWNlRkaWRXc1BMeENWQTNiNWdwdlRwVFYrT0c3R2hF?=
 =?utf-8?B?TzdwR3lEaHA2bmgzUXhpYytWT2J5bE9Jdlhpd0pYbnhTKzNmUWNkTmpXUmlo?=
 =?utf-8?B?TElnRVJDOHpmbzNZZzAvM1FuWmx5bkxiYVhuR3FKdzVmS0VHN0VZY2NSTGov?=
 =?utf-8?B?V3pEMlUwbkxscW1GQ2NzRVVsRkh0dzhpT2FXcVV4R1NWWHFtYndwVGtwNW85?=
 =?utf-8?B?SGNEZlVqQmtmR0RoMHkwNjR0QlE1c1h6cVJKc0gwcDcvRHdQMm1NdVRPYkZB?=
 =?utf-8?B?cDVPeEx2QUhvV09tb1crU3FFUW44RFBWWTRuV2NBZ25kU1k0bUVmTHVLblRp?=
 =?utf-8?B?akwvQlpHcitiSzdTNThnSE9HcFNGU3h3NzVMcjdjM3RUY3ZSbmJuM1pMNWZN?=
 =?utf-8?B?MlZxdDI1d0lqT2RzcVRSa2hMdk5Zd3IzeDFWUkNkNmc1UDNtRVBzMFExdmdN?=
 =?utf-8?B?TEFEVXV3VWRabjUrd1NOZlJIRHpNcDlPMDRiVTlOTzFzKzhZOHA5WG1aUE1h?=
 =?utf-8?B?VjQrbkFNNzZUWmNKVXpHa0xubXliai9xcGlHWXd5aXZQTnA2SGtxMnpxOThH?=
 =?utf-8?B?cjFabDRNbVQxRmYvT3MyaVZCSkkxRk1SbzcvSzRhZjdBWlFiK01vWHNzZWhT?=
 =?utf-8?B?YjBSRFp2am5qL2xxNkxldkdxKzJnSTVHOHNUU3hxQmFiQW0vYWhlRUp2Ym84?=
 =?utf-8?B?TXVQODBuS1BtMDYxQm95RG13UHNIYmVRK2YrZEptUUQ4WkJpYWdxUGNLSjlX?=
 =?utf-8?B?VHhQU1NIVEFlU0UvczJoRU9DQzNBL05EUnEyc2g4M0FqOW5EYVdzTS9wOGZU?=
 =?utf-8?B?bXphSmttOU5ZeUc4M0hycjlvbWhzTFRiMUMrek9vRFR3QnZKaGRHK29WMUlY?=
 =?utf-8?B?MWtNYU5qVGZGZC9tRzJhZlAxN3FBOERJSm9yak9IMCtWZStWT2JacjhpVVFy?=
 =?utf-8?B?NFE3bEd3SzlSWU15cVJsZEQrOEdNWVdLcUd1amVnT01sZ25BV0NKckt2VThl?=
 =?utf-8?B?WXg0NWUybXRxeHBIVmFMdXZJMzhGTnJmU1pSOEY5aTF3bUp2Vi9zc2xYR2V3?=
 =?utf-8?B?RSs1Qy9iS05pNW5Vdm5idEY1VHo2VzhTNTRyK05VL3JUeFNUT1pQTHBxVGw0?=
 =?utf-8?B?SUpyZ05LeDBOSDlQa2dFYlRZMkVjaHc0bmN3MWY2YWVnMWM4enFFTmhTVXli?=
 =?utf-8?B?bHBiU2RHNFRVZ3R4OTg5WEprajJJby9TTFFla0dFSzFGdFVoRE13c2hnbkpX?=
 =?utf-8?B?NFg1ZDI1RDJVTndsSmozRG9wSkV4NnNrVmV4czVPS2Z6L1lXbkZtcGJ5Y21T?=
 =?utf-8?B?RVB6MEpvS2VhQytSZi9OUng5WTFXYkdUcThtbU1tcEJKTG1qYjVsRWQ2cE1x?=
 =?utf-8?B?ZERyUkt5RTI0Mzcyc2MybS9ZdG9CblhRaEpSbms4STdxdndCeXd1ZGNYZ3hO?=
 =?utf-8?B?Umc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFJDMVFqTkFKckFMVWNZSk4yWWRuVm14WlF4SUdsQ0d4ejNQYWc5dml0VkhO?=
 =?utf-8?B?MmxkK1dyY2ppcERIRjBpYTIySXI2VEhvcmJESWZmd2IrSERwcU5jMVhrdzc2?=
 =?utf-8?B?ZTdVc0JKbXFhdnVTdkRJa3ppbitKdzNWOHZnYWNnQkU2MWVwY0xyZHFIcDE2?=
 =?utf-8?B?Z2xVMG9UYlRRN0lVdUtJZU8wTjhTay9YZGFhRGtqUUtoS1hnY0E1V21Bb3cz?=
 =?utf-8?B?Z2RMWU9qbUZrTnJySWFhWXVQMDRXVXNoUnU0anUzcU5pQndUaUdESjNQNzNB?=
 =?utf-8?B?cFhmL1pPamdIYmdpdng1QW9KVWgycS9nc2RBNS9mRWlkWkJxUDhzcE41TzB3?=
 =?utf-8?B?OURDSUVQOWc5VFVWR2MrRC9KSEo2akdEOHZFdFR3YmlFMjZSSGVpRG5aZXpa?=
 =?utf-8?B?S0JYNFJKeUkzdTVveXBOZ210cUVnSW9ibFJ1RG54dGRtYXQ4RFNDUGZsZlg0?=
 =?utf-8?B?T0dHaTByTFFrZ3M2UDRtMlFzZlpiZXE1R2pxb3lTd2ZuTW1qQ3BkcTRHbnJC?=
 =?utf-8?B?bDBWMU81c2ZIUjB2OWtHaERNekxVMWtvcnRxTFNFYmU4b25yZC91ZFVQRERV?=
 =?utf-8?B?NnBackk2eFZaMjJ1V2w4UnhLbkVyRjJjUXBqNWROOWdyK2djdFRiZExjeW1F?=
 =?utf-8?B?SjJURFlkeEtXRllnTWVrZGExaVloaktBd3VwajUvTG5CZjFjQTUzNncwT2xH?=
 =?utf-8?B?VFY3dFlDbUZiRHRheVB1cmpVTjhEWWVEeGp3ejR4VFYwVUFkVXZmaGJjUk03?=
 =?utf-8?B?MGZNaGtteGhCNTZVOGVHZWt3d2dsdkVjcllCekM3ZkozdXgyb3RXQllMRE95?=
 =?utf-8?B?bk9IeGZsVUtMUmo3ck1ieWkyc3h6Q2ZRWlp2ZG52U200T3JyajF4QlhnK2JG?=
 =?utf-8?B?blRsdGJER3Jpajdzb3R1dHk4Qmk4RmF5dzZGRWJJbXZzQmF3ODRRWTRDeS9n?=
 =?utf-8?B?TU9Ec1pMUy9vSTAreEJ4WjNYRTNLei9JZ1BFWlFPRE84RTNjTDJiN1V1LzBw?=
 =?utf-8?B?cndWN3YwMGJuaTRPYk9GRkhpQ3BkTU5COUlXWFdsYUhNVE5GMnhDd1lyb2s1?=
 =?utf-8?B?VDg1eVBhdWRmSG5va0VCRVVwREpleVlUMy9USzlyZ2VxaURDUFdpVTVWQkFr?=
 =?utf-8?B?OUJqOStRQjFkeG80S0Z0dzhwdWpmVTJqZnNoVjhNMXlXK1hBeFlQVlUwL25k?=
 =?utf-8?B?a3RDVlUveWxwb3MraDVieEttS04zNVFlU1JBUXFldm52RmFMZUlBMDErL3lx?=
 =?utf-8?B?c0lIUy9WWjA5NndPYS9ScDFMamthcFBvVU53NXJITHBSRHUzbXd1NDQvcUhj?=
 =?utf-8?B?czhlRXJiT0sxVFZyL0dHaHd0STNHK1RkTlFGVVBaRnhsQjVvQ0prNTYydk9O?=
 =?utf-8?B?aU9OeHNXWXlmT0ZqUThtWHdFeTlKMFA1Q2V2V2hzOVJnRzdTR2dDekIzQUJB?=
 =?utf-8?B?bmdoTkNBeXZQL0RlZ0JxMnVKb0tWMEpVMzZ6QjYzcUdTSWVHb2FjVjExSnMw?=
 =?utf-8?B?YVhqblRDM3VDS01XQzhzK2tRRnBNWVJnZFQyblppeHkwcjFYc1VUakdVaWJF?=
 =?utf-8?B?ZEM0dG5nTnQ4SHJST3dIdFZQMXFKVEhOcGFKS2NUMzJScS9pZDZncUtlTElG?=
 =?utf-8?B?U2t4QnN4YUd6Q25sVDBpemt3U3NJM1RXWnFGV3IyZzZPclh3OHlyYW1YR0ZV?=
 =?utf-8?B?NXZLQlFQdGdmZit0TFdHd0VsYm83TUFtaStlYlJFUEZ5dXJreHVEb09sMUJK?=
 =?utf-8?B?VnhFUGhuR1lRQ2xtNUQyMEtoU0dHM2d3Q3ViWTN4cVp2bzZtRGpybC9peVBI?=
 =?utf-8?B?QUFtUHg0blJBL3pwTFcwckhqaWI3ZTFlVzBkTXRmQ2dseE8zUzhoQUJPL0wy?=
 =?utf-8?B?SjRJZ3JodnlvRDZOMlRIY0k5aFhNZm11Ynp1N2xZU1c1NEIxVVVneGRyS01a?=
 =?utf-8?B?ekoySWxPL1lWSEtrNFR2VGNtY0ZLalhUN0l1SHMzWFIwNllXRE9wWFhkb1Nz?=
 =?utf-8?B?UHgrbi9YbXQ5TUVrSDFyRGlVeG9ZUEVOMFJsZGg3SksrcEhXdGl1eHR3RE40?=
 =?utf-8?B?b2tBTHA4ZVBTMW1haUp2MzRrc09FeXkvRy9HakdtVDNMV1grb2tNTDdZWngz?=
 =?utf-8?B?SGZvQTRxZ0xSV2Y2Tk9rT013anVaWkpxUU1TYWdJaUh3SkczYWppWjVIMkpl?=
 =?utf-8?B?NWRjeHJVOVo0cGplMkNObUE2K0h1c2NhTlA2T1pTOHhQVDYyOFBJenU3VGd2?=
 =?utf-8?B?ZDd1TFB2d3dEaTRBb3h3cWd3RTloNEt0ZHEyNG5RbDNjS0hKbVNGRzNVbjd5?=
 =?utf-8?B?VU9ZRTliMk5TY1dsc09LRXFnQkZhMkNlT3JvMk1kRDlqNkZyTTBmZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d760593d-b447-4a6d-785c-08de53a1f311
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 19:20:16.7496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKiGCgo7Aq5k2b4Uz7KbEJwUbz2rhxEfwFVrBtPwQlD8D05ApQ3rUdWH7vyii5sjbicXodwBHLkXJaV6u5hmzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501

On 1/14/2026 12:58 PM, Kuppuswamy Sathyanarayanan wrote:
> Hi,
> 
> On 1/14/2026 10:20 AM, Terry Bowman wrote:
>> The CXL driver's error handling for uncorrectable errors (UCE) will be
>> updated in the future. A required change is for the error handlers to
>> to force a system panic when a UCE is detected.
>>
>> Introduce PCI_ERS_RESULT_PANIC as a 'enum pci_ers_result' type. This will
>> be used by CXL UCE fatal and non-fatal recovery in future patches. Update
>> PCIe recovery documentation with details of PCI_ERS_RESULT_PANIC.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
>> ---
>>
>> Changes in v13 -> v14:
>> - Add review-by for Dan
>> - Update Title prefix (Bjorn)
>> - Removed merge_result. Only logging error for device reporting the
>>   error (Dan)
>>
>> Changes in  v12->v13:
>> - Add Dave Jiang's, Jonathan's, Ben's review-by
>> - Typo fix (Ben)
>>
>> Changes v11 -> v12:
>> - Documentation requested (Lukas)
>> ---
>>  Documentation/PCI/pci-error-recovery.rst | 2 ++
>>  include/linux/pci.h                      | 3 +++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
>> index 43bc4e3665b4..82ee2c8c0450 100644
>> --- a/Documentation/PCI/pci-error-recovery.rst
>> +++ b/Documentation/PCI/pci-error-recovery.rst
>> @@ -102,6 +102,8 @@ Possible return values are::
>>  		PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
>>  		PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
>>  		PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
>> +		PCI_ERS_RESULT_NO_AER_DRIVER, /* No AER capabilities registered for the driver */
>> +		PCI_ERS_RESULT_PANIC,       /* System is unstable, panic. Is CXL specific */
>>  	};
> 
> I think you also need to update the "Detailed Steps" section of this
> document to include details on when these new values should be returned
> and how they affect the recovery flow.
> 

I had details about PCI_ERS_RESULT_PANIC you mention in v13. Bjorne asked me to remove.

-Terry

>>  
>>  A driver does not have to implement all of these callbacks; however,
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index f8e8b3df794d..ee05d5925b13 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -921,6 +921,9 @@ enum pci_ers_result {
>>  
>>  	/* No AER capabilities registered for the driver */
>>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
>> +
>> +	/* System is unstable, panic. Is CXL specific */
>> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>>  };
>>  
>>  /* PCI bus error event callbacks */
> 


