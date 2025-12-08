Return-Path: <linux-pci+bounces-42762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 269E2CAD844
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 16:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8E0E3018F47
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 14:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97161328B4C;
	Mon,  8 Dec 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Oq9cjGx"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27539328631;
	Mon,  8 Dec 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203555; cv=fail; b=bNHtdWEnqWzT/gAWXj8eDTmDGnxqxhkwWGVfLIiCmAf63WeMmZdqLFl6xvNXgFbef3rlNYhj62OzzUAcV7YtFLySr6RC0dMT3jJKiHEda0BQlrXa+ijHSH4dPLy/yawBJfdQKzEyM8bJ2ErRRgoLFFLnFxy6Pm5e28Q31JelkWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203555; c=relaxed/simple;
	bh=KC4MgrXHWqjuSGOLJEbEjDoe2lOPKutyG+KvkJPUjAc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JIpFU5sENW8gavGzWzxYbSvC9u9ggKmyU0FN9JFJs869JBL1lPdAYzN5TCi9hu+A05o6fJv/h5cbcYMc8pdhSea0i++DjsLKQA35FWPxJXJm0eSb/qIf/H6bRcvFswtm5Tew7a3IW7JyBZYaLwkmXxan6hFxCCeJuAzri8pxGyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Oq9cjGx; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stIHgT6ESUbuznbvGLfx2lXmCTh6zdG4rLVvECGLJb+agVb7oAnxHqyOZkyrZLIq7W5cCEFQfR+u/pyVHVW/M/r0585Gkhu4u37iNjVD5Pa9AsysGxzTcaf0FYnx41VaIZXVBxmYlrIrOeLLRnvQ2SUbWzmWwNtNYT3jCU3QQEsQRlm5lLhxf6zoBVAMd7ON3nYYydZ2imTh0TtvY8Yn0QG8L2CXQ+TDkdvh9eYBbMyZV4ghexkSmGvpAW3J6G2+akpSWJBrA63llDDDZ/Z8xgs5wvfhNI9BdonvFnwsr+b3XYnTOKhnNn6y01L7TCx2r8q6KAtGy4/SKm+izvuM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wl3atE5TkpeVUhkyDuCwW3zLkAjzF6WjWiIdkzYnhgw=;
 b=Hgkl6nNtpK9IQaO81o2ZkwOnqgUULcTzoPU5qjVMzotoCSaX/rtFUE3EMgLb5Azkoc3o45u4bqvFvgbD/sQZJFqjyQjsLbFrCgw5B1Khcr7+VGzkbYhp3oRG9rD61rHksyiFdYlNy92g/AAYDXGXVTEfkiRp3g4KA41F+0gMASfpu96MuKeV2Nlpg/XpzADTUlYYQOPTKQRUtgRWRz4BY4rw/xB+/FZQHApcQ98fj7NmsPkcasMqmE8ChR+bGMo7w+09pIGB9Xiqd8KTrCrN+xXCSa+MkRLBYt0x7UPytNuwaQ3U8YIAoJ21GIA0GyZxkyztuDvZgUOdrH0k05yosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl3atE5TkpeVUhkyDuCwW3zLkAjzF6WjWiIdkzYnhgw=;
 b=4Oq9cjGxfhs8NMDIE5AWYEcm636P+gMFwTBHvZhwQ/A53CTYGgU5nn9oHwp/AwqHz+nzQ1VYfeJH4fu2NigqDEzqNyz2hVzMLO1WDlU5VfoFTU7jLSWWjk1Ueak5QyTklFXNwhGmqFyY3yB2PHfYLJUClEbYT27Gdp5DEim9dPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 14:19:10 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 14:19:10 +0000
