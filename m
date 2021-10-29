Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9023644040F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 22:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhJ2UaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 16:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhJ2UaC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 16:30:02 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3AAC061570;
        Fri, 29 Oct 2021 13:27:33 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id x3so20270342uar.13;
        Fri, 29 Oct 2021 13:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqg/kF25IE3Rne+C/OzkoLGPaIYkldAY8r8E8VHOCMA=;
        b=bnMOeP9UKV5j22QqgzQ60gKvPozViwAWHg4/tjraTKdpHnyuDMwB68wc9gp5Mzampv
         H28aMMbZzF0WVWPq6GIxpbRciQsA4Pwg1YJ3DfBAUHYT/WBpsmlKtsc/BhwsRonFv8PF
         UDGxaIGhVWcH0JQR849iZC1e03Qo2oKGifWkRglByLwhwnhWxCtK5saCEP0aBgvl9XmO
         jZth0xkPECgEOTElbaz9R0+CSi2E2tqak6OYIS6w8xE8b782fOG140liDyPxqpowDcaA
         jGZX0QjpN2ku85KKLg6g+CxcRFFyPB9KIyMT+3/8gClycWB1XMyhM3N1Hd4W/9Z15obW
         ccvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqg/kF25IE3Rne+C/OzkoLGPaIYkldAY8r8E8VHOCMA=;
        b=l6DoNdv1LSkiI3m9z9cwjgEJRhdDs5E6tGuPLw5TyqIKjrZS5SvPM9PAx61EWsRWFt
         HUd+3Xst8yLEvlCHlDG5LQWcw6ZqvGUVuxGDBH38k4gPrIcVpNIEDoXMizvCypt2Lzny
         QZvcRz22LJcrXDwUizA4Vjgu32R+74Yk0z9sf6pd400V0zKouwF6NPO4Jk6mpXIsDBo+
         uqNEPbPFiI+wSPssh0raj02ZQhiGJ1ekI3gzsm4CW76Ni10iZyM0gApatOM9/6XZIMYU
         gkil/Frv8ucIpJh7aNnIWecw3+5dCXpkrhcInKs0FTueDufRQ162BIFyiKRCGqy3abij
         981A==
X-Gm-Message-State: AOAM530EQqRjxkOJ/gkOcBTuAxOmR/iViVYWkaNYRU5rgXwoBj16pspT
        RQmEctcevXW7vqKV7KAYe1glHS89S9SiqsSChO92IBsQ79U=
X-Google-Smtp-Source: ABdhPJxjZ+rsnfCf4Vee/PqzdFgYnFMqI0aY1PJBX3qCSfi+7xTveWV5090iA5r7e+cIPovNX9bCIuRanUZJLTwfsh4=
X-Received: by 2002:a05:6102:3ec3:: with SMTP id n3mr15004901vsv.48.1635539252506;
 Fri, 29 Oct 2021 13:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhs-H8bjOkwfnYqdhWuwA8vt18naW3DABYN-EyW-gDB2cP7JA@mail.gmail.com>
 <20211029194751.GA349935@bhelgaas>
