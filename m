Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C320E268851
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgINJ3x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 05:29:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34731 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgINJ3g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 05:29:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id h17so14298748otr.1;
        Mon, 14 Sep 2020 02:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UiAbjHRw4cjP5/wpXgqRGjEA9eM07puQn1B7rhyihDc=;
        b=YK6J4TXuM5kUtw0mLGPtr9jYP2zfw27kIZaTM+bYGFaoymaim5c6iaKb8eMSMxfruv
         psM86DRtNRsRHY/yl/hqOrVAaq2+a8gnWpgR1QDStX2K2X5Ckcq7RZ+FR6mFqFsw3Jkp
         oPG9KF4L/EBwS6uhjo5W+h2mmgvHgFgM5r57LTd+qx9l6jdK0PRoy1ns+hn4zdU+qZzx
         8bpPi0HfNaoZVvbkUWjkrbpdYK8HGgOgLPCSgoTyMJ4y++eBKM+NTi7KZq5NDgQfQYo4
         xydtg8WNgRQgiI3xt3jLSl4Nnzbaxlp52fjaTLrkgeZGEnb6UpfGIoz+x01sk0a+D4J8
         jWMg==
X-Gm-Message-State: AOAM532HAAZEvYWT0dFmTm7MXolp2oDi8i7Roxj6YQU761obwj1WO/rF
        KFohQJh0GBCUkjo3ZYcloPFin8/r42HcVVXUJ88=
X-Google-Smtp-Source: ABdhPJz8WG0pcyiybvAbF80sy+vaInoGMbgKzefy5dtriM8elTITMERLP7wOCq7w0ArXKsY1nsn8C5slAkQn7crczqY=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr8904286otb.250.1600075774545;
 Mon, 14 Sep 2020 02:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200912211853.15321-1-marek.vasut@gmail.com>
In-Reply-To: <20200912211853.15321-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Sep 2020 11:29:23 +0200
Message-ID: <CAMuHMdUBOOwpNLWLKX2obnezrZmOi2Uk+drvzo4KRU2H1xfJDQ@mail.gmail.com>
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

Hi Marek,

On Sat, Sep 12, 2020 at 11:19 PM <marek.vasut@gmail.com> wrote:
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
> If a PCIe access happens inside of this window, where the controller
> is inbetween L0 and L1 link states, the access generates a fault and
> the ARM 'imprecise external abort' handler is invoked.
>
> Just like other PCI controller drivers, here we hook the fault handler,
> perform the fixup to help the controller enter L1 link state, and then
> restart the instruction which triggered the fault. Since the controller
> is in L1 link state now, the link can exit from L1 link state to L0 and
> successfully complete the access.
>
> Note that this fixup is applicable only to Aarch32 R-Car controllers,
> the Aarch64 R-Car perform the same fixup in TFA, see TFA commit
> 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for your patch!

Unfortunately it doesn't seem to make any difference for me:

    root@koelsch:~# lspci -v -s 2:01:00
    0002:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit
