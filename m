Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB245B677B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 07:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIMFt7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 01:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiIMFt6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 01:49:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017D0BC00;
        Mon, 12 Sep 2022 22:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3i60rCWjWkLOlXl0rVZWTYWWUHXlWxsr1gJFdcfEnBINuBD23p5sK6lqFVnCetOiFvy5xCWBB5gAg+cpLf4wmwF1N26RU9Pmr7SkPpNx6Pfwzm5jfoaN4qY1967VhgiY6mAeTLOUI6IQC/oxhHszc2nMiw7KtkWSqiFG3vw6IdPZqno6LwwNlgcUDcjzgWX6/jNc5XL9v/F4pYb3A5HzBl6El1dfuoDUVR0mEEIxmm072C0EewiNcjrZYlnRjpoHH3nBPicXC5EWSldy9savEqz5wS/XTud4Dvb54kuhMx6YvLn2zOQD5nLZQLX5WtmT2vk0N4d9xj5H5S+Spkdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZfSTbsDcS+nTdKNeQCrSYQVDFdvyhN8W1n7JW0Rb3U=;
 b=NwplxbAn54N3ku60hdm/CVPTvdvibU5NxUbfGMPSvXVvZQbEEKE+awm4btjOhdwS24KLbo7Cpp8PY7LNoWPKGD2bLysu9XhL7CR77UQwUuI1ayG31/Agmo9rt2fVIyp4+MXQ6JL2iF94wH4pfPFxNrLNM4vHN8OUwHctjURuCm5dv4B8mXUbNlUjn80CzFp3CGBSZwypBJT9uyu5YrxVNDrzirxE5UO/DJl0KCmzfxTtYwUVv7ihdQAfqT7VIacokdNFyC7uC1GpWUXAJCQPGVSv4sRRuAgTOvOHmeO2kym+5CS577LBxOtxCf1lpV4kRSYB8gqDSbqV5woylSkxjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZfSTbsDcS+nTdKNeQCrSYQVDFdvyhN8W1n7JW0Rb3U=;
 b=RWUYCde+4mkwHnNVHDblL3Q5HQReNs1QnibpqXRbypnVIVtgbXWL6UdLvofS9b1+KgTzuS/jXjUlie6HfEJXSR+wf8aixmoOUarvD7YEFNf2SIdwiYDsu2NTBwFvu8uKyye55fTkwL2KXko0Y+MfW/fJYjlJCQHqjRFPB8ofdZw=
