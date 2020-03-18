Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0BA18998A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 11:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCRKf2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 06:35:28 -0400
Received: from foss.arm.com ([217.140.110.172]:47974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgCRKf2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 06:35:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC02A1FB;
        Wed, 18 Mar 2020 03:35:27 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D66E93F534;
        Wed, 18 Mar 2020 03:35:26 -0700 (PDT)
Date:   Wed, 18 Mar 2020 10:35:16 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        amurray@thegoodpenguin.co.uk, bhelgaas@google.com,
        rdunlap@infradead.org
Subject: Re: [PATCH] PCI: mobiveil: Fix unmet dependency warning for
 PCIE_MOBIVEIL_PLAT
Message-ID: <20200318103504.GA13361@e121166-lin.cambridge.arm.com>
References: <20200318093312.49004-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318093312.49004-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 18, 2020 at 05:33:12PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Fix the follow warning by adding the dependency PCI_MSI_IRQ_DOMAIN
> into PCIE_MOBIVEIL_PLAT.
> 
> WARNING: unmet direct dependencies detected for PCIE_MOBIVEIL_HOST
>   Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
>   Selected by [y]:
>   - PCIE_MOBIVEIL_PLAT [=y] && PCI [=y] && (ARCH_ZYNQMP || COMPILE_TEST [=y]) && OF [=y]
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/pci/controller/mobiveil/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

I have applied it to pci/mobiveil for v5.7.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
> index 7439991ee82c..a62d247018cf 100644
> --- a/drivers/pci/controller/mobiveil/Kconfig
> +++ b/drivers/pci/controller/mobiveil/Kconfig
> @@ -15,6 +15,7 @@ config PCIE_MOBIVEIL_PLAT
>  	bool "Mobiveil AXI PCIe controller"
>  	depends on ARCH_ZYNQMP || COMPILE_TEST
>  	depends on OF
> +	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_MOBIVEIL_HOST
>  	help
>  	  Say Y here if you want to enable support for the Mobiveil AXI PCIe
> -- 
> 2.17.1
> 
