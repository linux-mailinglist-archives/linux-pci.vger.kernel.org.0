Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C652C45060E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 14:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhKONzv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 08:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhKONyK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 08:54:10 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CC5C061714;
        Mon, 15 Nov 2021 05:51:13 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id ay21so34935553uab.12;
        Mon, 15 Nov 2021 05:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=loPmgc2JMoHVojFdkbldbqXPohmWT0UKpG4ip4T4tJI=;
        b=c9UxmLrzkZhPxioy7U3V/hsKC9NQhlhRuXW40QOG2hzIUbgQeIv+yCP3xTDX3mCIFQ
         Os2PKp7aoSDS14pKoj4NgXvqrPGCXvAFs18MYCouoJ8h+otD3Tv0pKhLE3BBOoJFe7yA
         olkFSbWAt/toDtxJYaWiq3B8p6D6fpaBGz3cVvEjjtS26uws0oNpSQ3kk0zW7xiiL9Tg
         WDeZrbvqivBdIEKR4rX967ZqA4ARWgk/hCwJuEJNcFEOSKq00xEtsawzCrgUO9o+QlMW
         5FchxlTrw1TrBdNjm6a5ia7qpDMMlXma8r+La9KJO2+rucP+VJYwUGXDTRSMHfbCVSjA
         22sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=loPmgc2JMoHVojFdkbldbqXPohmWT0UKpG4ip4T4tJI=;
        b=lF3pRjk3s/hludVVQ0F450Tb9nFd9Ww9S/KEi8zgzANd+7lAtHbZpaa4LLSovkwO8k
         VjQm3IVDlFTrAS/ehlRxCgNXpA75U82q+t5+l4CwxlUAG83jzdjURxIzFobhWmAQG0A9
         VOrLJXaXCm31KFpYLNgqDdJal2f/hbI+mM5u0z7J8bu6JkwnHAtDMdzPrG5J44kNU3uL
         ovLGG1LCf3drsTB+XGXignQj8VF2B2gqXkihh+ytVdM9E5V+S3kAJv3ZfXMkyy4SvTGM
         UXeq0lnj9fI3Ts4TbSLlDxp2Ekjyp8zAVQwULwUTIsbrSpcJw+vZIn2jWCfuoQ2WgqPw
         LCiQ==
X-Gm-Message-State: AOAM533kWnnT97ls5BdfHy3I01xwGQ4oKdAKnJNvXWRuwg+a2sctyhB3
        YIg8Yd2MC4sOz5e1zAK7bx1zM8aqb5wqaTSXb84=
X-Google-Smtp-Source: ABdhPJyCATHHyo59GKA0HsPp6phUyFf4/lxnO0HrklF7lne08WdD+sXyUNde/1Vf72hOstYGkBSMVydHf/PwN/94n84=
X-Received: by 2002:ab0:2a8b:: with SMTP id h11mr59890212uar.98.1636984272431;
 Mon, 15 Nov 2021 05:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
 <20211115070809.15529-5-sergio.paracuellos@gmail.com> <YZJWM33dXqW1BsuV@rocinante>
 <CAK8P3a0A9xAcwDLFbUk--X2+7gFpOL7HJw-9Sk8KZxfoidcxuw@mail.gmail.com>
In-Reply-To: <CAK8P3a0A9xAcwDLFbUk--X2+7gFpOL7HJw-9Sk8KZxfoidcxuw@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 15 Nov 2021 14:51:00 +0100
Message-ID: <CAMhs-H9ox3qeAKCN7ug1BxJArmvjDBSqgubOvr_tK1hasPNs3A@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arnd,

On Mon, Nov 15, 2021 at 2:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Nov 15, 2021 at 1:44 PM Krzysztof Wilczy=C5=84ski <kw@linux.com> =
wrote:
> > > MT7620 PCIe host controller driver can be built as a module but there=
 is no
> > > 'MODULE_LICENSE()' specified in code, causing a build error due to mi=
ssing
> > > license information.
> > >
> > > ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pc=
ie-mt7621.o
> > >
> > > Fix this by adding 'MODULE_LICENSE()' to the driver.
> > >
> > > Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host cont=
roller driver")
> > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > ---
> > >  drivers/pci/controller/pcie-mt7621.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/contr=
oller/pcie-mt7621.c
> > > index 9cf541f5de9c..a120a61ede07 100644
> > > --- a/drivers/pci/controller/pcie-mt7621.c
> > > +++ b/drivers/pci/controller/pcie-mt7621.c
> > > @@ -561,3 +561,5 @@ static struct platform_driver mt7621_pci_driver =
=3D {
> > >       },
> > >  };
> > >  builtin_platform_driver(mt7621_pci_driver);
> > > +
> > > +MODULE_LICENSE("GPL v2");
> >
> > A question here about the builtin_platform_driver() use in this driver,
> > especially since it's set as tristate in Kconfig, thus I am not sure if
> > using builtin_platform_driver() over module_platform_driver() is correc=
t?
> >
> > Unless this is more because you need to reply on device_initcall() for =
the
> > driver to properly initialise?
>
> builtin_platform_driver() does the right thing for loadable modules that
> have no module-unload and are not intended to be removable.

Yes, this is the current state of this controller driver and the
reason for 'builtin_platform_driver()' being used.

>
> This is often use for PCI drivers, but after Rob reworked this code a whi=
le
> back, it should actually be possible to reliably remove and reload PCI
> host bridge drivers, and it would be good to eventually lift the restrict=
ion
> here as well.

I see. Thanks for letting me know. I will search for a way to
accomplish this but that will be a different patch series.

Best regards,
    Sergio Paracuellos

>
>         Arnd
