Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC0F6E9918
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjDTQFb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 12:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjDTQF1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 12:05:27 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E43C31;
        Thu, 20 Apr 2023 09:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2RJWW1DfVbsxzUa66+r5fDshaFKt4nHsJcYqZ9fHpnf+LOlMHhwbeS9rsoHzlvw2lNNf8o3hLtGnqhKqGx6IqXVHFlLO2h2kgA3gl0U3OwPhRiGZLifJx2OqKRVMDOVRXtI3VwVERE/eayMe6tlPrJ/Q86x9JkcjsUCPo4xVVIAVpB64tztkkJyJRqWXDBn/iKF5A2o61ndWhCxWaFQhIlfgfLUf4DDeoxAvF2YOXTO+oMDYY4/EvXdw/YfDdSPPxLQnkgKk/qXwOnTPXq1FWvOXpMW7O8hndGoFEWIFFNb4vZHik20WYKjKcu+da4wzrkH1w/bdKnErDup1ePZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsxIXohWGQ1Pa2+26c5XxEdOQj3rmz/fr0awF8MENIU=;
 b=bY99+padvxCjzz42MtIuVQUOb4y5fI2jdASgZcGhVRbt9czHicVp09tMPAdiZVekSTUsuyy8gI65i9Zul+kBHuX/+u4Uwoslp7rBNlbGtpCH4IgHwLEN2PL54VCXJ+yVNuqrhX5BUFi5aZMQlEmXHWp6iAOhQ6G2oWkeHd49Ay+DtVIMOhtKzDV+N0I+12ehL1Rfq6UBTe2ImVDDB4QCWYhxS3WgcrWA9x7W5hOdvEwU6hghJSet6m1/A6w2Htbj/BP0DQ+b8GYMkAX+ZE3/0G212BbXea0Fm73QcMhddsm2/s/nkpMnBVuArD/1M/1NUC/5GBL0RUtFq06PvpUfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsxIXohWGQ1Pa2+26c5XxEdOQj3rmz/fr0awF8MENIU=;
 b=J5t4R4YPkICNsXQorslnAnxGZWA8hxEHZBbhg/pUY2tmtI+f9W/XYwoGwZE2XwND01Njf159e5gxpPI3ZNvztZPIVnPqwv2OiXxTrb4vxdpxFb5RmywtoA6ogAG8U4b7TPs++DHQLyL5573zcc9LSubJyo27cZJDjdkKp/ozQhw=
Received: from BN8PR16CA0036.namprd16.prod.outlook.com (2603:10b6:408:4c::49)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 16:05:15 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::8f) by BN8PR16CA0036.outlook.office365.com
 (2603:10b6:408:4c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 16:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 16:05:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 11:05:14 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 20 Apr 2023 11:05:13 -0500
Message-ID: <20d251bc-c4ec-64cc-8e6b-10c24cae6c9b@amd.com>
Date:   Thu, 20 Apr 2023 09:05:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V8 2/3] PCI: Create device tree node for selected devices
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <frowand.list@gmail.com>,
        <helgaas@kernel.org>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
