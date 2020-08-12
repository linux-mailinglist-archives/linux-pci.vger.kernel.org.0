Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945542426F2
	for <lists+linux-pci@lfdr.de>; Wed, 12 Aug 2020 10:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgHLIun (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Aug 2020 04:50:43 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41775 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHLIun (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2020 04:50:43 -0400
Received: by mail-oi1-f193.google.com with SMTP id b22so1147302oic.8;
        Wed, 12 Aug 2020 01:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uTYye0fY5xHwFogECVNisHJHp+VC3dHv4j/KKmYK8w=;
        b=UEA0L7ANqNJEu5JOijhbZx5y4QCrhc4YR0b1w4Z9Em8tLCOyvf7cYvx+1TBLjdrwIL
         ynIoYju+xwEPhME2piqmnCq1pGbLhoMrES/LaVjwMTgSAwHwx5jgX0HIzhBEO3gsPiml
         apWq4k7oKm3ebmAjFO1NB1eyE7Gso/7/ni+dJZwGxajt1GRpq6w8D0eyw4v5grKzyJ0O
         YBu5iS8llJJhwlBEOYVkRgEXs6r2pdDoH7k68m6Ffk1cnZBCqYIAW46Z9F+SALH0uycU
         j9+X6tI8N7ityhxToVaKAeOUW7ibq/fqRCuXwwrUiIPdnHjg5JrlxUEam0Mjt/B/IXG2
         Yd+A==
X-Gm-Message-State: AOAM532tWt47pKhzaYdMq1di4kuuWXdvy9tDJTb31b2+JRyzj+zL2lji
        gzteML89Jyr4r03FN5unl8AvfBGYLvZ8y07mqk7G5Q==
X-Google-Smtp-Source: ABdhPJw7NICRip8/V/ucliYbvy3i/MNS3MwKtQtkxSBn9whONMZltPCkuXrVVaWTiDaZxJcYGioLbNjFI+L1GhYUl6U=
X-Received: by 2002:aca:b742:: with SMTP id h63mr6362059oif.148.1597222242627;
 Wed, 12 Aug 2020 01:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200810174156.30880-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200810174156.30880-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200810174156.30880-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Aug 2020 10:50:31 +0200
Message-ID: <CAMuHMdW_tgt9YHoUPL7duk5E3EdtKTE7FkemKu0O=rGN94gHrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: rcar: Add device tree support for r8a7742
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
> Add support for r8a7742. The Renesas RZ/G1H (R8A7742) PCIe controller
> is identical to the R-Car Gen2 family.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
