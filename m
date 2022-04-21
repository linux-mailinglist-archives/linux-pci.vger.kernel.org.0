Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0CB50A9F3
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 22:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350484AbiDUUaI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 16:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242527AbiDUUaH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 16:30:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7036B4B1FC;
        Thu, 21 Apr 2022 13:27:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F311BB82910;
        Thu, 21 Apr 2022 20:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52965C385A1;
        Thu, 21 Apr 2022 20:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650572833;
        bh=Bi6ilbgYwuPyufdRgUuYAxqiLZicaSBs05Xp3Xm6TF8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aezx9y9/Ej+IT0ShcEu+WG+f60TLjQqHzF7IxqUqCRBjdWraZApVu8VskeS+41ihJ
         i53luysaiZGydwqLsGPrYQ1cw9RFpAVdvb72tLEWuOhLkME7ppBJXYw3VLWPeu+MLd
         xI9K18rRF3LwSRQVIREsJ/crJ2wt8Rm53Wc9HxCaNJkHa2gl2ispDQcrLziYV5YU/u
         bjEBwCYMpSFT/yqEb+1wiqCgvXYQsohhuxZpofaW/tWbVcDLqBFZu8CqWNcA9HaOA+
         SxRYD4b/DYKwSmIzNakXlUajJd+qD1oMhX34eJx3TCXbxf1WIvAPQTSLok0wq5Z5e6
         4/LRL8ylRT7Tg==
Date:   Thu, 21 Apr 2022 15:27:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Stefan Roese <sr@denx.de>,
        Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] pci: Work around ASMedia ASM2824 PCIe link training
 failures
Message-ID: <20220421202711.GA1415244@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2203310037480.44113@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 31, 2022 at 08:11:28AM +0100, Maciej W. Rozycki wrote:

Note the subject line conventions.  I usually fix things like that
silently, but it saves me time if I don't have to.

> Attempt to handle cases with a downstream port of the ASMedia ASM2824 
> PCIe switch where link training never completes and the link continues 
> switching between speeds indefinitely with the data link layer never 
> reaching the active state.
> 
> It has been observed with a downstream port of the ASMedia ASM2824 Gen 3 
> switch wired to the upstream port of the Pericom PI7C9X2G304 Gen 2 
> switch, using a Delock Riser Card PCI Express x1 > 2 x PCIe x1 device, 
> P/N 41433, wired to a SiFive HiFive Unmatched board.  In this setup the 
> switches are supposed to negotiate the link speed of preferably 5.0GT/s, 
> falling back to 2.5GT/s.

Have you found any reports of issues other than on the SiFive HiFive
Unmatched?  I poked around a little and didn't see any.  I considered
suggesting that this go in arch/riscv unless we see the problem
elsewhere, but I guess it's maybe not worth that.

Interesting that there's a PI7C9X2G304 involved, since
quirk_enable_clear_retrain_link() is also for Pericom devices.
But that relates to Downstream Ports, and the PI7C9X2G304 is the
Upstream Port in this case, so I suppose it's just coincidental.

