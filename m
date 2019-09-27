Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1FCC0214
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 11:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfI0JS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 05:18:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34002 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfI0JS7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 05:18:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id m19so1681309otp.1;
        Fri, 27 Sep 2019 02:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1BH0Vz3nqYEk3uBlmLrPdAWKkQEPayw9EpZKQBCwWhc=;
        b=I0JDaqs6fyP+gRO5zyOduL0kpcligQ3/+TipnlTvgLQWhxlBQJBY0Ly8lzocCzaJVM
         bM95A79JRCLtWlP8Lv4jOrB6bTPTez+En7nO0wTEyxWOVwZI3RUWwdidcgmO40mPi9GC
         aDXaW4Uy1CcH2lorFskxsh4H6vXg03pPNSeDHwr7+CytIv4ETPRF/fmugV/61Xy99juS
         9Ga024kvd0tlZ3J3PQB1p9xyO8hVdMEsf0/EbnL+4ruugIA1vbslEabaEGVW+uCunYge
         6LETrSJGZ4jOwwY6fEpFVpGTUs7oFnr2w6fZ+MOfrTMnd3IhT341JOcIRCp3AdlqdEnQ
         Kg1g==
X-Gm-Message-State: APjAAAUsSQ71pJeDVw0Z3QVBiLjyJ+DNAmx4me1HMuMYx4530myhCAos
        +7zaBTqw0c1XUpbQRwEn2QLUXE7ge2ZZL2S5fyQ=
X-Google-Smtp-Source: APXvYqzbPjRiKTghIyriIKOe9Ucwh6OZNxL7ThafEIlwv9M07UyWLoDcrPJrT0NojwgaVgn5gQrCwXQhwitVJOPGwpw=
X-Received: by 2002:a9d:193:: with SMTP id e19mr2283511ote.107.1569575938022;
 Fri, 27 Sep 2019 02:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190927002455.13169-1-robh@kernel.org> <20190927002455.13169-3-robh@kernel.org>
In-Reply-To: <20190927002455.13169-3-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Sep 2019 11:18:47 +0200
Message-ID: <CAMuHMdVmG9NJ3eDWTGbMtzH7+Q0HDOjDR_QoGoGFN4OcQUTbNQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] of: Make of_dma_get_range() private
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 27, 2019 at 2:25 AM Rob Herring <robh@kernel.org> wrote:
> of_dma_get_range() is only used within the DT core code, so remove the
> export and move the header declaration to the private header.
>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
