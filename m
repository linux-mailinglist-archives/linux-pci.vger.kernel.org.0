Return-Path: <linux-pci+bounces-43463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10230CD29D8
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 08:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76462300FA64
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 07:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEA61F03DE;
	Sat, 20 Dec 2025 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SqC4CeSx"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14211EB195;
	Sat, 20 Dec 2025 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766215892; cv=fail; b=vAd1TJZ9OCVPmiw5cZ4LazKKqhT5rzRq6yFTBdhZEzwo/FSO3vg75xy+U+KJTs6FvdZy9VUfpH2lVucVyNYIh0to2jsFAyk+C+jWO/H41FafmS1oWVQwkjqXtFANr40T4/sTrWXDaFKGMVwSyGFCfXjbOFbrv7DsgBtqaUul7X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766215892; c=relaxed/simple;
	bh=VV2U7VPoA89bxN6E4o1HE9VKBspeT30oG2fLJ6jYNbY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D+m8DrOsoZaE3QObZQt30+UmQFtwNjnvIR+gtJzqs4FBOLL+hojsR/qcLnNx0NopiKM2keZSiwO8bmi6fHYQK4RYIo6PEZIVn02sbDlVqTP1jfbd3sLdTrl73tEdZ3OZd6fP235/a6QQn0MP1FmE5CK2XzVt1DJRWVNAh7eRqTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SqC4CeSx; arc=fail smtp.client-ip=40.107.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHuq9eI+nq8WwPY13zdh1pYZcg7tXcJFsX8xhh7b8VFyCMHLc8wrjJw/i2b78sW4wgsdzSuIa0TnQGk5DdGv3bXOk3NrWI1E+mXaU20LKlar+0lKczMeQL1jVCBX24lqmBlB2Q+8OTMsO/JxskzWf1FcPBIAUQ2ZV1VPF8Uyz4CPDAmHfkXhJPA7Im2RO4772DcdunUzdPNBhMeUCCK8eSkuCiiAPxVpFkkwGY9UHcNTkIaF7tS7/WF3gnCspAl5NNgHYKBWx4CGlpakDzgRkGynzYfoycESykLrBoL8a9GcFOS9/fyoO4c1E2sodl7sqxNFi3TMm7/ek1pOm6ExxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vV61ZZJ0qHqrak91vbJd8bWlkg3aoZlx0bu5XToJ4s=;
 b=NTFUQoxlYofgOF2jO7tl0dHQl15Z5it8T+b1nNb6a+Xrov7G+VvTrgfb27A1dJxyK+y4VUtoxy3rzwIQ96cgzIva+FxwMa0zuX7ydMsfsJXlApNP0v58mb0cBWDsXeeqUjqY3xRyYPDgC2S+4iQcqVbjwMDlUR6a4X9D/Uc9Y+Dsvm3ikbQzgXveRou4YkP1dmB8W//NWPjSGm4e1xCBXcmSECTmNDuFgvMHqL3ukaa1xUsqsdycrgFuas5AG0195QlTHvA98nlV9tbSuVL0CSZQqtxW1gtslvIBz/X3Mo/VKlHkWhXK779lOe5NPY01Hrh0tj8WvZg4Fiw8QDjLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vV61ZZJ0qHqrak91vbJd8bWlkg3aoZlx0bu5XToJ4s=;
 b=SqC4CeSxqavYlfQTO3cXe8MneAq0oIisRfdNBo+naw07VN07s/Fjl5GTNTnm5AD7rQEXlEdtYL2i42GZjTgNzOisVCGx/lFW+TsbbWjzSDQM0gLQRFjVRTfHAubip5He7haUl4MyNgu9/Uj+6+hTSwgsdlWTnWnplmhlzfkgObA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 07:31:27 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%6]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 07:31:27 +0000
