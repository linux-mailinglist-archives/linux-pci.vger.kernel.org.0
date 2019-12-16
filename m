Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC3E2120067
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 09:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfLPI4D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 03:56:03 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39082 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfLPI4D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Dec 2019 03:56:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so8254795oty.6;
        Mon, 16 Dec 2019 00:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYtpzi4OVKtcejBRTQymtnHqpwZ9IMOgfskqRMoMYJk=;
        b=FjlOHfjUAfcuD6g8sPuagxsQz5NN8GYgQkKB5eMFUDSFQVwSP89GYTqlut3C2mn/YS
         eBOmWEFi3DmQuTp/qkgihQaDk97WF8xOzKLyWA49CUntFhQp+iGILFSDaYtSjG/0u4Wj
         LxTSyOx9E//ppj6YpXZ9za8Llr1VmVC8BQXLoBKo0CW3HilP1RhaTFw1FQjulLbUp223
         mcF16tAkJWH/7f/hSfMy6k/MJDZnaM06WaiErKL/enY0E/Lb5Y7170h/2S8KarFCyZDD
         CgTiwf8HwXNonQvRTdFiPmrTUBGgr+ds+XVrfdLY1VYSxeJGxr4PI7XI3xP99XeFpSks
         XLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYtpzi4OVKtcejBRTQymtnHqpwZ9IMOgfskqRMoMYJk=;
        b=RPYjI3gwP83QcQqzhxK/prh5vQhNuhlVOh5qOzqkXImdY5cFJ6XypF5jLJ8+OSF8RC
         XSW6ZpvL7bjMYmSQcnR0DJZtLorc8yK+cSg4EFSr0qh/XHa3YJJnG+QmxXgs4g3xmWvA
         wkioxxZykys6C7vyDHfM+ClwuiY5cM8h+Pv3kP/RzLX+EN2gdiO8RG9RFqacemGqpWe2
         zxYAojJ4WoiQBraxp0k0yV9IqiFSl/RAEfAmRnQgHgoZF0F9s5IigrydQ9ApnZH0hoZQ
         NgBt33MutVTzl0zTPf+KVxs9K3appRL7ZiQ/7Y153M+lY9BzJSzUvLMESmhuZD9iukjz
         oHVg==
X-Gm-Message-State: APjAAAWKZa9yihn/6DhMbzE7j9O4osVchadOusA84c5rSIm2rl7ixtaw
        OUkL1LldHSsGa1nUtJGJcbpiaQsbp71nbcXgQo8=
X-Google-Smtp-Source: APXvYqxuG1NFvuEk8dd9qCJss5ujNitykdgf+GtcWeO9MK3yKpQRtT4rBhNxc5bDbHMtxvDMRwurT0NSEqfrjfpI+2g=
X-Received: by 2002:a05:6830:147:: with SMTP id j7mr15118795otp.44.1576486562033;
 Mon, 16 Dec 2019 00:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20191213084748.11210-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <20191213201944.GA190383@google.com>
In-Reply-To: <20191213201944.GA190383@google.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 16 Dec 2019 08:55:35 +0000
Message-ID: <CA+V-a8sd1c_8-weQjn6_UbAmVELLQa=3Fe+0cdXSm2Sif0HDRQ@mail.gmail.com>
Subject: Re: [v2 3/6] of: address: add support to parse PCI outbound-ranges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you for the review.

On Fri, Dec 13, 2019 at 9:05 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Dec 13, 2019 at 08:47:45AM +0000, Lad Prabhakar wrote:
> > From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> $ git log --oneline drivers/of/address.c
> 951d48855d86 of: Make of_dma_get_range() work on bus nodes
> 645c138636de of/address: Fix of_pci_range_parser_one translation of DMA addresses
> 81db12ee15cb of/address: Translate 'dma-ranges' for parent nodes missing 'dma-ranges'
> b68ac8dc22eb of: Factor out #{addr,size}-cells parsing
> c60bf3eb888a of: address: Follow DMA parent for "dma-coherent"
> 862ab5578f75 of/address: Introduce of_get_next_dma_parent() helper
>
> Make yours match.  There are a few "of: address: " subjects, but the
> ones from Rob (the maintainer) use "of/address: ", so I'd use that.
>
will do the same for next iteration.

> > this patch adds support to parse PCI outbound-ranges, the
> > outbound-regions are similar to pci ranges except it doesn't
> > have pci address, below is the format for bar-ranges:
>
> s/pci/PCI/
> Capitalize sentences.
>
will fix that.

> Is "bar-range" an actual DT property?  If it's supposed to be a
> generic description, "BAR range" would be better.
>
my bad, it should be outbound-range.

Cheers,
--Prabhakar

> > outbound-ranges = <flags upper32_cpuaddr lower32_cpuaddr
> >                    upper32_size lower32_size>;
