Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BC631E30A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Feb 2021 00:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhBQXdA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Feb 2021 18:33:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232120AbhBQXc7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Feb 2021 18:32:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6084C600EF;
        Wed, 17 Feb 2021 23:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613604738;
        bh=xr9Psu8shUX6MrhNK7Dr8wXIVyvf+IrCamxrpwOQW/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QaHR5I0XO73Ikb3v5nZ0vwVyxs5fLYIK29epplaUB3jKbSbc5hVQ9DcBCV1OzRIiP
         lg1+7dsIYdz5PXIrYrrBjX4mb6c0f5hIQ+/FGIhfcNgXCFFfciYd29tLZ0NAVk6wPI
         1A7PxQcUCduGkvZJk0f0lXvxBy7EPl85f/qRAWbuzSRa4EsURkSw1bR1BI5efpc1mt
         HI2QVZqKwvSOtCHxmgkeKIpsUmcDUZL+c8c+m+JzNICc7UyvHvraXVjj8qk5EB22Yy
         Q/uuHitGLZcgv4PdJ7mfxnH4dYTAF3CCKRWu9m3l9aoUKvsezPuAqxSDRoj5sCOEk8
         FwbtByEXdfv1A==
Date:   Wed, 17 Feb 2021 17:32:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix memory leak in pci_register_io_range()
Message-ID: <20210217233216.GA924417@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202100332.829047-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 02, 2021 at 11:03:32AM +0100, Geert Uytterhoeven wrote:
> Kmemleak reports:
> 
>     unreferenced object 0xc328de40 (size 64):
>       comm "kworker/1:1", pid 21, jiffies 4294938212 (age 1484.670s)
>       hex dump (first 32 bytes):
>         00 00 00 00 00 00 00 00 e0 d8 fc eb 00 00 00 00  ................
>         00 00 10 fe 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 
>     backtrace:
>       [<ad758d10>] pci_register_io_range+0x3c/0x80
>       [<2c7f139e>] of_pci_range_to_resource+0x48/0xc0
>       [<f079ecc8>] devm_of_pci_get_host_bridge_resources.constprop.0+0x2ac/0x3ac
>       [<e999753b>] devm_of_pci_bridge_init+0x60/0x1b8
>       [<a895b229>] devm_pci_alloc_host_bridge+0x54/0x64
>       [<e451ddb0>] rcar_pcie_probe+0x2c/0x644
> 
> In case a PCI host driver's probe is deferred, the same I/O range may be
> allocated again, and be ignored, causing a memory leak.
> 
> Fix this by (a) letting logic_pio_register_range() return -EEXIST if the
> passed range already exists, so pci_register_io_range() will free it,
> and by (b) making pci_register_io_range() not consider -EEXIST an error
> condition.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to pci/enumeration for v5.12, thanks!

> ---
>  drivers/pci/pci.c | 4 ++++
>  lib/logic_pio.c   | 3 +++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 09b03cfba8894955..c651003e304a2b71 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4037,6 +4037,10 @@ int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
>  	ret = logic_pio_register_range(range);
>  	if (ret)
>  		kfree(range);
> +
> +	/* Ignore duplicates due to deferred probing */
> +	if (ret == -EEXIST)
> +		ret = 0;
>  #endif
>  
>  	return ret;
> diff --git a/lib/logic_pio.c b/lib/logic_pio.c
> index f32fe481b4922bc1..07b4b9a1f54b6bf5 100644
> --- a/lib/logic_pio.c
> +++ b/lib/logic_pio.c
> @@ -28,6 +28,8 @@ static DEFINE_MUTEX(io_range_mutex);
>   * @new_range: pointer to the IO range to be registered.
>   *
>   * Returns 0 on success, the error code in case of failure.
> + * If the range already exists, -EEXIST will be returned, which should be
> + * considered a success.
>   *
>   * Register a new IO range node in the IO range list.
>   */
> @@ -51,6 +53,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>  	list_for_each_entry(range, &io_range_list, list) {
>  		if (range->fwnode == new_range->fwnode) {
>  			/* range already there */
> +			ret = -EEXIST;
>  			goto end_register;
>  		}
>  		if (range->flags == LOGIC_PIO_CPU_MMIO &&
> -- 
> 2.25.1
> 
