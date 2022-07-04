Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65561565E36
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 21:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiGDT5r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 15:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiGDT5q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 15:57:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C38E9FD4;
        Mon,  4 Jul 2022 12:57:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 609C9616A8;
        Mon,  4 Jul 2022 19:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D260C3411E;
        Mon,  4 Jul 2022 19:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656964664;
        bh=mGsydjzwJnInGMGOdSZO4PnNYkTf/KEoq5EP/11S7gg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KVKm0S+HGW7MTPJL4Z6Sv3XW+7iDbidNuZd/a4uVOXO5NGGezM2aZf7RsTzNM72kg
         8pdmADhty3NO/0UIODI0OnTege3uqnbX12OOF26hm8f8T7M+fa6pxLB9xkC2mhy8du
         rSPfSBUivuDkG2mmd2N06t/SNK2BBqDhGViK8QEBdoP3zaEFVJB6wkCFuvBf2nwy5V
         XHAUmq63PIubVUE71IGQ8dq/d97B0JrD2coVkbaqEFGC6ussi+gnSPYGeQ4JKaIgnY
         wu/9Jj7groqQzOxi6IZVAIl5T53oT/9ajT637Yb4iBOeQ7TVwZEXEbFIjlCWGHq491
         tGX2Wd6DyDwNw==
Date:   Mon, 4 Jul 2022 14:57:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Cal Peake <cp@absolutedigital.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Huacai Chen <chenhuacai@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] vgaarb: Add module param to allow for choosing the boot
 VGA device
Message-ID: <20220704195742.GA7975@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29b1e2e3-8954-2516-78f2-7e57cd5b976d@absolutedigital.net>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Mon, Jul 04, 2022 at 12:33:50AM -0400, Cal Peake wrote:
> My first attempt at solving this problem was based on a bit of a 
> misunderstanding of the code and, while it worked, could be much improved.

Can you outline the problem this solves in the commit log?

> This is a new attempt that creates the module parameter 'vgaarb.bootdev' 
> that can be passed a PCI ID (e.g. 0a:00.0) that the VGA arbiter will 
> attempt to use as the boot VGA device over any other eligible devices.
> 
> If the passed ID is invalid or is an ineligible device, the arbiter will 
> fallback to its normal method of trying to find the preferred device for 
> the job.
> 
> I've tested it thoroughly and it is working very well for me.
> 
> The patch is available below for review and, if found acceptable, can be 
> pulled via:
> 
>   git pull https://github.com/peake/linux.git vgaarb-2
> 
> -- 
> Cal Peake
> 
> Signed-off-by: Cal Peake <cp@absolutedigital.net>
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2522b11e593f..21ac87f4a8a9 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6518,6 +6518,13 @@
>  			This is actually a boot loader parameter; the value is
>  			passed to the kernel using a special protocol.
>  
> +	vgaarb.bootdev=	[PCI] Specify the PCI ID (e.g. 0e:00.0) of the
> +			device to use as the boot VGA device, overriding
> +			the heuristic used to normally determine which
> +			of the eligible VGA devices to use. If the device
> +			specified is not valid or not eligible, then we
> +			fallback to the heuristic.
> +
>  	vm_debug[=options]	[KNL] Available with CONFIG_DEBUG_VM=y.
>  			May slow down system boot speed, especially when
>  			enabled on systems with a large amount of memory.
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index f80b6ec88dc3..d3689b7dc63d 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -35,6 +35,34 @@
>  
>  #include <linux/vgaarb.h>
>  
> +static char *bootdev __initdata;
> +module_param(bootdev, charp, 0);
> +MODULE_PARM_DESC(bootdev, "Force boot device to the specified PCI ID");
> +
> +/*
> + * Initialize to the last possible ID to have things work as normal
> + * when no 'bootdev' option is supplied. We especially do not want
> + * this to be zero (0) since that is a valid PCI ID (00:00.0).
> + */
> +static u16 bootdev_id = 0xffff;
> +
> +static void __init parse_bootdev(char *input)
> +{
> +	unsigned int bus, dev, func;
> +	int ret;
> +
> +	if (input == NULL)
> +		return;
> +
> +	ret = sscanf(input, "%x:%x.%x", &bus, &dev, &func);
> +	if (ret != 3) {
> +		pr_warn("Improperly formatted PCI ID: %s\n", input);
> +		return;
> +	}
> +
> +	bootdev_id = PCI_DEVID(bus, PCI_DEVFN(dev, func));
> +}
> +
>  static void vga_arbiter_notify_clients(void);
>  /*
>   * We keep a list of all vga devices in the system to speed
> @@ -53,6 +81,7 @@ struct vga_device {
>  	bool bridge_has_one_vga;
>  	bool is_firmware_default;	/* device selected by firmware */
>  	unsigned int (*set_decode)(struct pci_dev *pdev, bool decode);
> +	bool is_chosen_one;		/* device specified on command line */
>  };
>  
>  static LIST_HEAD(vga_list);
> @@ -605,6 +634,7 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
>  
>  	/*
>  	 * We select the default VGA device in this order:
> +	 *   User specified device (see module param bootdev=)
>  	 *   Firmware framebuffer (see vga_arb_select_default_device())
>  	 *   Legacy VGA device (owns VGA_RSRC_LEGACY_MASK)
>  	 *   Non-legacy integrated device (see vga_arb_select_default_device())
> @@ -612,6 +642,14 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
>  	 *   Other device (see vga_arb_select_default_device())
>  	 */
>  
> +	if (boot_vga && boot_vga->is_chosen_one)
> +		return false;
> +
> +	if (bootdev_id == PCI_DEVID(pdev->bus->number, pdev->devfn)) {
> +		vgadev->is_chosen_one = true;
> +		return true;
> +	}
> +
>  	/*
>  	 * We always prefer a firmware default device, so if we've already
>  	 * found one, there's no need to consider vgadev.
> @@ -1544,6 +1582,8 @@ static int __init vga_arb_device_init(void)
>  	int rc;
>  	struct pci_dev *pdev;
>  
> +	parse_bootdev(bootdev);
> +
>  	rc = misc_register(&vga_arb_device);
>  	if (rc < 0)
>  		pr_err("error %d registering device\n", rc);
