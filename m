Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568053E0FC6
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 09:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbhHEH7I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 03:59:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236746AbhHEH7H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 03:59:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C0FD6104F;
        Thu,  5 Aug 2021 07:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628150334;
        bh=VLknsodvrM25ND+q2Zj+641W3Gv+7CB4psNdhS3kxz0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VqhbEXN5PI6DwUvKqtkn10XVO4YuIhff+eXWTy/yKXc2ryKsB2ee4ld53RF3jkXiV
         wfNL+0fiIj85UnbD6dOm3jv8FemjEV5wmYRhL2oRRG7FYDMmmsb9lHHQEOYe7dVyFk
         l67GzvhfmmJsTRbgdEtvP0+ja5y7TqMG6YNPlGKGjx0OwwH8gKRsQOMC32nk5yu5uc
         yf98mveCx4kZ/VL53vaQWam1C0obOVcxw2yW3Zs2MTTFuOUufowYDX9IwEfTFLzW5v
         aSe0rAn3UuuXdWONRxFuDb3ZcfFN7JG4XYHuG8peANPnUSelyFhuIjvLxyHzlMtlvw
         guyAgaus/K/wQ==
Date:   Thu, 5 Aug 2021 09:58:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>, Linuxarm <linuxarm@huawei.com>,
        mauro.chehab@huawei.com
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 0/4] DT schema changes for HiKey970 PCIe hardware to
 work
Message-ID: <20210805095848.464cf85c@coco.lan>
In-Reply-To: <20210805094612.2bc2c78f@coco.lan>
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
        <CAL_JsqLjw=+szXWJjGe86tMc51NA-5j=jVSXUAWuKeZRuJNJUg@mail.gmail.com>
        <20210804085045.3dddbb9c@coco.lan>
        <YQrARd7wgYS1nywt@robh.at.kernel.org>
        <20210805094612.2bc2c78f@coco.lan>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Thu, 5 Aug 2021 09:46:12 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Wed, 4 Aug 2021 10:28:53 -0600
> Rob Herring <robh@kernel.org> escreveu:
> 
> > On Wed, Aug 04, 2021 at 08:50:45AM +0200, Mauro Carvalho Chehab wrote:  
> > > Em Tue, 3 Aug 2021 16:11:42 -0600
> > > Rob Herring <robh+dt@kernel.org> escreveu:
> > >     
> > > > On Mon, Aug 2, 2021 at 10:39 PM Mauro Carvalho Chehab
> > > > <mchehab+huawei@kernel.org> wrote:    
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > That's the third version of the DT bindings for Kirin 970 PCIE and its
> > > > > corresponding PHY.
> > > > >
> > > > > It is identical to v2, except by:
> > > > >         -          pcie@7,0 { // Lane 7: Ethernet
> > > > >         +          pcie@7,0 { // Lane 6: Ethernet      
> > > > 
> > > > Can you check whether you have DT node links in sysfs for the PCI
> > > > devices? If you don't, then something is wrong still in the topology
> > > > or the PCI core is failing to set the DT node pointer in struct
> > > > device. Though you don't rely on that currently, we want the topology
> > > > to match. It's possible this never worked on arm/arm64 as mainly
> > > > powerpc relied on this.
> > > >
> > > > I'd like some way to validate the DT matches the PCI topology. We
> > > > could have a tool that generates the DT structure based on the PCI
> > > > topology.    
> > > 
> > > The of_node node link is on those places:
> > > 
> > > 	$ find /sys/devices/platform/soc/f4000000.pcie/ -name of_node
> > > 	/sys/devices/platform/soc/f4000000.pcie/of_node
> > > 	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/of_node
> > > 	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/pci_bus/0000:01/of_node
> > > 	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/pci_bus/0000:00/of_node    
> > 
> > Looks like we're missing some... 
> > 
> > It's not immediately obvious to me what's wrong here. Only the root 
> > bus is getting it's DT node set. The relevant code is pci_scan_device(), 
> > pci_set_of_node() and pci_set_bus_of_node(). Give me a few days to try 
> > to reproduce and debug it.  
> 
> I added a printk on both pci_set_*of_node() functions:
> 
> 	[    4.872991]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
> 	[    4.913806]  (null): pci_set_of_node: of_node: /soc/pcie@f4000000
> 	[    4.978102] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> 	[    4.990622]  (null): pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> 	[    5.052383] pci_bus 0000:02: pci_set_bus_of_node: of_node: (null)
> 	[    5.059263]  (null): pci_set_of_node: of_node: (null)
> 	[    5.085552]  (null): pci_set_of_node: of_node: (null)
> 	[    5.112073]  (null): pci_set_of_node: of_node: (null)
> 	[    5.138320]  (null): pci_set_of_node: of_node: (null)
> 	[    5.164673]  (null): pci_set_of_node: of_node: (null)
> 	[    5.233759] pci_bus 0000:03: pci_set_bus_of_node: of_node: (null)
> 	[    5.240539]  (null): pci_set_of_node: of_node: (null)
> 	[    5.310545] pci_bus 0000:04: pci_set_bus_of_node: of_node: (null)
> 	[    5.324719] pci_bus 0000:05: pci_set_bus_of_node: of_node: (null)
> 	[    5.338914] pci_bus 0000:06: pci_set_bus_of_node: of_node: (null)
> 	[    5.345516]  (null): pci_set_of_node: of_node: (null)
> 	[    5.415795] pci_bus 0000:07: pci_set_bus_of_node: of_node: (null)

The enclosed patch makes the above a clearer:

	[    4.800975]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
	[    4.855983] pci 0000:00:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000
	[    4.879169] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    4.900602] pci 0000:01:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    4.953086] pci_bus 0000:02: pci_set_bus_of_node: of_node: (null)
	[    4.968821] pci 0000:02:01.0: pci_set_of_node: of_node: (null)
	[    5.003538] pci 0000:02:04.0: pci_set_of_node: of_node: (null)
	[    5.041348] pci 0000:02:05.0: pci_set_of_node: of_node: (null)
	[    5.092770] pci 0000:02:07.0: pci_set_of_node: of_node: (null)
	[    5.118298] pci 0000:02:09.0: pci_set_of_node: of_node: (null)
	[    5.178215] pci_bus 0000:03: pci_set_bus_of_node: of_node: (null)
	[    5.198433] pci 0000:03:00.0: pci_set_of_node: of_node: (null)
	[    5.233330] pci_bus 0000:04: pci_set_bus_of_node: of_node: (null)
	[    5.247071] pci_bus 0000:05: pci_set_bus_of_node: of_node: (null)
	[    5.260898] pci_bus 0000:06: pci_set_bus_of_node: of_node: (null)
	[    5.293764] pci 0000:06:00.0: pci_set_of_node: of_node: (null)
	[    5.332808] pci_bus 0000:07: pci_set_bus_of_node: of_node: (null)

> 
> It sounds that the parent is missing when pci_set_bus_of_node() is
> called on some places. I'll try to identify why.
> 
> Thanks,
> Mauro

Thanks,
Mauro

[PATCH] pci: setup PCI before setting the OF node

With this change, it is easier to add a debug printk at
pci_set_of_node() in order to address possible issues.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 79177ac37880..c5dfc1afb1d3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2374,15 +2374,14 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
 
-	pci_set_of_node(dev);
-
 	if (pci_setup_device(dev)) {
-		pci_release_of_node(dev);
 		pci_bus_put(dev->bus);
 		kfree(dev);
 		return NULL;
 	}
 
+	pci_set_of_node(dev);
+
 	return dev;
 }
 


