Return-Path: <linux-pci+bounces-36370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA64EB812AA
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 19:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703A746490A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F842FDC20;
	Wed, 17 Sep 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AzMv2XuW"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CBD2F9C3E;
	Wed, 17 Sep 2025 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130019; cv=fail; b=JmaadIwScm6VYPvfWLOxwgDbLFMr8fgXLd/79iIMECan46NLvSJrzb9Csf3sEEwC3BNEQIDS52k3BfpCwK6uH+mxRJBQ4NSrzfQWpA5Xk64Mk62+NoJYiJT4bGA+HcOH0pKstWhcks2r1dAkiTe3d2Im7rA8CKudV5IVuOssqo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130019; c=relaxed/simple;
	bh=+qmFRUD6Av1Y8hBDlh8MbIkSX3BsSxGWAbtMimvqnY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e7XjXXF2CeWpNYmzpRHcP92ghs90IElhs0YIqPp5+IF5mu1unQ79yB07207LGTmo+nKfR6y9xG9uTU9oPlbP95mE+m7LHUBrOnsqLViwBpxZ5DE20Mh39bO6wIXYPtzg9yH/R+GJY1//cj3T6SBzFq/oUAoCjXmJy2hiUOUBYZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AzMv2XuW; arc=fail smtp.client-ip=40.93.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoB/t8fJtW+60fgoB3+lwslG29Ory5P5kYqoc9tRWHlQOwP1c1te/wmbJaLyS2jzLeRcz15qC6rqa+wqLBzvIy3rxGA69VMozhCO7ZgTvtnwLj8gdkzDd6Z54hF2GRxPx7EdH4GXnSpBXu14yskthCvw4ZDPzA1Xs6d2gNBFg52lyEl4mr604U/0MKAhJCGE1lDp/Vzl8x5wxsFLCM/A4rBt7ZgDX68oeWixGowwYIs0BODo8enJG+vibb69Ppi2hAvSYLuzohUepah0WL8j1L75s8N2i2awLZXgEArAINuQardXJv3MIhW8kVIdSztPSonlZrpNTAtMh/ZzHWqpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp2gQzMuQkb30BjRitNRlxmY5Pl1SeSvt+dG0AYc+y8=;
 b=bsfm1jHc9EKEQaaxkItcMbA8RCT0Q7iFCsteck7FuBBj6C48dbjghWbUGQ2/5o8n/7+b8Hea7/vZtWNx59HKsi/dtnQZKRkPBbC7uO6U2R6oBIYHtrGNSPHM8khJdGMPX1Jjc42GoTuJEfy1j5xZNJCTKZgHCt51sGAI3q9U33kZj8qrq28hqHsaOUrg7M6S8/cMHDqmuNQRS9vy4twK31HoJGFP/SyzWNMunnylkjNj9duffEDbIzqHJMrQSN2q9hcjgB1ZbZslb626cBURwNZFmfrnZtmJrRX2qWGa+cA2nuDz5oXLJ8cSaCe69LFq6NrjfXqcjMit5g4kG8wKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp2gQzMuQkb30BjRitNRlxmY5Pl1SeSvt+dG0AYc+y8=;
 b=AzMv2XuWBfSfdVNcu2AL+04BMu/MAlnabY66GJTNdL0g7JrV7DXkKUXI7GtSB3riRYoLgsCPalHhNIXzJonlQJPfi69tZiEy6trNtrarkcHPeCULrAXzQf9kmbS+l2/wCCihPI/xbz0qUtxna8Z/9nQmr3t8QRjvsFPwuFkw+9w=
