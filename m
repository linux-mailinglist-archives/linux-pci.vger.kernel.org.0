Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18643291224
	for <lists+linux-pci@lfdr.de>; Sat, 17 Oct 2020 16:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438209AbgJQODS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Oct 2020 10:03:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44895 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438207AbgJQODS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Oct 2020 10:03:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id e20so5330321otj.11;
        Sat, 17 Oct 2020 07:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0b/seI0e+TIVKTjq67vJOS1hG39AvC6HlXoE0qWwu7c=;
        b=BbVp3WTXErfIVv40Gb9GPfD65Db6axQ1gm/t7/23KdvZ8YEFb9y4/lNoXBEqCFaArL
         xx1KVrLxrYOj2z2BaNtJjgAhTY99DR8YlfcIJldNZmI3piCQGGLOX2fG7Wdhpq4Jn9nh
         GQ9p9CKjZQBG1s3EuUnD2sYX0CqJ9KicqzA0Xq4m0Vrs1y6pD8gYcCdxpBtNkWeC1jet
         HqTvulOi4echVFp8EqHj+Ph0DZR4Vbd1CZPmxTa28w0Q3n6vzWjttJne1QNDloA/XIL+
         GZ32i/qWOpI+7j6g1u3rp+4SgyQ2t/ELMF8yUSAqc2JCK0hURqCaih/ynmardpBW8rJW
         zgFg==
X-Gm-Message-State: AOAM53079Nwx99CoWdeVnGuDMbGWHdVWjTguHKawGMsnNWrLB4BSTafS
        5XRbml9I3i/Y2RWZUdyqTi1kTCcUiIw7+6+jiHE=
X-Google-Smtp-Source: ABdhPJzI8ptGp0z9jVeQrsLhxqPhvm+m6NNLmUXaM7rl2FAUkiWKzsDfgt0OINi0GxYXHzP0DJ3/NM5xOiSWlEDKLIw=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr5732667oti.107.1602943397450;
 Sat, 17 Oct 2020 07:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201016120416.7008-1-marek.vasut@gmail.com>
In-Reply-To: <20201016120416.7008-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 17 Oct 2020 16:03:05 +0200
Message-ID: <CAMuHMdUR1=+mX7RnrL2e4+kiR=pa9vPc3GVyUBOVsf+DFei2Aw@mail.gmail.com>
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 16, 2020 at 2:04 PM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> The R-Car PCIe controller is capable of handling L0s/L1 link states.
> While the controller can enter and exit L0s link state, and exit L1
> link state, without any additional action from the driver, to enter
> L1 link state, the driver must complete the link state transition by
> issuing additional commands to the controller.
>
> The problem is, this transition is not atomic. The controller sets
> PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
> the PCIe card, but then the controller enters some sort of inbetween
> state. The driver must detect this condition and complete the link
> state transition, by setting L1IATN bit in PMCTLR and waiting for
> the link state transition to complete.
>
> If a PCIe access happens inside this window, where the controller
> is between L0 and L1 link states, the access generates a fault and
> the ARM 'imprecise external abort' handler is invoked.
>
> Just like other PCI controller drivers, here we hook the fault handler,
> perform the fixup to help the controller enter L1 link state, and then
> restart the instruction which triggered the fault. Since the controller
> is in L1 link state now, the link can exit from L1 link state to L0 and
> successfully complete the access.
>
> Note that this fixup is applicable only to Aarch32 R-Car controllers,
> the Aarch64 R-Car perform the same fixup in TFA, see TFA commit [1]
> 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
> [1] https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: - Update commit message, add link to TFA repository commit
>     - Handle the LPAE case as in ARM fault.c and fsr-{2,3}level.c
>     - Cache clock and check whether they are enabled before register
>       access
> V3: - Fix commit message according to spellchecker
>     - Use of_find_matching_node() to apply hook only on Gen1 and Gen2 RCar
>       (in case the kernel is multiplatform)
> V4: - Mark rcar_pcie_abort_handler_of_match with __initconst

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Please add tags given to the previous version:
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
