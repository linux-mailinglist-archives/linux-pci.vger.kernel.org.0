Return-Path: <linux-pci+bounces-35681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45F3B495E6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 18:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EB137B7F42
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 16:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBB730F816;
	Mon,  8 Sep 2025 16:41:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022130.outbound.protection.outlook.com [40.107.75.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CA4213236;
	Mon,  8 Sep 2025 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349708; cv=fail; b=mG4nLvheSPh8jPUXygawiLZcPgrvmU4eLMAhiGB8FkWGARzskaj426yvr9Ru9NVZJJVRR/LQOj48/jolxZg2WK0dcIAjwiARGHVdDD0nY3ExUrsIq9mWY8MI2Z93iM9yX7LIBAsWykiQVWILSGymFE+8ZY4zQqWk3H8lv5+shbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349708; c=relaxed/simple;
	bh=swvJEmhi+w0PCWwaffCTOYuaLtz3N673xgAkrXE1DpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6+OO2oG8GSUKX3B985FT2+DPHe03AJOzR2g5bl1f7bgUxvKfcooM7lDPWrDtEHwc7F6Uu6vzp7K3AgPo+jbxnE6OPvdHrIBXxrgH5GaXbOaHV+olaGhWejyXF+lh4FGJIiQX0VmfZPBHB+6XtN7uacLWjl88f0XNkBYyZ2pimk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/lSOTXUenFbk8as2edpnqGC5IFCA28C3veTTppe8mwySWD1ZmFdE+FAYVPKadplkC65igR1hwd249s3K7gKESsnG/TMpHuY6NsY6PMwO1lXksKGFe9lpQ3dRImMxHGv6n2nGnWCmMY8zQ9jueT9Y9p8qexIYltJaDYlJCIzNwpVO6IGNn+ezLm9cRfiXWm+2sIxBQW2B5MXTs+3z+FVoAI0Mir3lwP8UjdROlKoEwf7h/T6wgpEeg7vQSFy7jYhpAGQZJ9CFRp/uQtyKXxCG3KApMMEurZ4mCx5D10oGm2OUaZdGqhNd83no64XRn+uX+0V0ak+4gqNPzq855TsoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDNy0Yuc9HHyclA2VINFzwPL5W1bgBNHGq1ogoozCNE=;
 b=D5VMpgxrnkVE/QzpfseBE0umggJbaRh3b3InYzNxTpPorLD7zivEy8h/3nddD4DiZWVeDKj+lrbSHG9TlaXCWbWDPssk5d4UISdt8xqSHJyuGDSFUub5IkY19eo7lZfC/nL3sN4PCGPnfM/unlId0/yGwa5fnpPLGLXg/Vg+Br3y835i7UztR083vVcLtHrbP212rj5kwiDby/LIybc/G/hK2TnEedchnvhzoySs9CLfph8LhWjzH87cvZXbDgJYj5Sd54BGcMJD33pJfaP9pVw+JW5ufYJ/IFsBEo/QSSXKlzlZkbxugc8WCT472UxlRZV/Y7VeH/72RVvUg6np7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::25) by KL1PR06MB6069.apcprd06.prod.outlook.com
 (2603:1096:820:de::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:41:39 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:300:2d:cafe::f2) by PS2PR01CA0013.outlook.office365.com
 (2603:1096:300:2d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 16:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:41:37 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 5542B40A5A13;
	Tue,  9 Sep 2025 00:41:36 +0800 (CST)
Message-ID: <5afb25b2-a3ca-4afe-9826-e1d722599ee1@cixtech.com>
Date: Tue, 9 Sep 2025 00:41:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/14] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com,
 guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
 <20250901092052.4051018-8-hans.zhang@cixtech.com>
 <yl5mty7uz3fneyxyeacydbu2l7ptngt2ah7roybxza6vtjvs3s@fobe3kl76msw>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <yl5mty7uz3fneyxyeacydbu2l7ptngt2ah7roybxza6vtjvs3s@fobe3kl76msw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|KL1PR06MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a83d8d1-2c83-4a5a-62f2-08ddeef69475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzRZd2xIdjljYzhudnFuNHNyTUFaUHZzMDhYcjR6a2F3UE0zKzg1dFR6Z1kx?=
 =?utf-8?B?ZGpodC9oYWNWMEFJK2E0UHNVdFY4YlY2dGlxckpRTDgzTUwyTGxCNGhnVTY5?=
 =?utf-8?B?amtEUGtjMFNJMU9PcURxOXl2cHdFeEMyS2FtelpYQzFiVWtiTVVhWlBrU3R0?=
 =?utf-8?B?TmE2cWk5OEw5NU92MGNNdmY1MEZIT0tQUG42RUJSNWUwM3NucFh0RzNreXVI?=
 =?utf-8?B?MUM4aVZUSXIrV05lVHFmMEsvVWN5N0lOd3lQU2ZPT011b0ZrdmZHM2hWay9k?=
 =?utf-8?B?ZTVLUkZES3JOcVJKK3NYUVRIQzFFcmxKTHg4elIzVDM5WW9abGVyVkdleWkv?=
 =?utf-8?B?Z21vSGUrMmQ4bnltSDh1NDJwNVp4Q3lESDIwZklRYmZLTjRXRnJCamdya2RR?=
 =?utf-8?B?bHpDV0JLQ1JMeVdLVWtiS0JVeTRHR25PVUVvWXY3NFR2c0xGNHc1bHRMVklZ?=
 =?utf-8?B?QmVqcmNNN2Z0NXp6M2h1R3NER1NIeFFpdDVJVXVnU2tRa1c3MFd2b1N1Q3FD?=
 =?utf-8?B?Y3NjSXhHdEhpeHd6VUFybjhQaUNJTS9UU0dVWkV3TmlZcTJ3Qi9xUGRpbWF3?=
 =?utf-8?B?cmJ0QUxQaVZPVDYxN2JoNXd6NFZXOTE0WGVMTlRoL3ErZTB6ODRSQy9ITmZF?=
 =?utf-8?B?NXFWTjhDSGkzVG92clREc2xVMGxRc04vaDg2NHdXWXNSdlNEdVJGOXZEMDBz?=
 =?utf-8?B?d2hYQ1BRQTJrbW50aE1lR2MrdUk1SnIyMEpTRk81UnA3SXpFK0ZDNklGVnNq?=
 =?utf-8?B?RFRTYzA4ZldGSlpRTmR5eExkVjVydldkSEpySENDTWR3clJwa1BCM1M5Umtp?=
 =?utf-8?B?anZJRDVuU1AwbEx3TFJBMWJrK3o0elY1YVVzMU52b3dtU3Z0dTl0OGxEK0ph?=
 =?utf-8?B?SElpKzRrWms1VFVzQ3ZpTG9kQ0Y2QVhuQWJRY0hHQlZEeG95dTBNUS9qN0RR?=
 =?utf-8?B?MzM0SEY1azVLZ1NJVTVFOGFHZ2N0dXgxVjJYLy9CQzU1S1NkVUNMQjJ5SDNP?=
 =?utf-8?B?dVI0bmZ5WkErM3lqdm5IVDVOekRyU3QxUDVhL01ib3l2TDdwcDlTYm1xTjkv?=
 =?utf-8?B?Q2p0MFE2RUZVcW80TUZNaTJBN3dZeElvVGxUcENRcFBXSXRjdGFsZ2tRWTNx?=
 =?utf-8?B?Z1JVcmo4UC9xaWlKSVJmMGZIUXNOVFZBUE45a29ZaTRnb05UQlE1YStjVGFS?=
 =?utf-8?B?Yy9rMVhRMEYvdW1jdUtNQlltRW9WY09SM0xRT0lTTGtvMVZ2ZXowOG5MazFU?=
 =?utf-8?B?NXdwaTlNNnBOZWlYdlBuaUVZVm9ENzc4L0dIVXFCT09jUk9PdXFLUXRlUXli?=
 =?utf-8?B?UVJWUTZ5T2hKSzJaL0twaUorRzdhMXVOaldMRGFIamljOEpRS1R5UkQ2Q1pK?=
 =?utf-8?B?c05vemJSUWVKV3NkZUJmZTk4UE1MaEU2WFBkN0kvTHYrVXJReGQ3VVg0N0lt?=
 =?utf-8?B?U21DMWlKTWt4aTJhZGUwRmNYUExITkU0TUw3elluS1RxMmwrcHNIMG1EaE1X?=
 =?utf-8?B?V3BkdmRtYkFIOTN3RGJQeHQ2OVVXc0todnpjVkJrZUIwY3NvVDF2RmFwQy8v?=
 =?utf-8?B?M251a1VvL1BWYm5rNXRLaXBGQ1NLS01PVVBvdHlZeEM0VktsK3VlUVFYTXUr?=
 =?utf-8?B?eC9UYzJEZjdpYjNmTCtOVWhoTXVuVXlXWnp0UkhhVmNqaWZ0eEI4S1VWRlRS?=
 =?utf-8?B?UnhRTXRYRzVMdE9zZ1BkekNVT2VLL2RvZ2tueGNpRm1TZHAxN1ZPNmdVZ2lq?=
 =?utf-8?B?UDRxWlhobmduWGpGVWJRUUpmeWdDeURCQUhEZU4zOElKTEJ5YzBJUEJzMHh5?=
 =?utf-8?B?dHBzS3FlSmwzVW5oY1ZkNm12S0VWcnBGZ2JzUHN2WCs5dUVzQ0tnQjlUbUNt?=
 =?utf-8?B?bUpyQjBvSUpZOTlZRWMrNEkzQnFYd01Pam9rS2g0R0dTNlNGS1VMUExNVjdI?=
 =?utf-8?B?M3poMlZzL0hoSFRIcHJOMEsyQy9nZWtYTnZCUmx3b3V5THVnWGMxVGJwQU5R?=
 =?utf-8?B?QlgvOEtaSDFvRFRJelhvYVB0eFF1aGRlb2JORXdqSzNLQUJWYS9vMjIvQ3Fq?=
 =?utf-8?Q?hP63sD?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:41:37.4071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a83d8d1-2c83-4a5a-62f2-08ddeef69475
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6069