Received: from DM6PR14CA0037.namprd14.prod.outlook.com (2603:10b6:5:18f::14)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 17:26:53 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::65) by DM6PR14CA0037.outlook.office365.com
 (2603:10b6:5:18f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 17:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 17:26:53 +0000
Received: from [10.236.181.100] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 10:26:51 -0700
Message-ID: <19dd8f00-1f17-4c58-9cd4-ed6a9d00613c@amd.com>
Date: Wed, 17 Sep 2025 12:26:51 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] PCI: PCIe portdrv: Add CXL Isolation service driver
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
 <20250730214718.10679-4-Benjamin.Cheatham@amd.com>
 <20250912161458.00002d16@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250912161458.00002d16@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 0358b5cb-427f-4de5-b855-08ddf60f64d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlZZUEFscWFSWU5rT3JsbWFMd0ZwZVBwU3MzTFFYcjBKMVFNSURiei96VkNv?=
 =?utf-8?B?Q1FnbnltVElTNTk4ZzEzSEtOUUJrcGlkRzdzNnpHK1VyeUUwcEhZelBRbCtk?=
 =?utf-8?B?TXZaMU9EdTQwK1NpR3BhcUFkZWpoZUo0anQyTEZKbnJ1dHlSaE1rNEE1VnVC?=
 =?utf-8?B?UmRNQngwc0JlYUE3QW84YmZ4NXlvN1M3aG9pSGxWWk8zVEFyMWVnSnptb2Nh?=
 =?utf-8?B?VDFCci9JaWVNNUszZCtxSDY1bEhYcWtLOHJpcXV1VHJZaU8xdU0weVNjVDNS?=
 =?utf-8?B?ejVjREsyR2o5c1dNcXdKai94R1RXTHZRWkpwNVIyV2pJQk1RT1FzY2lXUk9R?=
 =?utf-8?B?cnhESVg0YTgzUldKb0FENjR0T1phTDBpaEYwNTFaV2V5SHNSUkR1QzdHZGJD?=
 =?utf-8?B?b1J1ODlCU1Y5cE5zVzhkQUJ6cmxPc08rVkkra1JqNzlYQ1hld3hjOGk0aGxR?=
 =?utf-8?B?YzB3VXdJbFQvTHkyMm1JUjZiTHhpL205bmkwcGVpS2NWeXo2WEVSYzBXV2R5?=
 =?utf-8?B?Wll3UE1jSEVNdzU4VElZellYUjUrbHdWdmdkeEo1S3dnZjhUM3MzYndFL004?=
 =?utf-8?B?M3ZyZ2RRMkdkYTU3blhxNTN1enhvb1B6VjA0WG1TSTlNT2xKRlIwT25wNVRO?=
 =?utf-8?B?ZU05ZG9jQ20xUy9vRENiR0ZIZ1c2L0g1eUEvK0hhU2c5UE9iYXFQa1VWSTlS?=
 =?utf-8?B?S0I0MWlqZzdwUlFEdG1DdkRTbzVrR08yaFc1STNZZGlTd3R2bTdvNHp5K3BP?=
 =?utf-8?B?cmk2NHhTS0x3R0U1bW1HaVZvL3NyT21EVncvcURTczEwVXFpbkY3THJrclZL?=
 =?utf-8?B?b0FZejR2MDF4SHJkS3I1cnpDdTA5aDBMb2UrOU9kS3J6cGd1NzhFdzJJNVg0?=
 =?utf-8?B?bWxuUFg2MGRSZTNNYzF6MGhKVUp6UFgvUEFScFpPejEvOTFHOHBkNVJoUVhI?=
 =?utf-8?B?UHozV3Zyek1yUjFXc3k5b1FWUmYrbEJBdXRCYnpNd21QcE5ZZzB4YmdKcE9K?=
 =?utf-8?B?aDRLbEFKcFkweXM2UnVKbnpHNkZnQmtnQ3ZGSjZTZEUxUE12SU1VdHhubldv?=
 =?utf-8?B?TWo3TzBrd2sydEV0NG1FMGVwRUxEcFl6ZXB6eFZ3enZhbTR4aFBJci9Hak1w?=
 =?utf-8?B?eVlsaE9PeEc0d20wcVdTekxiU1hWbkpjUmZMR0h0aDNib3hTMXNpendWcGYv?=
 =?utf-8?B?b0hNb3M2dEw4K1A2d1RHR3c2N0RTVTdvbk5Ka002ZXRvNXJ4dzVYWC9ZTCt1?=
 =?utf-8?B?RHNGeFZ1U2F5MEU0WTg3dW5FdVg1dS9sc2U2Q2x5VmJIOGF1SFJiY2tiSndl?=
 =?utf-8?B?SFN6VndsOU1Cei9pckRrbDFGcjBiQ2xjM05qQ3RXeWpFOEtnNHZNV2VZZVc1?=
 =?utf-8?B?OGptTlBrbFVwdVRSSXVaaVNpcEhSbEFYRmpBS0gzdW1yMWFJY3JmbG56Q09I?=
 =?utf-8?B?OUtpcHFJTVhqbFc5NkJLRG9hR3IvZ0xiM3JHU0ZrQzNjNnhickpLTmpQS3Bj?=
 =?utf-8?B?YnU1dWh5LzN5RHdKM3NNR016aTNJMm1JalR1N0pKNjVnTk1VYWlVMUFDWDls?=
 =?utf-8?B?YWI3a3JIcEdvZHJHWitLRG9jYjNoUHFkOUlWWEFnSU9DUnVmbG1UK2J3djlO?=
 =?utf-8?B?U3kzQ0dIc3hFaGgrcmd1QVZZRHJoMW5makJyNzhzZHlwQjV3RVJObEc1cVI0?=
 =?utf-8?B?K0hCc0k5bytqS0d2YkpabkQyVFRYdWUyVnlPQktOSzNmby93OUJHK1F3VGxV?=
 =?utf-8?B?d0VqaEJyYTJiQU9vOXZORlV1M3F3U3NJSTViU3VhRFIvb0dyZzFQYVI1TmVY?=
 =?utf-8?B?R2NybDM5elc1ZDQ1QUVRNGpvcCtuZFJTS1VLWi91Z2V0d1ZrTEhaRWI3MWFh?=
 =?utf-8?B?Wm1pcFp6dFlsQ0Y2M3YyREdETUtiekRHcTVrdEhKNnV2SlZvOHBqUjFYRzZJ?=
 =?utf-8?B?OHE0Ym9oUkZoSkhyN2V0SmdQR3UrTkZaTjRPUEJWUktOeGkxQlB2RW9OMWp0?=
 =?utf-8?B?ZXRIWWgzeVFzMU03dTdwQVRsdEpLVGRxOW1aZ3hja2s1VXU4b09uSmw4MHNF?=
 =?utf-8?Q?F+5xnq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 17:26:53.2023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0358b5cb-427f-4de5-b855-08ddf60f64d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279



