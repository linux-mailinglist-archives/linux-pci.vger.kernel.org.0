Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0787C8D52
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 20:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjJMSuE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 14:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjJMSuC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 14:50:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23D783;
        Fri, 13 Oct 2023 11:50:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30438C433C7;
        Fri, 13 Oct 2023 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697223000;
        bh=qbUhClXwCDstZ4eK3GIEiGy9pkTKB0h+E9ACoIDl4Yw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I/oWOCZGMWXmib/Yf+Ch+QmUNSmIjY2L/Yo61Z3IRTw0ok6+Z9Nklv9tkME6QVWR3
         WTzhexm0DvNCSGG3b+O8nuQSNFRO35ZJorEPFBmr64BCusGm8M+IsQDvVWTWxvxo6B
         DQZIA4b1BntNjSOpACuY3/Q2z9eXV5iqIcNxcAp4vDnal2eSvnrIhj/kIxzsJIFGUw
         PmFM6IxYzf898PbRN8V0shlVfcHBPV+rbsMBdv4VsRhj+PYX59g9RjQa/tXI7/IC0N
         7yiBWmb+/4fk5zJttNBjPNi+38CL1UnptnjzohRHbmhb9aa5kaS+PPhlMjaC8cDiyk
         9/fGs5XEn+fMw==
Date:   Fri, 13 Oct 2023 13:49:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        r-gunasekaran@ti.com, srk@ti.com
Subject: Re: [PATCH] PCI: keystone: Don't enable BAR0 if link is not detected
Message-ID: <20231013184958.GA1118393@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d5c497-c411-1909-3ea4-8eb7aa6e8b1a@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 13, 2023 at 10:36:01AM +0530, Siddharth Vadapalli wrote:
> On 13/10/23 10:33, Siddharth Vadapalli wrote:
> > On 12/10/23 22:13, Bjorn Helgaas wrote:
> >> On Thu, Oct 12, 2023 at 10:15:09AM +0530, Siddharth Vadapalli wrote:
> >>> On 11/10/23 19:16, Bjorn Helgaas wrote:
> > ...
> >>>                                               msix_prepare_msi_desc
> >>> In this function: msix_prepare_msi_desc, the following readl()
> >>> causes completion timeout:
> >>> 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> >>> The completion timeout with the readl is only observed when the link
> >>> is down (No Endpoint device is actually connected to the PCIe
> >>> connector slot).
> >>
> >> Do you know the address ("addr")?  From pci_msix_desc_addr(), it looks
> >> like it should be:
> >>
> >>   desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE
> >>
> >> and desc->pci.mask_base should be dev->msix_base, which we got from
> >> msix_map_region(), which ioremaps part of the BAR indicated by the
> >> MSI-X Table Offset/Table BIR register.
> >>
> >> I wonder if this readl() is being handled as an MMIO access to a
> >> downstream device instead of a Root Port BAR access because it's
> >> inside the Root Port's MMIO window.
> >>
> >> Could you dump out these values just before the readl()?
> >>
> >>   phys_addr inside msix_map_region()
> >>   dev->msix_base
> >>   desc->pci.mask_base
> >>   desc->msi_index
> >>   addr
> > 
> > phys_addr: 0x10102000
> > msix_base: 0xffff80000997a000
> > mask_base: 0xffff80000997a000
> > msi_index: 0
> > addr: 0xffff80000997a000
> > 
> > Also, the details of BAR allocation from the logs are:
> > keystone-pcie 5500000.pcie: host bridge /bus@100000/pcie@5500000 ranges:
> > keystone-pcie 5500000.pcie:       IO 0x0010020000..0x001002ffff -> 0x0000000000
> > keystone-pcie 5500000.pcie:      MEM 0x0010030000..0x0017ffffff -> 0x0010030000
> > keystone-pcie 5500000.pcie: iATU unroll: enabled
> > keystone-pcie 5500000.pcie: iATU regions: 8 ob, 8 ib, align 64K, limit 4G
> > keystone-pcie 5500000.pcie: Phy link never came up
> > keystone-pcie 5500000.pcie: PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [bus 00-ff]
> > pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > pci_bus 0000:00: root bus resource [mem 0x10030000-0x17ffffff]
> > pci 0000:00:00.0: [104c:b00c] type 01 class 0x060400
> > pci 0000:00:00.0: reg 0x10: [mem 0x05500000-0x055fffff]
> > pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> > pci 0000:00:00.0: supports D1
> > pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> > pci 0000:00:00.0: BAR 0: assigned [mem 0x10100000-0x101fffff]
> > pci 0000:00:00.0: BAR 6: assigned [mem 0x10030000-0x1003ffff pref]
> > pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > 
> > The value of phys_addr lies within the range allocated to BAR0.
> > 
> >>   call early_dump_pci_device() on the Root Port
> > 
> > I invoked early_dump_pci_device() within the pci_setup_device() function in
> > drivers/pci/probe.c and the output is:

