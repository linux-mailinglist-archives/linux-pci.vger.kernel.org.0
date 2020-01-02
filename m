Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B0212F0D9
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2020 23:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgABW4I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jan 2020 17:56:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbgABW4I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jan 2020 17:56:08 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA3EE2467C;
        Thu,  2 Jan 2020 22:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578005766;
        bh=6Koeg/QpSh6SN7IsDtUD1Yw/jN4FQfOCYYp5OlkQg8k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BJyGrgJRAyAcMthsOmMVJk2/d9roLzBD5KeGqfyxfbX3KtZmnnxHXX0pyJ8akcsha
         K/iFSGYit7euv46SOim83yGJFkSBYf8D90gScmaaJtUv+dQKRJYtoCVXIxkXtGp8sR
         GDbQ6bO22fdQJ5Wf9rmFtnvZeSvKb4mLF6EU8dZs=
Received: by mail-qt1-f173.google.com with SMTP id e5so35708757qtm.6;
        Thu, 02 Jan 2020 14:56:06 -0800 (PST)
X-Gm-Message-State: APjAAAVKxjipXn0TO2rT+3qC8pmu+bnvQkMyWNSBpDwg/Uc+lLB5jr5G
        CWSio0aYWg3he0dfFCGJa9kYg0hXo9uTWv6Lrw==
X-Google-Smtp-Source: APXvYqwAbFfNGIM/JC1KIxuEbN03VDUjC5JsTAOv7Mn+H2Fs2ofR3ekjqd4fT38uPCQz6qNQ3qPQ9Hc0j9LyLmDrH44=
X-Received: by 2002:aed:2344:: with SMTP id i4mr63466799qtc.136.1578005765768;
 Thu, 02 Jan 2020 14:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191213084748.11210-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAL_JsqLSYroDZGWksJJ=E+01X=3Tji4+GmK8s3i+d2BJphqiLQ@mail.gmail.com>
 <CA+V-a8uKBuVUQvkoJ9pJYX97Qy3JazTyLCy-2T35gOX77AP8vg@mail.gmail.com>
 <20191219233129.GA5484@bogus> <CA+V-a8vjwqkH5rYsy_rsHF93d91izsaEwmFXNpYqk3_=_Asd2g@mail.gmail.com>
In-Reply-To: <CA+V-a8vjwqkH5rYsy_rsHF93d91izsaEwmFXNpYqk3_=_Asd2g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 Jan 2020 15:55:53 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJPPuWaOZytWfFy+kwju0tMb2qRN5Ji-Leq2wZdbne_ig@mail.gmail.com>
Message-ID: <CAL_JsqJPPuWaOZytWfFy+kwju0tMb2qRN5Ji-Leq2wZdbne_ig@mail.gmail.com>
Subject: Re: [v2 3/6] of: address: add support to parse PCI outbound-ranges
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        PCI <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 2, 2020 at 1:44 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Rob,
>
> On Thu, Dec 19, 2019 at 11:31 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Dec 16, 2019 at 08:49:23AM +0000, Lad, Prabhakar wrote:
> > > Hi Rob,
> > >
> > > Thank you for the review.
> > >
> > > On Fri, Dec 13, 2019 at 8:37 PM Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > On Fri, Dec 13, 2019 at 2:48 AM Lad Prabhakar
> > > > <prabhakar.csengg@gmail.com> wrote:
> > > > >
> > > > > From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > this patch adds support to parse PCI outbound-ranges, the
> > > > > outbound-regions are similar to pci ranges except it doesn't
> > > > > have pci address, below is the format for bar-ranges:
> > > > >
> > > > > outbound-ranges = <flags upper32_cpuaddr lower32_cpuaddr
> > > > >                    upper32_size lower32_size>;
> > > >
> > > > You can't just make up a new ranges property. Especially one that
> > > > doesn't follow how 'ranges' works. We already have 'dma-ranges' to
> > > > translate device to memory addresses.
> > > >
> > > > Explain the problem or feature you need, not the solution you came up
> > > > with. Why do you need this and other endpoint bindings haven't?
> > > >
> > > rcar SoC's supports multiple outbound region for mapping the PCI address
> > > locally to the system. This lead to discussion where there exist controllers
> > > which support regions for high/low priority transfer and similarly regions
> > > for large/small memory allocations, as a result a new ranges property was
> > > added, where we can specify the flags which would indicate how the outbound
> > > region can be used during requests.
> >
> > What are the flags?
>
> below are the flags which were discussed in first version of the
> series, but since the driver is
> currently using just PCI_EPC_WINDOW_FLAG_NON_MULTI_ALLOC flag I'll be
> dropping them in
> next version (suggested by Kishon) and rest will be added as and when
> required by the driver.
>
>  * @PCI_EPC_WINDOW_FLAG_MULTI_ALLOC: Indicates multiple chunks of memory can be
>  *                                  allocated from same window
>  * @PCI_EPC_WINDOW_FLAG_NON_MULTI_ALLOC: Indicates only single memory allocation
>  *                                      is possible on the window
>  * @PCI_EPC_WINDOW_FLAG_LARGE_ALLOC: Window is used for large memory allocation
>  * @PCI_EPC_WINDOW_FLAG_SMALL_ALLOC: Window is used for small memory allocation
>  * @PCI_EPC_WINDOW_FLAG_HIGH_PRI_ALLOC: Window is used for high priority data
>  *                                     transfers
>  * @PCI_EPC_WINDOW_FLAG_LOW_PRI_ALLOC: Window is used for low priority data
>  *                                    transfers

Looks like configuration or policy, not something that belongs in DT.
Coupling driver features and DT changes is not good for ABI compatible
changes either.

I'm hesitant to accept any PCI endpoint binding additions because they
don't seem to be completely thought out in terms of supporting
different usecases.

Rob