On 9/12/2025 10:14 AM, Jonathan Cameron wrote:
> On Wed, 30 Jul 2025 16:47:05 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add the CXL isolation service, which will provide the necessary
>> information to the PCIe portdrv and CXL drivers to map, setup, and
>> handle CXL isolation interrupts.
>>
>> Add functions to get the CXL isolation MSI/-X interrupt vector
>> from the PCIe portdrv.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> Hmm. I feel a bit guilty I haven't gotten back to a rework of the
> portdrv.  To potentially make that easier (when I or someone else
> get the time), would it work for you if this only did MSI-X?
> That would let us handle this in a somewhat 'pluggable' way without
> having to deal with the limitations of MSI wrt to dynamic interrupt
> allocation.

No need to feel guilt, the latest AMD processors use MSI for this functionality.
Relevant /proc/interrupts output on my Turin box:

 41: <trim> 0 IR-PCI-MSI-0000:e0:01.1    0-edge      PCIe PME, PCIe bwctrl, cxl_isolation

So it looks like I'm stuck with doing this weird dance between the portdrv and cxl drivers
and the resulting module dependency.

> 
>> ---
>>  drivers/cxl/Kconfig              | 14 +++++
>>  drivers/cxl/cxl.h                |  4 ++
>>  drivers/pci/pcie/Makefile        |  1 +
>>  drivers/pci/pcie/cxl_isolation.c | 87 ++++++++++++++++++++++++++++++++
>>  drivers/pci/pcie/portdrv.c       |  1 +
>>  drivers/pci/pcie/portdrv.h       | 18 ++++++-
>>  6 files changed, 124 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/pci/pcie/cxl_isolation.c
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 57274de54a45..537e1e8e13da 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -247,4 +247,18 @@ config CXL_NATIVE_RAS
>>  	  If unsure, or if this kernel is meant for production environments,
>>  	  say Y.
>>  
>> +config CXL_ISOLATION
>> +	bool "CXL.mem Isolation Support"
>> +	depends on PCIEPORTBUS
>> +	depends on CXL_BUS=PCIEPORTBUS
>> +	help
>> +	  Enables the CXL.mem isolation PCIe port bus service driver. This
>> +	  driver, in combination with the CXL driver core, is responsible
>> +	  for managing CXL-capable PCIe root ports that undergo CXL.mem
>> +	  error isolation due to either a CXL.mem transaction timeout or
>> +	  link down condition. Without error isolation, either of these
>> +	  conditions will trigger a system reset.
>> +
>> +	  If unsure say 'y'
> I'd drop this last line or say something more about when it makes sense to enable.
> 

