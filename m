Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56A138702A
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 05:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbhERDKg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 23:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231625AbhERDKg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 May 2021 23:10:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7542561019;
        Tue, 18 May 2021 03:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621307358;
        bh=Zro/v7Ix/DVDYetwpk7YQX5hdFcxqrh7zn2RZ8YBaM0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aM3nz+O2pWFnpEG1ptEzP5u5srtX9573NGkxOC9U+l3prkSrXymsWayQ0zxF5WHiJ
         ufvXpCIfXhYj8qzJ+h7dBS9flgIewwlfowH1BM/fpuat3WudgmTR9vS1ZiiTCDl35w
         +e4aM7W9PWU33TRAJdLK727qzUz/LgakY9wGqQyAwSWb9yHb+mUQiR4dXFhpTm7mFi
         T6K9votddxLbxJpYt6DYOfM8fpS01zp+WGIehZHJQ4YLPJfdbP2LYuZg26iPdd69w9
         pRSSMIWNLYEjtTSLtrEVMLLR5F2tT3p/3OwHNeXJDpsXQOoV7/C6b/tcsXusit/y/B
         iw98bHEr0D2Uw==
Date:   Mon, 17 May 2021 22:09:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?utf-8?B?6ZqL5pmv5bOw?= <suijingfeng@loongson.cn>
Cc:     Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: Re: [PATCH 5/5] PCI: Support ASpeed VGA cards behind a
 misbehaving bridge
Message-ID: <20210518030917.GA72161@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e82843c.42a4.1797d50c753.Coremail.suijingfeng@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 18, 2021 at 10:31:56AM +0800, 隋景峰 wrote:
> &gt; -----Original Messages-----

Wow, this is ugly (the "&gt;" instead of ">").  Can you figure out
how to respond in the usual plain-text way?

