Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F75825D808
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 13:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgIDLyd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 07:54:33 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41556 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729897AbgIDLy0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2020 07:54:26 -0400
Received: by mail-oi1-f195.google.com with SMTP id x69so3274668oia.8;
        Fri, 04 Sep 2020 04:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2902tjUEExh56ivZ/AyWrd8lNxBnpBrvUDOJVnYpxn8=;
        b=M4kHKVjCAa64eaSuRtNsl4kFfWoHLP/4Ap2THRF88GgWf+NxzAWjVrZKrxJ8IQXG7C
         0b0afpTPbWykv9flamTHerboEAKuZTxYEny+si6DnAuYjAGbuH54bdb3d4ZZ4NGg2/xH
         xqKNvXbFCpRL84i5Ft9lbJZuDdlZ+JmfkAQveKqVde/i6JDYmMTp0LyrWLGewG3Gl/hb
         C33NiVgVR4KpTm65B0LCq/n5e0buWPQqJVnn6oL+n+ohvveRlW5LPDvaPInRuES670Uo
         7srDHIZz4XOmj3gCPS08yTVh1sBF/zBBkOPSX2fNVwSVYNLHxbzflwK8BJmJorNbrO/S
         y8dQ==
X-Gm-Message-State: AOAM532q2UDHIe9gQsdisu/aepMw/0r+rzqsirVO+5cht4gSx+rGp152
        ps7Xmx/kZD7lxHC1zWoj2m7dOZhBGzG+1RxrEAw=
X-Google-Smtp-Source: ABdhPJxqBW2qkfqhyQA8beJB0ynb06FiXs2Sra/JUeCdmeXFfQpOQTFU4fXCvw0VFkR3Vamin3n+uLK4eLpqIC3qmCY=
X-Received: by 2002:aca:3402:: with SMTP id b2mr4788351oia.153.1599220465481;
 Fri, 04 Sep 2020 04:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200904103851.3946-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200904103851.3946-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200904103851.3946-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Sep 2020 13:54:14 +0200
Message-ID: <CAMuHMdVWqdSa1AkAYKUt80ET-t-BjrywZ4ijrfcQSkwbKb1DKQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pci: rcar-pci-ep: Document r8a774e1
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
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 4, 2020 at 12:40 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document the support for R-Car PCIe EP on R8A774E1 SoC device.
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
