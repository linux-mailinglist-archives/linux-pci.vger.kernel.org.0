Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED0079B59D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350558AbjIKVjL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243192AbjIKQ6V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 12:58:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F787116;
        Mon, 11 Sep 2023 09:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egMeOfAHEbFjcR20EfONq4fxEbge4UZcY6J/th1/d0VkyOsVKm/qwVvfB3bOB20jrwIfEWmTzXrIpeGyFt+KNp87iTn53CKibaDXpqzcTYC8S7H1TCZ3zx5LYwjzp54jiCLo5Y7IXrobiP+qfON4hofMo7bpxcQaDe02SA44Cyh2ipCvA9X7ubSHy2LdbXsm0x4f/690kPIfKI4lY2SfKKGG9OE96gFdXc1yAQR6KdzimkS/yIDwhvM28MPdQ/NO1pEtpQuoVy/1wtYlhe+4Q1YojTLJHxT0IWT2xNrWGMixABIVNbbRbomk35k/wf5vUE45042C6JFvLOA7uz9ybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dm+WLfx5mTuFZBv/UjkMb7jqHSMALpbCw4pb9imL9KU=;
 b=fBTtnmoVz2HJPELtwOgfRJXdTcXSGD+WwzV7g/OM0CRGkzoLheLETbqjMYD07OeFFpbULok/MWzGi0BLGDO37A1KIVfxHwzpuWLrcPfAKF7WPM/2NAM4UIwl5MnG2GYvV0TunlS3whPKLHi/CjYbfBbmarebGr8Ydg8DhjbgnKCMyajiBMYygjLhuZnaI9fDwk+Vl3wf+rQUHH1jil5nvsrop7hI08d/01Vo8pcectw0U4sfa97kcqoPPVKXkLM8pY1GyfwRmaXKPQsyVc7cd3Qr6Ndk92VZyH4z2itrZiECUpqtLTcCAFZtSPku5RfxlRR1yjoA2Gipttz5AqWIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dm+WLfx5mTuFZBv/UjkMb7jqHSMALpbCw4pb9imL9KU=;
 b=rPHYDUATpyBuP6HzapvpkK1uMTWgyp4nEXEDbtZgqWhjEQCyhSucKcbtrRBLYOoz2bVhMCA3WQU+7Wz0SK9Qxj3vB0LkhyRcc8UQWTIO1INbAnvjXKkfGAPBoIuUvA1RQhX6ioGu0w2laLargvPiQnguJAdKw8VUFhPC6hEoL7Y=
Received: from DM6PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:333::12)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 16:58:12 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::de) by DM6PR03CA0079.outlook.office365.com
 (2603:10b6:5:333::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 16:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 16:58:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 11:58:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 11:58:10 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 11 Sep 2023 11:58:09 -0500
Message-ID: <0cc232a2-1743-aeaa-cb87-ce320cc9fc39@amd.com>
Date:   Mon, 11 Sep 2023 09:58:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V13 2/5] PCI: Create device tree node for bridge
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>,
        <stefano.stabellini@xilinx.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
 <1692120000-46900-3-git-send-email-lizhi.hou@amd.com>
 <20230911154856.000076c3@Huawei.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230911154856.000076c3@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|BN9PR12MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: caef1a57-9a8a-4dc0-2d3b-08dbb2e847e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 131yAs/9YlkQqKqAhvXXcVbf30HrVGN1grIh/XjtJG4zLYLdH9UBzQcTvo6f/ocLLcbX3suMkvFIWcvE7HVx2h9jZSdk6+KZPm3+2/qqHqrG3xwlsP7gYCvZsCs2egighyvOvuPofuHG1G6wGPd7OVaCN11uVy4TVYJ77MNrGyYEJ/HvmnC/W5KdyaCDSjCb4PyPBXDP4KUolWFNqGhnEhOLlmpJ6O4JkFzb7pK2wHHEJRr8//lSnfmsQ3bwz11vd/IALYDhMExsaHaUfTCwGddrwzoOJIJhxagJG89q8af1Q6PN1gyFgYzUzNHOXNRwVLnfW2AluGJv8XN9fAv7HJU0LoLAlsM2VEJO3rPkMsmG/0IQldYidrv5ADQd79BmlH6266I2nIRJwLZ2lBQDLpFsywFk1Ojw6BgQSrSwpopmlOzoCZ0K5PsZv1UrQxEDnUfez9LUjGADleKGGI8h4YFl3GczDklqn+DImUJUZwFKE1zCAIunCuEAXfKqbIU5DQI+0ZoeJe2K3XMliw97fAGlWJF4URYMLmYu/4+yFuug0giOQsIUO/czHffi+BqCNgY+yroOfnhnMvqfe4RjdlaHQBTwW48C3OSiHHz839FiqZuN7iqFgD4/Q78a2K0BLsDU4NOFyR9MwP8SP7Dp7oef3KEo9+vcFDpFVWCLUATfCB/Hk7k3W7S0UeVfEq4AIf5J5q+ng20df8OEBuMizZ1rWjv/Xqh9sQSyxF0UVaG8GnKH3aretxcIYqUpSfEkveAjlHRBsOC666WrpyHMbUWSi6h9uOA/hpX/cgYNX+oauJLqiGbj+WdvZdiSPC2IqIi3HUMGoU1UGo3dIu7/ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(53546011)(6666004)(478600001)(83380400001)(2616005)(336012)(2906002)(426003)(54906003)(44832011)(16576012)(6916009)(26005)(316002)(5660300002)(70586007)(41300700001)(8936002)(8676002)(4326008)(70206006)(40460700003)(81166007)(40480700001)(47076005)(36860700001)(36756003)(31696002)(86362001)(82740400003)(356005)(31686004)(21314003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 16:58:11.0387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caef1a57-9a8a-4dc0-2d3b-08dbb2e847e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/11/23 07:48, Jonathan Cameron wrote:
