Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADA224D49E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 14:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHUMFC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 08:05:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40712 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUMFA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 08:05:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id u24so1293931oic.7;
        Fri, 21 Aug 2020 05:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1HeEvz2wI1FOpRCVf2LfgURAoLuEdudBP1iVF0BOkU=;
        b=SgyFr+usmSXelf51B2NkMUawWpK1exeGDPeyGt80VxsZgiQzVutCIkQpuOF8dCtELh
         G/5pcxlpkGIrbeVcFg9tYoA9baqMeN0qkOzGVecLYs3cdvMyQTvphmx2/BlUB2BJ8zpc
         J4HO4VjzwQ7Uu1sSIJUUa8iNRouGkjuH7cmwB8gjkLcZBZHu0a6fPp+HoIaPW4oQc1Kp
         cX4szgw9ZZ1+MdfXJJ3z7qqU8Ycls6PpQzC6sWmcea+QoaZocDgptBosl4+7ZjBsLz/f
         +Ftj4MhrVCBTs38Iq723R8jZFoNtVvgtqfGF8QXfWGeYsgNR6A3QGIb8Pkpx6K2+QgXN
         q7hQ==
X-Gm-Message-State: AOAM532P9eF/0EgPUpIjQkCJOTbkdCkVtOIWUXUnMu0TOUQ9HqP83gzt
        kFwdMjXxFtM+cqukELDPaz65qGjuYVPr5pLQG/Dz3Ksa
X-Google-Smtp-Source: ABdhPJw5Y6tFxNr/+/JFx28hKhjq7S4wmnRiKJapNiD/bD3qDlIgDmcckQH7DDOWMsrwer6Zd17bG01T/JVwo+X+V5Y=
X-Received: by 2002:aca:adc4:: with SMTP id w187mr1331706oie.153.1598011499077;
 Fri, 21 Aug 2020 05:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200814173037.17822-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200814173037.17822-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Aug 2020 14:04:47 +0200
Message-ID: <CAMuHMdVHOcPMPM4pWpTgzzDYWhgWnzPthcP5husNNEc_cjC2yA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: pci: rcar-pci-ep: Document r8a774a1 and r8a774b1
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 14, 2020 at 7:32 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document the support for R-Car PCIe EP on R8A774A1 and R8A774B1 SoC
> devices.
>
> Also constify "renesas,rcar-gen3-pcie-ep" so that it can be used as
> fallback compatible string for R-Car Gen3 and RZ/G2 devices as the
> PCIe module is identical.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
