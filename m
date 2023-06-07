Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6771472715A
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 00:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjFGWP1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 18:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFGWP0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 18:15:26 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4552115
        for <linux-pci@vger.kernel.org>; Wed,  7 Jun 2023 15:15:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1acd41ad2so73896911fa.3
        for <linux-pci@vger.kernel.org>; Wed, 07 Jun 2023 15:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686176122; x=1688768122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=idAjIL4zwEDFkJwn7jtDFtCa5NhtH9omzj8pWxZUdH0=;
        b=AQcvPeqeFWQ0wq4Nw77gzzQR9nw5CpGOoN9/1KKR8VfOCJCWKLv4sG6c/Hi9b1kdFc
         XpL128nPr2UQVbEGHRJZDgKHAYnbnHf5g17+uxOjphCUkMzWiHYSUydnHpIPBW9EfMea
         oK6Ke2nrlaHF4fs4/+oYF83UBJDGvvnOuQmuSZNFL38H9V5LK2JlWYiJ8iEIF0ygzWXk
         AamGTZ66MqKAEdG2ZrOAmPsY710dvUPsqtx9Ry+6LrOSkAVGLdHb3/quvajgTL2CFYrh
         XZ6sJ44IX8gEFV9iPgXba39DcmpfoV4rA8rLWBe/04ztuJ2EgjQXyeJQNZ1Jr3ASmwgL
         2LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686176122; x=1688768122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idAjIL4zwEDFkJwn7jtDFtCa5NhtH9omzj8pWxZUdH0=;
        b=d0M40bk1knZCQfDjaOJSLAcZDofzAjL+BYM1rOSl2fYvlYWAjN07laCTS6HKwbkkGY
         It28fQbRbtECJwhz7IyjWSP/5HKtOPLo1BteHt9tyoy8+u17D2fPFBgkJk+XqBG+qN/A
         OVUN+GXeESlsFu4kryei/RTnAJGfJPoAjaGlfUKdBlnTTNFbIkTgY/U841LN7gNF02ht
         gazbVirfcYEkxcsGxnxIFy2MVDO5KhSpR4xcyJnv2To6qA+V5etXbVfD8WO8LMkJKMUq
         ctzr2/wPgEudGAycAGESKx6DmlffnU3n0Z3Yo4Iyj3GKV/rE2NETR3aJM2/nedjKcwYe
         h5ww==
X-Gm-Message-State: AC+VfDzjFQoWw6kSKuEgc958m+uba8JTRDW+H1/zkRuiGollWaYqf4th
        ++3dCOi0sBpvySR/by9hnl5UK4uEQLun9cEUamY=
X-Google-Smtp-Source: ACHHUZ78Pa/p20pefsvRzCENj1D0ww4mXuxlwiLRH21DtNTb0hsKg/ZOq/70CRliTqXrGrKhnjhK6jXvYRIbeoA8J0Q=
X-Received: by 2002:a2e:7302:0:b0:2ac:d51f:2d60 with SMTP id
 o2-20020a2e7302000000b002acd51f2d60mr2511965ljc.33.1686176122270; Wed, 07 Jun
 2023 15:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <BL3PR02MB7986DFD09C363B691D7EF194FE1F9@BL3PR02MB7986.namprd02.prod.outlook.com>
 <20221213213053.GA208909@bhelgaas> <BL3PR02MB79863556B6F5735AD58D4DB5FE53A@BL3PR02MB7986.namprd02.prod.outlook.com>
