Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB49948540F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 15:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240532AbiAEOGW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 09:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbiAEOGU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 09:06:20 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3B8C061761;
        Wed,  5 Jan 2022 06:06:20 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id u6so61838456uaq.0;
        Wed, 05 Jan 2022 06:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TXzc+NNhHR7zkiqOhJjsY/heE4Nlk/EZ4wy3/3ZxxcY=;
        b=ICLs3I8qx/pXJEJVCvyD+a2RrTir/BHMm2narjNq4HebsRI5t0eGBH2dInNDq45nhi
         jmRVZWT8PhoRoclMO+/4L2wNUPSNuv4l9POAzMsxYhgd+/dK29R1V47BvYLmPecSBFpq
         6X3dvWWFeeKmqqO72MdLsrKytYQne9PgkJTG8fD7oJbk7KYcBw/mmVp+Pkd7UNR4GhuS
         vwqSmdPtgp7CYWiijdwlOvdq5wdxxzI1GZ18nLpQfDkXrGkIbP/+wlE91LIgG2U1fjim
         0emZZUitvFi0nqczjymI7aj2IVHrtmw105YuaoH1ygAH3UV+iGxQVv1iYbuo2XMJLDa2
         UQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXzc+NNhHR7zkiqOhJjsY/heE4Nlk/EZ4wy3/3ZxxcY=;
        b=2wJNNlKZWWKiFOBa2ac87Bd3agJTPHUj/5vHuL0T+j+NNPqH8c6yWKoeqsQecE/Wfn
         KczOVa+AEeow/j/JEIykWdlE9p8dTHhJ/t8qoxC10TukfH0bBOOrxPKTJehDaQScsAO6
         qrgz1wcP9iOP6SC8pDs0AoN75RsOeUmS1diHKCsA9a9RgDPSYELvntho/B78Uk8LH3T3
         ia7GBm+hrmx+CCmnmLVJ47UijJ/IjZZA6LBVrBiZzJFcIRPz3X135Uh7ZhlJV0wOAskC
         jud0hI9iQMk2sbxISyvxJMb+OYI2s4RqlhffaZcONqtrOotRICd/sFYQc/6lR1VIBUuy
         EOIA==
X-Gm-Message-State: AOAM530dz4eGAfjPkka6qrrXOUFUw9j7Ha5eI8NABfoRwZmBYDlkhxhU
        AskO1fW5DYQcToFSl5D6qVbnEvBqMZ38tZ1u8IM=
X-Google-Smtp-Source: ABdhPJzNGCQQ3JRtn8gm/Jq+m9bvCIx7w7LsXCDZGYAJQPObX1tdlEpbjCWGmGefVUDLrEEHVNhotR6kU23+Flxa3z4=
X-Received: by 2002:a05:6102:dc9:: with SMTP id e9mr16237622vst.17.1641391579464;
 Wed, 05 Jan 2022 06:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20211203192454.32624-1-sergio.paracuellos@gmail.com> <20220105140132.GA7208@lpieralisi>
In-Reply-To: <20220105140132.GA7208@lpieralisi>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 5 Jan 2022 15:06:08 +0100
Message-ID: <CAMhs-H-zCpc0GnogKHKfMOBM_FcSKxvewzi7us0eHUay7g8ZaA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: mt7621: Convert driver into 'bool'
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Wed, Jan 5, 2022 at 3:01 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Dec 03, 2021 at 08:24:54PM +0100, Sergio Paracuellos wrote:
> > Driver is not ready yet to be compiled as a module since it depends on some
> > MIPS not exported symbols. We have the following current problems:
> >
> > Building mips:allmodconfig ... failed
> > --------------
> > Error log:
> > ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
> > ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> >
> > Temporarily move from 'tristate' to 'bool' until a better solution is ready.
> >
> > Also RALINK is redundant because SOC_MT7621 already depends on it. Hence,
> > simplify condition.
> >
> > Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver").
> > Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> > Changes in v3:
> >  - Adjust subject to follow convention:
> >     s/PCI: mt7621: Kconfig:/PCI: mt7621:/
> > Changes in v2:
> >  - Add Guenter's 'Reviewed-and-tested-by'.
> >  - s/after/until
> >  drivers/pci/controller/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > index 93b141110537..7fc5135ffbbf 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -332,8 +332,8 @@ config PCIE_APPLE
> >         If unsure, say Y if you have an Apple Silicon system.
> >
> >  config PCIE_MT7621
> > -     tristate "MediaTek MT7621 PCIe Controller"
> > -     depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
> > +     bool "MediaTek MT7621 PCIe Controller"
> > +     depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
> >       select PHY_MT7621_PCI
> >       default SOC_MT7621
> >       help
> > --
> > 2.33.0
> >
>
> Hi Sergio,
>
> I believe this is still to be pulled in some tree, just asking for
> confirmation, please let me know and I will queue it.

This is already in Linus'tree [0].

>
> Thanks,
> Lorenzo

Best regards,
    Sergio Paracuellos

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/pci/controller?id=aa50faff4416c869b52dff68a937c84d29e12f4b
