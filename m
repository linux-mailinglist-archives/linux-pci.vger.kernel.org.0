Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01103F2E57
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 16:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbhHTOqP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 10:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240913AbhHTOqO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Aug 2021 10:46:14 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B24C061575
        for <linux-pci@vger.kernel.org>; Fri, 20 Aug 2021 07:45:34 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id EA76410325458;
        Fri, 20 Aug 2021 16:45:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BC7314A5F7; Fri, 20 Aug 2021 16:45:32 +0200 (CEST)
Date:   Fri, 20 Aug 2021 16:45:32 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Do not setup up IRQs if there are no users
Message-ID: <20210820144532.GA25391@wunner.de>
References: <43e1591d-51ed-39fa-3bc5-c11777f27b62@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e1591d-51ed-39fa-3bc5-c11777f27b62@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 20, 2021 at 03:52:18PM +0200, Jan Kiszka wrote:
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -312,7 +312,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
>   */
>  int pcie_port_device_register(struct pci_dev *dev)
>  {
> -	int status, capabilities, i, nr_service;
> +	int status, capabilities, irq_services, i, nr_service;
>  	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
>  
>  	/* Enable PCI Express port device */
> @@ -326,18 +326,32 @@ int pcie_port_device_register(struct pci_dev *dev)
>  		return 0;
>  
>  	pci_set_master(dev);
> -	/*
> -	 * Initialize service irqs. Don't use service devices that
> -	 * require interrupts if there is no way to generate them.
> -	 * However, some drivers may have a polling mode (e.g. pciehp_poll_mode)
> -	 * that can be used in the absence of irqs.  Allow them to determine
> -	 * if that is to be used.
> -	 */
> -	status = pcie_init_service_irqs(dev, irqs, capabilities);
> -	if (status) {
> -		capabilities &= PCIE_PORT_SERVICE_HP;
> -		if (!capabilities)
> -			goto error_disable;
> +
> +	irq_services = 0;
> +	if (IS_ENABLED(CONFIG_PCIE_PME))
> +		irq_services |= PCIE_PORT_SERVICE_PME;
> +	if (IS_ENABLED(CONFIG_PCIEAER))
> +		irq_services |= PCIE_PORT_SERVICE_AER;
> +	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> +		irq_services |= PCIE_PORT_SERVICE_HP;
> +	if (IS_ENABLED(CONFIG_PCIE_DPC))
> +		irq_services |= PCIE_PORT_SERVICE_DPC;
> +	irq_services &= capabilities;

get_port_device_capability() would seem like a more natural place
to put these checks.

Note that your check for CONFIG_PCIEAER is superfluous due to
the "#ifdef CONFIG_PCIEAER" in get_port_device_capability().

Thanks,

Lukas