On 2025/9/8 19:28, Manivannan Sadhasivam wrote:
> EXTERNAL EMAIL
> 
> On Mon, Sep 01, 2025 at 05:20:45PM GMT, hans.zhang@cixtech.com wrote:
>> From: Manikandan K Pillai <mpillai@cadence.com>
>>
>> Add support for Cadence PCIe RP and EP configuration for High
>> Performance Architecture (HPA) controllers. The Cadence High Performance
>> controllers are the latest PCIe controllers that have support for DMA,
>> optional IDE and updated register set.
>>
>> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
>> Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> ---
>>   drivers/pci/controller/cadence/Makefile       |  11 +-
>>   .../cadence/pcie-cadence-host-hpa.c           | 579 ++++++++++++++++++
>>   .../pci/controller/cadence/pcie-cadence-hpa.c | 205 +++++++
>>   drivers/pci/controller/cadence/pcie-cadence.c |  11 +
>>   drivers/pci/controller/cadence/pcie-cadence.h |  75 ++-
>>   5 files changed, 872 insertions(+), 9 deletions(-)
>>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa.c
>>
>> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
>> index e45f72388bbb..ee3bd0a69b5c 100644
>> --- a/drivers/pci/controller/cadence/Makefile
>> +++ b/drivers/pci/controller/cadence/Makefile
>> @@ -1,6 +1,11 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> -obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
>> -obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-common.o pcie-cadence-host.o
>> -obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-common.o pcie-cadence-ep.o
>> +
>> +pcie-cadence-mod-y := pcie-cadence-hpa.o pcie-cadence.o
>> +pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-cadence-host-hpa.o
>> +pcie-cadence-ep-mod-y := pcie-cadence-ep-common.o pcie-cadence-ep.o
>> +
>> +obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
>> +obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
>> +obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
>>   obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>>   obj-$(CONFIG_PCI_J721E) += pci-j721e.o
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>> new file mode 100644
>> index 000000000000..9e47b1bf41d7
>> --- /dev/null
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>> @@ -0,0 +1,579 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Cadence PCIe host controller driver.
>> + *
>> + * Copyright (c) 2019, Cadence Design Systems
> 
> Really? Is this driver developed in 2019? Just making sure it is not a typo.
> 
>> + * Author: Manikandan K Pillai <mpillai@cadence.com>
>> + */
>> +#include <linux/delay.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list_sort.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_pci.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "pcie-cadence.h"
>> +#include "pcie-cadence-host-common.h"
>> +
>> +static u8 bar_aperture_mask[] = {
>> +     [RP_BAR0] = 0x1f,
>> +     [RP_BAR1] = 0x0f,
>> +};
>> +
>> +void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn,
>> +                                int where)
>> +{
>> +     struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
>> +     struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
>> +     struct cdns_pcie *pcie = &rc->pcie;
>> +     unsigned int busn = bus->number;
>> +     u32 addr0, desc0, desc1, ctrl0;
>> +     u32 regval;
>> +
>> +     if (pci_is_root_bus(bus)) {
>> +             /*
>> +              * Only the root port (devfn == 0) is connected to this bus.
>> +              * All other PCI devices are behind some bridge hence on another
>> +              * bus.
>> +              */
>> +             if (devfn)
>> +                     return NULL;
>> +
>> +             return pcie->reg_base + (where & 0xfff);
>> +     }
>> +
>> +     /* Clear AXI link-down status */
>> +     regval = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN,
>> +                          (regval & ~GENMASK(0, 0)));
>> +
>> +     desc0 = 0;
>> +     desc1 = 0;
>> +     ctrl0 = 0;
> 
> I don't think you need to 0 initialize there variables.
> 
>> +
>> +     /* Update Output registers for AXI region 0 */
>> +     addr0 = CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
>> +             CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
>> +             CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(busn);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0), addr0);
>> +
>> +     desc1 = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
>> +                                 CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0));
>> +     desc1 &= ~CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK;
>> +     desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
>> +     ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
>> +             CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
>> +
>> +     if (busn == bridge->busnr + 1)
>> +             desc0 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
> 
> You can directly assign 'desc0' here and below.
> 
>> +     else
>> +             desc0 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
>> +
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), desc0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), ctrl0);
>> +
>> +     return rc->cfg_base + (where & 0xfff);
>> +}
>> +
>> +int cdns_pcie_hpa_host_wait_for_link(struct cdns_pcie *pcie)
>> +{
>> +     struct device *dev = pcie->dev;
>> +     int retries;
>> +
>> +     /* Check if the link is up or not */
>> +     for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>> +             if (cdns_pcie_hpa_link_up(pcie)) {
>> +                     dev_info(dev, "Link up\n");
>> +                     return 0;
>> +             }
>> +             usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>> +     }
>> +     return -ETIMEDOUT;
>> +}
>> +EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_wait_for_link);
> 
> I don't see an user for this API in this series. So make it static.
> 
>> +
>> +int cdns_pcie_hpa_host_start_link(struct cdns_pcie_rc *rc)
> 
> This function is not starting the link, but waiting for link up. So I guess you
> can move the retrain part to cdns_pcie_hpa_host_wait_for_link() and drop this
> function altogether.
> 
>> +{
>> +     struct cdns_pcie *pcie = &rc->pcie;
>> +     int ret;
>> +
>> +     ret = cdns_pcie_hpa_host_wait_for_link(pcie);
>> +
>> +     /* Retrain link for Gen2 training defect if quirk flag is set */
> 
> Drop this comment as the flag is self explanatory.
> 
>> +     if (!ret && rc->quirk_retrain_flag)
>> +             ret = cdns_pcie_retrain(pcie);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_start_link);
> 
> Same here. I do see many APIs getting exported without users. Maybe these are
> the remnants of the dropping EP driver in this version. Make them static.
> 
>> +
>> +static struct pci_ops cdns_pcie_hpa_host_ops = {
>> +     .map_bus        = cdns_pci_hpa_map_bus,
>> +     .read           = pci_generic_config_read,
>> +     .write          = pci_generic_config_write,
>> +};
>> +
>> +static void cdns_pcie_hpa_host_enable_ptm_response(struct cdns_pcie *pcie)
>> +{
>> +     u32 val;
>> +
>> +     val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_LM_PTM_CTRL);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_LM_PTM_CTRL,
>> +                          val | CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN);
>> +}
>> +
>> +static int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
>> +                                         enum cdns_pcie_rp_bar bar,
>> +                                         u64 cpu_addr, u64 size,
>> +                                         unsigned long flags)
>> +{
>> +     struct cdns_pcie *pcie = &rc->pcie;
>> +     u32 addr0, addr1, aperture, value;
>> +
>> +     if (!rc->avail_ib_bar[bar])
>> +             return -EBUSY;
> 
> -ENOMEM or -ENODEV?
> 
>> +
>> +     rc->avail_ib_bar[bar] = false;
>> +
>> +     aperture = ilog2(size);
>> +     addr0 = CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(aperture) |
>> +             (lower_32_bits(cpu_addr) & GENMASK(31, 8));
>> +     addr1 = upper_32_bits(cpu_addr);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
>> +                          CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar), addr0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
>> +                          CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar), addr1);
>> +
>> +     if (bar == RP_NO_BAR)
>> +             return 0;
> 
> Are you sure that you want to check for RP_NO_BAR in the middle and not at the
> start?
> 
>> +
>> +     value = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_CFG_CTRL_REG, CDNS_PCIE_HPA_LM_RC_BAR_CFG);
>> +     value &= ~(HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
>> +                HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
>> +                HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
>> +                HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
>> +                HPA_LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
>> +     if (size + cpu_addr >= SZ_4G) {
>> +             if (!(flags & IORESOURCE_PREFETCH))
>> +                     value |= HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
>> +             value |= HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
>> +     } else {
>> +             if (!(flags & IORESOURCE_PREFETCH))
>> +                     value |= HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
>> +             value |= HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
>> +     }
>> +
>> +     value |= HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
>> +
>> +     return 0;
>> +}
>> +
>> +static int cdns_pcie_hpa_host_bar_config(struct cdns_pcie_rc *rc,
>> +                                      struct resource_entry *entry)
> 
> Since the CSKY platform is not defining any 'dma-ranges' in binding, this whole
> code related to setting up the IB mapping becomes dead code. I know that this is
> a generic cadence library. But still dead code is of no use to anyone.
> 
> So please drop it now and add whenever a controller implementation that makes
> use of it gets added.
> 
>> +{
>> +     u64 cpu_addr, pci_addr, size, winsize;
>> +     struct cdns_pcie *pcie = &rc->pcie;
>> +     struct device *dev = pcie->dev;
>> +     enum cdns_pcie_rp_bar bar;
>> +     unsigned long flags;
>> +     int ret;
>> +
>> +     cpu_addr = entry->res->start;
>> +     pci_addr = entry->res->start - entry->offset;
>> +     flags = entry->res->flags;
>> +     size = resource_size(entry->res);
>> +
>> +     if (entry->offset) {
>> +             dev_err(dev, "PCI addr: %llx must be equal to CPU addr: %llx\n",
>> +                     pci_addr, cpu_addr);
>> +             return -EINVAL;
>> +     }
>> +
>> +     while (size > 0) {
>> +             /*
>> +              * Try to find a minimum BAR whose size is greater than
>> +              * or equal to the remaining resource_entry size. This will
>> +              * fail if the size of each of the available BARs is less than
>> +              * the remaining resource_entry size.
>> +              *
>> +              * If a minimum BAR is found, IB ATU will be configured and
>> +              * exited.
>> +              */
>> +             bar = cdns_pcie_host_find_min_bar(rc, size);
>> +             if (bar != RP_BAR_UNDEFINED) {
>> +                     ret = cdns_pcie_hpa_host_bar_ib_config(rc, bar, cpu_addr,
>> +                                                            size, flags);
>> +                     if (ret)
>> +                             dev_err(dev, "IB BAR: %d config failed\n", bar);
>> +                     return ret;
>> +             }
>> +
>> +             /*
>> +              * If the control reaches here, it would mean the remaining
>> +              * resource_entry size cannot be fitted in a single BAR. So we
>> +              * find a maximum BAR whose size is less than or equal to the
>> +              * remaining resource_entry size and split the resource entry
>> +              * so that part of resource entry is fitted inside the maximum
>> +              * BAR. The remaining size would be fitted during the next
>> +              * iteration of the loop.
>> +              *
>> +              * If a maximum BAR is not found, there is no way we can fit
>> +              * this resource_entry, so we error out.
>> +              */
>> +             bar = cdns_pcie_host_find_max_bar(rc, size);
>> +             if (bar == RP_BAR_UNDEFINED) {
>> +                     dev_err(dev, "No free BAR to map cpu_addr %llx\n",
>> +                             cpu_addr);
>> +                     return -EINVAL;
>> +             }
>> +
>> +             winsize = bar_max_size[bar];
>> +             ret = cdns_pcie_hpa_host_bar_ib_config(rc, bar, cpu_addr, winsize, flags);
>> +             if (ret) {
>> +                     dev_err(dev, "IB BAR: %d config failed\n", bar);
>> +                     return ret;
>> +             }
>> +
>> +             size -= winsize;
>> +             cpu_addr += winsize;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int cdns_pcie_hpa_host_map_dma_ranges(struct cdns_pcie_rc *rc)
>> +{
>> +     struct cdns_pcie *pcie = &rc->pcie;
>> +     struct device *dev = pcie->dev;
>> +     struct device_node *np = dev->of_node;
>> +     struct pci_host_bridge *bridge;
>> +     struct resource_entry *entry;
>> +     u32 no_bar_nbits = 32;
>> +     int err;
>> +
>> +     bridge = pci_host_bridge_from_priv(rc);
>> +     if (!bridge)
>> +             return -ENOMEM;
>> +
>> +     if (list_empty(&bridge->dma_ranges)) {
>> +             of_property_read_u32(np, "cdns,no-bar-match-nbits",
>> +                                  &no_bar_nbits);
>> +             err = cdns_pcie_hpa_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
>> +                                                    (u64)1 << no_bar_nbits, 0);
>> +             if (err)
>> +                     dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
>> +             return err;
>> +     }
>> +
>> +     list_sort(NULL, &bridge->dma_ranges, cdns_pcie_host_dma_ranges_cmp);
>> +
>> +     resource_list_for_each_entry(entry, &bridge->dma_ranges) {
>> +             err = cdns_pcie_hpa_host_bar_config(rc, entry);
>> +             if (err) {
>> +                     dev_err(dev, "Fail to configure IB using dma-ranges\n");
>> +                     return err;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
>> +{
>> +     struct cdns_pcie *pcie = &rc->pcie;
>> +     u32 value, ctrl;
>> +
>> +     /*
>> +      * Set the root complex BAR configuration register:
> 
> root complex or Root Port?
> 
>> +      * - disable both BAR0 and BAR1
>> +      * - enable Prefetchable Memory Base and Limit registers in type 1
>> +      *   config space (64 bits)
>> +      * - enable IO Base and Limit registers in type 1 config
>> +      *   space (32 bits)
>> +      */
>> +
>> +     ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED;
>> +     value = CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(ctrl) |
>> +             CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(ctrl) |
>> +             CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE |
>> +             CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS |
>> +             CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE |
>> +             CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS;
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG,
>> +                          CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
>> +
>> +     if (rc->vendor_id != 0xffff)
>> +             cdns_pcie_hpa_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);
>> +
>> +     if (rc->device_id != 0xffff)
>> +             cdns_pcie_hpa_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
>> +
>> +     cdns_pcie_hpa_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
>> +     cdns_pcie_hpa_rp_writeb(pcie, PCI_CLASS_PROG, 0);
>> +     cdns_pcie_hpa_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
>> +
>> +     return 0;
>> +}
>> +
>> +static void cdns_pcie_hpa_create_region_for_ecam(struct cdns_pcie_rc *rc)
>> +{
>> +     struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
>> +     struct resource *cfg_res = rc->cfg_res;
>> +     struct cdns_pcie *pcie = &rc->pcie;
>> +     u32 value, root_port_req_id_reg, pcie_bus_number_reg;
> 

Dear Mani,

Thank you very much for your reply. This function is a new one I added 
during my collaboration with Manikandan. Here I'll reply to you. Other 
Manikandan will reply to you.

> rp_bdf, rc_bus_nr

Will change.

> 
>> +     u32 ecam_addr_0, region_size_0, request_id_0;
> 
> So ECAM address is always 32bit? For all Cadence IP implementations?

Sorry, it's my fault here. Since the ECAM distribution of CIX SKY1 is as 
follows:

X8: 0x2c00_0000 ~ 0x3000_0000
X4: 0x2900_0000 ~ 0x2c00_0000
X2: 0x2600_0000 ~ 0x2900_0000
X1_1: 0x2300_0000 ~ 0x2600_0000
X1_0: 0x2000_0000 ~ 0x2300_0000

This is only the CIX SKY1 designed in the low 32-bit address range. In 
fact, Cadence IP supports 64-bit ECAM addresses. Will change.


> 
>> +     int busnr = 0, secbus = 0, subbus = 0;
>> +     struct resource_entry *entry;
>> +     resource_size_t size;
>> +     u32 axi_address_low;
>> +     int nbits;
>> +     u64 sz;
>> +
>> +     entry = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
>> +     if (entry) {
>> +             busnr = entry->res->start;
>> +             secbus = (busnr < 0xff) ? (busnr + 1) : 0xff;
>> +             subbus = entry->res->end;
>> +     }
>> +     size = resource_size(cfg_res);
>> +     sz = 1ULL << fls64(size - 1);
>> +     nbits = ilog2(sz);
>> +     if (nbits < 8)
>> +             nbits = 8;
>> +
>> +     root_port_req_id_reg = ((busnr & 0xff) << 8);
>> +     pcie_bus_number_reg = ((subbus & 0xff) << 16) | ((secbus & 0xff) << 8) |
>> +                           (busnr & 0xff);
>> +     ecam_addr_0 = cfg_res->start;
> 
> Doesn't the platform require 'cfg_res->start' to be aligned to 256 MiB? The bus
> range seem to be 0xff, so the Cadence IP allocates 8 bits for 'bus'. As per the
> PCIe spec r6.0, sec 7.2.2, says:
> 
> 'the base address of the range is aligned to a 2(n+20)-byte memory address
> boundary'
> 
> So the 'cfg_res->start' should be aligned to 2^28 byte (256 MiB) address.
> 

Just as the ECAM address range mentioned above, our bus is not 0xff. 
Therefore, aligned to 2^28 byte (256 MiB) address is not required.

X8: 0xc0 ~ 0xff
X4: 0x90 ~ 0xbf
X2: 0x60 ~ 0x8f
X1_1: 0x30 ~ 0x5f
X1_0: 0x00 ~ 0x2f

>> +     region_size_0 = nbits - 1;
>> +     request_id_0 = ((busnr & 0xff) << 8);
>> +
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_TAG_MANAGEMENT, 0x200000);
>> +
>> +     /* Taking slave err as OKAY */
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_SLAVE_RESP,
>> +                          0x0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_SLAVE_RESP + 0x4, 0x0);
>> +
>> +     /* Program the register "i_root_port_req_id_reg" with RP's BDF */
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, I_ROOT_PORT_REQ_ID_REG,
>> +                          root_port_req_id_reg);
>> +
>> +     /**
>> +      * Program the register "i_pcie_bus_numbers" with Primary(RP's bus number),
>> +      * secondary and subordinate bus numbers
>> +      */
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_RP, I_PCIE_BUS_NUMBERS,
>> +                          pcie_bus_number_reg);
>> +
>> +     /* Program the register "lm_hal_sbsa_ctrl[0]" to enable the sbsa */
>> +     value = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, LM_HAL_SBSA_CTRL);
>> +     value |= BIT(0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, LM_HAL_SBSA_CTRL, value);
>> +
>> +     /* Program region[0] for ECAM */
>> +     axi_address_low = (ecam_addr_0 & 0xfff00000) | region_size_0;
> 
> Could you explain what is getting programmed and why?

