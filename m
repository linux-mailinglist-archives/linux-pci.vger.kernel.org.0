Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA97D12A0
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 17:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbfJIP2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 11:28:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45566 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbfJIP2S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2019 11:28:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so2047487oti.12;
        Wed, 09 Oct 2019 08:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNZ+n3OtX3na0ohvcbS8SQf8eEI7FgG1atzrBqih6OY=;
        b=hHZBNA6AIRTAdcd+DXUoxT4nD9PZ6SC1UsCuCZwx+/74MuPXgSB9nXwDR8b9uBBzxt
         +M97SuGSgdGxK70GZi05s84hH3CtKSAUUb6pQubhdnNG4u25z056e2EM1XYqntDYua3M
         V1VuH9UA5TEmXnFAE/TYosbVSQfmgQPy7SWXViSyTTzcIxX6ioVbLFVEEDvAfjwnSzHB
         /xgm159cfYsWy9ZIbMyXB6tD5Z0UKjUlZBEaWSRTlgnszkKJj9RNSL+tTQVk2WCvLkfl
         xfnwgvBXkDXiaUxfbxoz3v9EcbkIbByHe+fRwPB8YVW0rxnbaKOwPIVujqx33esTcOQW
         Th/g==
X-Gm-Message-State: APjAAAV0eDWNqrd0OKY6Pnld1ZpGG+Fp7Y+MwOQzV8/tMC23cZ5qpgmJ
        5T/bwTdO/x4sgTivoyOROO8xMGE4esza+SzmNlM=
X-Google-Smtp-Source: APXvYqw3ZyNq6jFBTnHzS5gssLfE4DTID8I3qd8m84Q2kJvxaTWtxYsQx05sqIr5tsbvXGxgM7EoCiB2ZB97ZSP64/I=
X-Received: by 2002:a9d:7a82:: with SMTP id l2mr3423323otn.297.1570634897533;
 Wed, 09 Oct 2019 08:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570178133-21532-8-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570178133-21532-8-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Oct 2019 17:28:06 +0200
Message-ID: <CAMuHMdVh2=84=BaEw+aTvXC35K6A0KG2-18sgbvTxtqaan275Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] arm64: dts: renesas: hihope-rzg2-ex: Let the board
 specific DT decide about pciec1
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
> The plan for the HiHope RZ/G2N board is to enable pciec0 by default,
> and use pciec1 physical interface for SATA (as SATA and PCIE1 share
> the same physical interface), therefore move pciec1 enabling away
> from hihope-rzg2-ex.
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