> However the link continues oscillating between the two speeds, at the 
> rate of 34-35 times per second, with link training reported repeatedly 
> active ~84% of the time, e.g.:
> 
> 02:03.0 PCI bridge [0604]: ASMedia Technology Inc. ASM2824 PCIe Gen3 Packet Switch [1b21:2824] (rev 01) (prog-if 00 [Normal decode])
> [...]
> 	Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
> [...]
> 	Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
> [...]
> 		LnkSta:	Speed 5GT/s (downgraded), Width x1 (ok)
> 			TrErr- Train+ SlotClk+ DLActive- BWMgmt+ ABWMgmt-
> [...]
> 		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis+, Selectable De-emphasis: -3.5dB
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> [...]
> 
> Forcibly limiting the target link speed to 2.5GT/s with the upstream 
> ASM2824 device makes the two switches communicate correctly however:
> 
> 02:03.0 PCI bridge [0604]: ASMedia Technology Inc. ASM2824 PCIe Gen3 Packet Switch [1b21:2824] (rev 01) (prog-if 00 [Normal decode])
> [...]
> 	Bus: primary=02, secondary=05, subordinate=09, sec-latency=0
> [...]
> 	Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
> [...]
> 		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (ok)
> 			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
> [...]
> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis+, Selectable De-emphasis: -3.5dB
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> [...]
> 
> and then:
> 
> 05:00.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch [12d8:2304] (rev 05) (prog-if 00 [Normal decode])
> [...]
> 	Bus: primary=05, secondary=06, subordinate=09, sec-latency=0
> [...]
> 	Capabilities: [c0] Express (v2) Upstream Port, MSI 00
> [...]
> 		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (downgraded)
> 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> [...]
> 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> [...]
> 
> Removing the speed restriction afterwards makes the two devices switch 
> to 5.0GT/s then.
> 
> Make use of these observations then and detect the inability to train 
> the link, by checking for the Data Link Layer Link Active status bit 
> implemented by the ASM2824 being off while the Link Bandwidth Management 
> Status indicating that hardware has changed the link speed or width in 
> an attempt to correct unreliable link operation.
> 
> Restrict the speed to 2.5GT/s then with the Target Link Speed field, 
> request a retrain and wait 200ms for the data link to go up.  If this 
> turns out successful, then lift the restriction, letting the devices 
> negotiate a higher speed.  Also check for a 2.5GT/s speed restriction 
> the firmware may have already arranged and lift it too with ports that 
> already report their data link being up.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> Hi,
> 
>  Do you need any further information beyond what I provided in: 
> <https://lore.kernel.org/lkml/alpine.DEB.2.21.2203022037020.56670@angie.orcam.me.uk/>?

The commit log has more detail than necessary, so the specifics of
what the quirk does (basically the last paragraph) get lost.  This
link could be moved to the commit log for the background.  You
previously included a URL for a u-boot change; can you include that
URL as well?

