Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BB848550A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 15:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbiAEOuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 09:50:16 -0500
Received: from foss.arm.com ([217.140.110.172]:45114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241092AbiAEOuO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jan 2022 09:50:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C831211D4;
        Wed,  5 Jan 2022 06:50:13 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 774873F774;
        Wed,  5 Jan 2022 06:50:12 -0800 (PST)
Date:   Wed, 5 Jan 2022 14:50:06 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, john@phrozen.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 10/14] PCI: mediatek: Allow building for ARCH_AIROHA
Message-ID: <20220105145006.GA7465@lpieralisi>
References: <20211220211854.89452-1-nbd@nbd.name>
 <20211220211854.89452-11-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220211854.89452-11-nbd@nbd.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 20, 2021 at 10:18:50PM +0100, Felix Fietkau wrote:
> Allow selecting the pcie-mediatek driver if ARCH_AIROHA is set, because the
> Airoha EN7523 SoC uses the same controller as MT7622.
> The driver itself is not modified. The PCIe controller DT node should use
> mediatek,mt7622-pcie after airoha,en7523-pcie.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/pci/controller/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 93b141110537..f1342059c2a3 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -233,7 +233,7 @@ config PCIE_ROCKCHIP_EP
>  
>  config PCIE_MEDIATEK
>  	tristate "MediaTek PCIe controller"
> -	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
>  	depends on OF
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	help
> -- 
> 2.34.1
> 
