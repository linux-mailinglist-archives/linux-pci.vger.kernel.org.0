Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F7053694B
	for <lists+linux-pci@lfdr.de>; Sat, 28 May 2022 02:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiE1AJs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 20:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiE1AJs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 20:09:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7B52AE1B
        for <linux-pci@vger.kernel.org>; Fri, 27 May 2022 17:09:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C220561AD2
        for <linux-pci@vger.kernel.org>; Sat, 28 May 2022 00:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D254DC34113;
        Sat, 28 May 2022 00:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653696586;
        bh=t7pTxPx10FhT5p+43S9H1pAFsE9VLysi2oTLH93k7tQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RVprLcVx+EUPGoqZXMX16ESlf2pDNhULRiw8NHRSsypnSyhPRu1gTfXVWSsYKQQ6N
         eerhH+bwpLSVrPpS+EtAgHsN/7xl+ACTm+3dkhVewo9gg4I0yKiW9qgQ3cDHmEoniG
         TcQbjFVEZtbGIziD484glZuU4+j7ti/4FWKtQw3WuzHyA7N+Dfn0xWb/EyEXqML0sH
         qiEEac0yUMbbFCnh9ex4t5fJ3q+3v1h02FKIoej7UCK+4IZY5NJz2uQYcsjlgw3VRB
         rUMCl/bPVA1ecSxH+/XaYK4j7ruTjyCr1LaCflCVbU/5zaxy4+/EtdC+OIC8FF4MCU
         4AqaQi+6kxKlg==
Date:   Fri, 27 May 2022 19:09:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v4 1/2] PCI/portdrv: Add option to setup IRQs for
 platform-specific Service Errors
Message-ID: <20220528000943.GA518055@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220114075834.1938409-2-sr@denx.de>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject line, I assume you mean "System Errors" instead of "Service
Errors"?

On Fri, Jan 14, 2022 at 08:58:33AM +0100, Stefan Roese wrote:
> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> 
> As per section 6.2.4.1.2, 6.2.6 in PCIe r4.0 (and later versions),
> platform-specific System Errors like AER can be delivered via platform-
> specific interrupt lines.

IIUC, this refers to the top left branch in Figure 6-3 of PCIe r6.0,
sec 6.2.6, which shows "System Error (platform specific)" controlled
by "System Error Enables (one per error class) in the Root Control
register," i.e., the PCI_EXP_RTCTL_SECEE, PCI_EXP_RTCTL_SENFEE, and
PCI_EXP_RTCTL_SEFEE bits.

Where are those enable bits set?  The only references I see are to
them being cleared via SYSTEM_ERROR_INTR_ON_MESG_MASK in
aer_enable_rootport().

> This patch adds the init_platform_service_irqs() hook to struct
> pci_host_bridge, making it possible that platforms may implement this
> function to hook IRQs for these platform-specific System Errors, like
> AER.
> 
> If these platform-specific service IRQs have been successfully
> installed via pcie_init_platform_service_irqs(),
> pcie_init_service_irqs() is skipped.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/pci/pcie/portdrv_core.c | 39 ++++++++++++++++++++++++++++++++-
>  include/linux/pci.h             |  2 ++
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e7dcb1f23210..27b990cedb4c 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -190,6 +190,31 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  	return 0;
>  }
>  
> +/**
> + * pcie_init_platform_service_irqs - initialize platform service irqs for
> + * platform-specific System Errors
> + * @dev: PCI Express port to handle
> + * @irqs: Array of irqs to populate
> + * @mask: Bitmask of capabilities

s/irqs/IRQs/ above (twice) for consistency.

> + * Return value: -ENODEV, in case no platform-specific IRQ is available
> + */
> +static int pcie_init_platform_service_irqs(struct pci_dev *dev,
> +					   int *irqs, int mask)
> +{
> +	struct pci_host_bridge *bridge;
> +
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> +		bridge = pci_find_host_bridge(dev->bus);
> +		if (bridge && bridge->init_platform_service_irqs) {
> +			return bridge->init_platform_service_irqs(dev, irqs,
> +								  mask);
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
>  /**
>   * get_port_device_capability - discover capabilities of a PCI Express port
>   * @dev: PCI Express port to examine
> @@ -335,7 +360,19 @@ int pcie_port_device_register(struct pci_dev *dev)
>  		irq_services |= PCIE_PORT_SERVICE_DPC;
>  	irq_services &= capabilities;
>  
> -	if (irq_services) {
> +	/*
> +	 * Some platforms have dedicated interrupts from root complex to
> +	 * interrupt controller for PCIe platform-specific System Errors
> +	 * like AER/PME etc., check if the platform registered with any such
> +	 * IRQ.

I don't see "PME etc" mentioned in the spec sections you cite.
6.2.4.1.2 and 6.2.6 only cover interrupts in response to error
Messages.  Are there other sections that cover PME and whatever other
interrupts you have in mind?

6.7.3.4 ("Software Notification of Hot-Plug Events") talks about PME
and Hot-Plug Event interrupts, but these aren't errors, and I only see
signaling via INTx, MSI, or MSI-X.  Is there provision for a different
method?

> +	 */
> +	status = pcie_init_platform_service_irqs(dev, irqs, capabilities);
> +
> +	/*
> +	 * Only install service irqs, when the platform-specific hook was
> +	 * unsuccessful

s/irqs/IRQs/ again.

> +	 */
> +	if (irq_services && status) {
>  		/*
>  		 * Initialize service IRQs. Don't use service devices that
>  		 * require interrupts if there is no way to generate them.
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 18a75c8e615c..fb8aad3cb460 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -554,6 +554,8 @@ struct pci_host_bridge {
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>  	void (*release_fn)(struct pci_host_bridge *);
> +	int (*init_platform_service_irqs)(struct pci_dev *dev, int *irqs,
> +					  int plat_mask);
>  	void		*release_data;
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> -- 
> 2.34.1
> 