Network Connection
            Subsystem: Intel Corporation Gigabit CT Desktop Adapter
            Flags: bus master, fast devsel, latency 0, IRQ 132
            Memory at fe280000 (32-bit, non-prefetchable) [size=128K]
            Memory at fe200000 (32-bit, non-prefetchable) [size=512K]
            I/O ports at 1000 [disabled] [size=32]
            Memory at fe2a0000 (32-bit, non-prefetchable) [size=16K]
            [virtual] Expansion ROM at 38000000 [disabled] [size=256K]
            Capabilities: [c8] Power Management version 2
            Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
            Capabilities: [e0] Express Endpoint, MSI 00
            Capabilities: [a0] MSI-X: Enable- Count=5 Masked-
            Capabilities: [100] Advanced Error Reporting
            Capabilities: [140] Device Serial Number 68-05-ca-ff-ff-c1-27-84
            Kernel driver in use: e1000e
    lspci: Unable to load libkmod resources: error -12

    root@koelsch:~# echo 0 > /sys/module/printk/parameters/console_suspend
    root@koelsch:~# echo mem > /sys/power/state
    [...]
    8<--- cut here ---
    Unhandled fault: asynchronous external abort (0x1211) at 0x00000000
    pgd = 86cd1077
    [00000000] *pgd=80000040004003, *pmd=00000000
    Internal error: : 1211 [#1] SMP ARM
    Modules linked in:
    CPU: 1 PID: 331 Comm: kworker/u4:8 Not tainted
5.9.0-rc3-koelsch-03091-g0e466faeee7f31de-dirty #900
    Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
    Workqueue: events_unbound async_run_entry_fn
    PC is at rcar_pcie_config_access+0x10c/0x13c
    LR is at rcar_pcie_config_access+0x10c/0x13c
    pc : [<c04b2cf8>]    lr : [<c04b2cf8>]    psr: 60010093
    sp : e6193e00  ip : 00000000  fp : 00000000
    r10: 00000000  r9 : 00000000  r8 : e73e9c00
    r7 : 00000000  r6 : e6193e40  r5 : e73d6240  r4 : 000000cc
    r3 : f0900000  r2 : f0900018  r1 : f0900020  r0 : 00000000
    Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
    Control: 30c5387d  Table: 64627940  DAC: 55555555
    Process kworker/u4:8 (pid: 331, stack limit = 0x3b59bbec)
    Stack: (0xe6193e00 to 0xe6194000)
    3e00: 000000cc e6193e40 00000002 40010013 e6193e6a c04b2dfc
00000000 c04b2e24
    3e20: 000000cc e6193e40 e73e9c00 000000cc c0e04e88 c0498688
e6193e40 00000000
    3e40: 00000000 b6911cec e73eb000 00000003 00000000 c0e04e88
e73eb070 c0e3a4f8
    3e60: 00000000 c049e1d8 2103b000 b6911cec 00000003 e73eb000
00000001 e73eb000
    3e80: e73eb070 c04a0fc8 e73eb000 00000003 00000001 e73eb000
e73eb070 c04a1048
    3ea0: e73eb070 00000000 c0849cb8 c04a4e2c e73eb070 e73eb070
00000000 c0e3a4f8
    3ec0: 00000000 00000000 c04a4c04 c0e8d8a0 e73eb070 c0518130
c04a4c04 e73eb070
    3ee0: b6911cec e73eb070 00000002 00000000 c0e8d8a0 00000000
e6353194 c051970c
    3f00: e73eb070 c0e8d8a0 c0e38018 e7008900 00000000 c05199dc
e6353190 e6353180
    3f20: c0e38018 c023d4b4 e447e300 e7007400 e6353190 e7008900
00000000 c0235410
    3f40: e447e300 e6353190 e447e300 e447e314 e7007400 e6192000
e7007418 c0e03d00
    3f60: c0e38e64 c0235de8 00000000 e451c2c0 e4562b40 e6192000
c0235bc0 e447e300
    3f80: e66f7ebc e451c2e4 00000000 c023a504 e4562b40 c023a404
00000000 00000000
    3fa0: 00000000 00000000 00000000 c0200138 00000000 00000000
00000000 00000000
    3fc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
    3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
00000000 00000000
    [<c04b2cf8>] (rcar_pcie_config_access) from [<c04b2e24>]
(rcar_pcie_read_conf+0x28/0x80)
    [<c04b2e24>] (rcar_pcie_read_conf) from [<c0498688>]
(pci_bus_read_config_word+0x68/0xa8)
    [<c0498688>] (pci_bus_read_config_word) from [<c049e1d8>]
(pci_raw_set_power_state+0x18c/0x270)
    [<c049e1d8>] (pci_raw_set_power_state) from [<c04a0fc8>]
(pci_set_power_state+0x98/0xcc)
    [<c04a0fc8>] (pci_set_power_state) from [<c04a1048>]
(pci_prepare_to_sleep+0x4c/0x6c)
    [<c04a1048>] (pci_prepare_to_sleep) from [<c04a4e2c>]
(pci_pm_suspend_noirq+0x228/0x244)
    [<c04a4e2c>] (pci_pm_suspend_noirq) from [<c0518130>]
(dpm_run_callback.part.5+0x44/0xac)
    [<c0518130>] (dpm_run_callback.part.5) from [<c051970c>]
(__device_suspend_noirq+0x74/0x1a4)
    [<c051970c>] (__device_suspend_noirq) from [<c05199dc>]
(async_suspend_noirq+0x18/0x58)
    [<c05199dc>] (async_suspend_noirq) from [<c023d4b4>]
(async_run_entry_fn+0x44/0x10c)
    [<c023d4b4>] (async_run_entry_fn) from [<c0235410>]
(process_one_work+0x17c/0x220)
    [<c0235410>] (process_one_work) from [<c0235de8>]
(worker_thread+0x228/0x2d4)
    [<c0235de8>] (worker_thread) from [<c023a504>] (kthread+0x100/0x10c)
    [<c023a504>] (kthread) from [<c0200138>] (ret_from_fork+0x14/0x3c)
    Exception stack(0xe6193fb0 to 0xe6193ff8)
    3fa0:                                     00000000 00000000
00000000 00000000
    3fc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
    3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
    Code: 1a000007 e3a01020 e1a00005 ebfffc72 (e5860000)
    ---[ end trace 82864b10c34f54a4 ]---

I added a debug print to the abort handler, and it's not called?

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -1050,4 +1065,47 @@ static struct platform_driver rcar_pcie_driver = {
>         },
>         .probe = rcar_pcie_probe,
>  };
> +
> +#ifdef CONFIG_ARM
> +static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
> +               unsigned int fsr, struct pt_regs *regs)
> +{
> +       u32 pmsr;
> +
> +       pmsr = readl(pcie_base + PMSR);

If the abort is triggered for some other reason, pcie_base may still be
NULL, or the PCIe controller may be suspended, and accessing its
registers may cause another asynchronous abort.
To avoid the latter, you should check if the PCIe module clock is
enabled first, like you did in your ATF commit.

> +
> +       /*
> +        * Test if the PCIe controller received PM_ENTER_L1 DLLP and
> +        * the PCIe controller is not in L1 link state. If true, apply
> +        * fix, which will put the controller into L1 link state, from
> +        * which it can return to L0s/L0 on its own.
> +        */
> +       if ((pmsr & PMEL1RX) && ((pmsr & PMSTATE) != PMSTATE_L1)) {
> +               writel(L1IATN, pcie_base + PMCTLR);
> +               while (!(readl(pcie_base + PMSR) & L1FAEG))
> +                       ;

Do you know how many cycles this takes, typically?

> +               writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
> +               return 0;
> +       }
> +
> +       return 1;
> +}
> +
> +static int __init rcar_pcie_init(void)
> +{
> +       /*
> +        * Since probe() can be deferred we need to make sure that
> +        * hook_fault_code is not called after __init memory is freed
> +        * by kernel and since rcar_pcie_abort_handler() is a no-op,
> +        * we can install the handler here without risking it
> +        * accessing some uninitialized driver state.

It's not a no-op: it accesses PMSR, regardless of whether the device is
(a) present, (b) probed and/or (c) resumed, or not.

Note that there can be only one such handler, so this might interfere/be
interfered by with other drivers in multi-platform kernels doing similar
unhealthy things.

> +        */
> +       hook_fault_code(16 + 6, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,

After changing the "16 + 6" to "17", like pci-keystone.c does, it works!

It prints the following message during suspend, though:

    e1000e 0002:01:00.0: refused to change power state from D0 to D3hot

Network traffic works after system resume.

> +                       "imprecise external abort");
> +
> +       return platform_driver_register(&rcar_pcie_driver);
> +}
> +device_initcall(rcar_pcie_init);
> +#else
>  builtin_platform_driver(rcar_pcie_driver);
> +#endif
> diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
> index d4c698b5f821..73269296ae05 100644
> --- a/drivers/pci/controller/pcie-rcar.h
> +++ b/drivers/pci/controller/pcie-rcar.h
> @@ -85,6 +85,13 @@
>  #define  LTSMDIS               BIT(31)
>  #define  MACCTLR_INIT_VAL      (LTSMDIS | MACCTLR_NFTS_MASK)
>  #define PMSR                   0x01105c
> +#define  L1FAEG                        BIT(31)
> +#define  PMEL1RX               BIT(23)
> +#define  PMSTATE               GENMASK(18, 16)
> +#define  PMSTATE_L1            GENMASK(17, 16)

While the GENMASK() trick would work for L1, as its value is 0b011, it
won't work for all possible values.
What about "FIELD_PREP(PMSTATE, 3)", or just "(3 << 16)?

> +#define PMCTLR                 0x011060
> +#define  L1IATN                        BIT(31)
> +
>  #define MACS2R                 0x011078
>  #define MACCGSPSETR            0x011084
>  #define  SPCNGRSN              BIT(31)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