References: <1681877994-16487-1-git-send-email-lizhi.hou@amd.com>
 <1681877994-16487-3-git-send-email-lizhi.hou@amd.com>
 <20230419231155.GA899497-robh@kernel.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230419231155.GA899497-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: e18a7689-2719-490f-af74-08db41b90763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NNnq65858vzMYXFbSb+IWo4NI/so1JhEOk0klPx9am1MddMDBkTZ9lwDyAd0TKbuiWyk/GvTv3AWIUYyUneZ0IUmiht482MX/AUzG0pwgz2L4H1/xFGAaqWiufPJ2znJ8DodjCYiYsWhuXEXYKWVTybfQu//VsbA3+K1eZMlrhi9T45LKawReI9bKnx4JMkgFBpXpEzDydRKkpv1FBPyj9uaS0GMc/xOU3c8jA+CQGB/MbnTlKPEDgLeZ1/QS5vcMtAaq7DXlcvQcOAweqj2AoD/bxumt85z4Mqdzl4GTUyeJAyxphHO8/begJeoxOnCfp+42rNcpvveskossGzXT5hnnNiOCxnre7EsXYEQifZecLqxHcjy6kfIOJT4zYbrwpPQamgrf2RS4RpTljkGVE1AOrpagw8BkadcmwGIkHk1ss8KsUgnQ4VkMAXoM9NoxRSsKodsF0No3TDgp3VS9q+8JeVhv2Rv8X9qLyASKQ7GjvQNa6mdf8WENyCYG92ADwPHbENIF3nw8lWqY+i5YQSS1I4Kk2qYjsIadYwXLdYSN5oVbmuMUPmoVLgOJL5NZvAViwMMd1mAEgnmEuIBTSxgof/JmrH2vheAOw4nKEVxoAkJM9p5ccdawnRrngCIIK3Z1OH1Riz0Q+4QYl3cdZSPYYXFx2SoYy0REwyc+9hlXzWiJnIos3hcMSKV7hWe9jJ160YMz1XM2xNiQs57r91wbHQ9211hKzr8ATXfYun/Dsqn0PK01hfcg7lpELaxmqivg/eYT5otmg1l9wt3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(2616005)(36860700001)(316002)(70206006)(70586007)(16576012)(6916009)(82740400003)(4326008)(336012)(426003)(47076005)(83380400001)(478600001)(54906003)(8676002)(8936002)(41300700001)(81166007)(356005)(44832011)(2906002)(30864003)(31696002)(5660300002)(26005)(53546011)(186003)(31686004)(86362001)(36756003)(82310400005)(40460700003)(40480700001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 16:05:15.1317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e18a7689-2719-490f-af74-08db41b90763
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 4/19/23 16:11, Rob Herring wrote:
> On Tue, Apr 18, 2023 at 09:19:53PM -0700, Lizhi Hou wrote:
>> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
>> spaces from multiple hardware peripherals to its PCI BAR. Normally,
>> the PCI core discovers devices and BARs using the PCI enumeration process.
>> There is no infrastructure to discover the hardware peripherals that are
>> present in a PCI device, and which can be accessed through the PCI BARs.
>>
>> For Alveo PCI card, the card firmware provides a flattened device tree to
>> describe the hardware peripherals on its BARs. The Alveo card driver can
>> load this flattened device tree and leverage device tree framework to
>> generate platform devices for the hardware peripherals eventually.
>>
>> Apparently, the device tree framework requires a device tree node for the
>> PCI device. Thus, it can generate the device tree nodes for hardware
>> peripherals underneath. Because PCI is self discoverable bus, there might
>> not be a device tree node created for PCI devices. This patch is to add
>> support to generate device tree node for PCI devices.
>>
>> Added a kernel option. When the option is turned on, the kernel will
>> generate device tree nodes for PCI bridges unconditionally.
>>
>> Initially, the basic properties are added for the dynamically generated
>> device tree nodes.
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/pci/Kconfig         |  12 ++
>>   drivers/pci/Makefile        |   1 +
>>   drivers/pci/bus.c           |   2 +
>>   drivers/pci/msi/irqdomain.c |   6 +-
>>   drivers/pci/of.c            |  79 ++++++++++++++
>>   drivers/pci/of_property.c   | 212 ++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci-driver.c    |   3 +-
>>   drivers/pci/pci.h           |  19 ++++
>>   drivers/pci/remove.c        |   1 +
>>   9 files changed, 332 insertions(+), 3 deletions(-)
>>   create mode 100644 drivers/pci/of_property.c
>>
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 9309f2469b41..24c3107c68cc 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -193,6 +193,18 @@ config PCI_HYPERV
>>   	  The PCI device frontend driver allows the kernel to import arbitrary
>>   	  PCI devices from a PCI backend to support PCI driver domains.
>>   
>> +config PCI_DYNAMIC_OF_NODES
>> +	bool "Create Devicetree nodes for PCI devices"
>> +	depends on OF
>> +	select OF_DYNAMIC
>> +	help
>> +	  This option enables support for generating device tree nodes for some
>> +	  PCI devices. Thus, the driver of this kind can load and overlay
>> +	  flattened device tree for its downstream devices.
>> +
>> +	  Once this option is selected, the device tree nodes will be generated
>> +	  for all PCI bridges.
>> +
>>   choice
>>   	prompt "PCI Express hierarchy optimization setting"
>>   	default PCIE_BUS_DEFAULT
>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>> index 2680e4c92f0a..cc8b4e01e29d 100644
>> --- a/drivers/pci/Makefile
>> +++ b/drivers/pci/Makefile
>> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>>   obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>>   obj-$(CONFIG_PCI_DOE)		+= doe.o
>> +obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>>   
>>   # Endpoint library must be initialized before its users
>>   obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index 549c4bd5caec..89ef8c64bb22 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -341,6 +341,8 @@ void pci_bus_add_device(struct pci_dev *dev)
>>   	 */
>>   	pcibios_bus_add_device(dev);
>>   	pci_fixup_device(pci_fixup_final, dev);
>> +	if (pci_is_bridge(dev))
>> +		of_pci_make_dev_node(dev);
>>   	pci_create_sysfs_dev_files(dev);
>>   	pci_proc_attach_device(dev);
>>   	pci_bridge_d3_update(dev);
>> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
>> index e33bcc872699..cd73d2250305 100644
>> --- a/drivers/pci/msi/irqdomain.c
>> +++ b/drivers/pci/msi/irqdomain.c
>> @@ -456,8 +456,10 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>>   	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
>>   
>>   	of_node = irq_domain_get_of_node(domain);
>> -	rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
>> -			iort_msi_map_id(&pdev->dev, rid);
>> +	if (of_node && !of_node_check_flag(of_node, OF_DYNAMIC))
>> +		rid = of_msi_map_id(&pdev->dev, of_node, rid);
>> +	else
>> +		rid = iort_msi_map_id(&pdev->dev, rid);
> Whether or not this works depends if the host bridge has an 'msi-map' or
> not. For a pure DT system, I think you need to drop this change. The
> behavior shouldn't change based on dynamic vs. static nodes.
Ok,  Both of_msi_map_id() and iort_msi_map_id() will return input rid 
for a pure DT system. I can drop this change.
>
> For this to work for all 3 cases, I think we need just:
>
> rid = of_msi_map_id(&pdev->dev, of_node, rid); // NOP if of_node is NULL
> rid = iort_msi_map_id(&pdev->dev, rid); // NOP if no IORT entry
>
> But I'm not really sure if that really works for ACPI or not.
>
>>   
>>   	return rid;
>>   }
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 196834ed44fe..42a5cfac2d34 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -469,6 +469,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>>   		} else {
>>   			/* We found a P2P bridge, check if it has a node */
>>   			ppnode = pci_device_to_OF_node(ppdev);
>> +			if (ppnode && of_node_check_flag(ppnode, OF_DYNAMIC))
>> +				ppnode = NULL;
> Again, different behavior if dynamic. I'm not seeing why you need this
> change.
This change is required. For dynamic generated node, we do not generate 
interrupt routing related properties. Thus we need to fallback to use 
pci_swizzle_interrupt_pin(). Generating interrupt routing related 
properties might be difficult. I think we can differ it to the future 
patches. Or just use pci_swizzle_interrupt_pin() which is much simpler.
>
>>   		}
>>   
>>   		/*
>> @@ -599,6 +601,83 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>>   	return pci_parse_request_of_pci_ranges(dev, bridge);
>>   }
>>   
>> +#if IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES)
>> +
>> +void of_pci_remove_node(struct pci_dev *pdev)
>> +{
>> +	struct device_node *np;
>> +
>> +	np = pci_device_to_OF_node(pdev);
>> +	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
>> +		return;
>> +	pdev->dev.of_node = NULL;
>> +
>> +	of_changeset_revert(np->data);
>> +	of_changeset_destroy(np->data);
>> +	of_node_put(np);
>> +}
>> +
>> +void of_pci_make_dev_node(struct pci_dev *pdev)
>> +{
>> +	struct device_node *ppnode, *np = NULL;
>> +	const char *pci_type = "dev";
>> +	struct of_changeset *cset;
>> +	const char *name;
>> +	int ret;
>> +
>> +	/*
>> +	 * If there is already a device tree node linked to this device,
>> +	 * return immediately.
>> +	 */
>> +	if (pci_device_to_OF_node(pdev))
>> +		return;
>> +
>> +	/* Check if there is device tree node for parent device */
>> +	if (!pdev->bus->self)
>> +		ppnode = pdev->bus->dev.of_node;
>> +	else
>> +		ppnode = pdev->bus->self->dev.of_node;
>> +	if (!ppnode)
>> +		return;
>> +
>> +	if (pci_is_bridge(pdev))
>> +		pci_type = "pci";
>> +
>> +	name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
>> +			 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>> +	if (!name)
>> +		return;
>> +
>> +	cset = kmalloc(sizeof(*cset), GFP_KERNEL);
>> +	if (!cset)
>> +		goto failed;
>> +	of_changeset_init(cset);
>> +
>> +	np = of_changeset_create_node(ppnode, name, cset);
>> +	if (!np)
>> +		goto failed;
>> +	np->data = cset;
>> +
>> +	ret = of_pci_add_properties(pdev, cset, np);
>> +	if (ret)
>> +		goto failed;
>> +
>> +	ret = of_changeset_apply(cset);
>> +	if (ret)
>> +		goto failed;
>> +
>> +	pdev->dev.of_node = np;
>> +	kfree(name);
>> +
>> +	return;
>> +
>> +failed:
>> +	if (np)
>> +		of_node_put(np);
>> +	kfree(name);
>> +}
>> +#endif
>> +
>>   #endif /* CONFIG_PCI */
>>   
>>   /**
>> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
>> new file mode 100644
>> index 000000000000..3d8267aa96e2
>> --- /dev/null
>> +++ b/drivers/pci/of_property.c
>> @@ -0,0 +1,212 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/of.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include "pci.h"
>> +
>> +#define OF_PCI_ADDRESS_CELLS		3
>> +#define OF_PCI_SIZE_CELLS		2
>> +
>> +struct of_pci_addr_pair {
>> +	u32		phys_addr[OF_PCI_ADDRESS_CELLS];
>> +	u32		size[OF_PCI_SIZE_CELLS];
>> +};
>> +
>> +struct of_pci_range {
>> +	u32		child_addr[OF_PCI_ADDRESS_CELLS];
>> +	u32		parent_addr[OF_PCI_ADDRESS_CELLS];
>> +	u32		size[OF_PCI_SIZE_CELLS];
>> +};
>> +
>> +#define OF_PCI_ADDR_SPACE_IO		0x1
>> +#define OF_PCI_ADDR_SPACE_MEM32		0x2
>> +#define OF_PCI_ADDR_SPACE_MEM64		0x3
>> +
>> +#define OF_PCI_ADDR_FIELD_NONRELOC	BIT(31)
>> +#define OF_PCI_ADDR_FIELD_SS		GENMASK(25, 24)
>> +#define OF_PCI_ADDR_FIELD_PREFETCH	BIT(30)
>> +#define OF_PCI_ADDR_FIELD_BUS		GENMASK(23, 16)
>> +#define OF_PCI_ADDR_FIELD_DEV		GENMASK(15, 11)
>> +#define OF_PCI_ADDR_FIELD_FUNC		GENMASK(10, 8)
>> +#define OF_PCI_ADDR_FIELD_REG		GENMASK(7, 0)
>> +
>> +#define OF_PCI_ADDR_HI			GENMASK_ULL(63, 32)
>> +#define OF_PCI_ADDR_LO			GENMASK_ULL(31, 0)
>> +#define OF_PCI_SIZE_HI			GENMASK_ULL(63, 32)
>> +#define OF_PCI_SIZE_LO			GENMASK_ULL(31, 0)
>> +
>> +enum of_pci_prop_compatible {
>> +	PROP_COMPAT_PCI_VVVV_DDDD,
>> +	PROP_COMPAT_PCICLASS_CCSSPP,
>> +	PROP_COMPAT_PCICLASS_CCSS,
>> +	PROP_COMPAT_NUM,
>> +};
>> +
>> +static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
>> +			       u32 reg_num, u32 flags, bool reloc)
>> +{
>> +	prop[0] = FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
>> +		FIELD_PREP(OF_PCI_ADDR_FIELD_DEV, PCI_SLOT(pdev->devfn)) |
>> +		FIELD_PREP(OF_PCI_ADDR_FIELD_FUNC, PCI_FUNC(pdev->devfn));
>> +	prop[0] |= flags | reg_num;
>> +	if (!reloc) {
>> +		prop[0] |= OF_PCI_ADDR_FIELD_NONRELOC;
>> +		prop[1] = FIELD_GET(OF_PCI_ADDR_HI, addr);
>> +		prop[2] = FIELD_GET(OF_PCI_ADDR_LO, addr);
> No need for your own macros here. Use upper_32_bits() and
> lower_32_bits(). Same for size macros.
Ok, sure.
>
>> +	}
>> +}
>> +
>> +static int of_pci_get_addr_flags(struct resource *res, u32 *flags)
>> +{
>> +	u32 ss;
>> +
>> +	if (res->flags & IORESOURCE_IO)
>> +		ss = OF_PCI_ADDR_SPACE_IO;
>> +	else if (res->flags & IORESOURCE_MEM_64)
>> +		ss = OF_PCI_ADDR_SPACE_MEM64;
>> +	else if (res->flags & IORESOURCE_MEM)
>> +		ss = OF_PCI_ADDR_SPACE_MEM32;
>> +	else
>> +		return -EINVAL;
>> +
>> +	*flags = 0;
>> +	if (res->flags & IORESOURCE_PREFETCH)
>> +		*flags |= OF_PCI_ADDR_FIELD_PREFETCH;
>> +
>> +	*flags |= FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
>> +
>> +	return 0;
>> +}
>> +
>> +static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
>> +			      struct device_node *np)
>> +{
>> +	struct of_pci_range *rp;
>> +	struct resource *res;
>> +	int i = 0, j, ret;
>> +	u64 val64;
>> +	u32 flags;
>> +
>> +	rp = kcalloc(PCI_BRIDGE_RESOURCE_NUM, sizeof(*rp), GFP_KERNEL);
>> +	if (!rp)
>> +		return -ENOMEM;
>> +
>> +	res = &pdev->resource[PCI_BRIDGE_RESOURCES];
>> +	for (j = 0; j < PCI_BRIDGE_RESOURCE_NUM; j++) {
>> +		if (!resource_size(&res[j]))
>> +			continue;
>> +
>> +		if (of_pci_get_addr_flags(&res[j], &flags))
>> +			continue;
>> +
>> +		val64 = res[j].start;
>> +		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
>> +				   false);
>> +		memcpy(rp[i].child_addr, rp[i].parent_addr,
>> +		       sizeof(rp[i].child_addr));
>> +
>> +		val64 = resource_size(&res[j]);
>> +		rp[i].size[0] = FIELD_GET(OF_PCI_SIZE_HI, val64);
>> +		rp[i].size[1] = FIELD_GET(OF_PCI_SIZE_LO, val64);
>> +
>> +		i++;
>> +	}
>> +
>> +	ret = of_changeset_add_prop_u32_array(ocs, np, "ranges", (u32 *)rp,
>> +					      i * sizeof(*rp) / sizeof(u32));
>> +	kfree(rp);
>> +
>> +	return ret;
>> +}
>> +
>> +static int of_pci_prop_reg(struct pci_dev *pdev, struct of_changeset *ocs,
>> +			   struct device_node *np)
>> +{
>> +	struct of_pci_addr_pair *reg;
>> +	int i = 1, resno, ret = 0;
>> +	u32 flags, base_addr;
>> +	resource_size_t sz;
>> +
>> +	reg = kcalloc(PCI_STD_NUM_BARS + 1, sizeof(*reg), GFP_KERNEL);
>> +	if (!reg)
>> +		return -ENOMEM;
>> +
>> +	/* configuration space */
>> +	of_pci_set_address(pdev, reg[0].phys_addr, 0, 0, 0, true);
>> +
>> +	base_addr = PCI_BASE_ADDRESS_0;
>> +	for (resno = PCI_STD_RESOURCES; resno <= PCI_STD_RESOURCE_END;
>> +	     resno++, base_addr += 4) {
>> +		sz = pci_resource_len(pdev, resno);
>> +		if (!sz)
>> +			continue;
>> +
>> +		ret = of_pci_get_addr_flags(&pdev->resource[resno], &flags);
>> +		if (ret)
>> +			continue;
>> +
>> +		of_pci_set_address(pdev, reg[i].phys_addr, 0, base_addr, flags,
>> +				   true);
>> +		reg[i].size[0] = FIELD_GET(OF_PCI_SIZE_HI, (u64)sz);
>> +		reg[i].size[1] = FIELD_GET(OF_PCI_SIZE_LO, (u64)sz);
>> +		i++;
>> +	}
>> +
>> +	ret = of_changeset_add_prop_u32_array(ocs, np, "reg", (u32 *)reg,
> I believe this should be 'assigned-addresses' rather than 'reg'. But the
> config space entry above does go in 'reg'.

Do you mean I need to add 'assigned-addresses' in this patch?

For 'reg', it needs to have pairs for memory space or I/O space. Here is 
what I saw in IEEE1275:

"In the first such pair, the phys-addr component shall be the 
Configuration Space address of the
beginning of the function's set of configuration registers (i.e. the 
rrrrrrrr field is zero) and the size component shall
be zero. Each additional (phys-addr, size) pair shall specify the 
address of an addressable region of Memory Space or I/
O Space associated with the function. In these pairs, if the "n" bit of 
phys.hi is 0, reflecting a relocatable address, then
phys.mid and phys.lo specify an address relative to the value of the 
associated base register. In general this value will be
zero, specifying an address range corresponding directly to the 
hardware's. If the "n" bit of phys.hi is 1, reflecting a nonrelocatable 
address, then phys.mid and phys.hi specify an absolute PCI address."