> Changes from v3:
> 
> - Remove the <linux/pci_ids.h> entry for the ASM2824.
> 
> Changes from v2:
> 
> - Regenerate for 5.17-rc2 for a merge conflict.
> 
> - Replace BUG_ON for a missing PCI Express capability with WARN_ON and an
>   early return.
> 
> Changes from v1:
> 
> - Regenerate for a merge conflict.
> ---
>  drivers/pci/quirks.c |   96 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> linux-pcie-asm2824-manual-retrain.diff
> Index: linux-macro/drivers/pci/quirks.c
> ===================================================================
> --- linux-macro.orig/drivers/pci/quirks.c
> +++ linux-macro/drivers/pci/quirks.c
> @@ -12,6 +12,7 @@
>   * file, where their drivers can use them.
>   */
>  
> +#include <linux/bug.h>
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/export.h>
> @@ -5895,3 +5896,98 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IN
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
> +
> +/*
> + * Retrain the link of a downstream PCIe port by hand if necessary.
> + *
> + * This is needed at least where a downstream port of the ASMedia ASM2824
> + * Gen 3 switch is wired to the upstream port of the Pericom PI7C9X2G304
> + * Gen 2 switch, and observed with the Delock Riser Card PCI Express x1 >
> + * 2 x PCIe x1 device, P/N 41433, plugged into the SiFive HiFive Unmatched
> + * board.
> + *
> + * In such a configuration the switches are supposed to negotiate the link
> + * speed of preferably 5.0GT/s, falling back to 2.5GT/s.  However the link
> + * continues switching between the two speeds indefinitely and the data
> + * link layer never reaches the active state, with link training reported
> + * repeatedly active ~84% of the time.  Forcing the target link speed to
> + * 2.5GT/s with the upstream ASM2824 device makes the two switches talk to
> + * each other correctly however.  And more interestingly retraining with a
> + * higher target link speed afterwards lets the two successfully negotiate
> + * 5.0GT/s.
> + *
> + * With the ASM2824 we can rely on the otherwise optional Data Link Layer
> + * Link Active status bit and in the failed link training scenario it will
> + * be off along with the Link Bandwidth Management Status indicating that
> + * hardware has changed the link speed or width in an attempt to correct
> + * unreliable link operation.  For a port that has been left unconnected
> + * both bits will be clear.  So use this information to detect the problem
> + * rather than polling the Link Training bit and watching out for flips or
> + * at least the active status.
> + *
> + * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
> + * request a retrain and wait 200ms for the data link to go up.  If this
> + * turns out successful, then lift the restriction, letting the devices
> + * negotiate a higher speed.  Also check for a 2.5GT/s speed restriction
> + * the firmware may have already arranged and lift it too with ports that
> + * already report their data link being up.
> + */
> +static void pcie_downstream_link_retrain(struct pci_dev *dev)
> +{
> +	u16 lnksta, lnkctl2;
> +	u8 pos;
> +
> +	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
> +	WARN_ON(!pos);

Doesn't seem worth warning about to me.

> +	if (!pos)
> +		return;
> +
> +	pci_read_config_word(dev, pos + PCI_EXP_LNKCTL2, &lnkctl2);
> +	pci_read_config_word(dev, pos + PCI_EXP_LNKSTA, &lnksta);

Use pci_is_pcie(), pcie_capability_read_word(), etc.

> +	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
> +	    PCI_EXP_LNKSTA_LBMS) {
> +		unsigned long timeout;
> +		u16 lnkctl;
> +
> +		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s...\n");
> +
> +		pci_read_config_word(dev, pos + PCI_EXP_LNKCTL, &lnkctl);
> +		lnkctl |= PCI_EXP_LNKCTL_RL;
> +		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
> +		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
> +		pci_write_config_word(dev, pos + PCI_EXP_LNKCTL2, lnkctl2);
> +		pci_write_config_word(dev, pos + PCI_EXP_LNKCTL, lnkctl);
> +
> +		timeout = jiffies + msecs_to_jiffies(200);
> +		do {
> +			pci_read_config_word(dev, pos + PCI_EXP_LNKSTA,
> +					     &lnksta);
> +			if (lnksta & PCI_EXP_LNKSTA_DLLLA)
> +				break;
> +			usleep_range(10000, 20000);
> +		} while (time_before(jiffies, timeout));
> +
> +		pci_info(dev, "retraining %s!\n",
> +			 lnksta & PCI_EXP_LNKSTA_DLLLA ?
> +			 "succeeded" : "failed");

If retraining failed, I think we should just return here.  We will
skip the code below anyway, but this would be more obvious:

  if (!(lnksta & PCI_EXP_LNKSTA_DLLLA)) {
    pci_inf(..., "failed");
    return;
  }

I don't think it's really necessary to log success.

> +	}
> +
> +	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
> +	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
> +		u32 lnkcap;
> +		u16 lnkctl;
> +
> +		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
> +		pci_read_config_word(dev, pos + PCI_EXP_LNKCTL, &lnkctl);
> +		pci_read_config_dword(dev, pos + PCI_EXP_LNKCAP, &lnkcap);
> +		lnkctl |= PCI_EXP_LNKCTL_RL;
> +		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
> +		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;

We rely on PCI_EXP_LNKCAP_SLS and PCI_EXP_LNKCTL2_TLS having the same
encoding in the same bits.  Enough to force a reviewer to
double-check, but it looks like it *is* safe.

> +		pci_write_config_word(dev, pos + PCI_EXP_LNKCTL2, lnkctl2);
> +		pci_write_config_word(dev, pos + PCI_EXP_LNKCTL, lnkctl);
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x2824,
> +			 pcie_downstream_link_retrain);
> +DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_ASMEDIA, 0x2824,
> +			       pcie_downstream_link_retrain);
