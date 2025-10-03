Return-Path: <linux-pci+bounces-37581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA3BBB80AC
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95F51B205EC
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4A17A2E1;
	Fri,  3 Oct 2025 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iC87C+4j"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2D23E356;
	Fri,  3 Oct 2025 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522323; cv=fail; b=KEVGmX4zJXXD3VuBZy7f0sBP3uLDcNdEAvwragXiyYlfydScVeddKkitbgW88qpeNgQF8yTtrT+y5T63HPijZCGZvyNTgibNUNaI/7Kv3t6xTCjkT7V9ys/McAx+6VWsic/0c4E8BlYmMcIZicpdKNPrP3yp9oEjx22N5v0gCL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522323; c=relaxed/simple;
	bh=zulOETAP5RTm1BcINWSWWyTym8JiXcS8TLbq4issVAU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Hah/NhBbIxFO9GjWheGWtb09H3uajNaA5odzZxOSLG245SLiQ6ttZGaejayDzcEb6pCRtYZMlFOrYcmGsGlzAIgo22jDjLZunFDvlw9zhAxTWw5TUx36FNXFlnZ9kq4cmJlXkGCtDkrJdpzk/27wOgUbUeYD9xXG9EGhPTVCsR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iC87C+4j; arc=fail smtp.client-ip=52.101.43.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0FITTuvlVcfJBfIPLXE7Xv6OGAMwSvUVaMtlv7BqRcSiRgo7gH3v9OAxSPKqfiyxEWB+mI+pjNpfmmXw0I/0zf7Un9DYYsVr4Qhba2loGJ8R/ziuEa+zy/ORVuc5YaKkB733yCRZUjC0n+lDH3qVvV6RvCT98aXNoioLFWu4FMznsWLwPDVunTcIJVF1HydaC/8F6QL9VbV0kjqd6ZzOJbeI80cyWo5VYZP8Mxvb+wchI1n4BnJ6YfiP7X7V6JTkub/e1d5X2mycBanyeDNSu3YIuHj8TJqSSqvedyq01M5j+nwitgP4ahLFptDRyD3XGPem8867XwVDWzxaG/hWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqXx2PRuVfOcvYMEJvANck9UTQDWZ9myOLkfee84whE=;
 b=dizIR6IVdM1vdY6wuVN5BaNERDEpoK5ojCJkVtWIk3neimdq5JpQPkoUTQqo8HR/stI4Y4Zv1zWu8MukipkQJQClXVESSIfH7/UogwZ9GOlVqjpMMCazI0BD1i0Mdz8XgeNCbfNzyddb0AecVR/7f9V1RhSJGoha29GpUZzAPPJnLWVmJz8gFJ8G7StRYSF7Uf6VJgAA0KTe6AWJnecrH33gyyyKGJdE7TCvPGE85LOMfWLGePxvzqnpljctcnMNIXCx38DsYUNDkXOsywfCNGCl2RaIFSOnAF/EJgHT23piXJEw11m0dMxXwRDpHlTXWjkfNH0wnh+b9tAA352tIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqXx2PRuVfOcvYMEJvANck9UTQDWZ9myOLkfee84whE=;
 b=iC87C+4jLb7yFeGlW4/vk2WbmV2OwQtN+Db/5JzYA1lQtJsCKgm5dR7myogKXvOQfm8vrvG5v/jVDxEijkaTROZWNSOWv3qTXedxdDXTmm0Jx2zlaW1QRuu2NM1RcPhsLij5EacmyW0o5VNJzvzum6WcLqpddWCjiKukRHTf1f8=
Received: from BN9P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::30)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 20:11:53 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::90) by BN9P221CA0008.outlook.office365.com
 (2603:10b6:408:10a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.17 via Frontend Transport; Fri,
 3 Oct 2025 20:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:11:51 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:11:49 -0700
Message-ID: <394a3748-37d5-429f-ab64-276e50b7e621@amd.com>
Date: Fri, 3 Oct 2025 15:11:49 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 07/25] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
To: "Bowman, Terry" <terry.bowman@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-8-terry.bowman@amd.com>
 <20251001165843.0000321e@huawei.com>
 <17f51c55-2355-46f0-84e3-3a76a615d9bb@amd.com>
