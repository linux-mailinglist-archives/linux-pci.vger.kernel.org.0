Return-Path: <linux-pci+bounces-36240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FE4B592D5
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 12:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0BC7AA4FF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 09:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1422BEFF0;
	Tue, 16 Sep 2025 10:00:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F1C2BEC2C
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016809; cv=none; b=sAz15ILilcx9QgYwUnPziQwKkX+NOV7XxjikXuMlNVKjCHI2AH9zh7RFxubjHQ9NUdZLPWG3l0Ssl8hLvgcisCdjbm7w3Z3KkuAzwkHblu/TPjEWOmLtZu3CHGeezpDE5H5hBpjaS6RZHb1L0ChANYUXYqlKPgdhHqQX/1zCGXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016809; c=relaxed/simple;
	bh=v03hoUFvJRhChpnndr2qgMOU72Qeguu9KwSIZsAFkhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAyh6sFm1UtJZjSU4EqDe6kAskUkGgS3jUjxuUgEVYM20iuy7AQr1t/O+vOkH3IYALIhIB2f6Hs0h8WZJ2wGKN/RmbVzIh2HNmaVWYZVfuwcsPaQqKGaqau5+eXOXJXMYKn6dEererf/RH9H2trOMihbeTNiuxy5Br55zK20UiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-529da1b07b5so803005137.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 03:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758016805; x=1758621605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCWxUML6fyVHqAqlmS/Ne3WZwFujVO2PRku0xJENfBw=;
        b=Bzo8i+r1l9p+F6N4qKJchcro+5E9ujMB/7vBisV5doIcNCHcf8Yx7Xf3GtWEVQmh62
         gMS5ebUPZMu5UGQiXvMeoBNgYdnuIBS5HX8IRIc7kEcN5/ytnZ4sG+8D3VqaJuWz4Aaa
         SizaAwKaLLzzoKLPhlsOofgPpDw2wIH8Olcgko8Umw1/p9Ctf/dwvFOSSlNZycaBVlpx
         +6WXG4HhXW+pOrFEQN8Z5rOvmxqiKZJ5B9bvikKqbX6+jFAmZ/BXqpTrcDukelYQ0+oc
         eaUBuPs90LT/qKCMYFaYnWDvysZgddKcJUfxEihcUx4CydlO+Q3ERTIfsZoq6dbCd8zv
         re7g==
X-Gm-Message-State: AOJu0YwW7MspyOHp+d0xB0HAL9AVNs/LTRbfbgVhsmxjiMTRnE3xBGwe
	tYasUQq8i6oQHl+FS9q0U67LZFl03pxNDM8oIndQzFSTvmI5SJWADKQsZXhsCAC2
X-Gm-Gg: ASbGncvm6vWryDumxLVw+VryN6CXzxIiLWVBoAUbBSm/2luMyuzhMLFxGZWuOQNKdO2
	cORk0h1slFZ2jm5/f10VEwkPXsEPO3ZJl3hNx/uODshrqmVZsB1hkLqoxKfCYrsOy1dZBvk+/tg
	A4BiLkpPDvUunWXnKMi1G+tHsILiPhjNp/915ShPTRBHfAKoG6hR3yU3Y9GJXNXJmaflfTa2cR/
	UsfYnlN0kDOKoZiBaLTyaQFnao8djZVdRlekg/qLH/li2BJnLnV30gRlF+q1KkFHVWdtVTVRh+i
	xyXTkPVzk6neDAKOPaPTGArW0r5G+T7iW4+WYTjqnKei21fU15CjJ3h8I3tBjuTQswtuSlH4E5K
	D29UIM78a6wkp28DA3PWLo+rMKMqPu+ACFO3io1z86yqEcgd+NMpxRS4MgUFfExML
X-Google-Smtp-Source: AGHT+IEvlHy1VAnLpXjPzPms/tc4k0TClLsm2GIwqPJ9nknH3Lt7t4qkL0zXPb4YAulyZyEc/d9qLQ==
X-Received: by 2002:a05:6102:d8d:b0:555:56e0:f372 with SMTP id ada2fe7eead31-5560908d470mr5354776137.2.1758016804967;
        Tue, 16 Sep 2025 03:00:04 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8ccd6e91934sm2783919241.22.2025.09.16.03.00.04
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 03:00:04 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-545df2bb95dso1845176e0c.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 03:00:04 -0700 (PDT)
X-Received: by 2002:a05:6102:f07:b0:523:fa25:9dcb with SMTP id
 ada2fe7eead31-5560a10e90dmr5050960137.8.1758016804397; Tue, 16 Sep 2025
 03:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915235910.47768-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250915235910.47768-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Sep 2025 11:59:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXAK6EhxPoNoqwqWSjGtwM24gL4qjSf6_n+NMCcpDf1HA@mail.gmail.com>
