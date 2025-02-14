Return-Path: <linux-pci+bounces-21521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D43A3667B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 20:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA601896F8C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781791C84AF;
	Fri, 14 Feb 2025 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y7sMfrs/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BDF1ADC7C;
	Fri, 14 Feb 2025 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562647; cv=fail; b=jDULnT2ZdYbD/b3v+zBHAU03XKXpQHUlChBB4Mc5vW81KbROvYMntUyIs17z95uttaPIT8dblcYeo+NXePa9u3dmdPx/U8mWDMPPxzGjjo1ylLcVZD0S2XbOD3mCMdC8ZVC8pR95sOsaAEn28vGl8xl+s9taPR5etV6Afxn+QiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562647; c=relaxed/simple;
	bh=WRksux7AKvVUFEJJNdri86vMVm1a2vOQ5p0UX6NZgd8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EC3o0GeSWth/91K+wKxbxHmhRjGsgFHIbqHOjgmmKDAnhkdK/qxeRj3pmPWLjRLQ1q4Dlwk9IceSCzJEoWFhWYsNx9+LJdPui9597DbOHV2a+svVaL/ETwXjISz9XKdirCBoP9Ndx2oO9Y/WuAOqS28+qBVlqcpc2+rvlloEaVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y7sMfrs/; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJjSnqWSVRLJAwa985Ipr9nWVmXzyMOSTXESuT2uataD1JrtOhxDl9YdeqRqS6yxjNMDLGNg6TebBxcYIWXJpj5BhoUb+UxYgQJcYdfOKiuy82kfBjdNZvLYQ3EZE7+NF8AxToe4e/FrA2OpLp4rc4eBUFupwENcJfirtv+xsvMNnP36cb4/3tQkVtpjqz8Q/WfuIFSsysim+mSPCuSgakwv/Oa7P5Hlm0GOwMU17HT7noDSew9FccjeymbUZAHb7glFOrpR89NYGqSQy2M0t2oXfORXXW6KASu+2c2g6XDrWSkHm0VbJ4o1WpD8hGeMGhfpbgQ8q8ifeN4JWv1kWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0kCMvGVgvG1SlkvhOyu7XAkblNFR3IzDq03lmuLGuY=;
 b=xUgZCNokYNdVuqga6tghAPpGYGYHDOwEuPClm4MtwCpcGUrqsPIiC09YrNyYyOhETMzEyWAXWHXhCuoS8BHYke+7evcvMa1Ln3h4KEXDnKgcmF/ylOlGtn9+KOlIrMCKZe3Mb8IUnZih2zkog78UrHLZEy89+dgtkVYOpCONVRtOfBdW8atz0QYn83+17dvdrfsEgheh+1BkzUcPyjLxJAEpbKJOdvrZTiTQSaTxQ6Ad9FcNCuQMAyydHxB7CPbfdG614alrUm0yo6z8KhiJqgqf058Y0GRYR2pcDpi1O4pVD7hMDgO8Hw8RqK4nQNXOYgvdKbW301evJ5i+btdoog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0kCMvGVgvG1SlkvhOyu7XAkblNFR3IzDq03lmuLGuY=;
 b=Y7sMfrs/Exxxp9+wz453T52IUTkxXiP6IUQfU64+dfd/EAoRqsVfc7J4GtKqOnpR91Vk5ocEh5VwMa2ZO3WXP5qB3iyBrn8FinhpUyvDZLIVOLCzAVM5PKRvCjWQ0TeFBFXWGYl20d3sYHMDJaN9HBnesIUQXZDZDwPEpSNskyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Fri, 14 Feb
 2025 19:50:43 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Fri, 14 Feb 2025
 19:50:43 +0000