It'd be better to dump the config space immediately before the readl()
since the PCI core did change some things in the interim.

> > pci 0000:00:00.0: config space:
> > 00000000: 4c 10 0c b0 07 01 10 00 01 00 04 06 00 00 01 00

  PCI_COMMAND = 0x0107
    PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_SERR

> > 00000010: 00 00 50 05 00 00 00 00 00 01 ff 00 00 00 00 00
> > 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

  PCI_IO_BASE            =       0x00 low 4 bits indicate 16-bit addressing
  PCI_IO_LIMIT           =       0x00
  PCI_MEMORY_BASE        =     0x0000
  PCI_MEMORY_LIMIT       =     0x0000
  PCI_PREF_MEMORY_BASE   =     0x0000 low 4 bits indicate 32-bit pref
  PCI_PREF_MEMORY_LIMIT  =     0x0000
  PCI_PREF_BASE_UPPER32  = 0x00000000
  PCI_PREF_LIMIT_UPPER32 = 0x00000000

We can't tell from this whether the prefetchable window is implemented
(but I'm sure keystone *does* implement it).  If PCI_PREF_MEMORY_BASE
and PCI_PREF_MEMORY_LIMIT are read-only zeros, it is not implemented.
If they are writable, it is enabled at the same range as the
non-prefetchable window.

Similarly for the I/O window; we can't tell whether the base/limit are
read-only zero or writable.

So we have these windows that look like they're probably enabled:

  io window   at [io  0x0000-0x0fff]
  mem window  at [mem 0x00000000-0x000fffff]
  pref window at [mem 0x00000000-0x000fffff pref]

No idea whether it makes a difference, but these windows seem
misconfigured.  The default should probably be to make them all
disabled (as in f73eedc90bf7 ("PCI: vmd: Disable bridge window for
domain reset")):

  PCI_IO_BASE            = 0xf0
  PCI_IO_LIMIT           = 0x00
  PCI_MEMORY_BASE        = 0xfff0
  PCI_MEMORY_LIMIT       = 0x0000
  PCI_PREF_MEMORY_BASE   = 0xfff0
  PCI_PREF_MEMORY_LIMIT  = 0x0000
  PCI_PREF_BASE_UPPER32  = 0xffffffff
  PCI_PREF_LIMIT_UPPER32 = 0x00000000

The PCI core should reconfigure and enable them as needed by
downstream devices.

> I also noticed that the value of desc->pci.msix_ctrl obtained from
> the readl is always 0xffffffff irrespective of whether or not an
> endpoint device is connected. This isn't expected right? The only
> difference between the cases where endpoint device is connected and
> isn't connected is the completion timeout.

Right, I wouldn't expect that.  PCI_MSIX_ENTRY_VECTOR_CTRL has a bunch
of reserved bits that should be zero.

I assume MSI-X actually does work for downstream endpoints?  I
wouldn't think anybody would have bothered with
ks_pcie_v3_65_add_bus() unless MSI-X works.

Bjorn