Message-ID: <0c2a91f6-e94c-4898-b259-158be655b630@amd.com>
Date: Sat, 20 Dec 2025 07:31:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] cxl/mem: Introduce cxl_memdev_attach for
 CXL-dependent operation
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, alison.schofield@intel.com,
 terry.bowman@amd.com, alejandro.lucero-palau@amd.com,
 linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20251216005616.3090129-1-dan.j.williams@intel.com>
 <20251216005616.3090129-7-dan.j.williams@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251216005616.3090129-7-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0060.eurprd04.prod.outlook.com
 (2603:10a6:10:234::35) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 0606aa77-c694-4821-4048-08de3f99c8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkJiR29memNLaUNWTStFS1oxNnZkNnphSDVWbWIwZ20xTU9ZWG1QV293Ym9y?=
 =?utf-8?B?ZW9zanMyaXRpRk5kdC9RYXlZWWRWVHYzZ3V6cWx6UW5WUVQ2RzNPNG9JSVpk?=
 =?utf-8?B?RTZXTDZKNGFXMms2RmIydVV2NU5RK0xsc2twcUdXUkN1bklzL0xwR2p4b3JO?=
 =?utf-8?B?ZHNBQ08wY0dMdUxxOUV3L1cxaWMwYjFSelM5aEhvdlNnLzN6alJzb0g3cklC?=
 =?utf-8?B?eVpIUStUNjV1MjVXakZwajQ0bzZGTVJ6MDcrZWRnanp5djE0VUN3MTNoUVVB?=
 =?utf-8?B?V3NPanhkNFoveXJGOEJZbndFNFkxSHN4b3g2MzdtS1FnUklMS3p5bGtPSmFC?=
 =?utf-8?B?Z25tZDMrWXhscW5sSmNXMzRMRDFlSFl1TUtVaW1RbmdCWTJVc2M3a2xoNUZq?=
 =?utf-8?B?SHNNczJ5UmxITWRFNEtRSnhvSzN1alFIVWV2TVQxVzkwdDNXUHc4THRGOG9y?=
 =?utf-8?B?S092SWo3S3ZUbHpqK3NpRE9LLzZuYnM4S3BZa3Vnc0pzNzhITHlHRzJFdUJs?=
 =?utf-8?B?emswT0dGRkZlR0x0SFE3R3U3MnNOZVgyZjlQSWxNWkI5N2FydXlDOTJ2WHFW?=
 =?utf-8?B?RTVSODk1bk96b0FHWnl2Q3ZWZGFFZU42MGVycjNYUklSZ0lUNVRXL0RqTGM4?=
 =?utf-8?B?bnhuSUJwZGtkNS9LbThrZ0pZZUdOcGZwT01qQkdTM3ducUtnTWdHWmZNYm5L?=
 =?utf-8?B?ZmR4dGhFTlQ2TWRxR2o5QmViUG02RUFXWFJOanNoNkxXZy9oSDNVNy82a2RJ?=
 =?utf-8?B?SEw3VXBKVXRyV1dkaTE3U0Z6d21oUlhFWWhpQ1VMNkxnVGEyd0JNMjdkRXdy?=
 =?utf-8?B?WG9xOHRWQ0pFczd3QWxVVXoxSFZKaE05OG9xbm9wYlYzZWV6ZTA5RjdpSFlz?=
 =?utf-8?B?M0IxSUo4eVF0RTZ5T1VzbXkrdG5PZVB2TzlFQ2gxVWFXZGxZaWF0YzBZbUV6?=
 =?utf-8?B?UHoyREw5Y0Fma3R2ZjlhMkZieWR3b2JuRlhWZU91NDBwQnhFWVFMejNaRTd4?=
 =?utf-8?B?eGUyQ1pEWEd4alJVRzVpSEJLSExEY3haQTJac0MwTGdyK25XcTRMRnF5RFl3?=
 =?utf-8?B?MmkrYUdteTIvL0hhMFhvMTFZc2tENkVXZzZFTDNsTHVuQmZhNTZzWEJIaCta?=
 =?utf-8?B?MWRzTHZtaEJLQnc0SVY1SllMYzh4U1l5dUEraWZabWdra3NZejlGTEttWEwv?=
 =?utf-8?B?K3BvMWZTVm1sbEJCYVUwWDhpUllmbkh4VU53ZG5rU1NmdUdMem1qc1Z4dkNl?=
 =?utf-8?B?VXJzVi81d0pBVTB2OUZUZUk3ODVPRWhGQUVOU0l0ZkIrbWNQYk5JTHpKTnRq?=
 =?utf-8?B?UnZvTGhVWVJON1UySWJzZE1tN09ZcXp5UGRLazdQdzFBdCtjY3RqdDl2a2pw?=
 =?utf-8?B?SWJVU0UzdVZtU3NpQnZxdmZ2OEI5WTZMRS9YQTluV09wU0dKbHFwdXlxZm8v?=
 =?utf-8?B?cWtQRnF0ajB5amx0aktjK1NkQ0dFelVKdjhpSkwrbnQxTC91cjROU2ZUVVhJ?=
 =?utf-8?B?MXAxMTFENURWTVhPVUxyOGNUR0pTWUZsVHhkSXR6Y0g3a0tSc0pMbXlMNE5s?=
 =?utf-8?B?YkowYk9GMldSYzE1R3dHZitCU1JNSUZWanFnSVlWRFRIQUNNcFRlRDNCNk1X?=
 =?utf-8?B?ODB1ZXg1ek9YYWxyTEZtb0NnQkxaSVVBV1BnTFRxVzhHbGhkNFUrSkYyK28y?=
 =?utf-8?B?YXR0WWdnYVFHaEozQUo3NkRkaElQT2FPVVlYcmpFRnM3c1ZyL3ZleWNoTmJv?=
 =?utf-8?B?cEM0ZzZtOGtHeVYwaUJUT2lnbC9ZSWFVd3FjWnQwTWZaak81dE5TbGlMSE4x?=
 =?utf-8?B?YjZHeE1BVGtBbU5xTVl5VTUzZkIrcWo1anFSazdZVk1mODJuMm1sQ0hiSTBp?=
 =?utf-8?B?c3hFMlNQdU04TWhqekREMDgzRmk5aGU1UmpMcnJiMnR6WElUTVdTM0kxU0h5?=
 =?utf-8?Q?YU/6bvi8cEgcFTEzCRVewp6rRLAy0aFj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGV0Rko3TVkvUVVGQ2htQ1ZZQ3I0QzgxL0dERkNJaWk5UkpFTU5hcWRDdTNY?=
 =?utf-8?B?T3ZDa2RWc2M1L1lRMkttb3B2MW4rS2JRcmhVYjlWYVMxb0lrVjZNOGFmWlBn?=
 =?utf-8?B?U2JhZkhwTFlwcGhqK1VpRlBJVUFoV3FvelJBT3pjMUhHWWNTM0Erb1dEa1FV?=
 =?utf-8?B?bU9VZTJWUlF5VkhnOGlqbUlrK1hXbGFkaWNKeGVLR1ZxNS9VTEdIMlY3MlJL?=
 =?utf-8?B?VVFmNjI0N2ZtbStGeUhCUW5nVDZvV0JuYlpyaHBrb2dHektwY0ZXd2xYVm9x?=
 =?utf-8?B?cExEMExkdit2RVA3Y3F2WEJwSEk2TVpaNy9nRStINlcxcDU1V2tGcVhYVy9U?=
 =?utf-8?B?RkdvZmg4NFBkblpKaEMvVGp0SDNONDV6Tm1XcTg0NlZCbWtMcVE5UnFrYUtP?=
 =?utf-8?B?ZTVwWk13b3B6NFNWRGdnTnRwWk5nc3loSm5QVUhwbk1UODZVNWVuYWFaWnF0?=
 =?utf-8?B?RkFISG5CZUhuUExxMEZMM2gxZEZMc2swa1lJam9YbHY4cXpHUVE0V3JIYkFo?=
 =?utf-8?B?NUFzb2QrYjlFcG9UYlRlWVVhc1grUVkzWTJYSkR5c0t6UUg5b1gwL0ZNdGli?=
 =?utf-8?B?NFNVZ3FFVnZFeHFKYyszaXRQMVBpS0JUd3J2VU9SYk8vZ0tuQkRHSEo4c1M4?=
 =?utf-8?B?NTh2aU92em1rRzF0SkZWNzY1QXBLUFdOZFQ3VGlzOTZ6UGlpWlA4NXdSR2h3?=
 =?utf-8?B?THg4M0RJaUVQQzhhQ1piUkovNUlsK3VZWnZEeXFzcVgxRGVrODJUWUhVWms4?=
 =?utf-8?B?VUxOT0tidEY2cjRtdTVKeXBjQnpEcitjTUdCdzlDTUdnNGFxaDFlQXZkaXg1?=
 =?utf-8?B?TmlTdTJaTlNjRWh0SDFjamtZTklTTVc1MUVpQ0FQOHFJUHI1TWJjdGxrQ0pR?=
 =?utf-8?B?Z0ZZK1VRdDUrdTViYkx1VlZ4YmFDaTBmTmI3V0xUenU1OURNZDB6RTdxdzRh?=
 =?utf-8?B?VDRxWERLeFVwaDFOTVdtQWRwQTE2Y3pQdnQwTXpPZzdySEN6ZVg5L2hadVQx?=
 =?utf-8?B?YmcyNEZrK2x2Q2x4T3owbXA0VG05U2Y2ZXpYTkI5MjNXT3FvS3dYQ3Y1d3Jj?=
 =?utf-8?B?WEp2dFRVamd6TG5KekhWLzJZVlRCNU05U2NFUi8ySG5EektmWVVoeVB1Vmt0?=
 =?utf-8?B?UGlOT0dWWHZUdGd6MlZoQkJ1cUtEeHpxM3BJTXJabFlwWkdoM1Vmc1NldVNK?=
 =?utf-8?B?UUlFc2RLRWZDVGczaGIybStxdXArWjRXbVQwRlM3aTErc0JtVURQcFFMTDdF?=
 =?utf-8?B?Q3Z3T1FYd0xiTmM2b2h2TVpEMDZrQ1RQUFRGb1RiWU9seTV1TjMrMnpaSjRq?=
 =?utf-8?B?Mis0bzBvSEVXK09QdXl1NEVHekU4YkZETUhTamJ5RXRzK1dVRUVIYlRpNHEv?=
 =?utf-8?B?b2hXa0p3MzVlZzJ1UFdMdEVzVTJUUk5jaHdFOW8rZWtXMkFWK3VTcC9LMDhq?=
 =?utf-8?B?VE1FcC95T2lNWnVhT3dwcnVGU1ZVcDFWa3k2SkY4Y01aRXZ2K2ZweVdGVW14?=
 =?utf-8?B?WGdlTXYyNG5rZjJxZ3lsVEtzQnBURVd0bThlcXRCOVFGa0dBb3FxQTFTUE5S?=
 =?utf-8?B?MzRWbDltUzA3UUt5THppSnBlZk1CQ2phSWdtYkltbmRMZkNTRVhvMGEzd3dW?=
 =?utf-8?B?NDZkb3lNSGlUMVhlRXRIZnQ0YTc1VmwvZHlGeDVpMXFsK0RUY0kxNmE3QXZD?=
 =?utf-8?B?L0w3QkV0OHYxWk8rMStsQ3c5SFp3K2hxUFFraDkxOUsxbFUzQ1FBdjB3cXli?=
 =?utf-8?B?TXNPTUN6RGJkZW5YWW9VOC9wK2IweEc0YzNBSWE0dnB3L2JWczV1WllybjZP?=
 =?utf-8?B?czR5YjRzZXdlK1BwVjhDVSsrVVNFK0FEMzdYSDhZbHQ5QjNuWko0eldrMWIx?=
 =?utf-8?B?R2hLODVVUGxYL3FYQzJMUTBFNnhpRUViS0ZPVzVyU2RkbHZNZW1kMDRYaHhw?=
 =?utf-8?B?a0ZaRlJTQ09kNlNJNDNDbXdCYTNtOFZ0dEFTSGhRa3BYaFIwbGVkbkRWSnRS?=
 =?utf-8?B?RldMeUpXWmZTZ2VHMlpiTUlEdVJZRldLZnBZTExkTERWNnp3VkpscTZ4N0Vl?=
 =?utf-8?B?dWJPV1JoRkg3U3N3TjVtU3hWV1dQbThabmNEbGl6c2VZVUF4S3V6NWRadm5w?=
 =?utf-8?B?RENmMk9GSE11VVJ3VXc1cUoveDFXUzh6SmtIRU42U0pQbm5BOTBzanR0M2Uv?=
 =?utf-8?B?T2EvVnZ0aGtUT2NGZFdWcGE3TVNVNGlXNzhlRTI4UzBkemJpSzRZeGVPd0Z4?=
 =?utf-8?B?VU5zQjFoMWxWS3BCdVljOVQ0UTM2UEk2VisxRVRXamRZV1VBd0JhdXJ3NzJD?=
 =?utf-8?B?R0FFRVlQRGVOeGNkdGsvdjZvTzNYV1Zta1VuZkh3NTFEc2xONHVKZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0606aa77-c694-4821-4048-08de3f99c8ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 07:31:27.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErvOeIdFKp3wrwfD54KiINisb0KTBdmuaB+br2K+eG/O3y8a8dZydkFJtdboHsOL8Gc3MV1e6IV1yzTovY1Wug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452