Message-ID: <5bd14207-cc7c-4fec-8340-e8a98330d628@amd.com>
Date: Mon, 8 Dec 2025 14:19:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, alison.schofield@intel.com,
 terry.bowman@amd.com, alejandro.lucero-palau@amd.com,
 linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
 Shiju Jose <shiju.jose@huawei.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-2-dan.j.williams@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251204022136.2573521-2-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0031.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b3cfb3-cd36-4134-12d1-08de3664c199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VndhZTJ3a212UktrOGdRTUo3YW91cHpvM0RQM2E3VXBZODdPVy9CNy9iOENy?=
 =?utf-8?B?WUczNU85QVlrZVVkY3Q4VVcyNVlzMlFBNFZxV0VkQzdlaFRFNCtFRWFVVlBO?=
 =?utf-8?B?aTdmOHpUcEc3bzZEcmRLWmNER3JWdzRQc0VoTnFOMXZ1L05vVFVZSzdWMEtI?=
 =?utf-8?B?MUpTZVlDT2lGdGQ1VHp6eDJ4OVFwY0JpL1J6NGhLc29XWEZWNlRZZ0ZkR05m?=
 =?utf-8?B?T2F6aHlkVnZCbW8wbW0rSUJQMFdkQStLTDhHZmlESjBRdFg5cjh5S2JvVVVR?=
 =?utf-8?B?N1VFb0hlZUdVOWpSdk5VUUJEUytOcGZKWDVmdVZnM0cwZUFIRkZDMkVxd1dJ?=
 =?utf-8?B?OFpyUzdCT1J3eWdJaGQ2QVB4c0RaMkJzcXRURW5HZnBPaDR1SjAzMUk1bThB?=
 =?utf-8?B?SWVEbHFFZFhuUTArQlFwT2JXS0JDdXpuNzZFK3BDeUpnT2lieHZ1R05yTktZ?=
 =?utf-8?B?R3ZBWXU5M2FyUHBYT01SdCtYMENZaGQ1dk9tRkFrYVZpVzZsTHE0UWtFSmFS?=
 =?utf-8?B?VTQ1OFZtU0xKanc5VWs3T3ozWW54dmdFcVZGRWdYd0RqVVptOUNTWWJSL0ZR?=
 =?utf-8?B?TGlPcjBlbVVhQ24rbHdJa1YwdVg5cUVGaG9DSE94d1NENHFNSmd4V0pMVUFZ?=
 =?utf-8?B?M2tXUHg2SUtYbWNHaE5KVkFaL1ZTSlltYVExTVZqRURoaHk3TGpvNkE1MEtH?=
 =?utf-8?B?RnBDZmE1d3BqakFaTHZjT3kvbFFNRjBZcHA4TnVjT2J1ekNZWTM2OWg0N0RT?=
 =?utf-8?B?UjZQemNCS05xRU5oU3k5b0dGeTIzZnBkN2pmMDY4UHA5aXpMSm43elRLeWxL?=
 =?utf-8?B?UEJtR0g3VXhFWEV4cVhNWXlHNERSVEJZUzRvNWFzSks4aTB3TytpczFuYUUw?=
 =?utf-8?B?REUvWEltZTNDcTNxWXhWZlFZZlZvODh5MHdncmxOZzVjS21NOTdSeDFwQ1NG?=
 =?utf-8?B?M2dGSWN2LzBEaHJpcnNmb1M0STZjV1lIclBiNUxYd3UwTEo2S0tkTXZZbW44?=
 =?utf-8?B?cDVFbTE0b1ZacWhtNWJCckc0cEJMOElTTlpuUkxVaVJCNVdQVE9rbFFvZS9G?=
 =?utf-8?B?bmszYjNVK3ZhOGVtaXYycmlEOWo2clZqVmh5b0pTczBFUDJVZ01BcDBCSWs4?=
 =?utf-8?B?RXhsYlB4SitxbzVnZkFTaU1COXo0aFBxQ2tGYy9NemFDd0t1Q05DSVFaK0ZO?=
 =?utf-8?B?QjlNSkZoSFM1QjZvdmVNSFVER21FVE9ZM1JsZmUvZDcvOC94ejVLUDBrSDN3?=
 =?utf-8?B?N2o0N3dsK1FmUkJwaTRVTGRYMEhRcFpoaWhrT1lnLzhFZ2FRZ3g4bE9MM2Iz?=
 =?utf-8?B?TDhLN0oreEpxdjhLMTkvQyswT1h4a0xMU3NzbWN1ZHFqWU5OK1BWKzVMTDVL?=
 =?utf-8?B?czlVZGZISFFidnJGV1MyU3M4L2ljcHRqVjBKbXJzUzJudnpPZTRkK0wyRFd4?=
 =?utf-8?B?Q0VicmJkVHdzNWhzMWgwUmdjUWlFcmZCcWlPUDFsSVpmcDRDQkMya1ZNL2Ry?=
 =?utf-8?B?bHdrN0FqclVvMlFNcWZIOGppNDY2MEREWm5aVHVnM3F2Ui9IS2g0cUs2S2Qr?=
 =?utf-8?B?dTMwR3FIUkhwMG1FNnVpelVWdzM5a3FpU0QvS3IzV0tMajVhRHB0b2FCTFBo?=
 =?utf-8?B?NTZteHZFZVNrWVcwOGVnZEpZK3J6Zm1IM3hUUWYzeEJtMGQ1dHFLUXNaeGpW?=
 =?utf-8?B?eDlzTURBMUl2dG9uU3puaWR3dTdCQ2pzNCs5U3VTMXArcExzS3JkREdYOFlr?=
 =?utf-8?B?WE5QUCtOejdvS3N4MDhRNzYzclAxOFZDL25sSjQ3UXBJT1JjckVBM1A1NnZa?=
 =?utf-8?B?YVNISFFybFpNSmdVdERjYmh3VCt2WXQyWXJOTW1DSHlPT2Uwb1hCMWdxVnFP?=
 =?utf-8?B?V1kvRmtCaFFiWnVmbzc1VmJhNEhGb2lRYkRhckVVNnFlTDdUdW1JTDV4MkY4?=
 =?utf-8?Q?YjzURhevq4qZaTg3L6oz7IrBKK7Tjy6A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFpYSllDWVV3RHpaZ2huYnZwT2pnS3RwdmhYNExGSkRGdmNoK0FDUnIvK2dS?=
 =?utf-8?B?a29UaTFhQm91L296RTBmOHdTcEUzUCtWaUVsT1d6Yklrcnp5UTZZL1JjSjht?=
 =?utf-8?B?bEhFSmlUWDMveXM5TGcycDltWUNoOUsrdmxLSXJHVVpPaVJQbG41THFKenFr?=
 =?utf-8?B?cytFamFGRUYyRHJKaGo2Y2lOejhhanZLWjJXaGRQOUlWUlAzQitDOUI4NlJq?=
 =?utf-8?B?cGQ0ZW1abVQzeUVhZlEvSUNjUFhVUXV4S0VQM2FKcTVXWjBWcWQ2WjFuY2J1?=
 =?utf-8?B?OW5BNTlGV1B3MW9mNERmS08yMHdmM1hXVXc1VTJ4V053OXAydHMwdVlWcGgv?=
 =?utf-8?B?dG81OGdOQkdUMmJvcG9KSHRxOEFrTDV3aklhdzJkWGQ1dWh5dDNLYWNmemFy?=
 =?utf-8?B?MFJhRDlzQ1BqM2xZK1B5QXlsVjFCN1VTSVVlK2Nsc2lVdHNkOW5rZmNCY25M?=
 =?utf-8?B?NyttTDBleTdBN0F3V3g1YWVFbGVZbjBWbWRtKytIR3ZvYVptN0pVQ0EzaVRF?=
 =?utf-8?B?Mnp0bVhHTnNIL25BS0NGK0xYL2lHTG5HM01SOTJJOEJUMGFOc2ZnaVFYbjNa?=
 =?utf-8?B?TXZWUXBjMWNrczlFNGlySjV5ZVlkeW95YWh3em16Z3hMTld0QTJjUE1wT1FL?=
 =?utf-8?B?MHQwZEVuWjFGV0hOMmk5cW80K0pDQkpkM1h4WExLS3F2cDNKdFdkM2dlSjhS?=
 =?utf-8?B?a0hjdmpGR3Z1NUtIeS8xZndxSC9oSVpyczlpK1dYRi9GaDkwbGw2aWRKcDl0?=
 =?utf-8?B?N3NYVTN1UFRhajNjaEo5amVyR0RtSW4yNU55MTNZS0pnMmdTb3YwdVdyUVd5?=
 =?utf-8?B?S0xNV0t6VStleEpyemlqWFYwTFA5cDVJS1VXUmRkc0tIWEhSazNRTDh5SHFB?=
 =?utf-8?B?OVF2Qy9HV0VmTDBITmxVbHFGb0NEMlNVTHZQbFZiZjB0alh0dldkRVZaM3Vu?=
 =?utf-8?B?RHhXblFrcUxBQm5qNG43UVJjWVBTVUZMaS9idzU0VC9ZcVJ5QU9mRjZ1V1ZI?=
 =?utf-8?B?Y2xxa0ZWOVZWMXdtaWczb0NkN2xyWTJZc2NDNW9oWmlwOStrUzhoSExjQ0sr?=
 =?utf-8?B?U1RYRlF1eDFCUERTWGpPL2hCbndsSW9rUlhxUGlibU9PdUh4Y3F4MGVaSnBV?=
 =?utf-8?B?enErODFzeVA1SndaMEl5eHY2aER5YnJqVjFKWjFmVU1wOTdLQ0djTGJjQ0Fo?=
 =?utf-8?B?YTFzWUNDbTJrVnZGS1JSNFJJUDYyVUx5RUZ3N1BNSFB2WmdHZisyTzk5c1hV?=
 =?utf-8?B?T2JkRlhpbmlKaUtaWlMzUkxCeGVIUGlXRGw0QklEb1NWS1NveVBaaDZyRGpR?=
 =?utf-8?B?eU00aUxlR1VYbVE4WjU2VmRXMk85aUxzZ0g5dHc2dGhGSUtPdndGRXk1amlM?=
 =?utf-8?B?NS9mdDRkMURPeS9DbzN1eU9Eb0ltOFFpSGNWT0d3YnlGZ1N2L21tRlZNbnZT?=
 =?utf-8?B?WGZZYW9LVlVIWjBJZHhRcU9uc3BLTWpYaUVXRnZXbVdHZFVSR0QxeVhXbjZU?=
 =?utf-8?B?aHlKTmNLWThUWEJwVlB1dWFGQk95MVN0VEcvdjljWUpqbkl6UEhoVjc3OWk0?=
 =?utf-8?B?Sk1jVzlVU0RQRFZzQ3V0UWxnWUU3M1RYaDQ0THBxNkxxTnpubUNyNXBtTmhL?=
 =?utf-8?B?bE5IRm1mZVk4NU5qUSsrUG02YzdEWnZ2c1RTdGlzSnBtRnBha3JXUGRiTmdh?=
 =?utf-8?B?L21MbEhyc0dTaHFNM1UvbUovSG9tNGRjbXBLMDNLRlFoYkNUdzBaWGFFUVVY?=
 =?utf-8?B?d0tNbTNiR1oyRUpscG1yWjFKRlhEK2NodHdjNEEzMTZlRXY4U2xuc1JsWEhH?=
 =?utf-8?B?ZnkyVHhXZ0RhakxYSnRMNFd2MVB4aXR1b3Z2aDc5dDFwSlB6bzZOZy9IZFZk?=
 =?utf-8?B?NnBqTFV6d250QU1XSGdFM3duRWpaWU9sWm9wR1p2U3lXR3l0RENWa0dicUJZ?=
 =?utf-8?B?UDcyenNuWGxHU3hiekFaem40V2pmUzR5U1hzSFJ2Y0p2RjdZRUxYMG9YdWZT?=
 =?utf-8?B?NEN6dmE4am90cWg1UVdBeEEzTmphcWk0U0hCZmQ3bjI1Y283M1pyaEhkc2Y0?=
 =?utf-8?B?VHFhYXRZSzBKRUk3NWlrWTFDZGNtLzFZMmN1UlhieE5Ob3JDTElEcjM1M1Jj?=
 =?utf-8?Q?70cCt/699RNcLZmIt/CtcN1eC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b3cfb3-cd36-4134-12d1-08de3664c199
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 14:19:10.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tf8qgQXvE46imivix2GfbJUuAnM/cBRGPAwd+DAoe+OYZBJ2s1zTWY3dqhbUZpn7YPeUjOEpVe+HjiGsPNZgsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369


