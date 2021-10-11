Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9232E4287A2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 09:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhJKHbb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 03:31:31 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:42569 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbhJKHb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 03:31:28 -0400
Received: by mail-vs1-f49.google.com with SMTP id y19so463581vsm.9;
        Mon, 11 Oct 2021 00:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgMof5ZUC0fmw9h8iZYlS40RW3RGZtBMlIz5QMNsq2I=;
        b=WK78ZdCBwY+ujEtn6FtVuKo41348xxfI5JxXNZQU0B0YnSF9Vzc5IJlpDuJqV9Z3LO
         nj5LhIj7jMXpJ8rznCpd4EX7FudVgdWlsaxpEIvgmYbB8cECx/MX7CqC8aM9CYl+2p40
         0HuxNp1odtwE9KP9haBj0jcfc6HRA+tz2wSd7pJDkf8A7jNO4FbifVZl2RpmtOtwe6GS
         FryXlVqAXong5TGRA3swxTc/9nv3ZY1tmLduA7iu0hyaijj4wqv85rqMC414nwV9wRTI
         Hv6UDLXW9AUPqeNKrVbJmr3WigMEKQOHdJWDJ5GjLXaZ14SeTKm2C6mwVlyFzLJQZ6l8
         yOfw==
X-Gm-Message-State: AOAM5331V5Kv1oZMsIOC4HpqlzhJY105h62GpHIJzgHpDDJsUyDKRU0q
        6d05U6RZNT1ZORog9stREKNKKCBS0+T9iiFphmU=
X-Google-Smtp-Source: ABdhPJwxIcLsvlwauYZnwBdgPCDkR3pMdwmI0c2vn88vM6zzbeY+QI0jdDxPZSqasVoCWPvu747ErIj9v0uidqPPS3Y=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr21664575vsl.9.1633937368767;
 Mon, 11 Oct 2021 00:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211010220658.873504-1-marek.vasut@gmail.com>
In-Reply-To: <20211010220658.873504-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Oct 2021 09:29:17 +0200
Message-ID: <CAMuHMdX=enk0rn3TwB1FHdfmJDXdymKrbCQucpAFiEBY_sdLOg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: rcar: Remove __clk_is_enabled() call
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

Thanks for your patch!

On Mon, Oct 11, 2021 at 12:07 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> Remove __clk_is_enabled() call, otherwise the following build error occurs:
>   arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
>   pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_enabled'
> This should be OK, since the bus clock are always enabled in probe() of the driver.

As I said in [1], the bus clock is the wrong clock to check.  The
correct clock to check is the module clock (like in the ATF version
of your patch).  Unfortunately I missed this in the review of the
original patch, sorry for that.

As I said in [2], while the bus clock is always enabled, the module
clock is under control of Runtime PM.  I'm not sure it's never
disabled (e.g. during system suspend).  So you may have to check
pm_runtime_suspended().

If you ever get an imprecise external abort for some other reason,
while the PCIe module clock is disabled, accessing the PCIe module
registers will lead to another imprecise external abort, causing
infinite recursion.

> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

> V2: Drop the __clk_is_enabled(), like it was done already in V1 of
>     a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")

I couldn't find v1, not in my mailbox, and not in lore?

[1] https://lore.kernel.org/linux-pci/CAMuHMdV8Xu-Pgda9ZrgaXFqXdzBrSRWwiSQFLjzxqRGNWkO3wQ@mail.gmail.com
[2] https://lore.kernel.org/linux-pci/CAMuHMdVQ7r6-H8kBiNYXdqHQRGJxc4eE4hYthFw+XJZx86g6eA@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
