Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB24539A14
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 01:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241658AbiEaXfc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 19:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbiEaXfc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 19:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D3A996B9
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 16:35:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B3F66149C
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 23:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D80C385A9;
        Tue, 31 May 2022 23:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654040129;
        bh=0KRbl/K/ZtnWdJWFGAC31TEMCkosU75MaFVJhjlBWKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QXJ9rZytjEFBRf0b+CuDR1088xkJAt4oDXPbhtDxapSTUBC56LiCn4G7p0jX6ldQk
         Il6Y6PLSxUfZWSAfreLFFE8lVxoOJFq5zHA4lUoXm9MzcFjqHvRAcaZqJVFrUczypf
         RVFU0cMbHoYYh7btJxO9/HWstHQabdPvjtyGhBbOI7I5oRNrC7xxMR9f1re0EyJUVH
         Zhi977TRhfQY1D5a7XANO0IhkjJ3AcZ9k8u4Ir2+KxYn8Om2XmliVIbsGuZez70GtT
         iAkjJb1p+kj3/8tYhkxSNRvk6ckAKh9smPv3ja+lb78Il47Er6NM8/7PmYMrG0o6Mz
         T3kD/wWzvYlvQ==
Date:   Tue, 31 May 2022 18:35:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V13 5/6] PCI: Add quirk for LS7A to avoid reboot failure
Message-ID: <20220531233527.GA797502@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430084846.3127041-6-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 30, 2022 at 04:48:45PM +0800, Huacai Chen wrote:
> Commit cc27b735ad3a75574a ("PCI/portdrv: Turn off PCIe services during
> shutdown") 

Usual quoting style would be 

  cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
  causes poweroff/reboot ...

> causes poweroff/reboot failure on systems with LS7A chipset.
> We found that if we remove "pci_command &= ~PCI_COMMAND_MASTER;" in
> do_pci_disable_device(), it can work well. The hardware engineer says
> that the root cause is that CPU is still accessing PCIe devices while
> poweroff/reboot, and if we disable the Bus Master Bit at this time, the
> PCIe controller doesn't forward requests to downstream devices, and also
> doesn't send TIMEOUT to CPU, which causes CPU wait forever (hardware
> deadlock). This behavior is a PCIe protocol violation (Bus Master should
> not be involved in CPU MMIO transactions), and it will be fixed in new
> revisions of hardware (add timeout mechanism for CPU read request,
> whether or not Bus Master bit is cleared).

LS7A might have bugs in that clearing Bus Master Enable prevents the
root port from forwarding Memory or I/O requests in the downstream
direction.

But this feels like a bit of a band-aid because we don't know exactly
what those requests are.  If we're removing the Root Port, I assume we
think we no longer need any devices *below* the Root Port.

If that's not the case, e.g., if we still need to produce console
output or save state to a device, we probably should not be removing
the Root Port at all.

> On some x86 platforms, radeon/amdgpu devices can cause similar problems
> [1][2]. Once before I wanted to make a single patch to solve "all of
> these problems" together, but it seems unreasonable because maybe they
> are not exactly the same problem. So, this patch just add a quirk for
> LS7A to avoid clearing Bus Master bit in pcie_port_device_remove(), and
> leave other platforms as is.
> 
> [1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
> [2] https://bugs.freedesktop.org/show_bug.cgi?id=98638
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/controller/pci-loongson.c | 17 +++++++++++++++++
>  drivers/pci/pcie/portdrv_core.c       |  6 +++++-
>  include/linux/pci.h                   |  1 +
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 83447264048a..49d8b8c24ffb 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -85,6 +85,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  			DEV_PCIE_PORT_2, loongson_mrrs_quirk);
>  
> +static void loongson_bmaster_quirk(struct pci_dev *pdev)
> +{
> +	/*
> +	 * Some Loongson PCIe ports will cause CPU deadlock if disable
> +	 * the Bus Master bit during poweroff/reboot.
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
>  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>  {
>  	struct pci_config_window *cfg;
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 604feeb84ee4..23f41e31a6c6 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -491,9 +491,13 @@ EXPORT_SYMBOL_GPL(pcie_port_find_device);
>   */
>  void pcie_port_device_remove(struct pci_dev *dev)
>  {
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> +
>  	device_for_each_child(&dev->dev, NULL, remove_iter);
>  	pci_free_irq_vectors(dev);
> -	pci_disable_device(dev);
> +
> +	if (!bridge->no_dis_bmaster)
> +		pci_disable_device(dev);
>  }
>  
>  /**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d146eb28e6da..c52d6486ff99 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -570,6 +570,7 @@ struct pci_host_bridge {
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
>  	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
> +	unsigned int	no_dis_bmaster:1;	/* No Disable Bus Master */
>  	unsigned int	native_aer:1;		/* OS may use PCIe AER */
>  	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
>  	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
> -- 
> 2.27.0
> 
