Return-Path: <linux-pci+bounces-37580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 622DDBB80BE
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74A04C4213
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD94025783B;
	Fri,  3 Oct 2025 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="opSQjJOf"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2799B2566D9;
	Fri,  3 Oct 2025 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522320; cv=fail; b=Sem5VkUb3xSF0sDsVWQMld1TwkbILtJPaFFf2SD7UpIESgN6XLZQn9QuYntvuza3ZQD5ZiGuyyhoLAGAOzyTpMU7IeJRQVxDfM5pkCPmttBvWd6kTZ1SiZmKw+bs5RiOSXUTSa40UMPbek/AlOk5JjZw2cs/JAxCWnS1hERDe0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522320; c=relaxed/simple;
	bh=tu/veQkq/fspAjbTlxLT2KNlNiwDN9Nf15D4tdy8xSg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=s1ebe0b4VmHvzhQHoQZWP5JY+7E4l+5bjhR5pi6gCz/P9oP2i9iq+7Afx27Y5lkiRXeCvOaYNBDPmT0J5kLKR4Y+9+iMkGhyFOIyahpvjPLNWyHUWNLGBHrA2MhtBsc57d/6fZoNDBALDq30PtYuXxEoSTgkyZlzDHy7qii6ea8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=opSQjJOf; arc=fail smtp.client-ip=40.107.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeJtXcKmNWmQ7gICrn+4JZFP5XBgotwwIP1btGVEDZnjdF/g2K5ZgAqAcmr6ys8/iWQEvEJsMT41VHAsII7u4qTQMq1U8RnZoGZetVdTR+5GMds4b927zClzMYxTsyjLMx8Jt1n+rS4CzCbnMmbgGf1ozGSCNgxLSZDgANqCi+qb8j88/3UbazjvswH2zfmaUV//f56RO4TZOnVieUMDQsldgUddIELIcxnk9SZCWA8diJNS34HpEieCiYdiXyvPcwRRWMdUISEpPFM6IMwXooyP478iSiIjKdLgmQSahvQbJCY0z20KKhDUTvfDrzLF3Uc25YgyT6ke9UfAdtEB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kL1pt3isdcl+aRGp0mJpZQExk/+XBMdBelTClC4tXRw=;
 b=UITI68EVoKO6BO0mbatvZELLZDjsmWDLj5YVt72EC17JTmCryRBhR/GsA6Vh09T62H6co2cTuvg4QoBTOMWaiT7Db0arMndu1Y2Eqt9DKYNlgF5Ze8Yy5C+kwHWj7NXylpKgc0xjj1+O6xHWaLWMB3R8fG8Rhvbfq2vK912YMh2QUPA0Td3MTk0NXNiuPIX/UzaRkC2iZC6SiZKYhXoBPrnrwHyGidZSIuoQFXKg0a2ZKuQsq3YmXKYVLmxaeVU7y5yfi/GKGSJskpP+XOGeSRcBLPemRXcjQ12DtvDaB7ejKQ5AZ9AxgSsm2sbrS/EeuqFzRM7h5u/tK3liu9cdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kL1pt3isdcl+aRGp0mJpZQExk/+XBMdBelTClC4tXRw=;
 b=opSQjJOfRebbtLWh4EH7oJQuqjiPSpuSENaGP8ta+TzWjWucp9Mdvc45y8grdBoyYTpFTQWyfrRQY4UW0t8swKV9sbg2Ab7S/Isq8gC5H6faRfydU1zp2TpdnDPINHFDs5M0jw2w1IHqMR1OUvnFNojqrLp3nghMdts2mTX2Uks=
