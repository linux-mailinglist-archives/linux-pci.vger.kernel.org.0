Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644ABAC7C5
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2019 18:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406112AbfIGQ4C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Sep 2019 12:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404220AbfIGQ4B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 7 Sep 2019 12:56:01 -0400
Received: from localhost (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B7D621835;
        Sat,  7 Sep 2019 16:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567875361;
        bh=5PQmXyEjUUF9AxHPZrmaDK+7Anvek9rSUaMyf2vAAsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8+E1rWZ6+p1rC5cNfdF0gzTPrfPY/b/PdoQFtV1KnB2A75o/gvBXgEtPHiF3VkSK
         x42otI3HH0sIhmJGy8Y/AbmxIFHe7QW7nFVDInpIXg4+k/vMCJ/0gLq9S1LCck+FWA
         wHiGCDqrbHDUvpDgiRZm0i72PAXxRwgS5X1hjYYo=
Date:   Sat, 7 Sep 2019 11:55:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andrew.murray@arm.com, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, alisaidi@amazon.com, ronenk@amazon.com,
        barakw@amazon.com, talel@amazon.com, hanochu@amazon.com,
        hhhawa@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/7] PCI: dwc: al: Add support for DW based driver type
Message-ID: <20190907165557.GO103977@google.com>
References: <20190905140018.5139-1-jonnyc@amazon.com>
 <20190905140144.7933-2-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905140144.7933-2-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/Add support for DW based driver type/Add Amazon Annapurna Labs PCIe controller driver/

On Thu, Sep 05, 2019 at 05:01:43PM +0300, Jonathan Chocron wrote:
> This driver is DT based and utilizes the DesignWare APIs.
> 
> It allows using a smaller ECAM range for a larger bus range -
> usually an entire bus uses 1MB of address space, but the driver
> can use it for a larger number of buses. This is achieved by using a HW
> mechanism which allows changing the BUS part of the "final" outgoing
> config transaction. There are 2 HW regs, one which is basically a
> bitmask determining which bits to take from the AXI transaction itself
> and another which holds the complementary part programmed by the
> driver.
> 
> All link initializations are handled by the boot FW.
> 
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  drivers/pci/controller/dwc/Kconfig   |  12 +
>  drivers/pci/controller/dwc/pcie-al.c | 365 +++++++++++++++++++++++++++
>  2 files changed, 377 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 4fada2e93285..0ba988b5b5bc 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -256,4 +256,16 @@ config PCIE_UNIPHIER
>  	  Say Y here if you want PCIe controller support on UniPhier SoCs.
>  	  This driver supports LD20 and PXs3 SoCs.
>  
> +config PCIE_AL
> +	bool "Amazon Annapurna Labs PCIe controller"
> +	depends on OF && (ARM64 || COMPILE_TEST)
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here to enable support of the Amazon's Annapurna Labs PCIe
> +	  controller IP on Amazon SoCs. The PCIe controller uses the DesignWare
> +	  core plus Annapurna Labs proprietary hardware wrappers. This is
> +	  required only for DT-based platforms. ACPI platforms with the
> +	  Annapurna Labs PCIe controller don't need to enable this.

Interesting.  How do you deal with the funky ECAM space on ACPI
platforms?  Oh, never mind, I see, it's the pcie-al.c ECAM ops quirk
that's already in the tree.

Bjorn