Message-ID: <a928791b-6fb9-4a03-88fa-87e70b609c9f@amd.com>
Date: Fri, 14 Feb 2025 13:50:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/17] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-9-terry.bowman@amd.com>
 <20250214151531.000007d1@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250214151531.000007d1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:806:24::9) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SN7PR12MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e140420-e12a-4862-2062-08dd4d30ddbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T003UWRDYjlvMVJHMFJMeXB2SGNma3ZhdElnUkpRM20vMnl4TyswSFYvRmdk?=
 =?utf-8?B?R21oeVJoSTNHa2hKS3RVclhkTXg4MlVoQzZOWWZsdVNhT2VFR2J3VlhIUVpu?=
 =?utf-8?B?Z3RhWkNaOW9LNUM1NlVwNzZVbG5MSDlCWG9DUDE4MGx0eStJUmdhWnVUTFIz?=
 =?utf-8?B?Qm1ndktEbnkyWVNaelpwS3RyVWFGVnczMitNTFprQXI0NEdsbXlwbnNkTkZB?=
 =?utf-8?B?YUlsVi9nL2FBU05hZVMzQnlGS0VHODZaV3NEYVQ1RTZvV2prcEMwMS9RRmpk?=
 =?utf-8?B?eEVUT09ZRjQ0M244ZE9DdHBnUStyZHJhNUJLdGtOQ1dLZ1NsU0t4SmR1RURQ?=
 =?utf-8?B?NmNRRUp2QjlkYnJXVG03cHFvbThGZURiSU9mbHVLNTBEQ3BYbXZ3QWNibDFI?=
 =?utf-8?B?NWFPSjQvVUkxbWpqWWRaRjlXVkZyUjQyaUdHR0FmOTV2bEc5eTRlY013Qmxs?=
 =?utf-8?B?QjFFVi9pWTdmTG5FN0hBMU1FL01mbXFPUGZpRzFkWmExSzFUbzM2Z0FJa2R4?=
 =?utf-8?B?ZHNkaEtEdWtKUGFKbU41WDQ1WkgxWWNucWVrbEEydW96Z2xhRzJzc2M1bFFM?=
 =?utf-8?B?dVBUZDVlemtVb3VRZkRqS09NTmZKWVF3VWRsQ09DMmliam91TmZhRXpLYzE2?=
 =?utf-8?B?ZFU4OFc1NGVMVWE0UlZsWmZaMU9BbHNzY0gvdng2QUtUYTRxRVp5dG1QV0Jk?=
 =?utf-8?B?N1MrQWVpWHBJSWk1SXg1QkhGSjZWZksrdmVTWHZ1N1NqL1VuUU9Zbjk2VE9U?=
 =?utf-8?B?RkU2cElFRTJMNFVwQU1IeW53YW1ka3VmOVo0RG5OSlY2bWFiOCsvQUVkaXA0?=
 =?utf-8?B?TzUvWXFlMmtTRUhxTGVTSkhQVFFMRGFiWkwxZk9oZUJxR1dwUmYzanM1ZzR6?=
 =?utf-8?B?VUlGTUdWeGpQM1hlS1JrN2c1ckNvTTlDeUdLaGo2b3IxZFBldFJINDZBODFm?=
 =?utf-8?B?VVNrdnFiSUg2Myt1dGl5b2YrVHhzK1VXZnMvL01iS1ZQa3ZtWVFzV1R5TWVE?=
 =?utf-8?B?V2JkTnprcDNjRzM4NlN1N0U0Q25haWhRaWx6clZlVFNUeXRYNC9TK3NyS1Nw?=
 =?utf-8?B?UjZZTVp1U0djVmV2eU80YnJaWDQvRkJHaHd0SXFrRmFaK3p0ZkVHYkU3RE43?=
 =?utf-8?B?Qkd4KzhWd3Bkb1I0bVlsNElmd281NEFoeSszMGo3Z1h4YkJLWHBLY29mOTBE?=
 =?utf-8?B?cFhKSGE1T0lmU296ZXBselJDR2NWd1VVaHI3ZkpEaWFSbEdpaENUazZjdWJR?=
 =?utf-8?B?cU5XajVTenF1SzMwWGZzZTF3TzdCblZQOXErV0pTc1dySkdsdWhWNUJwVjlQ?=
 =?utf-8?B?UkowaUJGb3gzdGVCLzZSN2diWDFtK3RvK0tCODlhdjRUUmduOWYxRm5vVkZH?=
 =?utf-8?B?ODM1VnU1UEYxZ3I2ejRmdlpjdnp2TEtWaU1vUmkrTWZ0cXpRN3lGY0QyMTNv?=
 =?utf-8?B?YW04cDlXNHZUUGNKTWZISUwySUpNZ0tOME5Nc0huODhxME95WEx0SmQ3NXc0?=
 =?utf-8?B?WG1MWVFWR01PVGRxbVluWm81bnFud1dGYmhoUnJCT1ZnY3Z4TGkxdkdhRnE0?=
 =?utf-8?B?S3FIMzlFZ3VNaFFaRnVFTXF0Y1ZpZkx0UzdtT3gwZ014ODhmUDZBVXJtczdu?=
 =?utf-8?B?eXhGNWVRL3R1ZFczUGlRNXAweFJoTnhoOUltcTUyaEFXVjNtRGpGU0pyTHNo?=
 =?utf-8?B?bUdPa1IxbU9NZVA3TFBBaVFRbGI2OG5pUnVtZDhtMWJkaG56ei9BcnhuZW5V?=
 =?utf-8?B?UFJsTVNmTm1ERUFXWGhLSEx0WktTNW9JaDhuS1J4ZndidCs1NXppMDNtOXJw?=
 =?utf-8?B?eWF0WkdxWEwrMTYrTnpsRFJKMkw4b2p1MmY1MjVlbzBYNExsWmxINXQwY0NX?=
 =?utf-8?Q?6cMpPVYGbi3NO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3greFZkZVR5S3NFY0lGTkVZdW1ncU5LOGdHMlhNQnRWb3UrWWY2WlY1Ylh2?=
 =?utf-8?B?WmpZcWplQkZaUis4MXNVWlR6NCtzVHZvc2ZaNmttczlFMHNzQ0MzcFIvaytn?=
 =?utf-8?B?ODFUL2s1NkpZQ2J6Y3p6RUQ5TGFPd3hZTjkwN01mRjl0RWxpb3IwclBiRWpw?=
 =?utf-8?B?cTNoa3UyYjZQTkFqMHdCSlZxcGpRMXZLNkFEQzdXQWdRNzVJT3BML3dhRUtN?=
 =?utf-8?B?ZmgySUtySWdXR2prNG44aVh2M3pLVHVsSmJXWjlIM2RwU2I5OWZuVUhGVG9O?=
 =?utf-8?B?TTJVaW1GVmR6L0tRTkY0SUc2Z1RHSmUzZWxIV1paTmNGMUFIT1JyTU8vOGp6?=
 =?utf-8?B?RFhmWXF3Ry9FY0dWZ2lCbXVsMlRnWWRtekRjSEVHcUMwR1lNRVozSVNXeCs5?=
 =?utf-8?B?Z3RKblJjY0JRQ3FKeFhYL2p3SjJicmszOVB0NUN4T0N4QW9udkdTK3VhQUJO?=
 =?utf-8?B?NkYzSTBwNGtlMDFGempKdjdBQjNEQU1iL25ZL2E2WVVieXVsMEF0M3Vuajhj?=
 =?utf-8?B?Y2tPcHVzRUptWnRBUFdwdWFRVHludnhFbGRsb04xN0dXeXg2NlgweDNHcDJ1?=
 =?utf-8?B?dzAwSzFtakt0UzdrMjZHNHRyZWtocUlXWnZwUEN0c3JRajdhTW1ydm00dmc1?=
 =?utf-8?B?VlYzOTNtM1ZBck0xbEI1NUdWQXgrRXJzdUdERnhkZWNuSCtOOUlXeVZZa0k4?=
 =?utf-8?B?MzBCSkQ4MW9KOUp0Z0kxZlJJaXNDQmMrYm9DTGxtMVhuSHNsM1hpL0VZSHpZ?=
 =?utf-8?B?U1Mxdms3aFdWOExlWTFrUFhOMHJtK0ZsQ0RPTkYwOWZzTkpIVDdMVUFvb2pS?=
 =?utf-8?B?WGdBb3RtNlJwclBkUnh3d0lLeDQyL2Z2NEdNWTJTVGk1S0NyVWJvdEJKRUNH?=
 =?utf-8?B?SmFwSU1DdTloVUVpT1BLalh5b2V6cE8vRjdTWHhEOGtqTTdCTVU2WTByUzFt?=
 =?utf-8?B?UHVBQldYSWFrUFdobkFVZm1VczlhbEJCWFVKb0N0eFc0UGNxalc4ZW15amx4?=
 =?utf-8?B?SDVZTFl2VlpDRXNWTHdJRlpGYkFTSnlvVkxCcFRRQVJac09ibWRZOWNGN3dQ?=
 =?utf-8?B?ZjRVbmlyNGRaajVFK2c4NDJMbEFyTGkvdGFFU0dPQ2hZWk9teU1XUnVWak5R?=
 =?utf-8?B?TXJKOFczbGljMm5CM0pNNTBmV3E5VWF5RW9sYUMwQUw4b2R4czZXKzNlR2Fy?=
 =?utf-8?B?bkZsc1p5ZWxIS3JMazRiQWlZbG5va0VGRTRjMGp1aVppM2xET1RtYXNpeU50?=
 =?utf-8?B?K0FYTXJVNW02ZWxidVZZandEeEg1TXg4YXF0R2hYeEhRclI2R0tVYWNvYjhs?=
 =?utf-8?B?ZCtQWVBPamNjUWJTOEZVL1RZTUtZTW5kODRSNTRvbEI0WHZGMnlQT0VNWUxP?=
 =?utf-8?B?RmVLb3dXTkdVb3MySkNtcTVDMlV3Sm1hN01GcUxBMURtMmVHdERONmhXSUVy?=
 =?utf-8?B?aUN1QS9VMVNQMWhVRUZUaFVienpOY0JqNm1FR0tCNTVaR0RRR2FCQnBhRDJz?=
 =?utf-8?B?UHc0eE44T3lSQ0YrOU9mRlRBZ0JvRE1haXRJc2xoZ1phdVhwYjBnbzAwSnh0?=
 =?utf-8?B?ZmZ3TjAxTzlBTW1VNG92TUxKTDFDd28rWVIxTzFLcGlVRXJ0QitTNzRPM1FI?=
 =?utf-8?B?YTY3WlhnejZ4WXQzR1cwSG9GYVhGeHltanp5WUxYdlZoRzZ0eEZKcStRVmpW?=
 =?utf-8?B?dWhnVUs2ekVqaUNEYVdOOWVLQjM3MnBOOTA0K2FjbWZBY2t4d3VhakVCcWNk?=
 =?utf-8?B?L2pCckw0Q0VRVDZxTk5IZHdBUHVoK29hT0lBV0h4Vk83MXRYaHVHVlBzRU1O?=
 =?utf-8?B?aGJJbXBkVFgrRGV0cER5bWNoKzVXazQxK29ORWVPSy9YTTNEWFZacHU2SkpY?=
 =?utf-8?B?UDNiYm52QWtCaGFlNmQ3RnlNUzNveWNIcnVpaEFnYUZESXZiWFNKWm85WUVp?=
 =?utf-8?B?UERrdHZzaWhKNTZFdlpJSGYvUUNrWjZXS254VVQxWjlHaUtjS2tqSVAwWTRm?=
 =?utf-8?B?K2U0WFFFOVk4MFNZak5BUFYyYi9TaU9HNzl5WUdVcWIySmY5TFczWWhFL0px?=
 =?utf-8?B?N0g4MmtWMXErNm53Y1lwQUhVUkJ6SnFseUhpTjBTU3hSV2xmK1U4SGFRTnRG?=
 =?utf-8?Q?fK54Sgl7ORZRfCnXYSS5HuOOO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e140420-e12a-4862-2062-08dd4d30ddbf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:50:43.2158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju7ly1VMPPrUo/aXuc2KEhqoqHwGG8ruoh02mbXSx0gwLT0LXjlSGpHXQklwjQ7hR0VxWrR5HCjLxwF7PlXawQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786



On 2/14/2025 9:15 AM, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 13:24:35 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.
>>
>> Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
>> pointer to the CXL Upstream Port's mapped RAS registers.
>>
>> Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
>> register mapping. This is similar to the existing
>> cxl_dport_init_ras_reporting() but for USP devices.
>>
>> The USP may have multiple downstream endpoints. Before mapping RAS
>> registers check if the registers are already mapped.
>>
>> Introduce a mutex for synchronizing accesses to the cached RAS
>> mapping.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Gregory Price <gourry@gourry.net>
>>  /**
>>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>   * @dport: the cxl_dport that needs to be initialized
>> @@ -801,7 +819,6 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>  				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>  		dev_err(dport_dev, "Failed to map RAS capability\n");
>>  	mutex_unlock(&ras_init_mutex);
>> -
> Grumpy hat (it is Friday afternoon).  Shouldn't be in this patch!
Thanks. This is removed from this patch in next revision.

Terry