Received: from CY5PR19CA0030.namprd19.prod.outlook.com (2603:10b6:930:15::26)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 05:49:52 +0000
Received: from CY4PEPF0000B8EB.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::c0) by CY5PR19CA0030.outlook.office365.com
 (2603:10b6:930:15::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Tue, 13 Sep 2022 05:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EB.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Tue, 13 Sep 2022 05:49:52 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 00:49:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 22:49:29 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 00:49:28 -0500
Message-ID: <89f6af46-e995-9456-a7b3-0bbbcb1f70eb@amd.com>
Date:   Mon, 12 Sep 2022 22:49:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC 2/2] pci: create device tree node for selected devices
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <frowand.list@gmail.com>,
        <helgaas@kernel.org>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <1661809417-11370-3-git-send-email-lizhi.hou@amd.com>
 <20220902185403.GA173255-robh@kernel.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20220902185403.GA173255-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EB:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: bf53a335-3c3a-46a9-3df2-08da954bc75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wh7o+nsYerTObVE7oWteDDM6qMgU7jN7I3h3r8yaBMXMyWXGHDTPgrHBkpdyFsmWrZWvkd6KOoJQZAl5ha2bkiciulg114I1tF9+GmCI2MKEOfgSZ+6TQP88bseUTk+IkAop/KfUf2tp+XcuCHhIW66ldAOex6YiXIEpauOJsFCbC4z9V0yY45Yx+PwsRNO23roQaXAPJX45N4EoYfaQyOzPvo+0Ytkik3KfmFz9fPvk0miWvTe1jbo7uDFi6EiPkeWeppnWQ9SH73s7VQPEkstq2r6A9SltnqBpb+J+xcWKSQM8LlBayJgyQDLBnC8hHLyRTGyu0IoCZTsXM5qNawBx+2X7+Fx3k+ImZBfWQgWdv/4yFt2ZI7JOGbTaSktO5Zr2pwBdJv9a5S5psXPawqj+TBSJMDvcB5hEjN25f0rIPrHu8UUrGEsfC6UT0yRCIsV+/5ZFxe9oCsmmWPf/7B47xfY7zCfnt6gRIfrUX/pQkg9pszOj+3SYLPC76DuY5RdhWyTYOzfq3Yw2rng+pZAoyS0uT4LSpDhy3qSt+WXo1LskpPWI5fy7+4dhQKQISHKz+VXSCvJ5Wl0RBVDuyqymoZgR5GS389WsG9kozHYklG2Q98m7fzUm95WXCee2NBARt2UIRGPGlZLHz2yk3PMxEbbsfX5JaLYc5IbUcJd50tk9WJOeNl0HGFj+5tW/BHesskm1gL7Y3D0llLNlGlKgTnyVUiEdobvIxTJyiDLcXTWTGP96E/vjjhBhNZhPiLS1BvaLfMl7cVbCf/G9fLVuJV7kyw0ul32PiRSdTTgK+OSvg1V9dddngKhz0PVqUCIxjz8D+ZFkzi56F0cWcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(41300700001)(4326008)(8676002)(30864003)(82740400003)(426003)(40460700003)(47076005)(86362001)(81166007)(70206006)(44832011)(31696002)(186003)(356005)(31686004)(83380400001)(53546011)(36756003)(2616005)(82310400005)(26005)(54906003)(8936002)(2906002)(336012)(316002)(478600001)(16576012)(6916009)(5660300002)(40480700001)(70586007)(36860700001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 05:49:52.4449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf53a335-3c3a-46a9-3df2-08da954bc75a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/2/22 11:54, Rob Herring wrote:
> On Mon, Aug 29, 2022 at 02:43:37PM -0700, Lizhi Hou wrote:
>> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
>> spaces from multiple hardware peripherals to its PCI BAR. Normally,
>> the PCI core discovers devices and BARs using the PCI enumeration process.
>> And the process does not provide a way to discover the hardware peripherals
>> been mapped to PCI BARs.
> This sentence doesn't make sense.

How about changing it to:

And it does not discover the hardware peripherals that are present in a 
PCI device, and which can be accessed through the PCI BARs.

>
>> For Alveo PCI card, the card firmware provides a
>> flattened device tree to describe the hardware peripherals on its BARs.
>> And the Alveo card driver can load this flattened device tree and leverage
>> device tree framework to generate platform devices for the hardware
>> peripherals eventually.
>>
>> Apparently, the device tree framework requires a device tree node for the
>> PCI device. Thus, it can generate the device tree nodes for hardware
>> peripherals underneath. Because PCI is self discoverable bus, there might
>> not be a device tree node created for PCI devices. This patch is to add
>> support to generate device tree node for PCI devices. It introduces a
>> kernel option. When the option is turned on, the kernel will generate
>> device tree nodes for PCI bridges unconditionally. It will also generate
>> a device tree node for Xilinx Alveo U50 by using PCI quirks. The generated
>> device tree nodes do not have any property. The future patches will add
>> necessary properties.
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Brian Xu <brian.xu@amd.com>
>> ---
>>   drivers/pci/Kconfig         |  11 ++++
>>   drivers/pci/bus.c           |   2 +
>>   drivers/pci/msi/irqdomain.c |   6 +-
>>   drivers/pci/of.c            | 106 ++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci-driver.c    |   3 +-
>>   drivers/pci/pci.h           |  16 ++++++
>>   drivers/pci/quirks.c        |  11 ++++
>>   drivers/pci/remove.c        |   1 +
>>   8 files changed, 153 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 55c028af4bd9..9eca5420330b 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -198,6 +198,17 @@ config PCI_HYPERV
>>   	  The PCI device frontend driver allows the kernel to import arbitrary
>>   	  PCI devices from a PCI backend to support PCI driver domains.
>>   
>> +config PCI_OF
> We already have OF_PCI so this is confusing. Maybe
> 'PCI_DYNAMIC_OF_NODES'.
Sure. I will change it to PCI_DYNAMIC_OF_NODES
>
>
>> +	bool "Device tree node for PCI devices"
>> +	select OF_DYNAMIC
>> +	help
>> +	  This option enables support for generating device tree nodes for some
>> +	  PCI devices. Thus, the driver of this kind can load and overlay
>> +	  flattened device tree for its downstream devices.
>> +
>> +	  Once this option is selected, the device tree nodes will be generated
>> +	  for all PCI/PCIE bridges.
>> +
>>   choice
>>   	prompt "PCI Express hierarchy optimization setting"
>>   	default PCIE_BUS_DEFAULT
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index 3cef835b375f..f752b804ad1f 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -316,6 +316,8 @@ void pci_bus_add_device(struct pci_dev *dev)
>>   	 */
>>   	pcibios_bus_add_device(dev);
>>   	pci_fixup_device(pci_fixup_final, dev);
>> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> Would pci_is_bridge() work here? That would include cardbus, but I think
> that won't matter in practice.
ok. I will use pci_is_bridge() here.
>
>> +		of_pci_make_dev_node(dev);
>
>>   	pci_create_sysfs_dev_files(dev);
>>   	pci_proc_attach_device(dev);
>>   	pci_bridge_d3_update(dev);
>> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
>> index e9cf318e6670..eeaf44169bfd 100644
>> --- a/drivers/pci/msi/irqdomain.c
>> +++ b/drivers/pci/msi/irqdomain.c
>> @@ -230,8 +230,10 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>>   	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
>>   
>>   	of_node = irq_domain_get_of_node(domain);
>> -	rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
>> -			iort_msi_map_id(&pdev->dev, rid);
>> +	if (of_node && !of_node_check_flag(of_node, OF_DYNAMIC))
>> +		rid = of_msi_map_id(&pdev->dev, of_node, rid);
>> +	else
>> +		rid = iort_msi_map_id(&pdev->dev, rid);
>>   
>>   	return rid;
>>   }
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 196834ed44fe..19856d42e147 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -469,6 +469,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>>   		} else {
>>   			/* We found a P2P bridge, check if it has a node */
>>   			ppnode = pci_device_to_OF_node(ppdev);
>> +			if (of_node_check_flag(ppnode, OF_DYNAMIC))
>> +				ppnode = NULL;
>>   		}
>>   
>>   		/*
>> @@ -599,6 +601,110 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>>   	return pci_parse_request_of_pci_ranges(dev, bridge);
>>   }
>>   
>> +#if IS_ENABLED(CONFIG_PCI_OF)
>> +struct of_pci_node {
>> +	struct list_head node;
>> +	struct device_node *dt_node;
>> +	struct of_changeset cset;
>> +};
>> +
>> +static LIST_HEAD(of_pci_node_list);
>> +static DEFINE_MUTEX(of_pci_node_lock);
> There is a 'data' pointer in device_node which you could use to store
> the changeset. Then you wouldn't need a list. (though 'data' is rarely
> used and I hoped to get rid of it)

Ok. So if I understand correctly, in of_pci_removed_node(), it may check 
the flag and assume 'data' is pointing to cset if OF_DYNAMIC is set.

>> +
>> +static void of_pci_free_node(struct of_pci_node *node)
>> +{
>> +	of_changeset_destroy(&node->cset);
>> +	kfree(node->dt_node->full_name);
>> +	if (node->dt_node)
>> +		of_node_put(node->dt_node);
> You free full_name before freeing the node, so you could have a UAF.
> That needs to be taken care of when releasing the node.
Got it. I will fix this.
>
>> +	kfree(node);
>> +}
>> +
>> +void of_pci_remove_node(struct pci_dev *pdev)
>> +{
>> +	struct list_head *ele, *next;
>> +	struct of_pci_node *node;
>> +
>> +	mutex_lock(&of_pci_node_lock);
>> +
>> +	list_for_each_safe(ele, next, &of_pci_node_list) {
>> +		node = list_entry(ele, struct of_pci_node, node);
>> +		if (node->dt_node == pdev->dev.of_node) {
>> +			list_del(&node->node);
>> +			mutex_unlock(&of_pci_node_lock);
>> +			of_pci_free_node(node);
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&of_pci_node_lock);
>> +}
> The above bits aren't really particular to PCI, so they probably
> belong in the DT core code. Frank will probably have thoughts on what
> this should look like.
Sure. Looking forward Frank's comment.
>
>> +
>> +void of_pci_make_dev_node(struct pci_dev *pdev)
>> +{
>> +	const char *pci_type = "dev";
>> +	struct device_node *parent;
>> +	struct of_pci_node *node;
>> +	int ret;
>> +
>> +	/*
>> +	 * if there is already a device tree node linked to this device,
>> +	 * return immediately.
>> +	 */
>> +	if (pci_device_to_OF_node(pdev))
>> +		return;
>> +
>> +	/* check if there is device tree node for parent device */
>> +	if (!pdev->bus->self)
>> +		parent = pdev->bus->dev.of_node;
>> +	else
>> +		parent = pdev->bus->self->dev.of_node;
>> +	if (!parent)
>> +		return;
>> +
>> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
>> +	if (!node)
>> +		return;
>> +	of_changeset_init(&node->cset);
>> +
>> +	node->dt_node = of_node_alloc(NULL);
>> +	if (!node->dt_node) {
>> +		ret = -ENOMEM;
>> +		goto failed;
>> +	}
>> +	node->dt_node->parent = parent;
>> +
>> +	if (pci_is_bridge(pdev))
>> +		pci_type = "pci";
>> +
>> +	node->dt_node->full_name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
>> +					     PCI_SLOT(pdev->devfn),
>> +					     PCI_FUNC(pdev->devfn));
>> +	if (!node->dt_node->full_name) {
>> +		ret = -ENOMEM;
>> +		goto failed;
>> +	}
> Wait, aren't you missing adding properties? You need 'reg',
> 'compatbile', and 'device_type = "pci"' for bridges.
In this patch series nobody consumes the dynamic generated node yet, 
Thus I did not add any property. I will add one or two patches to this 
series for the properties you listed.
>
>> +
>> +	ret = of_changeset_attach_node(&node->cset, node->dt_node);
>> +	if (ret)
>> +		goto failed;
>> +
>> +	ret = of_changeset_apply(&node->cset);
>> +	if (ret)
>> +		goto failed;
>> +
>> +	pdev->dev.of_node = node->dt_node;
>> +
>> +	mutex_lock(&of_pci_node_lock);
>> +	list_add(&node->node, &of_pci_node_list);
>> +	mutex_unlock(&of_pci_node_lock);
>> +
>> +	return;
>> +
>> +failed:
>> +	of_pci_free_node(node);
>> +}
> Pass in the parent node and node name, and this function is not PCI
> specific either.

