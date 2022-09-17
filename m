Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97E85BB819
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 14:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIQME2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Sep 2022 08:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIQMET (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Sep 2022 08:04:19 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Sep 2022 05:04:13 PDT
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1426E3A168;
        Sat, 17 Sep 2022 05:04:12 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1BCDF92009D; Sat, 17 Sep 2022 14:04:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 14A3192009B;
        Sat, 17 Sep 2022 13:04:12 +0100 (BST)
Date:   Sat, 17 Sep 2022 13:04:11 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Bjorn Helgaas <bhelgaas@google.com>, Stefan Roese <sr@denx.de>,
        Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] pci: Work around ASMedia ASM2824 PCIe link training
 failures
In-Reply-To: <20220421202711.GA1415244@bhelgaas>
Message-ID: <alpine.DEB.2.21.2209061237270.2275@angie.orcam.me.uk>
References: <20220421202711.GA1415244@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, 21 Apr 2022, Bjorn Helgaas wrote:

> Note the subject line conventions.  I usually fix things like that
> silently, but it saves me time if I don't have to.

 Fixed.  Not sure why I missed it, I usually capitalise subsystem names 
properly and check the usual convention beforehand anyway.  Sorry about 
it.

> > It has been observed with a downstream port of the ASMedia ASM2824 Gen 3 
> > switch wired to the upstream port of the Pericom PI7C9X2G304 Gen 2 
> > switch, using a Delock Riser Card PCI Express x1 > 2 x PCIe x1 device, 
> > P/N 41433, wired to a SiFive HiFive Unmatched board.  In this setup the 
> > switches are supposed to negotiate the link speed of preferably 5.0GT/s, 
> > falling back to 2.5GT/s.
> 
> Have you found any reports of issues other than on the SiFive HiFive
> Unmatched?  I poked around a little and didn't see any.  I considered
> suggesting that this go in arch/riscv unless we see the problem
> elsewhere, but I guess it's maybe not worth that.

 I haven't seen any report, but it doesn't mean nobody has triggered it.  

 It shouldn't matter anyway.  Both devices exist in the form of an option 
card each, sold under different brands, so if someone is creative enough 
and has such a need, then they can use them together in any system that 
has PCIe connectivity.

 The ASMedia ASM2824 switch is used with the StarTech PEX8M2E2 dual M.2 
M-Key adapter.  Also sold under the Ableconn brand as PEXM2-130.  And M.2 
M-Key to PCIe slot adapters are widely available.

 The Pericom PI7C9X2G304 switch is used with the Delock 41433 dual PCIe 
slot adapter.  Also sold under the SYBA IOCrest brand as SI-PEX60016.  
They have both been withdrawn AFAICT now, so availability may vary though.

 Therefore limiting the workaround to arch/riscv doesn't seem a terribly 
good idea to me.  You can plug these option cards into any system.

 Also the nature of the erratum is not fully understood and while it 
cannot trigger in the reverse configuration with these specific ICs (i.e. 
where the PI7C9X2G304 is upstream and the ASM2824 is downstream) because 
PI7C9X2G304's downstream ports are 2.5GT/s only, I suspect it may with a 
combination of other ASMedia and Pericom devices in either hierarchy order 
or possibly other switches.  Such devices continue being widely available.

 Therefore after some thinking about the possible consequences I chose to 
mimic as far as possible the approach I already took with the analogous 
U-Boot workaround and relax the vendor:device ID check so that an attempt 
to retrain is applied to all stuck devices that have a downstream link.  

 Since unlike U-Boot we cannot busy-loop with interrupts disabled polling 
the Link Training bit the workaround is limited to devices capable of 
reporting Data Link Layer Link Active status.  According to the PCIe spec 
that should only exclude some 5.0GT/s devices, because all 8.0GT/s and 
higher speed devices are required to support the feature (though I can 
imagine that reality might disagree, just as this issue shouldn't have 
been made possible either).

 Then for safety if retraining succeeds at 2.5GT/s, then the speed cap is 
only removed for known-good devices, currently the ASM2824 only.

> Interesting that there's a PI7C9X2G304 involved, since
> quirk_enable_clear_retrain_link() is also for Pericom devices.
> But that relates to Downstream Ports, and the PI7C9X2G304 is the
> Upstream Port in this case, so I suppose it's just coincidental.

 It's unrelated however in that it's merely a Retrain Link bit erratum 
rather than an issue with initial training.  Thank you for pointing this 
out though as I had to factor this in in my now more generic updated code.

> >  Do you need any further information beyond what I provided in: 
> > <https://lore.kernel.org/lkml/alpine.DEB.2.21.2203022037020.56670@angie.orcam.me.uk/>?
> 
> The commit log has more detail than necessary, so the specifics of
> what the quirk does (basically the last paragraph) get lost.  This
> link could be moved to the commit log for the background.  You
> previously included a URL for a u-boot change; can you include that
> URL as well?

 Sure, though background information can be easily lost and is best kept 
together with the change itself.  Since the necessary details are already 
in the comment at `pcie_downstream_link_retrain' though I've trimmed the 
commit message now as you requested.

> > +static void pcie_downstream_link_retrain(struct pci_dev *dev)
> > +{
> > +	u16 lnksta, lnkctl2;
> > +	u8 pos;
> > +
> > +	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
> > +	WARN_ON(!pos);
> 
> Doesn't seem worth warning about to me.

 And not relevant in v5 anymore where a check for the device being PCIe 
is used instead, thus necessarily removed.

> > +	if (!pos)
> > +		return;
> > +
> > +	pci_read_config_word(dev, pos + PCI_EXP_LNKCTL2, &lnkctl2);
> > +	pci_read_config_word(dev, pos + PCI_EXP_LNKSTA, &lnksta);
> 
> Use pci_is_pcie(), pcie_capability_read_word(), etc.

 Right, I wasn't aware about these helpers.  Fixed.

> > +		pci_info(dev, "retraining %s!\n",
> > +			 lnksta & PCI_EXP_LNKSTA_DLLLA ?
> > +			 "succeeded" : "failed");
> 
> If retraining failed, I think we should just return here.  We will
> skip the code below anyway, but this would be more obvious:
> 
>   if (!(lnksta & PCI_EXP_LNKSTA_DLLLA)) {
>     pci_inf(..., "failed");
>     return;
>   }
> 
> I don't think it's really necessary to log success.

 Fine with me, applied, removing the ellipsis from the preceding message 
accordingly.

> > +		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
> > +		pci_read_config_word(dev, pos + PCI_EXP_LNKCTL, &lnkctl);
> > +		pci_read_config_dword(dev, pos + PCI_EXP_LNKCAP, &lnkcap);
> > +		lnkctl |= PCI_EXP_LNKCTL_RL;
> > +		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
> > +		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
> 
> We rely on PCI_EXP_LNKCAP_SLS and PCI_EXP_LNKCTL2_TLS having the same
> encoding in the same bits.  Enough to force a reviewer to
> double-check, but it looks like it *is* safe.

 It is the intent of the spec AFAICT and all these fields (including 
PCI_EXP_LNKSTA_CLS too) refer to the Supported Link Speeds Vector 
(PCI_EXP_LNKCAP2_SLS).  Thanks for double-checking.

 Thank you for your review.  I have posted v5 now.  Since the move to a 
generic quirk required changes elsewhere this has now become a patch 
series including 4 changes total.  I have retained the original subject 
verbatim with the cover letter so as to give a chance to mail user agents 
to show the new series next to older revisions of the original patch (mine 
does).

  Maciej
