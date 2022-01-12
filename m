Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845D348C256
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 11:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352549AbiALKeL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 05:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbiALKeJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 05:34:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9169DC06173F
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 02:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ABAEB81E9C
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 10:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7466C36AEC;
        Wed, 12 Jan 2022 10:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641983645;
        bh=/CNNqGx8TNUq8NmnVD7XIpIIUdpJOYA4deWpi7CtkOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XyZ0jGWl2CYAlkJV5AMpReUL9JmUlIHN1ZoQ741eV5wqdtskRu2eRXZjO9Ah6N78s
         EWlMqrQM3W9GdTZ9BjM3VMeSc8jDZPsizm2jMsPlYuVd+Si5e55fXH1923aCRNvnzQ
         yCBmQp/z/vhrfvRe/fYJuGVttl4vvcluTnSYolBqztKR69El6BMy8/xHCPwKReRmPY
         JqptZj6muqk7bDQy5d4DmnDgU4xyOICPUzGtizPzGcSMateRh/ZJvXXtteYH+0eh5g
         T49r7JLjckiRplM5IaKucLU8kgjZaLPs42r68k9RdW3YSzDsEW7WzDgGIzLVIR0Buk
         cxZounP7C2Ozg==
Received: by pali.im (Postfix)
        id B9BCD768; Wed, 12 Jan 2022 11:34:02 +0100 (CET)
Date:   Wed, 12 Jan 2022 11:34:02 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RESEND PATCH v2 3/4] PCI/portdrv: Check platform supported
 service IRQ's
Message-ID: <20220112103402.ldeqff3dlxi2azgn@pali>
References: <20220112094251.1271531-1-sr@denx.de>
 <20220112094251.1271531-3-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112094251.1271531-3-sr@denx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 12 January 2022 10:42:50 Stefan Roese wrote:
> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> 
> Platforms may have dedicated IRQ lines for PCIe services like
> AER/PME etc., check for such IRQ lines.
> Check if platform has any dedicated IRQ lines for PCIe
> services.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Tested-by: Stefan Roese <sr@denx.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/pci/pcie/portdrv_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index bda630889f95..70dd45671ed8 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -358,6 +358,14 @@ int pcie_port_device_register(struct pci_dev *dev)
>  		}
>  	}
>  
> +	/*
> +	 * Some platforms have dedicated interrupt line from root complex to
> +	 * interrupt controller for PCIe services like AER/PME etc., check
> +	 * if platform registered with any such IRQ.
> +	 */
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +		pci_check_platform_service_irqs(dev, irqs, capabilities);
> +

In my opinion calling this hook at this stage is too late. Few lines
above is following code:

	if (irq_services) {
		/*
		 * Initialize service IRQs. Don't use service devices that
		 * require interrupts if there is no way to generate them.
		 * However, some drivers may have a polling mode (e.g.
		 * pciehp_poll_mode) that can be used in the absence of IRQs.
		 * Allow them to determine if that is to be used.
		 */
		status = pcie_init_service_irqs(dev, irqs, irq_services);
		if (status) {
			irq_services &= PCIE_PORT_SERVICE_HP;
			if (!irq_services)
				goto error_disable;
		}
	}

Function pcie_init_service_irqs() fails if "dev" does not have any
suitable interrupt. Which happens for devices / root ports without
support for standard interrupts (INTx / MSI).

I think that this new hook should have preference over
pcie_init_service_irqs() and after this new hook should be
pcie_init_service_irqs() called only for irq_services which new hook has
not filled. And if at least new hook or pcie_init_service_irqs() passes
then "error_disable" path should not be called.

>  	/* Allocate child services if any */
>  	status = -ENODEV;
>  	nr_service = 0;
> -- 
> 2.34.1
> 
