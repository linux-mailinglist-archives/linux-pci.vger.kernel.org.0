Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B30F2D1AAD
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 21:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgLGUiN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 15:38:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgLGUiN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 15:38:13 -0500
Date:   Mon, 7 Dec 2020 14:37:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607373452;
        bh=mfwi2/EKkZUNhWL82rdthYNiJlGRQHrM44be9bTSWXU=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=iNqTPnxLZcNUWOaIqo/lY3PV8PrM4IHqYvEj1vXEY0Xup/vDV3dM7KrSc30fzE68u
         y63KWqvsTxcomng4S5ITEHCRlRcDQONTnZuRC/MsmGpp6xmrsWvx2rkp1SbmljSBku
         uWLYXkblMU6dsQdge0/xTHkYBqMohd00HeMtCKs6OpRM9iW0rlgICXMef6CZfNh4Fs
         SSaCAQEmBxhRUsCueVA126SkH3UNKCOLtZOqINf/EIpHY7teoEKseZQ0Sk3QTAJM+6
         AgVrK9A3jbVzfbU4YvbC5fOf4J+SuEadQtumWuPzH1Mc2WrvozgaTXqDG9qWIYKm+2
         cp+aW62e883Rw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        amanharitsh123@gmail.com, dinghao.liu@zju.edu.cn, kw@linux.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH V5 5/5] PCI: tegra: Disable LTSSM during L2 entry
Message-ID: <20201207203730.GA2289423@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203133451.17716-6-vidyas@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jingoo, Gustavo]

On Thu, Dec 03, 2020 at 07:04:51PM +0530, Vidya Sagar wrote:
> PCIe cards like Marvell SATA controller and some of the Samsung NVMe
> drives don't support taking the link to L2 state. When the link doesn't
> go to L2 state, Tegra194 requires the LTSSM to be disabled to allow PHY
> to start the next link up process cleanly during suspend/resume sequence.
> Failing to disable LTSSM results in the PCIe link not coming up in the
> next resume cycle.

Is this a Tegra194-specific issue, or will other DWC-based controllers
need a similar change?

> Tested-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> V5:
> * Added Tested-by and Acked-by from Thierry Reding
> 
> V4:
> * New patch in this series
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index f4109d71f20b..5597b2a49598 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1506,6 +1506,14 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
>  		data &= ~APPL_PINMUX_PEX_RST;
>  		appl_writel(pcie, data, APPL_PINMUX);
>  
> +		/*
> +		 * Some cards do not go to detect state even after de-asserting
> +		 * PERST#. So, de-assert LTSSM to bring link to detect state.
> +		 */
> +		data = readl(pcie->appl_base + APPL_CTRL);
> +		data &= ~APPL_CTRL_LTSSM_EN;
> +		writel(data, pcie->appl_base + APPL_CTRL);
> +
>  		err = readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG,
>  						data,
>  						((data &
> @@ -1513,14 +1521,8 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
>  						APPL_DEBUG_LTSSM_STATE_SHIFT) ==
>  						LTSSM_STATE_PRE_DETECT,
>  						1, LTSSM_TIMEOUT);
> -		if (err) {
> +		if (err)
>  			dev_info(pcie->dev, "Link didn't go to detect state\n");
> -		} else {
> -			/* Disable LTSSM after link is in detect state */
> -			data = appl_readl(pcie, APPL_CTRL);
> -			data &= ~APPL_CTRL_LTSSM_EN;
> -			appl_writel(pcie, data, APPL_CTRL);
> -		}
>  	}
>  	/*
>  	 * DBI registers may not be accessible after this as PLL-E would be
> -- 
> 2.17.1
> 
