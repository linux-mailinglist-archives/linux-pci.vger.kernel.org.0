Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC20373E690
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jun 2023 19:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjFZReO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 13:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjFZReL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 13:34:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C2410CB;
        Mon, 26 Jun 2023 10:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPkGM64DRGDCN4tSlmzEOf7B5g21Ja1/8x6d1B5e0PzuMpwnynTpyRs4UA3ohv38+RGQy3LjQdgB/jFaQoKNBG4ldkAzBJSK8wckN2V4O+P7Sql8rhH+N6rGDHcv01j6VDHqGzWPH7CBghuWtk0Ee2+hr6SruO7dcSIU7BT6RrqDjYwIHsvNSO/Kw3FR44RAxLWuc+WAa0AbfejLyrskEegoxlC+j4fyRqQiCRvh5WnpaLUCwaQfhEfzOZ1lrAPsHBwFG8LbFhsdvm1DJsHs9r9whtehvxJm7ib+TnpVt+33uQrrEdtoUJXSYvyzVGifPIqXL3pZYcdGykz1JiRYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGKssyxg0Y4NHxjNQCJpC3vMQNBrpmY38gDBfPIYmyo=;
 b=WMeXGLJTpGs5K+hNhIo1bDR2TsCYZW4l0U8034OUUzKpTSwtZ0SQmtpgSFskydh7dbtKFM5ow2VDe+MgJEBZLDfjqTg7nh8jViZj302gwUU1f56K5TfpN8L9vnmILvAg6JUVtK+5H5Ml08Ej5HGnc2jROZKpZaxQk+iI6NzoThc0XpobZZ4hroWvxsit0KFQpYfFQU02SVsKCTNRrNOpnt9RIIkJC92fLLMhlNy915qpf77q1kM6BxTQuEYckOGwoKvA4RKe30t4df+jpWbs2ChcuWysv6U4Z71Eto4i0nLYCaMx9q3UOrgVKO3kX5SwZURiDJCYe+03YCt6HL+ubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGKssyxg0Y4NHxjNQCJpC3vMQNBrpmY38gDBfPIYmyo=;
 b=X2MAdNgZmgq7LPNN1Fx+te3D7UBEUDeWurRziT07gLWSi52+dmO1hSyEzaHsUrLFfgBY+acN+USGZ5iUySuGIg27esnHJU8ZRNWPRSGvm5/C7sgUqkuYvgvDnLTaE3uWH/bIqtrwoEtwedKFk5q7P8bYBjOSaEaZ/3zpxNFHsBo=
Received: from MW4PR04CA0304.namprd04.prod.outlook.com (2603:10b6:303:82::9)
 by DM4PR12MB5373.namprd12.prod.outlook.com (2603:10b6:5:39d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 17:34:07 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::ba) by MW4PR04CA0304.outlook.office365.com
 (2603:10b6:303:82::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 17:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 17:34:07 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 12:34:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 10:34:06 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 26 Jun 2023 12:34:05 -0500
Message-ID: <af9b6bb3-a98d-4fb6-b51e-b48bca61dada@amd.com>
Date:   Mon, 26 Jun 2023 10:34:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V9 2/5] PCI: Create device tree node for selected devices
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>,
        <stefano.stabellini@xilinx.com>
