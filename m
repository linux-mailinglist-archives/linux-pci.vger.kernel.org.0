Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CD42E7BC2
	for <lists+linux-pci@lfdr.de>; Wed, 30 Dec 2020 19:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgL3SE0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Dec 2020 13:04:26 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:34349 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbgL3SEZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Dec 2020 13:04:25 -0500
Received: from [192.168.0.6] (ip5f5ae921.dynamic.kabel-deutschland.de [95.90.233.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0052020646219;
        Wed, 30 Dec 2020 19:03:43 +0100 (CET)
Subject: Re: [Intel-wired-lan] [PATCH] PCI: add Intel i210 quirk
To:     Michael Walle <michael@walle.cc>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        intel-wired-lan@lists.osuosl.org
References: <20201230172823.28483-1-michael@walle.cc>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <f9009984-1917-824a-25c1-d9120f6d3d5b@molgen.mpg.de>
Date:   Wed, 30 Dec 2020 19:03:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201230172823.28483-1-michael@walle.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Michael,


Thank you for the patch.

Maybe the summary could be more specific:

 > PCI: Fix Intel i210 by avoiding overlapping of BARs

Am 30.12.20 um 18:28 schrieb Michael Walle:
> The Intel i210 doesn't work if the Expansion ROM BAR overlaps with
> another BAR. Networking won't work at all and once a packet is sent the
> netdev watchdog will bite:
> 
> [   89.059374] ------------[ cut here ]------------
> [   89.064019] NETDEV WATCHDOG: enP2p1s0 (igb): transmit queue 0 timed out
> [   89.070681] WARNING: CPU: 1 PID: 0 at net/sched/sch_generic.c:443 dev_watchdog+0x3a8/0x3b0
> [   89.078989] Modules linked in:
> [   89.082053] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.11.0-rc1-00020-gc16f033804b #289
> [   89.091574] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 2.0 carrier (DT)
> [   89.099870] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> [   89.105900] pc : dev_watchdog+0x3a8/0x3b0
> [   89.109923] lr : dev_watchdog+0x3a8/0x3b0
> [   89.113945] sp : ffff80001000bd50
> [   89.117268] x29: ffff80001000bd50 x28: 0000000000000008
> [   89.122602] x27: 0000000000000004 x26: 0000000000000140
> [   89.127935] x25: ffff002001c6c000 x24: ffff002001c2b940
> [   89.133267] x23: ffff8000118c7000 x22: ffff002001c6c39c
> [   89.138600] x21: ffff002001c6bfb8 x20: ffff002001c6c3b8
> [   89.143932] x19: 0000000000000000 x18: 0000000000000010
> [   89.149264] x17: 0000000000000000 x16: 0000000000000000
> [   89.154596] x15: ffffffffffffffff x14: 0720072007200720
> [   89.159928] x13: 0720072007740775 x12: ffff80001195b980
> [   89.165260] x11: 0000000000000003 x10: ffff800011943940
> [   89.170592] x9 : ffff800010100d44 x8 : 0000000000017fe8
> [   89.175924] x7 : c0000000ffffefff x6 : 0000000000000001
> [   89.181255] x5 : 0000000000000000 x4 : 0000000000000000
> [   89.186587] x3 : 00000000ffffffff x2 : ffff8000118eb908
> [   89.191919] x1 : 84d8200845006900 x0 : 0000000000000000
> [   89.197251] Call trace:
> [   89.199701]  dev_watchdog+0x3a8/0x3b0
> [   89.203374]  call_timer_fn+0x38/0x208
> [   89.207049]  run_timer_softirq+0x290/0x540
> [   89.211158]  __do_softirq+0x138/0x404
> [   89.214831]  irq_exit+0xe8/0xf8
> [   89.217981]  __handle_domain_irq+0x70/0xc8
> [   89.222091]  gic_handle_irq+0xc8/0x2b0
> [   89.225850]  el1_irq+0xb8/0x180
> [   89.228999]  arch_cpu_idle+0x18/0x40
> [   89.232587]  default_idle_call+0x70/0x214
> [   89.236610]  do_idle+0x21c/0x290
> [   89.239848]  cpu_startup_entry+0x2c/0x70
> [   89.243783]  secondary_start_kernel+0x1a0/0x1f0
> [   89.248332] ---[ end trace 1687af62576397bc ]---
> [   89.253350] igb 0002:01:00.0 enP2p1s0: Reset adapter
> 
> Before this fixup the Expansion ROM BAR will overlap with BAR3:
>    # lspci -ns 2:1:0 -xx
>    0002:01:00.0 0200: 8086:1533 (rev 03)
>    00: 86 80 33 15 06 04 10 00 03 00 00 02 08 00 00 00
>    10: 00 00 00 40 00 00 00 00 00 00 00 00 00 00 20 40
>    20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 03 00
>    30: 00 00 20 40 40 00 00 00 00 00 00 00 22 01 00 00
> 
> Add a quirk which will update the Expansion ROM BAR for Intel i210s even
> if the ROM is disabled. This was tested on an ARM64 board (kontron
> sl28).

As this seems also related to the boot loader, please mention the name 
and version too.

Maybe also add the output with the quirk applied?

> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>   drivers/pci/quirks.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..59c204ef5df7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5612,3 +5612,37 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
>   }
>   DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
>   			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> +
> +/*
> + * Some devices doesn't work if the Expansion ROM has the same base address as

don’t

> + * one of the other BARs although it is disabled.
> + * This might happen if the bootloader/BIOS enumerate the BARs in a different

enumerates?

> + * way than linux. If the Expansion ROM is disabled, linux deliberately skip

skip*s*

> + * writing the ROM BAR if the BAR is not enabled because of some broken
> + * devices, see pci_std_update_resource(). Thus, the ROM BAR of the device will
> + * still contain the value assigned by the booloader, which might be the same
> + * value as one of the other BARs then.
> + *
> + * As a workaround, update the Expansion ROM BAR even if the Expansion ROM is
> + * disabled.
> + */
> +static void pci_fixup_rewrite_rom_bar(struct pci_dev *dev)
> +{
> +	struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
> +	struct pci_bus_region region;
> +	u32 rom_addr;
> +
> +	pci_read_config_dword(dev, dev->rom_base_reg, &rom_addr);
> +
> +	if (rom_addr & PCI_ROM_ADDRESS_ENABLE)
> +		return;
> +
> +	pcibios_resource_to_bus(dev->bus, &region, res);
> +	rom_addr &= ~PCI_ROM_ADDRESS_MASK;
> +	rom_addr |= region.start;
> +	pci_write_config_dword(dev, dev->rom_base_reg, rom_addr);
> +}

Can some debug message be added, that the quirk was run?

> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1533, pci_fixup_rewrite_rom_bar);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1536, pci_fixup_rewrite_rom_bar);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1537, pci_fixup_rewrite_rom_bar);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1538, pci_fixup_rewrite_rom_bar);


Kind regards,

Paul
