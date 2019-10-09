Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2DAD0F11
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfJIMp4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 08:45:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45087 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfJIMpz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2019 08:45:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id 41so1556438oti.12;
        Wed, 09 Oct 2019 05:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TSLR+mwxg9Q5+XE2yLQVwrJbE3+A+r0QrAVdeWr2cQ=;
        b=P/s7Fn/RrhED7TQp8ccc2JWKLo7Eh2bjijSaclRHV5y9aQ82DBoBN4F75lOSCemM9x
         VdfTG3f54G5Rr++Gbcs8XuKu4y7pLvnwzlcMh7VBVWndxtYy8aPL+ikae9ha6LmwR/9g
         v2m4xhPpnC/8uuYHpKT3674+ElNo/pL7LBrjlHfCl96fAaS4IpbA3Bq81lny5KmANfpN
         EVr7bVkTDNs8LsA9dMdobQWvkZsyJqAehLZzXd65Qzs0RP2qUI9MY82+L1ELsN8P+k+D
         6aAt9l8EnD1KDgJllhlcWk9fEW0wrhUoK5qa1Q3wTOYijIbTCNluHb7RfBJKDrgtrOOE
         yV3Q==
X-Gm-Message-State: APjAAAWy/3UT2OCzf+4o1vIg25ANehGJ/iLeEixhnBKHwWV6PDvvi7n0
        sIwkzQdGy2SEtHD04DMrw2UpowHLdnDSEAh8fNs=
X-Google-Smtp-Source: APXvYqzPsTHOJqIszz4KgIhVWU18UOmy2KceYqxm07f+OeN/TcRbk4nBsPmkiuBtPfwaVHynQPqBQD/X6RsZeR4tMRM=
X-Received: by 2002:a9d:70d0:: with SMTP id w16mr2514409otj.107.1570625153442;
 Wed, 09 Oct 2019 05:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570178133-21532-5-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570178133-21532-5-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Oct 2019 14:45:42 +0200
Message-ID: <CAMuHMdWjNBd_1M69WmeqL4s35BKzVmXpO3EjQ=q-TuqHTj0doQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] arm64: dts: renesas: r8a774b1: Add RWDT node
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, xu_shunji@hoperun.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 4, 2019 at 10:36 AM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Populate the device tree node for the Watchdog Timer (RWDT)
> controller on the Renesas RZ/G2N (r8a774b1) SoC.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
