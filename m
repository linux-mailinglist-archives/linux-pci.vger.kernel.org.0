Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E8A24D515
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 14:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgHUMeC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 08:34:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39323 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgHUMdu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 08:33:50 -0400
Received: by mail-oi1-f193.google.com with SMTP id a24so1362531oia.6;
        Fri, 21 Aug 2020 05:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FoCf/d6sCYZ/KyyrwIp5Cw6quj7S+sdns+Np6rCMhPg=;
        b=KLU+J6w1rXFNySHGFk9iXCt9cq6SFcZ76Q1Au513FKBuqxo1EvgtHtS0h23k33X7W2
         93dkV+wp6Vrv3ymk2gzti05s3Q5wgJeyWTXgmOhDbVByo/xBO4ya6vzZbwJJ+URsz2eY
         MUJMzkAVoqQrUVbkJALqphX1zWM2oVuyC79hg4RqRxix4qzgVtqbQzrGRUGU5WWRmtS9
         ttoLP7XyIyjcfDRsxL0zPHphcoCFKA7VW3+alsISX3If+GkqsqTGtEmtO4kzz6eqVeEK
         jNwiYfTJam15VdS3PiF3hrre+A+ViA6Gmzh8wc/VU61RZ3b7xotDgn6hATYMSPcwaeGE
         +8Pg==
X-Gm-Message-State: AOAM532uVDga8AnwTgdxcBobCDwPM6bbbIAA0RDP7jwreB+D2rfkC4+3
        pgNdQKq5evATBPiA+MzgJVkqR2Az2P9OQBcHGPE=
X-Google-Smtp-Source: ABdhPJxWQSlxIg5H9r9XwKN6jG7+1E3KJtg09/CU7FmrrF5Uj8lLu2+kQ9TMsGSuMGcCDf5wtGdnObsyKjrnYUnE5xE=
X-Received: by 2002:aca:b742:: with SMTP id h63mr1498785oif.148.1598013229860;
 Fri, 21 Aug 2020 05:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200814173037.17822-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200814173037.17822-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Aug 2020 14:33:39 +0200
Message-ID: <CAMuHMdVpZbN41+dNDdC6qGhyb7bjdK=d26T+FRdpypvXjw_0uA@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: renesas: r8a774b1: Add PCIe EP nodes
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

On Fri, Aug 14, 2020 at 7:33 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add PCIe EP nodes to R8A774B1 (RZ/G2N) SoC dtsi.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.10, with s/pcie_ep@/pcie-ep@/.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
