Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749AB3767E1
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 17:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbhEGP0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 11:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231540AbhEGP0p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 11:26:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 454566141F;
        Fri,  7 May 2021 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620401145;
        bh=guSAf3Z8cwB+uKCKTgY4ghbe6wtYbxXBXcwzEq8gk18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpJjPpCt6H3raOG6Y4go+bJbjhKbfad3MCT1h0u1XNvS6WMgoJ1OVIW/Wr7XtmXpO
         DSbWPLYGbnskgTZbEJkbZuqdmEX06Nr0TRi9cZRpbREYS2l3pIHwsvqGCwjZZFZiGp
         Az9wGrQZmMoXEH3qiDTiDuns/iWK8UIceGevEsGduYGBVuBvuoNGquXEvJa93nNsnY
         BfB0V/lsjdqQ6F6c7PbIiRl7BXo0IV8xEZuBFgyZgZLntzdpKlVjmCQqo8EAvxnky0
         919MVKIg7/4+TihXa/lHcmuqGJdRuwnbLWx6ngctNmULJHEjeRTXzpSrY5IvJyUMrO
         i5eBo5KMSudSw==
Received: by pali.im (Postfix)
        id 38B5C7E0; Fri,  7 May 2021 17:25:42 +0200 (CEST)
Date:   Fri, 7 May 2021 17:25:42 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/42] PCI: aardvark: Fix reporting CRS Software
 Visibility on emulated bridge
Message-ID: <20210507152542.sd54lk7bk56qapf3@pali>
References: <20210506153153.30454-7-pali@kernel.org>
 <20210507130307.GA1448097@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210507130307.GA1448097@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 07 May 2021 08:03:07 Bjorn Helgaas wrote:
> On Thu, May 06, 2021 at 05:31:17PM +0200, Pali Rohár wrote:
> > CRS Software Visibility is supported and always enabled by PIO.
> > Correctly report this information via emulated root bridge.
> 
> Maybe spell out "Configuration Request Retry Status (CRS) Software
> Visibility" once.
> 
> I'm guessing the aardvark hardware spec is proprietary,

Seems so. I have never seen aardvark hardware or software spec. I have
already asked Marvell more times if they can provide me documentation,
but I have not received anything (yet).

I have access to A3720 documentation which is available on Marvell
Customer portal and it contains section about PCIe on A3720. It is
incomplete and mostly buggy.

So most code is written by trial & error method and simply observe how
this hardware behaves. Lot of things I can just guess how should work.
See e.g. long description in patch 7/42 Fix link training.

> but can you at
> least include a reference to the section that says CRSVIS is
> supported and CRSSVE is enabled?

There is nothing :-(

> What is PIO?  I assume this is something other than "programmed I/O"?

I'm not sure what PIO abbreviation means. As I saw that sometimes people
refers to PCIe I/O, sometimes (generic) programmed I/O and sometimes
Posted I/O.

I was probably not accurate in all commit messages as some of these
patches I have written months ago and some just few days ago.

I will try to explain what PIO means in this driver and context of A3720
PCIe. I understand it as a way how to send PCIe messages/packets from
A3720 PCIe controller without need to map PCIe address space. A3720 HW
provides registers into which you fill information what kind of PCIe
message you want to send (e.g. config read/write or memory read/write
transactions, INTx or Error or Slot Power or Vendor message) and then by
another register you trigger sending of this message and waiting until
register indicates that operation finished.

> I'd like the commit log to say something about the effect of this
> change, i.e., why are we doing it?
> 
> For one thing, I expect lspci will now show "RootCtl: ... CRSVisible+"
> and "RootCap: CRSVisible+".

Exactly.

> With PCI_EXP_RTCAP_CRSVIS set, pci_enable_crs() should now try to set
> PCI_EXP_RTCTL_CRSSVE (which I think is a no-op since
> advk_pci_bridge_emul_pcie_conf_write() doesn't do anything with
> PCI_EXP_RTCTL_CRSSVE).

aardvark hook for emul bridge does nothing for PCI_EXP_RTCTL_CRSSVE.

> So AFAICT this has zero effect on the kernel.  Possibly we *should*
> base some kernel behavior on whether PCI_EXP_RTCTL_CRSSVE is set, but
> I don't think we do today.

I understood CRSSVE bit that when it is enabled then root complex starts
returning CRS when trying to read device+vendor id from device which is
not ready yet. And if CRSSVE is not enabled then root complex should
re-issue config request until completes with non-CRS status and do not
return CRS.

And because I have not found any way how to reconfigure aardvark to auto
re-issue config request (which is when CRSSVE is not enabled) started by
PIO, I included this patch which sets CRSSVE bit in emulated bridge to
match expected behavior.

If my understanding is incorrect here, please let me know and I update
and fix this driver.

> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Marek Behún <kabel@kernel.org>
> > Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
> > Cc: stable@vger.kernel.org
> 
> Again, I think this just adds functionality and doesn't fix something
> that used to be broken.
> 
> Per [1], patches for the stable kernel should be for serious issues
> like an oops, hang, data corruption, etc.  I know stable kernel
> maintainers pick up all sorts of other stuff, but that's up to them.
> I try to limit stable tags to reduce the risk of regressing.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?id=v5.11

Ok, no problem. I can omit either CC, Fixes or both tags.

> > ---
> >  drivers/pci/controller/pci-aardvark.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 3f3c72927afb..e297ec9ec390 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -578,6 +578,8 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
> >  	case PCI_EXP_RTCTL: {
> >  		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
> >  		*value = (val & PCIE_MSG_PM_PME_MASK) ? 0 : PCI_EXP_RTCTL_PMEIE;
> > +		*value |= PCI_EXP_RTCTL_CRSSVE;
> > +		*value |= PCI_EXP_RTCAP_CRSVIS << 16;
> >  		return PCI_BRIDGE_EMUL_HANDLED;
> >  	}
> >  
> > @@ -659,6 +661,7 @@ static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
> >  static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> >  {
> >  	struct pci_bridge_emul *bridge = &pcie->bridge;
> > +	int ret;
> >  
> >  	bridge->conf.vendor =
> >  		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff);
> > @@ -682,7 +685,16 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> >  	bridge->data = pcie;
> >  	bridge->ops = &advk_pci_bridge_emul_ops;
> >  
> > -	return pci_bridge_emul_init(bridge, 0);
> > +	/* PCIe config space can be initialized after pci_bridge_emul_init() */
> > +	ret = pci_bridge_emul_init(bridge, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Completion Retry Status is supported and always enabled by PIO */
> 
> "CRS Software Visibility", not "Completion Retry Status".
> 
> The CRSSVE bit is *supposed* to be RW, per spec.  Is it RO on this
> hardware?

As I wrote above, I did not find a way how to turn off CRS.

A3720 spec does not mention any register which could map to PCIe Root
Capabilities Register.

> > +	bridge->pcie_conf.rootctl = cpu_to_le16(PCI_EXP_RTCTL_CRSSVE);
> > +	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
> > +
> > +	return 0;
> >  }
> >  
> >  static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
> > -- 
> > 2.20.1
> > 
