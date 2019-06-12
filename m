Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304AF41E43
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 09:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfFLHwT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 03:52:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34998 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfFLHwS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jun 2019 03:52:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so9617374ljh.2;
        Wed, 12 Jun 2019 00:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHAiVBtI4wTRr/mIaxFBqtCpECcSlQ7YSDG2J1NlBOE=;
        b=uSUiwkbSkpAx9D2wqxReGVfnlLBU5wqk2FDoGu1/Q13WdnLKhQFliQWPFz7enbEw7M
         EJG0QokvF5S/l0I8sFeX071cudNfY4xZ+bvrRJl85xrDlsLEQkoAqg0CsuUvB6GD2gwh
         tfIFd5+th6na0GqBcNvfg6vZe5X1XVWZ6Y4PmCh2UjDEIqICD1X3Ihm7bNb7w6GhnLjT
         FLQcqNyo1m5L5xC8+HUD+Fvzn/xVNVnDjOx5eftLdbV5/yZr6Me94HVLbpf2bgAXjzME
         5FgAe9/8bGkzdKjZzSPXmCDOunOGP2YDZorngLJqi9Ls/8XY0ES+ojECqJa4NLMbOahp
         9x5g==
X-Gm-Message-State: APjAAAXub8NgLAGOJbo5XuPeTHHF8/DkGENUr/nHB8TrqK8pn897dFWW
        PjG3169LIGXYZ9/y1hRhxkJ4j/hrGt4TJe6aFOQ=
X-Google-Smtp-Source: APXvYqyvS1HtmoeUVU1qWAovQA9z2SrohqY0mW414kk/CrLu86gLlSpsg1lYfW4xpd516YTxz/WXuYe6YPfVc7afNec=
X-Received: by 2002:a2e:2b8d:: with SMTP id r13mr31669052ljr.145.1560325936859;
 Wed, 12 Jun 2019 00:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <1559891016-56157-1-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1559891016-56157-1-git-send-email-biju.das@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jun 2019 09:52:04 +0200
Message-ID: <CAMuHMdW3GxjF-MPRDkJorLpAzPKSNx3bE+sHAGgUHrV1d9pD0w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: rcar: Add device tree support for r8a774a1
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 7, 2019 at 9:08 AM Biju Das <biju.das@bp.renesas.com> wrote:
> Add PCIe support for the RZ/G2M (a.k.a. R8A774A1).
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
