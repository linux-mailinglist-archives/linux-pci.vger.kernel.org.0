Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31B343F6A9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 07:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhJ2Fb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 01:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhJ2Fb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 01:31:28 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8EAC061570;
        Thu, 28 Oct 2021 22:29:00 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id h4so16073265uaw.1;
        Thu, 28 Oct 2021 22:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3R02g5agze3gTm5Z45MrmlDDVJJ1SjhpJ9wVYHXfFVc=;
        b=dAPzFHqY6a3yuq3WPaxBDLMqDiOOIvbGTScOjWeJ9qYjDnceFbeYAjHCjmG2cdtSt/
         JF2Sh3MpKz+H0WgA2dhV0urNCpDT9IsQJaEkdOg1h6AfroREvG2h/J9t5qpr3xFV5Y6/
         Luj+VxSUsDZk2KOXn+bmj0KnCRWv8z0BYM+ULkYivoL2izRIUAjmePHDr8IYa5njuX/t
         +hzFigJBtBfggVl8QM4sriD8UiUWzEg8+z2AXzEVPvOUEdyEhbue8rLgopr/FYLUtVav
         n2iBAoefklk9UzAs/gNG3stlyB85kiGCLNqjCfTEQ72igNsfST0LQEwdTDkeGpChJrEc
         1MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3R02g5agze3gTm5Z45MrmlDDVJJ1SjhpJ9wVYHXfFVc=;
        b=d17Pn5xY+sVAIiEVp7vib4IWEemkhZMfbOmKA7sVfNKcUpUvnrMhOJAUiULEMw7wtK
         Yc/OwCQLbot3GGx2sqqtUy0FsbcM7X3qBZqXtsphVu2Iwi+FVp1FRVDqU3capbc6Dr9a
         rez107DE1PakswRzl3urvIyFSh/toH82GsXJAM/tUFz1Lbe92Y0wpqYZqxHLnGnIyOxt
         Zn6JYepkGaXwxuTa/STWzQ7wDL9fUQgf5qRfxacIudLtnSoM6qAgAZw4Uripqx/gDWpS
         LhZl0tIvw+zzHyGPFtWre5KUZTCPLlHG+CniXrLp05QpgM/NFSOD3aM3nPh7PF9RC4FV
         KOPg==
X-Gm-Message-State: AOAM531K2x5jq2hSfhQtbK6jcZme3lT6cT5Y0kK01jFECsIHeJwHGREh
        SVSoCLaD/4ZB6CVeDnuJmopDXbCFTjH9EVttx8A=
X-Google-Smtp-Source: ABdhPJxs1fI3cK3JY0LAlIQGqCHUDGWxH+wj3J2xlepe64o7dHGMQFS10+///IP4btkcLM3sItdX9v4WNeESaNXOQSs=
X-Received: by 2002:a05:6102:3ec3:: with SMTP id n3mr9762236vsv.48.1635485338588;
 Thu, 28 Oct 2021 22:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhs-H8HoO7dsfiTFaTRie1-DB-DF5st-gFmS=AF2tfHP_gsVw@mail.gmail.com>
 <20211028204756.GA293663@bhelgaas>
In-Reply-To: <20211028204756.GA293663@bhelgaas>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 29 Oct 2021 07:28:47 +0200
Message-ID: <CAMhs-H_a0PqATB3kFO3dcFiq+reR+5z7FW27M=m2MnnYA48NYw@mail.gmail.com>
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

On Thu, Oct 28, 2021 at 10:47 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Oct 28, 2021 at 11:59:17AM +0200, Sergio Paracuellos wrote:
> > On Thu, Oct 28, 2021 at 11:34 AM Sergio Paracuellos
> > <sergio.paracuellos@gmail.com> wrote:
> > > On Thu, Oct 28, 2021 at 11:24 AM Thomas Bogendoerfer
> > > <tsbogend@alpha.franken.de> wrote:
> > > > On Thu, Oct 28, 2021 at 06:11:18AM +0200, Sergio Paracuellos wrote:
> > > > > On Thu, Oct 28, 2021 at 6:05 AM Yanteng Si <siyanteng01@gmail.com> wrote:
> > > > > >
> > > > > > Since commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
> > > > > > the MT7621 PCIe host controller driver is built as a module but modpost complains once these
> > > > > > drivers become modules.
> > > > > >
> > > > > > ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > > > ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > > > ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > > > ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > > > ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > > >
> > > > > > Let's just export them.
> > > > > >
> > > > > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > > > > ---
> > > > > >  arch/mips/kernel/mips-cm.c  | 5 +++++
> > > > > >  arch/mips/kernel/mips-cpc.c | 1 +
> > > > > >  2 files changed, 6 insertions(+)
> > > > > >
> > > > >
> > > > > Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > >
> > > > could we instead make the pcie-mt761 driver non modular ? Exporting
> > > > all MIPS specific stuff for just making an essential driver modular
> > > > doesn't IMHO make much sense.
> > >
> > > The driver is modular because I have been advised other times that new
> > > drivers should be able to be compiled as modules and we should avoid
> > > using 'bool' in Kconfig for new drivers. That's the only reason. I am
> > > also always including as 'y' the driver since for me not having pci in
> > > my boards has no sense... I am ok in changing Kconfig to be 'bool'
> > > instead of 'tristate', but I don't know what should be the correct
> > > thing to do in this case. Thoughts?
> >
> > I guess we also want the driver to at least be compile tested in
> > 'allmodconfig' and other similars...15692a80d949
>
> Sounds like the systems that actually use this driver require it to be
> built-in, and the only benefit of exporting these symbols is that we
> would get better compile test coverage.
>
> If that's the case, I agree that it's better to just make it
> non-modular.

I agree and that was my reasoning for sending a patch to also convert
to bool the phy driver that this PCIe controller uses. When the pull
request was sent from Vinod to Greg, Greg refused to take it because
of that commit and the commit was reverted and a new pull request was
sent including this revert. This is commit 15692a80d949 ("phy: Revert
"phy: ralink: Kconfig: convert mt7621-pci-phy into 'bool'""). Because
of this I also changed the PCIe controller Kconfig from bool to
tristate when I sent v3 of the series which at the end were the ones
that was finally taken. There are also other ralink related symbols
that have been exported to allow to compile other drivers as a
modules, like the watchdog. See the commit fef532ea0cd8 ("MIPS:
ralink: export rt_sysc_membase for rt2880_wdt.c"). So, as I said, I
agree and I am using the driver as if it were a bool and also ralink
systems normally require all drivers built-in, but I think we have to
take into account also the "historical facts" here. In any case,
Bjorn, let me know if you want me to send whatever patch might be
needed.

Best regards,
    Sergio Paracuellos

>
> Bjorn
