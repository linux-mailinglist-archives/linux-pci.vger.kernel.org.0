Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444234504DF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 14:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhKONFa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 15 Nov 2021 08:05:30 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:52469 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhKONEu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 08:04:50 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N17gw-1mfY7O1YxW-012WMZ; Mon, 15 Nov 2021 14:00:48 +0100
Received: by mail-wr1-f49.google.com with SMTP id c4so30460954wrd.9;
        Mon, 15 Nov 2021 05:00:48 -0800 (PST)
X-Gm-Message-State: AOAM531/BSt51l9hGN8eH+Spe52UPKJTv73jGKTvOFQdzacdXtiV2PHD
        aVx6l7glykzxzmxBLi4TCViQvc2rJU5PjneRXOY=
X-Google-Smtp-Source: ABdhPJz2jZb0IioVANvEk5/XHzjDyF55+gflOqMSLZnvv9OhleGj61ucIoD3iLfrJotoW7ZKQO6a/T/z+ca0dplDdV0=
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr37014455wrq.71.1636981247997;
 Mon, 15 Nov 2021 05:00:47 -0800 (PST)
MIME-Version: 1.0
References: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
 <20211115070809.15529-5-sergio.paracuellos@gmail.com> <YZJWM33dXqW1BsuV@rocinante>
In-Reply-To: <YZJWM33dXqW1BsuV@rocinante>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Nov 2021 14:00:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0A9xAcwDLFbUk--X2+7gFpOL7HJw-9Sk8KZxfoidcxuw@mail.gmail.com>
Message-ID: <CAK8P3a0A9xAcwDLFbUk--X2+7gFpOL7HJw-9Sk8KZxfoidcxuw@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:8t33xIVSNRIFGAB8ZCf/cAdz/qXfSn1YVuxMaLplSrBq1RbiXYB
 cvqz5aR0BZuhsWz2wR8RezGtT8MJ9qqujv8pdt2dCRIVma7mdUN5VUTWad2qemxM4q+0Zrd
 L4npVriTndzVqO6Xcb9YC1dda7ooLr3qnDaVy3OEqjTQuh/z1m2akUiyVnAgBW9Qs2vUNhb
 1YAYr5rYHW3Wszjk4DdBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ToxZdc1f3hM=:oY3xjNabfFK23siuEr4axT
 Vk1XMlNFW849P7lwJC9SBNyXMWWtj3ZKXK8lupdBJOv+4VPkSb9dwsXNOsqRkXo1Oz0sXo5Ts
 LGCwgNDoDfxCb/EoQ2abKhIrIjo/duJZ2Ejd4N8hbD0ts7HHAFezR7E8C82VQCR1xAEWM1oPy
 qMr7GBv7AxbLU8miuvOgDF3qZS5QagVdhmdHEc4GWWW+ZmMblZ0Co6GKYolI3MuJOn6hs2NjU
 Ba1Un8LLuItLHVa+kA9/altR0zZgOcAd0vCOLOILBSAAJvh+gmV//LFl84ikYSQRwHKjUDaKi
 hxNWLZrF6eVXRE6EE0y/Czr9RfChYDOujItv5ee/3lf7eL5aNYRbI0HLiXUy8U5m7OyS02sa7
 dCWmCPNkK+92ZynU3OA6ltA5SquqrySxxTjwA9TSLEfaFxhPKmAhvpzxrZBy6qDDrlaFPdQ4P
 Qr+/7DOQt7hNPr2Wo1V+d2jAHkTLFN/Dt6VksTjtdUI5vVTFGAzLbuTj5xEieje9spsRK0PrT
 OOP23T1iu13bQjJ/bCH6NcYXJNHhVSJl9lXHPz/U3hGzzcIA7RwTdukL0G/syjwclvtQNhT2M
 teccDthhIk5KivhSy+zeeV43UNLX2NIO/5tVQ/Q2VAXG1zyWxPmaHljtrQ/eM+PCv4vyZvqfI
 Cb11H3/c0vsKa7/7Fk+NrI8gtKZvAnYnBTmYWYne4rD85O4id1rh+ZvTHDQldYFydRaNU7jGs
 CJftzJm8w+glc017bjcEv99v6dFoupUZe3tPFqyjoT+/GHxPZGBE4uT5gGDG11ikYMT1W3sfO
 AZzFXcbFjFp/U/fN0MFCnBMJCDNLNcwh4tPyp7bng3cd01O0c0=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 15, 2021 at 1:44 PM Krzysztof Wilczyński <kw@linux.com> wrote:
> > MT7620 PCIe host controller driver can be built as a module but there is no
> > 'MODULE_LICENSE()' specified in code, causing a build error due to missing
> > license information.
> >
> > ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
> >
> > Fix this by adding 'MODULE_LICENSE()' to the driver.
> >
> > Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-mt7621.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> > index 9cf541f5de9c..a120a61ede07 100644
> > --- a/drivers/pci/controller/pcie-mt7621.c
> > +++ b/drivers/pci/controller/pcie-mt7621.c
> > @@ -561,3 +561,5 @@ static struct platform_driver mt7621_pci_driver = {
> >       },
> >  };
> >  builtin_platform_driver(mt7621_pci_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
>
> A question here about the builtin_platform_driver() use in this driver,
> especially since it's set as tristate in Kconfig, thus I am not sure if
> using builtin_platform_driver() over module_platform_driver() is correct?
>
> Unless this is more because you need to reply on device_initcall() for the
> driver to properly initialise?

builtin_platform_driver() does the right thing for loadable modules that
have no module-unload and are not intended to be removable.

This is often use for PCI drivers, but after Rob reworked this code a while
back, it should actually be possible to reliably remove and reload PCI
host bridge drivers, and it would be good to eventually lift the restriction
here as well.

        Arnd
