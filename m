Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948E1397D69
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 02:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhFBACV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 20:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235200AbhFBACU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jun 2021 20:02:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3748D61351;
        Wed,  2 Jun 2021 00:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622592038;
        bh=rVK3YUCtR0dajL4CU3IwF/FVLtLTy2UCEautu/RPTfo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vHZkH7U2/ZS4zaG1BaZontROp5lFSo4/m2MWu1QhkForJ5d9A5s83AeK3Ss0lDrCH
         3+5qz6ti7aicunpRYO92CeSs1fenBUVAdK3DKVqPFYcnqYSmjErbWRP4U/UbGb+g77
         0gIIVLcbWgedd2XPlWmRORzl8S/Xinx9B+6hcYZRlvm0ECXNjtEuJZd++pDPcsOoag
         4k2cVYKA04DKWuTHBnuFnbyQNh1LJ/OLFd8rhwnSj8PVHNegCXA+S9jHOuZupE1n1Y
         IYicthTyqgrbe4pUuVajDfaPDJn0GnOti2GIk9O/cx4wQbjeTzCQxEN3DPImnRraa6
         qEWLfhQLRt4Sw==
Date:   Tue, 1 Jun 2021 19:00:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Disallow retraining link for Atheros chips on
 non-Gen1 PCIe bridges
Message-ID: <20210602000036.GA1973950@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210601211839.b2jlspy3x6lmt4by@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 01, 2021 at 11:18:39PM +0200, Pali Rohár wrote:
> On Tuesday 01 June 2021 15:05:49 Bjorn Helgaas wrote:
> > On Wed, May 05, 2021 at 06:33:57PM +0200, Pali Rohár wrote:
> > > Atheros AR9xxx and QCA9xxx chips have behaviour issues not only after a
> > > bus reset, but also after doing retrain link, if PCIe bridge is not in
> > > GEN1 mode (at 2.5 GT/s speed):
> > > 
> > > - QCA9880 and QCA9890 chips throw a Link Down event and completely
> > >   disappear from the bus and their config space is not accessible
> > >   afterwards.
> > > 
> > > - QCA9377 chip throws a Link Down event followed by Link Up event, the
> > >   config space is accessible and PCI device ID is correct. But trying to
> > >   access chip's I/O space causes Uncorrected (Non-Fatal) AER error,
> > >   followed by Synchronous external abort 96000210 and Segmentation fault
> > >   of insmod while loading ath10k_pci.ko module.
> > > 
> > > - AR9390 chip throws a Link Down event followed by Link Up event, config
> > >   space is accessible, but contains nonsense values. PCI device ID is
> > >   0xABCD which indicates HW bug that chip itself was not able to read
> > >   values from internal EEPROM/OTP.
> > > 
> > > - AR9287 chip throws also Link Down and Link Up events, also has
> > >   accessible config space containing correct values. But ath9k driver
> > >   fails to initialize card from this state as it is unable to access HW
> > >   registers. This also indicates that the chip iself is not able to read
> > >   values from internal EEPROM/OTP.
> > > 
> > > These issues related to PCI device ID 0xABCD and to reading internal
> > > EEPROM/OTP were previously discussed at ath9k-devel mailing list in
> > > following thread:
> > > 
> > >   https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html
> > > 
> > > After experiments we've come up with a solution: it seems that Retrain
> > > link can be called only when using GEN1 PCIe bridge or when PCIe bridge
> > > link speed is forced to 2.5 GT/s. Applying this workaround fixes all
> > > mentioned cards.
> > 
> > I *assume* this means the device was running at > 2.5 GT/s in the
> > first place,
> 
> No. All these Atheros chips are 2.5 GT/s only. It looks like that if
> PCIe Bridge has initial value 5 GT/s (or higher) in PCI_EXP_LNKCAP2
> register and link retraining is activated, something happen which cause
> these Atheros chips to "crash". Looks like that Root Bridge tries to
> change link speed from 2.5 GT/s to 5 GT/s (which is not supported by all
> these Atheros chips).

Oh, perfect.  Then I guess all we need is to restrict these devices to
2.5 GT/s.  And we can just ignore all my rambling about higher speeds
below, so I'll elide them.

> > ...

Except this:

> > This patch implies that the hardware automatically trained to a
> > higher rate after power-on (which I think is what PCIe hardware is
> > *supposed* to do) and something prevents that from succeeding when
> > we retrain, or maybe BIOS did something different than what Linux
> > is doing, or ... something else?

> Tested platforms was also without BIOS and without any other firmware
> which touched PCIe.

The fact that the link came up automatically without any firmware or
software at all is very interesting.  The retrain path is actually
different from a hardware point of view: the power-on path through
LTSSM would normally be Detect, Polling, Configuration, L0; the
retrain path would be L0, Recovery, L0.  So I guess it isn't *too*
surprising that the power-on path could work even if the retrain path
is broken.