Cadence IP register description:

Region Base Address [31:8] (24 bits)
Lower [31:8] bits of the AXI region base address.

Region Size (6 bits)
The programme value in this field + 1 gives the region size. Minimum 
value to be programmed into this field is 7 as the lower 8 bits of the 
AXI region base address are replaced by zeros by the region select 
logic. Minumum supported region size is 256 bytes.


The original intention of ecam_addr_0 & 0xfff00000 is to align with 1MB. 
This is clearly redundant, as one Bus alone requires a 1MB ECAM range.

Will delete & 0xfff00000.

Here it refers to CPU address.

> 
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(0),
>> +                          axi_address_low);
>> +
>> +     /* rc0-high-axi-address */
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(0), 0x0);
>> +     /* Type-1 CFG */
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), 0x05000000);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0),
>> +                          (request_id_0 << 16));
>> +
>> +     /* All AXI bits pass through PCIe */
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0), 0x1b);
>> +     /* PCIe address-high */
> 
> What is this address?

Cadence IP register description:

AXI to PCIe Address Translation
AXI Slave to PCIe Address Translation registers. Provides bits 31:8 of 
the PCIe address and the number of AXI address bits passed through.

The annotations here will be changed to:  /* AXI to PCIe Address 
Translation */


Here it refers to PCI address.

