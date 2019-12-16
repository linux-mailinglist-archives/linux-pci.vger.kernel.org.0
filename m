Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4622120040
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 09:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfLPItv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 03:49:51 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:41117 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfLPItv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Dec 2019 03:49:51 -0500
Received: by mail-ot1-f47.google.com with SMTP id r27so8211115otc.8;
        Mon, 16 Dec 2019 00:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xOLwi7XGa06O+FcZfECpskN3Lf2VXslN2VEftJlRvg=;
        b=dJ58NKxpobcoCFcVrixIygWkFd2lRYRcK62+F0oqTQy0PfcLrohbjZ/4794t+zXWew
         6YLPUjhuSc++1fWNSHL/u93PNyCv2AvGz6o5coEvJZP3/hXPveU7fhP50DZUhQl1cz7m
         V5fbw5287Yw5Yh7oHOP+LKFl2v6NCNjzpdDHSpDJqcHwSxuqAjcA54zuTxIvsu+dfUvy
         UjipEEgIYB2tmihK3Vq8xjpTJ7WIBIUSWu1i2WoVVYyGSEL2gBFGJRoiUBwuf9+OYdfq
         fv/+7QQ5mAQxYsEukysEKYsNNsRRs/bU9NflxHI5EA4lz+ZI6DUvHdRkPSA7tteynrLD
         HAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xOLwi7XGa06O+FcZfECpskN3Lf2VXslN2VEftJlRvg=;
        b=Nfe4K/bYqsEzecM5mGaT1laPBKUT0gxjznuZ8Zoc0U04SFNPoxLReKv++1M1m65073
         guSmbiC9WaJst9L6wc7WPeVzSo/kK3GPxJtkIukzkN/Eu3B18iQw9CF4H3yfvuHVhNxo
         efDEEEkdLHXt+/P8be1q1lQnkfJ7GKdXrFnqtfCDAQgyu/jZFrnnAZzqWisIikHniNSo
         SNLoHQN2D2JMTvm8sbufodDw9l5WUdb7NuSE7Moa1ePnAyuMlJ9FcbIclt79rY0P42lm
         xEJa9DMiW135os1/fRglkqv33+TFiQcN5ejCkcaFdz/wcDq4xwYqnKBzWt4ZTFP3+LkS
         JYDA==
X-Gm-Message-State: APjAAAWVndGIal8uv+3/eXXmGtT69aW8hwwgb2dp0enbGiD/4aECeqZT
        lyN4h5uPrT6fM9tTMHWJuiNRJRHnp5iV+6WB/2A=
X-Google-Smtp-Source: APXvYqwlbGXOP54hraUBXqLyvcB1sZC55s35DdLDVTvMlWDnFYSYzIpnhC0yoc7BBbnE7hMFzhGGWwdDVzlod+Kll6g=
X-Received: by 2002:a05:6830:16d0:: with SMTP id l16mr31683433otr.176.1576486189948;
 Mon, 16 Dec 2019 00:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191213084748.11210-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAL_JsqLSYroDZGWksJJ=E+01X=3Tji4+GmK8s3i+d2BJphqiLQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLSYroDZGWksJJ=E+01X=3Tji4+GmK8s3i+d2BJphqiLQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 16 Dec 2019 08:49:23 +0000
Message-ID: <CA+V-a8uKBuVUQvkoJ9pJYX97Qy3JazTyLCy-2T35gOX77AP8vg@mail.gmail.com>
Subject: Re: [v2 3/6] of: address: add support to parse PCI outbound-ranges
To:     Rob Herring <robh+dt@kernel.org>
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

Hi Rob,

Thank you for the review.

On Fri, Dec 13, 2019 at 8:37 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Dec 13, 2019 at 2:48 AM Lad Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> >
> > From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > this patch adds support to parse PCI outbound-ranges, the
> > outbound-regions are similar to pci ranges except it doesn't
> > have pci address, below is the format for bar-ranges:
> >
> > outbound-ranges = <flags upper32_cpuaddr lower32_cpuaddr
> >                    upper32_size lower32_size>;
>
> You can't just make up a new ranges property. Especially one that
> doesn't follow how 'ranges' works. We already have 'dma-ranges' to
> translate device to memory addresses.
>
> Explain the problem or feature you need, not the solution you came up
> with. Why do you need this and other endpoint bindings haven't?
>
rcar SoC's supports multiple outbound region for mapping the PCI address
locally to the system. This lead to discussion where there exist controllers
which support regions for high/low priority transfer and similarly regions
for large/small memory allocations, as a result a new ranges property was
added, where we can specify the flags which would indicate how the outbound
region can be used during requests.

The current endpoint controller drivers just support  single region.

Cheers,
--Prabhakar