On 12/4/25 02:21, Dan Williams wrote:
> A device release method is only for undoing allocations on the path to
> preparing the device for device_add(). In contrast, devm allocations are


Should this not be referencing to device_del() instead?


> post device_add(), are acquired during / after ->probe() and are released
> synchronous with ->remove().
>
> So, a "devm" helper in a "release" method is a clear anti-pattern.
>
> Move this devm release action where it belongs, an action created at edac
> object creation time. Otherwise, this leaks resources until
> cxl_memdev_release() time which may be long after these xarray and error
> record caches have gone idle.
>
> Note, this also fixes up the type of @cxlmd->err_rec_array which needlessly
> dropped type-safety.
>
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/cxlmem.h      |  5 +--
>   drivers/cxl/core/edac.c   | 64 ++++++++++++++++++++++-----------------
>   drivers/cxl/core/memdev.c |  1 -
>   3 files changed, 38 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 434031a0c1f7..c12ab4fc9512 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -63,7 +63,7 @@ struct cxl_memdev {
>   	int depth;
>   	u8 scrub_cycle;
>   	int scrub_region_id;
> -	void *err_rec_array;
> +	struct cxl_mem_err_rec *err_rec_array;
>   };
>   
>   static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
> @@ -877,7 +877,6 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);
>   int devm_cxl_region_edac_register(struct cxl_region *cxlr);
>   int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt);
>   int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt);
> -void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd);
>   #else
>   static inline int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
>   { return 0; }
> @@ -889,8 +888,6 @@ static inline int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd,
>   static inline int cxl_store_rec_dram(struct cxl_memdev *cxlmd,
>   				     union cxl_event *evt)
>   { return 0; }
> -static inline void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd)
> -{ return; }
>   #endif
>   
>   #ifdef CONFIG_CXL_SUSPEND
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 79994ca9bc9f..81160260e26b 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -1988,6 +1988,40 @@ static int cxl_memdev_soft_ppr_init(struct cxl_memdev *cxlmd,
>   	return 0;
>   }
>   
> +static void err_rec_free(void *_cxlmd)
> +{
> +	struct cxl_memdev *cxlmd = _cxlmd;
> +	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
> +	struct cxl_event_gen_media *rec_gen_media;
> +	struct cxl_event_dram *rec_dram;
> +	unsigned long index;
> +
> +	cxlmd->err_rec_array = NULL;
> +	xa_for_each(&array_rec->rec_dram, index, rec_dram)
> +		kfree(rec_dram);
> +	xa_destroy(&array_rec->rec_dram);
> +
> +	xa_for_each(&array_rec->rec_gen_media, index, rec_gen_media)
> +		kfree(rec_gen_media);
> +	xa_destroy(&array_rec->rec_gen_media);
> +	kfree(array_rec);
> +}
> +
> +static int devm_cxl_memdev_setup_err_rec(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_mem_err_rec *array_rec =
> +		kzalloc(sizeof(*array_rec), GFP_KERNEL);
> +
> +	if (!array_rec)
> +		return -ENOMEM;
> +
> +	xa_init(&array_rec->rec_gen_media);
> +	xa_init(&array_rec->rec_dram);
> +	cxlmd->err_rec_array = array_rec;
> +
> +	return devm_add_action_or_reset(&cxlmd->dev, err_rec_free, cxlmd);
> +}
> +
>   int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
>   {
>   	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
> @@ -2038,15 +2072,9 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
>   		}
>   
>   		if (repair_inst) {
> -			struct cxl_mem_err_rec *array_rec =
> -				devm_kzalloc(&cxlmd->dev, sizeof(*array_rec),
> -					     GFP_KERNEL);
> -			if (!array_rec)
> -				return -ENOMEM;
> -
> -			xa_init(&array_rec->rec_gen_media);
> -			xa_init(&array_rec->rec_dram);
> -			cxlmd->err_rec_array = array_rec;
> +			rc = devm_cxl_memdev_setup_err_rec(cxlmd);
> +			if (rc)
> +				return rc;
>   		}
>   	}
>   
> @@ -2088,22 +2116,4 @@ int devm_cxl_region_edac_register(struct cxl_region *cxlr)
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_cxl_region_edac_register, "CXL");
>   
> -void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd)
> -{
> -	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
> -	struct cxl_event_gen_media *rec_gen_media;
> -	struct cxl_event_dram *rec_dram;
> -	unsigned long index;
> -
> -	if (!IS_ENABLED(CONFIG_CXL_EDAC_MEM_REPAIR) || !array_rec)
> -		return;
> -
> -	xa_for_each(&array_rec->rec_dram, index, rec_dram)
> -		kfree(rec_dram);
> -	xa_destroy(&array_rec->rec_dram);
>   
> -	xa_for_each(&array_rec->rec_gen_media, index, rec_gen_media)
> -		kfree(rec_gen_media);
> -	xa_destroy(&array_rec->rec_gen_media);
> -}
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_edac_release, "CXL");
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index e370d733e440..4dff7f44d908 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -27,7 +27,6 @@ static void cxl_memdev_release(struct device *dev)
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   
>   	ida_free(&cxl_memdev_ida, cxlmd->id);
> -	devm_cxl_memdev_edac_release(cxlmd);
>   	kfree(cxlmd);
>   }
>   

