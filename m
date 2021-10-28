Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E964B43E896
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 20:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhJ1Ss3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 14:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhJ1Ss2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 14:48:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84BD060C40;
        Thu, 28 Oct 2021 18:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635446760;
        bh=9HS7ckLZaxFi9Kr+8bTuZKM+0YuyECEZrXP/x8cg0p0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvwMs75dN2K2UmOliEdyFRRZsOSsb/75Lf0k7BT38uuDbBFHxqhQXwXNNHXkKcrDb
         +eN54O9MN2FUR0PrpQJluJWH8ChtBw3+NvdgJAIet1+9VzxVbEYAu4lxcjpMvxAsze
         5yqy7M4umna1m8acwekLjsc54gIJj6I0tzukdrYto0+DHs9iU25gK0u2fdB2TqTy13
         RVSYreAnJTPkoXxh6Ozu8W5l1oKFqabidmeersMErghESohVjmDe3wmefmNeRPIeQO
         VRrdiFEKxPpYs7w5tXDL/RKkxMWJ6mdo43uJbg+AetMcavnX1H61Q9sLe3mydOmccy
         ThljdPfWzDM0Q==
Received: by pali.im (Postfix)
        id 0B97E689; Thu, 28 Oct 2021 20:45:57 +0200 (CEST)
Date:   Thu, 28 Oct 2021 20:45:57 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 12/14] PCI: aardvark: Set PCI Bridge Class Code to PCI
 Bridge
Message-ID: <20211028184557.wbnfdyg3j6yyhhju@pali>
References: <20211012164145.14126-1-kabel@kernel.org>
 <20211012164145.14126-13-kabel@kernel.org>
 <20211028183054.GA4746@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028183054.GA4746@lpieralisi>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 28 October 2021 19:30:54 Lorenzo Pieralisi wrote:
> On Tue, Oct 12, 2021 at 06:41:43PM +0200, Marek Behún wrote:
> > From: Pali Rohár <pali@kernel.org>
> > 
> > Aardvark controller has something like config space of a Root Port
> > available at offset 0x0 of internal registers - these registers are used
> > for implementation of the emulated bridge.
> > 
> > The default value of Class Code of this bridge corresponds to a RAID Mass
> > storage controller, though. (This is probably intended for when the
> > controller is used as Endpoint.)
> > 
> > Change the Class Code to correspond to a PCI Bridge.
> > 
> > Add comment explaining this change.
> > 
> > Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Marek Behún <kabel@kernel.org>
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 289cd45ed1ec..801657e7da93 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -513,6 +513,26 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> >  	reg = (PCI_VENDOR_ID_MARVELL << 16) | PCI_VENDOR_ID_MARVELL;
> >  	advk_writel(pcie, reg, VENDOR_ID_REG);
> >  
> > +	/*
> > +	 * Change Class Code of PCI Bridge device to PCI Bridge (0x600400),
> > +	 * because the default value is Mass storage controller (0x010400).
> > +	 *
> > +	 * Note that this Aardvark PCI Bridge does not have compliant Type 1
> > +	 * Configuration Space and it even cannot be accessed via Aardvark's
> > +	 * PCI config space access method. Something like config space is
> > +	 * available in internal Aardvark registers starting at offset 0x0
> > +	 * and is reported as Type 0. In range 0x10 - 0x34 it has totally
> > +	 * different registers.
> 
> Is the RP enumerated as a PCI device with type 0 header ?

Yes.

And pci-bridge-emul.c "converts" it to type 1 header. So lspci correctly
see it as type 1.

> > +	 *
> > +	 * Therefore driver uses emulation of PCI Bridge which emulates
> > +	 * access to configuration space via internal Aardvark registers or
> > +	 * emulated configuration buffer.
> > +	 */
> > +	reg = advk_readl(pcie, PCIE_CORE_DEV_REV_REG);
> > +	reg &= ~0xffffff00;
> > +	reg |= (PCI_CLASS_BRIDGE_PCI << 8) << 8;
> > +	advk_writel(pcie, reg, PCIE_CORE_DEV_REV_REG);
> 
> I remember Bjorn commenting on something similar in the past - he may
> have some comments on whether this change is the right thing to do.

Root Port should have PCI Bridge class code, but aardvark HW initialize
it to class code for Mass Storage (as explained above).

pci-bridge-emul.c again transparently "converts" it to PCI Bridge class
code.

Similar issue has also mvebu hw, see email:
https://lore.kernel.org/linux-pci/20211003120944.3lmwxylnhlp2kfj7@pali/

And similar fixup was applied for kirkwood:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1dc831bf53fddcc6443f74a39e72db5bcea4f15d

Are there any issues with it?

> Lorenzo
> 
> >  	/* Disable Root Bridge I/O space, memory space and bus mastering */
> >  	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
> >  	reg &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> > -- 
> > 2.32.0
> > 