Note: Cadence IP's region is somewhat similar to Synopsys IP's iATU.

Best regards,
Hans

> 
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(0), 0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), 0x06000000);
>> +}
>> +
>> +static void cdns_pcie_hpa_create_region_for_cfg(struct cdns_pcie_rc *rc)
>> +{
>> +     struct cdns_pcie *pcie = &rc->pcie;
>> +     struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
>> +     struct resource *cfg_res = rc->cfg_res;
>> +     struct resource_entry *entry;
>> +     u64 cpu_addr = cfg_res->start;
>> +     u32 addr0, addr1, desc1;
>> +     int busnr = 0;
>> +
>> +     entry = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
>> +     if (entry)
>> +             busnr = entry->res->start;
>> +
>> +     /*
>> +      * Reserve region 0 for PCI configure space accesses:
>> +      * OB_REGION_PCI_ADDR0 and OB_REGION_DESC0 are updated dynamically by
>> +      * cdns_pci_map_bus(), other region registers are set here once for all
>> +      */
>> +     addr1 = 0;
> 
> No need to initalize addr1 if you pass 0 to
> CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1() directly. Initializing it causes slight
> confusion.
> 
>> +     desc1 = CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(0), addr1);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
>> +
>> +     addr0 = CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
>> +             (lower_32_bits(cpu_addr) & GENMASK(31, 8));
>> +     addr1 = upper_32_bits(cpu_addr);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(0), addr0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(0), addr1);
>> +}
>> +
>> +static int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc)
>> +{
>> +     struct cdns_pcie *pcie = &rc->pcie;
>> +     struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
>> +     struct resource_entry *entry;
>> +     int r = 0, busnr = 0;
>> +
>> +     if (rc->ecam_supported)
>> +             cdns_pcie_hpa_create_region_for_ecam(rc);
>> +     else
>> +             cdns_pcie_hpa_create_region_for_cfg(rc);
>> +
>> +     entry = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
>> +     if (entry)
>> +             busnr = entry->res->start;
>> +
>> +     r++;
>> +     if (pcie->msg_res)
>> +             cdns_pcie_hpa_set_outbound_region_for_normal_msg(pcie, busnr, 0, r,
>> +                                                              pcie->msg_res->start);
> 
> What is this MSG region for?
> 
>> +
>> +     r++;
>> +     resource_list_for_each_entry(entry, &bridge->windows) {
>> +             struct resource *res = entry->res;
>> +             u64 pci_addr = res->start - entry->offset;
>> +
>> +             if (resource_type(res) == IORESOURCE_IO)
>> +                     cdns_pcie_hpa_set_outbound_region(pcie, busnr, 0, r,
>> +                                                       true,
>> +                                                       pci_pio_to_address(res->start),
>> +                                                       pci_addr,
>> +                                                       resource_size(res));
>> +             else
>> +                     cdns_pcie_hpa_set_outbound_region(pcie, busnr, 0, r,
>> +                                                       false,
>> +                                                       res->start,
>> +                                                       pci_addr,
>> +                                                       resource_size(res));
>> +
>> +             r++;
> 
> Why do you need to increment 'r' here?
> 
>> +     }
>> +
>> +     if (rc->no_inbound_map)
>> +             return 0;
>> +     else
>> +             return cdns_pcie_hpa_host_map_dma_ranges(rc);
>> +}
>> +
>> +int cdns_pcie_hpa_host_init(struct cdns_pcie_rc *rc)
>> +{
>> +     int err;
>> +
>> +     err = cdns_pcie_hpa_host_init_root_port(rc);
>> +     if (err)
>> +             return err;
>> +
>> +     return cdns_pcie_hpa_host_init_address_translation(rc);
>> +}
>> +EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_init);
>> +
>> +int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
>> +{
>> +     struct cdns_pcie *pcie = &rc->pcie;
>> +     struct device *dev = rc->pcie.dev;
>> +     int ret;
>> +
>> +     if (rc->quirk_detect_quiet_flag)
>> +             cdns_pcie_hpa_detect_quiet_min_delay_set(&rc->pcie);
>> +
>> +     cdns_pcie_hpa_host_enable_ptm_response(pcie);
>> +
>> +     ret = cdns_pcie_start_link(pcie);
>> +     if (ret) {
>> +             dev_err(dev, "Failed to start link\n");
>> +             return ret;
>> +     }
>> +
>> +     ret = cdns_pcie_hpa_host_start_link(rc);
>> +     if (ret)
>> +             dev_dbg(dev, "PCIe link never came up\n");
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_link_setup);
>> +
>> +int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
>> +{
>> +     struct device *dev = rc->pcie.dev;
>> +     struct platform_device *pdev = to_platform_device(dev);
>> +     struct pci_host_bridge *bridge;
>> +     enum cdns_pcie_rp_bar bar;
>> +     struct cdns_pcie *pcie;
>> +     struct resource *res;
>> +     int ret;
>> +
>> +     bridge = pci_host_bridge_from_priv(rc);
>> +     if (!bridge)
>> +             return -ENOMEM;
>> +
>> +     pcie = &rc->pcie;
>> +     pcie->is_rc = true;
>> +
>> +     if (!pcie->reg_base) {
>> +             pcie->reg_base = devm_platform_ioremap_resource_byname(pdev, "reg");
>> +             if (IS_ERR(pcie->reg_base)) {
>> +                     dev_err(dev, "missing \"reg\"\n");
>> +                     return PTR_ERR(pcie->reg_base);
>> +             }
>> +     }
>> +
>> +     /* ECAM config space is remapped at glue layer */
>> +     if (!rc->cfg_base) {
>> +             res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
>> +             rc->cfg_base = devm_pci_remap_cfg_resource(dev, res);
>> +             if (IS_ERR(rc->cfg_base))
>> +                     return PTR_ERR(rc->cfg_base);
>> +             rc->cfg_res = res;
>> +     }
>> +
>> +     ret = cdns_pcie_hpa_host_link_setup(rc);
> 
> You should only ignore the 'waiting for link up' error and not the actual
> start_link error.
> 
>> +
>> +     for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++)
>> +             rc->avail_ib_bar[bar] = true;
>> +
>> +     ret = cdns_pcie_hpa_host_init(rc);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (!bridge->ops)
>> +             bridge->ops = &cdns_pcie_hpa_host_ops;
>> +
>> +     return pci_host_probe(bridge);
>> +}
>> +EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_setup);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Cadence PCIe host controller driver");
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-hpa.c
>> new file mode 100644
>> index 000000000000..76c1de5ea9ee
>> --- /dev/null
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-hpa.c
>> @@ -0,0 +1,205 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Cadence PCIe controller driver.
>> + *
>> + * Copyright (c) 2019, Cadence Design Systems
>> + * Author: Manikandan K Pillai <mpillai@cadence.com>
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +
>> +#include "pcie-cadence.h"
>> +
>> +bool cdns_pcie_hpa_link_up(struct cdns_pcie *pcie)
>> +{
>> +     u32 pl_reg_val;
>> +
>> +     pl_reg_val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_DBG_STS_REG0);
>> +     if (pl_reg_val & GENMASK(0, 0))
>> +             return true;
>> +     return false;
>> +}
>> +EXPORT_SYMBOL_GPL(cdns_pcie_hpa_link_up);
>> +
>> +int cdns_pcie_hpa_start_link(struct cdns_pcie *pcie)
> 
> Where is this function used?
> 
>> +{
>> +     u32 pl_reg_val;
>> +
>> +     pl_reg_val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_LAYER_CFG0);
>> +     pl_reg_val |= CDNS_PCIE_HPA_LINK_TRNG_EN_MASK;
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_LAYER_CFG0, pl_reg_val);
>> +     return 0;
>> +}
>> +
>> +void cdns_pcie_hpa_stop_link(struct cdns_pcie *pcie)
> 
> Where is this function used?
> 
>> +{
>> +     u32 pl_reg_val;
>> +
>> +     pl_reg_val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_LAYER_CFG0);
>> +     pl_reg_val &= ~CDNS_PCIE_HPA_LINK_TRNG_EN_MASK;
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_LAYER_CFG0, pl_reg_val);
>> +}
>> +
>> +void cdns_pcie_hpa_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
>> +{
>> +     u32 delay = 0x3;
>> +     u32 ltssm_control_cap;
>> +
>> +     /* Set the LTSSM Detect Quiet state min. delay to 2ms */
>> +     ltssm_control_cap = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG,
>> +                                             CDNS_PCIE_HPA_PHY_LAYER_CFG0);
>> +     ltssm_control_cap = ((ltssm_control_cap &
>> +                         ~CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK) |
>> +                         CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay));
>> +
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG,
>> +                          CDNS_PCIE_HPA_PHY_LAYER_CFG0, ltssm_control_cap);
>> +}
>> +EXPORT_SYMBOL_GPL(cdns_pcie_hpa_detect_quiet_min_delay_set);
>> +
>> +void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
>> +                                    u32 r, bool is_io,
>> +                                    u64 cpu_addr, u64 pci_addr, size_t size)
>> +{
>> +     /*
>> +      * roundup_pow_of_two() returns an unsigned long, which is not suited
>> +      * for 64bit values
>> +      */
>> +     u64 sz = 1ULL << fls64(size - 1);
>> +     int nbits = ilog2(sz);
>> +     u32 addr0, addr1, desc0, desc1, ctrl0;
>> +
>> +     if (nbits < 8)
>> +             nbits = 8;
>> +
>> +     /* Set the PCI address */
>> +     addr0 = CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) |
>> +             (lower_32_bits(pci_addr) & GENMASK(31, 8));
>> +     addr1 = upper_32_bits(pci_addr);
>> +
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), addr0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), addr1);
>> +
>> +     /* Set the PCIe header descriptor */
>> +     if (is_io)
>> +             desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO;
>> +     else
>> +             desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM;
>> +     desc1 = 0;
>> +     ctrl0 = 0;
>> +
>> +     /*
>> +      * Whether Bit [26] is set or not inside DESC0 register of the outbound
>> +      * PCIe descriptor, the PCI function number must be set into
>> +      * Bits [31:24] of DESC1 anyway.
>> +      *
>> +      * In Root Complex mode, the function number is always 0 but in Endpoint
>> +      * mode, the PCIe controller may support more than one function. This
>> +      * function number needs to be set properly into the outbound PCIe
>> +      * descriptor.
>> +      *
>> +      * Besides, setting Bit [26] is mandatory when in Root Complex mode:
>> +      * then the driver must provide the bus, resp. device, number in
>> +      * Bits [31:24] of DESC1, resp. Bits[23:16] of DESC0. Like the function
>> +      * number, the device number is always 0 in Root Complex mode.
>> +      *
>> +      * However when in Endpoint mode, we can clear Bit [26] of DESC0, hence
>> +      * the PCIe controller will use the captured values for the bus and
>> +      * device numbers.
>> +      */
>> +     if (pcie->is_rc) {
>> +             /* The device and function numbers are always 0 */
>> +             desc1 = CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr) |
>> +                     CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
>> +             ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
>> +                     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
>> +     } else {
>> +             /*
>> +              * Use captured values for bus and device numbers but still
>> +              * need to set the function number
>> +              */
>> +             desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
>> +     }
>> +
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
>> +
>> +     addr0 = CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
>> +             (lower_32_bits(cpu_addr) & GENMASK(31, 8));
>> +     addr1 = upper_32_bits(cpu_addr);
>> +
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), addr0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), addr1);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r), ctrl0);
>> +}
>> +EXPORT_SYMBOL_GPL(cdns_pcie_hpa_set_outbound_region);
>> +
>> +void cdns_pcie_hpa_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
>> +                                                   u8 busnr, u8 fn,
>> +                                                   u32 r, u64 cpu_addr)
>> +{
>> +     u32 addr0, addr1, desc0, desc1, ctrl0;
>> +
>> +     desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG;
>> +     desc1 = 0;
>> +     ctrl0 = 0;
>> +
>> +     /* See cdns_pcie_set_outbound_region() comments above */
>> +     if (pcie->is_rc) {
>> +             desc1 = CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr) |
>> +                     CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
>> +             ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
>> +                     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
>> +     } else {
>> +             desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
>> +     }
>> +
>> +     addr0 = CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
>> +             (lower_32_bits(cpu_addr) & GENMASK(31, 8));
>> +     addr1 = upper_32_bits(cpu_addr);
>> +
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), 0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), 0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), addr0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), addr1);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r), ctrl0);
>> +}
>> +EXPORT_SYMBOL_GPL(cdns_pcie_hpa_set_outbound_region_for_normal_msg);
>> +
>> +void cdns_pcie_hpa_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
> 
> Where is this function used?
> 
>> +{
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), 0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), 0);
>> +
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), 0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), 0);
>> +
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), 0);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +                          CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), 0);
>> +}
>> +EXPORT_SYMBOL_GPL(cdns_pcie_hpa_reset_outbound_region);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Cadence PCIe controller driver");
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
>> index 5603f214f4c7..62252befcf47 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
>> @@ -9,6 +9,17 @@
>>
>>   #include "pcie-cadence.h"
>>
>> +bool cdns_pcie_linkup(struct cdns_pcie *pcie)
> 
> Where is this function used?
> 
>> +{
>> +     u32 pl_reg_val;
>> +
>> +     pl_reg_val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE);
>> +     if (pl_reg_val & GENMASK(0, 0))
>> +             return true;
>> +     return false;
>> +}
>> +EXPORT_SYMBOL_GPL(cdns_pcie_linkup);
>> +
>>   void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
>>   {
>>        u32 delay = 0x3;
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>> index 1174cf597bb0..b8b44ce0a594 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -7,6 +7,7 @@
>>   #define _PCIE_CADENCE_H
>>
>>   #include <linux/kernel.h>
>> +#include <linux/module.h>
>>   #include <linux/pci.h>
>>   #include <linux/pci-epf.h>
>>   #include <linux/phy/phy.h>
>> @@ -42,9 +43,9 @@ enum cdns_pcie_reg_bank {
>>   };
>>
>>   struct cdns_pcie_ops {
>> -     int     (*start_link)(struct cdns_pcie *pcie);
>> -     void    (*stop_link)(struct cdns_pcie *pcie);
>> -     bool    (*link_up)(struct cdns_pcie *pcie);
>> +     int     (*start_link)(struct cdns_pcie *pcie);
>> +     void    (*stop_link)(struct cdns_pcie *pcie);
>> +     bool    (*link_up)(struct cdns_pcie *pcie);
> 
> Spurious change?
> 
>>        u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
>>   };
>>
>> @@ -76,6 +77,7 @@ struct cdns_plat_pcie_of_data {
>>    * struct cdns_pcie - private data for Cadence PCIe controller drivers
>>    * @reg_base: IO mapped register base
>>    * @mem_res: start/end offsets in the physical system memory to map PCI accesses
>> + * @msg_res: Region for send message to map PCI accesses
>>    * @dev: PCIe controller
>>    * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
>>    * @phy_count: number of supported PHY devices
>> @@ -88,6 +90,7 @@ struct cdns_plat_pcie_of_data {
>>   struct cdns_pcie {
>>        void __iomem                         *reg_base;
>>        struct resource                      *mem_res;
>> +     struct resource                      *msg_res;
>>        struct device                        *dev;
>>        bool                                 is_rc;
>>        int                                  phy_count;
>> @@ -110,6 +113,8 @@ struct cdns_pcie {
>>    *                available
>>    * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
>>    * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
>> + * @ecam_supported: Whether the ECAM is supported
>> + * @no_inbound_map: Whether inbound mapping is supported
>>    */
>>   struct cdns_pcie_rc {
>>        struct cdns_pcie        pcie;
>> @@ -120,6 +125,8 @@ struct cdns_pcie_rc {
>>        bool                    avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
>>        unsigned int            quirk_retrain_flag:1;
>>        unsigned int            quirk_detect_quiet_flag:1;
>> +     unsigned int            ecam_supported:1;
>> +     unsigned int            no_inbound_map:1;
>>   };
>>
>>   /**
>> @@ -303,6 +310,29 @@ static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
>>        return cdns_pcie_read_sz(addr, 0x2);
>>   }
>>
>> +static inline void cdns_pcie_hpa_rp_writeb(struct cdns_pcie *pcie,
>> +                                        u32 reg, u8 value)
>> +{
>> +     void __iomem *addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
>> +
>> +     cdns_pcie_write_sz(addr, 0x1, value);
>> +}
>> +
>> +static inline void cdns_pcie_hpa_rp_writew(struct cdns_pcie *pcie,
>> +                                        u32 reg, u16 value)
> 
> Where is this function used?
> 
>> +{
>> +     void __iomem *addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
>> +
>> +     cdns_pcie_write_sz(addr, 0x2, value);
>> +}
>> +
>> +static inline u16 cdns_pcie_hpa_rp_readw(struct cdns_pcie *pcie, u32 reg)
>> +{
> 
> Where is this function used?
> 
> Please drop all dead code.
> 
> - Mani
> 
> --
> மணிவண்ணன் சதாசிவம்

