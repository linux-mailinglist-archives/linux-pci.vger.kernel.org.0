Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F41824273C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Aug 2020 11:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgHLJMb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Aug 2020 05:12:31 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33048 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgHLJMb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2020 05:12:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id 25so1226462oir.0;
        Wed, 12 Aug 2020 02:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHgYnKByHg5dhHsGT1IBu2QcKNIoIouHLZ5r2cTdlOs=;
        b=cD5BRDOUvIJzh6bel3qQvhFw7FaXG1/dDhNPPocM3c5p791kgL7qyYogV/+zyc27am
         WFPt7iKzb8kYrHhrSwrAn6ggqSWdCwh+XHQIxk5LZ1TOGCCde+B4rmbD+rGIuAjA2BTd
         TwETpq+MpZe0OCK+Vs9LLoIIaZOSOiF1GTb87WPsWpclbBGP+2prh5yrlofmiRuunqOj
         fDEO4S6HYvmO22ROhOwQXH5SSzAKuB7THyWDUa8vl2qhcoKsgpcPyue7LobscfF8a5Zb
         HAluA57dG2VB1cdX+tmq4ekZ3j5dh9GSrHaLQPdorLFEQ5lUOstYZVzCrMPq21bxvnMZ
         KmgQ==
X-Gm-Message-State: AOAM530/Zum/YQAoGwfVcKXdjm+Ot4UL2CMtTHhUIhpAiVqFzzbAxA8/
        cSo3DNNKYQblAtU3V/9TSI8t4+M5C7XE/XAb5vw=
X-Google-Smtp-Source: ABdhPJyh3HdXy3ssU6NgUanxf31X/8KIztM8TZkSzCN0cHypQjdelZ3JgOtlJMfvNbHXn5OSNb8P2d46fzcQH4Z+Q0M=
X-Received: by 2002:aca:4b54:: with SMTP id y81mr6709650oia.54.1597223550326;
 Wed, 12 Aug 2020 02:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200810174156.30880-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200810174156.30880-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200810174156.30880-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Aug 2020 11:12:19 +0200
Message-ID: <CAMuHMdWJrrC8X1zfauGbpraEm0aO8szeZskNdPRCbwzp7cfZTQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: r8a7742: Add PCIe Controller device node
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 10, 2020 at 7:42 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add a device node for the PCIe controller on the Renesas
> RZ/G1H (r8a7742) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.10.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