>
>> +					      i * sizeof(*reg) / sizeof(u32));
>> +	kfree(reg);
>> +
>> +	return ret;
>> +}
>> +
>> +static int of_pci_prop_compatible(struct pci_dev *pdev,
>> +				  struct of_changeset *ocs,
>> +				  struct device_node *np)
>> +{
>> +	const char *compat_strs[PROP_COMPAT_NUM] = { 0 };
>> +	int i, ret;
>> +
>> +	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =
>> +		kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
>> +	compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] =
>> +		kasprintf(GFP_KERNEL, "pciclass,%06x", pdev->class);
>> +	compat_strs[PROP_COMPAT_PCICLASS_CCSS] =
>> +		kasprintf(GFP_KERNEL, "pciclass,%04x", pdev->class >> 8);
>> +
>> +	ret = of_changeset_add_prop_string_array(ocs, np, "compatible",
>> +						 compat_strs, PROP_COMPAT_NUM);
>> +	for (i = 0; i < PROP_COMPAT_NUM; i++)
>> +		kfree(compat_strs[i]);
>> +
>> +	return ret;
>> +}
>> +
>> +int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
>> +			  struct device_node *np)
>> +{
>> +	int ret = 0;
>> +
>> +	if (pci_is_bridge(pdev)) {
>> +		ret |= of_changeset_add_prop_string(ocs, np, "device_type",
>> +						    "pci");
>> +		ret |= of_changeset_add_prop_u32(ocs, np, "#address-cells",
>> +						 OF_PCI_ADDRESS_CELLS);
>> +		ret |= of_changeset_add_prop_u32(ocs, np, "#size-cells",
>> +						 OF_PCI_SIZE_CELLS);
>> +		ret |= of_pci_prop_ranges(pdev, ocs, np);
>> +	}
>> +
>> +	ret |= of_pci_prop_reg(pdev, ocs, np);
>> +	ret |= of_pci_prop_compatible(pdev, ocs, np);
>> +
>> +	/*
>> +	 * The added properties will be released when the
>> +	 * changeset is destroyed.
>> +	 */
>> +	return ret;
>> +}
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index 57ddcc59af30..9120ca63a82a 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -1634,7 +1634,8 @@ static int pci_dma_configure(struct device *dev)
>>   	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
>>   
>>   	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
>> -	    bridge->parent->of_node) {
>> +	    bridge->parent->of_node &&
>> +	    !of_node_check_flag(bridge->parent->of_node, OF_DYNAMIC)) {
> Again, I don't think changing behavior for dynamic case is right. I
> haven't dug into what an ACPI+DT case would look like here. (Hint:
> someone that wants this merged can dig into that)

