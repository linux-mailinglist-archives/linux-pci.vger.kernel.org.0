Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA16394CCA
	for <lists+linux-pci@lfdr.de>; Sat, 29 May 2021 17:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhE2PTu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 May 2021 11:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhE2PTt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 May 2021 11:19:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1759611ED;
        Sat, 29 May 2021 15:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622301493;
        bh=8FZAeBSWYNo1uOPripW3vsWibTqtzIx9nusBwNbW5qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4jsFM52uPatr2qbrBGe7FELUMHXEyrMQS7O1g5kyhd9IDj1PkFF98rDUMZM/iQJY
         yerwdeJWmqm7nbRzrfkI4kDQTHvqHqntwbNbJ51/P2wq0j1uPJmzPk6AENIqoclwRK
         sJ+99l2ahBos2ghPFa9sPHXzSF1WeJCE0BebymdZKi44hVKEDwhnhm5wp0ZUnwE3wr
         c2ZroN2VRUcfqqXBNT4sFYZTU0JRTT1KK6j2LJbpPsDXiWZQO1gtW/j+wuGHA80vpp
         yw0sIkFKpakhYh6P/ZQv/vpJ8cJ/vGUVpJcdFFPN0DXVJzmIP5e0jNBz/yRqpoe7gP
         kNeuxeHaGyjmA==
Received: by pali.im (Postfix)
        id 52F23DEA; Sat, 29 May 2021 17:18:10 +0200 (CEST)
Date:   Sat, 29 May 2021 17:18:10 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "pawel.moll@arm.com" <pawel.moll@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
        "galak@codeaurora.org" <galak@codeaurora.org>,
        Michal Simek <michals@xilinx.com>,
        Soren Brinkmann <sorenb@xilinx.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tinamdar@apm.com" <tinamdar@apm.com>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
        "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
        "hauke@hauke-m.de" <hauke@hauke-m.de>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "dhdang@apm.com" <dhdang@apm.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH v12] [PATCH] PCI: Xilinx-NWL-PCIe: Adding support for
 Xilinx NWL PCIe Host Controller
Message-ID: <20210529151810.lloziy67bq35phdx@pali>
References: <1457281934-32068-1-git-send-email-bharatku@xilinx.com>
 <20160311215819.GB16257@localhost>
 <8520D5D51A55D047800579B09414719825889095@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160314170437.GA16729@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160314170437.GA16729@localhost>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 14 March 2016 12:04:37 Bjorn Helgaas wrote:
