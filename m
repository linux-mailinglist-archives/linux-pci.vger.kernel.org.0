Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C16C1DCB65
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 12:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgEUKvw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 06:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgEUKvv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 06:51:51 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B09C061A0E
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2020 03:51:51 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y17so4397919ilg.0
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2020 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAq0CUb9eHF5XL7m9QAwrYiYBsIOlvzS2aUYA6oPip4=;
        b=sI+/MSMpadGwzdjD6sEAQPe44BkPRd2bXOBQ3MXMmevUkDzMn+DDGN/PYyupwfUOUB
         NrQanWm4jyQiAyQPEdPxiHD6CRiyil5RJ6tmypDIfJ+NJMorrZo28GlSvTf6+vGo6QVI
         fCjdCFAbkOYHA7AAmarm6Ohrp3AD/GPh66V5TW3B3s8lIwq5+Y2ESwpxIDAWoXx0UM1C
         jP0KFWzMPgk7UYbqKkOZXhbjVGq0EFq5r+I08qvgTiftSpNBkNAT2yRsuuUkC0r3YHR0
         ONjvmqk5mXLLA7afsMShpLidprbEGJkDrKMrlSvvinktn2dNepqYOvgtrrxPvWVR1jsV
         aOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAq0CUb9eHF5XL7m9QAwrYiYBsIOlvzS2aUYA6oPip4=;
        b=DC8wwWRihhx15bT7MSYFdaf61un9oSvGM54pnUnYFiG9q2AiaW8t/revUoDjtTnTPD
         lIFfK39rQYYcIjtJ1ucTf3QWe9XcO0F8+PgaYgPaahEmO3YI8FkGcc5E4WjzIxZVcPV1
         LPs2v1E9y9XKb/hdhEOyBI3NZRO4sO9GnkYAJ4IqTaxfwjob8SsaDYGK22QAdUzGRjNg
         0TH10E6yhh9WF+MqECCZciuekmKTtuyd7OIbyg8JYUEqOn0HJXYObobNPRomNQbZ8e+m
         y72QcGNkBtTZfHpgOKVeGbcnD+hcTViYx1Hjun+fWjHhuI5jUsvvTLCCck5B4Hoj4B0V
         ZKgw==
X-Gm-Message-State: AOAM532cW4tI+9BGAe2ShDd5qbPE2JgIrLCxjcboEQ+M6EtpgtZ9UL8l
        A9MDegeONixtu83h3B0E69t81iTBhdkdaS29WUs=
X-Google-Smtp-Source: ABdhPJy4lejL58uBqoRoZVuaJdx0RCNxznPD5OberhdCeboWfiOLtvY6ZtaySrK3koFVir11d9MZ6Ohaxy6NFO3COhg=
X-Received: by 2002:a92:d946:: with SMTP id l6mr8422565ilq.6.1590058310908;
 Thu, 21 May 2020 03:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <1590023130-137406-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1590023130-137406-1-git-send-email-shawn.lin@rock-chips.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 21 May 2020 16:21:40 +0530
Message-ID: <CANAwSgRXuMQaytB4BXL89JQAmU=XutBXj6iMhfKdZp3JwM9a4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: rockchip: Enable IO base and limit registers
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shawn,

On Thu, 21 May 2020 at 06:35, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> According to RK3399 user manual, bit 9 in PCIE_RC_BAR_CONF should
> be set, otherwise accessing to IO base and limit registers would
> fail.
>
> [    0.411318] pci_bus 0000:00: root bus resource [bus 00-1f]
> [    0.411822] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
> [    0.412440] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff])
> [    0.413665] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    0.414698] pci 0000:01:00.0: reg 0x10: initial BAR value 0x00000000 invalid
> [    0.415412] pci 0000:01:00.0: reg 0x18: initial BAR value 0x00000000 invalid
> [    0.418456] pci 0000:00:00.0: BAR 8: assigned [mem 0xfa000000-0xfa0fffff]
> [    0.419065] pci 0000:01:00.0: BAR 1: assigned [mem 0xfa000000-0xfa007fff pref]
> [    0.419728] pci 0000:01:00.0: BAR 6: assigned [mem 0xfa008000-0xfa00ffff pref]
> [    0.420377] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0100]
> [    0.420935] pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0100]
> [    0.421526] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0004]
> [    0.422084] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0004]
> [    0.422687] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    0.423135] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
> [    0.423794] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
> [    0.424566] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
> [    0.425182] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
>
> 01:00.0 Class 0700: Device 1c00:3853 (rev 10) (prog-if 05)
>         Subsystem: Device 1c00:3853
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 230
>         Region 0: I/O ports at <unassigned> [disabled]
>         Region 1: Memory at fa000000 (32-bit, prefetchable) [disabled] [size=32K]
>         Region 2: I/O ports at <unassigned> [disabled]
>         [virtual] Expansion ROM at fa008000 [disabled] [size=32K]
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---

