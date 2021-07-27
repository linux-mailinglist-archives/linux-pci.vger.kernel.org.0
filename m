Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041303D7AC7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 18:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhG0QRO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 27 Jul 2021 12:17:14 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:36459 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhG0QQm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jul 2021 12:16:42 -0400
Received: by mail-vs1-f54.google.com with SMTP id o12so7446467vst.3;
        Tue, 27 Jul 2021 09:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C62vkBRXfKMHmJDrbvlLPPOVMw/4BA4JZ56KgoHRNys=;
        b=lGE2+BoL7+wO3pls151IJJEsL0zdwVy0tgU0AX7SHLnQwCZV5Tv6DfyT++77+1+8UH
         wb11jR3ibbWYgKBJtNUUW2XV9AL53rPFZnsO75lZKPpCG1/NNXkkr+6A0ZP3i6IcFnyf
         eHmirmbHShnjpPsjs50yBCP+loUddrmzywL0gWOEQoWjS7AiZszIHk7+cGpM5CCWZxaz
         8ItClFvkArxDpgmyn3ADZb/w05G1RIOHcekh6MSY2X6RtGpjh3sOcdxR8Z/geNIyHnQy
         QH67TSmhqKJJpmUsLIwSkl6buw4p8Yk7BTIkxVs2n49iIWKYAgW7XBE9hp2P2O504DJV
         WL7Q==
X-Gm-Message-State: AOAM532AB53CrkOSXEID5o7QLxuiYpVgjk86e6x2i3YY+3E9ExxyFkig
        A5pZ0lFTQmtFwwUf2ueQtohkHbKtXhKyZsQs26M=
X-Google-Smtp-Source: ABdhPJz8gW155+zW2Q9zCQCOcuhsEFepAhj2gFCuQdLgUtH5Tryp4o5aPtb1KtTGdtoKe44A9Ss42u03u7YGezy2Nfw=
X-Received: by 2002:a05:6102:2450:: with SMTP id g16mr2020867vss.3.1627402601183;
 Tue, 27 Jul 2021 09:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210514200549.431275-1-marek.vasut@gmail.com>
 <20210717173334.GA2232818@bjorn-Precision-5520> <20210719085953.GA17481@lpieralisi>
 <20210719172340.vvtnddbli2vgxndi@pali> <20210727161142.GA15814@lpieralisi>
In-Reply-To: <20210727161142.GA15814@lpieralisi>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Jul 2021 18:16:29 +0200
Message-ID: <CAMuHMdVxBCe2TKNkAHCNtmGFs5ozvx2gouxr4JErrdVZOi-8EQ@mail.gmail.com>
Subject: Re: [PATCH V6] PCI: rcar: Add L1 link state fix into data abort hook
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Tue, Jul 27, 2021 at 6:11 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Mon, Jul 19, 2021 at 07:23:40PM +0200, Pali Rohár wrote:
>
> [...]
>
> > > > > +#ifdef CONFIG_ARM
> > > > > +static DEFINE_SPINLOCK(pmsr_lock);
> > > > > +static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
> > > > > +               unsigned int fsr, struct pt_regs *regs)
> > > > > +{
> > > > > +       unsigned long flags;
> > > > > +       int ret = 0;
> > > > > +       u32 pmsr;
> > > > > +
> > > > > +       spin_lock_irqsave(&pmsr_lock, flags);
> > > > > +
> > > > > +       if (!pcie_base || !__clk_is_enabled(pcie_bus_clk)) {
> > > > > +               ret = 1;
> > > > > +               goto unlock_exit;
> > > > > +       }
> > > > > +
> > > > > +       pmsr = readl(pcie_base + PMSR);
> > > > > +
> > > > > +       /*
> > > > > +        * Test if the PCIe controller received PM_ENTER_L1 DLLP and
> > > > > +        * the PCIe controller is not in L1 link state. If true, apply
> > > > > +        * fix, which will put the controller into L1 link state, from
> > > > > +        * which it can return to L0s/L0 on its own.
> > > > > +        */
> > > > > +       if ((pmsr & PMEL1RX) && ((pmsr & PMSTATE) != PMSTATE_L1)) {
> > > > > +               writel(L1IATN, pcie_base + PMCTLR);
> > > > > +               while (!(readl(pcie_base + PMSR) & L1FAEG))
> > > > > +                       ;
> >
> > Infinite loop in abort handler is not a good idea. If this software
> > workaround is not able to fix HW in broken state then it is better to
> > let kernel finish abort handler and reboot machine (or whatever is
> > default action for particular abort handler).

The default action is to crash with an imprecise external abort.

> Probably worth adding a timeout, I can do it before merging it.

Indeed, better to lock up with a message than without ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
