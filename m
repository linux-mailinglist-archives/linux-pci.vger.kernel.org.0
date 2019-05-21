Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA5253D8
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfEUPZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 11:25:59 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56913 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbfEUPZ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 11:25:59 -0400
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 8049960013;
        Tue, 21 May 2019 15:25:51 +0000 (UTC)
Date:   Tue, 21 May 2019 17:34:11 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ellie Reeves <ellierevves@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Use LTSSM state to build link training
 flag
Message-ID: <20190521153410.GB2754@voidbox.localdomain>
References: <20190316161243.29517-1-repk@triplefau.lt>
 <20190425110830.GC10833@e121166-lin.cambridge.arm.com>
 <20190425142353.GO2754@voidbox.localdomain>
 <20190425150640.GA20770@e121166-lin.cambridge.arm.com>
 <20190429153234.GS2754@voidbox.localdomain>
 <20190430113427.GA18742@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430113427.GA18742@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Tue, Apr 30, 2019 at 12:34:27PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Apr 29, 2019 at 05:32:35PM +0200, Remi Pommarel wrote:
> > Hi Lorenzo,
> > 
> > Sorry for duplicates I forgot to include everyone.
> > 
> > On Thu, Apr 25, 2019 at 04:06:40PM +0100, Lorenzo Pieralisi wrote:
> > > On Thu, Apr 25, 2019 at 04:23:53PM +0200, Remi Pommarel wrote:
> > > > Hi Lorenzo,
> > > > 
> > > > On Thu, Apr 25, 2019 at 12:08:30PM +0100, Lorenzo Pieralisi wrote:
> > > > > On Sat, Mar 16, 2019 at 05:12:43PM +0100, Remi Pommarel wrote:
> > > > > > The PCI_EXP_LNKSTA_LT flag in the emulated root device's PCI_EXP_LNKSTA
> > > > > > config register does not reflect the actual link training state and is
> > > > > > always cleared. The Link Training and Status State Machine (LTSSM) flag
> > > > > > in LMI config register could be used as a link training indicator.
> > > > > > Indeed if the LTSSM is in L0 or upper state then link training has
> > > > > > completed (see [1]).
> > > > > > 
> > > > > > Unfortunately because setting the PCI_EXP_LINCTL_RL flag does not
> > > > > > instantly imply a LTSSM state change (e.g. L0s to recovery state
> > > > > > transition takes some time), LTSSM can be in L0 but link training has
> > > > > > not finished yet. Thus a lower L0 LTSSM state followed by a L0 or upper
> > > > > > state sequence has to be seen to be sure that link training has been
> > > > > > done.
> > > > > 
> > > > > Hi Remi,
> > > > > 
> > > > > I am a bit confused, so you are saying that the LTSSM flag in the
> > > > > LMI config register can't be used to detect when training is completed ?
> > > > 
> > > > Not exactly, I am saying that PCI_EXP_LNKSTA_LT from PCI_EXP_LNKSTA
> > > > register can't be used with this hardware, but can be emulated with
> > > > LTSSM flag.
> > > > 
> > > > > 
> > > > > Certainly it can't be used by ASPM core that relies on:
> > > > > 
> > > > > PCI_EXP_LNKSTA_LT flag
> > > > > 
> > > > > in the PCI_EXP_LNKSTA register, and that's what you are setting through
> > > > > this timeout mechanism IIUC.
> > > > > 
> > > > > Please elaborate on that.
> > > > 
> > > > The problem here is that the hardware does not change PCI_EXP_LNKSTA_LT
> > > > at all. So in order to support link re-training feature we need to
> > > > emulate this flag. To do so LTSSM flag can be used.
> > > 
> > > Understood.
> > > 
> > > > Indeed we can set the emulated PCI_EXP_LNKSTA_LT as soon as re-training
> > > > is asked and wait for LTSSM flag to be back to a configured state
> > > > (e.g. L0, L0s) before clearing it.
> > > 
> > > The check for the LTSSM is carried out through advk_pcie_link_up()
> > > (ie register CFG_REG), correct ?
> > > 
> > 
> > Yes that is correct.
> > 
> > > > The problem with that is that LTSSM flag does not change instantly after
> > > > link re-training has been asked, and will stay in configured state for a
> > > > small amount of time. So the idea is to poll the LTSSM flag and wait for
> > > > it to enter a recovery state then waiting for it to be back in
> > > > configured state.
> > > 
> > > When you say "poll" you mean checking advk_pcie_link_up() ?
> > > 
> > 
> > I mean checking advk_pcie_link_up() in a loop. This loop is done by the
> > user (e.g. ASPM core). ASPM core waits for PCI_EXP_LNKSTA_LT to be
> > cleared in pcie_aspm_configure_common_clock() just after it has set
> > PCI_EXP_LNKCTL_RL.
> > 
> > So the idea was to check advk_pcie_link_up() each time ASPM core checks
> > the PCI_EXP_LNKSTA_LT flag. Please see below patch for an alternative
> > to that.
> > 
> > > More below on the code.
> > > 
> > > > The timeout is only here as a fallback in the unlikely event that we
> > > > missed the LTSSM flag entering recovery state.
> > > > 
> > > > > 
> > > > > I am picking Bjorn's brain on this patch since what you are doing
> > > > > seems quite arbitrary and honestly it is a bit of a hack.
> > > > 
> > > > Yes, sorry, it is a bit of a hack because I try to workaround a
> > > > hardware issue.
> > > 
> > > No problems, it is not your fault.
> > > > 
> > > > Please note that vendor has been contacted about this in the meantime
> > > > and answered the following:
> > > > 
> > > > "FW can poll LTSSM state equals any of the following values: 0xB or 0xD
> > > > or 0xC or 0xE. After that, polls for LTSSM equals 0x10. For your
> > > > information, LTSSM will transit from 0x10 -> 0xB -> 0xD -> 0xC or 0xE
> > > > ........... -> 0x10".
> > > > 
> > > > It is basically what this patch does, I've just added a timeout fallback
> > > > to not poll LTSSM state forever if its transition to 0xB, 0xD, 0xC or
> > > > 0xE has been missed.
> > > 
> > > When you say "missed" you mean advk_pcie_link_up() returning true, right ?
> > > 
> > 
> > Not exactly, I mean that LTSSM had the time to go down and back up
> > between advk_pcie_link_up() because, for example, ASPM core loop took
> > too much time between two PCI_EXP_LNKSTA_LT flag checks.
> > 
> > > [...]
> > > 
> > > > > > +static int advk_pcie_link_retraining(struct advk_pcie *pcie)
> > > > > > +{
> > > > > > +	if (!advk_pcie_link_up(pcie)) {
> > > 
> > > That's the bit I find confusing. Is this check here to detect if the
> > > link went through the sequence below ? Should not it be carried
> > > out only if (pcie->rl_asked == 1) ?
> > > 
> > > "... LTSSM will transit from 0x10 -> 0xB -> 0xD -> 0xC or 0xE
> > >  ........... -> 0x10".
> > 
> > Yes it is the check to detect the sequence. advk_pcie_link_up() returns
> > false if LTSSM <= 0x10.
> > 
> > This cannot be done only if (pcie->rl_asked == 1) because I still
> > want this function to return 1 if link is still down.
> > 
> > > 
> > > > > > +		pcie->rl_asked = 0;
> > > 
> > > Why ?
> > > 
> > 
> > rl_asked is not a good name, I could have called it
> > pcie->wait_for_link_down instead. So if advk_pcie_link_up() returns
> > false that means that we don't need to wait for link being down any more
> > and just wait for (LTSSM >= 0x10). In this case the delay is not needed.
> > 
> > > > > > +		return 1;
> > > > > > +	}
> > > > > > +
> > > > > > +	if (pcie->rl_asked && time_before(jiffies, pcie->rl_deadline))
> > > > > > +		return 1;
> > > 
> > > This ensures that if the LTSSM >= 0x10 we still wait for a delay before
> > > considering the link up (because I suppose, after asking a retraining
> > > it takes a while for the LTSSM state to become < 0x10), correct ?
> > 
> > Yes it takes a while to become < 0x10 after retraining hence the delay.
> > But here we don't need to always wait for a delay. Indeed if we've
> > already seen the link being < 0x10 (i.e if "pcie->rl_asked == 0") and
> > if after that link is >= 0x10 then we know that retraining process has
> > finished.
> > 
> > Anyway I did it this way because I wanted to keep
> > advk_pci_bridge_emul_pcie_conf_write() from polling. But this is
> > obviously a bad reason as it makes the code way too complex and relies
> > on user (ASPM core) to do the poll instead.
> > 
> > So if you find the following better I'll send a v3 with that:
> > 
> > ---
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index eb58dfdaba1b..67e8ae4e313e 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -180,6 +180,9 @@
> >  #define LINK_WAIT_MAX_RETRIES		10
> >  #define LINK_WAIT_USLEEP_MIN		90000
> >  #define LINK_WAIT_USLEEP_MAX		100000
> > +#define RETRAIN_WAIT_MAX_RETRIES	20
> > +#define RETRAIN_WAIT_USLEEP_MIN		2000
> > +#define RETRAIN_WAIT_USLEEP_MAX		5000
> >  
> >  #define MSI_IRQ_NUM			32
> >  
> > @@ -239,6 +242,17 @@ static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
> >  	return -ETIMEDOUT;
> >  }
> >  
> > +static void advk_pcie_wait_for_retrain(struct advk_pcie *pcie)
> > +{
> > +	size_t retries;
> > +
> > +	for (retries = 0; retries < RETRAIN_WAIT_MAX_RETRIES; ++retries) {
> > +		if (!advk_pcie_link_up(pcie))
> > +			break;
> > +		usleep_range(RETRAIN_WAIT_USLEEP_MIN, RETRAIN_WAIT_USLEEP_MAX);
> > +	}
> > +}
> > +
> >  static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> >  {
> >  	u32 reg;
> > @@ -426,11 +440,19 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
> >  		return PCI_BRIDGE_EMUL_HANDLED;
> >  	}
> >  
> > +	case PCI_EXP_LNKCTL: {
> > +		u32 val = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg) &
> > +			~(PCI_EXP_LNKSTA_LT << 16);
> > +		if (!advk_pcie_link_up(pcie))
> 
> Is this correct ?
> 
> "PCI Express Base Specification Rev4.0 Version 1.0" page 758
> 
> "Link Training: this read-only bit indicates that
> the physical layer LTSSM is in the Configuration or
> Recovery state or that 1b was written to the Retrain
> Link..."
> 
> Isn't that a subset of states for which !advk_pcie_link_up()
> return true ?

Yes you are right, unfortunately I don't know exactly what the LTSSM
value for Configuration or Recovery states. All I can observe is that
LTSSM goes to 0xb which is likely either Recovery or Configuration
state.

Sorry for long response delay, I was waiting for Marvell answer on that
specific subject but I don't think it is going to come anytime soon. So
in the meantime I suggest we could either use !advk_pcie_link_up() or
check for LTSSM != 0xb. Would you be ok with that ?

Thanks,

-- 
Remi