In-Reply-To: <BL3PR02MB79863556B6F5735AD58D4DB5FE53A@BL3PR02MB7986.namprd02.prod.outlook.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Wed, 7 Jun 2023 17:15:10 -0500
Message-ID: <CABhMZUUQmuSBoOJXozON26fLrr7xjz6TpfLUoNZfjHBeJuRY7w@mail.gmail.com>
Subject: Re: uefi secureboot vm and IO window overlap
To:     "Kallol Biswas [C]" <kallol.biswas@nutanix.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[FYI, I'm not sure why, but your email didn't seem to make it to the
list; maybe there's a clue at
http://vger.kernel.org/majordomo-info.html]

On Wed, Jun 7, 2023 at 4:42=E2=80=AFPM Kallol Biswas [C]
<kallol.biswas@nutanix.com> wrote:
>
> Hello Bjorn,
>                             I have reproduced the problem in the 6.3.6 ke=
rnel and debugged the source of the conflict.
>
> Here is the OVMF log:
> PciBus: Resource Map for Root Bridge PciRoot(0x0)^M
> Type =3D   Io16; Base =3D 0x6000;   Length =3D 0x3000;        Alignment =
=3D 0xFFF^M
>    Base =3D 0x6000;       Length =3D 0x200; Alignment =3D 0xFFF;      Own=
er =3D PPB [00|02|02:**]^M
>    Base =3D 0x7000;       Length =3D 0x200; Alignment =3D 0xFFF;      Own=
er =3D PPB [00|02|01:**]^M
>    Base =3D 0x8000;       Length =3D 0x200; Alignment =3D 0xFFF;      Own=
er =3D PPB [00|02|00:**]^M
>    Base =3D 0x8200;       Length =3D 0x40;  Alignment =3D 0x3F;       Own=
er =3D PCI [00|1F|03:20]^M
>    Base =3D 0x8240;       Length =3D 0x20;  Alignment =3D 0x1F;       Own=
er =3D PCI [00|1F|02:20]^M
>    Base =3D 0x8260;       Length =3D 0x20;  Alignment =3D 0x1F;       Own=
er =3D PCI [00|1D|02:20]^M
>    Base =3D 0x8280;       Length =3D 0x20;  Alignment =3D 0x1F;       Own=
er =3D PCI [00|1D|01:20]^M
>    Base =3D 0x82A0;       Length =3D 0x20;  Alignment =3D 0x1F;       Own=
er =3D PCI [00|1D|00:20]^M
>    Base =3D 0x82C0;       Length =3D 0x20;  Alignment =3D 0x1F;       Own=
er =3D PCI [00|03|00:10]^M
>
> [nutanix@localhost ~]$ lspci -s 0:2.0 -vvv
> 00:02.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port (prog-if 00 [Normal=
 decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 22
>         Region 0: Memory at c1645000 (32-bit, non-prefetchable) [size=3D4=
K]
>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=
=3D0
>         I/O behind bridge: 00008000-00008fff [size=3D4K]
>         Memory behind bridge: c1400000-c15fffff [size=3D2M]
>         Prefetchable memory behind bridge: 0000084000000000-00000840000ff=
fff [size=3D1M]
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB=
2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: <access denied>
>         Kernel driver in use: pcieport
> Dmesg log:
> [    2.232081] pci 0000:00:02.0: PCI bridge to [bus 01]
> [    2.232098] pci_read_bridge_io:base 0x8000 limit 0x8000 io_granulatiry=
 0x1000
> [    2.232099] pci 0000:00:02.0:   bridge window [io  0x8000-0x8fff]
> [    2.233005] pci 0000:00:02.0:   bridge window [mem 0xc1400000-0xc15fff=
ff]
> [    2.233034] pci 0000:00:02.0:   bridge window [mem 0x84000000000-0x840=
000fffff 64bit
>
> Kernel code:
> static void pci_read_bridge_io(struct pci_bus *child)
> {
>         struct pci_dev *dev =3D child->self;
>         u8 io_base_lo, io_limit_lo;
>         unsigned long io_mask, io_granularity, base, limit;
>         struct pci_bus_region region;
>         struct resource *res;
>
>         io_mask =3D PCI_IO_RANGE_MASK;
>         io_granularity =3D 0x1000;
>         if (dev->io_window_1k) {
>                 /* Support 1K I/O space granularity */
>                 io_mask =3D PCI_IO_1K_RANGE_MASK;
>                 io_granularity =3D 0x400;
>         }
>
>
>         printk("pci_read_bridge_io:base 0x%x limit 0x%x io_granulatiry 0x=
%x\n", base, limit, io_granularity);  <=3D my print
>         if (base <=3D limit) {
>                 res->flags =3D (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IO=
RESOURCE_IO;
>                 region.start =3D base;
>                 region.end =3D limit + io_granularity - 1;
>                 pcibios_bus_to_resource(dev->bus, res, &region);
>                 pci_info(dev, "  bridge window %pR\n", res);
>         }
>
>
> OVMF sets the base for 0:2.0 as 0x8000 and length as 0x200 but kernel io_=
granularity is 0x1000
> So, the bridge window becomes 0x8000 to 0x8fff, which overlaps the OVMF p=
rogrammed IO base
> registers for other endpoints.
>
> [    2.996029] pci 0000:00:03.0: can't claim BAR 0 [io  0x82c0-0x82df]: a=
ddress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
> [    2.996049] pci 0000:00:1d.0: can't claim BAR 4 [io  0x82a0-0x82bf]: a=
ddress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
> [    2.996058] pci 0000:00:1d.1: can't claim BAR 4 [io  0x8280-0x829f]: a=
ddress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
> [    2.996068] pci 0000:00:1d.2: can't claim BAR 4 [io  0x8260-0x827f]: a=
ddress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
> [    2.996093] pci 0000:00:1f.2: can't claim BAR 4 [io  0x8240-0x825f]: a=
ddress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
> [    2.996997] pci 0000:00:1f.3: can't claim BAR 4 [io  0x8200-0x823f]: a=
ddress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
>
> Sorry, did not get time to debug this before.
>
> Question, why does the kernel set IO granularity to 4k?

The "io_granularity =3D 0x1000" in pci_read_bridge_io() comes from the
fact that PCIe r6.0, sec 7.5.1.3.6, says bridges assume the lower 12
address bits of I/O Base registers (the bridge I/O window) are zero.

Bjorn

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, December 13, 2022 1:31 PM
> To: Kallol Biswas [C] <kallol.biswas@nutanix.com>
> Cc: linux-pci@vger.kernel.org
> Subject: Re: uefi secureboot vm and IO window overlap
>
> On Sat, Dec 10, 2022 at 05:45:50PM +0000, Kallol Biswas [C] wrote:
> > The part1 of the dmesg:
> >
> > [    0.000000] Initializing cgroup subsys cpuset
> > [    0.000000] Initializing cgroup subsys cpu
> > [    0.000000] Initializing cgroup subsys cpuacct
> > [    0.000000] Linux version 3.10.0-957.el7.x86_64 (mockbuild@kbuilder.=
bsys.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-36) (GCC) ) #1 =
SMP Thu Nov 8 23:39:32 UTC 2018
>
> Is there any chance you can reproduce the problem on a current kernel?
> If it's been fixed by now, maybe we could identify the fix and you could =
backport it?
>
> Bjorn
