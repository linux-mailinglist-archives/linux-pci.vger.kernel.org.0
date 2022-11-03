Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A95618CE2
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 00:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKCXlU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 19:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKCXlT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 19:41:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274D817888;
        Thu,  3 Nov 2022 16:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEE94B82A82;
        Thu,  3 Nov 2022 23:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D302C433D7;
        Thu,  3 Nov 2022 23:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667518875;
        bh=KUDx7ONoN3ko06OzZmixvulJITlwhp2I5+/A5L6H2hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LoRsHuDHqV6kBH8fulg5STsgC8v6T41Mwn26zrvKxBm1lkR1cjiwu4SK7vOu23sD/
         mtpShtln8tvrddmvsPl6Coyz8ZYq+dRHMex885ssnxmoIif8gMHkawnRpw+aIGMlHT
         hDFrQXw03KrM/2YGFORP9KtLkf/MCZqSgh8BRkpAwIGnRNWacCk+uWaKeZ78Zusskw
         QsI5urwP+Rl+Gkb7EORACTN+tmUd3q7RlIR5ts66V/wVqpRw9nxh4vVLcolgjLfYds
         7ObXA2kXs03zk0w29MXTxpdo5YUNHvp14EOarMdDVwUMKe0lUebvlZE7wA7RAszZlm
         GCIEX5z3nCZ3g==
Received: by pali.im (Postfix)
        id E24A387A; Fri,  4 Nov 2022 00:41:11 +0100 (CET)
Date:   Fri, 4 Nov 2022 00:41:11 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <bhelgaas@google.com>, Stefan Roese <sr@denx.de>,
        Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: Work around PCIe link training failures
Message-ID: <20221103234111.ykexx733fty7g3da@pali>
References: <alpine.DEB.2.21.2209130050380.60554@angie.orcam.me.uk>
 <20221103231335.GA51625@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103231335.GA51625@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 03 November 2022 18:13:35 Bjorn Helgaas wrote:
> [+cc Pali]
> 
> On Sat, Sep 17, 2022 at 01:03:38PM +0100, Maciej W. Rozycki wrote:
> > Attempt to handle cases such as with a downstream port of the ASMedia 
> > ASM2824 PCIe switch where link training never completes and the link 
> > continues switching between speeds indefinitely with the data link layer 
> > never reaching the active state.
> > 
> > It has been observed with a downstream port of the ASMedia ASM2824 Gen 3 
> > switch wired to the upstream port of the Pericom PI7C9X2G304 Gen 2 
> > switch, using a Delock Riser Card PCI Express x1 > 2 x PCIe x1 device, 
> > P/N 41433, wired to a SiFive HiFive Unmatched board.  In this setup the 
> > switches are supposed to negotiate the link speed of preferably 5.0GT/s, 
> > falling back to 2.5GT/s.
> > 
> > Instead the link continues oscillating between the two speeds, at the 
> > rate of 34-35 times per second, with link training reported repeatedly 
> > active ~84% of the time.  Forcibly limiting the target link speed to 
> > 2.5GT/s with the upstream ASM2824 device however makes the two switches 
> > communicate correctly.  Removing the speed restriction afterwards makes 
> > the two devices switch to 5.0GT/s then.
> > 
> > Make use of these observations then and detect the inability to train 
> > the link, by checking for the Data Link Layer Link Active status bit 
> > being off while the Link Bandwidth Management Status indicating that 
> > hardware has changed the link speed or width in an attempt to correct 
> > unreliable link operation.
> > 
> > Restrict the speed to 2.5GT/s then with the Target Link Speed field, 
> > request a retrain and wait 200ms for the data link to go up.  If this 
> > turns out successful, then lift the restriction, letting the devices 
> > negotiate a higher speed.
> > 
> > Also check for a 2.5GT/s speed restriction the firmware may have already 
> > arranged and lift it too with ports of devices known to continue working 
> > afterwards, currently the ASM2824 only, that already report their data 
> > link being up.
> 
> This quirk is run at boot-time and resume-time.  What happens after a
> Secondary Bus Reset, as is done by pci_reset_secondary_bus()?

