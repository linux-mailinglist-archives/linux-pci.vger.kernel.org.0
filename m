Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA7A763300
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjGZKAN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 06:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjGZJ7v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 05:59:51 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4903412D
        for <linux-pci@vger.kernel.org>; Wed, 26 Jul 2023 02:59:43 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-486198c70adso1135841e0c.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Jul 2023 02:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690365582; x=1690970382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ggMmbTgfOxRgqR/7a08sk0qOVDEQkI5+XHkBaieC530=;
        b=uATWBBwu87+ofJu1k+q+vlEK8a4aiWyR2Xz0mv2857whZoXU/a8vGVEC0OcVC2dMoi
         cqVBwrdnfBWGL4funHSzsZvdkAdXrYFEaSvEMwQwr5m4c7KQNbS5XXqhuCx7SGsm7KWg
         hG9h47OFBOGfUcUnVgZwkl7ZkZXgetlaf5j6gBj80o8D9s2JYtfT2XtPAR+GWXkleEOa
         UWmNubI9nCGV9o8lzwZL+9GIU4sYGxdI4S8T1Eey12rsAhvtsgaFInWe9uJuxSLshwsh
         6v1uIX6lQ/lbbZOHGofpqTVZS8HWYol84zFl7iVbcFE1v9ly6Fz5NYCHyaz55hDtskP/
         yN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690365582; x=1690970382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggMmbTgfOxRgqR/7a08sk0qOVDEQkI5+XHkBaieC530=;
        b=Pznog/7dT6Rl8dLwv+xHzbvbYGj8gp7Rqf4c5LyyMTxI76Bqa9ExjyQyv4N4zTG/Yp
         NCDmeYGZBl7l42lBwm5DIGkMwOWzHjaM4Wz9yN+WVtDNzYAqGRAXM51G68hXGvtJvC5P
         fPj2QiPH9wsAFoKajRohyqT+Ld4V4vKzXyeDqyRlllcoXu+LEbgF0N+dRZU/yIpvhpx9
         iJ04BFTEFFZJdg6hXh+AFE5ZEgA3c8J98+RLroWpWURw64YyksBlKQcmYMWdBjvhMt2u
         /Dfp38zN8sWe40Ibb3g7Lo79z27EelnlGHkM/eszeufMnIH2+9wIa2FEBkvE/lta0X4H
         RfiQ==
X-Gm-Message-State: ABy/qLbhlb1KcmQw2+kpYqpdiwTcPC6NIEmlVUxYzzwaY19Bvqkw2+/E
        7iNgSyWrKisRhihz472cFOwKRebKgJeLBFU0KuDceQ==
X-Google-Smtp-Source: APBJJlGhCRaMo8KRs4HdEZ9utTDa3wOi7tZCcs5hQVcQ2r193d9n09NEEtLNzBE1KAz4dQWj4Ck2DWiPE/03PVyNcvk=
X-Received: by 2002:a67:be13:0:b0:447:4b52:5c8 with SMTP id
 x19-20020a67be13000000b004474b5205c8mr683637vsq.26.1690365582137; Wed, 26 Jul
 2023 02:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtAi8NQ_5LNku3oik6b0243xhGFt2WyxERNE+eNqLbNOw@mail.gmail.com>
 <76665dd9-1cbc-4b3a-b466-18a54cd74c1c@app.fastmail.com>
In-Reply-To: <76665dd9-1cbc-4b3a-b466-18a54cd74c1c@app.fastmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 26 Jul 2023 15:29:31 +0530
Message-ID: <CA+G9fYuEVLeJX485ZbPNnvbViYUecNsewGiMi+54mNVnL-XBGA@mail.gmail.com>
Subject: Re: x15: Unable to handle kernel NULL pointer dereference at virtual
 address 00000004 when read : pci_generic_config_read
