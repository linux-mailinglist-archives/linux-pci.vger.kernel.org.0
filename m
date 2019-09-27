Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C06CC0237
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 11:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfI0JYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 05:24:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46576 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfI0JYa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 05:24:30 -0400
Received: by mail-oi1-f196.google.com with SMTP id k25so4594346oiw.13;
        Fri, 27 Sep 2019 02:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PliSA9XuRMkzrOvLsXtt+pM6dMge6sikKc+gba1/4fE=;
        b=O/ue2AWYELc86dyRJg/dYUtQ5ESkvRM8GzqfUsSOp++gS7AJzsQ/nfUXmfH4j68Tna
         llINWYc/EuXivsMLqSRUi9ho86Wz2ah8vqc4hmp7X2b8qyX7jbNvMFjAEJlVqQf+4/gE
         HFzsMtPpGjAHxo6i3m2eQ0kQY3nEVF/sxHqAV4wBxdkF7Y/Z/k+aWXkynwx/fEkXsHFr
         W8hlKnXsZfLHZaCkyy0MP0Ujv5HLPVVKLgq3CzOehKMq2A4PTVC6LhBlOB6XPMJf5ihy
         KBiN7uwyBcTYZgFPMPtmtv6RHADDugtl4do0QZXNRxmQvhmfppTCXhD9jTqIMDtokHAi
         6FOg==
X-Gm-Message-State: APjAAAWZWnJvXNCoiOcV2wOQ263IWmF9DKsJe437yjtn6O4Fy3T+gXWR
        JSBt0kDHdc8U0w1DCQmZuVHuUdMRlesTB08dmMI=
X-Google-Smtp-Source: APXvYqygMX80pvcFFJI5miUi9Z9iy/nlhZYIiWyd26NXPWeA2/LLNVg0ZajgnmkkOecL3MFc7O0DeaIY3bDnJetu3jM=
X-Received: by 2002:aca:cdc7:: with SMTP id d190mr6065798oig.148.1569576269452;
 Fri, 27 Sep 2019 02:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190927002455.13169-1-robh@kernel.org> <20190927002455.13169-7-robh@kernel.org>
In-Reply-To: <20190927002455.13169-7-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Sep 2019 11:24:18 +0200
Message-ID: <CAMuHMdWHGR2odz4nvY_Bjg8H7SKf1eio=tw9yRRO1VYbGCXAbg@mail.gmail.com>
Subject: Re: [PATCH 06/11] of/address: Introduce of_get_next_dma_parent() helper
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
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 27, 2019 at 2:25 AM Rob Herring <robh@kernel.org> wrote:
> From: Robin Murphy <robin.murphy@arm.com>
>
> Add of_get_next_dma_parent() helper which is similar to
> __of_get_dma_parent(), but can be used in iterators and decrements the
> ref count on the prior parent.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
