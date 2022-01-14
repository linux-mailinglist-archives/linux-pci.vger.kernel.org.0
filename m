Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F93B48E966
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 12:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbiANLqT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jan 2022 06:46:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45640 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbiANLqT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jan 2022 06:46:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82651B825C8
        for <linux-pci@vger.kernel.org>; Fri, 14 Jan 2022 11:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA76EC36AE5;
        Fri, 14 Jan 2022 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642160777;
        bh=E5KqOMuIo5m9lLLXHofhxNr+MCSQxPJVCIxClOJgnfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=azZFqGe1DznPeyKjfO8KPukLIolNwk3xqmvWwb8OmFqhX0fPlLySO4Jit6F5f9qaH
         T607wgHQCLuvoLmsZ7iy1p90IqnRIsOV/fkOnqkecDZMUaLmJMM1eXrSXhadr+QR6/
         wTmGoN7Xj/xrcfoPQOr5CW+bkmk+lvHQml1k8JZTBEb/+9vnaicJfBqVyabMgo6jMb
         h1MIK2Toa/+1kQaS0I9Q1uYWq+7T/Q+IQoW5FfAMAZA/U3axL5M3U5Pq5uuTh1rxVd
         gHCzeEqZepbvNhSetlqXgebzbS9/MAehnq7S5OOsnswxV3/O61MHKrgJp/J1j1MXI7
         YpnHMfXlcI8sw==
Received: by pali.im (Postfix)
        id 173A17D1; Fri, 14 Jan 2022 12:46:14 +0100 (CET)
Date:   Fri, 14 Jan 2022 12:46:13 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v4 1/2] PCI/portdrv: Add option to setup IRQs for
 platform-specific Service Errors
Message-ID: <20220114114613.oymjnjsoqbx2uwjl@pali>
References: <20220114075834.1938409-1-sr@denx.de>
 <20220114075834.1938409-2-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220114075834.1938409-2-sr@denx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 14 January 2022 08:58:33 Stefan Roese wrote:
> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> 
> As per section 6.2.4.1.2, 6.2.6 in PCIe r4.0 (and later versions),
> platform-specific System Errors like AER can be delivered via platform-
> specific interrupt lines.
> 
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

Reviewed-by: Pali Rohár <pali@kernel.org>

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
> + *
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
> +	 */
> +	status = pcie_init_platform_service_irqs(dev, irqs, capabilities);
> +
> +	/*
> +	 * Only install service irqs, when the platform-specific hook was
> +	 * unsuccessful
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
