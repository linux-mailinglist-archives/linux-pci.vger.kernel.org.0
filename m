Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5E33E1617
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 15:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241781AbhHENyM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 09:54:12 -0400
Received: from foss.arm.com ([217.140.110.172]:46348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235180AbhHENyL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 09:54:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02CB531B;
        Thu,  5 Aug 2021 06:53:57 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17C593F40C;
        Thu,  5 Aug 2021 06:53:55 -0700 (PDT)
Date:   Thu, 5 Aug 2021 14:53:53 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 2/2] PCI: dwc: Clean up Kconfig dependencies
 (PCIE_DW_EP)
Message-ID: <20210805135353.GB22410@lpieralisi>
References: <20210623140103.47818-1-andriy.shevchenko@linux.intel.com>
 <20210623140103.47818-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623140103.47818-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 23, 2021 at 05:01:03PM +0300, Andy Shevchenko wrote:
> The "depends on" is no-op in the selectable options.

Same as in patch one, spell out what "depends on" you are referring
to - please make this log more descriptive.

Thanks,
Lorenzo

> 
> Clean up the users of PCIE_DW_EP and introduce idiom
> 
> 	depends on PCI_ENDPOINT
> 	select PCIE_DW_EP
> 
> for all of them.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 9bfd41eadd5e..ca5de4e40fbe 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -12,7 +12,6 @@ config PCIE_DW_HOST
>  
>  config PCIE_DW_EP
>  	bool
> -	depends on PCI_ENDPOINT
>  	select PCIE_DW
>  
>  config PCI_DRA7XX
> @@ -37,8 +36,8 @@ config PCI_DRA7XX_HOST
>  config PCI_DRA7XX_EP
>  	bool "TI DRA7xx PCIe controller Endpoint Mode"
>  	depends on SOC_DRA7XX || COMPILE_TEST
> -	depends on PCI_ENDPOINT
>  	depends on OF && HAS_IOMEM && TI_PIPE3
> +	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
>  	select PCI_DRA7XX
>  	help
> -- 
> 2.30.2
> 
