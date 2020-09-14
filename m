Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E802268906
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 12:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgINKMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 06:12:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36120 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgINKMH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 06:12:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id x19so17283618oix.3;
        Mon, 14 Sep 2020 03:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6qIWsZAMXFA6R8dZa5JALODs0DnWG4bbFhErRCdLhSg=;
        b=l2ZOLaGoSK6Tu1kJ+idGpISssMS2jcn6Ylw5NiuihAfX9S6AJd0pVqbp6mC7X5jz3l
         yl07AfnjkpiHZU0dAVbH9dxcZVfRHtQ/T94dIGO+KFzDWzPCISJv9BMuvYHo6YQ8kRm8
         onMEMqhjwkqFOHpfVv24kEBxp63CkQ8ybKt0oTRw/YPzwHDxzrMmque0jOyU94QqDWni
         nnSbmYFmEnSBaXK/tXeUHgbRt3Ts3pQZmEdovFlThCdtpgWHasUSVMoQ/NQzbieNkWNA
         APtAaQdKq9UmxP22R49K94AwI+yx2dAhdaDgM6VXcAVQeD4u8WmYP8Pn0KymNTts4FO5
         7fAQ==
X-Gm-Message-State: AOAM530gbAr6VkCkBqvA5mvH0U6SnicsY3f5vvzs0BmfVjRteU9zaOoG
        L02a2caPFqZQA5vcQjZZ5X6wHL37LLnah39eOlq7tQocqGY=
X-Google-Smtp-Source: ABdhPJxpdeo+d4eoib4KcvySImvbes64puBnWU6IkFUlWPxGH+QeU32RMnl8DC4QNxBS/oi9zLUCaBu/DrnvhU1DdLM=
X-Received: by 2002:aca:3bc3:: with SMTP id i186mr7403356oia.148.1600078326032;
 Mon, 14 Sep 2020 03:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200912211853.15321-1-marek.vasut@gmail.com> <CAMuHMdUBOOwpNLWLKX2obnezrZmOi2Uk+drvzo4KRU2H1xfJDQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUBOOwpNLWLKX2obnezrZmOi2Uk+drvzo4KRU2H1xfJDQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Sep 2020 12:11:54 +0200
Message-ID: <CAMuHMdWW6sX+4Hn8wdkCj0kixRZcDKiZR987iEcXrs+U+-4yUA@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Add L1 link state fix into data abort hook
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 14, 2020 at 11:29 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sat, Sep 12, 2020 at 11:19 PM <marek.vasut@gmail.com> wrote:
> > From: Marek Vasut <marek.vasut+renesas@gmail.com>
> >
> > The R-Car PCIe controller is capable of handling L0s/L1 link states.
> > While the controller can enter and exit L0s link state, and exit L1
> > link state, without any additional action from the driver, to enter
> > L1 link state, the driver must complete the link state transition by
> > issuing additional commands to the controller.
> >
> > The problem is, this transition is not atomic. The controller sets
> > PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
> > the PCIe card, but then the controller enters some sort of inbetween
> > state. The driver must detect this condition and complete the link
> > state transition, by setting L1IATN bit in PMCTLR and waiting for
> > the link state transition to complete.
> >
> > If a PCIe access happens inside of this window, where the controller
> > is inbetween L0 and L1 link states, the access generates a fault and
> > the ARM 'imprecise external abort' handler is invoked.
> >
> > Just like other PCI controller drivers, here we hook the fault handler,
> > perform the fixup to help the controller enter L1 link state, and then
> > restart the instruction which triggered the fault. Since the controller
> > is in L1 link state now, the link can exit from L1 link state to L0 and
> > successfully complete the access.
> >
> > Note that this fixup is applicable only to Aarch32 R-Car controllers,
> > the Aarch64 R-Car perform the same fixup in TFA, see TFA commit
> > 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

>
> > +        */
> > +       hook_fault_code(16 + 6, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
>
> After changing the "16 + 6" to "17", like pci-keystone.c does, it works!

Oh, this depends on LPAE.  So it must be 17 if CONFIG_ARM_LPAE=y,
22 otherwise.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
