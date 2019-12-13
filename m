Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB0E11EBEC
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 21:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfLMUgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 15:36:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729067AbfLMUgF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 15:36:05 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C54E246E0;
        Fri, 13 Dec 2019 20:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576269363;
        bh=TD0vlyaaEUltY3uhgJ1XIdZNPofDo4T5Xxo/vcYOCwY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x/ScfOhLMLfLSOxK98g5I1CSfHCvGY8HkFL/pbJrRsktxxOZFqLEFBhiV5wU2WRJN
         wrMijQLeCDJ0+/5Gf3VRdeM4RfREKcGKQHDOeystLL6jmmznSYZQ317HO5Hj2gFMvG
         7MCWp2IyA61/qrqAS2yk3WEW+zO96cbyO5994S8E=
Received: by mail-qk1-f176.google.com with SMTP id x1so267197qkl.12;
        Fri, 13 Dec 2019 12:36:04 -0800 (PST)
X-Gm-Message-State: APjAAAWfG8iJtaCznxj4UTCAv42KaVQ91sahk9pg5aTICADg2k+iRNjB
        yIhYTFKrRnxCDapIugMrJK1Ydw4kTJhq4hG3qg==
X-Google-Smtp-Source: APXvYqxkbISqK9twnzzbDp0Ep4niiepgzIHARDF7yBHJmpY5klt6cp3Cad6Ltt+c1NvlrxmDe5/mRhj5K2wE2GoSEAU=
X-Received: by 2002:a37:85c4:: with SMTP id h187mr14127413qkd.223.1576249641042;
 Fri, 13 Dec 2019 07:07:21 -0800 (PST)
MIME-Version: 1.0
References: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20191213084748.11210-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20191213084748.11210-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 13 Dec 2019 09:07:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLSYroDZGWksJJ=E+01X=3Tji4+GmK8s3i+d2BJphqiLQ@mail.gmail.com>
Message-ID: <CAL_JsqLSYroDZGWksJJ=E+01X=3Tji4+GmK8s3i+d2BJphqiLQ@mail.gmail.com>
Subject: Re: [v2 3/6] of: address: add support to parse PCI outbound-ranges
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
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
        devicetree@vger.kernel.org,
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

On Fri, Dec 13, 2019 at 2:48 AM Lad Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> this patch adds support to parse PCI outbound-ranges, the
> outbound-regions are similar to pci ranges except it doesn't
> have pci address, below is the format for bar-ranges:
>
> outbound-ranges = <flags upper32_cpuaddr lower32_cpuaddr
>                    upper32_size lower32_size>;

You can't just make up a new ranges property. Especially one that
doesn't follow how 'ranges' works. We already have 'dma-ranges' to
translate device to memory addresses.

Explain the problem or feature you need, not the solution you came up
with. Why do you need this and other endpoint bindings haven't?

Rob
