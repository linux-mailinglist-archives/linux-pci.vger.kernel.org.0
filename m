Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B244F17793A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 15:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCCOia (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 09:38:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgCCOi3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 09:38:29 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E767E20838;
        Tue,  3 Mar 2020 14:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583246309;
        bh=elj28SC1BBksBJDG9rtk+GAZOY8nGE3uwbpMfH0H8kE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ymecdNsmzO/RdyoCzvt+ifRaflAViNZudlRJ82N84Ku2Mi4A7UPNdobvStDFNf1bo
         uw3JPwVfgbMGEagfkCy2/sO8sjc7hoQrXMDmH+fkc12ACTfVG6j1SwFwy/L+b5H72a
         PXlL/HL/CaD0J7a7HEKlPT48stIB0zU2Hi7FCN7E=
Date:   Tue, 3 Mar 2020 08:38:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mikel Rychliski <mikel@mikelr.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Matthew Garrett <matthewgarrett@google.com>
Subject: Re: [PATCH 2/4] PCI: Use ioremap, not phys_to_virt for platform rom
Message-ID: <20200303143827.GA78253@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303033457.12180-3-mikel@mikelr.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cosmetics:

s/ioremap/ioremap()/ (also in commit log)
s/phys_to_virt/phys_to_virt()/ (also in commit log)
s/pci_platform_rom/pci_platform_rom()/ (commit log)
s/rom/ROM/

On Mon, Mar 02, 2020 at 10:34:55PM -0500, Mikel Rychliski wrote:
> On some EFI systems, the video BIOS is provided by the EFI firmware.  The
> boot stub code stores the physical address of the ROM image in pdev->rom.
> Currently we attempt to access this pointer using phys_to_virt, which
> doesn't work with CONFIG_HIGHMEM.
> 
> On these systems, attempting to load the radeon module on a x86_32 kernel
> can result in the following:
> 
>     BUG: unable to handle page fault for address: 3e8ed03c
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     *pde = 00000000
>     Oops: 0000 [#1] PREEMPT SMP
>     CPU: 0 PID: 317 Comm: systemd-udevd Not tainted 5.6.0-rc3-next-20200228 #2
>     Hardware name: Apple Computer, Inc. MacPro1,1/Mac-F4208DC8, BIOS     MP11.88Z.005C.B08.0707021221 07/02/07
>     EIP: radeon_get_bios+0x5ed/0xe50 [radeon]
>     Code: 00 00 84 c0 0f 85 12 fd ff ff c7 87 64 01 00 00 00 00 00 00 8b 47 08 8b 55 b0 e8 1e 83 e1 d6 85 c0 74 1a 8b 55 c0 85 d2 74 13 <80> 38 55 75 0e 80 78 01 aa 0f 84 a4 03 00 00 8d 74 26 00 68 dc 06
>     EAX: 3e8ed03c EBX: 00000000 ECX: 3e8ed03c EDX: 00010000
>     ESI: 00040000 EDI: eec04000 EBP: eef3fc60 ESP: eef3fbe0
>     DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010206
>     CR0: 80050033 CR2: 3e8ed03c CR3: 2ec77000 CR4: 000006d0
>     Call Trace:
>      ? register_client+0x34/0xe0
>      ? register_client+0xab/0xe0
>      r520_init+0x26/0x240 [radeon]
>      radeon_device_init+0x533/0xa50 [radeon]
>      radeon_driver_load_kms+0x80/0x220 [radeon]
>      drm_dev_register+0xa7/0x180 [drm]
>      radeon_pci_probe+0x10f/0x1a0 [radeon]
>      pci_device_probe+0xd4/0x140
>      really_probe+0x13d/0x3b0
>      driver_probe_device+0x56/0xd0
>      device_driver_attach+0x49/0x50
>      __driver_attach+0x79/0x130
>      ? device_driver_attach+0x50/0x50
>      bus_for_each_dev+0x5b/0xa0
>      driver_attach+0x19/0x20
>      ? device_driver_attach+0x50/0x50
>      bus_add_driver+0x117/0x1d0
>      ? pci_bus_num_vf+0x20/0x20
>      driver_register+0x66/0xb0
>      ? 0xf80f4000
>      __pci_register_driver+0x3d/0x40
>      radeon_init+0x82/0x1000 [radeon]
>      do_one_initcall+0x42/0x200
>      ? kvfree+0x25/0x30
>      ? __vunmap+0x206/0x230
>      ? kmem_cache_alloc_trace+0x16f/0x220
>      ? do_init_module+0x21/0x220
>      do_init_module+0x50/0x220
>      load_module+0x1f26/0x2200
>      sys_init_module+0x12d/0x160
>      do_fast_syscall_32+0x82/0x250
>      entry_SYSENTER_32+0xa5/0xf8
> 
> Fix the issue by using ioremap instead of phys_to_virt in pci_platform_rom.
> 
> Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
> ---
>  drivers/pci/rom.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index 137bf0cee897..e352798eed0c 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -197,8 +197,7 @@ void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom)
>  EXPORT_SYMBOL(pci_unmap_rom);
>  
>  /**
> - * pci_platform_rom - provides a pointer to any ROM image provided by the
> - * platform
> + * pci_platform_rom - ioremap the ROM image provided by the platform
>   * @pdev: pointer to pci device struct
>   * @size: pointer to receive size of pci window over ROM
>   */
> @@ -206,7 +205,7 @@ void __iomem *pci_platform_rom(struct pci_dev *pdev, size_t *size)
>  {
>  	if (pdev->rom && pdev->romlen) {
>  		*size = pdev->romlen;
> -		return phys_to_virt((phys_addr_t)pdev->rom);
> +		return ioremap(pdev->rom, pdev->romlen);

This changes the interface of pci_platform_rom() (the caller is now
responsible for doing an iounmap()).  That should be mentioned in the
function comment, and I think the subsequent patches should be
squashed into this one so the interface change and the caller changes
are done simultaneously.

Also, it looks like nvbios_platform.init() (platform_init()) needs a
similar change?

>  	}
>  
>  	return NULL;
> -- 
> 2.13.7
> 
