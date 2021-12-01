Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3851A4644A5
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 02:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345580AbhLAB4d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 20:56:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38696 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhLAB4d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 20:56:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9177CB81DC3
        for <linux-pci@vger.kernel.org>; Wed,  1 Dec 2021 01:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACCBC53FCB;
        Wed,  1 Dec 2021 01:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638323591;
        bh=IQ4x5m8J6ycXd4+XrGiJrJYmjGa6k2Zc6P7oiLfbbck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RCRiqVkxKUfINUjIx1V5uJZglwvlQwIinscAOPJ6MTOPriC7tFot3oRHZzJvdS5tX
         hrkzsKEBVYG7Fq2Qz0Xxk18AJtH8u9Knd65iZO1dWPRIb9KXXm9PzOPnGrnlrux2gq
         RHQziJAXVUPsVtnhxLSPFEoX/MwWZsz2W2YnLtGMbWyRiSOdqyywgkkLOyP2a9mxs0
         7YfFFj7RKrS7EKgVxdZBY5dYifXhb0YyW0Ud4X0qDRrEssrMbecvMf55H8o+162zUm
         +W7wmJFWW4eFzvdPZ7J72mX3KpxnuB8G3luffEn5BvW0zqeEqzJKJZNX57K9gFyp3U
         TrQzA5rbiPwUg==
Date:   Tue, 30 Nov 2021 19:53:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH pci-fixes 2/2] Revert "PCI: aardvark: Fix support for
 PCI_ROM_ADDRESS1 on emulated bridge"
Message-ID: <20211201015308.GA2791148@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211130112937.GA3130@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 30, 2021 at 11:29:37AM +0000, Lorenzo Pieralisi wrote:
> On Thu, Nov 25, 2021 at 05:01:48PM +0100, Marek Behún wrote:
> > This reverts commit 239edf686c14a9ff926dec2f350289ed7adfefe2.
> > 
> > PCI Bridge which represents aardvark's PCIe Root Port has Expansion ROM
> > Base Address register at offset 0x30, but its meaning is different than
> > PCI's Expansion ROM BAR register, although the layout is the same.
> > (This is why we thought it does the same thing.)
> > 
> > First: there is no ROM (or part of BootROM) in the A3720 SOC dedicated
> > for PCIe Root Port (or controller in RC mode) containing executable code
> > that would initialize the Root Port, suitable for execution in
> > bootloader (this is how Expansion ROM BAR is used on x86).
> > 
> > Second: in A3720 spec the register (address D0070030) is not documented
> > at all for Root Complex mode, but similar to other BAR registers, it has
> > an "entangled partner" in register D0075920, which does address
> > translation for the BAR in D0070030:
> > - the BAR register sets the address from the view of PCIe bus
> > - the translation register sets the address from the view of the CPU
> > 
> > The other BAR registers also have this entangled partner, and they
> > can be used to:
> > - in RC mode: address-checking on the receive side of the RC (they
> >   can define address ranges for memory accesses from remote Endpoints
> >   to the RC)
> > - in Endpoint mode: allow the remote CPU to access memory on A3720
> > 
> > The Expansion ROM BAR has only the Endpoint part documented, but from
> > the similarities we think that it can also be used in RC mode in that
> > way.
> > 
> > So either Expansion ROM BAR has different meaning (if the hypothesis
> > above is true), or we don't know it's meaning (since it is not
> > documented for RC mode).
> > 
> > Remove the register from the emulated bridge accessing functions.
> > 
> > Fixes: 239edf686c14 ("PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge")
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> 
> Bjorn,
> 
> this reverts a commit we merged the last merge window so it is
> a candidate for one of the upcoming -rcX.

Sure, happy to apply the revert.

What problem does the revert fix?  I assume 239edf686c14 ("PCI:
aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge") broke
something, but the commit log for the revert doesn't say *what*.  How
would one notice that something broke?

> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index baa62cdcaab4..e3001b3b3293 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -32,7 +32,6 @@
> >  #define PCIE_CORE_DEV_ID_REG					0x0
> >  #define PCIE_CORE_CMD_STATUS_REG				0x4
> >  #define PCIE_CORE_DEV_REV_REG					0x8
> > -#define PCIE_CORE_EXP_ROM_BAR_REG				0x30
> >  #define PCIE_CORE_PCIEXP_CAP					0xc0
> >  #define PCIE_CORE_ERR_CAPCTL_REG				0x118
> >  #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
> > @@ -774,10 +773,6 @@ advk_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
> >  		*value = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
> >  		return PCI_BRIDGE_EMUL_HANDLED;
> >  
> > -	case PCI_ROM_ADDRESS1:
> > -		*value = advk_readl(pcie, PCIE_CORE_EXP_ROM_BAR_REG);
> > -		return PCI_BRIDGE_EMUL_HANDLED;
> > -
> >  	case PCI_INTERRUPT_LINE: {
> >  		/*
> >  		 * From the whole 32bit register we support reading from HW only
> > @@ -810,10 +805,6 @@ advk_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
> >  		advk_writel(pcie, new, PCIE_CORE_CMD_STATUS_REG);
> >  		break;
> >  
> > -	case PCI_ROM_ADDRESS1:
> > -		advk_writel(pcie, new, PCIE_CORE_EXP_ROM_BAR_REG);
> > -		break;
> > -
> >  	case PCI_INTERRUPT_LINE:
> >  		if (mask & (PCI_BRIDGE_CTL_BUS_RESET << 16)) {
> >  			u32 val = advk_readl(pcie, PCIE_CORE_CTRL1_REG);
> > -- 
> > 2.32.0
> > 
