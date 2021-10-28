Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759CC43DDAE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 11:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhJ1J0v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 05:26:51 -0400
Received: from elvis.franken.de ([193.175.24.41]:45139 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJ1J0v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 05:26:51 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mg1dv-0002j1-00; Thu, 28 Oct 2021 11:24:15 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id ED26FC2770; Thu, 28 Oct 2021 11:23:18 +0200 (CEST)
Date:   Thu, 28 Oct 2021 11:23:18 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Yanteng Si <siyanteng01@gmail.com>,
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
Message-ID: <20211028092318.GA6574@alpha.franken.de>
References: <cover.1635390750.git.siyanteng@loongson.cn>
 <112fea0c8c1b65a762ac98412216239160721263.1635390750.git.siyanteng@loongson.cn>
 <CAMhs-H9LUQ6Km=sA992LH=+E0MbGuMf9YhM6w2HoyeqE0QbzJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H9LUQ6Km=sA992LH=+E0MbGuMf9YhM6w2HoyeqE0QbzJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 28, 2021 at 06:11:18AM +0200, Sergio Paracuellos wrote:
> On Thu, Oct 28, 2021 at 6:05 AM Yanteng Si <siyanteng01@gmail.com> wrote:
> >
> > Since commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
> > the MT7621 PCIe host controller driver is built as a module but modpost complains once these
> > drivers become modules.
> >
> > ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> >
> > Let's just export them.
> >
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > ---
> >  arch/mips/kernel/mips-cm.c  | 5 +++++
> >  arch/mips/kernel/mips-cpc.c | 1 +
> >  2 files changed, 6 insertions(+)
> >
> 
> Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

could we instead make the pcie-mt761 driver non modular ? Exporting
all MIPS specific stuff for just making an essential driver modular
doesn't IMHO make much sense.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
