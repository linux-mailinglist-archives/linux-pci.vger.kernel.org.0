Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B3A42C454
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 17:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbhJMPDZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 11:03:25 -0400
Received: from foss.arm.com ([217.140.110.172]:40758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236737AbhJMPDJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 11:03:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C22061FB;
        Wed, 13 Oct 2021 08:01:05 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EA513F694;
        Wed, 13 Oct 2021 08:01:04 -0700 (PDT)
Date:   Wed, 13 Oct 2021 16:00:58 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: apple: select CONFIG_PCI_HOST_COMMON
Message-ID: <20211013150058.GA11615@lpieralisi>
References: <20211013143914.2133428-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013143914.2133428-1-arnd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 13, 2021 at 04:38:50PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> If this symbol is not already selected by another driver, pci-apple.o
> fails to link:
> 
> aarch64-linux-ld: drivers/pci/controller/pcie-apple.o: in function `apple_pcie_probe':
> pcie-apple.c:(.text+0xd28): undefined reference to `pci_host_common_probe'
> 
> Add another 'select' statement here, the same that is used for the
> other drivers.
> 
> Fixes: a8bbe0366a3e ("PCI: apple: Add initial hardware bring-up")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/controller/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Squashed it in the commit it is fixing and rebuilt my pci/apple
branch.

Thanks,
Lorenzo

> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index cc1fcc89c58f..5af99701e1f6 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -322,6 +322,7 @@ config PCIE_APPLE
>  	depends on ARCH_APPLE || COMPILE_TEST
>  	depends on OF
>  	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCI_HOST_COMMON
>  	help
>  	  Say Y here if you want to enable PCIe controller support on Apple
>  	  system-on-chips, like the Apple M1. This is required for the USB
> -- 
> 2.29.2
> 
