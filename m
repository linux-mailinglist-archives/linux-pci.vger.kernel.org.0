Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B3761FF1E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 21:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiKGUGp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 15:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKGUGo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 15:06:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28824178BB;
        Mon,  7 Nov 2022 12:06:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5E13612AB;
        Mon,  7 Nov 2022 20:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A55C433D6;
        Mon,  7 Nov 2022 20:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667851602;
        bh=9m6X4lP4tvtcLVkdLhhNRclK4e94Mh5/KEch2uhPrdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uthuFFZgVGGbU3VKT6COTWtTkbxGo96/ahQGh0cUp29YFlSvQ/f/c9LGvJSYhUcB5
         CNwS/cYWnVh17/fZKoyXTzCIZY8OHQ7CquUuPrtlsGIVc6G0MoMwG8o+7XI3kmjqac
         Sl2M7F73B5N8x72C5FfXTWrUAGKDV6aibYf9C+uX7Hzxa831MKd6fduJYHO1GL5Si5
         RB3RysInhNpgDhrWPb5wHkV96oJ2M1hHHXdjxysRjFJ+Y/OYVRjSq1DW29GARYQlSU
         RHLZIMxExqCbfwQP6Sq2dOWuhG/EcRV3Wdy+rV0+AjQtg/o+bxG1rRip5wVB6+C0n9
         Y/gnI0tERaAGQ==
Received: by pali.im (Postfix)
        id E170189B; Mon,  7 Nov 2022 21:06:37 +0100 (CET)
Date:   Mon, 7 Nov 2022 21:06:37 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nathan Rossi <nathan.rossi@digi.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: mvebu: Set Target Link Speed for 2.5GT downstream
 devices
Message-ID: <20221107200637.heoakrpzob4yz7c5@pali>
References: <20221107081327.336239-1-nathan@nathanrossi.com>
 <20221107084346.ksdhcxk7bppvpmqc@pali>
 <CA+aJhH0k1zaP0sVNk98qviTiyCEAmQKO4MOD8LSiHiwuzh6-aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+aJhH0k1zaP0sVNk98qviTiyCEAmQKO4MOD8LSiHiwuzh6-aA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 07 November 2022 19:10:02 Nathan Rossi wrote:
> On Mon, 7 Nov 2022 at 18:43, Pali Rohár <pali@kernel.org> wrote:
> >
> > On Monday 07 November 2022 08:13:27 Nathan Rossi wrote:
> > > From: Nathan Rossi <nathan.rossi@digi.com>
> > >
> > > There is a known issue with the mvebu PCIe controller when triggering
> > > retraining of the link (via Link Control) where the link is dropped
> > > completely causing significant delay in the renegotiation of the link.
> > > This occurs only when the downstream device is 2.5GT and the upstream
> > > port is configured to support both 2.5GT and 5GT.
> > >
> > > It is possible to prevent this link dropping by setting the associated
> > > link speed in Target Link Speed of the Link Control 2 register. This
> > > only needs to be done when the downstream is specifically 2.5GT.
> > >
> > > This change applies the required Target Link Speed value during
> > > mvebu_pcie_setup_hw conditionally depending on the current link speed
> > > from the Link Status register, only applying the change when the link
> > > is configured to 2.5GT already.
> > >
> > > Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> > > ---
> > >  drivers/pci/controller/pci-mvebu.c | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > > index 1ced73726a..6a869a33ba 100644
> > > --- a/drivers/pci/controller/pci-mvebu.c
> > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > @@ -248,7 +248,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
> > >
> > >  static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> > >  {
> > > -     u32 ctrl, lnkcap, cmd, dev_rev, unmask, sspl;
> > > +     u32 ctrl, lnkcap, cmd, dev_rev, unmask, sspl, lnksta, lnkctl2;
> > >
> > >       /* Setup PCIe controller to Root Complex mode. */
> > >       ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
> > > @@ -339,6 +339,22 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> > >       unmask |= PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
> > >                 PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
> > >       mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> > > +
> > > +     /*
> > > +      * Set Target Link Speed within the Link Control 2 register when the
> > > +      * linked downstream device is connected at 2.5GT. This is configured
> > > +      * in order to avoid issues with the controller when the upstream port
> > > +      * is configured to support 2.5GT and 5GT and the downstream device is
> > > +      * linked at 2.5GT, retraining the link in this case causes the link to
> > > +      * drop taking significant time to retrain.
> > > +      */
> > > +     lnksta = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL) >> 16;
> > > +     if ((lnksta & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
> >
> > This code does not work because at this stage endpoint device does not
> > have to be ready and therefore link is not established yet.
> >
> > Also this code is not running when kernel issue PCIe Hot Reset via
> > PCI Secondary Bus Reset bit.
> >
> > And it does not handle possible hot-plug situation.
> >
> > That check that code below has to be done _after_ kernel enumerate
> > device. PCI core code has already logic to handle delays for "slow"
> > devices.
> >
> > And reverse operation (setting lnkctl2 target speed to original value)
> > has to be called after unplugging device - when link goes down.
> >
> > If you want to work on this stuff, I can try to find my notes which I
> > done during investigation of this issue... where is probably the best
> > place in kernel pci core code for handling this issue.
> 
> Some notes/direction for implementation would be very appreciated. I
> am not particularly familiar with the pci core code, so I don't have a
> good idea on how to best implement this workaround.

Ok, I have checked and seems that I have removed my notes :-(

So trying to reconstruct information from my memory...

Target link speed in Root port's lnkctl2 register must be set to
_correct_ value before configuring ASPM. Because link retraining (part
of ASPM configuration) fails. ASPM is initialized by calling function
pcie_aspm_init_link_state() from _non-endpoint_ device and it is called
at the end of function pci_scan_slot().

Look also at the tree-traversal functions pci_scan_child_bus_extend()
and pci_scan_bridge_extend() and try to find the best place where should
be this "fix" called.

Because same issue as you are trying to fix is also in pci-aardvark.c
hardware (Marvell too), I think that you can introduce some flag in
struct pci_host_bridge, set it in pci-mvebu.c (later I can do same in
pci-aardvark.c) and then in core pci code (in some of above mentioned
function when you find the proper place in tree traversal) add code
which "fixes" lnkctl2 register.

Because both pci hotplug and static initialization calls those pci core
scan functions, this should fix init-probe part.

Second thing is fixing unplugging part. Because in hotplug setup you can
connect 2.5GT/s GEN1 card (which requires this workaround), then
disconnect it and connect some 5GT/s GEN2 card, it is needed to set
target link back to 5GT/s to use full speed of GEN2 card.

For this second part, I think that it is needed to change target link
speed back to 5GT/s after card is disconnected. As a good candidates
where to do it is probably pci_stop_dev() or pci_destroy_dev() function.
Beware that it is needed to change link speed of device on the other end
of link - not the device which is being removed/unregistered. And check
if it is the last kernel device being unregistered from the bus
(endpoint card may be multifunction device).

I hope that this information would help you. I'm really sorry that I do
not have my notes about this issue where I documented it. Anyway I would
try to provide other information if needed.

> Thanks,
> Nathan
> 
> >
> > > +             lnkctl2 = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
> > > +             lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
> > > +             lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
> > > +             mvebu_writel(port, lnkctl2, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
> > > +     }
> > >  }
> > >
> > >  static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
> > > ---
> > > 2.37.2
