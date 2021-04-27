Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C571D36C39F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 12:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbhD0K3E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 06:29:04 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:40644 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbhD0K2c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 06:28:32 -0400
Received: by mail-vs1-f49.google.com with SMTP id o192so13820178vsd.7;
        Tue, 27 Apr 2021 03:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGrRlHhBlZKiN3l1LVzj1AyBNlaPvvMY2uCc5XB9HbI=;
        b=Em2Llgd3Av902Yh/E35ENt3MMM/jV6oKSK/q20NZzJEhL5HUom5qv3ej5h9NW8Q8HT
         t7fN5q2FPuPyGncmxhYStrDHcEHM99dMbvhc85H9vSs/Y/Jz/S5XDHTa/1LOHA3jdvXu
         7WMfuSwU9HMsN4JiMCSSPyUaH8XGaucdz5zARkZidfUujBBwvmv9q/SdD2ARG2cbDxcZ
         jmGqECC7WWeyTTgbBqQXdwWWH3GGqsGQ4Q2GpqT22ycb8LV+Me01D03QNpcC4+wwcojL
         OlZnajNNY93iMYW0erlOJxtXEsKsiBpyIzL/o1vhWw49F6ud62kc7/T/w3Xe+/lzluhq
         2QTA==
X-Gm-Message-State: AOAM530EN9UVmEYsVFqxeG8E9sNvO5DyfIbC4ufxmYjB21m6AsxVMpZF
        HgL11dRNp3S0xVZRmyegs4kR+0WQTltiwoxMSAw=
X-Google-Smtp-Source: ABdhPJy1KHqYPXES3KEM++BD7a0+6SLRBJgtYlFRVah9A5YadG00cG6x+2o8QX7KgmlMEQ2lwcMBHxFvkFoLvoF2+P0=
X-Received: by 2002:a67:f614:: with SMTP id k20mr3002133vso.42.1619519268545;
 Tue, 27 Apr 2021 03:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210421140334.3847155-1-arnd@kernel.org>
In-Reply-To: <20210421140334.3847155-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Apr 2021 12:27:37 +0200
Message-ID: <CAMuHMdUGKMktTWtaXr8jK9x-D5YZ1yXQ-ZJjQ193oAKPAt+3JQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/VPD: fix unused pci_vpd_set_size function warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 21, 2021 at 8:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The only user of this function is now in an #ifdef, causing
> a warning when that symbol is not defined:
>
> drivers/pci/vpd.c:289:13: error: 'pci_vpd_set_size' defined but not used [-Werror=unused-function]
>   289 | static void pci_vpd_set_size(struct pci_dev *dev, size_t len)
>
> Move the function into that #ifdef block.
>
> Fixes: f349223f076e ("PCI/VPD: Remove pci_set_vpd_size()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