To:     Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Benjamin Copeland <ben.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 20 Jun 2023 at 14:10, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jun 20, 2023, at 10:00, Naresh Kamboju wrote:
> > We have been noticing the following kernel crash on x15 device while running
> > LTP fs proc01 testing with Linux stable rc 6.x kernels.
>
> Do you know if this is a regression with this kernel version compared
> to older kernels running the same tests, or an added testcase in LTP
> that exercises a code path that may have been broken for longer?
>
> > Starting kernel ...
> >
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 6.3.9-rc1 (tuxmake@tuxmake)
> > (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld
> > (GNU Binutils for Debian) 2.35.2) #1 SMP @1687172533
> > [    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=10c5387d
> > [    0.000000] CPU: div instructions available: patching division code
> > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> > [    0.000000] OF: fdt: Machine model: TI AM5728 BeagleBoard-X15
> >
> > ..
> > LTP fs tests running
> >
> > cd /opt/ltp
> > ./runltp -f fs
> >
> > atch/ltp-lyYeJYjM8Y/fs_di-4743
> >              Loops: 10
> >     Data File Size: 30
> > fs_di       0  TINFO  :  Test Started
> > fs_di       0  TINFO  :  Completed Loop 1
> > fs_di       0  TINFO  :  Completed Loop 2
> > fs_di       0  TINFO  :  Completed Loop 3
> > fs_di       0  TINFO  :  Completed Loop 4
> > fs_di       0  TINFO  :  Completed Loop 5
> > fs_di       0  TINFO  :  Completed Loop 6
> > fs_di       0  TINFO  :  Completed Loop 7
> > fs_di       0  TINFO  :  Completed Loop 8
> > fs_di       0  TINFO  :  Completed Loop 9
> > fs_di       0  TINFO  :  Completed Loop 10
> > fs_di      10  TPASS  :  Test Successful
> > [ 1212.864074] 8<--- cut here ---
> > [ 1212.867156] Unable to handle kernel NULL pointer dereference at
> > virtual address 00000004 when read
> > [ 1212.876159] [00000004] *pgd=fb342835
> > [ 1212.879760] Internal error: Oops: 17 [#1] SMP ARM
> > [ 1212.884490] Modules linked in: etnaviv gpu_sched
> > snd_soc_simple_card snd_soc_simple_card_utils onboard_usb_hub
> > snd_soc_davinci_mcasp snd_soc_ti_udma snd_soc_ti_edma snd_soc_ti_sdma
> > snd_soc_core ac97_bus snd_pcm_dmaengine snd_pcm cfg80211 snd_timer snd
> > soundcore bluetooth display_connector
> > [ 1212.910217] CPU: 0 PID: 4855 Comm: proc01 Not tainted 6.3.9-rc1 #1
> > [ 1212.916442] Hardware name: Generic DRA74X (Flattened Device Tree)
> > [ 1212.922546] PC is at pci_generic_config_read+0x34/0x8c
> > [ 1212.927734] LR is at pci_generic_config_read+0x1c/0x8c
>
> It looks like the PCIe bus is not set up correctly, I also
> see these messages in the log indicating a problem with it:
>
> [    3.334503] dra7-pcie 51000000.pcie: host bridge /ocp/target-module@51000000/pcie@51000000 ranges:
> [    3.343627] dra7-pcie 51000000.pcie:       IO 0x0020003000..0x0020012fff -> 0x0000000000
> [    3.351806] dra7-pcie 51000000.pcie:      MEM 0x0020013000..0x002fffffff -> 0x0020013000
> [    3.362030] dra7-pcie 51000000.pcie: iATU: unroll F, 16 ob, 4 ib, align 4K, limit 4G
> [    4.370635] dra7-pcie 51000000.pcie: Phy link never came up
> [    4.376831] dra7-pcie 51000000.pcie: PCI host bridge to bus 0000:00
> [    4.383148] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    4.388702] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    4.394927] pci_bus 0000:00: root bus resource [mem 0x20013000-0x2fffffff]
> [    4.401885] pci 0000:00:00.0: [104c:8888] type 01 class 0x060400
> [    4.407958] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> [    4.414245] pci 0000:00:00.0: reg 0x14: [mem 0x00000000-0x0000ffff]
> [    4.420654] pci 0000:00:00.0: supports D1
> [    4.424682] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> [    4.437499] PCI: bus0: Fast back to back transfers disabled
> [    4.443389] PCI: bus1: Fast back to back transfers enabled
> [    4.448974] pci 0000:00:00.0: BAR 0: assigned [mem 0x20100000-0x201fffff]
> [    4.455810] pci 0000:00:00.0: BAR 1: assigned [mem 0x20020000-0x2002ffff]
> [    4.462646] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    4.468322] pcieport 0000:00:00.0: PME: Signaling with IRQ 135
> [    4.474487] genirq: Threaded irq requested with handler=NULL and !ONESHOT for dra7xx-pcie-main (irq 132)
> [    4.484100] dra7-pcie 51000000.pcie: failed to request irq
> [    4.489685] dra7-pcie: probe of 51000000.pcie failed with error -22
> [    4.503967] pcie-clkctrl:0000:0: failed to disable
>
> The function that crashed is
>
> int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
>                             int where, int size, u32 *val)
> {
>         void __iomem *addr;
>
>         addr = bus->ops->map_bus(bus, devfn, where);
>         if (!addr)
>                 return PCIBIOS_DEVICE_NOT_FOUND;
>
>         if (size == 1)
>                 *val = readb(addr);
>         else if (size == 2)
>                 *val = readw(addr);
>         else
>                 *val = readl(addr);
>
>         return PCIBIOS_SUCCESSFUL;
> }
>
> I have not disassembled the vmlinux file, but I can see that the
> offset into the NULL pointer is '4', which does not match the
> structur offsets for bus->ops or ops->map_bus.
>
> I also see that if map_bus returns NULL, we treat that as
> an error, but if it returns '4', that is taken as a pointer,
> which is my best guess at what is happening here.
>
> map_bus() seems to be either dw_pcie_other_conf_map_bus() or
> dw_pcie_own_conf_map_bus(), since the dra7 does not have its
> own variant but inherits these from the dwc pci driver.
>
> I think this is caused by the combination of two bugs:
>
> - something prevents the dra7-pcie driver from probing the
>   device correctly, ultimately failing with the "failed to
>   request irq" message.
>
> - The error handling in dra7xx_pcie_probe() fails to clean
>   up after the first problem, leaving the PCIe host
>   in a broken state instead of removing it entirely.