References: <20230621202233.GA115496@bhelgaas>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230621202233.GA115496@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|DM4PR12MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a466155-efce-4106-643f-08db766b8b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIjQcNoFKkMskaap/kP7IAQKN6XLlcrc6nTLPZDlI7n+4NkI22hbDiPS3NsutgKuAX+c1HGfvjNmWKAjMZKqO824E6kAH/cZ8z79QQ19kiZmvRELxgtPTnxgKvsY+jVAgijyTq+ZNhEXEyX2M/nPPnlz2w+HDzKi6//Jrkf6sezBulskYM/4UtzSS7sTS9QvseNxyITkRLqsi5yaMnUle20yd6aMY6Mztm4neOB0OKeqyf5VY6klQW9mlK6/pUDoE3qk83lSsf4qlIIW0HPfJoyVRXg0whOm8kKFblj5uLYxqbDSKN2E/fQThV4eRYYvOQrbFkKe0ZsgkiJocqFVHAUS2k6UM1vci3wwHuJbaB13CHg0I3Ipe03pc5Gz12RgW0j1hagvTOiRpJ2qbXUXaKgK4wAjzK0iBBRBYalLoYCdVSXdLvHhqD701xJ0qR5lj0rp5z6gIYaUs9xQg9U0P3cr+Fab8QEAj0iCEaQ/H//E2wFE6CJGppgi09I2r8zwQX1rL9I5ZLm7CU8/cTdaV9DWySc37z5/w/UdzGNGeU8VaBOOEljqMa/hgkC6LwY8kC6TQduwvRjRc2BWQcTA/M8vjKFjaS+y51pRsPJtPOP1+6drBV/O4l4AxYgzbCVAaQuJAVvziKixmPc1jB/OW8FLjf9NrULeiNwrshhSbPn3CPRCfh3vfUz71LhP7PPsA3m0iWHZcNoirBUbQrXS3fJ2cjOxfV7frQq8aHGrJa5XYq6PUWmfZXO6TsSRMHMl3o+yu8YmfoAMUal8odYSm45gea+1jk1ka8Dqj3jezrp23LjAfmnCvHQRIt6okM7r
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(31686004)(186003)(26005)(2906002)(5660300002)(31696002)(82740400003)(8676002)(36756003)(82310400005)(6916009)(316002)(16576012)(54906003)(86362001)(478600001)(4326008)(81166007)(336012)(47076005)(2616005)(426003)(40460700003)(83380400001)(44832011)(41300700001)(8936002)(70206006)(70586007)(356005)(53546011)(36860700001)(40480700001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 17:34:07.3488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a466155-efce-4106-643f-08db766b8b61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5373
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/21/23 13:22, Bjorn Helgaas wrote:
> In subject, IIUC this patch does not actually create device tree nodes
> for selected devices.  It looks like it:
>
>    - Adds an of_pci_make_dev_node() *interface* that can be used to
>      create this node
>
>    - Creates such a node for *every* bridge
>
>    - Does nothing at all for "selected devices" or the Xilinx Alveo
>
> On Wed, Jun 21, 2023 at 10:34:06AM -0700, Lizhi Hou wrote:
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
> The Alveo details are relevant to the quirk patch but not to *this*
> patch.
>
> But the reason for creating a node for every bridge device *is*
> relevant and should be included here, since that change affects
> everybody that uses OF.
>
>> Apparently, the device tree framework requires a device tree node for the
>> PCI device. Thus, it can generate the device tree nodes for hardware
>> peripherals underneath. Because PCI is self discoverable bus, there might
>> not be a device tree node created for PCI devices. This patch is to add
>> support to generate device tree node for PCI devices.
> s/This patch is to add/Add/
>
>> Added a kernel option. When the option is turned on, the kernel will
>> generate device tree nodes for PCI bridges unconditionally.
> s/Added a kernel option/Add a PCI_DYNAMIC_OF_NODES config option/
> (Be specific, and way what the patch does, not what you did.)
>
>> Initially, the basic properties are added for the dynamically generated
>> device tree nodes.
> Make this specific, e.g., list the specific properties added.

I rewrote the description as below. Does it look better?

     PCI: Create device tree node for bridge

     The PCI endpoint device such as Xilinx Alveo PCI card maps the register
     spaces from multiple hardware peripherals to its PCI BAR. Normally,
     the PCI core discovers devices and BARs using the PCI enumeration 
process.
     There is no infrastructure to discover the hardware peripherals 
that are
     present in a PCI device, and which can be accessed through the PCI 
BARs.

     Apparently, the device tree framework requires a device tree node 
for the
     PCI device. Thus, it can generate the device tree nodes for hardware
     peripherals underneath. Because PCI is self discoverable bus, there 
might
     not be a device tree node created for PCI devices. Furthermore, if 
the PCI
     device is hot pluggable, when it is plugged in, the device tree 
nodes for
     its parent bridges are required. Add support to generate device 
tree node
     for PCI bridges.

     Added an of_pci_make_dev_node() interface that can be used to create
     device tree node for PCI devices.

     Added a PCI_DYNAMIC_OF_NODES config option. When the option is 
turned on,
     the kernel will generate device tree nodes for PCI bridges 
unconditionally.

     Initially, the basic properties are added for the dynamically generated
     device tree nodes which include #address-cells, #size-cells, 
device_type,
     compatible, ranges, reg.

>
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
> Is there a convention for using "devicetree" vs "device tree"?  The
> help message uses both and it would be nice to only use one or the
> other.
Ok. Will use "device tree".
>
>> @@ -501,8 +501,10 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>>   		 * to rely on this function (you ship a firmware that doesn't
>>   		 * create device nodes for all PCI devices).
>>   		 */
>> -		if (ppnode)
>> +		if (ppnode && of_property_present(ppnode, "interrupt-map"))
> Maybe this deserves a comment?  The connection between "interrupt-map"
> and the rest of this patch isn't obvious to me.
>
> Also, it looks like this happens for *everybody*, regardless of
> PCI_DYNAMIC_OF_NODES, which seems a little suspect.  If it's an
> unrelated bug fix it should be a different patch.

This is not a bug fix. The check will distinguish between device tree 
nodes automatically created for pci bridges by this patch with those 
created by a DT based system. With this patch, device tree nodes are 
created for pci bridges, thus ppnode here will be non-zero and we will 
break out of the loop. In order to still use 
pci_swizzle_interrupt_pin(), checking “interrupt-map” for ppnode is 
added here.


After thinking about this more, using “interrupt-map” property may not 
be correct for the cases where ppnode is not dynamically generated and 
it does not have “interrupt-map”. So, I would introduce a new property 
“dynamic” for pci bridge nodes generated dynamically. And change the 
code to: if (ppnode && of_property_present(ppnode, "dynamic")).


Does this make sense?
>
>>   			break;
>> +		else
>> +			ppnode = NULL;
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
> Initialize pci_type = "dev" here instead of way up top:
>
>    if (pci_is_bridge(pdev))
>      pci_type = "pci";
>    else
>      pci_type = "dev";
sure.
>
>> +	name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
>> +			 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>> +static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
>> +			      struct device_node *np)
>> +{
>> +	struct of_pci_range *rp;
>> +	struct resource *res;
>> +	int i = 0, j, ret;
>> +	u32 flags, num;
>> +	u64 val64;
>> +
>> +	if (pci_is_bridge(pdev)) {
>> +		num = PCI_BRIDGE_RESOURCE_NUM;
>> +		res = &pdev->resource[PCI_BRIDGE_RESOURCES];
>> +	} else {
>> +		num = PCI_STD_NUM_BARS;
>> +		res = &pdev->resource[PCI_STD_RESOURCES];
>> +	}
>> +
>> +	rp = kcalloc(num, sizeof(*rp), GFP_KERNEL);
>> +	if (!rp)
>> +		return -ENOMEM;
>> +
>> +	for (j = 0; j < num; j++) {
> Initialize i = 0 here so it's connected with the use:
>
>    for (i = 0, j = 0; j < num; ...)
ok.
>
>> +		if (!resource_size(&res[j]))
>> +			continue;
>> +
>> +		if (of_pci_get_addr_flags(&res[j], &flags))
>> +			continue;
>> +
>> +		val64 = res[j].start;
>> +		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
>> +				   false);
>> +		if (pci_is_bridge(pdev)) {
>> +			memcpy(rp[i].child_addr, rp[i].parent_addr,
>> +			       sizeof(rp[i].child_addr));
>> +		} else {
>> +			/*
>> +			 * For endpoint device, the lower 64-bits of child
>> +			 * address is always zero.
> For the non-OF folks (like me), can you say what the semantics of
> parent_addr vs child_addr are?  I suppose maybe parent_addr is an
> address on the primary side of a bridge and child_addr is the
> corresponding address on the secondary side?
>
> And PCI bridges don't perform address translation, so they are
> identical?
I will add more comments here.
>
>> +			 */
>> +			rp[i].child_addr[0] = j;
>> +		}
>> +int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
>> +			  struct device_node *np)
>> +{
>> +	int ret = 0;
>> +
>> +	if (pci_is_bridge(pdev)) {
>> +		ret |= of_changeset_add_prop_string(ocs, np, "device_type",
>> +						    "pci");
>> +	}
>> +
>> +	ret |= of_pci_prop_ranges(pdev, ocs, np);
>> +	ret |= of_changeset_add_prop_u32(ocs, np, "#address-cells",
>> +					 OF_PCI_ADDRESS_CELLS);
>> +	ret |= of_changeset_add_prop_u32(ocs, np, "#size-cells",
>> +					 OF_PCI_SIZE_CELLS);
>> +	ret |= of_pci_prop_reg(pdev, ocs, np);
>> +	ret |= of_pci_prop_compatible(pdev, ocs, np);
>> +
>> +	/*
>> +	 * The added properties will be released when the
>> +	 * changeset is destroyed.
>> +	 */
> I don't think it's meaningful to OR together the "negative error
> values" returned by all these functions.  Presumably those are things
> like -EINVAL, -ENOMEM, etc.  ORing them together is admittedly
> non-zero, but yields nonsense.
ok. I will return for each failure.
>
>> +	return ret;
>> +static inline void
>> +of_pci_make_dev_node(struct pci_dev *pdev)
>> +{
>> +}
>> +
>> +static inline void
>> +of_pci_remove_node(struct pci_dev *pdev)
>> +{
>> +}
> Pull these functions all onto one line, like other similar stubs in
> this file.
Sure.
>
>> +#endif /* CONFIG_PCI_DYNAMIC_OF_NODES */
> Unnecessary comment since this is all 10 lines.

Will remove it.

Thanks,

Lizhi

