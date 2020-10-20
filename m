Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD22937B5
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 11:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391029AbgJTJNC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 05:13:02 -0400
Received: from foss.arm.com ([217.140.110.172]:48364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390971AbgJTJNC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Oct 2020 05:13:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77E2E101E;
        Tue, 20 Oct 2020 02:13:01 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E2C43F66E;
        Tue, 20 Oct 2020 02:13:00 -0700 (PDT)
Date:   Tue, 20 Oct 2020 10:12:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Message-ID: <20201020091255.GA21678@e121166-lin.cambridge.arm.com>
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com>
 <20201015224738.GA24466@bjorn-Precision-5520>
 <HE1PR0402MB3371CD54946A513C12A5ABC2841E0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <7778161f-b87c-5499-b4e6-de0550bc165c@ti.com>
 <HE1PR0402MB337161161D04C34247C1D876841F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0402MB337161161D04C34247C1D876841F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 20, 2020 at 02:13:13AM +0000, Z.q. Hou wrote:

[...]

> > > For NXP Layerscape platforms (the ls1028a and ls2088a are also NXP
> > Layerscape platform), as the error response to AXI/AHB was enabled, it will
> > get UR error and trigger SError on AXI bus when it accesses a non-existent
> > BDF on a link down bus. I'm not clear about how it happens on dra7xxx and
> > imx6, since they doesn't enable the error response to AXI/AHB.
> > 
> > That's exactly the case with DRA7xx as the error response is enabled by
> > default in the platform integration.
> 
> Got feedback from the imx6 owner that imx6 like the dra7xx has the
> error response enabled by default.  Now it's clear that the problem on
> all these platforms is the same.

Ok. Now the question is: on these platforms we trigger an SError because
the link is down. If the link is down there is no point in enumerating
the PCI hierarchy, is there ? If I am right the link-up check should be
moved at probe time and skip enumeration if the link is down, map_bus()
is not really the place where it should be - having it there is
misleading and it is racy code whatever we do.

We may still merge this code as a temporary workaround but the DWC
drivers should be reworked to skip enumeration if the link is down.

Please let me know if my reading is correct.

Thanks,
Lorenzo

> Thanks,
> Zhiqiang
> 
> > 
> > Thanks
> > Kishon
> > 
> > >
> > >>
> > >> The backtrace below contains a bunch of irrelevant info.  The
> > >> timestamps are pointless.  The backtrace past
> > >> pci_scan_single_device+0x80/0x100 or so really doesn't add anything
> > either.
> > >>
> > >> It'd be nice to have a comment in the code because the code *looks*
> > >> wrong and racy.  Without a hint, everybody who sees it will have to
> > >> dig through the history to see why we tolerate the race.
> > >
> > > Yes, agree, but seems the cause of the SError on dra7xx and imx6 is
> > different from Layerscape platforms, we need to make it clear first.
> > >
> > > Thanks,
> > > Zhiqiang
> > >
> > >>
> > >>> [    0.807773] SError Interrupt on CPU2, code 0xbf000002 -- SError
> > >>> [    0.807775] CPU: 2 PID: 1 Comm: swapper/0 Not tainted
> > >> 5.9.0-rc5-next-20200914-00001-gf965d3ec86fa #67
> > >>> [    0.807776] Hardware name: LS1046A RDB Board (DT)
> > >>> [    0.807777] pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
> > >>> [    0.807778] pc : pci_generic_config_read+0x3c/0xe0
> > >>> [    0.807778] lr : pci_generic_config_read+0x24/0xe0
> > >>> [    0.807779] sp : ffff80001003b7b0
> > >>> [    0.807780] x29: ffff80001003b7b0 x28: ffff80001003ba74
> > >>> [    0.807782] x27: ffff000971d96800 x26: ffff00096e77e0a8
> > >>> [    0.807784] x25: ffff80001003b874 x24: ffff80001003b924
> > >>> [    0.807786] x23: 0000000000000004 x22: 0000000000000000
> > >>> [    0.807788] x21: 0000000000000000 x20: ffff80001003b874
> > >>> [    0.807790] x19: 0000000000000004 x18: ffffffffffffffff
> > >>> [    0.807791] x17: 00000000000000c0 x16: fffffe0025981840
> > >>> [    0.807793] x15: ffffb94c75b69948 x14: 62203a383634203a
> > >>> [    0.807795] x13: 666e6f635f726568 x12: 202c31203d207265
> > >>> [    0.807797] x11: 626d756e3e2d7375 x10: 656877202c307830
> > >>> [    0.807799] x9 : 203d206e66766564 x8 : 0000000000000908
> > >>> [    0.807801] x7 : 0000000000000908 x6 : ffff800010900000
> > >>> [    0.807802] x5 : ffff00096e77e080 x4 : 0000000000000000
> > >>> [    0.807804] x3 : 0000000000000003 x2 : 84fa3440ff7e7000
> > >>> [    0.807806] x1 : 0000000000000000 x0 : ffff800010034000
> > >>> [    0.807808] Kernel panic - not syncing: Asynchronous SError
> > Interrupt
> > >>> [    0.807809] CPU: 2 PID: 1 Comm: swapper/0 Not tainted
> > >> 5.9.0-rc5-next-20200914-00001-gf965d3ec86fa #67
> > >>> [    0.807810] Hardware name: LS1046A RDB Board (DT)
> > >>> [    0.807811] Call trace:
> > >>> [    0.807812]  dump_backtrace+0x0/0x1c0
> > >>> [    0.807813]  show_stack+0x18/0x28
> > >>> [    0.807814]  dump_stack+0xd8/0x134
> > >>> [    0.807814]  panic+0x180/0x398
> > >>> [    0.807815]  add_taint+0x0/0xb0
> > >>> [    0.807816]  arm64_serror_panic+0x78/0x88
> > >>> [    0.807817]  do_serror+0x68/0x180
> > >>> [    0.807818]  el1_error+0x84/0x100
> > >>> [    0.807818]  pci_generic_config_read+0x3c/0xe0
> > >>> [    0.807819]  dw_pcie_rd_other_conf+0x78/0x110
> > >>> [    0.807820]  pci_bus_read_config_dword+0x88/0xe8
> > >>> [    0.807821]  pci_bus_generic_read_dev_vendor_id+0x30/0x1b0
> > >>> [    0.807822]  pci_bus_read_dev_vendor_id+0x4c/0x78
> > >>> [    0.807823]  pci_scan_single_device+0x80/0x100
> > >>> [    0.807824]  pci_scan_slot+0x38/0x130
> > >>> [    0.807825]  pci_scan_child_bus_extend+0x54/0x2a0
> > >>> [    0.807826]  pci_scan_child_bus+0x14/0x20
> > >>> [    0.807827]  pci_scan_bridge_extend+0x230/0x570
> > >>> [    0.807828]  pci_scan_child_bus_extend+0x134/0x2a0
> > >>> [    0.807829]  pci_scan_root_bus_bridge+0x64/0xf0
> > >>> [    0.807829]  pci_host_probe+0x18/0xc8
> > >>> [    0.807830]  dw_pcie_host_init+0x220/0x378
> > >>> [    0.807831]  ls_pcie_probe+0x104/0x140
> > >>> [    0.807832]  platform_drv_probe+0x54/0xa8
> > >>> [    0.807833]  really_probe+0x118/0x3e0
> > >>> [    0.807834]  driver_probe_device+0x5c/0xc0
> > >>> [    0.807835]  device_driver_attach+0x74/0x80
> > >>> [    0.807835]  __driver_attach+0x8c/0xd8
> > >>> [    0.807836]  bus_for_each_dev+0x7c/0xd8
> > >>> [    0.807837]  driver_attach+0x24/0x30
> > >>> [    0.807838]  bus_add_driver+0x154/0x200
> > >>> [    0.807839]  driver_register+0x64/0x120
> > >>> [    0.807839]  __platform_driver_probe+0x7c/0x148
> > >>> [    0.807840]  ls_pcie_driver_init+0x24/0x30
> > >>> [    0.807841]  do_one_initcall+0x60/0x1d8
> > >>> [    0.807842]  kernel_init_freeable+0x1f4/0x24c
> > >>> [    0.807843]  kernel_init+0x14/0x118
> > >>> [    0.807843]  ret_from_fork+0x10/0x34
> > >>> [    0.807854] SMP: stopping secondary CPUs
> > >>> [    0.807855] Kernel Offset: 0x394c64080000 from
> > 0xffff800010000000
> > >>> [    0.807856] PHYS_OFFSET: 0xffff8bfd40000000
> > >>> [    0.807856] CPU features: 0x0240022,21806000
> > >>> [    0.807857] Memory Limit: none
> > >>>
> > >>> Fixes: c2b0c098fbd1 ("PCI: dwc: Use generic config accessors")
> > >>> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >>> ---
> > >>>  drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++++
> > >>>  1 file changed, 6 insertions(+)
> > >>>
> > >>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > >>> b/drivers/pci/controller/dwc/pcie-designware-host.c
> > >>> index c01c9d2fb3f9..e82b518430c5 100644
> > >>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > >>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > >>> @@ -442,6 +442,9 @@ static void __iomem
> > >> *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
> > >>>  	struct pcie_port *pp = bus->sysdata;
> > >>>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > >>>
> > >>> +	if (!dw_pcie_link_up(pci))
> > >>> +		return NULL;
> > >>> +
> > >>>  	busdev = PCIE_ATU_BUS(bus->number) |
> > >> PCIE_ATU_DEV(PCI_SLOT(devfn)) |
> > >>>  		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> > >>>
> > >>> --
> > >>> 2.17.1
> > >>>
