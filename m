Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 762B7CE066
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2019 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfJGL1N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 07:27:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35252 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfJGL1N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2019 07:27:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id z6so10636621otb.2;
        Mon, 07 Oct 2019 04:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRO/TI+2U+Mnp2n0LB3QUA+ksdxnhCB7M1sKuDwnBI8=;
        b=kBd+eM3Zz0OEq0Jsx6D65Q0dPMbvIiytCFWLnpssrMkibLBmfLOpCjF6moavqDlkL/
         +t8BgH02ORlxrg6M825hTpr6HZ9Y/7vwXMXhNUz6WGeDNRljQxizlDFioPk8ybW+YPuJ
         XZq9yom2hSMKL1I4FGtOknYUEGMHJwmmd0V9KPMvB2ddNtFUVy4GP9M7hUfWMQYATda8
         seN6GbZlR4G5LOZJT4VwoZ+YO+JWke/v3MnbWx1xjk04pFLg2tOlzssLpOm732NSpTb5
         0wali9lN/a9gb+uKbzWvC0sd2GiJdRCiYuD5xPfaJhlMQAsOxqidB43NZSzi5GTVJpKM
         ASkA==
X-Gm-Message-State: APjAAAVIHB0eIYtCWc/c8AL9MNgOvoniYCFGKKwNCkmYMuZXOZ/8m+sr
        0MXZKDiGnITL5HqV+Sw4HNLTD26z2DVvXw14rrA=
X-Google-Smtp-Source: APXvYqxnu6U8S63dLV1lsHdXGQHef3F61XQEi70QpWOo4C33hmoMZwQPDD+rVz9AbxsCo4FSDAIrRYl9MD9JctgODeY=
X-Received: by 2002:a9d:404d:: with SMTP id o13mr11205526oti.39.1570447632006;
 Mon, 07 Oct 2019 04:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570178133-21532-3-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570178133-21532-3-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Oct 2019 13:27:00 +0200
Message-ID: <CAMuHMdW+FAYwuV876Y_BkHoSMtmV=0zUTU_cU1PGhX6zorqbwg@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: spi: sh-msiof: Add r8a774b1 support
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
> Document RZ/G2N (R8A774B1) SoC bindings.
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
