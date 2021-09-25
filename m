Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26147418431
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 21:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhIYTgD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 15:36:03 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56617 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhIYTgD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 15:36:03 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mgek8-1n4d3t3b0W-00hA3y; Sat, 25 Sep 2021 21:34:25 +0200
Received: by mail-wr1-f50.google.com with SMTP id w29so37904001wra.8;
        Sat, 25 Sep 2021 12:34:25 -0700 (PDT)
X-Gm-Message-State: AOAM533ZJbNs8uJDy+MmIVPSoat2nckamJmatH/Jf58H0pmViEn08+wl
        SvSKiNlt0AYkU65bmx3WblqHM+B549OkG0bOqQI=
X-Google-Smtp-Source: ABdhPJwbpmHIdWFL4NwLB5kag/+wj+bWLQfp5Mtq/+97YD9kjJkKuMkhEupsEM0B7gpocdwbiU1czX+HWHnqtWzRS8w=
X-Received: by 2002:a05:600c:3209:: with SMTP id r9mr8157627wmp.35.1632598465533;
 Sat, 25 Sep 2021 12:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210924211139.3477-1-sergio.paracuellos@gmail.com>
 <20210924211139.3477-6-sergio.paracuellos@gmail.com> <CAK8P3a3SpuioCVBfQpHFGuNQoXG7g8w9VL+V8rYd8Q80Od89HA@mail.gmail.com>
 <CAMhs-H8jF10NpTgCP=_FEaBcedTN75b6MoyrEVrrayJEAdufwA@mail.gmail.com>
In-Reply-To: <CAMhs-H8jF10NpTgCP=_FEaBcedTN75b6MoyrEVrrayJEAdufwA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 25 Sep 2021 21:34:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0p0YwsiG8NgZGPxGp=GwTLXfEO=D=CY3TtmYwiDSuaXg@mail.gmail.com>
Message-ID: <CAK8P3a0p0YwsiG8NgZGPxGp=GwTLXfEO=D=CY3TtmYwiDSuaXg@mail.gmail.com>
Subject: Re: [PATCH 5/6] MIPS: implement architecture dependent 'pci_remap_iospace()'
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:iwWaSM5CXBY1MW15Fj9okJshi2Cef0i1I4nV+u5ir35RIMoDb3y
 dfrmF9caEYBb2QdPK7OcajGnpVZ4dPmjjpTYwS7wgf+1Bosr8mR7a2l1xgxaN4S1RbPEu6z
 Hx4tdMM0LeZaUs2Xvg1VVVOwbaEnKGY9eY+hEP7vkaRmFZZPH4rzKDsNbPW6Oe9h1mHi+bE
 1OekT1v7cmQrlu7A3dj5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d+rTrMa3QGI=:7qVpOzrRZoCYa8FnSoa511
 rre38zTfKG+Iqqt+GNVoDM6+cDH6pp22CxLvAWjeVogIaLZFOHAYyRP1R0URdd1NEILHVc7jj
 bRUbv1z4OW7cU/46J//ydZ77bnqQTJMq5qdHL2xASdBIcrOhRNIi7a1SSL964gTyi6bonFnv2
 +teutYoh3GVdnqm0XlWpmYOK3OFQTPWBXMvltFhrRWBAcgww70bg/gEwRTADMSCrUTzQHI1cy
 qc53VJDiFPd0nshHei703gM1+jljF2Md26ZYD3its16EPN7eGqieVD59GPcaclZ+glzMJ4aCV
 zNUsTdyd06KIHAP8XHuP9W5jf4fkyA/07cIcG9VOkrAhktYB9KvcDPP4u8slVgA0fA9yqCs6R
 QQ0PWyx3xjG0u3phBESct/TcT/ZoJmbM43PevKMqDYAqRNHyL2C5OU/ucuQ6Zwp5qH3unu+sE
 /w/8A27iouEaMTkqsXq+oIPOZxHO2fqMg2kL/hThdHMaJabexM1fEwgbpfZ24siGjdPED56Ak
 rMtQ94uLe+5KjJhdG9zvHImzka5gbQ+JGkcQAfG3QPYv3xAKD5Aga3kdrzcDYjIe953PwOnSL
 aQLqIrmBB601nAIEYqK+Pgh9wZASbkAxlQs+GdLxKnrk3ckrZMxxP98A1gYWVQOgaLk1fgNaW
 j+erZv4OozdwnZPbLA/aOeG0rViGXOqtXo3f5ulnGxawcTPhpbNABcJxL/QaM/ANK2XpZXMi/
 DQWKjMnz+0b7cDUlfgVY3ncef3pVt3miELku1Q==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 25, 2021 at 8:10 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
> > It might be good to check that res->start is zero here, otherwise
> > the io_port_base would be off. That could happen if you ever have more
> > than one bridge.
>
> Do you mean something like the following?

Yes, exactly.

> int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> {
>     unsigned long vaddr;
>     size_t size;
>
>     if (res->start != 0) {
>          // Should I WARN_ONCE or just show an error/warning message??
>          WARN_ONCE(1, "resource start must be zero\n");
>          return -ENODEV;
>    }

I don't care if it's WARN(), WARN_ONCE() or pr_warn(). If we ever see the
message, the system is not working and the person who caused the problem
will figure it out.

        Arnd
