Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483EF3E8615
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 00:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhHJWdK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 18:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhHJWdK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 18:33:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FD2960F94;
        Tue, 10 Aug 2021 22:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628634767;
        bh=jBhUSswXbu7eqOIoOTNA6LTai3QKt3yxiCxd0AsaSVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UlmwruyWNcVqCzdrGmJPwoT3zO+oq3c4bN4e1EG0j8Ii782GwufWkNoeuTDL0xflB
         ibTEtBFLr0igVxyV7HL8hPn+SCaP1x3th5gqtBsam28jRK9tdNeL2wovy8u/qrpKWL
         +3ON1m8q99OGqedxcga0dnuz8NVYmecq+yg2bUs024Ngg71HgXSIe9W4JRi++hh349
         SIt0uQxYWMXOgIAKY+5YfI8XqoxtksF9hr0fyuWl6G698LuWhGbGg24ZrDtltwIF1q
         ryYvHMuiPy/tBFJDq/n+5m6kmjByrUKxp9FT2Oz6rL/iywuYUqYIv5Nhwdvs3r7oD4
         GosihRIA4TfYw==
Date:   Tue, 10 Aug 2021 17:32:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     tsbogend@alpha.franken.de, bhelgaas@google.com,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: of: avoid 'devm_pci_remap_iospace' if
 PCI_IOBASE is not defined
Message-ID: <20210810223245.GA2311409@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807072409.9018-3-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 07, 2021 at 09:24:08AM +0200, Sergio Paracuellos wrote:
> Defining PCI_IOBASE for MIPS ralink in expected addresses results in PCI IO
> resources being assigned but the addresses generated for IO accesses are wrong
> since the ioremap in the PCI core function 'pci_parse_request_of_pci_ranges'
> tries to remap to a fixed virtual address (PC_IOBASE) which can't work for KSEG1
> addresses. To get it working this way, we would need to put PCI_IOBASE somewhere
> into KSEG2 which will result in creating TLB entries for IO addresses, which most
> of the time isn't needed on MIPS because of access via KSEG1. To allow MIPS PCI
> drivers to properly use the PCI generic core we need to increase IO_SPACE_LIMIT
> since IO addresses are in addresses higher that 0xffff. We also need to avoid
> the call 'devm_pci_remap_iospace' when 'pci_parse_request_of_pci_ranges' is
> called to avoid the following problem:

Rewrap to fit in ~75 columns.

This is a generic change so the commit log needs to be generic as
well.  The MIPS/KSEG1/KSEG2 information is not really useful here
because most readers won't understand it (and I don't :)).

devm_pci_remap_iospace() calls pci_remap_iospace(), which already
contains #ifdef PCI_IOBASE.  When PCI_IOBASE is not defined (as on 
MIPS ralink), it emits the warning below and returns failure.

This patch avoids that failure, but it still leaves
devm_pci_remap_iospace() and pci_remap_iospace() broken on MIPS
ralink.  It's true that on MIPS ralink, they are currently only called
via pci_parse_request_of_pci_ranges(), but I think it would be better
if we could fix pci_remap_iospace() to handle this case so all these
interfaces work consistently.

This patch doesn't do anything with IO_SPACE_LIMIT, so I don't know
what that part of the commit log is telling me.

> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 1 at ../drivers/pci/pci.c:4066 pci_remap_iospace+0x3c/0x54
> This architecture does not support memory mapped I/O
> Modules linked in:
> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.10.1+ #1228
> Stack : 00000000 00000000 807fa974 00000000 827ffa80 80066b48 80710000 0000000b
>         00000000 00000000 81c59aac 7d06ddec 80850000 00000001 81c59a40 7d06ddec
>         00000000 00000000 807c909c 81c598f0 00000001 81c59904 00000000 0000000a
>         203a6d6d 80708880 0000000f 70617773 80850000 00000000 00000000 807d0000
>         807ffecc 1e160000 00000001 00000200 00000000 8054e920 00000008 815e0008
>         ...
> Call Trace:
> [<80008efc>] show_stack+0x8c/0x130
> [<806e1674>] dump_stack+0x9c/0xc8
> [<80024a3c>] __warn+0xc0/0xe8
> [<80024ad0>] warn_slowpath_fmt+0x6c/0xbc
> [<80410ca8>] pci_remap_iospace+0x3c/0x54
> [<80410d20>] devm_pci_remap_iospace+0x58/0xa4
> [<8042019c>] devm_of_pci_bridge_init+0x4dc/0x55c
> [<80408de8>] devm_pci_alloc_host_bridge+0x78/0x88
> [<80424e44>] mt7621_pci_probe+0x68/0x9a4
> [<80464804>] platform_drv_probe+0x40/0x7c
> [<804628bc>] really_probe+0x2fc/0x4e4
> [<80463214>] device_driver_attach+0x4c/0x74
> [<80463384>] __driver_attach+0x148/0x150
> [<8046047c>] bus_for_each_dev+0x6c/0xb0
> [<804614dc>] bus_add_driver+0x1b4/0x1fc
> [<80463aa0>] driver_register+0xd0/0x110
> [<80001714>] do_one_initcall+0x84/0x1c0
> [<808e7fd0>] kernel_init_freeable+0x214/0x24c
> [<806e4164>] kernel_init+0x14/0x118
> [<80003358>] ret_from_kernel_thread+0x14/0x1c
> 
> ---[ end trace 1c9d4412bd51b53c ]---
> mt7621-pci 1e140000.pcie: error -19: failed to map resource [io  0x1e160000-0x1e16ffff]
> 
> Hence don't call 'devm_pci_remap_iospace' if PCI_IOBASE is not defined to get
> a working PCI core APIs for MIPS ralink platforms.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/pci/of.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index a143b02b2dcd..657aef39bf63 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -564,12 +564,14 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>  
>  		switch (resource_type(res)) {
>  		case IORESOURCE_IO:
> +#ifdef PCI_IOBASE
>  			err = devm_pci_remap_iospace(dev, res, iobase);
>  			if (err) {
>  				dev_warn(dev, "error %d: failed to map resource %pR\n",
>  					 err, res);
>  				resource_list_destroy_entry(win);
>  			}
> +#endif
>  			break;
>  		case IORESOURCE_MEM:
>  			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> -- 
> 2.25.1
> 
