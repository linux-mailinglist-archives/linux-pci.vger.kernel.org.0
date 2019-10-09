Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6212D0F1E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 14:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfJIMsN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 08:48:13 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43391 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfJIMsN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2019 08:48:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id t84so1593131oih.10;
        Wed, 09 Oct 2019 05:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9sihoD8xtf+xJJ/YN8Ttpi/IAoGkmrDo73SAP7wiuU=;
        b=lEq7dDjBTWi1L0HDF0T6p3dbSb+HAbjN6m5Mf+PcNG0MsuYTZ7Xjr/aD21nEj9AC2P
         4L3FCi2qaCH2IpFNdSd1PYxZ1OPns9imP12ZC5R908G4P8oBtFFR4GUkWmcyB9GQkwFA
         +d9R26M2C/4VNN03pDfCHiefVwTxj6qmqGxDCfWoOeHkSBb1Oy5Ht24l24amHFXNLmgr
         uj/2RUxy/HP4WRizxKIf8weBwSp9LV0kX9zQpIDoLz8pGmLkkrXo6XWwAAN3D+xrX15V
         A8RD4f1yf8aWLwOTyJgTA7J5ONzQ9MhLOwzMyBgDaz6YckvA3HovRpkXI+UgcgVKnf+0
         tlIA==
X-Gm-Message-State: APjAAAUgbxOSP4IiYOtbUHEVvFRwqjggYVy6zwk6JAYi1yWTCan3MQJ+
        i0TEhVwBK8gy6tS42cY7k405n2/SmZ9wGVvEcuE=
X-Google-Smtp-Source: APXvYqz8RkrMAo1aVETLuTwYrdB2hkzhyiOgT81nepAIJT5UFEWrRqAdCBYAgc1IF85bemnI+YynzlBidICme1Cn/Nc=
X-Received: by 2002:aca:4bd2:: with SMTP id y201mr2187936oia.102.1570625292202;
 Wed, 09 Oct 2019 05:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570178133-21532-7-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570178133-21532-7-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Oct 2019 14:48:01 +0200
Message-ID: <CAMuHMdWNmzWyUkHsJbY9A8of1B61SCcy3J8Friw0JDCctJa2=Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: dts: renesas: r8a774b1: Add PCIe device nodes
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
> This patch adds PCIe{0,1} device nodes for R8A774B1 SoC.
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
