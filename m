Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8638B65DC46
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 19:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjADSha (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 13:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbjADShQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 13:37:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E64B17586
        for <linux-pci@vger.kernel.org>; Wed,  4 Jan 2023 10:37:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D69D6179B
        for <linux-pci@vger.kernel.org>; Wed,  4 Jan 2023 18:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B499AC433D2;
        Wed,  4 Jan 2023 18:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672857433;
        bh=jAONJ/f1eWzUbzgGUucqc+fiVdwEoDGW61smw/EspQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KvgqCusNBdHKC0uIMZsWXjwHJn9r0sdbfLLYtWKkvlBRLXPfJn65vxq33x5gu/EDF
         IMZuUb+e/d2P/Cyosa3ssjrxgkXQUvyUK2fARtwqvS7Gx1aL/97KFZku6vpA6t2FPN
         tyBWdlUFGzx6/UnYtYDMwrQcxNss4gOP92OAUjEhkhn0BoGGlYABr9iFgzIguY7T0m
         rTfpKMGhX+gl70S80FsLe89vPQQJWTRpolZNwZt+dfGAsE7dANJZeMygJbR1oegu8C
         8TMh0I6pUCB/S5a5KrmeeRur9+yylNPnpZe6XxeKySxiiCbtYFZiVhfCgF8vkDQodI
         8wsDpUUlfef5Q==
Date:   Wed, 4 Jan 2023 12:37:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 2/2] PCI: Add quirk for LS7A to avoid reboot failure
Message-ID: <20230104183712.GA1082132@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103073401.1256736-3-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 03, 2023 at 03:34:01PM +0800, Huacai Chen wrote:
> cc27b735ad3a7557 ("PCI/portdrv: Turn off PCIe services during shutdown")
> causes poweroff/reboot failure on systems with LS7A chipset. We found
> that if we remove "pci_command &= ~PCI_COMMAND_MASTER" in do_pci_disable
> _device(), it can work well. The hardware engineer says that the root
> cause is that CPU is still accessing PCIe devices while poweroff/reboot,

Did you ever figure out what these CPU accesses are?  If we call the
Root Port .shutdown() method, and later access a downstream device,
that seems like a problem in itself.  At least, we should understand
exactly *why* we access that downstream device.

To be clear, cc27b735ad3a does not cause the failure.  IIUC, the cause
is:

  - CPU issues MMIO read to device below Root Port

  - LS7A Root Port fails to forward transaction to secondary bus
    because of LS7A Bus Master defect

  - CPU hangs waiting for response to MMIO read

> and if we disable the Bus Master Bit at this time, the PCIe controller
> doesn't forward requests to downstream devices, and also does not send
> TIMEOUT to CPU, which causes CPU wait forever (hardware deadlock). This
> behavior is a PCIe protocol violation (Bus Master should not be involved
> in CPU MMIO transactions), and it will be fixed in new revisions of
> hardware (add timeout mechanism for CPU read request, whether or not Bus
> Master bit is cleared).
> 
> On some x86 platforms, radeon/amdgpu devices can cause similar problems
> [1][2]. Once before I wanted to make a single patch to solve "all of
> these problems" together, but it seems unreasonable because maybe they
> are not exactly the same problem.

I don't know what any of these problems are.  Neither one of these bug
reports has a root cause analysis, and it's not obvious how they're
connected to this patch.

> So, this patch add a new function
> pcie_portdrv_shutdown(), a slight modified copy of pcie_portdrv_remove()
> dedicated for the shutdown path, and then add a quirk just for LS7A to
> avoid clearing Bus Master bit in pcie_portdrv_shutdown(). Leave other
> platforms behave as before.

Nit: don't break function names across lines ("do_pci_disable_device()").

> [1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
> [2] https://bugs.freedesktop.org/show_bug.cgi?id=98638
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/controller/pci-loongson.c | 17 +++++++++++++++++
>  drivers/pci/pcie/portdrv.c            | 21 +++++++++++++++++++--
>  include/linux/pci.h                   |  1 +
>  3 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 759ec211c17b..641308ba4126 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -93,6 +93,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  			DEV_PCIE_PORT_2, loongson_mrrs_quirk);
>  
> +static void loongson_bmaster_quirk(struct pci_dev *pdev)
> +{
> +	/*
> +	 * Some Loongson PCIe ports will cause CPU deadlock if disable
> +	 * the Bus Master bit during poweroff/reboot.

This is not actually true, as far as I can see.

It's not turning off Bus Master that causes the problem; it's the MMIO
read to a downstream device when the Root Port has bus mastering
disabled that causes the problem.

> +	 */
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> +
> +	bridge->no_dis_bmaster = 1;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_0, loongson_bmaster_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_1, loongson_bmaster_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_2, loongson_bmaster_quirk);
> +
>  static void loongson_pci_pin_quirk(struct pci_dev *pdev)
>  {
>  	pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 2cc2e60bcb39..96f45c444422 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -501,7 +501,6 @@ static void pcie_port_device_remove(struct pci_dev *dev)
>  {
>  	device_for_each_child(&dev->dev, NULL, remove_iter);
>  	pci_free_irq_vectors(dev);
> -	pci_disable_device(dev);
>  }
>  
>  /**
> @@ -727,6 +726,24 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>  	}
>  
>  	pcie_port_device_remove(dev);
> +
> +	pci_disable_device(dev);
> +}
> +
> +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> +
> +	if (pci_bridge_d3_possible(dev)) {
> +		pm_runtime_forbid(&dev->dev);
> +		pm_runtime_get_noresume(&dev->dev);
> +		pm_runtime_dont_use_autosuspend(&dev->dev);
> +	}
> +
> +	pcie_port_device_remove(dev);
> +
> +	if (!bridge->no_dis_bmaster)
> +		pci_disable_device(dev);
>  }
>  
>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> @@ -777,7 +794,7 @@ static struct pci_driver pcie_portdriver = {
>  
>  	.probe		= pcie_portdrv_probe,
>  	.remove		= pcie_portdrv_remove,
> -	.shutdown	= pcie_portdrv_remove,
> +	.shutdown	= pcie_portdrv_shutdown,
>  
>  	.err_handler	= &pcie_portdrv_err_handler,
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3df2049ec4a8..a64dbcb89231 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -573,6 +573,7 @@ struct pci_host_bridge {
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
>  	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
> +	unsigned int	no_dis_bmaster:1;	/* No Disable Bus Master */
>  	unsigned int	native_aer:1;		/* OS may use PCIe AER */
>  	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
>  	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
> -- 
> 2.31.1
> 