> On Mon, Mar 14, 2016 at 03:51:01PM +0000, Bharat Kumar Gogada wrote:
> > > On Sun, Mar 06, 2016 at 10:02:14PM +0530, Bharat Kumar Gogada wrote:
> > > > Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> > > 
> > > > +static bool nwl_pcie_valid_device(struct pci_bus *bus, unsigned int
> > > > +devfn) {
> > > > +	struct nwl_pcie *pcie = bus->sysdata;
> > > > +
> > > > +	/* Check link,before accessing downstream ports */
> > > > +	if (bus->number != pcie->root_busno) {
> > > > +		if (!nwl_pcie_link_up(pcie))
> > > > +			return false;
> > > > +	}
> > > 
> > > This seems racy.  What if we check, and the link is up, but the
> > > link goes down before we actually complete the config access?
> > > 
> > > I'm suggesting that this check for the link being up might be
> > > superfluous.
> 
> > Without the above check and also if there is no EP then we are getting kernel stack as follows,

Hello! Now I found this old thread... And I would like to ask, have you
solved this issue somehow? Because very similar problem I observe with
pci-aardvark.c, just it cause Synchronous External Abort on CPU.

> > [    2.654105] PCI host bridge /amba/pcie@fd0e0000 ranges:
> > [    2.659268]   No bus range found for /amba/pcie@fd0e0000, using [bus 00-ff]
> > [    2.666195]   MEM 0xe1000000..0xefffffff -> 0xe1000000
> > [    2.671410] nwl-pcie fd0e0000.pcie: PCI host bridge to bus 0000:00
> > [    2.677436] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [    2.682883] pci_bus 0000:00: root bus resource [mem 0xe1000000-0xefffffff]
> > [    2.690031] Unhandled fault: synchronous external abort (0x96000210) at 0xffffff8000200000
> > [    2.690036] nwl-pcie fd0e0000.pcie: Slave error
> > [    2.702582] Internal error: : 96000210 [#1] SMP
> > [    2.707078] Modules linked in:
> > [    2.710108] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc6+ #5
> > [    2.716332] Hardware name: ZynqMP (DT)
> > [    2.720659] task: ffffffc0798bed00 ti: ffffffc0798c0000 task.ti: ffffffc0798c0000
> > [    2.728102] PC is at pci_generic_config_read+0x38/0x9c
> > [    2.733202] LR is at pci_generic_config_read+0x1c/0x9c
> > .......
> > [    3.322701] [<ffffffc000498b1c>] pci_generic_config_read+0x38/0x9c
> > [    3.328842] [<ffffffc000498f54>] pci_bus_read_config_dword+0x80/0xb0
> > [    3.335156] [<ffffffc00049abd4>] pci_bus_read_dev_vendor_id+0x30/0x104
> > [    3.341643] [<ffffffc00049c5b0>] pci_scan_single_device+0x50/0xc4
> > [    3.347698] [<ffffffc00049c674>] pci_scan_slot+0x50/0xe8
> > [    3.352974] [<ffffffc00049d530>] pci_scan_child_bus+0x30/0xd8
> > [    3.358683] [<ffffffc00049d210>] pci_scan_bridge+0x1fc/0x4ec
> > [    3.364306] [<ffffffc00049d58c>] pci_scan_child_bus+0x8c/0xd8
> > [    3.370016] [<ffffffc0004b2d9c>] nwl_pcie_probe+0x6c4/0x8e0
> > .....
> > 
> > > The hardware should do something reasonable with the config access if it
> > > can't send it down the link.
> >
> > When Link is down and H/W gets a ECAM access request for downstream
> > ports, hardware responds by DECERR (decode error) status on AXI
> > Interface.
> 
> DECERR isn't a PCIe concept, so I assume it's something specific to
> Xilinx.  In the general case of a PCIe switch, a config access that
> targets a device where the link is down should cause an Unsupported
> Request completion (see PCIe spec r3.0, section 2.9.1, quoted below).
> Possibly your Root Complex turns Unsupported Request completions into
> DECERR.

This looks like same design as with pci aardvark hw. PCIe Unsupported
Request or Completion Abort is converted to AXI DECERR (or SLVERR)
which is then reported to CPU. In my case AXI DECERR/SLVERR cause
Synchronous External Abort on CPU.

>   2.9 Link Status Dependencies
>   2.9.1 Transaction Layer Behavior in DL_Down Status
> 
>   DL_Down status indicates that there is no connection with another
>   component on the Link, or that the connection with the other
>   component has been lost and is not recoverable by the Physical or
>   Data Link Layers.
> 
>   For a Downstream Port, DL_Down status is handled by:
>   
>    for Non-Posted Requests, forming completions for any Requests
>    submitted by the device core for Transmission, returning
>    Unsupported Request Completion Status, then discarding the Requests
> 
> Linux expects reads with Unsupported Request completion status to
> return all 1's data to the CPU as in section 2.3.2:
> 
>   2.3.2 Completion Handling Rules
> 
>   Read Data Values with UR Completion Status
> 
>   Some system configuration software depends on reading a data value
>   of all 1’s when a Configuration Read Request is terminated as an
>   Unsupported Request, particularly when probing to determine the
>   existence of a device in the system.  A Root Complex intended for
>   use with software that depends on a read-data value of all 1’s must
>   synthesize this value when UR Completion Status is returned for a
>   Configuration Read Request.
> 
> > So without any EP and without this condition, Linux kernel cannot
> > determine above response from H/W. So the above condition is useful
> > only when no EP is connected.
> > 
> > Now even if the link is up initially, but the link goes down before
> > we actually complete the config access, then H/W responds by DECERR,
> > then Linux kernel might throw similar stack. (We haven't observed
> > this condition yet)
> 
> It'd be hard to hit this race unless you added delay in
> nwl_pcie_map_bus() after nwl_pcie_valid_device(), then removed the
> device during that delay.
> 
> > It looks like we need a different type of hardware response to get
> > rid of this situation, but it's not easy way.  Have you come across
> > this/similar kind of problem anywhere else?  Can you suggest if
> > there is any other way to handle this.
> 
> I'm not a hardware designer, so I don't know what to suggest here.
> The current design does seem like a robustness issue: surprise removal
> of a device may cause this external abort in rare cases.

With pci aardvark I'm able to reproduce this issue with surprise removal
of device.

Bharat, have you somehow resolved this issue? Seems that this kind of HW
design is not rare.