On 12/16/25 00:56, Dan Williams wrote:
> Unlike the cxl_pci class driver that opportunistically enables memory
> expansion with no other dependent functionality, CXL accelerator drivers
> have distinct PCIe-only and CXL-enhanced operation states. If CXL is
> available some additional coherent memory/cache operations can be enabled,
> otherwise traditional DMA+MMIO over PCIe/CXL.io is a fallback.


This can be misleading. I bet most Type2 drivers will indeed use CXL.io 
and traditional DMA along with some special functionality with CXL.mem 
and CXL.cache.


>
> Allow for a driver to pass a routine to be called in cxl_mem_probe()
> context. This ability is inspired by and mirrors the semantics of
> faux_device_create(). It allows for the caller to run CXL-topology
> attach-dependent logic on behalf of the caller.
>
> The probe callback runs after the port topology is successfully attached
> for the given memdev.


As discussed at LPC, I would like to reflect here this potential 
problem, with port not ready, is mainly due to CXL switches being in the 
path to the device, unlike an accelerator directly connected to a CXL 
Host Bridge which will have all this sorted out at the time of driver 
probing. If there exist other cases, that should be also documented here 
or in the future when discovered.


>
> Additionally the presence of @cxlmd->attach indicates that the accelerator
> driver be detached when CXL operation ends. This conceptually makes a CXL
> link loss event mirror a PCIe link loss event which results in triggering
> the ->remove() callback of affected devices+drivers.


