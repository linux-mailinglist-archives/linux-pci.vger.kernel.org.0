Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C246DC075
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 11:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442268AbfJRJBx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 05:01:53 -0400
Received: from [217.140.110.172] ([217.140.110.172]:58982 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2442255AbfJRJBx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 05:01:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1096492;
        Fri, 18 Oct 2019 02:01:33 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E39F53F718;
        Fri, 18 Oct 2019 02:01:31 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:01:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, andrew.murray@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 1/2] PCI: tegra: Fix CLKREQ dependency programming
Message-ID: <20191018090127.GA25918@e121166-lin.cambridge.arm.com>
References: <20191005164212.3646-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005164212.3646-1-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 05, 2019 at 10:12:11PM +0530, Vidya Sagar wrote:
> Corrects the programming to provide REFCLK to the downstream device
> when there is no CLKREQ sideband signal routing present from root port
> to the endpont.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied to pci/tegra, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index f89f5acee72d..cbe95f0ea0ca 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -40,8 +40,6 @@
>  #define APPL_PINMUX_CLKREQ_OVERRIDE		BIT(3)
>  #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN	BIT(4)
>  #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE	BIT(5)
> -#define APPL_PINMUX_CLKREQ_OUT_OVRD_EN		BIT(9)
> -#define APPL_PINMUX_CLKREQ_OUT_OVRD		BIT(10)
>  
>  #define APPL_CTRL				0x4
>  #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
> @@ -1193,8 +1191,8 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
>  
>  	if (!pcie->supports_clkreq) {
>  		val = appl_readl(pcie, APPL_PINMUX);
> -		val |= APPL_PINMUX_CLKREQ_OUT_OVRD_EN;
> -		val |= APPL_PINMUX_CLKREQ_OUT_OVRD;
> +		val |= APPL_PINMUX_CLKREQ_OVERRIDE_EN;
> +		val &= ~APPL_PINMUX_CLKREQ_OVERRIDE;
>  		appl_writel(pcie, val, APPL_PINMUX);
>  	}
>  
> -- 
> 2.17.1
> 
