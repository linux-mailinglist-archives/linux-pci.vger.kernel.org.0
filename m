Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9632C4C9998
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 01:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiCBABb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 19:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiCBABa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 19:01:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4AA8CD8B;
        Tue,  1 Mar 2022 16:00:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55BD4B81E4A;
        Wed,  2 Mar 2022 00:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB15DC340EE;
        Wed,  2 Mar 2022 00:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646179245;
        bh=0uX8VP/kJ0kj4IBqpbe9QBCjak+86Gz+zRwBAma0zyA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=leD/4S2rJvSzbYNM9phUCrDv6l3tMYDZL8ECL1prFXOODSmVC6fAh0V/FC4dbhTSg
         PyzAiyuoObHpZOtQcKIPkkof25VnrwCUrMv7f5JDkxuqx0yURMp4Xpz1nCs+WYcz6F
         lw7zoQSARNtIlCE6juxCnajNS3cQUnPT4ms8yRApTnPgRqjuMDV7al1VCRfuTmKVcM
         3heYNXMt+MxWKDbMRkOeRuOPtyTNvJlcMKIavDnxa+LW/yPFQJIYpwTtrQS4KPnc+l
         Z950Cgjoit4ffY9pfK5EUX7Vkn6sT9O+hTA801S4bo858o10QewUY9J9kEbVaeJCVl
         esmcwtoFKx07g==
Date:   Tue, 1 Mar 2022 18:00:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Stefan Roese <sr@denx.de>,
        Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pci: Work around ASMedia ASM2824 PCIe link training
 failures
Message-ID: <20220302000043.GA662523@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2202010240190.58572@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 01, 2022 at 10:50:37AM +0000, Maciej W. Rozycki wrote:
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

Can you collect the complete dmesg and lspci output, please?

From hints on the web, I guess the ASM2824 is built-in to the SiFive
board, right?  So I suspect the topology is something like this:

  00:00.0 Root Port to [bus 01-??]                  # soldered on to Unmatched
  01:00.0 ASM2824 Upstream Port to [bus 02-09]      # soldered on
  02:03.0 ASM2824 Downstream Port to [bus 05-09]    # soldered on, to slot
  05:00.0 PI7C9X2G304 Upstream Port to [bus 06-09]  # on Delock riser card
  06:??.? PI7C9X2G304 Downstream Port to [bus ??]   # slot 0 on Delock card
  06:??.? PI7C9X2G304 Downstream Port to [bus ??]   # slot 1 on Delock card

Do we have other reports of this bridge being broken?  Or could this
be some kind of signal integrity problem on Unmatched or the slot?

The ASM2824 has been around for a while and seems to be used in other
systems, e.g., https://linux-hardware.org/?id=pci:1b21-2824, so if
it's an ASM2824 issue, we should see it elsewhere, too.

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

I think the above is supposed to show 02:03.0 operating at 5GT/s or
2.5GT/s, and 05:00.0 operating at 2.5GT/s.  But there's a lot of noise
that makes it hard to pick out what's important.

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
>  Patch regenerated and re-verified against 5.17-rc2.  On this occasion I 
> decided to remove BUG_ON after all for a supposedly impossible condition 
> of a missing PCI Express capability for this PCIe switch and instead use 
> WARN_ON and an early return.  It should be safer this way.
> 
>  NB the corresponding U-boot change has since gone in with commit 
> a398a51ccc68 ("pci: Work around PCIe link training failures").  See 

Please include a URL for this commit.  Without knowing where to use
it, the SHA1 by itself isn't much use.

> <https://lore.kernel.org/lkml/alpine.DEB.2.21.2201022100430.56863@angie.orcam.me.uk/> 
> for previous background information.
> 
>  Questions, comments, concerns?  Otherwise please apply.
> 
>   Maciej
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
>  drivers/pci/quirks.c    |   98 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci_ids.h |    1 
>  2 files changed, 99 insertions(+)
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
> @@ -5879,3 +5880,100 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IN
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
> +	if (!pos)
> +		return;
> +
> +	pci_read_config_word(dev, pos + PCI_EXP_LNKCTL2, &lnkctl2);
> +	pci_read_config_word(dev, pos + PCI_EXP_LNKSTA, &lnksta);
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
> +	}

Perhaps a place to use pcie_retrain_link() (would require a little
rework to make it usable outside aspm.c).

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
> +		pci_write_config_word(dev, pos + PCI_EXP_LNKCTL2, lnkctl2);
> +		pci_write_config_word(dev, pos + PCI_EXP_LNKCTL, lnkctl);
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA,
> +			 PCI_DEVICE_ID_ASMEDIA_ASM2824,
> +			 pcie_downstream_link_retrain);
> +DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_ASMEDIA,
> +			       PCI_DEVICE_ID_ASMEDIA_ASM2824,
> +			       pcie_downstream_link_retrain);
> Index: linux-macro/include/linux/pci_ids.h
> ===================================================================
> --- linux-macro.orig/include/linux/pci_ids.h
> +++ linux-macro/include/linux/pci_ids.h
> @@ -2545,6 +2545,7 @@
>  #define PCI_SUBDEVICE_ID_QEMU            0x1100
>  
>  #define PCI_VENDOR_ID_ASMEDIA		0x1b21
> +#define PCI_DEVICE_ID_ASMEDIA_ASM2824	0x2824

We only add to pci_ids.h when the ID is used in more than one place.