> &gt; From: "Bjorn Helgaas" <helgaas@kernel.org>
> &gt; Sent Time: 2021-05-18 02:28:10 (Tuesday)
> &gt; To: "Huacai Chen" <chenhuacai@gmail.com>
> &gt; Cc: "Huacai Chen" <chenhuacai@loongson.cn>, "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci <linux-pci@vger.kernel.org>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>, "Jingfeng Sui" <suijingfeng@loongson.cn>
> &gt; Subject: Re: [PATCH 5/5] PCI: Support ASpeed VGA cards behind a misbehaving bridge
> &gt; 
> &gt; On Mon, May 17, 2021 at 08:53:43PM +0800, Huacai Chen wrote:
> &gt; &gt; On Sat, May 15, 2021 at 5:09 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> &gt; &gt; &gt; On Fri, May 14, 2021 at 11:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> &gt; &gt; &gt; &gt; On Fri, May 14, 2021 at 04:00:25PM +0800, Huacai Chen wrote:
> &gt; &gt; &gt; &gt; &gt; According to PCI-to-PCI bridge spec, bit 3 of Bridge Control Register is
> &gt; &gt; &gt; &gt; &gt; VGA Enable bit which modifies the response to VGA compatible addresses.
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; The bridge spec is pretty old, and most of the content has been
> &gt; &gt; &gt; &gt; incorporated into the PCIe spec.  I think you can cite "PCIe r5.0, sec
> &gt; &gt; &gt; &gt; 7.5.1.3.13" here instead.
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; &gt; If the VGA Enable bit is set, the bridge will decode and forward the
> &gt; &gt; &gt; &gt; &gt; following accesses on the primary interface to the secondary interface.
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; *Which* following accesses?  The structure of English requires that if
> &gt; &gt; &gt; &gt; you say "the following accesses," you must continue by *listing* the
> &gt; &gt; &gt; &gt; accesses.
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; &gt; The ASpeed AST2500 hardward does not set the VGA Enable bit on its
> &gt; &gt; &gt; &gt; &gt; bridge control register, which causes vgaarb subsystem don't think the
> &gt; &gt; &gt; &gt; &gt; VGA card behind the bridge as a valid boot vga device.
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; s/hardward/bridge/
> &gt; &gt; &gt; &gt; s/vga/VGA/ (also in code comments and dmesg strings below)
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; From the code, it looks like AST2500 ([1a03:2000]) is a VGA device,
> &gt; &gt; &gt; &gt; since it apparently has a VGA class code.  But here you say the
> &gt; &gt; &gt; &gt; AST2500 has a Bridge Control register, which suggests that it's a
> &gt; &gt; &gt; &gt; bridge.  If AST2500 is some sort of combination that includes both a
> &gt; &gt; &gt; &gt; bridge and a VGA device, please outline that topology.
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; But the hardware defect is that some bridges forward VGA accesses even
> &gt; &gt; &gt; &gt; though their VGA Enable bit is not set?  The quirk should be attached
> &gt; &gt; &gt; &gt; to broken *bridges*, not to VGA devices.
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; If a bridge forwards VGA accesses regardless of how its VGA Enable bit
> &gt; &gt; &gt; &gt; is set, that means VGA arbitration (in vgaarb.c) cannot work
> &gt; &gt; &gt; &gt; correctly, so merely setting the default VGA device once in a quirk is
> &gt; &gt; &gt; &gt; not sufficient.  You would have to somehow disable any future attempts
> &gt; &gt; &gt; &gt; to use other VGA devices.  Only the VGA device below this defective
> &gt; &gt; &gt; &gt; bridge is usable.  Any other VGA devices in the system would be
> &gt; &gt; &gt; &gt; useless.
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; &gt; So we provide a quirk to fix Xorg auto-detection.
> &gt; &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; &gt; See similar bug:
> &gt; &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; &gt; https://patchwork.kernel.org/project/linux-pci/patch/20170619023528.11532-1-dja@axtens.net/
> &gt; &gt; &gt; &gt;
> &gt; &gt; &gt; &gt; This patch was never merged.  If we merged a revised version, please
> &gt; &gt; &gt; &gt; cite the SHA1 instead.
> &gt; &gt; &gt;
> &gt; &gt; &gt; This patch has never merged, and I found that it is unnecessary after
> &gt; &gt; &gt; commit a37c0f48950b56f6ef2ee637 ("vgaarb: Select a default VGA device
> &gt; &gt; &gt; even if there's no legacy VGA"). Maybe this ASpeed patch is also
> &gt; &gt; &gt; unnecessary. If it is still needed, I'll investigate the root cause.
> &gt; &gt;
> &gt; &gt; I found that vga_arb_device_init() and pcibios_init() are both wrapped
> &gt; &gt; by subsys_initcall(), which means their sequence is unpredictable. And
> &gt; &gt; unfortunately, in our platform vga_arb_device_init() is called before
> &gt; &gt; pcibios_init(), which makes vga_arb_device_init() fail to set a
> &gt; &gt; default vga device. This is the root cause why we thought that we
> &gt; &gt; still need a quirk for AST2500.
> &gt; 
> &gt; Does this mean there is no hardware defect here?  The VGA Enable bit
> &gt; works correctly?
> 
> 
> The AST2500 BMC card we are using consist of a PCI-to-PCI Bridge (1a03:1150)
> and a PCI VGA device (1a03:2000). The value of the Bridge Control register
> in its PCI-to-PCI Bridge Configuration Registers is 0x0000. Thus, the VGA
> Enable bit in the Bridge Control register do not set, and the VGA
> Enable bit is not writable. 

If VGA Enable is 0 and cannot be set to 1, the bridge should *never*
forward VGA accesses to its secondary bus.  The generic VGA driver
that uses the legacy [mem 0xa0000-0xbffff] range should not work with
the VGA device at 05:00.0, and that device cannot participate in the
VGA arbitration scheme, which relies on the VGA Enable bit.

If you have a driver for 05:00.0 that doesn't need the legacy memory
range, it's possible that it may work.  But VGA arbitration will be
broken, and if 05:00.0 needs to be initialized by an option ROM, that
probably won't work either.

If the 04:00.0 bridge *always* forwards VGA accesses, even though its
VGA Enable bit is always zero, then the bridge is broken.  In that
case, the generic VGA driver should work with the 05:00.0 device, but
VGA arbitration will be limited.  I'm not sure, but the arbiter
*might* be able to use the VGA Enable bit in the 00:0c.0 bridge to
control VGA access to 05:00.0.  You wouldn't be able to have more than
one VGA device below 00:0c.0, and you may not be able have more than
one in the entire system.

> The topology of this BMC card is illustrated as following:
> 
>      /sys/devices/pci0000:00
>      |-- 0000:00:0c.0
>      |   |-- class (0x060400)
>      |   |-- vendor (0x0014)
>      |   |-- device (0x7a09)
>      |   |-- ...
>      |   |-- 0000:04:00.0
>      |   |   | -- class (0x060400)
>      |   |   | -- device (0x1150)
>      |   |   | -- vendor (0x1a03)
>      |   |   | -- revision (0x04)
>      |   |   | -- ...
>      |   |   | -- 0000:05:00.0 
>      |   |   |    | -- class  (0x030000)
>      |   |   |    | -- device (0x2000)
>      |   |   |    | -- vendor (0x1a03)
>      |   |   |    | -- irq (51)
>      |   |   |    | -- i2c-6
>      |   |   |    | -- drm
>      |   |   |    | -- graphics 
>      |   |   |    | -- ...
>      |   `-- uevent
>      `-- ...
> 
> The following information is getted from lspci -vvxx:

Generally it's better to use "sudo lspci -vvxx" so you decode all the
capabilities, too.  But in this case, all we care about is the Bridge
Control register ("bridgectl"), which *is* included (and apparently is
set to 0, since it's decoded as "vga-").

> 04:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 04) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast &gt;TAbort- <tabort- <mabort-="">SERR- <perr- intx-="" latency:="" 0="" interrupt:="" pin="" a="" routed="" to="" irq="" 51="" numa="" node:="" bus:="" primary="04," secondary="05," subordinate="05," sec-latency="0" i="" o="" behind="" bridge:="" 00004000-00004fff="" memory="" 41000000-427fffff="" status:="" 66mhz+="" fastb2b-="" parerr-="" devsel="medium">TAbort- <tabort- <mabort-="" <serr-="" <perr-="" bridgectl:="" parity-="" serr-="" noisa-="" vga-="" mabort-="">Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied="">
> 00: 03 1a 50 11 07 00 10 00 04 00 04 06 00 00 01 00
> 10: 00 00 00 00 00 00 00 00 04 05 05 00 41 41 20 02
> 20: 00 41 70 42 f1 ff 01 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 50 00 00 00 00 00 00 00 63 01 00 00
> 
> 05:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 41) (prog-if 00 [VGA controller])
> 	Subsystem: ASPEED Technology, Inc. ASPEED Graphics Family
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium &gt;TAbort- <tabort- <mabort-="">SERR- <perr- intx-="" latency:="" 0="" interrupt:="" pin="" a="" routed="" to="" irq="" 51="" numa="" node:="" region="" 0:="" memory="" at="" 41000000="" (32-bit,="" non-prefetchable)="" [size="16M]" 1:="" 42000000="" 2:="" i="" o="" ports="" 4000="" capabilities:="" <access="" denied="">
> 	Kernel driver in use: ast
> 00: 03 1a 00 20 27 00 10 02 41 00 00 03 00 00 00 00
> 10: 00 00 00 41 00 00 00 42 01 40 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 03 1a 00 20
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 63 01 00 00
