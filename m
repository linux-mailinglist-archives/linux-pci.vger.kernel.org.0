Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9942E447D18
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 10:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhKHJ4C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 04:56:02 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:46799 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbhKHJ4B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 04:56:01 -0500
Received: by mail-ua1-f48.google.com with SMTP id az37so30256701uab.13;
        Mon, 08 Nov 2021 01:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9iy/NdjxFem4zTtxC00Zuf9Q21cXTvvJdAqpWDyk58=;
        b=oj0YYjtYbImbfNKP3MaBfN0R+sTTfYv0D1NEm/PLIAUV6N1DKYzQARapm0AxTg0NsF
         Tbvft5Nsxv9vtVMzox0TRt5GFuVmYjgXyLQv6iZfTzqK1W99udatOzkP6OQrkUcfMepM
         sDXXwqzJxUVbN5hyl4Xt+QO33WP/mJYYZ+wXCEypLDA2rZraCCWmvIRJ22yx4KRjSXGf
         79sylyCCXDlm95iPOUtUgCnenem326RLDKHlfB3WzOE9TzgVL6XrYRwp2sFGo/7JLFxK
         EYI/DQo7NwUA/JuE3uZ7meksm+RMT8jWgblxWv94pB/t+pG80K9rFtibqkiZZVzP46Iq
         pfSQ==
X-Gm-Message-State: AOAM530XDuWE2hHTni2YA8znQpWBHTI8ARRWVYKYgsKaS+WUsl2bkzAt
        pnrsZzOmjUxawSlMSDyML0k0r1ebcaa0ag==
X-Google-Smtp-Source: ABdhPJwLYpgPIaI+2SaYLE7gzscQQYLfEGfaa9nVcl8d01iWbTI0JQhL9z7ciDzaggeFm6GjP67X1A==
X-Received: by 2002:a67:f516:: with SMTP id u22mr2203113vsn.47.1636365197147;
        Mon, 08 Nov 2021 01:53:17 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id d128sm3101701vsd.20.2021.11.08.01.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 01:53:16 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id i6so30239181uae.6;
        Mon, 08 Nov 2021 01:53:16 -0800 (PST)
X-Received: by 2002:a67:c38f:: with SMTP id s15mr38923383vsj.50.1636365196479;
 Mon, 08 Nov 2021 01:53:16 -0800 (PST)
MIME-Version: 1.0
References: <20211107191057.145467-1-marek.vasut@gmail.com>
In-Reply-To: <20211107191057.145467-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Nov 2021 10:53:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXOBNJcwWVwF-zVgYQ0uezFfRO8ODKAzVExdYV3zH158A@mail.gmail.com>
Message-ID: <CAMuHMdXOBNJcwWVwF-zVgYQ0uezFfRO8ODKAzVExdYV3zH158A@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: rcar: Check if device is runtime suspended
 instead of __clk_is_enabled()
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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

On Sun, Nov 7, 2021 at 8:11 PM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> Replace __clk_is_enabled() with pm_runtime_suspended(),
> otherwise the following build error occurs:
>   arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
>   pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_enabled'

While this describes what is done and why, it misses one important
semantic change: the old __clk_is_enabled() actually checked the wrong
clock (bus clock instead of module clock), while pm_runtime_suspended()
reflects (a.o.) the state of the module clock.

>
> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