I wonder if setting, then clearing, the bridge's Link Disable bit
would work, since that would start again with the LTSSM Detect state,
just like power-on.  But I don't think that would help with this
ASPM/Common Clock issue because I think the link disable would look
like a hot reset to the endpoint, and it would clear the Common Clock
Configuration bit.

So backing up a loooong ways, how much value is there in doing this
retrain at all?  AFAICT the only reason we do it is because we think
the Common Clock Configuration is inconsistent, and we tried to fix
something, and we have to retrain the link to get the devices to
update their L0s and L1 exit latencies.  I guess it's the Slock Clock
(PCI_EXP_LNKSTA_SLC) bits that determines all this, right?  Do you
know those?

I wonder if this could be restructured as a generic quirk in quirks.c
that simply set the bridge's TLS to 2.5 GT/s during enumeration.  Or
would the retrain fail even in that case?

> > > +static int pcie_downgrade_link_to_gen1(struct pci_dev *parent)
> > > +{
> > > +	u16 reg16;
> > > +	u32 reg32;
> > > +	int ret;
> > > +
> > > +	/* Check if link is capable of higher speed than 2.5 GT/s */
> > > +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &reg32);
> > > +	if ((reg32 & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
> > > +		return 0;
> > 
> > I guess this means "if the link is already at 2.5 GT/s, no need to do
> > anything."  Right?
> 
> PCI_EXP_LNKCAP_SLS is maximal supported speed by Bridge. So if bridge
> does not support higher speed, we do not have to do anything.
> 
> > > +	/* Check if link speed can be downgraded to 2.5 GT/s */
> > > +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &reg32);
> > > +	if (!(reg32 & PCI_EXP_LNKCAP2_SLS_2_5GB)) {
> > > +		pci_err(parent, "ASPM: Bridge does not support changing Link Speed to 2.5 GT/s\n");
> > > +		return -EOPNOTSUPP;
> > > +	}
> > 
> > Why is this check needed?  Per PCIe r5.0, sec 8.2.1, all devices must
> > support 2.5 GT/s.
> 
> Because older PCIe devices does not have to support PCI_EXP_LNKCAP2
> register (in which cause they returns zero). And this applies also for
> pci-bridge-emul.c driver. So this check is needed at least for devices
> which use pci-bridge-emul.c driver.

Ugh.  So this depends on the fact that pcie_capability_read_dword()
sets "*val = 0" if PCI_EXP_LNKCAP2 is not implemented.  I have a
half-baked idea that we should be doing "*val = ~0" instead because
that's what we normally get for *hardware* registers that are
implemented.

> > > +	/* Force link speed to 2.5 GT/s */
> > > +	ret = pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
> > > +						 PCI_EXP_LNKCTL2_TLS,
> > > +						 PCI_EXP_LNKCTL2_TLS_2_5GT);
> > > +	if (!ret) {
> > > +		/* Verify that new value was really set */
> > > +		pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &reg16);
> > > +		if ((reg16 & PCI_EXP_LNKCTL2_TLS) != PCI_EXP_LNKCTL2_TLS_2_5GT)
> > > +			ret = -EINVAL;
> > > +	}
> > > +
> > > +	if (ret) {
> > > +		pci_err(parent, "ASPM: Changing Target Link Speed to 2.5 GT/s failed: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	pci_info(parent, "ASPM: Target Link Speed changed to 2.5 GT/s due to quirk\n");
> > > +	return 0;
> > > +}
> > > +
> > >  static bool pcie_retrain_link(struct pcie_link_state *link)
> > >  {
> > >  	struct pci_dev *parent = link->pdev;
> > >  	unsigned long end_jiffies;
> > >  	u16 reg16;
> > >  
> > > +	if ((link->downstream->dev_flags & PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1) &&
> > > +	    pcie_downgrade_link_to_gen1(parent)) {
> > 
> > I assume (correct me if I'm wrong) that this would work equally well
> > if we set the *endpoint's* target link speed to 2.5 GT/s instead of
> > the upstream bridge's?
> 
> I think not. Issue is really when Bridge-end of the link supports higher
> than 2.5 GT/s speed this end tries to increase speed. As device-end of
> the link supports only 2.5 GT/s there is nothing to change to higher
> speed from device-end point of view.

Based on PCIe r5.0, sec 4.2.6, when the link is trained, both devices
start at 2.5 GT/s.  Then they exchange TS Ordered Sets, which
advertise all the data rates supported by each side.  After the link
is operating in L0 at 2.5 GT/s, either side can initiate a change to
the highest supported common data rate.

A device can't initiate a change until it knows the rates supported by
both sides.  So either:

  - The bridge initiated a change because it knows *it* supports a
    higher rate and the Atheros device incorrectly advertised a higher
    rate), or 

  - The Atheros device initiated a change because the bridge
    advertised a higher rate and the Atheros device incorrectly thinks
    that *it* supports a higher rate.

Setting Target Link Speed in the bridge should prevent either case
because it restricts the rates advertised by the bridge in its
training sequences (per sec 7.5.3.19).

Interesting -- also per 7.5.3.19, Target Link Speed is permitted to
have no effect for Upstream Ports (like the one in the Atheros
device).  Probably makes sense since that port is not reachable until
the link is already operating.

Bottom line, I think you do have to do this with the bridge, not the
Atheros device.

> > I think the log messages would make more sense
> > then, since the problem is really with the endpoint, not the parent.
> 
> So... buggy is device (child) end of the link and only bridge (parent)
> end of the link can workaround it. And if bridge end is not capable
> (e.g. because of pci-bridge-emul.c) then it is problem of bridge
> (parent) end.
> 
> > > +		pci_err(parent, "ASPM: Retrain Link at higher speed is disallowed by quirk\n");
> > > +		return false;
> > > +	}
> > > +
> > >  	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> > >  	reg16 |= PCI_EXP_LNKCTL_RL;
> > >  	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 653660e3ba9e..4999ad9d08b8 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -3553,23 +3553,46 @@ static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
> > >  			mellanox_check_broken_intx_masking);
> > >  
> > > -static void quirk_no_bus_reset(struct pci_dev *dev)
> > > +static void quirk_no_bus_reset_and_no_retrain_link(struct pci_dev *dev)
> > >  {
> > > -	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
> > > +	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET |
> > > +			  PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1;
> > >  }
> > >  
> > >  /*
> > > - * Some Atheros AR9xxx and QCA988x chips do not behave after a bus reset.
> > > + * Atheros AR9xxx and QCA9xxx chips do not behave after a bus reset and also
> > > + * after retrain link when PCIe bridge is not in GEN1 mode at 2.5 GT/s speed.
> > >   * The device will throw a Link Down error on AER-capable systems and
> > >   * regardless of AER, config space of the device is never accessible again
> > >   * and typically causes the system to hang or reset when access is attempted.
> > > + * Or if config space is accessible again then it contains only dummy values
> > > + * like fixed PCI device ID 0xABCD or values not initialized at all.
> > > + * Retrain link can be called only when using GEN1 PCIe bridge or when
> > > + * PCIe bridge has forced link speed to 2.5 GT/s via PCI_EXP_LNKCTL2 register.
> > > + * To reset these cards it is required to do PCIe Warm Reset via PERST# pin.
> > >   * https://lore.kernel.org/r/20140923210318.498dacbd@dualc.maya.org/
> > > + * https://lore.kernel.org/r/87h7l8axqp.fsf@toke.dk/
> > > + * https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html
> > >   */
> > > -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030, quirk_no_bus_reset);
> > > -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
> > > -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
> > > -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
> > > -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x002e,
> > > +			 quirk_no_bus_reset_and_no_retrain_link);
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030,
> > > +			 quirk_no_bus_reset_and_no_retrain_link);
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032,
> > > +			 quirk_no_bus_reset_and_no_retrain_link);
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033,
> > > +			 quirk_no_bus_reset_and_no_retrain_link);
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034,
> > > +			 quirk_no_bus_reset_and_no_retrain_link);
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c,
> > > +			 quirk_no_bus_reset_and_no_retrain_link);
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0042,
> > > +			 quirk_no_bus_reset_and_no_retrain_link);
> > > +
> > > +static void quirk_no_bus_reset(struct pci_dev *dev)
> > > +{
> > > +	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
> > > +}
> > >  
> > >  /*
> > >   * Root port on some Cavium CN8xxx chips do not successfully complete a bus
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 86c799c97b77..fdbf7254e4ab 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -227,6 +227,8 @@ enum pci_dev_flags {
> > >  	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
> > >  	/* Don't use Relaxed Ordering for TLPs directed at this device */
> > >  	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> > > +	/* Don't Retrain Link for device when bridge is not in GEN1 mode */
> > > +	PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1 = (__force pci_dev_flags_t) (1 << 12),
> > 
> > I know this is entangled with the existing PCI_DEV_FLAGS_NO_BUS_RESET,
> > but unless there's a better reason to use pci_dev_flags, I'd prefer a
> > new "unsigned retrain_gen1:1" or similar bit.  
> 
> Ok! I can change patch...
> 
> > Whatever you do, I'd like to avoid the double negative of "*no*
> > retrain when *not* gen1."
> 
> Do you have a suggestion for this name? Because I do not know how to
> call this "quirk" in English, so it describes "disallow link retrain
> when link is not at gen1 = 2.5GT/s". Somehow I cannot imagine name
> without double negative words.
> 
> > It does make me wonder whether the bus reset would work on these
> > devices if we set the target link speed back down to 2.5 GT/s.
> 
> Tested and does not work. Secondary bus reset (=Hot Reset) is broken
> also when link is forced to 2.5 GT/s. It looks like that when
> PCI_EXP_LNKCTL2_TLS is not set to 2.5 GT/s when setting
> PCI_EXP_LNKCTL_RL it results in the same effect / issue like calling
> secondary bus reset.
> 
> > >  };
> > >  
> > >  enum pci_irq_reroute_variant {
> > > -- 
> > > 2.20.1
> > > 
