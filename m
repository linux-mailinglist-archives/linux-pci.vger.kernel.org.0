Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC3BD0F19
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfJIMqp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 08:46:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40811 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfJIMqp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2019 08:46:45 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so1597642oib.7;
        Wed, 09 Oct 2019 05:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J47bwEO6SH0I7ztat9/azJ8eziwhYPDazvWnJtRO0hs=;
        b=IV3IXy48MvcvlflhJIR4R6EOPlxc1BIXZuIe2LGYM5LQKmFz24caqgFW+029pVJFY5
         5yuFzXtjUBJkr3S/0lOX3jWx3LcbbpNQwHCGO+lvFyfqZ9xp0NQkIU5iAAtmPkEO4SYw
         f1XzGCIzwPmC6EbiPnCiAaG+eLp7wGSYxK1WrIr9lheq+O0ltt4hToZGT4GhxpPyNCUM
         k4yJMQMHSpy3/1+VuR53dTsBzKH8cwc6Q8xYM3Q3OAVONDKTeSs5oCs8b7K9KWMwz6jt
         I9BTpIaWC1mMeUP3BDoIXg5S9kqXbWu4yTHGfSZ3iDGBdlRgmYPdoT27nX6hyN/lGE+z
         ZbfA==
X-Gm-Message-State: APjAAAUROoM0GDtRYvVV+I4/E65hUifu0mf3NSse0yLnh/hV5LN5ry+L
        vkFlFhaK/wlx+GES0SgdOeqV03nVmOBVP0CZRZQ=
X-Google-Smtp-Source: APXvYqyB8y75Qw1TwUCbQEH4ukLuMBxP24F5dZWNVSCJi4jSyKwiE5ahh7a9uDV/hbkXGttXzxAnWQLYkv+vpZCCGxA=
X-Received: by 2002:aca:882:: with SMTP id 124mr2142307oii.54.1570625204258;
 Wed, 09 Oct 2019 05:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570178133-21532-6-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570178133-21532-6-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Oct 2019 14:46:33 +0200
Message-ID: <CAMuHMdVuDg2cicp8w6fS5F3OWhH9gK1eCMJ_pDGsWAJoWh68yQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm64: dts: renesas: r8a774b1: Add all MSIOF nodes
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
> Add the device nodes for all MSIOF SPI controllers on the RZ/G2N
> SoC (a.k.a. r8a774b1).
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
