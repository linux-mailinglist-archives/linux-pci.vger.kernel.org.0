Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F38134B762
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 14:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhC0Na1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 09:30:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhC0NaD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 27 Mar 2021 09:30:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6783161966;
        Sat, 27 Mar 2021 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616851802;
        bh=n8sXS1//HNddHQmSXJmBqsBbpbXrAQw627EGz2mYdAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AvCK9mdMat6gE2h7ERaT3A18hXaVBuWX9PrKu3Z3bhya8p/5X0HobTPXrJ2cDwg4P
         dmHgQ0zbszwZn03zimFCqpa3vyWI/FNWQT/ubvwbDQ7LFiZoa96KmUK+16TIvVrSSh
         J76pXRXXikhb/gaERMevu4lRjM+5+JGsFwhiyN4pLzoz9aTU4VOikWhxo7cJ7Dpmsn
         n8nsijEslo/nhb7y5xwBqexo94uQAw+E3VHJ6wIRRZWqHjRNIO0CcH1v0RJrxxHUNb
         3n3DVINKKj6S5U8X1vkTms56y1AJu7QCJAeJD9ewiLK1cZHrWgMN0Ff+HmXQsAOupu
         IXfw3GR5mHTvw==
Received: by pali.im (Postfix)
        id D3B8F95D; Sat, 27 Mar 2021 14:29:59 +0100 (CET)
Date:   Sat, 27 Mar 2021 14:29:59 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Disallow retraining link for Atheros QCA98xx chips
 on non-Gen1 PCIe bridges
Message-ID: <20210327132959.fwkphna7gg57aove@pali>
References: <20210326124326.21163-1-pali@kernel.org>
 <YF540gjh156QIirA@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YF540gjh156QIirA@rocinante>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Saturday 27 March 2021 01:14:10 Krzysztof Wilczyński wrote:
> Hi Pali,
> 
> Thank you for sending the patch over!
> 
> [...]
> > +static int pcie_change_tls_to_gen1(struct pci_dev *parent)
> 
> Just a nitpick, so feel free to ignore it.  I would just call the
> variable "dev" as we pass a pointer to a particular device, but it does
> not matter as much, so I am leaving this to you.

I called it 'parent' because it is called 'parent' also in caller
function. Link consists of two devices, so 'dev' could be ambiguous.

> [...]
> > +	if (ret == 0) {
> 
> You prefer this style over "if (!ret)"?  Just asking in the view of the
> style that seem to be preferred in the code base at the moment.

I can change this to 'if (!ret)' if needed, no problem.

I use 'if (!val)' mostly for boolean and pointer variables. If variable
can contain more integer values then I lot of times I use '=='.

> > +		/* Verify that new value was really set */
> > +		pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &reg16);
> > +		if ((reg16 & PCI_EXP_LNKCTL2_TLS) != PCI_EXP_LNKCTL2_TLS_2_5GT)
> > +			ret = -EINVAL;
> 
> I am wondering about this verification - did you have a case where the
> device would not properly set its capability, or accept the write and do
> nothing?

I do not know any real device which is doing this thing.

But this issue can happen with kernel's PCIe emulated root bridge:
drivers/pci/pci-bridge-emul.c

Drivers which are using this emulated root bridge (and both pci-mvebu.c
and pci-aardvark.c are using it!) do not have to implement callback for
every read and every write operation of every register.

Note that both pci-mvebu.c and pci-aardvark.c currently does not
implement access to HW register PCI_EXP_LNKCTL2. So currently it is not
possible to set PCI_EXP_LNKCTL2_TLS_2_5GT. And above code correctly
fails and disallow ASPM code to retrain link.

I have some WIP patches which implement LNKCAP2, LNKCTL2 and LNKSTA2
read/write callbacks on emulated bridge for pci-mvebu.c and
pci-aardvark.c. And I have tested that with those WIP patches ASPM code
can correctly switch link to 2.5GT/s and enable ASPM.

> > +	if (ret != 0)
> 
> I think "if (ret)" would be fine to use here, unless you prefer being
> more explicit.  See my question about style above.
> 
> >  static bool pcie_retrain_link(struct pcie_link_state *link)
> >  {
> >  	struct pci_dev *parent = link->pdev;
> >  	unsigned long end_jiffies;
> >  	u16 reg16;
> > +	u32 reg32;
> > +
> > +		/* Check if link is capable of higher speed than 2.5 GT/s and needs quirk */
> > +		pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &reg32);
> > +		if ((reg32 & PCI_EXP_LNKCAP_SLS) > PCI_EXP_LNKCAP_SLS_2_5GB) {
> 
> I wonder if moving this check to pcie_change_tls_to_gen1() would make
> more sense?  It would then make this function a little cleaner.  What do
> you think?

Ok, no problem. But then function needs to be renamed. Any idea how
should be this function called?

> [...]
> > +static void quirk_no_bus_reset_and_no_retrain_link(struct pci_dev *dev)
> > +{
> > +	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET | PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1;
> > +}
> [...]
> 
> I know that the style has been changed to allow 100 characters width and
> that checkpatch.pl now also does not warn about line length, as per
> commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column
> warning"), but I think Bjorn still prefers 80 characters, thus this line
> above might have to be aligned.

Ok! If needed I can reformat patch to 80 characters per line.
