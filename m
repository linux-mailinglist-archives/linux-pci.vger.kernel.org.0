Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD2E57D033
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiGUPsT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 11:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiGUPsH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 11:48:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2866289A8F;
        Thu, 21 Jul 2022 08:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD0B4B8253C;
        Thu, 21 Jul 2022 15:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5A7C341C0;
        Thu, 21 Jul 2022 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658418389;
        bh=PXrSX6TqOGgu/mUPbX1MSmgTXFQ9SHdxh/ZWILLOrWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XGWFT/851segzOr4xlR49pzv4LvKUjk8gig6g8kUKwDDgcAfTJIc0R03rIpTCY3aV
         1KS2DiK3JMESQACTiJYmZnlYMzrquaz7yK9Ez8VrJ/LZQaJgf2rfBdSgOhwbUqkzpG
         D2pmFlqhbcZ+QcwhmIyeTcq2fZX2aRJQB4L5M27vI9F/cn/a7Ml03p2IFh2BhHstQY
         NKaz8J6QOMgt1His78n/IsY6GxYY/VWBhcWsosInI/8e3MsKz0I8NbQ3AAOrOvAXSX
         cmmhojATSEUiEIMJnHwSnQwTuUsqO49oryt5KKAbQk+sjHW9S6KS3PuTrCOx089Q5B
         KugxgcpzPBFXQ==
Date:   Thu, 21 Jul 2022 10:46:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] PCI: brcmstb: Add "refusal mode" to preclude
 PCIe-induced CPU aborts
Message-ID: <20220721154627.GA1722428@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNyUB4es01xsSvsvS0gZyUuuttJJ4XSBVajtBrVNFT5dMw@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 21, 2022 at 10:53:54AM -0400, Jim Quinlan wrote:
> https://lore.kernel.org/linux-pci/20171215201434.GY30595@bhelgaas-glaptop.roam.corp.google.com/
> On Wed, Jul 20, 2022 at 6:06 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sat, Jul 16, 2022 at 06:24:50PM -0400, Jim Quinlan wrote:
> > > Our PCIe RC HW has an atypical behavior: if it does not have PCIe link
> > > established between itself and downstream, any subsequent config space
> > > access causes a CPU abort.  This commit sets a "refusal mode" if the PCIe
> > > link-up fails, and this has our pci_ops map_bus function returning a NULL
> > > address, which in turn precludes the access from happening.
> > >
> > > Right now, "refusal mode" is window dressing.  It will become relevant
> > > in a future commit when brcm_pcie_start_link() is invoked during
> > > enumeration instead of before it.
> > >
> > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > index c026446d5830..72219a4f3964 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -255,6 +255,7 @@ struct brcm_pcie {
> > >       u32                     hw_rev;
> > >       void                    (*perst_set)(struct brcm_pcie *pcie, u32 val);
> > >       void                    (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> > > +     bool                    refusal_mode;
> > >  };
> > >
> > >  static inline bool is_bmips(const struct brcm_pcie *pcie)
> > > @@ -687,6 +688,19 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
> > >       if (pci_is_root_bus(bus))
> > >               return PCI_SLOT(devfn) ? NULL : base + where;
> > >
> > > +     if (pcie->refusal_mode) {
> > > +             /*
> > > +              * At this point we do not have PCIe link-up.  If there is
> > > +              * a config read or write access besides those targeting
> > > +              * the host bridge, our PCIe HW throws a CPU abort.  To
> > > +              * prevent this we return the NULL address.  The calling
> > > +              * functions -- pci_generic_config_*() -- will notice this
> > > +              * and not perform the access, and if it is a read access,
> > > +              * 0xffffffff is returned.
> > > +              */
> > > +             return NULL;
> > > +     }
> >
> > Is this any different from all the other .map_bus() implementations
> > that return NULL when the link is down?
> 
> Not really, but long ago I submitted code that gated the config spec
> access based on link status and was advised not to do it  [1].
> I'll be happy to make it look like the others.
>
> [1] https://lore.kernel.org/linux-pci/20171215201434.GY30595@bhelgaas-glaptop.roam.corp.google.com/

My point there was that if you can deal with the abort cleanly, that's
the best approach.  Apparently brcmstb can't recover cleanly, so you
have to settle for the 99% solution.

The refusal_mode approach has the same race as checking
*_pcie_link_up(), since the link may go down between the time
brcm_pcie_start_link() sees that it is up and the time somebody does a
config access:

  brcm_pcie_start_link
    pcie->refusal_mode = false

  <link goes down>

  brcm_pcie_map_conf
    if (pcie->refusal_mode)            # still false

  <config access causes abort>

So there's no advantage in making the code look different.  Checking
for link-up in the config access path can never completely remove the
window, but it does make it smaller than using refusal_mode.

Bjorn
