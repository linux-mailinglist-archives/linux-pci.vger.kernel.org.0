Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D8F3D5C12
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jul 2021 16:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhGZOHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jul 2021 10:07:39 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:36549 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbhGZOHi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jul 2021 10:07:38 -0400
Received: by mail-ua1-f50.google.com with SMTP id v3so3632443uau.3;
        Mon, 26 Jul 2021 07:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4QRKkHEY8BvzwrfevnhRLT5PisPeEaV12SXPsm6bBQ=;
        b=KooPMLeZ51egTGgY7kXUVwLpNO6PdJHjC/IAqPI6AzSm4Um0NOXj4BDG9x3Z3goGbi
         yCBC46+BBrxCQGW/qcabP8qxH1ZlRVhOcgL/mO66nYx/koHh8Qwp+FO18X/kgUsyjzTK
         IP8cwZliid4XRSL8V6byOMp5WwXCMfNFMuVN0IGU9aRzBryBIMBxxeKVWT3eGr5g+D4R
         K4e2w0S30apN+iKN9Coyy7mQ59z6z4gEv35BHo0esahOcPkf7vdIPY5siYy04AV+VCkp
         aJ0j1IZSkhHgbaiV/7apddtaUQenUFBOaunpTzawWPmTzPs62PQa2x/C1B/fpnYPNEl5
         8nDA==
X-Gm-Message-State: AOAM531UfgIfs5680rP1uZ9x6U2aJ6VfBpKmW14BcsC87lFxdJ4srzy4
        XrGeJtZmtI+LBtLwtV7fgSdR82ZMvx0OrMuYdLc=
X-Google-Smtp-Source: ABdhPJxeBtgxjhETzykm7PslqlhGZkKcWUvLnYm3nWx8h2Aog/VAVvKVYFlG5jFOiFnQUNomJNLwLRkB4iwCMrgGJqA=
X-Received: by 2002:ab0:6710:: with SMTP id q16mr13034300uam.106.1627310886053;
 Mon, 26 Jul 2021 07:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210514200549.431275-1-marek.vasut@gmail.com> <20210717173334.GA2232818@bjorn-Precision-5520>
In-Reply-To: <20210717173334.GA2232818@bjorn-Precision-5520>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Jul 2021 16:47:54 +0200
Message-ID: <CAMuHMdWFeTP81pfsX0YG=qouGH8+d-0GDCw68MmamhSHjQdM_A@mail.gmail.com>
Subject: Re: [PATCH V6] PCI: rcar: Add L1 link state fix into data abort hook
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
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

Hi Bjorn,

On Sat, Jul 17, 2021 at 7:33 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, May 14, 2021 at 10:05:49PM +0200, marek.vasut@gmail.com wrote:
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
> > If a PCIe access happens inside this window, where the controller
> > is between L0 and L1 link states, the access generates a fault and
> > the ARM 'imprecise external abort' handler is invoked.
> >
> > Just like other PCI controller drivers, here we hook the fault handler,
> > perform the fixup to help the controller enter L1 link state, and then
> > restart the instruction which triggered the fault. Since the controller
> > is in L1 link state now, the link can exit from L1 link state to L0 and
> > successfully complete the access.
> >
> > While it was suggested to disable L1 link state support completely on
> > the controller level, this would not prevent the L1 link state entry
> > initiated by the link partner. This happens e.g. in case a PCIe card
> > enters D3Hot state, which could be initiated from pci_set_power_state()
> > if the card indicates D3Hot support, which in turn means link must enter
> > L1 state. So instead, fix up the L1 link state after all.
> >
> > Note that this fixup is applicable only to Aarch32 R-Car controllers,
> > the Aarch64 R-Car perform the same fixup in TFA, see TFA commit [1]
> > 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
> > [1] https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
>
> This patch is horribly ugly but it's working around a horrible
> hardware problem, and I don't have any better suggestions, so I guess
> we don't really have much choice.
>
> I do think the commit log is a bit glib:
>
>   - "The R-Car PCIe controller is capable of handling L0s/L1 link
>     states."  AFAICT every PCIe device is required to handle L0 and L1
>     without software assistance.  So saying R-Car is "capable" puts a
>     better face on this than seems warranted.
>
>     L0s doesn't seem relevant at all; at least it doesn't seem to play
>     a role in the patch.  There's no such thing as "returning to L0s"
>     as mentioned in the comment below; L0s is only reachable from L0.
>     Returns from L1 only go to L0 (PCIe r5.0, fig 5-1).
>
>   - "The problem is, this transition is not atomic."  I think the
>     *problem* is the hardware is broken in the first place.  This
>     transition is supposed to be invisible to software.
>
>   - "Just like other PCI controller drivers ..." suggests that this is
>     an ordinary situation that we shouldn't be concerned about.  This
>     patch may be the best we can do to work around a bad hardware
>     defect, but it's definitely not ordinary.
>
>     I think the other hook_fault_code() uses are for reporting
>     legitimate PCIe errors, which most controllers log and turn
>     into ~0 data responses without generating an abort or machine
>     check, not things caused by hardware defects, so they're not
>     really comparable.
>
> Has Renesas documented this as an erratum?  Will future devices
> require additions to rcar_pcie_abort_handler_of_match[]?
>
> It'd be nice if the commit log mentioned the user-visible effect of
> this problem.  I guess it does mention external aborts -- I assume you
> see those when downstream devices go to D3hot or when ASPM puts the
> link in L1?  And the abort results in a reboot?
>
> To be clear, I'm not objecting to the patch.  It's a hardware problem
> and we should work around it as best we can.

Cool! So what's missing for this patch, which we have been polishing
for almost one year, to be applied, so innocent people can no longer
lock up an R-Car system just by inserting an ubiquitous Intel Ethernet
card, and suspending the system?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
