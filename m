Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8FA43E9DC
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 22:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJ1Uu1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 16:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230451AbhJ1UuZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 16:50:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3588D60F21;
        Thu, 28 Oct 2021 20:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635454078;
        bh=QIIErr9k/GQ8cPnA4NVe5+CaffoR9OvTQo8rGLm1sGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fyCHgBKRLWVUiE7jSBydUg2K5TvD7NRO2xtSrG9BOGKjyGkvnVFUPekPQ9kBvqcU9
         uAd4vG+FZ9sZFYEt+di/4wC7U4RsxhdmFJ9FVX6hchKmjCf4ba6ked5MLI0S76Wtje
         S4sAvfP2kCfIs/v5Y2Pt2gtLjvtYsLI2wY2xCtQ/mYNvRqSkaY7C08uFAc+TuF2G7X
         OnSfuz6FoHMXF9giGvL3RZijUjIN7BfY9ofuzF55Ei+Yapbc1yO6/WxIRlmoR4ImwP
         LHfIc5oHs6ck0Cn9k5Ai5cAthno++jwv8rElte0uKT6sGrDUqkRPg3P6cj0maPUraq
         H/5JO/h9LwilA==
Date:   Thu, 28 Oct 2021 15:47:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yanteng Si <siyanteng01@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Yanteng Si <siyanteng@loongson.cn>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        chenhuacai@kernel.org, sterlingteng@gmail.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] MIPS: cm/cpc: export some missing symbols to be
 able to use them from driver code
Message-ID: <20211028204756.GA293663@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H8HoO7dsfiTFaTRie1-DB-DF5st-gFmS=AF2tfHP_gsVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 28, 2021 at 11:59:17AM +0200, Sergio Paracuellos wrote:
> On Thu, Oct 28, 2021 at 11:34 AM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> > On Thu, Oct 28, 2021 at 11:24 AM Thomas Bogendoerfer
> > <tsbogend@alpha.franken.de> wrote:
> > > On Thu, Oct 28, 2021 at 06:11:18AM +0200, Sergio Paracuellos wrote:
> > > > On Thu, Oct 28, 2021 at 6:05 AM Yanteng Si <siyanteng01@gmail.com> wrote:
> > > > >
> > > > > Since commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
> > > > > the MT7621 PCIe host controller driver is built as a module but modpost complains once these
> > > > > drivers become modules.
> > > > >
> > > > > ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > > ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > > ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > > ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > > ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > >
> > > > > Let's just export them.
> > > > >
> > > > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > > > ---
> > > > >  arch/mips/kernel/mips-cm.c  | 5 +++++
> > > > >  arch/mips/kernel/mips-cpc.c | 1 +
> > > > >  2 files changed, 6 insertions(+)
> > > > >
> > > >
> > > > Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > >
> > > could we instead make the pcie-mt761 driver non modular ? Exporting
> > > all MIPS specific stuff for just making an essential driver modular
> > > doesn't IMHO make much sense.
> >
> > The driver is modular because I have been advised other times that new
> > drivers should be able to be compiled as modules and we should avoid
> > using 'bool' in Kconfig for new drivers. That's the only reason. I am
> > also always including as 'y' the driver since for me not having pci in
> > my boards has no sense... I am ok in changing Kconfig to be 'bool'
> > instead of 'tristate', but I don't know what should be the correct
> > thing to do in this case. Thoughts?
> 
> I guess we also want the driver to at least be compile tested in
> 'allmodconfig' and other similars...

Sounds like the systems that actually use this driver require it to be
built-in, and the only benefit of exporting these symbols is that we
would get better compile test coverage.

If that's the case, I agree that it's better to just make it
non-modular.

Bjorn