> On Tue, 15 Aug 2023 10:19:57 -0700
> Lizhi Hou <lizhi.hou@amd.com> wrote:
>
>> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
>> spaces from multiple hardware peripherals to its PCI BAR. Normally,
>> the PCI core discovers devices and BARs using the PCI enumeration process.
>> There is no infrastructure to discover the hardware peripherals that are
>> present in a PCI device, and which can be accessed through the PCI BARs.
>>
>> Apparently, the device tree framework requires a device tree node for the
>> PCI device. Thus, it can generate the device tree nodes for hardware
>> peripherals underneath. Because PCI is self discoverable bus, there might
>> not be a device tree node created for PCI devices. Furthermore, if the PCI
>> device is hot pluggable, when it is plugged in, the device tree nodes for
>> its parent bridges are required. Add support to generate device tree node
>> for PCI bridges.
>>
>> Add an of_pci_make_dev_node() interface that can be used to create device
>> tree node for PCI devices.
>>
>> Add a PCI_DYNAMIC_OF_NODES config option. When the option is turned on,
>> the kernel will generate device tree nodes for PCI bridges unconditionally.
>>
>> Initially, add the basic properties for the dynamically generated device
>> tree nodes which include #address-cells, #size-cells, device_type,
>> compatible, ranges, reg.
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> I tried to bring this up for a custom PCIe card emulated in QEMU on an ARM ACPI
> machine.
>
> There are some missing parts that were present in Clements series, but not this
> one, particularly creation of the root pci object.
Thanks for trying this. The entire effort was separated in different 
phases. That is why this patchset does not include creating of_root.
>
> Anyhow, hit an intermittent crash...
>
>
>> ---
>> +static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
>> +				struct device_node *np)
>> +{
>> +	struct of_phandle_args out_irq[OF_PCI_MAX_INT_PIN];
>> +	u32 i, addr_sz[OF_PCI_MAX_INT_PIN], map_sz = 0;
>> +	__be32 laddr[OF_PCI_ADDRESS_CELLS] = { 0 };
>> +	u32 int_map_mask[] = { 0xffff00, 0, 0, 7 };
>> +	struct device_node *pnode;
>> +	struct pci_dev *child;
>> +	u32 *int_map, *mapp;
>> +	int ret;
>> +	u8 pin;
>> +
>> +	pnode = pci_device_to_OF_node(pdev->bus->self);
>> +	if (!pnode)
>> +		pnode = pci_bus_to_OF_node(pdev->bus);
>> +
>> +	if (!pnode) {
>> +		pci_err(pdev, "failed to get parent device node");
>> +		return -EINVAL;
>> +	}
>> +
>> +	laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
>> +	for (pin = 1; pin <= OF_PCI_MAX_INT_PIN;  pin++) {
>> +		i = pin - 1;
>> +		out_irq[i].np = pnode;
>> +		out_irq[i].args_count = 1;
>> +		out_irq[i].args[0] = pin;
>> +		ret = of_irq_parse_raw(laddr, &out_irq[i]);
>> +		if (ret) {
>> +			pci_err(pdev, "parse irq %d failed, ret %d", pin, ret);
>> +			continue;
> If all the interrupt parsing fails we continue ever time...

Did you use Clement's patch to create of_root? I am just wondering if 
parsing irq could fail on a dt-based system.

And yes, the failure case should be handled without crash. I think if 
irq parsing failed,  the interrupt-map pair generation should be skipped.


Thanks,

Lizhi

>
>> +		}
>> +		ret = of_property_read_u32(out_irq[i].np, "#address-cells",
>> +					   &addr_sz[i]);
>> +		if (ret)
>> +			addr_sz[i] = 0;
> This never happens.
>
>> +	}
>> +
>> +	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
>> +		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
>> +			i = pci_swizzle_interrupt_pin(child, pin) - 1;
>> +			map_sz += 5 + addr_sz[i] + out_irq[i].args_count;
> and here we end up derefencing random memory which happens in my case to cause
> a massive allocation sometimes and that fails one of the assertions in the
> allocator.
>
> I'd suggest just setting addr_sz[xxx] = {}; above
> to ensure it's initialized. Then the if(ret) handling should not be needed
> as well as of_property_read_u32 should be side effect free I hope!
>
>> +		}
>> +	}
>> +
>> +	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
>> +	mapp = int_map;