I have old development board Odroid N1 (RK3399),  It has onboard PCIe
2 dual sata bridge.
I have tested this patch, but I am still getting following log on
Odroid N1 board.
Is their any more configuration needed for sata ports ?

[    7.444504] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
[    7.445521] panfrost ff9a0000.gpu: Features: L2:0x07120206
Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff
JS:0x7
[    7.452246] pci 0000:00:00.0: BAR 14: assigned [mem 0xfa000000-0xfa0fffff]
[    7.460106] panfrost ff9a0000.gpu: shader_present=0xf l2_present=0x1
[    7.466459] pci 0000:01:00.0: BAR 6: assigned [mem
0xfa000000-0xfa00ffff pref]
[    7.473679] panfrost ff9a0000.gpu: [drm:panfrost_devfreq_init
[panfrost]] Failed to register cooling device
[    7.479703] pci 0000:01:00.0: BAR 5: assigned [mem 0xfa010000-0xfa0101ff]
[    7.487706] [drm] Initialized panfrost 1.1.0 20180908 for
ff9a0000.gpu on minor 0
[    7.494343] pci 0000:01:00.0: BAR 4: no space for [io  size 0x0010]
[    7.494348] pci 0000:01:00.0: BAR 4: failed to assign [io  size 0x0010]
[    7.494352] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0008]
[    7.494356] pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0008]
[    7.494360] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0008]
[    7.494364] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0008]
[    7.494368] pci 0000:01:00.0: BAR 1: no space for [io  size 0x0004]
[    7.494372] pci 0000:01:00.0: BAR 1: failed to assign [io  size 0x0004]
[    7.578910] rockchip-vop ff8f0000.vop: Adding to iommu group 3
[    7.587074] pci 0000:01:00.0: BAR 3: no space for [io  size 0x0004]
[    7.594780] rockchip-vop ff900000.vop: Adding to iommu group 4
[    7.607701] pci 0000:01:00.0: BAR 3: failed to assign [io  size 0x0004]

# lspci -v
00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI
Express Root Port (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 237
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00000000-00000fff [size=4K]
        Memory behind bridge: fa000000-fa0fffff [size=1M]
        Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
        Capabilities: [80] Power Management version 3
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable+ 64bit+
        Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
        Capabilities: [c0] Express Root Port (Slot+), MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [274] Transaction Processing Hints
        Kernel driver in use: pcieport

01:00.0 IDE interface: ASMedia Technology Inc. ASM1061 SATA IDE
Controller (rev 02) (prog-if 85 [PCI native mode-only controller,
supports bus mastering])
        Subsystem: ASMedia Technology Inc. ASM1061 SATA IDE Controller
        Flags: bus master, fast devsel, latency 0, IRQ 238
        I/O ports at <unassigned> [disabled]
        I/O ports at <unassigned> [disabled]
        I/O ports at <unassigned> [disabled]
        I/O ports at <unassigned> [disabled]
        I/O ports at <unassigned> [disabled]
        Memory at fa010000 (32-bit, non-prefetchable) [size=512]
        Expansion ROM at fa000000 [virtual] [disabled] [size=64K]
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Legacy Endpoint, MSI 00
        Capabilities: [100] Virtual Channel
        Kernel driver in use: ahci

Best Regards
-Anand