Received: from BN9PR03CA0898.namprd03.prod.outlook.com (2603:10b6:408:13c::33)
 by DS0PR12MB9057.namprd12.prod.outlook.com (2603:10b6:8:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Fri, 3 Oct
 2025 20:11:48 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::6b) by BN9PR03CA0898.outlook.office365.com
 (2603:10b6:408:13c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Fri,
 3 Oct 2025 20:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:11:48 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:11:46 -0700
Message-ID: <ce36a104-dd72-40da-bb30-048fa75982c8@amd.com>
Date: Fri, 3 Oct 2025 15:11:45 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 08/25] PCI/CXL: Introduce pcie_is_cxl()
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-pci@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-9-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-9-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DS0PR12MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 0638f186-a405-46f9-18d4-08de02b9152b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzBCQk1mV1ExYStjRXBOTWQxN1dZektCVW5CQjN3R1ZiNmZBSitKWDRUNGZQ?=
 =?utf-8?B?OUxYdDdieHU0MWN0QXRNdmRvRTBFVGtiMGU5cEZVaEhDeUZjQUFYc1B5a1Mz?=
 =?utf-8?B?dG81TmVmOXZnZVMyMWF4Y2NYTkJyMkd2bGw2dmlOU1NpdzJWSjRIMnVnNFcv?=
 =?utf-8?B?VHBsbWZrSjlJU05zTVhmdjFUdWwrSkRGcW55VjhjMHQ1QU1lbXk0WWlzU1Zj?=
 =?utf-8?B?aU9ydHNtL0lZeFJBU0lkVGc0VGZBMU16cUdkcWlSbzA4NGpOYU4wallBKzQ2?=
 =?utf-8?B?dnE5YVJQaGt3Wm5wU2V1Vi9UZGROVzBEWW9Gb0JZMzZzbnF6NWVtSkZOalhU?=
 =?utf-8?B?NDFIQm04bGhSOGdLVTRWSS9BbWE5ODkwV2Vlc2JTSzNCMUNLWCsrWHFodzFQ?=
 =?utf-8?B?R0tUbThmMzg3UERzbW5rOGhPVmVLSWhLalkxSFhqOGo5QWJIWjRiaTJCemtH?=
 =?utf-8?B?OHdSSHB2KzJsODRsWGtZdzFrL1NrdDJQb0pzdmExQm1QSnVFVXhqUXpOclVr?=
 =?utf-8?B?SXpYL1FmYWdXMkJJcTlXUFhQYkRtUENJdHZxWmFWcE5mblIxcjh0YUZzN0dC?=
 =?utf-8?B?RFFWZ01KdVQ2SmJ1MzFtQTdqa3BGS1MwZ3Y1bTR3a1RiMXhXR2lPcmM2dll0?=
 =?utf-8?B?RGVBVmYrUXl3cG1ZaDZZaThoTUJ4aW8rb3pDWlB4NEVMMVlLc3NrTVlSZity?=
 =?utf-8?B?VW9XM2Y1TllQOUlLQStkaWJmN1FuTmdJRWlpUTZtOG5KV2RIUEZEVjlMOTNz?=
 =?utf-8?B?ZEpDNGpHK0NNMC93MzcxSHZKb2FveFRVMnBnZjl4ZEhpSWpzajM1N29VSGVo?=
 =?utf-8?B?ZTliV1VtSk9rdkhKSG5GRnF3ODVoaWs5WkZKOWhJUGlxc1JhdEcwUUZ6OUpT?=
 =?utf-8?B?dks2WlA4ZUloT0xLUFAwRnBQUG8rYS9RdnpCTndYbU1OR1Vtcmhjb3RnbE5G?=
 =?utf-8?B?cjJRTEF3a01raWczUTV5VU9WQVpxS1VwU1FuRGp5U0Y4L2tTRmdFd29OcG1z?=
 =?utf-8?B?RlhIdnU2T2orVnUvTGlMUnY1ZWtUcDRVM0p6c01aODZBaUV5ZUgvVi9sSFls?=
 =?utf-8?B?WlIwaE4ydUdjU2l6Q0g5YlpnVTczcUZwN1JGZzZTcWNwK3J2eWt2a0dMR28y?=
 =?utf-8?B?YjRibWZrVmh6eDlrQXZacUhHSUVXNFd1cU9yQklPd05zWlh3MklkQ1F2ZVB5?=
 =?utf-8?B?c0VWbS90NjhiMjdMTWY3Vm40QkxPRzVVSXZnTUdObHZzTm45Z24xZVk2Y2JG?=
 =?utf-8?B?QTEwcEpqbWl0UXc4RWRwVk1pTGt6eWFDaU92S3ZWcWZBbXlVaGFOc3NJOUp0?=
 =?utf-8?B?OWJqVnNRaXVRajEzS1Frdzl0TnNINExQd05hQmpnRndJVkZkYjlFQ25pL3Js?=
 =?utf-8?B?UUFyOGE4QUhjdzVkdERlRU9WcHNvT2ZzYm5HdUVMbGlFRCsrelB4NTZRN0tZ?=
 =?utf-8?B?ekI5Zml1VENZYnA3bTJFRVQrYlBheVVLYXIrbmJTNllSZ3hrMjR1cWJlNkV6?=
 =?utf-8?B?c0tlYjFORHh1UVdvYmRNN1ZHbS9sL0J5cjk0M0pUMDFubE0xd3N3STd2NFZr?=
 =?utf-8?B?eDRzeFo4Z3FjTnF4dXE3aTRVdXJtVTUyQzVQeTdhY2dSVzZCTGJMaDMvc0VZ?=
 =?utf-8?B?emZSVlhDMU1udUJaZldyTEllQjY5S1Z3U3NYTGY0S0MxaWV6czVCeDhMRDRy?=
 =?utf-8?B?TG9Tdzc5VHhUeU5hbitFRUQ0NjRRc0N5eVllOHQ3MmJqRUFpanFtWU4welVn?=
 =?utf-8?B?T3J4bGJkZVg4akVmbUZEdmM3R3lmaVd6YlJwREZiL3RNaHN0TlJZeWE3Zks5?=
 =?utf-8?B?TGErSmc3bUxWcHhydzk0NWxuaE9nRWFNWGV0dnVSaVUxUzVUQmQxcXJweEVD?=
 =?utf-8?B?OXhZa2FGK1N5N1lFQjBtSTBlMGVaR0xBZHVDME5wdUUyaUJQQXB4QkZrQWJE?=
 =?utf-8?B?eHVnWGhGR1JOVllIcWUzdkZRNzVoZ0pEbUkzeTNBTWNWeTRJNnBZSUdYNzNP?=
 =?utf-8?B?eWFhZHd0TW9ab0FyUjNBTElzUTFWelB3bktReERZcTR2cUpqekZwOVZ3eURW?=
 =?utf-8?B?YXJGZXNpSlR1QTdGL29nODdkZllFbzcraGNHaUtFeTFoZWJSNVAyekdubzZi?=
 =?utf-8?Q?BWxE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:11:48.0052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0638f186-a405-46f9-18d4-08de02b9152b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9057

[snip]

>  
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	struct pci_dev *parent;
> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					      PCI_DVSEC_CXL_FLEXBUS_PORT);
> +	if (dvsec) {
> +		u16 cap;
> +
> +		pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET, &cap);
> +
> +		dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK, cap) ||
> +			FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK, cap);
> +	}
> +
> +	if (!pci_is_pcie(dev) ||

Really small optimization nit, but you can move this check to before you look for the dvsec and
return early if it's true. It shouldn't be possible for a non-PCIe device to have CXL capabilities.

Either way:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

