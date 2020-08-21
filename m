Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B2924D50E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 14:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgHUMdU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 08:33:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40918 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgHUMdU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 08:33:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id h16so1422084oti.7;
        Fri, 21 Aug 2020 05:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kp04NyE1R8mExtAWoAPf6jDea1fvPhMOmzjx4dT17Rc=;
        b=Sma8KB5Np6A87uam6rXitqhTvact/3jhcF3w3Dccl+Am8GcObLmJBlc1gOns3h5Zie
         DQRkAiSgqkDr4K9qgtEetE6ebhwF8kg0RjbjC9VI+9TxFtwdfvZyyxfBtNsg7cptk3CZ
         xqiv5o4p4nV1UkyNrsQZV2T2jflFslqZy3eNeRhzTdzRDzDmfi0uRNZ9IY5sHCtTGnps
         lE9UU66YXOfnZ3ShY9/r+aqsSCgO/N/cMHKpuK58AI1JkNfuHJruiJkALDpxA55mXaIH
         sl1LAOhQ8yLxkYnkq8+zvYHsWqUUefWuy4pXvwam85mtJxZxtOTfcOOUzT48PQy5KC3B
         1Enw==
X-Gm-Message-State: AOAM5323rCzlndlzyTPvaABqLJl61z28YnucgZZPwmMeTx/djpwecbv5
        a6DK/0lyQ10HXZEYYgjiuUby0OM7Ziza5kwObJE=
X-Google-Smtp-Source: ABdhPJwPyOcdI4JvL4B+MLySyU/i068uTb++p4rqF8/sCos5OiyBd/wdDFD6Xo0DomMvbnAPqsRJ/j/u4/jtduKZTIs=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr1618807ote.107.1598013199083;
 Fri, 21 Aug 2020 05:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200814173037.17822-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200814173037.17822-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Aug 2020 14:33:08 +0200
Message-ID: <CAMuHMdVd8pVCMmGNKv4DH7s-rNAD7K7Y=qTVuwveB1v2tFWi8g@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: renesas: r8a774a1: Add PCIe EP nodes
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
> Add PCIe EP nodes to R8A774A1 (RZ/G2M) SoC dtsi.
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