X-Gm-Features: AS18NWDE7JG051ZHXHbI83ikXIOcOB4W1HukpjosLXjuv559Vtogo--bVIVdY9s
Message-ID: <CAMuHMdXAK6EhxPoNoqwqWSjGtwM24gL4qjSf6_n+NMCcpDf1HA@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY initialization
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Tue, 16 Sept 2025 at 01:59, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 4581
> Figure 104.3b Initial Setting of PCIEC(example), third quarter of the figure
> indicates that register 0xf8 should be polled until bit 18 becomes set to 1.
>
> Register 0xf8 bit 18 is 0 immediately after write to PCIERSTCTRL1 and is set
> to 1 in less than 1 ms afterward. The current readl_poll_timeout() break
> condition is inverted and returns when register 0xf8 bit 18 is set to 0,
> which in most cases means immediately. In case CONFIG_DEBUG_LOCK_ALLOC=y ,
> the timing changes just enough for the first readl_poll_timeout() poll to
> already read register 0xf8 bit 18 as 1 and afterward never read register
> 0xf8 bit 18 as 0, which leads to timeout and failure to start the PCIe
> controller.
>
> Fix this by inverting the poll condition to match the reference manual
> initialization sequence.
>
> Fixes: faf5a975ee3b ("PCI: rcar-gen4: Add support for R-Car V4H")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -711,7 +711,7 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
>         val &= ~APP_HOLD_PHY_RST;
>         writel(val, rcar->base + PCIERSTCTRL1);
>
> -       ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, !(val & BIT(18)), 100, 10000);
> +       ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, val & BIT(18), 100, 10000);
>         if (ret < 0)
>                 return ret;
>

This change looks correct, and fixes the timeout seen on White Hawk
with CONFIG_DEBUG_LOCK_ALLOC=y.
However, it causes a crash when CONFIG_DEBUG_LOCK_ALLOC=n:

    SError Interrupt on CPU0, code 0x00000000be000011 -- SError
    CPU: 0 UID: 0 PID: 14 Comm: kworker/u16:1 Tainted: G   M
     6.17.0-rc5-rcar3-06070-gdadc15c5e4ba #523 NONE
    Tainted: [M]=MACHINE_CHECK
    Hardware name: Renesas White Hawk CPU and Breakout boards based on
r8a779g0 (DT)
    Workqueue: async async_run_entry_fn
    pstate: 60000009 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : dw_pcie_read+0x20/0x74
    lr : dw_pcie_read_dbi+0x74/0x9c
    sp : ffffffc086123ae0
    x29: ffffffc086123af0 x28: ffffff84403454e0 x27: ffffff8440343405
    x26: 61c8864680b583eb x25: ffffff8441769010 x24: ffffff86bedb7f80
    x23: ffffff8441769010 x22: ffffff8442b890d8 x21: ffffff8442b89650
    x20: 0000000000000000 x19: ffffff8442b89080 x18: 00000000e3b92ec8
    x17: ffffffc08002bcc8 x16: ffffffc08021d3c8 x15: ffffffc0801f10b8
    x14: ffffffc0861238d0 x13: 1ffffff0883aa021 x12: ffffffc080b46d14
    x11: 0000000000000000 x10: ffffffffffffffff x9 : 0000000000000001
    x8 : ffffffc0861239f0 x7 : 0000000000000000 x6 : ffffffc086616000
    x5 : 0000000000000714 x4 : ffffff8442b89080 x3 : 0000000000000003
    x2 : ffffffc086123ae4 x1 : 0000000000000000 x0 : ffffffc086616714
    Kernel panic - not syncing: Asynchronous SError Interrupt
    CPU: 0 UID: 0 PID: 14 Comm: kworker/u16:1 Tainted: G   M
     6.17.0-rc5-rcar3-06070-gdadc15c5e4ba #523 NONE
    Tainted: [M]=MACHINE_CHECK
    Hardware name: Renesas White Hawk CPU and Breakout boards based on
r8a779g0 (DT)
    Workqueue: async async_run_entry_fn
    Call trace:
     show_stack+0x14/0x1c (C)
     dump_stack_lvl+0x64/0x8c
     dump_stack+0x14/0x1c
     vpanic+0x10c/0x2f0
     nmi_panic+0x0/0x64
     nmi_panic+0x50/0x64
     arm64_serror_panic+0x68/0x74
     do_serror+0x2c/0x48
     el1h_64_error_handler+0x2c/0x40
     el1h_64_error+0x70/0x74
     dw_pcie_read+0x20/0x74 (P)
     rcar_gen4_pcie_additional_common_init+0x1c/0x6c
     rcar_gen4_pcie_host_init+0xbc/0x17c
     dw_pcie_host_init+0x258/0x428
     rcar_gen4_pcie_probe+0x198/0x1b4
     platform_probe+0x58/0x88
     really_probe+0x130/0x260
     __driver_probe_device+0xec/0x104
     driver_probe_device+0x3c/0xc0
     __device_attach_driver+0x58/0xcc
     bus_for_each_drv+0xb8/0xe0
     __device_attach_async_helper+0x70/0xc4
     async_run_entry_fn+0x34/0xe0
     process_scheduled_works+0x204/0x308
     worker_thread+0x144/0x1e0
     kthread+0x198/0x1a8
     ret_from_fork+0x10/0x20
    Kernel Offset: disabled
    CPU features: 0x000000,00007000,24003041,0400700b
    Memory Limit: none
    ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

