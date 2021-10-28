Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3214743E9D4
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 22:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhJ1Upu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 16:45:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230404AbhJ1Upt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 16:45:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 010F660F92;
        Thu, 28 Oct 2021 20:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635453802;
        bh=mr/fiFuUHHMGsLI2l3zIL2nH5rEDnRCnUe6KCd1lMN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N9+9LNZ2U4ZKE+g2/Q8SVwL7l/2PP61G6KhkAj8pwTr1uOg0XdaVBCOGiY3ubrNak
         Q9vh8W0e5R4h2lDckFnRbaPtxPQZKuKH1braOXEqAK2BPBUczcQhRqlFfTDphDRU3S
         wOpRtIEhxD3EA74rjqn9CBNIM/wd1nv6FQLX92JTl8xwBw3heewscCLOg1GI8wwQ6m
         VNrHSf3+VSmtMh4uXT/comXBYYCIZWKwQqsysydf1SdsV5ocMQ0kA0OT+9zVavbHGS
         Utg3Wg6bJRYGOBfcN7LaSBlriljrN/HJucYOsSh4BYYd0PC9DgA06Tdz1dtLN2tIS9
         eXARvtJmVJHWQ==
Date:   Thu, 28 Oct 2021 15:43:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 12/14] PCI: aardvark: Set PCI Bridge Class Code to PCI
 Bridge
Message-ID: <20211028204320.GA292150@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028184557.wbnfdyg3j6yyhhju@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 28, 2021 at 08:45:57PM +0200, Pali Roh�r wrote:
> On Thursday 28 October 2021 19:30:54 Lorenzo Pieralisi wrote:
> > On Tue, Oct 12, 2021 at 06:41:43PM +0200, Marek Beh�n wrote:
> > > From: Pali Roh�r <pali@kernel.org>
> > > 
> > > Aardvark controller has something like config space of a Root Port
> > > available at offset 0x0 of internal registers - these registers are used
> > > for implementation of the emulated bridge.
> > > 
> > > The default value of Class Code of this bridge corresponds to a RAID Mass
> > > storage controller, though. (This is probably intended for when the
> > > controller is used as Endpoint.)
> > > 
> > > Change the Class Code to correspond to a PCI Bridge.
> > > 
> > > Add comment explaining this change.
> > > 
> > > Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
> > > Signed-off-by: Pali Roh�r <pali@kernel.org>
> > > Reviewed-by: Marek Beh�n <kabel@kernel.org>
> > > Signed-off-by: Marek Beh�n <kabel@kernel.org>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  drivers/pci/controller/pci-aardvark.c | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > index 289cd45ed1ec..801657e7da93 100644
> > > --- a/drivers/pci/controller/pci-aardvark.c
> > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > @@ -513,6 +513,26 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> > >  	reg = (PCI_VENDOR_ID_MARVELL << 16) | PCI_VENDOR_ID_MARVELL;
> > >  	advk_writel(pcie, reg, VENDOR_ID_REG);
> > >  
> > > +	/*
> > > +	 * Change Class Code of PCI Bridge device to PCI Bridge (0x600400),
> > > +	 * because the default value is Mass storage controller (0x010400).
> > > +	 *
> > > +	 * Note that this Aardvark PCI Bridge does not have compliant Type 1
> > > +	 * Configuration Space and it even cannot be accessed via Aardvark's
> > > +	 * PCI config space access method. Something like config space is
> > > +	 * available in internal Aardvark registers starting at offset 0x0
> > > +	 * and is reported as Type 0. In range 0x10 - 0x34 it has totally
> > > +	 * different registers.
> > 
> > Is the RP enumerated as a PCI device with type 0 header ?
> 
> Yes.
> 
> And pci-bridge-emul.c "converts" it to type 1 header. So lspci correctly
> see it as type 1.
> 
> > > +	 *
> > > +	 * Therefore driver uses emulation of PCI Bridge which emulates
> > > +	 * access to configuration space via internal Aardvark registers or
> > > +	 * emulated configuration buffer.
> > > +	 */
> > > +	reg = advk_readl(pcie, PCIE_CORE_DEV_REV_REG);
> > > +	reg &= ~0xffffff00;
> > > +	reg |= (PCI_CLASS_BRIDGE_PCI << 8) << 8;
> > > +	advk_writel(pcie, reg, PCIE_CORE_DEV_REV_REG);
> > 
> > I remember Bjorn commenting on something similar in the past - he may
> > have some comments on whether this change is the right thing to do.

No comments from me :)

> Root Port should have PCI Bridge class code, but aardvark HW initialize
> it to class code for Mass Storage (as explained above).
>
> pci-bridge-emul.c again transparently "converts" it to PCI Bridge class
> code.
> 
> Similar issue has also mvebu hw, see email:
> https://lore.kernel.org/linux-pci/20211003120944.3lmwxylnhlp2kfj7@pali/
> 
> And similar fixup was applied for kirkwood:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1dc831bf53fddcc6443f74a39e72db5bcea4f15d
> 
> Are there any issues with it?
> 
> > Lorenzo
> > 
> > >  	/* Disable Root Bridge I/O space, memory space and bus mastering */
> > >  	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
> > >  	reg &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> > > -- 
> > > 2.32.0
> > > 
