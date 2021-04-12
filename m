Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140E635C630
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 14:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbhDLM1B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 08:27:01 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:34596 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240913AbhDLM07 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Apr 2021 08:26:59 -0400
Received: by mail-vs1-f46.google.com with SMTP id h20so6541434vsu.1;
        Mon, 12 Apr 2021 05:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfXpOHN1nC0M88ZM/W8jBlWqk14043GyOoIo/T+w7WQ=;
        b=MVxWwJGNF5g5W4Qo0mqsXzgWb+hiaEL1iNTfLiZHEnvVsCueGTT/3s9Xb9zXhVrP9Z
         KYOrjibtfgbTL1SMACiRtFQ3+Yj/hrHGXx++3XTxQwFD71plLvmlQD7VEKnhi0wHPrPc
         UWDQUmaLlMetUZ26tK4fObOYleeR9eruqEdmGabpiy9VX/Sn1UJCNB/vcaScJwtZnp/2
         xARyeyWPXQ7zOlxg21IKmswSfRL9jyP8K4Fyctp0G2XlfsPcUnMwqquLgbVQnZT6QJse
         PVr/GplZu1LNq67PaAK0nVNVtEcIYSOaspnVfCX57gGfSY0cnNwRwgpjKYXKvNrMNw9X
         pn1Q==
X-Gm-Message-State: AOAM532mvP/VkDZ+w0dDXivg94PU8F7naya8hfZ7kq6ASjh3YrO9JaP/
        s3M+WgBO6b5foVCmt3Z8hTWbovQ99svPRVYpZns=
X-Google-Smtp-Source: ABdhPJzZDP1u8g+AzCQjZKX7IXjS4HfBHXSz+bFEGx6fJfhtpstjMRIHPLJWdxxBuHrGC0e5nOX0204lLlpgbPEq5es=
X-Received: by 2002:a67:7d02:: with SMTP id y2mr19915858vsc.18.1618230400971;
 Mon, 12 Apr 2021 05:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210411185030.8818-1-marek.vasut@gmail.com>
In-Reply-To: <20210411185030.8818-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Apr 2021 14:26:29 +0200
Message-ID: <CAMuHMdWFoOrh9jNKY-NL4_dnC_eGkK5AndLoOf0g5Sg4AEctZg@mail.gmail.com>
Subject: Re: [PATCH V5] PCI: rcar: Add L1 link state fix into data abort hook
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

Hi Marek,

On Sun, Apr 11, 2021 at 8:50 PM <marek.vasut@gmail.com> wrote:
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
> While it was suggested to disable L1 link state support completely on
> the controller level, this would not prevent the L1 link state entry
> initiated by the link partner. This happens e.g. in case a PCIe card
> enters D3Hot state, which could be initiated from pci_set_power_state()
> if the card indicates D3Hot support, which in turn means link must enter
> L1 state. So instead, fix up the L1 link state after all.
>
> Note that this fixup is applicable only to Aarch32 R-Car controllers,
> the Aarch64 R-Car perform the same fixup in TFA, see TFA commit [1]
> 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
> [1] https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>


> V5: - Add mutex around rcar_pcie_aarch32_abort_handler()

spinlock (used as a mutex ;-)

>     - Update commit message again to point out issues with L1/D3Hot states

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
