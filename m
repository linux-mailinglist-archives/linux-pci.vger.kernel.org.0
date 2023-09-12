Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D68979CD71
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 12:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjILKLK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 12 Sep 2023 06:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjILKK7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 06:10:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2143172E;
        Tue, 12 Sep 2023 03:10:38 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlK6w4s01z6HJlZ;
        Tue, 12 Sep 2023 18:08:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 11:10:35 +0100
Date:   Tue, 12 Sep 2023 11:10:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>,
        <stefano.stabellini@xilinx.com>,
        =?ISO-8859-1?Q?C?= =?ISO-8859-1?Q?l=E9ment_L=E9ger?= 
        <clement.leger@bootlin.com>
Subject: Re: [PATCH V13 2/5] PCI: Create device tree node for bridge
Message-ID: <20230912111035.00002e9b@Huawei.com>
In-Reply-To: <0cc232a2-1743-aeaa-cb87-ce320cc9fc39@amd.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
        <1692120000-46900-3-git-send-email-lizhi.hou@amd.com>
        <20230911154856.000076c3@Huawei.com>
        <0cc232a2-1743-aeaa-cb87-ce320cc9fc39@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Sep 2023 09:58:04 -0700
Lizhi Hou <lizhi.hou@amd.com> wrote:

> On 9/11/23 07:48, Jonathan Cameron wrote:
> > On Tue, 15 Aug 2023 10:19:57 -0700
> > Lizhi Hou <lizhi.hou@amd.com> wrote:
> >  
> >> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> >> spaces from multiple hardware peripherals to its PCI BAR. Normally,
> >> the PCI core discovers devices and BARs using the PCI enumeration process.
> >> There is no infrastructure to discover the hardware peripherals that are
> >> present in a PCI device, and which can be accessed through the PCI BARs.
> >>
> >> Apparently, the device tree framework requires a device tree node for the
> >> PCI device. Thus, it can generate the device tree nodes for hardware
> >> peripherals underneath. Because PCI is self discoverable bus, there might
> >> not be a device tree node created for PCI devices. Furthermore, if the PCI
> >> device is hot pluggable, when it is plugged in, the device tree nodes for
> >> its parent bridges are required. Add support to generate device tree node
> >> for PCI bridges.
> >>
> >> Add an of_pci_make_dev_node() interface that can be used to create device
> >> tree node for PCI devices.
> >>
> >> Add a PCI_DYNAMIC_OF_NODES config option. When the option is turned on,
> >> the kernel will generate device tree nodes for PCI bridges unconditionally.
> >>
> >> Initially, add the basic properties for the dynamically generated device
> >> tree nodes which include #address-cells, #size-cells, device_type,
> >> compatible, ranges, reg.
> >>
> >> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>  
> > I tried to bring this up for a custom PCIe card emulated in QEMU on an ARM ACPI
> > machine.
> >
> > There are some missing parts that were present in Clements series, but not this
> > one, particularly creation of the root pci object.  
> Thanks for trying this. The entire effort was separated in different 
> phases. That is why this patchset does not include creating of_root.
> >
> > Anyhow, hit an intermittent crash...
> >
> >  
> >> ---
> >> +static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
> >> +				struct device_node *np)
> >> +{
> >> +	struct of_phandle_args out_irq[OF_PCI_MAX_INT_PIN];
> >> +	u32 i, addr_sz[OF_PCI_MAX_INT_PIN], map_sz = 0;
> >> +	__be32 laddr[OF_PCI_ADDRESS_CELLS] = { 0 };
> >> +	u32 int_map_mask[] = { 0xffff00, 0, 0, 7 };
> >> +	struct device_node *pnode;
> >> +	struct pci_dev *child;
> >> +	u32 *int_map, *mapp;
> >> +	int ret;
> >> +	u8 pin;
> >> +
> >> +	pnode = pci_device_to_OF_node(pdev->bus->self);
> >> +	if (!pnode)
> >> +		pnode = pci_bus_to_OF_node(pdev->bus);
> >> +
> >> +	if (!pnode) {
> >> +		pci_err(pdev, "failed to get parent device node");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
> >> +	for (pin = 1; pin <= OF_PCI_MAX_INT_PIN;  pin++) {
> >> +		i = pin - 1;
> >> +		out_irq[i].np = pnode;
> >> +		out_irq[i].args_count = 1;
> >> +		out_irq[i].args[0] = pin;
> >> +		ret = of_irq_parse_raw(laddr, &out_irq[i]);
> >> +		if (ret) {
> >> +			pci_err(pdev, "parse irq %d failed, ret %d", pin, ret);
> >> +			continue;  
> > If all the interrupt parsing fails we continue ever time...  
> 
> Did you use Clement's patch to create of_root? I am just wondering if 
> parsing irq could fail on a dt-based system.

For qemu already have of_root as there is still a device tree, it's just
used to pass some stuff to EDK2 I think. I was carrying the Frank's
series adding a bare device tree, it's just not doing anything on these
systems

I used Clements patch to add the pci root (cleaned up a bit to
match the style of your series more closely).

However, my interest is in ACPI based systems, not DT based ones.

Jonathan


> 
> And yes, the failure case should be handled without crash. I think if 
> irq parsing failed,  the interrupt-map pair generation should be skipped.
> 
> 
> Thanks,
> 
> Lizhi
> 
> >  
> >> +		}
> >> +		ret = of_property_read_u32(out_irq[i].np, "#address-cells",
> >> +					   &addr_sz[i]);
> >> +		if (ret)
> >> +			addr_sz[i] = 0;  
> > This never happens.
> >  
> >> +	}
> >> +
> >> +	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
> >> +		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
> >> +			i = pci_swizzle_interrupt_pin(child, pin) - 1;
> >> +			map_sz += 5 + addr_sz[i] + out_irq[i].args_count;  
> > and here we end up derefencing random memory which happens in my case to cause
> > a massive allocation sometimes and that fails one of the assertions in the
> > allocator.
> >
> > I'd suggest just setting addr_sz[xxx] = {}; above
> > to ensure it's initialized. Then the if(ret) handling should not be needed
> > as well as of_property_read_u32 should be side effect free I hope!
> >  
> >> +		}
> >> +	}
> >> +
> >> +	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
> >> +	mapp = int_map;  

