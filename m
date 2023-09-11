Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D624C79B8CD
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbjIKVix convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 11 Sep 2023 17:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242824AbjIKQXH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 12:23:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F3CCC3;
        Mon, 11 Sep 2023 09:23:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RksMd0jFQz6J7xn;
        Tue, 12 Sep 2023 00:18:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 11 Sep
 2023 17:22:57 +0100
Date:   Mon, 11 Sep 2023 17:22:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Herve Codina <herve.codina@bootlin.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
        <stefano.stabellini@xilinx.com>,
        =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH V13 2/5] PCI: Create device tree node for bridge
Message-ID: <20230911172256.00002ee3@Huawei.com>
In-Reply-To: <20230911164741.00003904@Huawei.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
        <1692120000-46900-3-git-send-email-lizhi.hou@amd.com>
        <20230911154856.000076c3@Huawei.com>
        <20230911173503.0db85e4b@bootlin.com>
        <20230911164741.00003904@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Sep 2023 16:47:41 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 11 Sep 2023 17:35:03 +0200
> Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > Hi Jonathan,
> > 
> > On Mon, 11 Sep 2023 15:48:56 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >   
> > > On Tue, 15 Aug 2023 10:19:57 -0700
> > > Lizhi Hou <lizhi.hou@amd.com> wrote:
> > >     
> > > > The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> > > > spaces from multiple hardware peripherals to its PCI BAR. Normally,
> > > > the PCI core discovers devices and BARs using the PCI enumeration process.
> > > > There is no infrastructure to discover the hardware peripherals that are
> > > > present in a PCI device, and which can be accessed through the PCI BARs.
> > > > 
> > > > Apparently, the device tree framework requires a device tree node for the
> > > > PCI device. Thus, it can generate the device tree nodes for hardware
> > > > peripherals underneath. Because PCI is self discoverable bus, there might
> > > > not be a device tree node created for PCI devices. Furthermore, if the PCI
> > > > device is hot pluggable, when it is plugged in, the device tree nodes for
> > > > its parent bridges are required. Add support to generate device tree node
> > > > for PCI bridges.
> > > > 
> > > > Add an of_pci_make_dev_node() interface that can be used to create device
> > > > tree node for PCI devices.
> > > > 
> > > > Add a PCI_DYNAMIC_OF_NODES config option. When the option is turned on,
> > > > the kernel will generate device tree nodes for PCI bridges unconditionally.
> > > > 
> > > > Initially, add the basic properties for the dynamically generated device
> > > > tree nodes which include #address-cells, #size-cells, device_type,
> > > > compatible, ranges, reg.
> > > > 
> > > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>      
> > > 
> > > I tried to bring this up for a custom PCIe card emulated in QEMU on an ARM ACPI
> > > machine.
> > > 
> > > There are some missing parts that were present in Clements series, but not this
> > > one, particularly creation of the root pci object.
> > > 
> > > Anyhow, hit an intermittent crash...    
> > 
> > I am facing the same issues.
> > 
> > I use a custom PCIe board too but on x86 ACPI machine.
> > 
> > In order to have a working system, I need also to build a DT node for the PCI
> > Host bridge (previously done by Clement's patch) and I am a bit stuck with
> > interrupts.
> > 
> > On your side (ACPI machine) how do you handle this ?  
> 
> That was next on my list to look at now I've gotten the device tree stuff
> to show up.
> 
> > I mean is your PCI host bridge provided by ACPI ? And if so, you probably need
> > to build a DT node for this PCI host bridge and add some interrupt-map,
> > interrupt-map-mask properties in the DT node.  
> 
> Agreed. Potentially some other stuff, but interrupts are the thing that
> showed up first as an issue.
> 
> Given the only reason I'm looking at this is to potentially solve
> a long term CXL / MCTP over I2C upstreaming problem on QEMU side, I've only
> limited time to throw at this (thought it was a short activity
> for a Friday afternoon :)  Will see if it turns out not too be
> too hard to build the rest.
> 
> I can at least boot same system with device tree and check I'm matching
> what is being generated by QEMU.

So, I'm not really sure how to approach this.  It seems 'unwise'/'unworkable' to
instantiate the device tree blob for the interrupt controller we already have
ACPI for and without that I have nothing to route to.

Or can we just ignore the interrupt map stuff completely and instead
rely on instantiating an interrupt controller on the card (that under
the hood uses non DT paths to make interrupts actually happen?)

That path to me seems workable and keeps the boundary of ACPI vs DT
actually getting used within the card specific driver.

Suggestions welcome!

Jonathan

> 
> Jonathan
> 
> 
> > 
> > Best regards,
> > Hervé
> >   
> 

