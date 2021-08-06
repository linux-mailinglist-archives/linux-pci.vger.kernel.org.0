Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7093E2629
	for <lists+linux-pci@lfdr.de>; Fri,  6 Aug 2021 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbhHFIcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 04:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235706AbhHFIcm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Aug 2021 04:32:42 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D47E61052;
        Fri,  6 Aug 2021 08:32:27 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mBvHF-003Jke-0l; Fri, 06 Aug 2021 09:32:25 +0100
MIME-Version: 1.0
Date:   Fri, 06 Aug 2021 09:32:24 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] PCI: aardvark: Correctly clear and unmask all MSI
 interrupts
In-Reply-To: <20210625090319.10220-7-pali@kernel.org>
References: <20210625090319.10220-1-pali@kernel.org>
 <20210625090319.10220-7-pali@kernel.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <fb3a7ef15397292692b6d5dd0d2e439e@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: pali@kernel.org, lorenzo.pieralisi@arm.com, thomas.petazzoni@bootlin.com, bhelgaas@google.com, robh@kernel.org, kabel@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-06-25 10:03, Pali Rohár wrote:
> Define a new macro PCIE_MSI_ALL_MASK and use it for masking, unmasking 
> and
> clearing all MSI interrupts.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/controller/pci-aardvark.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c
> b/drivers/pci/controller/pci-aardvark.c
> index 0e81d89f307d..7cad6d989f6c 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -117,6 +117,7 @@
>  #define PCIE_MSI_ADDR_HIGH_REG			(CONTROL_BASE_ADDR + 0x54)
>  #define PCIE_MSI_STATUS_REG			(CONTROL_BASE_ADDR + 0x58)
>  #define PCIE_MSI_MASK_REG			(CONTROL_BASE_ADDR + 0x5C)
> +#define     PCIE_MSI_ALL_MASK			GENMASK(31, 0)
>  #define PCIE_MSI_PAYLOAD_REG			(CONTROL_BASE_ADDR + 0x9C)
>  #define     PCIE_MSI_DATA_MASK			GENMASK(15, 0)
> 
> @@ -470,19 +471,22 @@ static void advk_pcie_setup_hw(struct advk_pcie 
> *pcie)
>  	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
> 
>  	/* Clear all interrupts */
> +	advk_writel(pcie, PCIE_MSI_ALL_MASK, PCIE_MSI_STATUS_REG);
>  	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_REG);
>  	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
>  	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
> 
>  	/* Disable All ISR0/1 Sources */
> -	reg = PCIE_ISR0_ALL_MASK;
> -	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
> -	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
> -
> +	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_MASK_REG);
>  	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
> 
>  	/* Unmask all MSIs */
> -	advk_writel(pcie, 0, PCIE_MSI_MASK_REG);
> +	advk_writel(pcie, ~(u32)PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
> +
> +	/* Unmask summary MSI interrupt */
> +	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
> +	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
> +	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
> 
>  	/* Enable summary interrupt for GIC SPI source */
>  	reg = PCIE_IRQ_ALL_MASK & (~PCIE_IRQ_ENABLE_INTS_MASK);
> @@ -1177,7 +1181,7 @@ static void advk_pcie_handle_msi(struct advk_pcie 
> *pcie)
> 
>  	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
>  	msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
> -	msi_status = msi_val & ~msi_mask;
> +	msi_status = msi_val & ((~msi_mask) & PCIE_MSI_ALL_MASK);
> 
>  	for (msi_idx = 0; msi_idx < MSI_IRQ_NUM; msi_idx++) {
>  		if (!(BIT(msi_idx) & msi_status))

This still begs the question: why would you ever enable all
MSIs the first place? They should be enabled on request only.

         M.
-- 
Jazz is not dead. It just smells funny...
