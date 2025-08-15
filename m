Return-Path: <linux-pci+bounces-34095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E60B3B27A65
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 09:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F463BE01D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC03B29AAF5;
	Fri, 15 Aug 2025 07:53:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023114.outbound.protection.outlook.com [52.101.127.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2280210E0;
	Fri, 15 Aug 2025 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244423; cv=fail; b=fGKEIgKcNxmSAImthb8j46Wc490Uqsp8n5KrctjeUQZf/frAwWc1l0wzDrhxM5cU1HtrIPKlIdQrB495nzQKp+4sGZs11cTQ3DMnlZp4xg4mL5Adk7RRem5VVq+JPnrMN+40XDoi098BCvajkFAAgJ9n5ZWLm+I4KqrvxL09pLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244423; c=relaxed/simple;
	bh=pGPMlwH8CbRBwB/w3Q6bEDLgte749ZbQTVcE0otbZPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYaXHVcDnAa4hKx9Bp7zkLQk0rhVl+BLBjTcr015j6msB25jJksBlqAel6dIevHWMOYJR8lUtTFr9mibN0/z0PU2KqJ2NbnJzgZT0td83uKOq+H5xKiJRn9dlupnm3aiRQwXURayYLhV1LWG8dMqd23xW0TplFdlMGEHytqO9m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcTiSOEllYEsSsJW4danbb/jkT5N8Q3T4ahcviV62EAX8hlbyjEFA/HZsyw0gsfRWvjzneciRrzVxBlivu0jCxE7bOBJFasM96PofGHLTou5bIBL/kV6qjyIkWsXqFdWlIDLC3kRmoIkglCcFsWIJ24Ar/ND2hdrKpnjodvJ/nQ0eAIYZ4p/05Mo0FdGaqt+On7DWuO3O4eMMDWu3EJKu1K4n1NlIs7jwUPXiqU1Oc/ErAHT0iorVOmrp+BfsOc56HHq07GYPl4yX4PjXlnFTtodPSTdLSNymOoE2BaPdMFUkuQwH3EbnInQm0CRlz6ool9QngTIofCoDaf07/X6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqpVIgQ2h3Fd7G2bKcFuOu2vCOizGR/WALoxHHxDRIg=;
 b=Y2MzU6nhKzw1RpgzKIEzKsOgY3Zui7VKUiiT1XwUm8+KRN7SD24tafS6C7ykRVkdGoNuHv/WYCs2jNI2CzhOn7yLcuakyf2R6KAJ95shs7dPGzd02g/fR5gbE1u1gpy3gMM60L6lA9+tvfveh+Tr33+Aa2BcahasfyAIxKQw/Yr42IgGlbwP+0BWjRWGwyJo+laoDkP8g6H2a7hE6eK63Eh+B/UKLRqGH4VXtvrVXPnQssx6EJ02/vnSdSg33nvKhAFc2ArF+4D3fvwtf9pdIjv7X9r7+0ddYucCfZOWGWHNxuTjDgsfU1rVdDHum6Z6TUx5n6AJai7OKKhGRmk3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYAPR01CA0196.jpnprd01.prod.outlook.com (2603:1096:404:29::16)
 by SEYPR06MB6009.apcprd06.prod.outlook.com (2603:1096:101:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 07:53:35 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:404:29:cafe::cd) by TYAPR01CA0196.outlook.office365.com
 (2603:1096:404:29::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Fri,
 15 Aug 2025 07:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 07:53:32 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 04FC040A5A2B;
	Fri, 15 Aug 2025 15:53:32 +0800 (CST)
Message-ID: <6a038c5f-1632-4a5e-aadb-0b5dd94236f9@cixtech.com>
Date: Fri, 15 Aug 2025 15:53:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/13] PCI: sky1: Add PCIe host support for CIX Sky1
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250814224612.GA352494@bhelgaas>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250814224612.GA352494@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|SEYPR06MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 3647ed72-c4d6-458e-b168-08dddbd0d53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFBWeDRlOU5qd1Yxa2QrZGJ5eW92T2g1dEJ0d254L2pmc04vK2dtYjJTRDB4?=
 =?utf-8?B?R0pxKzc0TEdnVnJIdkVDNnZKTzludzFnZTc0Uk0rNkkwL2xhQnBWZW1pNTUw?=
 =?utf-8?B?VmovZWtOdVVnRVpoQzlvaEpRNnZldDNGVno1WVd6QVJ0TGtrQnNxS2l2NHhM?=
 =?utf-8?B?bE9uSjhjUWZpNTk0Yklua0wrSFdaSzYrZ1Z4bGJaL0ZIRExmUGhFTDBzQzZo?=
 =?utf-8?B?MEFNdm1IOFZCRWNWTHVhUzJENnp1bmMrSWp0WVNkckdzNGlIQmNieW9ic1Rk?=
 =?utf-8?B?ejE3V2pBWEhabEl4YVgzcm9Ed0dDaVRBaksxWUhOcDFCUkU5ZHZid1RhSGk1?=
 =?utf-8?B?VnN0eEJ4OWk1bmo5Q085aVF3SlFBckFYOG91b2crN3FqSU9IWjhCbGU3Z2s4?=
 =?utf-8?B?MEFLTWJ4UnJTc1J5Tm1mRkJVc2NyOE9vOXlTUnNQQ3VrTUN0Qm8ydEwzWTlV?=
 =?utf-8?B?VDlwSzJXRzhWeDBoRUROeVZsTnhVbjlLS21tMDhhNGF6VFBHSTJHdWpVZW1n?=
 =?utf-8?B?VkwvL2luRUZOWmdKUFB5NXZIby91a1BMcTY2RisvUXcxUFRmWnpMSG16dVl1?=
 =?utf-8?B?cUVQZlR2OEU1V04zSkZqdFE3bElYaXhiZmQ4V0IzRWl4eXRaT29xd0JsZVJO?=
 =?utf-8?B?eStDT2gvNCtxbURqVTVxOFhPeENGcGZvQ3hHNjE2OUY0cmxPL1hxb2dRNVdp?=
 =?utf-8?B?RW54VEpYV3h5SW1nUnlvTjVCbUpWckRYSlFlUTgwY2J4Y0pjRFdDY2R4QlZH?=
 =?utf-8?B?d0pucmtNS3FWRzhEcGFTRk9xK050UWJxMk1vNWxFMjB1c09RUHhmdmIrZ1h2?=
 =?utf-8?B?U0tTbzVHdkZJT2RncjMrWkRFdGpBcTE1cFpsN2lRMzM5QTUvWXl6dnR2eTJZ?=
 =?utf-8?B?cTJvMTBDMUZHU2MvVG1uUXppK3dhL1lOVlkvYWlHOE9kR2V6endlQStFZEFI?=
 =?utf-8?B?ejZqS1Q3VFg2SU4vSW9jNEhwNXJwUkVxejVhOUJ4NExUR2JmQU9JWWIzODBx?=
 =?utf-8?B?UU1qNmhheEFGQjhHWFdpdGJoTEF5RzN5ZGwvdEVRWWt6aHVzRmtPZzlkNjdD?=
 =?utf-8?B?WjZKMml6bUdpRGVwTTJqUVNJb1U4djU5N0Q2Y3RvQmZJcGRSWjZaeUw5L2Ju?=
 =?utf-8?B?MjNDUHFURU9CVDNLWWlOcVV4T0wxV25DY3NOZlh6b2RQYlVLQ2NTRldXQmZz?=
 =?utf-8?B?dWdDcGtaUDFEUFJaN2hTcVVNNHBnVXhXbEpqS1gwTjhvR2ZhQU5KNVIxRDJC?=
 =?utf-8?B?VnM5ais1U3JieVF6Zk5WUzVOdjBFaGUwMExlV3RTUWlkdHAwN1FuaTgrS3Z2?=
 =?utf-8?B?Wi9TN3lWdXl4Q3N6allhak5xaFk2bEFHQVQ5Y2xoblorWFpYbHBhblVpK0gx?=
 =?utf-8?B?eFBHS0RHdEZabXVRN2phWEpYTU9BRDhmTVJsVUl4cUdXUGRnVlozcSt2TTNk?=
 =?utf-8?B?Y2VWdHg5RU4vVWJ5b014d1ZYTW9pcFEzNVp4N0RrUUFDdzV1WlhMU1lvVmZh?=
 =?utf-8?B?bDNyaVppVHFvZGxYL2JNZFVaV0pUeVZKM1Y3ODJ6NHRjcGVKVFNmZThLYThq?=
 =?utf-8?B?bWliZXEzUjRDMlorTjRka3E4enk1WHFwT1Eya3QyZFo1eVpJTjRJQmdjWFdC?=
 =?utf-8?B?dHV4cXQ0b05xUEt5VllqYzVOb09PM3NraEU2cjM5WURya3IzdDljbFpIT01s?=
 =?utf-8?B?cDYwM1NGc2ZDRTliSHZLdFFwcENXRFR6T1RUb0VQSWFYT2Q4NlRYaldnMXJ1?=
 =?utf-8?B?Um5nMUwrNEo1Qnl5ZGtEZGlGREs3cEpiTzU0RzBlcWJBeDZCaEFDTnpKZjNS?=
 =?utf-8?B?UzIvTkd0bENKS29Cb09SVEw1OERwa2RRZlJqN2MrSkxDRWRYWWZVaFJHMmpm?=
 =?utf-8?B?YWJGQi82NlJUMzlIMW5RWk9QbVBKSHBTYVB4bExueUdQanlIVDNwaURMU2pZ?=
 =?utf-8?B?OWNiMG13cXJBeEZIV3NONWJCbitzVEtLNDRCYnRsSDlLeWMrSGtwNWtleUhG?=
 =?utf-8?B?TXluV1dRY3dKSVhpeGlBenIva1kzTTgxSXNDcVpXR0ZrR3l0Ujh1YU5CdlRi?=
 =?utf-8?Q?LTpsij?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 07:53:32.8276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3647ed72-c4d6-458e-b168-08dddbd0d53a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6009



On 2025/8/15 06:46, Bjorn Helgaas wrote:
> EXTERNAL EMAIL
> 
> On Wed, Aug 13, 2025 at 12:23:28PM +0800, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Add driver for the CIX Sky1 SoC PCIe Gen4 16 GT/s controller based
>> on the Cadence PCIe core.
>>
>> Supports MSI/MSI-x via GICv3, Single Virtual Channel, Single Function.
> 
>> +config PCI_SKY1_HOST
>> +     tristate "CIX SKY1 PCIe controller (host mode)"
>> +     depends on OF
>> +     select PCIE_CADENCE_HOST
>> +     select PCI_ECAM
>> +     help
>> +       Say Y here if you want to support the CIX SKY1 PCIe platform
>> +       controller in host mode. CIX SKY1 PCIe controller uses Cadence HPA(High
>> +       Performance Architecture IP[Second generation of cadence PCIe IP])
>> +
>> +       This driver requires Cadence PCIe core infrastructure (PCIE_CADENCE_HOST)
>> +       and hardware platform adaptation layer to function.
> 
> Reorder so this menu entry appears in alphabetical order by vendor.
> 
> Add space in "HPA(..".
> 
> Add space in "IP[Second ..."
> 
> s/cadence PCIe IP/Cadence PCIe IP/
> 
> Rewrap so help text fits in 80 columns when displayed by menuconfig.

Dear Bjorn,

Thank you very much for your reply. Will change.

> 
>> +++ b/drivers/pci/controller/cadence/Makefile
>> +++ b/drivers/pci/controller/cadence/pci-sky1.c
>> @@ -0,0 +1,294 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PCIe controller driver for CIX's sky1 SoCs
>> + *
>> + * Author: Hans Zhang <hans.zhang@cixtech.com>
>> + */
> 
> The typical comment style, thank you :)
> 
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pci.h>
>> +#include <linux/pci-ecam.h>
>> +#include <linux/pci_ids.h>
>> +
>> +#include "pcie-cadence.h"
>> +#include "pcie-cadence-host-common.h"
>> +
>> +#define STRAP_REG(n) ((n) * 0x04)
>> +#define STATUS_REG(n) ((n) * 0x04)
>> +
>> +#define RCSU_STRAP_REG 0x300
>> +#define RCSU_STATUS_REG 0x400
>> +
>> +#define SKY1_IP_REG_BANK_OFFSET 0x1000
>> +#define SKY1_IP_CFG_CTRL_REG_BANK_OFFSET 0x4c00
>> +#define SKY1_IP_AXI_MASTER_COMMON_OFFSET 0xf000
>> +#define SKY1_AXI_SLAVE_OFFSET 0x9000
>> +#define SKY1_AXI_MASTER_OFFSET 0xb000
>> +#define SKY1_AXI_HLS_REGISTERS_OFFSET 0xc000
>> +#define SKY1_AXI_RAS_REGISTERS_OFFSET 0xe000
>> +#define SKY1_DTI_REGISTERS_OFFSET 0xd000
> 
> Indent the values to line up.
> 
> Consider dropping "_OFFSET".