Flipping SBR bit can be done on any PCI-to-PCI bridge device and in this
topology there are following: PCIe Root Port, ASMedia PCIe Switch
Upstream Port, ASMedia PCIe Switch Downstream Port, Pericom PCIe Switch
Upstream Port, Pericom PCIe Switch Downstream Port.
(Maciej, I hope that this is whole topology and there is not some other
device of PCI-to-PCI bridge type in your setup; please correct me)

Bjorn, to make it clear, on which device you mean to issue secondary bus
reset?

Because I would not be surprised if different things happen when issuing
bus reset on different parts of that topology.

> PCIe r6.0, sec 7.5.1.3.13, says "setting Secondary Bus Reset triggers
> a hot reset on the corresponding PCI Express Port".  Sec 4.2.7 says
> LinkUp is 0 in the LTSSM Hot Reset state, and the Hot Reset state
> leads to Detect, so it looks like this reset would cause the link to
> go down and come back up.
> 
> Can you tell if that's what happens?  Does the link negotiation fail
> then, too?
> 
> If it does fail then, I don't know how hard we need to work to fix it.
> Maybe we just accept it?  Or maybe we need a "quirk-after-reset" phase
> or something?
> 
> Bjorn
> 
> > Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> > Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.2203022037020.56670@angie.orcam.me.uk/
> > Link: https://source.denx.de/u-boot/u-boot/-/commit/a398a51ccc68
> > ---
> > Changes from v4:
> > 
> > - Remove <linux/bug.h> inclusion no longer needed.
> > 
> > - Make the quirk generic based on probing device features rather than 
> >   specific to the ASM2824 part only; take the Retrain Link bit erratum 
> >   into account.
> > 
> > - Still lift the 2.5GT/s speed restriction with the ASM2824 only.
> > 
> > - Increase retrain timeout from 200ms to 1s (PCIE_LINK_RETRAIN_TIMEOUT).
> > 
> > - Remove retrain success notification.
> > 
> > - Use PCIe helpers rather than generic PCI functions throughout.
> > 
> > - Trim down and update the wording of the change description for the 
> >   switch from an ASM2824-specific to a generic fixup.
> > 
> > Changes from v3:
> > 
> > - Remove the <linux/pci_ids.h> entry for the ASM2824.
> > 
> > Changes from v2:
> > 
> > - Regenerate for 5.17-rc2 for a merge conflict.
> > 
> > - Replace BUG_ON for a missing PCI Express capability with WARN_ON and an
> >   early return.
> > 
> > Changes from v1:
> > 
> > - Regenerate for a merge conflict.
> > ---
> >  drivers/pci/quirks.c |  118 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 118 insertions(+)
> > 
> > linux-pcie-asm2824-manual-retrain.diff
> > Index: linux-macro/drivers/pci/quirks.c
> > ===================================================================
> > --- linux-macro.orig/drivers/pci/quirks.c
> > +++ linux-macro/drivers/pci/quirks.c
> > @@ -5956,3 +5956,121 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
> >  #endif
> > +
> > +/*
> > + * Retrain the link of a downstream PCIe port by hand if necessary.
> > + *
> > + * This is needed at least where a downstream port of the ASMedia ASM2824
> > + * Gen 3 switch is wired to the upstream port of the Pericom PI7C9X2G304
> > + * Gen 2 switch, and observed with the Delock Riser Card PCI Express x1 >
> > + * 2 x PCIe x1 device, P/N 41433, plugged into the SiFive HiFive Unmatched
> > + * board.
> > + *
> > + * In such a configuration the switches are supposed to negotiate the link
> > + * speed of preferably 5.0GT/s, falling back to 2.5GT/s.  However the link
> > + * continues switching between the two speeds indefinitely and the data
> > + * link layer never reaches the active state, with link training reported
> > + * repeatedly active ~84% of the time.  Forcing the target link speed to
> > + * 2.5GT/s with the upstream ASM2824 device makes the two switches talk to
> > + * each other correctly however.  And more interestingly retraining with a
> > + * higher target link speed afterwards lets the two successfully negotiate
> > + * 5.0GT/s.
> > + *
> > + * With the ASM2824 we can rely on the otherwise optional Data Link Layer
> > + * Link Active status bit and in the failed link training scenario it will
> > + * be off along with the Link Bandwidth Management Status indicating that
> > + * hardware has changed the link speed or width in an attempt to correct
> > + * unreliable link operation.  For a port that has been left unconnected
> > + * both bits will be clear.  So use this information to detect the problem
> > + * rather than polling the Link Training bit and watching out for flips or
> > + * at least the active status.
> > + *
> > + * Since the exact nature of the problem isn't known and in principle this
> > + * could trigger where an ASM2824 device is downstream rather upstream,
> > + * apply this erratum workaround to any downstream ports as long as they
> > + * support Link Active reporting and have the Link Control 2 register.
> > + * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
> > + * request a retrain and wait 200ms for the data link to go up.
> > + *
> > + * If this turns out successful and we know by the Vendor:Device ID it is
> > + * safe to do so, then lift the restriction, letting the devices negotiate
> > + * a higher speed.  Also check for a similar 2.5GT/s speed restriction the
> > + * firmware may have already arranged and lift it with ports that already
> > + * report their data link being up.
> > + */
> > +static void pcie_downstream_link_retrain(struct pci_dev *dev)
> > +{
> > +	static const struct pci_device_id ids[] = {
> > +		{ PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
> > +		{}
> > +	};
> > +	u16 lnksta, lnkctl2;
> > +	u32 lnkcap;
> > +
> > +	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev)
> > +	    || !pcie_cap_has_lnkctl2(dev))
> > +		return;
> > +
> > +	/* It's too early yet to use `dev->link_active_reporting'.  */
> > +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > +	if (!(lnkcap & PCI_EXP_LNKCAP_DLLLARC))
> > +		return;
> > +
> > +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
> > +	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> > +	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
> > +	    PCI_EXP_LNKSTA_LBMS) {
> > +		unsigned long timeout;
> > +		u16 lnkctl;
> > +
> > +		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
> > +
> > +		pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> > +		lnkctl |= PCI_EXP_LNKCTL_RL;
> > +		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
> > +		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
> > +		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
> > +		pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl);
> > +		/*
> > +		 * Due to an erratum in some devices the Retrain Link bit
> > +		 * needs to be cleared again manually to allow the link
> > +		 * training to succeed.
> > +		 */
> > +		lnkctl &= ~PCI_EXP_LNKCTL_RL;
> > +		if (dev->clear_retrain_link)
> > +			pcie_capability_write_word(dev, PCI_EXP_LNKCTL,
> > +						   lnkctl);
> > +
> > +		timeout = jiffies + PCIE_LINK_RETRAIN_TIMEOUT;
> > +		do {
> > +			pcie_capability_read_word(dev, PCI_EXP_LNKSTA,
> > +					     &lnksta);
> > +			if (lnksta & PCI_EXP_LNKSTA_DLLLA)
> > +				break;
> > +			usleep_range(10000, 20000);
> > +		} while (time_before(jiffies, timeout));
> > +
> > +		if (!(lnksta & PCI_EXP_LNKSTA_DLLLA)) {
> > +			pci_info(dev, "retraining failed\n");
> > +			return;
> > +		}
> > +	}
> > +
> > +	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
> > +	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
> > +	    pci_match_id(ids, dev)) {
> > +		u16 lnkctl;
> > +
> > +		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
> > +		pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> > +		lnkctl |= PCI_EXP_LNKCTL_RL;
> > +		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
> > +		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
> > +		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
> > +		pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl);
> > +	}
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID,
> > +			 pcie_downstream_link_retrain);
> > +DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_ANY_ID, PCI_ANY_ID,
> > +			       pcie_downstream_link_retrain);
