Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC65BCE075
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2019 13:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfJGL3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 07:29:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41216 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfJGL3i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2019 07:29:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id g13so10617842otp.8;
        Mon, 07 Oct 2019 04:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=az517lk7l2JjiWVDEoNmqTwk0kRxY6zy3XGdpUQGK/8=;
        b=LkTKZ1jkTeR9yI8V0jI2BMS4vWkM1lrdRGvFjv2U/v9CUsNia4pyTKepMgQfyCb8xq
         2x6q8JWXETwICqM0pE9CwEOgojNWw2BawBHFz6+vpnYNn0hK0Jy5rjFaZkYX9QgzSiXi
         22O/9liKNXmhrKZouwa5RvTQQwF8ujXVy772raIrcj82tuc3C52wbovFNYPOQZB7N2yr
         N+GsgYbTzdokG5j2HUghX20zk6E9uQo5wB9oYz4xEZGQf66uVn08bQ0Pco7fVBHtPssK
         99TAzno7dYIWzIRsK4t/rBJwyNwbaPDczv55PfXt1Ic/vw9HAdNrmGxdhLnZGLNzxYb0
         jfJg==
X-Gm-Message-State: APjAAAVpWTK8hUhhsaTcy8Jp2UmHsePaUZT825Pdkxr0wB0pTGGfbbVH
        R7Iy3k683Qnv9Vfnft7C/WkKqamieL30sAeQtNM=
X-Google-Smtp-Source: APXvYqxRQNEZnEmH0p+/FXVlkwQGADEscR1yu73btXK3QB7lvmhgAJErpoReSODDZljCt9iJfWcgiO2rZ6AK2ADzaic=
X-Received: by 2002:a9d:730d:: with SMTP id e13mr1096381otk.145.1570447776392;
 Mon, 07 Oct 2019 04:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570178133-21532-4-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570178133-21532-4-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Oct 2019 13:29:25 +0200
Message-ID: <CAMuHMdX4P_5Bu2dO_kVtFFyOOTycm2jFqk8qNAzH3XEeePfG0Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: PCI: rcar: Add device tree support for r8a774b1
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Fri, Oct 4, 2019 at 10:35 AM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Add PCIe support for the RZ/G2N (a.k.a. R8A774B1).
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