I think this is required. Without dynamic node, on pure DT system, 
has_acpi_companion() will return false. Then "ret" is 0 and the 
following iommu_device_use_default_domain() might be called.

With dynamic node, of_dma_configure() might return error because dma 
related properties are not generated. Thus, "ret" is none zero and the 
following iommu_device_use_default_domain() will be skipped.


Thanks,

Lizhi

>
>>   		ret = of_dma_configure(dev, bridge->parent->of_node, true);
>>   	} else if (has_acpi_companion(bridge)) {
>>   		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index d2c08670a20e..58df456e6c92 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -674,6 +674,25 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
>>   
>>   #endif /* CONFIG_OF */
>>   
>> +struct of_changeset;
>> +
>> +#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
>> +void of_pci_make_dev_node(struct pci_dev *pdev);
>> +void of_pci_remove_node(struct pci_dev *pdev);
>> +int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
>> +			  struct device_node *np);
>> +#else
>> +static inline void
>> +of_pci_make_dev_node(struct pci_dev *pdev)
>> +{
>> +}
>> +
>> +static inline void
>> +of_pci_remove_node(struct pci_dev *pdev)
>> +{
>> +}
>> +#endif /* CONFIG_PCI_DYNAMIC_OF_NODES */
>> +
>>   #ifdef CONFIG_PCIEAER
>>   void pci_no_aer(void);
>>   void pci_aer_init(struct pci_dev *dev);
>> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
>> index 0145aef1b930..1462f2d9b194 100644
>> --- a/drivers/pci/remove.c
>> +++ b/drivers/pci/remove.c
>> @@ -23,6 +23,7 @@ static void pci_stop_dev(struct pci_dev *dev)
>>   		device_release_driver(&dev->dev);
>>   		pci_proc_detach_device(dev);
>>   		pci_remove_sysfs_dev_files(dev);
>> +		of_pci_remove_node(dev);
>>   
>>   		pci_dev_assign_added(dev, false);
>>   	}
>> -- 
>> 2.34.1
>>