Ok. How about introducing new functions of_changeset_create_node(), 
of_changeset_create_property_*()  to of/dynamic.c?

So the function could be like:

of_pci_make_dev_node ()

{

     node = of_changeset_create_node (cset, full_name, parent); //alloc  
of_node and add to cset

     of_changeset_create_property_string(cset, node, name, string);  
//alloc of_property and add to cset

     of_changeset_create_property_u32_array(cset, node, name, array, len);

     ....  add more properties;

     of_changeset_apply(cset)

}


Thanks,

Lizhi

>
>> +#endif
>> +
>>   #endif /* CONFIG_PCI */
>>   
>>   /**
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index 49238ddd39ee..1540c4c9a770 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -1628,7 +1628,8 @@ static int pci_dma_configure(struct device *dev)
>>   	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
>>   
>>   	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
>> -	    bridge->parent->of_node) {
>> +	    bridge->parent->of_node &&
>> +	    !of_node_check_flag(bridge->parent->of_node, OF_DYNAMIC)) {
>>   		ret = of_dma_configure(dev, bridge->parent->of_node, true);
>>   	} else if (has_acpi_companion(bridge)) {
>>   		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 785f31086313..319b79920d40 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -678,6 +678,22 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
>>   
>>   #endif /* CONFIG_OF */
>>   
>> +#ifdef CONFIG_PCI_OF
>> +void of_pci_make_dev_node(struct pci_dev *pdev);
>> +void of_pci_remove_node(struct pci_dev *pdev);
>> +
>> +#else
>> +static inline void
>> +of_pci_make_dev_node(struct pci_dev *pdev)
>> +{
>> +}
>> +
>> +static inline void
>> +of_pci_remove_node(struct pci_dev *pdev);
>> +{
>> +}
>> +#endif /* CONFIG_OF_DYNAMIC */
>> +
>>   #ifdef CONFIG_PCIEAER
>>   void pci_no_aer(void);
>>   void pci_aer_init(struct pci_dev *dev);
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 4944798e75b5..58a81e9ff0ed 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -5956,3 +5956,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency
>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
>>   #endif
>> +
>> +/*
>> + * For PCIe device which have multiple downstream devices, its driver may use
>> + * a flattened device tree to describe the downstream devices.
>> + * To overlay the flattened device tree, the PCI device and all its ancestor
>> + * devices need to have device tree nodes on system base device tree. Thus,
>> + * before driver probing, it might need to add a device tree node as the final
>> + * fixup.
>> + */
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
>> index 4c54c75050dc..0eaa9d9a3609 100644
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
>> 2.27.0
>>
>>