In-Reply-To: <20211029194751.GA349935@bhelgaas>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 29 Oct 2021 22:27:20 +0200
Message-ID: <CAMhs-H9ANAP6bsF3AgUTSnaNYxqhxETVwEcL7AC96pFc=WskOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] MIPS: cm/cpc: export some missing symbols to be
 able to use them from driver code
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 29, 2021 at 9:47 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Oct 29, 2021 at 09:37:53PM +0200, Sergio Paracuellos wrote:
> > On Fri, Oct 29, 2021 at 8:49 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Oct 29, 2021 at 07:28:47AM +0200, Sergio Paracuellos wrote:
> > > > On Thu, Oct 28, 2021 at 10:47 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Thu, Oct 28, 2021 at 11:59:17AM +0200, Sergio Paracuellos wrote:
> > > > > > On Thu, Oct 28, 2021 at 11:34 AM Sergio Paracuellos
> > > > > > <sergio.paracuellos@gmail.com> wrote:
> > > > > > > On Thu, Oct 28, 2021 at 11:24 AM Thomas Bogendoerfer
> > > > > > > <tsbogend@alpha.franken.de> wrote:
> > > > > > > > On Thu, Oct 28, 2021 at 06:11:18AM +0200, Sergio Paracuellos wrote:
> > > > > > > > > On Thu, Oct 28, 2021 at 6:05 AM Yanteng Si <siyanteng01@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Since commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
> > > > > > > > > > the MT7621 PCIe host controller driver is built as a module but modpost complains once these
> > > > > > > > > > drivers become modules.
> > > > > > > > > >
> > > > > > > > > > ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > > > > > > > ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > > > > > > > ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > > > > > > > ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > > > > > > > ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > > > > > > >
> > > > > > > > > > Let's just export them.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > > > > > > > > ---
> > > > > > > > > >  arch/mips/kernel/mips-cm.c  | 5 +++++
> > > > > > > > > >  arch/mips/kernel/mips-cpc.c | 1 +
> > > > > > > > > >  2 files changed, 6 insertions(+)
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > > > > >
> > > > > > > > could we instead make the pcie-mt761 driver non modular ? Exporting
> > > > > > > > all MIPS specific stuff for just making an essential driver modular
> > > > > > > > doesn't IMHO make much sense.
> > > > > > >
> > > > > > > The driver is modular because I have been advised other times that new
> > > > > > > drivers should be able to be compiled as modules and we should avoid
> > > > > > > using 'bool' in Kconfig for new drivers. That's the only reason. I am
> > > > > > > also always including as 'y' the driver since for me not having pci in
> > > > > > > my boards has no sense... I am ok in changing Kconfig to be 'bool'
> > > > > > > instead of 'tristate', but I don't know what should be the correct
> > > > > > > thing to do in this case. Thoughts?
> > > > > >
> > > > > > I guess we also want the driver to at least be compile tested in
> > > > > > 'allmodconfig' and other similars...15692a80d949
> > > > >
> > > > > Sounds like the systems that actually use this driver require it to be
> > > > > built-in, and the only benefit of exporting these symbols is that we
> > > > > would get better compile test coverage.
> > > > >
> > > > > If that's the case, I agree that it's better to just make it
> > > > > non-modular.
> > > >
> > > > I agree and that was my reasoning for sending a patch to also convert
> > > > to bool the phy driver that this PCIe controller uses. When the pull
> > > > request was sent from Vinod to Greg, Greg refused to take it because
> > > > of that commit and the commit was reverted and a new pull request was
> > > > sent including this revert. This is commit 15692a80d949 ("phy: Revert
> > > > "phy: ralink: Kconfig: convert mt7621-pci-phy into 'bool'""). Because
> > > > of this I also changed the PCIe controller Kconfig from bool to
> > > > tristate when I sent v3 of the series which at the end were the ones
> > > > that was finally taken. There are also other ralink related symbols
> > > > that have been exported to allow to compile other drivers as a
> > > > modules, like the watchdog. See the commit fef532ea0cd8 ("MIPS:
> > > > ralink: export rt_sysc_membase for rt2880_wdt.c"). So, as I said, I
> > > > agree and I am using the driver as if it were a bool and also ralink
> > > > systems normally require all drivers built-in, but I think we have to
> > > > take into account also the "historical facts" here. In any case,
> > > > Bjorn, let me know if you want me to send whatever patch might be
> > > > needed.
> > >
> > > I didn't see the conversation with Greg, so I don't know the whole
> > > story.
> >
> > Here it is: https://www.spinics.net/lists/kernel/msg3986821.html
> >
> > > For pcie-mt7621.c, it looks like the only problem is
> > > setup_cm_memory_region(), which does a little coherency-related stuff.
> > > If we could move that to arch/mips, we could still make this tristate.
> >
> > Yes, the only mips specific function used in the driver is
> > 'setup_cm_memory_region()'.
> >
> > > One way might be to implement a pcibios_root_bridge_prepare() for mips
> > > and put the setup_cm_memory_region() stuff in there.  It's not *ideal*
> > > because that's a strong/weak function arrangement that doesn't allow
> > > for multiple host bridges, but that's probably not an issue here.
> > >
> > > If we can't do that, I think making it bool is probably the right
> > > answer, but it would be worth a brief comment in the commit log to
> > > explain the issue.
> >
> > Do you mean to implement 'pcibios_root_bridge_prepare()' for MIPS
> > ralink? I guess this means to parse device tree and so on only to get
> > memory range addresses to be added to the MIPS I/O coherence regions
> > to make things work and then re-parse it again in the driver to do the
> > proper PCI setup... We end up in an arch generic driver but at the end
> > this controller is only present in ralink MIPS, so I am not sure that
> > implementing 'pcibios_root_bridge_prepare()' is worthy here... I can
> > explore and try to implement it if you think that it really makes
> > sense... but, IMHO if this is the case, just making it bool looks like
> > the correct thing to do.
>
> It should be trivial to put the contents of setup_cm_memory_region()
> into a ralink function called pcibios_root_bridge_prepare().
>
> pcibios_root_bridge_prepare() is called with the same "struct
> pci_host_bridge *" argument as setup_cm_memory_region(), and it's
> called slightly later, so the window resources are already set up, so
> no DT parsing is required.  It looks like a simple move and rename to
> me.

I see. Thanks Bjorn. I will try the approach during the weekend and
report if it works.

Best regards,
    Sergio Paracuellos

>
> Bjorn
