Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757AA2C80C4
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 10:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgK3JRX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 04:17:23 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:43736 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgK3JRX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 04:17:23 -0500
Received: by mail-oi1-f170.google.com with SMTP id t143so13420398oif.10;
        Mon, 30 Nov 2020 01:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpFsmKHMxP9g9q5APyn1icsD+ymXQt4NPSq031N1NNI=;
        b=WSrp/PyOB4L9ORnsszYo+I4K2SIz1/wJvFA1s/5m8MZVPiZ4melDWHVnxfqKIw2xpr
         odlBczevnikx2AgQZ1mI7OYLuNLOjWgC1tRw6v/4Ao0F1BNkOiHDJC/CCx9SJcDJkSKe
         AR3tMA03ly/5yXdFmrpsLpm2YkGri6N//vKec1SUY/cr5BMMhLSMmGW++odDT/5zhkRV
         K8hr+9l8ZlOvPy5uHrYd1LHLZxUhrIM7tUuj0wHUNvRCCf+Zzgux1zBSYIQCvMvFrKAE
         NxL20bAFqecuTclGBHLRh+1n1/zyYDOU9a15jM+Sjf00z+lc2+0zImHcQSmbNN1Z9JHL
         MTgw==
X-Gm-Message-State: AOAM533FVcx4kDXJ/Uipq+k8tnq0t5cBRUEE6lXYKQ67TIpihDEWgRSh
        FF7Go04FXiObu+WLc0fDYodrtbTUudvEYl2XjQeoZ1+DRvE=
X-Google-Smtp-Source: ABdhPJzeINpx9GMKwjhKFTAHXMl7bD1gJfOA2/3YLUwKSuBIptgaIj//KON2S18pSW1vwn1PxT6uD5Ljvsv/bbYS8tk=
X-Received: by 2002:aca:1c0f:: with SMTP id c15mr13811815oic.54.1606727802158;
 Mon, 30 Nov 2020 01:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20201126115927.4089838-1-geert@linux-m68k.org>
In-Reply-To: <20201126115927.4089838-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Nov 2020 10:16:31 +0100
Message-ID: <CAMuHMdXPrfEvFUDEU72odcS6S8e0GS_XRcrcDsQMvSHxMcxwYg@mail.gmail.com>
Subject: Re: [PATCH/RFC] dt-bindings: pci: rcar-pci-ep: Document missing
 interrupts property
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 26, 2020 at 3:20 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> The R-Car PCIe controller does not use interrupts when configured
> for endpoint mode, hence the bindings do not document the interrupt
> property.  However, all DTS files provide interrupts properties, and
> thus fail to validate.
>
> Fix this by documenting the interrupts property.
>
> Fixes: 5be478f9c24fbdf8 ("dt-bindings: Another round of adding missing 'additionalProperties'")
> Fixes: 4c0f80920923f103 ("dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint controller")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Oops, this should have been geert+renesas@glider.be.

> ---
> Alternatively, the interrupts properties should be removed from the
> corresponding device nodes in the DTS files.  Obviously they should be
> retained in the device nodes representing PCIe controllers configured in
> host mode, which describe the same hardware...

Anyway, waiting for your comments ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
