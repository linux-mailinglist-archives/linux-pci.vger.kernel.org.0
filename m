Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DE130AFE3
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 19:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhBAS6N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 13:58:13 -0500
Received: from foss.arm.com ([217.140.110.172]:36580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhBAS6L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 13:58:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE453147A;
        Mon,  1 Feb 2021 10:57:25 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D6FF3F71A;
        Mon,  1 Feb 2021 10:57:24 -0800 (PST)
Date:   Mon, 1 Feb 2021 18:57:19 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh@kernel.org, bhelgaas@google.com, pankaj.dubey@samsung.com,
        sriram.dash@samsung.com, niyas.ahmed@samsung.com,
        p.rajanbabu@samsung.com, l.mehra@samsung.com, hari.tv@samsung.com
Subject: Re: [PATCH v2] PCI: dwc: Add upper limit address for outbound iATU
Message-ID: <20210201185719.GA5767@e121166-lin.cambridge.arm.com>
References: <CGME20210106105019epcas5p377bdbff5cd9e14e5107ccbf2b87b5754@epcas5p3.samsung.com>
 <1609930210-19227-1-git-send-email-shradha.t@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609930210-19227-1-git-send-email-shradha.t@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 06, 2021 at 04:20:10PM +0530, Shradha Todi wrote:
> The size parameter is unsigned long type which can accept size > 4GB. In
> that case, the upper limit address must be programmed. Add support to
> program the upper limit address and set INCREASE_REGION_SIZE in case size >
> 4GB.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
> v1: https://lkml.org/lkml/2020/12/20/187
> v2:
>    Addressed Rob's review comment and added PCI version check condition to
>    avoid writing to reserved registers.
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
>  drivers/pci/controller/dwc/pcie-designware.h | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)

Does not apply to my pci/dwc branch, please rebase it on top of it
and resend it while keeping review tags.

Thanks,
Lorenzo

> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 74590c7..1d62ca9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -290,12 +290,17 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  			   upper_32_bits(cpu_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
>  			   lower_32_bits(cpu_addr + size - 1));
> +	if (pci->version >= 0x460A)
> +		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
> +				   upper_32_bits(cpu_addr + size - 1));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
>  			   lower_32_bits(pci_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
>  			   upper_32_bits(pci_addr));
> -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
> -			   PCIE_ATU_FUNC_NUM(func_no));
> +	val = type | PCIE_ATU_FUNC_NUM(func_no);
> +	val = ((upper_32_bits(size - 1)) && (pci->version >= 0x460A)) ?
> +		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
> +	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
>  
>  	/*
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 8b905a2..7da79eb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -102,6 +102,7 @@
>  #define PCIE_ATU_DEV(x)			FIELD_PREP(GENMASK(23, 19), x)
>  #define PCIE_ATU_FUNC(x)		FIELD_PREP(GENMASK(18, 16), x)
>  #define PCIE_ATU_UPPER_TARGET		0x91C
> +#define PCIE_ATU_UPPER_LIMIT		0x924
>  
>  #define PCIE_MISC_CONTROL_1_OFF		0x8BC
>  #define PCIE_DBI_RO_WR_EN		BIT(0)
> -- 
> 2.7.4
> 
