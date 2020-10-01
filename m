Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4516A27FE38
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 13:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbgJALRh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 07:17:37 -0400
Received: from foss.arm.com ([217.140.110.172]:59532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731243AbgJALRh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 07:17:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DEC130E;
        Thu,  1 Oct 2020 04:17:36 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B2A53F70D;
        Thu,  1 Oct 2020 04:17:35 -0700 (PDT)
Date:   Thu, 1 Oct 2020 12:17:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/2] PCI: dwc: armada-8k driver needs OF support
Message-ID: <20201001111729.GA6420@e121166-lin.cambridge.arm.com>
References: <20201001074244.349443-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201001074244.349443-1-thomas.petazzoni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 01, 2020 at 09:42:43AM +0200, Thomas Petazzoni wrote:
> Fixes the following build warning when CONFIG_OF is disabled:
> 
> drivers/pci/controller/dwc/pcie-armada8k.c:344:34: warning: ‘armada8k_pcie_of_match’ defined but not used [-Wunused-const-variable=]
>   344 | static const struct of_device_id armada8k_pcie_of_match[] = {
>       |                                  ^~~~~~~~~~~~~~~~~~~~~~
> 
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/pci/controller/dwc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged both patches into pci/dwc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 044a3761c44f..96994b715f26 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -176,7 +176,7 @@ config PCIE_QCOM
>  
>  config PCIE_ARMADA_8K
>  	bool "Marvell Armada-8K PCIe controller"
> -	depends on ARCH_MVEBU || COMPILE_TEST
> +	depends on OF && (ARCH_MVEBU || COMPILE_TEST)
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	help
> -- 
> 2.26.2
> 