Will change.

> 
>> +#define IP_REG_I_DBG_STS_0 0x420
>> +
>> +#define LINK_TRAINING_ENABLE BIT(0)
>> +#define LINK_COMPLETE BIT(0)
> 
> Define next to the offset of the register that contains these.
> Consider naming them to relate to the register.
> 

All of our registers are RCSU (Remote CIX System Unit registers.), and 
they are named like this: I moved it below this.
#define STRAP_REG(n) ((n) * 0x04)
#define STATUS_REG(n) ((n) * 0x04)

>> +enum cix_soc_type {
>> +     CIX_SKY1,
>> +};
>> +
>> +struct sky1_pcie_data {
>> +     struct cdns_plat_pcie_of_data reg_off;
> 
> Weird name for this member.  cdns_plat_pcie_of_data contains more than
> just offsets.

We are considering deleting cdns_plat_pcie_of_data. Krzysztof also 
provided a review opinion, intending to directly assign the register 
offset value in the probe.

> 
>> +     enum cix_soc_type soc_type;
>> +};
>> +
>> +struct sky1_pcie {
>> +     struct device *dev;
>> +     const struct sky1_pcie_data *data;
>> +     struct cdns_pcie *cdns_pcie;
> 
> Typically first in the driver struct.  Also cdns_pcie already contains
> a struct device *; do you need another?

I checked and it's indeed possible to delete it by using "dev" in cdns_pcie.

> 
>> +     struct cdns_pcie_rc *cdns_pcie_rc;
>> +
>> +     struct resource *cfg_res;
>> +     struct resource *msg_res;
>> +     struct pci_config_window *cfg;
>> +     void __iomem *rcsu_base;
>> +     void __iomem *strap_base;
>> +     void __iomem *status_base;
>> +     void __iomem *reg_base;
>> +     void __iomem *cfg_base;
>> +     void __iomem *msg_base;
>> +};
>> +
>> +static void sky1_pcie_clear_and_set_dword(void __iomem *addr, u32 clear,
>> +                                       u32 set)
>> +{
>> +     u32 val;
>> +
>> +     val = readl(addr);
>> +     val &= ~clear;
>> +     val |= set;
>> +     writel(val, addr);
> 
> Nothing specific to sky1 here.  Find an existing interface or copy the
> style of other drivers.  Surely other drivers do something similar,
> but "git grep clear_and_set_dword drivers/pci/controller/" finds
> nothing.

My original intention was for the future upstream, as there are many 
repetitive read and write registers. Then I'll delete it first.

> 
>> +static int sky1_pcie_parse_mem(struct sky1_pcie *pcie)
>> +{
>> +     struct device *dev = pcie->dev;
>> +     struct platform_device *pdev = to_platform_device(dev);
>> +     struct resource *res;
>> +     void __iomem *base;
>> +     int ret = 0;
>> +
>> +     base = devm_platform_ioremap_resource_byname(pdev, "reg");
>> +     if (IS_ERR(base)) {
>> +             dev_err(dev, "Parse \"reg\" resource err\n");
>> +             return PTR_ERR(base);
>> +     }
>> +     pcie->reg_base = base;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
>> +     if (!res) {
>> +             dev_err(dev, "Parse \"cfg\" resource err\n");
>> +             return -ENXIO;
>> +     }
>> +     pcie->cfg_res = res;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rcsu");
>> +     if (!res) {
>> +             dev_err(dev, "Parse \"rcsu\" resource err\n");
>> +             return -ENXIO;
>> +     }
>> +     pcie->rcsu_base = devm_ioremap(dev, res->start, resource_size(res));
>> +     if (!pcie->rcsu_base) {
>> +             dev_err(dev, "ioremap failed for resource %pR\n", res);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
>> +     if (!res) {
>> +             dev_err(dev, "Parse \"msg\" resource err\n");
>> +             return -ENXIO;
>> +     }
>> +     pcie->msg_res = res;
>> +     pcie->msg_base = devm_ioremap(dev, res->start, resource_size(res));
>> +     if (!pcie->msg_base) {
>> +             dev_err(dev, "ioremap failed for resource %pR\n", res);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     return ret;
> 
> "ret" is never used; remove it and just "return 0" here.

Will change.

> 
>> +}
>> +
>> +static int sky1_pcie_parse_property(struct platform_device *pdev,
>> +                                 struct sky1_pcie *pcie)
> 
> Find a similar function in other drivers and copy the name.
> "git grep parse_property drivers/pci/controller/" finds nothing.

Will change.

> 
>> +{
>> +     int ret = 0;
>> +
>> +     ret = sky1_pcie_parse_mem(pcie);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     sky1_pcie_init_bases(pcie);
>> +
>> +     return ret;
> 
> Drop "ret" and return 0 here.

Will change.

> 
>> +}
>> +
>> +static int sky1_pcie_start_link(struct cdns_pcie *cdns_pcie)
>> +{
>> +     struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
>> +
>> +     sky1_pcie_clear_and_set_dword(pcie->strap_base + STRAP_REG(1),
>> +                                   0, LINK_TRAINING_ENABLE);
>> +
>> +     return 0;
>> +}
>> +
>> +static void sky1_pcie_stop_link(struct cdns_pcie *cdns_pcie)
>> +{
>> +     struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
>> +
>> +     sky1_pcie_clear_and_set_dword(pcie->strap_base + STRAP_REG(1),
>> +                                   LINK_TRAINING_ENABLE, 0);
>> +}
>> +
>> +
>> +static bool sky1_pcie_link_up(struct cdns_pcie *cdns_pcie)
>> +{
>> +     u32 val;
>> +
>> +     val = cdns_pcie_hpa_readl(cdns_pcie, REG_BANK_IP_REG,
>> +                               IP_REG_I_DBG_STS_0);
>> +     return val & LINK_COMPLETE;
>> +}
>> +
>> +static const struct cdns_pcie_ops sky1_pcie_ops = {
>> +     .start_link = sky1_pcie_start_link,
>> +     .stop_link = sky1_pcie_stop_link,
>> +     .link_up = sky1_pcie_link_up,
>> +};
>> +
>> +static int sky1_pcie_probe(struct platform_device *pdev)
>> +{
>> +     const struct sky1_pcie_data *data;
>> +     struct device *dev = &pdev->dev;
>> +     struct pci_host_bridge *bridge;
>> +     struct cdns_pcie *cdns_pcie;
>> +     struct resource_entry *bus;
>> +     struct cdns_pcie_rc *rc;
>> +     struct sky1_pcie *pcie;
>> +     int ret;
>> +
>> +     pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>> +     if (!pcie)
>> +             return -ENOMEM;
>> +
>> +     data = of_device_get_match_data(dev);
>> +     if (!data)
>> +             return -EINVAL;
>> +
>> +     pcie->data = data;
>> +     pcie->dev = dev;
>> +     dev_set_drvdata(dev, pcie);
>> +
>> +     bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
>> +     if (!bridge)
>> +             return -ENOMEM;
>> +
>> +     bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
>> +     if (!bus)
>> +             return -ENODEV;
> 
> Maybe put this near the code that uses it instead of sticking the
> unrelated sky1_pcie_parse_property() in the middle?

Will change.

> 
>> +     ret = sky1_pcie_parse_property(pdev, pcie);
>> +     if (ret < 0)
>> +             return -ENXIO;
>> +
>> +     pcie->cfg = pci_ecam_create(dev, pcie->cfg_res, bus->res,
>> +                                 &pci_generic_ecam_ops);
>> +     if (IS_ERR(pcie->cfg))
>> +             return PTR_ERR(pcie->cfg);
>> +
>> +     bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
>> +     rc = pci_host_bridge_priv(bridge);
>> +     rc->ecam_support_flag = 1;
>> +     rc->cfg_base = pcie->cfg->win;
>> +     rc->cfg_res = &pcie->cfg->res;
>> +
>> +     cdns_pcie = &rc->pcie;
>> +     cdns_pcie->dev = dev;
>> +     cdns_pcie->ops = &sky1_pcie_ops;
>> +     cdns_pcie->reg_base = pcie->reg_base;
>> +     cdns_pcie->msg_res = pcie->msg_res;
>> +     cdns_pcie->cdns_pcie_reg_offsets = &data->reg_off;
>> +     cdns_pcie->is_rc = data->reg_off.is_rc;
>> +
>> +     pcie->cdns_pcie = cdns_pcie;
>> +     pcie->cdns_pcie_rc = rc;
>> +     pcie->cfg_base = rc->cfg_base;
>> +     bridge->sysdata = pcie->cfg;
>> +
>> +     if (data->soc_type == CIX_SKY1) {
>> +             rc->vendor_id = PCI_VENDOR_ID_CIX;
>> +             rc->device_id = PCI_DEVICE_ID_CIX_SKY1;
>> +             rc->no_inbound_flag = 1;
>> +     }
>> +
>> +     ret = cdns_pcie_hpa_host_setup(rc);
>> +     if (ret < 0) {
>> +             pci_ecam_free(pcie->cfg);
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct sky1_pcie_data sky1_pcie_rc_data = {
>> +     .reg_off = {
>> +             .is_rc = true,
>> +             .ip_reg_bank_offset = SKY1_IP_REG_BANK_OFFSET,
>> +             .ip_cfg_ctrl_reg_offset = SKY1_IP_CFG_CTRL_REG_BANK_OFFSET,
>> +             .axi_mstr_common_offset = SKY1_IP_AXI_MASTER_COMMON_OFFSET,
>> +             .axi_slave_offset = SKY1_AXI_SLAVE_OFFSET,
>> +             .axi_master_offset = SKY1_AXI_MASTER_OFFSET,
>> +             .axi_hls_offset = SKY1_AXI_HLS_REGISTERS_OFFSET,
>> +             .axi_ras_offset = SKY1_AXI_RAS_REGISTERS_OFFSET,
>> +             .axi_dti_offset = SKY1_DTI_REGISTERS_OFFSET,
>> +     },
>> +     .soc_type = CIX_SKY1,
>> +};
>> +
>> +static const struct of_device_id of_sky1_pcie_match[] = {
>> +     {
>> +             .compatible = "cix,sky1-pcie-host",
>> +             .data = &sky1_pcie_rc_data,
>> +     },
>> +     {},
>> +};
>> +
>> +static void sky1_pcie_remove(struct platform_device *pdev)
>> +{
>> +     struct sky1_pcie *pcie = platform_get_drvdata(pdev);
>> +
>> +     pci_ecam_free(pcie->cfg);
>> +}
>> +
>> +static struct platform_driver sky1_pcie_driver = {
>> +     .probe  = sky1_pcie_probe,
>> +     .remove = sky1_pcie_remove,
>> +     .driver = {
>> +             .name = "sky1-pcie",
>> +             .of_match_table = of_sky1_pcie_match,
>> +     },
>> +};
>> +module_platform_driver(sky1_pcie_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("PCIe controller driver for CIX's sky1 SoCs");
>> +MODULE_AUTHOR("Hans Zhang <hans.zhang@cixtech.com>");
>> --
>> 2.49.0
>>

Best regards,
Hans

