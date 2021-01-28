Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6E3307816
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 15:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhA1Oaj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 09:30:39 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55014 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhA1Oa0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 09:30:26 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10SETN9v047348;
        Thu, 28 Jan 2021 08:29:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611844163;
        bh=AGuu1uk59C5HzGmXebO7NHb9zrfqRHugzWkIahYiu10=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fn/nDQQEeysezFrYPuFESi52LVMD4msuMAbTozd9EzdMZAm2OYJ9gdqrCiVZF7sGT
         mHzPMPAc3FQ50PdXTMzPoi4VjYTexOs0GlXKT2RF9Iw4ghsmQTLfu2TXyzLwTeBTTx
         1feX7TgOldsJblhISryd8eDOxlVRbBqFnPjeVmZE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10SETNiY056439
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jan 2021 08:29:23 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 Jan 2021 08:29:22 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 Jan 2021 08:29:22 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10SETIJQ028665;
        Thu, 28 Jan 2021 08:29:19 -0600
Subject: Re: [PATCH v2 3/3] PCI: uniphier-ep: Add EPC restart management
 support
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1611500977-24816-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1611500977-24816-4-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c5e89789-2dd3-3247-ec85-d54652987e2a@ti.com>
Date:   Thu, 28 Jan 2021 19:59:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611500977-24816-4-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kunihiko,

On 24/01/21 8:39 pm, Kunihiko Hayashi wrote:
> Set the polling function and call the init function to enable EPC restart
> management. The polling function detects that the bus-reset signal is a
> rising edge.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |  1 +
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c | 44 ++++++++++++++++++++++++++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 22c5529..90d400a 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -302,6 +302,7 @@ config PCIE_UNIPHIER_EP
>  	depends on OF && HAS_IOMEM
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
> +	select PCI_ENDPOINT_RESTART
>  	help
>  	  Say Y here if you want PCIe endpoint controller support on
>  	  UniPhier SoCs. This driver supports Pro5 SoC.
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> index 69810c6..9d83850 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> @@ -26,6 +26,7 @@
>  #define PCL_RSTCTRL_PIPE3		BIT(0)
>  
>  #define PCL_RSTCTRL1			0x0020
> +#define PCL_RSTCTRL_PERST_MON		BIT(16)
>  #define PCL_RSTCTRL_PERST		BIT(0)
>  
>  #define PCL_RSTCTRL2			0x0024
> @@ -60,6 +61,7 @@ struct uniphier_pcie_ep_priv {
>  	struct clk *clk, *clk_gio;
>  	struct reset_control *rst, *rst_gio;
>  	struct phy *phy;
> +	bool bus_reset_status;
>  	const struct pci_epc_features *features;
>  };
>  
> @@ -212,6 +214,41 @@ uniphier_pcie_get_features(struct dw_pcie_ep *ep)
>  	return priv->features;
>  }
>  
> +static bool uniphier_pcie_ep_poll_reset(void *data)
> +{
> +	struct uniphier_pcie_ep_priv *priv = data;
> +	bool ret, status;
> +
> +	if (!priv)
> +		return false;
> +
> +	status = !(readl(priv->base + PCL_RSTCTRL1) & PCL_RSTCTRL_PERST_MON);
> +
> +	/* return true if the rising edge of bus reset is detected */
> +	ret = !!(status == false && priv->bus_reset_status == true);
> +	priv->bus_reset_status = status;

I'm still not convinced about having a separate library for restart
management but shouldn't we reset the function driver on falling edge?
After the rising edge the host expects the endpoint to be ready.

Why not use the CORE_INIT (core_init_notifier) infrastructure?

Thanks
Kishon

> +
> +	return ret;
> +}
> +
> +static int uniphier_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct uniphier_pcie_ep_priv *priv = to_uniphier_pcie(pci);
> +	int ret;
> +
> +	/* Set up epc-restart thread */
> +	pci_epc_restart_register_poll_func(ep->epc,
> +					    uniphier_pcie_ep_poll_reset, priv);
> +	/* With call of poll_reset() directly, initialize internal state */
> +	uniphier_pcie_ep_poll_reset(priv);
> +	ret = pci_epc_restart_init(ep->epc);
> +	if (ret)
> +		dev_err(pci->dev, "Failed to initialize epc-restart (%d)\n", ret);
> +
> +	return ret;
> +}
> +
>  static const struct dw_pcie_ep_ops uniphier_pcie_ep_ops = {
>  	.ep_init = uniphier_pcie_ep_init,
>  	.raise_irq = uniphier_pcie_ep_raise_irq,
> @@ -318,7 +355,12 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	priv->pci.ep.ops = &uniphier_pcie_ep_ops;
> -	return dw_pcie_ep_init(&priv->pci.ep);
> +
> +	ret = dw_pcie_ep_init(&priv->pci.ep);
> +	if (ret)
> +		return ret;
> +
> +	return uniphier_pcie_ep_init_complete(&priv->pci.ep);
>  }
>  
>  static const struct pci_epc_features uniphier_pro5_data = {
> 
