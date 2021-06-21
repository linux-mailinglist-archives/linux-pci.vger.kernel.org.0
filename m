Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44FC3AE887
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 13:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhFUMA2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 08:00:28 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:44580 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFUMA1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jun 2021 08:00:27 -0400
Received: by mail-vs1-f44.google.com with SMTP id x13so9047832vsf.11;
        Mon, 21 Jun 2021 04:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JvkNDTjahjImKj3duGEUeFWayKv7PwXaOqSSyc1OVNU=;
        b=mzK59I7nS2/Rbb7tHKJMj67tOfJ4UMw82PnXs9qpMeAYPi9OTasrlFXZsRv+kikZRN
         1q00zKJKYkb4SZ335W2+vHhWXV5YeZktngy4xw8gJns7FeS36Bw+5V4gTyMw8r3VJiOK
         zfl7iWLEtT+BBtWNst4tpHJYQ1EO+6TwMp7E31DnM8RQUSLeB1R3QNgEw1bEih263m7x
         +bQL513hHSD+S8Z6iM/nbZS61pZKhh/4KSr4qQsHn0FU85FmL4ZzypKW4cKr/kcXYeIT
         b/4RJMiTvYpX3VlR4Qxr69LWo9Qyx2v135E4WtVQG9TUQFjKJRU6ob4wmaNaPGWcj9N5
         thiA==
X-Gm-Message-State: AOAM530qrcPEykzzwSoazQjg4+n8JPS4v8SFpODCeKv4XMcQdmCj3Y3Z
        v5XHiynpGPp7JAohPH1lrF7x5keWRKv+NbNlnTc=
X-Google-Smtp-Source: ABdhPJyPTI7R1k+VHXKEn7V/ytUzb8Ph6jRLuMRm32wJsktBv6I/1V9kLSm+9ZXOI3OWa7GJ2hPARZleNFt36FNBlDA=
X-Received: by 2002:a67:7787:: with SMTP id s129mr11610077vsc.40.1624276692898;
 Mon, 21 Jun 2021 04:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210408072402.15069-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20210408072402.15069-1-dinghao.liu@zju.edu.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jun 2021 13:58:01 +0200
Message-ID: <CAMuHMdXAW5jeUBQzK84DMbUqhG+NyD1V=Spci2RYahw_X_m12w@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Fix runtime PM imbalance in rcar_pcie_ep_probe
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 8, 2021 at 9:24 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
> pm_runtime_get_sync() will increase the runtime PM counter
> even it returns an error. Thus a pairing decrement is needed
> to prevent refcount leak. Fix this by replacing this API with
> pm_runtime_resume_and_get(), which will not change the runtime
> PM counter on error.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