Content-Language: en-US
In-Reply-To: <17f51c55-2355-46f0-84e3-3a76a615d9bb@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DM4PR12MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 04485958-44cd-4a17-a85f-08de02b9175f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVVudHlIRFZ4Unk2YlNLUzNwSGZPdm1QWktmMVNHUERlcGtPeTZZbmEyZlRE?=
 =?utf-8?B?SDlqRXRJaEw2RjdISEFtMGxDU2wvemxBZnNjNm9UeVU2VTg2SU5zaWx0VnM4?=
 =?utf-8?B?WW90UEYrMTliWFEyODR5MlNZa0pSbmxveTVQWEZRMlFnT0xaaGluUzJHaXFE?=
 =?utf-8?B?a2oxNHZxMU5oa0J3WVo4aWZ3ZzRkQ20wcGhQaTBoaWJ5WWxJOEc1bEtPbjNH?=
 =?utf-8?B?UVNWOFIzUndTU3lCbHEwckg5YUNJL1FaMWkyYXhtSmZ4c2NZRHZXK1BqckJa?=
 =?utf-8?B?TDZjRmVaR3k5UEIyUFRGb0RuVnRlTGNCZEpjZ3ZlTnlwT29IZzhEVjhscnBt?=
 =?utf-8?B?V0VXNmZLRWQ1R21Fci83WHdIR0pDOFowWW9JV0VXamFzZHh1bC9WMTJOUzh5?=
 =?utf-8?B?dXk0c0JTdVZpQ2ZJaHVMTTcrN2Yzc2dabFRLZzdKdW8vQmNsbE9sK0FaMzJ5?=
 =?utf-8?B?NWRDQ2tETHpBOXdLOEk0UGY4SG9zOGsxVnlZUEZVL01ZTzR6Vk5RVklLeEtJ?=
 =?utf-8?B?TUVCLzRucGZEcTNnYklmbkxLM2JwYXpBcTg3YjkxSEw4dkE3azFtUHlZS3JI?=
 =?utf-8?B?OHo2VTZ0VCtkbUNJbVJjcDJ5RjVQYWVBOVRBbWtXZ3hLNUFWZE8xS2R5ZUVS?=
 =?utf-8?B?ZTJFejdvdzUvVTFUN0pCZ0NVYkNXWGpPMjJkUEVkckJuWnptZDRyZWVxODFa?=
 =?utf-8?B?QTJmZ3Nwd2tnT3FmS1pBL3dqbmxyMUlReStnMllsa29IdEQ1eStldzBIRTJ5?=
 =?utf-8?B?MmgxdlZMWVRPbjdwWlY4emJqbGc1N01NUlhPK3Uram0yRlRtQ1Zlckd5Zktw?=
 =?utf-8?B?TngrNUphejhxNmMvMDV4ZnNjdkdhb0ZtK0FkaHRIL0d2SldodDkzZXpsWEUz?=
 =?utf-8?B?SkVTKy9aTTBLNjNDYXdnSE81L3pweTJMOFEwQ05ybjFjM1JKU00wU3RXOVM4?=
 =?utf-8?B?RUpZVXB2V0NvWm1FSE5rb09nSnRHcWYzeit6UGh3UUtQemx2ZmdVNEViMlNR?=
 =?utf-8?B?b3YzUnJHTmVqNWRkUmhqcDR5Rk11elI3N1JsYTd2TWJpTG9TR2M4Zk5lUTZl?=
 =?utf-8?B?OUo1eG9MY2hzZlF1VlNoZHZPNXlDL3lNdXBMQ3ErdTNMMjNIVTF3M2FPc3Er?=
 =?utf-8?B?eWRKcjhCTUtCMHNwYWJiazF4emd4UWlQL3dHM1lNUzZldm5aSnR2cWxESVQ3?=
 =?utf-8?B?d1hQL0hEYXpFVE0vUEVNb2ZLUkZrYVBjUDhaazRlNkVVbkNVSm5tZHM3OWJ1?=
 =?utf-8?B?Z0JvUnM4U3BUL0c5M1JTNTV1cHB0c0tKRndJOGQzLzczei8zM1l2elUyNEZa?=
 =?utf-8?B?djlBUndoYlhuQzAyMFBQbFdPSkFLSDd0SGdLQUQ1ai85WE5NL1FDV2l2cnJL?=
 =?utf-8?B?ZWxTTzJJV2lrZDMrUXJhTHhEb1NFL2trQXpKcVRuZ3dyazJFcDFndEQ3NXkr?=
 =?utf-8?B?SGUyMzQ1K0pWd1JqUS9QY0dlWjVUS2N4bGtZS1p0T0ZFK0dmaWhPbTlwdDJu?=
 =?utf-8?B?MFFxTFcvUDhQeFpZSW5WdzBRUWVsaTlCV01neXQ2b09CVkNXc2tIVTVqVWNj?=
 =?utf-8?B?eXhXNUVDR1BQR3htd2ljcmlJdkhHQXdhT2Z4WXI4VzBCUEFVTndBN2hGQ2du?=
 =?utf-8?B?Y2dwck9xODRwcE05TzNuL0J1UjFVU0lWN0h3UHZFclpyU0grcmF2eFN3Z1M1?=
 =?utf-8?B?eDZjMHBUS0VKdXpvenhoRGtDNGs5OFNNV1Z6aGMvcFpsaXJIMWlBK0dzdDJR?=
 =?utf-8?B?TStsMzFNbDVTbXg1SXpBbVkvNm1uTE1IL1V6NmU5aTl0Mi9Fb1RRM05VcTNr?=
 =?utf-8?B?WkVEeXdzZWRuM2RSbTVmYjJZcjVNTUNkNzVVeWVKVGljNnBHaXZycGI1Q3RO?=
 =?utf-8?B?bXRjYk1YUnFsUGNsY1lEUG1BNWJKMlpnbUhGWlA5UEhRdEtKVm10dnNPVU9V?=
 =?utf-8?B?NnNSVEhBUFVSWktPWkxSZEMxWHFITzI4RC9PdFpVK2xMTmE4aUR2RlJMOW9R?=
 =?utf-8?B?Q05VZlhKSkFjU2ZvWEFnT0NwYkJmQ2VIMXJyMzEyKzNGTXdoZnNDS09PcGFl?=
 =?utf-8?B?bFRiLzRwRFFBUnhaV3hBWHpadGhBWCtZODVpZmd1VU1FV0NmUm93NUpwcnhV?=
 =?utf-8?Q?qkYY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:11:51.7086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04485958-44cd-4a17-a85f-08de02b9175f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495

