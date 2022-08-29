Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F92F5A4688
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 11:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiH2Jy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 05:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiH2Jy0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 05:54:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0BE5E32B;
        Mon, 29 Aug 2022 02:54:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6D1EB80E4D;
        Mon, 29 Aug 2022 09:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CB2C433D7;
        Mon, 29 Aug 2022 09:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661766862;
        bh=oWLurgdSKTB0vt6GSTZSrYv9689ZAcwK3zgfRifrLzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+St8Rf7q5Qc/uUBzP9wcevzAHPshaX7kUdv4mAvQq5xIvY8dKA7zu7Dab9tg+4+Z
         nbLNeVZ8lm4sMLKbXhXoVDm9WPEcnSg4jkmrgGFyNG7CNZNWP/RKq7US3kv8fjT5Gd
         tfrJKAcqZU33M+7r0207lGuMWN3MRfn3OitCyQUK1p+MLYaJLDO9BX2n3YcUE3Kq/i
         +AoG94M7uF/SlOsVJ13VKajhX2rdSvlrBCn8tTUZR9QvK7XeaprmevxcGlyFfAqnYl
         TaJgXDG7YqdY68qKcgFU0DEIE3ldLkcpdcsEgDsQnthJQbn7GBc3fsXZstuFvR+gSw
         vqiwPHuVX4bRg==
Date:   Mon, 29 Aug 2022 11:54:15 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hajo Noerenberg <hajo-linux-bugzilla@noerenberg.de>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Dispose INTx irqs prior to removing INTx
 domain
Message-ID: <YwyMx+bncFkEtjlT@lpieralisi>
References: <20220709161858.15031-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220709161858.15031-1-pali@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 09, 2022 at 06:18:58PM +0200, Pali Rohár wrote:
> Documentation for irq_domain_remove() says that all mapping within the
> domain must be disposed prior to domain remove.
> 
> Currently INTx irqs are not disposed in pci-mvebu.c device unbind callback
> which cause that kernel crashes after unloading driver and trying to read
> /sys/kernel/debug/irq/irqs/<num> or /proc/interrupts.
> 
> Fixes: ec075262648f ("PCI: mvebu: Implement support for legacy INTx interrupts")
> Reported-by: Hajo Noerenberg <hajo-linux-bugzilla@noerenberg.de>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
> Depends on patch:
> https://lore.kernel.org/linux-pci/20220524122817.7199-1-pali@kernel.org/

It does not look like the patch above will be merged therefore you
need to rebase all dependent patches please.

