Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560E11CF2E6
	for <lists+linux-pci@lfdr.de>; Tue, 12 May 2020 12:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgELKwU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 May 2020 06:52:20 -0400
Received: from foss.arm.com ([217.140.110.172]:52242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgELKwT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 May 2020 06:52:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEE3B30E;
        Tue, 12 May 2020 03:52:18 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA6A43F71E;
        Tue, 12 May 2020 03:52:17 -0700 (PDT)
Date:   Tue, 12 May 2020 11:52:11 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        amurray@thegoodpenguin.co.uk, bhelgaas@google.com, kishon@ti.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH] PCI: dwc: Program outbound ATU upper limit register
Message-ID: <20200512105211.GA11726@e121166-lin.cambridge.arm.com>
References: <1585785493-23210-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585785493-23210-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 01, 2020 at 04:58:13PM -0700, Alan Mikhak wrote:
> From: Alan Mikhak <alan.mikhak@sifive.com>
> 
> Function dw_pcie_prog_outbound_atu_unroll() does not program the upper
> 32-bit ATU limit register. Since ATU programming functions limit the
> size of the translated region to 4GB by using a u32 size parameter,
> these issues may combine into undefined behavior for resource sizes
> with non-zero upper 32-bits.
> 
> For example, a 128GB address space starting at physical CPU address of
> 0x2000000000 with size of 0x2000000000 needs the following values
> programmed into the lower and upper 32-bit limit registers:
>  0x3fffffff in the upper 32-bit limit register
>  0xffffffff in the lower 32-bit limit register
> 
> Currently, only the lower 32-bit limit register is programmed with a
> value of 0xffffffff but the upper 32-bit limit register is not being
> programmed. As a result, the upper 32-bit limit register remains at its
> default value after reset of 0x0.
> 
> These issues may combine to produce undefined behavior since the ATU
> limit address may be lower than the ATU base address. Programming the
> upper ATU limit address register prevents such undefined behavior despite
> the region size getting truncated due to the 32-bit size limit.
> 
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++--
>  drivers/pci/controller/dwc/pcie-designware.h | 3 ++-
>  2 files changed, 7 insertions(+), 3 deletions(-)

Applied to pci/dwc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 681548c88282..c92496e36fd5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -244,13 +244,16 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
>  					     u64 pci_addr, u32 size)
>  {
>  	u32 retries, val;
> +	u64 limit_addr = cpu_addr + size - 1;
>  
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
>  				 lower_32_bits(cpu_addr));
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_BASE,
>  				 upper_32_bits(cpu_addr));
> -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LIMIT,
> -				 lower_32_bits(cpu_addr + size - 1));
> +	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_LIMIT,
> +				 lower_32_bits(limit_addr));
> +	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_LIMIT,
> +				 upper_32_bits(limit_addr));
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
>  				 lower_32_bits(pci_addr));
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index a22ea5982817..5ce1aef706c5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -112,9 +112,10 @@
>  #define PCIE_ATU_UNR_REGION_CTRL2	0x04
>  #define PCIE_ATU_UNR_LOWER_BASE		0x08
>  #define PCIE_ATU_UNR_UPPER_BASE		0x0C
> -#define PCIE_ATU_UNR_LIMIT		0x10
> +#define PCIE_ATU_UNR_LOWER_LIMIT	0x10
>  #define PCIE_ATU_UNR_LOWER_TARGET	0x14
>  #define PCIE_ATU_UNR_UPPER_TARGET	0x18
> +#define PCIE_ATU_UNR_UPPER_LIMIT	0x20
>  
>  /*
>   * The default address offset between dbi_base and atu_base. Root controller
> -- 
> 2.7.4
> 
