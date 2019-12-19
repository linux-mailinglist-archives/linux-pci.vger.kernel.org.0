Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 744B6127183
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 00:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfLSXbd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 18:31:33 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:40302 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLSXbd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 18:31:33 -0500
Received: by mail-ot1-f41.google.com with SMTP id w21so1557869otj.7;
        Thu, 19 Dec 2019 15:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cHN0yTmRtblTpyKmg4iRlUo8Qwlh54zEqesHcqtc4tw=;
        b=d+jLduKnzyv9knYWRuHHTI8kuyrwaRtTGAzk003ScdHmpph+m0EfL+OAilo7LrwZ/w
         ZyVvW0kqXeOoG7WqKWWbi4tBY/KDVpPDaaQX2MYATCNp754CVHtxKv4K4O4a2Vfvlw95
         XDnRaufSupT1rKdqUyaXW1B2ZUTAAfNzva1D3vb6onhrI+Pprok6Kzo6pKsTX+5u9LZ9
         eGUd0gnOYCqAHpM0jOffJ7Y2z897VF3putvc15Oo3EgZh+Pq4afvnG6lK46BEUNpWWg8
         TWAJ6LL4E8CWje/6jXWqcgSKHzq+a9WKUqefl0eqGvHfzY6EPX/HKVvceHNPJm5gCJXo
         4y1A==
X-Gm-Message-State: APjAAAWOx8ClZHYGOPcUv9aPSTs0OMpZe7HcaZOll+RH8ghmZdZ8iMIy
        OV3Z511TbOSQIl/EA1Ab0Q==
X-Google-Smtp-Source: APXvYqyjZvh03uk/NUEQwvqjY4ru5OS3ZB9R5H2+OfsQFZsDDFfjxfktkVMWSrQ5ILJVZfDTUO1a6Q==
X-Received: by 2002:a9d:1e4:: with SMTP id e91mr5962233ote.324.1576798292085;
        Thu, 19 Dec 2019 15:31:32 -0800 (PST)
Received: from localhost (ip-184-205-174-147.ftwttx.spcsdns.net. [184.205.174.147])
        by smtp.gmail.com with ESMTPSA id n7sm2524611oij.14.2019.12.19.15.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 15:31:31 -0800 (PST)
Date:   Thu, 19 Dec 2019 17:31:29 -0600
From:   Rob Herring <robh@kernel.org>
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
Subject: Re: [v2 3/6] of: address: add support to parse PCI outbound-ranges
Message-ID: <20191219233129.GA5484@bogus>
References: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191213084748.11210-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAL_JsqLSYroDZGWksJJ=E+01X=3Tji4+GmK8s3i+d2BJphqiLQ@mail.gmail.com>
 <CA+V-a8uKBuVUQvkoJ9pJYX97Qy3JazTyLCy-2T35gOX77AP8vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8uKBuVUQvkoJ9pJYX97Qy3JazTyLCy-2T35gOX77AP8vg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 16, 2019 at 08:49:23AM +0000, Lad, Prabhakar wrote:
> Hi Rob,
> 
> Thank you for the review.
> 
> On Fri, Dec 13, 2019 at 8:37 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Fri, Dec 13, 2019 at 2:48 AM Lad Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > >
> > > From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > this patch adds support to parse PCI outbound-ranges, the
> > > outbound-regions are similar to pci ranges except it doesn't
> > > have pci address, below is the format for bar-ranges:
> > >
> > > outbound-ranges = <flags upper32_cpuaddr lower32_cpuaddr
> > >                    upper32_size lower32_size>;
> >
> > You can't just make up a new ranges property. Especially one that
> > doesn't follow how 'ranges' works. We already have 'dma-ranges' to
> > translate device to memory addresses.
> >
> > Explain the problem or feature you need, not the solution you came up
> > with. Why do you need this and other endpoint bindings haven't?
> >
> rcar SoC's supports multiple outbound region for mapping the PCI address
> locally to the system. This lead to discussion where there exist controllers
> which support regions for high/low priority transfer and similarly regions
> for large/small memory allocations, as a result a new ranges property was
> added, where we can specify the flags which would indicate how the outbound
> region can be used during requests.

What are the flags?

Rob