The reported kernel crash is continuously happening on the
BeagleBoard x15 device while running LTP fs tests on stable rc 6.4.7-rc1.

fs_di      10  TPASS  :  Test Successful
[ 1195.556701] 8<--- cut here ---
[ 1195.559783] Unable to handle kernel NULL pointer dereference at
virtual address 00000004 when read
[ 1195.568786] [00000004] *pgd=00000000
[ 1195.572387] Internal error: Oops: 5 [#1] SMP ARM
[ 1195.577026] Modules linked in: etnaviv gpu_sched
snd_soc_simple_card snd_soc_simple_card_utils onboard_usb_hub
snd_soc_davinci_mcasp snd_soc_ti_udma snd_soc_ti_edma snd_soc_ti_sdma
snd_soc_core ac97_bus snd_pcm_dmaengine snd_pcm snd_timer snd
soundcore display_connector
[ 1195.601104] CPU: 0 PID: 4876 Comm: proc01 Not tainted 6.4.7-rc1 #1
[ 1195.607330] Hardware name: Generic DRA74X (Flattened Device Tree)
[ 1195.613464] PC is at pci_generic_config_read+0x34/0x8c
[ 1195.618621] LR is at pci_generic_config_read+0x1c/0x8c

Links,
 - https://lkft.validation.linaro.org/scheduler/job/6619189#L3236
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2T3uHpNM7MkE9BOTcs22aOVCDnw/

- Naresh

>
>        Arnd