Ok, will do.

> 
>> diff --git a/drivers/pci/pcie/cxl_isolation.c b/drivers/pci/pcie/cxl_isolation.c
>> new file mode 100644
>> index 000000000000..550f16271d1c
>> --- /dev/null
>> +++ b/drivers/pci/pcie/cxl_isolation.c
>> @@ -0,0 +1,87 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * The CXL Isolation PCIe port service driver provides functions to allocate
>> + * and set up CXL Timeout & Isolation interrupts (CXL 3.2 12.3). This driver
>> + * does no actual interrupt handling, it only provides the information for
>> + * the CXL driver to set up its own handling because the CXL driver is better
>> + * equipped to handle isolation interrupts.
>> + *
>> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> + */
>> +
>> +#include <linux/pci.h>
>> +
>> +#include "../../cxl/cxlpci.h"
>> +#include "portdrv.h"
>> +
>> +static int get_isolation_intr_vec(u32 cap)
>> +{
>> +	if (!FIELD_GET(CXL_ISOLATION_CAP_INTR_SUPP, cap) ||
>> +	    !FIELD_GET(CXL_ISOLATION_CAP_MEM_ISO_SUPP, cap))
>> +		return -ENXIO;
>> +
>> +	return FIELD_GET(CXL_ISOLATION_CAP_INTR_MASK, cap);
>> +}
>> +
>> +int pcie_cxliso_get_intr_vec(struct pci_dev *dev, int *vec)
>> +{
>> +	struct cxl_component_regs regs;
>> +	struct cxl_register_map map;
>> +	u32 cap;
>> +	int rc;
>> +
>> +	rc = cxl_find_regblock(dev, CXL_REGLOC_RBI_COMPONENT, &map);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_setup_regs(&map);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (!map.component_map.isolation.valid)
>> +		return -ENXIO;
>> +
> 
> Add some comments here on why we go through this dance of temporary mapping.
> (I have similar for the CPMU code I never finished upstreaming).
> 

Ok.

>> +	rc = cxl_map_component_regs(&map, &regs,
>> +				    BIT(CXL_CM_CAP_CAP_ID_ISOLATION));
>> +	if (rc)
>> +		return rc;
>> +
>> +	cap = readl(regs.isolation + CXL_ISOLATION_CAPABILITY_OFFSET);
>> +	rc = get_isolation_intr_vec(cap);
>> +	if (rc < 0) {
> 
> Probably use a goto given common shared stuff to do on exit.
> 

Sure!

>> +		cxl_unmap_component_regs(&map, &regs,
>> +					 BIT(CXL_CM_CAP_CAP_ID_ISOLATION));
>> +		return rc;
>> +	}
>> +
>> +	if (vec)
>> +		*vec = rc;
>> +
>> +	cxl_unmap_component_regs(&map, &regs, BIT(CXL_CM_CAP_CAP_ID_ISOLATION));
>> +	return 0;
>> +
>> +}
>> +
>> +static int cxl_isolation_probe(struct pcie_device *dev)
>> +{
>> +	if (!pcie_is_cxl(dev->port) || pcie_cxliso_get_intr_vec(dev->port, NULL))
> The second call has rich error codes so better not to eat them.
> 

Ok.

> 	if (!pcie_is_cxl(dev->port))
> 		return -ENXIO;
> 
> 	rc = pcie_cxl_iso_get_intr_vec();
> 	if (rc)
> 		return rc;
> 
>> +		return -ENXIO;
>> +
>> +	pci_info(dev->port, "CXLISO: Signaling with IRQ %d\n", dev->irq);
> I guess there is history of this for other portdrv services, but to me too noisy
> for a normal boot and should be trivial to get from /proc/interrupts

I just went with what the rest of the portdrv services were doing. I'll drop it to
a pci_dbg() instead of just deleting it for parity.

> 
>> +	return 0;
>> +}
> 


