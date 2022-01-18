Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F3849213C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 09:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiARIbK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 03:31:10 -0500
Received: from mail-vk1-f178.google.com ([209.85.221.178]:33717 "EHLO
        mail-vk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiARIbJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 03:31:09 -0500
Received: by mail-vk1-f178.google.com with SMTP id g5so12013726vkg.0;
        Tue, 18 Jan 2022 00:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3bW86Tr5XN3ZOrA53EILVLd81w2LJ0wB/ZgFi8ZETs=;
        b=FdYEkfCpiBpdg6O0dFN247vS+2fAai41yNzpZk1IDVtWLcICbsVEGGrNVRJoKOjIF2
         Gm/Wkmr8gIWSATxE/Qaz5zrsNcNrXp3xnTT+lNCFvxkJGNLzBo+ZxwndnLJCHWhP0OcV
         Fcql0CSC5z1gC8VxKQ7k0tGenL0Bv07uJVZwxDJFkRCbzrudCJdKD2QigkkjSE8k4yO2
         G00RLj21Yr/wgkaXdIoCopCfS/Xlnj7cgP8gtLkNyQg/EO7hCSNF9ylTclj2JnpzoB9L
         kV4U7BT4f8w5TioYnUpb+ym7v4tCwlHy0Ik/3oARofFtI86n10mya0I83RQ799Torcw+
         y0LQ==
X-Gm-Message-State: AOAM532Quoea6xXTryTU55GZc7d+GD7IlrDnsCARrhcpKlpVRWGxIC9Y
        WHWDY72Wpwq1B8o/M+Gj8VKbdjP8oWzVuA==
X-Google-Smtp-Source: ABdhPJyp8/C0hn+Wm7Ag7Ras/nAuZzhEn39na5nMWGjalEehXGMm+O57ro9YH4HRibxsunW1J3I4lQ==
X-Received: by 2002:a05:6122:200d:: with SMTP id l13mr9703359vkd.16.1642494668284;
        Tue, 18 Jan 2022 00:31:08 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id s69sm3609309vka.55.2022.01.18.00.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 00:31:08 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id m90so35181699uam.2;
        Tue, 18 Jan 2022 00:31:07 -0800 (PST)
X-Received: by 2002:ab0:4d5a:: with SMTP id k26mr9174493uag.122.1642494667707;
 Tue, 18 Jan 2022 00:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20220117220355.92575-1-marek.vasut@gmail.com>
In-Reply-To: <20220117220355.92575-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Jan 2022 09:30:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUCHWd1w8CwtbO34TXYDoXVi6aQdFQgoeosCX7viVZXoQ@mail.gmail.com>
Message-ID: <CAMuHMdUCHWd1w8CwtbO34TXYDoXVi6aQdFQgoeosCX7viVZXoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

On Mon, Jan 17, 2022 at 11:04 PM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> In case the controller is transitioning to L1 in rcar_pcie_config_access(),
> any read/write access to PCIECDR triggers asynchronous external abort. This
> is because the transition to L1 link state must be manually finished by the
> driver. The PCIe IP can transition back from L1 state to L0 on its own.
>
> Avoid triggering the abort in rcar_pcie_config_access() by checking whether
> the controller is in the transition state, and if so, finish the transition
> right away. This prevents a lot of unnecessary exceptions, although not all
> of them.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for your patch!

I believe all my comments on v1[1] are still valid.

[1] https://lore.kernel.org/r/CAMuHMdXUteqOinkCNH8L-dC=W82DChQSupAXv_Uhjq5M=T5uxQ@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
