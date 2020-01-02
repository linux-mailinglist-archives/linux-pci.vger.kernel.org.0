Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99F212E3F6
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2020 09:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgABIou (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jan 2020 03:44:50 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42070 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgABIot (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jan 2020 03:44:49 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so56084251otd.9;
        Thu, 02 Jan 2020 00:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJXFVlyRwTqj9HkStatG/uviJjFGvZJlZBeqka9UDNY=;
        b=gdiUCeOPqScjXzrbvIh+ShMJdMtOIFx3qiDxl8Rnx0tRID+ljoSEDWZXifZyy+UDoK
         ZbP+uX2yH0Lua7XN3AMGacK2rVrdEAdaFX09Pn8/uzG3t01jvXUKjmInkQIVS+QHIezD
         VXX6JM5ur/SC4XeH73Y6MZ2pf8t8dk3hLl6vy6PahZF9tKuqXwq53iy00PMcaIcImJvz
         a0qOXjUw9jKbNkcQk34Ejg4DCSj/O8c7yFs5z0bZaMFOy6CrljgugPlFvg6n+X9/iQEw
         F/xgEeo5JX2ZN4LVxKsTrzXDRQO8ty7llvBlWTz/fa7rkDg9PweY+jOm9fuFBl4kD2F5
         0bPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJXFVlyRwTqj9HkStatG/uviJjFGvZJlZBeqka9UDNY=;
        b=RL2nRiSN6pm26gySagtnGSBdpJFox4fSSxM0bkFoFZhavUAvTp9lk1wV+v1BmsvU4y
         789IjyZYuEBkldfyMvSe82ptq4Lcp0Wsg2j0oscyzeCrYS8hv4+hfVjdZnzMlIcBW03a
         h5lCgvSY1Is6zfofSLM4K9HIq6mkmTUl8feVUM64lK0hdZUKfXqujfqRtc6UExvz14QJ
         BfE6oQKFx+/piAnrLsyCrDo1atLPQioJzpHU1HFty4u66VHPjAHTVhU7JrblJDLITEV/
         tqpyPEomO13AUAPaKlaAL5QNremkrs2coRdNVtfzkEOLGD5WUGDZASA8BwD2ZCs/r8Qy
         B8CA==
X-Gm-Message-State: APjAAAVOTxiJbxzCAeuNrYa9Mxeo9kOw8qLrwofBhvqOmJNZlIl3R6fR
        q2Fe0897JKIDyKcwvobKAl+o5lNXp87uZ9B2bok=
X-Google-Smtp-Source: APXvYqzOhzS82AptAf2MZPwDekJw6thW0D54iQ6Qt4TuLUMBcVXdHaCHrtJnYpVCXcsxnGiGCP9GyLgDg6gsrK4LUGE=
X-Received: by 2002:a9d:5c02:: with SMTP id o2mr83617674otk.176.1577954688818;
 Thu, 02 Jan 2020 00:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191213084748.11210-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAL_JsqLSYroDZGWksJJ=E+01X=3Tji4+GmK8s3i+d2BJphqiLQ@mail.gmail.com>
 <CA+V-a8uKBuVUQvkoJ9pJYX97Qy3JazTyLCy-2T35gOX77AP8vg@mail.gmail.com> <20191219233129.GA5484@bogus>
In-Reply-To: <20191219233129.GA5484@bogus>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 2 Jan 2020 08:44:23 +0000
Message-ID: <CA+V-a8vjwqkH5rYsy_rsHF93d91izsaEwmFXNpYqk3_=_Asd2g@mail.gmail.com>
Subject: Re: [v2 3/6] of: address: add support to parse PCI outbound-ranges
To:     Rob Herring <robh@kernel.org>
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

On Thu, Dec 19, 2019 at 11:31 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Dec 16, 2019 at 08:49:23AM +0000, Lad, Prabhakar wrote:
> > Hi Rob,
> >
> > Thank you for the review.
> >
> > On Fri, Dec 13, 2019 at 8:37 PM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Fri, Dec 13, 2019 at 2:48 AM Lad Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > this patch adds support to parse PCI outbound-ranges, the
> > > > outbound-regions are similar to pci ranges except it doesn't
> > > > have pci address, below is the format for bar-ranges:
> > > >
> > > > outbound-ranges = <flags upper32_cpuaddr lower32_cpuaddr
> > > >                    upper32_size lower32_size>;
> > >
> > > You can't just make up a new ranges property. Especially one that
> > > doesn't follow how 'ranges' works. We already have 'dma-ranges' to
> > > translate device to memory addresses.
> > >
> > > Explain the problem or feature you need, not the solution you came up
> > > with. Why do you need this and other endpoint bindings haven't?
> > >
> > rcar SoC's supports multiple outbound region for mapping the PCI address
> > locally to the system. This lead to discussion where there exist controllers
> > which support regions for high/low priority transfer and similarly regions
> > for large/small memory allocations, as a result a new ranges property was
> > added, where we can specify the flags which would indicate how the outbound
> > region can be used during requests.
>
> What are the flags?

below are the flags which were discussed in first version of the
series, but since the driver is
currently using just PCI_EPC_WINDOW_FLAG_NON_MULTI_ALLOC flag I'll be
dropping them in
next version (suggested by Kishon) and rest will be added as and when
required by the driver.

 * @PCI_EPC_WINDOW_FLAG_MULTI_ALLOC: Indicates multiple chunks of memory can be
 *                                  allocated from same window
 * @PCI_EPC_WINDOW_FLAG_NON_MULTI_ALLOC: Indicates only single memory allocation
 *                                      is possible on the window
 * @PCI_EPC_WINDOW_FLAG_LARGE_ALLOC: Window is used for large memory allocation
 * @PCI_EPC_WINDOW_FLAG_SMALL_ALLOC: Window is used for small memory allocation
 * @PCI_EPC_WINDOW_FLAG_HIGH_PRI_ALLOC: Window is used for high priority data
 *                                     transfers
 * @PCI_EPC_WINDOW_FLAG_LOW_PRI_ALLOC: Window is used for low priority data
 *                                    transfers

Cheers,
--Prabhakar