Also as discussed at LPC, I do not think this should happen. The 
accelerator driver should of course get a notification about this but 
not removed. Moreover, should not a link error being reported somehow 
through the RAS infrastructure and the driver reacting accordingly?


FWIW, there is a pending work by Vishal Aslot based on Type2 support for 
this RAS support what I have discussed with him for being a follow-up 
work of Type2.


>   A driver can re-attach
> to recover back to PCIe-only operation. Live recovery, i.e. without a
> ->remove()/->probe() cycle, is left as a future consideration.
>
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com> (✓ DKIM/intel.com)
> Tested-by: Alejandro Lucero <alucerop@amd.com> (✓ DKIM/amd.com)
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/cxlmem.h         | 12 ++++++++++--
>   drivers/cxl/core/memdev.c    | 33 +++++++++++++++++++++++++++++----
>   drivers/cxl/mem.c            | 20 ++++++++++++++++----
>   drivers/cxl/pci.c            |  2 +-
>   tools/testing/cxl/test/mem.c |  2 +-
>   5 files changed, 57 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9db31c7993c4..ef202b34e5ea 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -34,6 +34,10 @@
>   	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
>   	 CXLMDEV_RESET_NEEDED_NOT)
>   
> +struct cxl_memdev_attach {
> +	int (*probe)(struct cxl_memdev *cxlmd);
> +};
> +
>   /**
>    * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
>    * @dev: driver core device object
> @@ -43,6 +47,7 @@
>    * @cxl_nvb: coordinate removal of @cxl_nvd if present
>    * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
>    * @endpoint: connection to the CXL port topology for this memory device
> + * @attach: creator of this memdev depends on CXL link attach to operate
>    * @id: id number of this memdev instance.
>    * @depth: endpoint port depth
>    * @scrub_cycle: current scrub cycle set for this device
> @@ -59,6 +64,7 @@ struct cxl_memdev {
>   	struct cxl_nvdimm_bridge *cxl_nvb;
>   	struct cxl_nvdimm *cxl_nvd;
>   	struct cxl_port *endpoint;
> +	const struct cxl_memdev_attach *attach;
>   	int id;
>   	int depth;
>   	u8 scrub_cycle;
> @@ -95,8 +101,10 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>   	return is_cxl_memdev(port->uport_dev);
>   }
>   
> -struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
> -struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
> +struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
> +					 const struct cxl_memdev_attach *attach);
> +struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
> +				       const struct cxl_memdev_attach *attach);
>   int devm_cxl_sanitize_setup_notifier(struct device *host,
>   				     struct cxl_memdev *cxlmd);
>   struct cxl_memdev_state;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 63da2bd4436e..3ab4cd8f19ed 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -641,14 +641,24 @@ static void detach_memdev(struct work_struct *work)
>   	struct cxl_memdev *cxlmd;
>   
>   	cxlmd = container_of(work, typeof(*cxlmd), detach_work);
> -	device_release_driver(&cxlmd->dev);
> +
> +	/*
> +	 * When the creator of @cxlmd sets ->attach it indicates CXL operation
> +	 * is required. In that case, @cxlmd detach escalates to parent device
> +	 * detach.
> +	 */
> +	if (cxlmd->attach)
> +		device_release_driver(cxlmd->dev.parent);
> +	else
> +		device_release_driver(&cxlmd->dev);
>   	put_device(&cxlmd->dev);
>   }
>   
>   static struct lock_class_key cxl_memdev_key;
>   
>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
> -					   const struct file_operations *fops)
> +					   const struct file_operations *fops,
> +					   const struct cxl_memdev_attach *attach)
>   {
>   	struct cxl_memdev *cxlmd;
>   	struct device *dev;
> @@ -664,6 +674,8 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>   		goto err;
>   	cxlmd->id = rc;
>   	cxlmd->depth = -1;
> +	cxlmd->attach = attach;
> +	cxlmd->endpoint = ERR_PTR(-ENXIO);
>   
>   	dev = &cxlmd->dev;
>   	device_initialize(dev);
> @@ -1081,6 +1093,18 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
>   {
>   	int rc;
>   
> +	/*
> +	 * If @attach is provided fail if the driver is not attached upon
> +	 * return. Note that failure here could be the result of a race to
> +	 * teardown the CXL port topology. I.e. cxl_mem_probe() could have
> +	 * succeeded and then cxl_mem unbound before the lock is acquired.
> +	 */
> +	guard(device)(&cxlmd->dev);
> +	if (cxlmd->attach && !cxlmd->dev.driver) {
> +		cxl_memdev_unregister(cxlmd);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
>   	rc = devm_add_action_or_reset(cxlmd->cxlds->dev, cxl_memdev_unregister,
>   				      cxlmd);
>   	if (rc)
> @@ -1093,13 +1117,14 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
>    * Core helper for devm_cxl_add_memdev() that wants to both create a device and
>    * assert to the caller that upon return cxl_mem::probe() has been invoked.
>    */
> -struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> +struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
> +					 const struct cxl_memdev_attach *attach)
>   {
>   	struct device *dev;
>   	int rc;
>   
>   	struct cxl_memdev *cxlmd __free(put_cxlmd) =
> -		cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
> +		cxl_memdev_alloc(cxlds, &cxl_memdev_fops, attach);
>   	if (IS_ERR(cxlmd))
>   		return cxlmd;
>   
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 677996c65272..333c366b69e7 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -142,6 +142,12 @@ static int cxl_mem_probe(struct device *dev)
>   			return rc;
>   	}
>   
> +	if (cxlmd->attach) {
> +		rc = cxlmd->attach->probe(cxlmd);
> +		if (rc)
> +			return rc;
> +	}
> +
>   	rc = devm_cxl_memdev_edac_register(cxlmd);
>   	if (rc)
>   		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
> @@ -166,17 +172,23 @@ static int cxl_mem_probe(struct device *dev)
>   /**
>    * devm_cxl_add_memdev - Add a CXL memory device
>    * @cxlds: CXL device state to associate with the memdev
> + * @attach: Caller depends on CXL topology attachment
>    *
>    * Upon return the device will have had a chance to attach to the
> - * cxl_mem driver, but may fail if the CXL topology is not ready
> - * (hardware CXL link down, or software platform CXL root not attached)
> + * cxl_mem driver, but may fail to attach if the CXL topology is not ready
> + * (hardware CXL link down, or software platform CXL root not attached).
> + *
> + * When @attach is NULL it indicates the caller wants the memdev to remain
> + * registered even if it does not immediately attach to the CXL hierarchy. When
> + * @attach is provided a cxl_mem_probe() failure leads to failure of this routine.
>    *
>    * The parent of the resulting device and the devm context for allocations is
>    * @cxlds->dev.
>    */
> -struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> +struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
> +				       const struct cxl_memdev_attach *attach)
>   {
> -	return __devm_cxl_add_memdev(cxlds);
> +	return __devm_cxl_add_memdev(cxlds, attach);
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
>   
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1c6fc5334806..549368a9c868 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1006,7 +1006,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
>   
> -	cxlmd = devm_cxl_add_memdev(cxlds);
> +	cxlmd = devm_cxl_add_memdev(cxlds, NULL);
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 8a22b7601627..cb87e8c0e63c 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1767,7 +1767,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   
>   	cxl_mock_add_event_logs(&mdata->mes);
>   
> -	cxlmd = devm_cxl_add_memdev(cxlds);
> +	cxlmd = devm_cxl_add_memdev(cxlds, NULL);
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   