> Here is the captured kernel crash which happens without this patch:
> 
> $ cat /sys/kernel/debug/irq/irqs/64
> [  301.571370] 8<--- cut here ---
> [  301.574496] Unable to handle kernel paging request at virtual address 0a00002a
> [  301.581736] [0a00002a] *pgd=00000000
> [  301.585323] Internal error: Oops: 80000005 [#1] SMP ARM
> [  301.590560] Modules linked in:

Timing information is not relevant, remove it.

Thanks,
Lorenzo

> [  301.593621] CPU: 1 PID: 4641 Comm: cat Not tainted 5.16.0-rc1+ #192
> [  301.599905] Hardware name: Marvell Armada 380/385 (Device Tree)
> [  301.605836] PC is at 0xa00002a
> [  301.608896] LR is at irq_debug_show+0x210/0x2d4
> [  301.613440] pc : [<0a00002a>]    lr : [<c018ca40>]    psr: 200000b3
> [  301.619721] sp : c797fdd8  ip : 0000000b  fp : 0a00002b
> [  301.624957] r10: c0d9a364  r9 : 00000001  r8 : 00000000
> [  301.630192] r7 : c18fee18  r6 : c0da2a74  r5 : c18fee00  r4 : c66ec050
> [  301.636734] r3 : 00000001  r2 : c18fee18  r1 : 00000000  r0 : c66ec050
> [  301.643275] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA Thumb  Segment none
> [  301.650689] Control: 10c5387d  Table: 0790c04a  DAC: 00000051
> [  301.656446] Register r0 information: slab seq_file start c66ec050 pointer offset 0
> [  301.664040] Register r1 information: NULL pointer
> [  301.668755] Register r2 information: slab kmalloc-256 start c18fee00 pointer offset 24 size 256
> [  301.677480] Register r3 information: non-paged memory
> [  301.682543] Register r4 information: slab seq_file start c66ec050 pointer offset 0
> [  301.690133] Register r5 information: slab kmalloc-256 start c18fee00 pointer offset 0 size 256
> [  301.698770] Register r6 information: non-slab/vmalloc memory
> [  301.704442] Register r7 information: slab kmalloc-256 start c18fee00 pointer offset 24 size 256
> [  301.713165] Register r8 information: NULL pointer
> [  301.717879] Register r9 information: non-paged memory
> [  301.722941] Register r10 information: non-slab/vmalloc memory
> [  301.728699] Register r11 information: non-paged memory
> [  301.733848] Register r12 information: non-paged memory
> [  301.738997] Process cat (pid: 4641, stack limit = 0xf591166e)
> [  301.744756] Stack: (0xc797fdd8 to 0xc7980000)
> [  301.749123] fdc0:                                                       0000000a 830d3f3e
> [  301.757321] fde0: c1004f48 c0d9a374 c7a9cc10 c66ec050 00000000 c88af900 c797fe80 7ffff000
> [  301.765518] fe00: 00400cc0 c66ec068 00000001 c02c5cb8 00000000 00000000 c66ec078 c797fe68
> [  301.773715] fe20: c1cdf6c0 c7a9cc10 ffffffea c88af900 00000010 00000000 00000000 c88af900
> [  301.781911] fe40: c1004f48 c797ff78 00001000 00004004 c03efcb8 c02c6100 00001000 00000000
> [  301.790108] fe60: bec73e04 00001000 00000000 00000000 00001000 c797fe60 00000001 00000000
> [  301.798304] fe80: c88af900 00000000 00000000 00000000 00000000 00000000 00000000 40040000
> [  301.806501] fea0: 00000000 00000000 c1004f48 830d3f3e c88af900 c02c6018 c1c7a770 bec73e04
> [  301.814697] fec0: 00001000 c797ff78 00000001 c03efd0c 00001000 c88af900 00000000 bec73e04
> [  301.822894] fee0: c1004f48 c797ff78 00000001 c029c728 c887ca20 01100cca 0000004f 0045f000
> [  301.831091] ff00: 00000254 c790c010 c790c010 00000000 00000000 00000000 c5f6117c eeece9b8
> [  301.839288] ff20: 00000000 830d3f3e 00000000 c797ffb0 c79fc000 80000007 0045f5b8 00000254
> [  301.847484] ff40: c79fc040 00000004 c887ca20 830d3f3e 00000000 c1004f48 c88af900 00000000
> [  301.855681] ff60: 00000000 c88af900 bec73e04 00001000 00000000 c029cd68 00000000 00000000
> [  301.863877] ff80: 00000000 830d3f3e 00000000 00000000 01000000 00000003 c0100284 c1b8abc0
> [  301.872074] ffa0: 00000003 c0100060 00000000 00000000 00000003 bec73e04 00001000 00000000
> [  301.880270] ffc0: 00000000 00000000 01000000 00000003 00000003 00000001 00000001 00000000
> [  301.888468] ffe0: bec73d98 bec73d88 b6f81f88 b6f81410 60000010 00000003 00000000 00000000
> [  301.896666] [<c018ca40>] (irq_debug_show) from [<c02c5cb8>] (seq_read_iter+0x1a4/0x504)
> [  301.904700] [<c02c5cb8>] (seq_read_iter) from [<c02c6100>] (seq_read+0xe8/0x12c)
> [  301.912117] [<c02c6100>] (seq_read) from [<c03efd0c>] (full_proxy_read+0x54/0x70)
> [  301.919623] [<c03efd0c>] (full_proxy_read) from [<c029c728>] (vfs_read+0xa0/0x2c8)
> [  301.927214] [<c029c728>] (vfs_read) from [<c029cd68>] (ksys_read+0x58/0xd0)
> [  301.934195] [<c029cd68>] (ksys_read) from [<c0100060>] (ret_fast_syscall+0x0/0x54)
> [  301.941785] Exception stack(0xc797ffa8 to 0xc797fff0)
> [  301.946849] ffa0:                   00000000 00000000 00000003 bec73e04 00001000 00000000
> [  301.955045] ffc0: 00000000 00000000 01000000 00000003 00000003 00000001 00000001 00000000
> [  301.963241] ffe0: bec73d98 bec73d88 b6f81f88 b6f81410
> [  301.968304] Code: bad PC value
> [  301.971365] ---[ end trace fe25fd26d042b605 ]---
> [  301.975992] Kernel panic - not syncing: Fatal exception
> [  301.981229] CPU0: stopping
> [  301.983946] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D           5.16.0-rc1+ #192
> [  301.991884] Hardware name: Marvell Armada 380/385 (Device Tree)
> [  301.997817] [<c010e120>] (unwind_backtrace) from [<c010a170>] (show_stack+0x10/0x14)
> [  302.005587] [<c010a170>] (show_stack) from [<c0bbf108>] (dump_stack_lvl+0x40/0x4c)
> [  302.013179] [<c0bbf108>] (dump_stack_lvl) from [<c010c3f8>] (do_handle_IPI+0xf4/0x128)
> [  302.021117] [<c010c3f8>] (do_handle_IPI) from [<c010c444>] (ipi_handler+0x18/0x20)
> [  302.028707] [<c010c444>] (ipi_handler) from [<c0185c5c>] (handle_percpu_devid_irq+0x78/0x124)
> [  302.037256] [<c0185c5c>] (handle_percpu_devid_irq) from [<c017ffb8>] (generic_handle_domain_irq+0x44/0x88)
> [  302.046938] [<c017ffb8>] (generic_handle_domain_irq) from [<c05f051c>] (gic_handle_irq+0x74/0x88)
> [  302.055839] [<c05f051c>] (gic_handle_irq) from [<c0bc7ef8>] (generic_handle_arch_irq+0x34/0x44)
> [  302.064564] [<c0bc7ef8>] (generic_handle_arch_irq) from [<c0100b10>] (__irq_svc+0x50/0x68)
> [  302.072851] Exception stack(0xc1001f00 to 0xc1001f48)
> [  302.077916] 1f00: 000d6830 00000000 00000001 c0116be0 c1004f90 c1004fd4 00000001 00000000
> [  302.086114] 1f20: c1004f48 c0f5d2a8 c1009e80 00000000 00000000 c1001f50 c01076f4 c01076f8
> [  302.094309] 1f40: 60000013 ffffffff
> [  302.097804] [<c0100b10>] (__irq_svc) from [<c01076f8>] (arch_cpu_idle+0x38/0x3c)
> [  302.105223] [<c01076f8>] (arch_cpu_idle) from [<c0bcf3a0>] (default_idle_call+0x1c/0x2c)
> [  302.113338] [<c0bcf3a0>] (default_idle_call) from [<c015db34>] (do_idle+0x1c8/0x218)
> [  302.121106] [<c015db34>] (do_idle) from [<c015de40>] (cpu_startup_entry+0x18/0x20)
> [  302.128697] [<c015de40>] (cpu_startup_entry) from [<c0f00fec>] (start_kernel+0x650/0x694)
> [  302.136901] Rebooting in 3 seconds..
> ---
>  drivers/pci/controller/pci-mvebu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 31f53a019b8f..951030052358 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1713,8 +1713,15 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
>  		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
>  
>  		/* Remove IRQ domains. */
> -		if (port->intx_irq_domain)
> +		if (port->intx_irq_domain) {
> +			int virq, j;
> +			for (j = 0; j < PCI_NUM_INTX; j++) {
> +				virq = irq_find_mapping(port->intx_irq_domain, j);
> +				if (virq > 0)
> +					irq_dispose_mapping(virq);
> +			}
>  			irq_domain_remove(port->intx_irq_domain);
> +		}
>  
>  		/* Free config space for emulated root bridge. */
>  		pci_bridge_emul_cleanup(&port->bridge);
> -- 
> 2.20.1
> 
