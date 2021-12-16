Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368DC477249
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 13:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhLPMzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 07:55:24 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:34021 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhLPMzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Dec 2021 07:55:24 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MAOVx-1mlzNZ2kV1-00BsAi; Thu, 16 Dec 2021 13:55:22 +0100
Received: by mail-wr1-f50.google.com with SMTP id i22so14247484wrb.13;
        Thu, 16 Dec 2021 04:55:22 -0800 (PST)
X-Gm-Message-State: AOAM530pawN72ypZWEbCYeHsrrrI8SzVJ3p+7BeT4qqPvJaMLnvpRKwA
        Ow9aYWyoQSCy85JjR9Cb2fRRr4VtNi133pXMVso=
X-Google-Smtp-Source: ABdhPJxqiJNKIPDPxQiAYD/ADzEnUGacnfrfwb+mwnEiDpqRpaRAA43q41TWNAdS96RDEsxEkkrg/T9kHUnFSTm357Y=
X-Received: by 2002:adf:a352:: with SMTP id d18mr4393837wrb.317.1639659322216;
 Thu, 16 Dec 2021 04:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
 <20210925203224.10419-6-sergio.paracuellos@gmail.com> <67687e579e633d42dc501cfb6746c1cb9f600112.camel@mengyan1223.wang>
In-Reply-To: <67687e579e633d42dc501cfb6746c1cb9f600112.camel@mengyan1223.wang>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Dec 2021 13:55:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3R67D+0KLrTncr+SiHg79itRkxbG9caDo6YsHKzRwwkA@mail.gmail.com>
Message-ID: <CAK8P3a3R67D+0KLrTncr+SiHg79itRkxbG9caDo6YsHKzRwwkA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] MIPS: implement architecture-specific 'pci_remap_iospace()'
To:     Xi Ruoyao <xry111@mengyan1223.wang>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:k+dzuHUBnxmp237dTZgU2vdCf9nLIyQgN0u/kJd9ELDeLol0Xex
 oV4FQGnqqG6j0hjc75YGtmVtDhFTaZVTgGF4I2Z5rPrc6yooEf+AwPt/gHqdVgNRZwFz3i1
 vwaEEDimGLrIMDxuanD+JbkO/0bC7nOK7reDhNR7HGzuVx6M1GYYqIBnBkDL5ogqGfmWzBd
 /yaID8wU/3lb3sZ7ywHSg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AWZt9FKW1SM=:77i+za3GB8YmkKaN10J2ac
 uW3uAUxFoptCsMT/t3ARo2B/u/ylFW01dODUFD2Z97W5d8uC9EZYo3IwBQb42ajjegQ2G3BcP
 /TckwGBgJVbnn/SFU3iYr8TNqFcqC5evqExqlha8KP+s8KtwL9zhJrCpnTZ3FRgIBFoPC8Jiu
 loZgI2+a+KTUIYMDAuwPYISVbEA0rHDVDrKBH3kYlBqFxqZSxS6CRE55gobAin2yVqsLRNefK
 Y/KPUuG6WX7xTqn5L1jpXda5ot0m1qpECNjDtXyTU+5QuK5NXK38dSzAUuCT5zJbM2P5CeRmI
 vkfb+E8vJyU1PgW6OoH2wqv/3pmLRW0sHkpJAzGIzDonEYvV//pUBBjWpPfIzrJQICyD3MHKi
 JWOi0wHoTDWQkT8RhdweHPvf6z7tlgJkTXVCPmdZJltXguC3BpuHRkW+Vgcbi+Del0WqTI5Ux
 +cBKfyCEnsui/zi010OlUUcGQgWHKJmRI5E+dc7srXW+ckjDyOY2fQEGkHZL+DVYrDUEErpE9
 RFPTqZy35KEmH4r4qcRMHX8C1ViRoXg++cYdNKhXO+Ix+XEd+/SNZwfymhDZCrJ14UyXDoMiO
 FypaXu4DnQlzMhStP/drcslgnak1Pf6VS8J4Pb4hFEyVd8a5y4cjqNDAoiHgD8BOAXgFmnyqv
 SUHsKIyzM8q79Ei7rKnujDx8OQO2b3ZvbPBlkCIKPVPzSWujjfiIzPJh32LEdp/IEGL0=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 16, 2021 at 12:44 PM Xi Ruoyao <xry111@mengyan1223.wang> wrote:
>
> On Sat, 2021-09-25 at 22:32 +0200, Sergio Paracuellos wrote:
> > To make PCI IO work we need to properly virtually map IO cpu physical address
> > and set this virtual address as the address of the first PCI IO port which
> > is set using function 'set_io_port_base()'.
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> Hi,
>
> the change is causing a WARNING on loongson64g-4core-ls7a:
>
> [    0.105781] loongson-pci 1a000000.pci:       IO 0x0018020000..0x001803ffff ->
>  0x0000020000
> [    0.105792] loongson-pci 1a000000.pci:      MEM 0x0040000000..0x007fffffff ->
>  0x0040000000
> [    0.105801] ------------[ cut here ]------------
> [    0.105804] WARNING: CPU: 0 PID: 1 at arch/mips/pci/pci-generic.c:55 pci_remap_iospace+0x80/0x88
> [    0.105815] resource start address is not zero
>
> I'm not sure how to fix this one.

It looks like this machine has two I/O spaces, one for ISA at 0x18000000/0x00000
and one for PCI at 0x18020000/0x20000, but the implementation assumes there
is only one. If you want to use pci_remap_iospace() on this platform,
it needs to
be extended to allow more than one such space.

       Arnd