On 10/2/2025 10:25 AM, Bowman, Terry wrote:
> 
> 
> On 10/1/2025 10:58 AM, Jonathan Cameron wrote:
>> On Thu, 25 Sep 2025 17:34:22 -0500
>> Terry Bowman <terry.bowman@amd.com> wrote:
>>
>>> The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
>>> accessible to other subsystems.
>>>
>>> Change DVSEC name formatting to follow the existing PCI format in
>>> pci_regs.h. The current format uses CXL_DVSEC_XYZ. Change to be PCI_DVSEC_CXL_XYZ.
>>> Reuse the existing formatting.
>>>
>>> Update existing occurrences to match the name change.
>>>
>>> Update the inline documentation to refer to latest CXL spec version.
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Maybe we discussed it in earlier versions and I've forgotten but generally renaming
>> uapi defines is a non starter.
>>
>> I was kind of assuming lspci used these, but nope, it uses hard coded
>> value of 3 and it's own defines for the fields. (A younger me even reviewed
>> the patch adding those :) )
>>
>> https://github.com/pciutils/pciutils/blob/master/ls-ecaps.c#L1279
>>
>> However, that doesn't mean other code isn't already using those defines.
>>
>> Minimum I think would be to state here why you think we can get away with
>> this change. 
>>
>> Personally I'd just not bother changing that one.
>>
>> Jonathan
>>
>>
> 
> Ok, I'll leave these below as-is.
> 
> #define PCI_DVSEC_CXL_PORT                             3                                   
> #define PCI_DVSEC_CXL_PORT_CTL                         0x0c                                  
> #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR              0x00000001
> 
> Terry
> 

I think updating to the new names would be better here since they match the other #defines introduced here.
I don't know if this is a no-no, but just re-routing the old ones to the new ones with a comment along the
lines of "Deprecated to match other DVSEC definitions" seems fine to me.

