Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B9275C0EE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 10:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjGUIKl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 04:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGUIKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 04:10:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383502704;
        Fri, 21 Jul 2023 01:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C253616BA;
        Fri, 21 Jul 2023 08:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56993C433C7;
        Fri, 21 Jul 2023 08:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689927035;
        bh=3P+rjri8ZXWV2yItqYH4n3f7fYr2yvmOKMX8gB8x124=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GYbB2y/deUQMsdJGd02IPLVM0h9+p69Ob5MBjC2uVTQ3N+jM1KHcE3pBgx9jpP7s+
         OUXWQIgUKyYRcmrrsbnKTkJUfet1OwOTxyRlqxdJPh9toUFszfJb1SSH2pbVvVm1cD
         +OJDAAA7dSZqG+fyOrUnVdbtNDW4Fk43ilA2C5YFMxtAKkxqoSwb0nXoC8NEAC6/+C
         ngHPzdZHQ97eBITdOP9pOMl6w+6+8lOnGGRm7D0C2nLLMy0dtwusFr4PzYew2Errn9
         7noJbJXeFjovnwESvPQaQ1qovznLzWizGs72mFJ4Ry8uZNPxFGpG0VjqpYRdSPf2zE
         wBboCQxkn54KA==
Content-Type: multipart/mixed; boundary="------------6hZAHcSRh0mvN0jj5PooCif0"
Message-ID: <6e88938f-5cb7-96c8-681e-0e929ace4517@kernel.org>
Date:   Fri, 21 Jul 2023 17:10:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v18 02/20] PCI: Rename PCI_EPC_IRQ_LEGACY to
 PCI_EPC_IRQ_INTX
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-3-yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230721074452.65545-3-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a multi-part message in MIME format.
--------------6hZAHcSRh0mvN0jj5PooCif0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/23 16:44, Yoshihiro Shimoda wrote:
> Using "INTx" instead of "legacy" is more specific. So, rename
> PCI_EPC_IRQ_LEGACY to PCI_EPC_IRQ_INTX.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com> # ARTPEC
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

I would rather drop completely the PCI_EPC_IRQ_XXX enum and simply use the
PCI_IRQ_XXX macros used everywhere. Less definitions :)

See attached patch that I have in my queue (about to send that).

> ---
> This CC-list is for git send-email.
> 
> Cc: Tom Joseph <tjoseph@cadence.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Minghuan Lian <minghuan.Lian@nxp.com>
> Cc: Mingkai Hu <mingkai.hu@nxp.com>
> Cc: Roy Zang <roy.zang@nxp.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Srikanth Thokala <srikanth.thokala@intel.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Kishon Vijay Abraham I <kishon@kernel.org>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c  |  2 +-
>  drivers/pci/controller/dwc/pci-dra7xx.c           |  2 +-
>  drivers/pci/controller/dwc/pci-imx6.c             |  2 +-
>  drivers/pci/controller/dwc/pci-keystone.c         |  2 +-
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  2 +-
>  drivers/pci/controller/dwc/pcie-artpec6.c         |  2 +-
>  drivers/pci/controller/dwc/pcie-designware-plat.c |  2 +-
>  drivers/pci/controller/dwc/pcie-keembay.c         |  2 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c         |  2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c        |  2 +-
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  2 +-
>  drivers/pci/controller/pcie-rcar-ep.c             |  2 +-
>  drivers/pci/controller/pcie-rockchip-ep.c         |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c     | 10 +++++-----
>  include/linux/pci-epc.h                           |  4 ++--
>  15 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index b8b655d4047e..2af8eb4e6d91 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -539,7 +539,7 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
>  	struct device *dev = pcie->dev;
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		if (vfn > 0) {
>  			dev_err(dev, "Cannot raise legacy interrupts for VF\n");
>  			return -EINVAL;
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index b445ffe95e3f..8767432dda5c 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -410,7 +410,7 @@ static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		dra7xx_pcie_raise_legacy_irq(dra7xx);
>  		break;
>  	case PCI_EPC_IRQ_MSI:
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 235ead4c807f..feadc88782a7 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1063,7 +1063,7 @@ static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
>  	case PCI_EPC_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 49aea6ce3e87..fce300673ea3 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -907,7 +907,7 @@ static int ks_pcie_am654_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		ks_pcie_am654_raise_legacy_irq(ks_pcie);
>  		break;
>  	case PCI_EPC_IRQ_MSI:
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index de4c1758a6c3..b2e14d64dba2 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -155,7 +155,7 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
>  	case PCI_EPC_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index 9b572a2b2c9a..cf92a11ede86 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -357,7 +357,7 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		dev_err(pci->dev, "EP cannot trigger legacy IRQs\n");
>  		return -EINVAL;
>  	case PCI_EPC_IRQ_MSI:
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index b625841e98aa..f72df38dd523 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -48,7 +48,7 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
>  	case PCI_EPC_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
> index 289bff99d762..62903fef343c 100644
> --- a/drivers/pci/controller/dwc/pcie-keembay.c
> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> @@ -295,7 +295,7 @@ static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		/* Legacy interrupts are not supported in Keem Bay */
>  		dev_err(pci->dev, "Legacy IRQ is not supported\n");
>  		return -EINVAL;
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 267e1247d548..21e2ccc49219 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -660,7 +660,7 @@ static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
>  	case PCI_EPC_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 383ba71d1e8f..85cc64324efd 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1999,7 +1999,7 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		return tegra_pcie_ep_raise_legacy_irq(pcie, interrupt_num);
>  
>  	case PCI_EPC_IRQ_MSI:
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> index cba3c88fcf39..a00301928c38 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> @@ -262,7 +262,7 @@ static int uniphier_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		return uniphier_pcie_ep_raise_legacy_irq(ep);
>  	case PCI_EPC_IRQ_MSI:
>  		return uniphier_pcie_ep_raise_msi_irq(ep, func_no,
> diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
> index f9682df1da61..fbdf3d85301c 100644
> --- a/drivers/pci/controller/pcie-rcar-ep.c
> +++ b/drivers/pci/controller/pcie-rcar-ep.c
> @@ -408,7 +408,7 @@ static int rcar_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
>  	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		return rcar_pcie_ep_assert_intx(ep, fn, 0);
>  
>  	case PCI_EPC_IRQ_MSI:
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 0af0e965fb57..e856a45d0986 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -413,7 +413,7 @@ static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
>  	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		return rockchip_pcie_ep_send_legacy_irq(ep, fn, 0);
>  	case PCI_EPC_IRQ_MSI:
>  		return rockchip_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 1f0d2b84296a..caa30596fadd 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -19,11 +19,11 @@
>  #include <linux/pci-epf.h>
>  #include <linux/pci_regs.h>
>  
> -#define IRQ_TYPE_LEGACY			0
> +#define IRQ_TYPE_INTX			0
>  #define IRQ_TYPE_MSI			1
>  #define IRQ_TYPE_MSIX			2
>  
> -#define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
> +#define COMMAND_RAISE_INTX_IRQ		BIT(0)
>  #define COMMAND_RAISE_MSI_IRQ		BIT(1)
>  #define COMMAND_RAISE_MSIX_IRQ		BIT(2)
>  #define COMMAND_READ			BIT(3)
> @@ -600,9 +600,9 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  	WRITE_ONCE(reg->status, status);
>  
>  	switch (reg->irq_type) {
> -	case IRQ_TYPE_LEGACY:
> +	case IRQ_TYPE_INTX:
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_EPC_IRQ_LEGACY, 0);
> +				  PCI_EPC_IRQ_INTX, 0);
>  		break;
>  	case IRQ_TYPE_MSI:
>  		count = pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
> @@ -659,7 +659,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	}
>  
>  	switch (command) {
> -	case COMMAND_RAISE_LEGACY_IRQ:
> +	case COMMAND_RAISE_INTX_IRQ:
>  	case COMMAND_RAISE_MSI_IRQ:
>  	case COMMAND_RAISE_MSIX_IRQ:
>  		pci_epf_test_raise_irq(epf_test, reg);
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 5cb694031072..c5ada36b6ca0 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -21,7 +21,7 @@ enum pci_epc_interface_type {
>  
>  enum pci_epc_irq_type {
>  	PCI_EPC_IRQ_UNKNOWN,
> -	PCI_EPC_IRQ_LEGACY,
> +	PCI_EPC_IRQ_INTX,
>  	PCI_EPC_IRQ_MSI,
>  	PCI_EPC_IRQ_MSIX,
>  };
> @@ -54,7 +54,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
>   *	     MSI-X capability register
>   * @get_msix: ops to get the number of MSI-X interrupts allocated by the RC
>   *	     from the MSI-X capability register
> - * @raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
> + * @raise_irq: ops to raise an INTx, MSI or MSI-X interrupt
>   * @map_msi_irq: ops to map physical address to MSI address and return MSI data
>   * @start: ops to start the PCI link
>   * @stop: ops to stop the PCI link

-- 
Damien Le Moal
Western Digital Research

--------------6hZAHcSRh0mvN0jj5PooCif0
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-PCI-endpoint-Drop-PCI_EPC_IRQ_XXX-definitions.patch"
Content-Disposition: attachment;
 filename="0001-PCI-endpoint-Drop-PCI_EPC_IRQ_XXX-definitions.patch"
Content-Transfer-Encoding: base64

RnJvbSBlMmFjZjhjYzkyZmMzOTAyYjM1NWJhM2ZlNGE4YzM3Yzk1MzVjN2M4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwu
b3JnPgpEYXRlOiBXZWQsIDEyIEFwciAyMDIzIDE5OjUwOjQ3ICswOTAwClN1YmplY3Q6IFtQ
QVRDSF0gUENJOiBlbmRwb2ludDogRHJvcCBQQ0lfRVBDX0lSUV9YWFggZGVmaW5pdGlvbnMK
CmxpbnV4L3BjaS5oIGRlZmluZXMgdGhlIElSUSBmbGFncyBQQ0lfSVJRX0xFR0FDWSwgUENJ
X0lSUV9NU0kgYW5kClBDSV9JUlFfTVNJWC4gTGV0J3MgdXNlIHRoZXNlIGZsYWdzIGRpcmVj
dGx5IGluc3RlYWQgb2YgdGhlIGVuZHBvaW50CmRlZmluaXRpb25zIHByb3ZpZGVkIGJ5IGVu
dW0gcGNpX2VwY19pcnFfdHlwZS4KClNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsIDxk
bGVtb2FsQGtlcm5lbC5vcmc+Ci0tLQogZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNl
L3BjaWUtY2FkZW5jZS1lcC5jICB8ICA5ICsrKystLS0tLQogZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWRyYTd4eC5jICAgICAgICAgICB8ICA2ICsrKy0tLQogZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyAgICAgICAgICAgICB8ICA5ICsrKystLS0t
LQogZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWtleXN0b25lLmMgICAgICAgICB8
ICA5ICsrKystLS0tLQogZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2Nh
cGUtZXAuYyAgICB8ICA4ICsrKystLS0tCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWFydHBlYzYuYyAgICAgICAgIHwgIDYgKysrLS0tCiBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYyAgIHwgIDIgKy0KIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1wbGF0LmMgfCAgOSArKysrLS0tLS0KIGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oICAgICAgfCAgMiAr
LQogZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1rZWVtYmF5LmMgICAgICAgICB8
ICA5ICsrKystLS0tLQogZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1xY29tLWVw
LmMgICAgICAgICB8ICA2ICsrKy0tLQogZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS10ZWdyYTE5NC5jICAgICAgICB8ICA5ICsrKystLS0tLQogZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS11bmlwaGllci1lcC5jICAgICB8ICA3ICsrKy0tLS0KIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvcGNpZS1yY2FyLWVwLmMgICAgICAgICAgICAgfCAgNyArKystLS0t
CiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcm9ja2NoaXAtZXAuYyAgICAgICAgIHwg
IDcgKysrLS0tLQogZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtbWhp
LmMgICAgICB8ICAyICstCiBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVw
Zi1udGIuYyAgICAgIHwgIDQgKystLQogZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25z
L3BjaS1lcGYtdGVzdC5jICAgICB8ICA2ICsrKy0tLQogZHJpdmVycy9wY2kvZW5kcG9pbnQv
ZnVuY3Rpb25zL3BjaS1lcGYtdm50Yi5jICAgICB8ICA3ICsrLS0tLS0KIGRyaXZlcnMvcGNp
L2VuZHBvaW50L3BjaS1lcGMtY29yZS5jICAgICAgICAgICAgICAgfCAgMiArLQogaW5jbHVk
ZS9saW51eC9wY2ktZXBjLmggICAgICAgICAgICAgICAgICAgICAgICAgICB8IDExICsrLS0t
LS0tLS0tCiAyMSBmaWxlcyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCA3OCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNp
ZS1jYWRlbmNlLWVwLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1j
YWRlbmNlLWVwLmMKaW5kZXggYjhiNjU1ZDQwNDdlLi4yNTBhZDEzMzBmZjMgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UtZXAuYwor
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLWVwLmMK
QEAgLTUzMSwyNSArNTMxLDI0IEBAIHN0YXRpYyBpbnQgY2Ruc19wY2llX2VwX3NlbmRfbXNp
eF9pcnEoc3RydWN0IGNkbnNfcGNpZV9lcCAqZXAsIHU4IGZuLCB1OCB2Zm4sCiB9CiAKIHN0
YXRpYyBpbnQgY2Ruc19wY2llX2VwX3JhaXNlX2lycShzdHJ1Y3QgcGNpX2VwYyAqZXBjLCB1
OCBmbiwgdTggdmZuLAotCQkJCSAgZW51bSBwY2lfZXBjX2lycV90eXBlIHR5cGUsCi0JCQkJ
ICB1MTYgaW50ZXJydXB0X251bSkKKwkJCQkgIHVuc2lnbmVkIGludCB0eXBlLCB1MTYgaW50
ZXJydXB0X251bSkKIHsKIAlzdHJ1Y3QgY2Ruc19wY2llX2VwICplcCA9IGVwY19nZXRfZHJ2
ZGF0YShlcGMpOwogCXN0cnVjdCBjZG5zX3BjaWUgKnBjaWUgPSAmZXAtPnBjaWU7CiAJc3Ry
dWN0IGRldmljZSAqZGV2ID0gcGNpZS0+ZGV2OwogCiAJc3dpdGNoICh0eXBlKSB7Ci0JY2Fz
ZSBQQ0lfRVBDX0lSUV9MRUdBQ1k6CisJY2FzZSBQQ0lfSVJRX0xFR0FDWToKIAkJaWYgKHZm
biA+IDApIHsKIAkJCWRldl9lcnIoZGV2LCAiQ2Fubm90IHJhaXNlIGxlZ2FjeSBpbnRlcnJ1
cHRzIGZvciBWRlxuIik7CiAJCQlyZXR1cm4gLUVJTlZBTDsKIAkJfQogCQlyZXR1cm4gY2Ru
c19wY2llX2VwX3NlbmRfbGVnYWN5X2lycShlcCwgZm4sIHZmbiwgMCk7CiAKLQljYXNlIFBD
SV9FUENfSVJRX01TSToKKwljYXNlIFBDSV9JUlFfTVNJOgogCQlyZXR1cm4gY2Ruc19wY2ll
X2VwX3NlbmRfbXNpX2lycShlcCwgZm4sIHZmbiwgaW50ZXJydXB0X251bSk7CiAKLQljYXNl
IFBDSV9FUENfSVJRX01TSVg6CisJY2FzZSBQQ0lfSVJRX01TSVg6CiAJCXJldHVybiBjZG5z
X3BjaWVfZXBfc2VuZF9tc2l4X2lycShlcCwgZm4sIHZmbiwgaW50ZXJydXB0X251bSk7CiAK
IAlkZWZhdWx0OgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWRyYTd4eC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWRyYTd4eC5jCmlu
ZGV4IDRhZTgwN2U3Y2Y3OS4uMTIwM2Y3NmIzNjA0IDEwMDY0NAotLS0gYS9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktZHJhN3h4LmMKKysrIGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWRyYTd4eC5jCkBAIC00MDQsMTYgKzQwNCwxNiBAQCBzdGF0aWMgdm9p
ZCBkcmE3eHhfcGNpZV9yYWlzZV9tc2lfaXJxKHN0cnVjdCBkcmE3eHhfcGNpZSAqZHJhN3h4
LAogfQogCiBzdGF0aWMgaW50IGRyYTd4eF9wY2llX3JhaXNlX2lycShzdHJ1Y3QgZHdfcGNp
ZV9lcCAqZXAsIHU4IGZ1bmNfbm8sCi0JCQkJIGVudW0gcGNpX2VwY19pcnFfdHlwZSB0eXBl
LCB1MTYgaW50ZXJydXB0X251bSkKKwkJCQkgdW5zaWduZWQgaW50IHR5cGUsIHUxNiBpbnRl
cnJ1cHRfbnVtKQogewogCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19wY2llX2Zyb21f
ZXAoZXApOwogCXN0cnVjdCBkcmE3eHhfcGNpZSAqZHJhN3h4ID0gdG9fZHJhN3h4X3BjaWUo
cGNpKTsKIAogCXN3aXRjaCAodHlwZSkgewotCWNhc2UgUENJX0VQQ19JUlFfTEVHQUNZOgor
CWNhc2UgUENJX0lSUV9MRUdBQ1k6CiAJCWRyYTd4eF9wY2llX3JhaXNlX2xlZ2FjeV9pcnEo
ZHJhN3h4KTsKIAkJYnJlYWs7Ci0JY2FzZSBQQ0lfRVBDX0lSUV9NU0k6CisJY2FzZSBQQ0lf
SVJRX01TSToKIAkJZHJhN3h4X3BjaWVfcmFpc2VfbXNpX2lycShkcmE3eHgsIGludGVycnVw
dF9udW0pOwogCQlicmVhazsKIAlkZWZhdWx0OgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaS1pbXg2LmMKaW5kZXggMjdhYWEyYTZiZjM5Li4yOTc1ZjNmYWNhNjEgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMKKysrIGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYwpAQCAtMTA1NywxNyArMTA1NywxNiBA
QCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfZXBfaW5pdChzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAp
CiB9CiAKIHN0YXRpYyBpbnQgaW14Nl9wY2llX2VwX3JhaXNlX2lycShzdHJ1Y3QgZHdfcGNp
ZV9lcCAqZXAsIHU4IGZ1bmNfbm8sCi0JCQkJICBlbnVtIHBjaV9lcGNfaXJxX3R5cGUgdHlw
ZSwKLQkJCQkgIHUxNiBpbnRlcnJ1cHRfbnVtKQorCQkJCSAgdW5zaWduZWQgaW50IHR5cGUs
IHUxNiBpbnRlcnJ1cHRfbnVtKQogewogCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19w
Y2llX2Zyb21fZXAoZXApOwogCiAJc3dpdGNoICh0eXBlKSB7Ci0JY2FzZSBQQ0lfRVBDX0lS
UV9MRUdBQ1k6CisJY2FzZSBQQ0lfSVJRX0xFR0FDWToKIAkJcmV0dXJuIGR3X3BjaWVfZXBf
cmFpc2VfbGVnYWN5X2lycShlcCwgZnVuY19ubyk7Ci0JY2FzZSBQQ0lfRVBDX0lSUV9NU0k6
CisJY2FzZSBQQ0lfSVJRX01TSToKIAkJcmV0dXJuIGR3X3BjaWVfZXBfcmFpc2VfbXNpX2ly
cShlcCwgZnVuY19ubywgaW50ZXJydXB0X251bSk7Ci0JY2FzZSBQQ0lfRVBDX0lSUV9NU0lY
OgorCWNhc2UgUENJX0lSUV9NU0lYOgogCQlyZXR1cm4gZHdfcGNpZV9lcF9yYWlzZV9tc2l4
X2lycShlcCwgZnVuY19ubywgaW50ZXJydXB0X251bSk7CiAJZGVmYXVsdDoKIAkJZGV2X2Vy
cihwY2ktPmRldiwgIlVOS05PV04gSVJRIHR5cGVcbiIpOwpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWtleXN0b25lLmMgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2kta2V5c3RvbmUuYwppbmRleCA3ODgxODg1M2FmOWUuLmU2M2VhODgw
NTFjMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWtleXN0
b25lLmMKKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWtleXN0b25lLmMK
QEAgLTkwMSwyMCArOTAxLDE5IEBAIHN0YXRpYyB2b2lkIGtzX3BjaWVfYW02NTRfcmFpc2Vf
bGVnYWN5X2lycShzdHJ1Y3Qga2V5c3RvbmVfcGNpZSAqa3NfcGNpZSkKIH0KIAogc3RhdGlj
IGludCBrc19wY2llX2FtNjU0X3JhaXNlX2lycShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4
IGZ1bmNfbm8sCi0JCQkJICAgZW51bSBwY2lfZXBjX2lycV90eXBlIHR5cGUsCi0JCQkJICAg
dTE2IGludGVycnVwdF9udW0pCisJCQkJICAgdW5zaWduZWQgaW50IHR5cGUsIHUxNiBpbnRl
cnJ1cHRfbnVtKQogewogCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19wY2llX2Zyb21f
ZXAoZXApOwogCXN0cnVjdCBrZXlzdG9uZV9wY2llICprc19wY2llID0gdG9fa2V5c3RvbmVf
cGNpZShwY2kpOwogCiAJc3dpdGNoICh0eXBlKSB7Ci0JY2FzZSBQQ0lfRVBDX0lSUV9MRUdB
Q1k6CisJY2FzZSBQQ0lfSVJRX0xFR0FDWToKIAkJa3NfcGNpZV9hbTY1NF9yYWlzZV9sZWdh
Y3lfaXJxKGtzX3BjaWUpOwogCQlicmVhazsKLQljYXNlIFBDSV9FUENfSVJRX01TSToKKwlj
YXNlIFBDSV9JUlFfTVNJOgogCQlkd19wY2llX2VwX3JhaXNlX21zaV9pcnEoZXAsIGZ1bmNf
bm8sIGludGVycnVwdF9udW0pOwogCQlicmVhazsKLQljYXNlIFBDSV9FUENfSVJRX01TSVg6
CisJY2FzZSBQQ0lfSVJRX01TSVg6CiAJCWR3X3BjaWVfZXBfcmFpc2VfbXNpeF9pcnEoZXAs
IGZ1bmNfbm8sIGludGVycnVwdF9udW0pOwogCQlicmVhazsKIAlkZWZhdWx0OgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUtZXAuYyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMKaW5kZXgg
ZGU0YzE3NThhNmMzLi43OTRlMGJkMTk5YjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMKKysrIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUtZXAuYwpAQCAtMTUwLDE2ICsxNTAsMTYgQEAg
c3RhdGljIHZvaWQgbHNfcGNpZV9lcF9pbml0KHN0cnVjdCBkd19wY2llX2VwICplcCkKIH0K
IAogc3RhdGljIGludCBsc19wY2llX2VwX3JhaXNlX2lycShzdHJ1Y3QgZHdfcGNpZV9lcCAq
ZXAsIHU4IGZ1bmNfbm8sCi0JCQkJZW51bSBwY2lfZXBjX2lycV90eXBlIHR5cGUsIHUxNiBp
bnRlcnJ1cHRfbnVtKQorCQkJCXVuc2lnbmVkIGludCB0eXBlLCB1MTYgaW50ZXJydXB0X251
bSkKIHsKIAlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNpZV9mcm9tX2VwKGVwKTsK
IAogCXN3aXRjaCAodHlwZSkgewotCWNhc2UgUENJX0VQQ19JUlFfTEVHQUNZOgorCWNhc2Ug
UENJX0lSUV9MRUdBQ1k6CiAJCXJldHVybiBkd19wY2llX2VwX3JhaXNlX2xlZ2FjeV9pcnEo
ZXAsIGZ1bmNfbm8pOwotCWNhc2UgUENJX0VQQ19JUlFfTVNJOgorCWNhc2UgUENJX0lSUV9N
U0k6CiAJCXJldHVybiBkd19wY2llX2VwX3JhaXNlX21zaV9pcnEoZXAsIGZ1bmNfbm8sIGlu
dGVycnVwdF9udW0pOwotCWNhc2UgUENJX0VQQ19JUlFfTVNJWDoKKwljYXNlIFBDSV9JUlFf
TVNJWDoKIAkJcmV0dXJuIGR3X3BjaWVfZXBfcmFpc2VfbXNpeF9pcnFfZG9vcmJlbGwoZXAs
IGZ1bmNfbm8sCiAJCQkJCQkJICBpbnRlcnJ1cHRfbnVtKTsKIAlkZWZhdWx0OgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1hcnRwZWM2LmMgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFydHBlYzYuYwppbmRleCA5ODEwMjA3OWUy
NmQuLmU4NDc0OGI4MmZlZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1hcnRwZWM2LmMKKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1hcnRwZWM2LmMKQEAgLTM1MiwxNSArMzUyLDE1IEBAIHN0YXRpYyB2b2lkIGFydHBlYzZf
cGNpZV9lcF9pbml0KHN0cnVjdCBkd19wY2llX2VwICplcCkKIH0KIAogc3RhdGljIGludCBh
cnRwZWM2X3BjaWVfcmFpc2VfaXJxKHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19u
bywKLQkJCQkgIGVudW0gcGNpX2VwY19pcnFfdHlwZSB0eXBlLCB1MTYgaW50ZXJydXB0X251
bSkKKwkJCQkgIHVuc2lnbmVkIGludCB0eXBlLCB1MTYgaW50ZXJydXB0X251bSkKIHsKIAlz
dHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNpZV9mcm9tX2VwKGVwKTsKIAogCXN3aXRj
aCAodHlwZSkgewotCWNhc2UgUENJX0VQQ19JUlFfTEVHQUNZOgorCWNhc2UgUENJX0lSUV9M
RUdBQ1k6CiAJCWRldl9lcnIocGNpLT5kZXYsICJFUCBjYW5ub3QgdHJpZ2dlciBsZWdhY3kg
SVJRc1xuIik7CiAJCXJldHVybiAtRUlOVkFMOwotCWNhc2UgUENJX0VQQ19JUlFfTVNJOgor
CWNhc2UgUENJX0lSUV9NU0k6CiAJCXJldHVybiBkd19wY2llX2VwX3JhaXNlX21zaV9pcnEo
ZXAsIGZ1bmNfbm8sIGludGVycnVwdF9udW0pOwogCWRlZmF1bHQ6CiAJCWRldl9lcnIocGNp
LT5kZXYsICJVTktOT1dOIElSUSB0eXBlXG4iKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMKaW5kZXggZjkxODJmOGQ1NTJmLi5h
Yjg3ZWEzYjA5ODYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS1lcC5jCisrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS1lcC5jCkBAIC00MjYsNyArNDI2LDcgQEAgc3RhdGljIGludCBkd19w
Y2llX2VwX3NldF9tc2l4KHN0cnVjdCBwY2lfZXBjICplcGMsIHU4IGZ1bmNfbm8sIHU4IHZm
dW5jX25vLAogfQogCiBzdGF0aWMgaW50IGR3X3BjaWVfZXBfcmFpc2VfaXJxKHN0cnVjdCBw
Y2lfZXBjICplcGMsIHU4IGZ1bmNfbm8sIHU4IHZmdW5jX25vLAotCQkJCWVudW0gcGNpX2Vw
Y19pcnFfdHlwZSB0eXBlLCB1MTYgaW50ZXJydXB0X251bSkKKwkJCQl1bnNpZ25lZCBpbnQg
dHlwZSwgdTE2IGludGVycnVwdF9udW0pCiB7CiAJc3RydWN0IGR3X3BjaWVfZXAgKmVwID0g
ZXBjX2dldF9kcnZkYXRhKGVwYyk7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1wbGF0LmMgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtcGxhdC5jCmluZGV4IDFmY2ZiODQwZjIzOC4uOTg3
MWM0OWIwMzgzIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWRlc2lnbndhcmUtcGxhdC5jCisrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS1wbGF0LmMKQEAgLTQyLDE3ICs0MiwxNiBAQCBzdGF0aWMgdm9pZCBk
d19wbGF0X3BjaWVfZXBfaW5pdChzdHJ1Y3QgZHdfcGNpZV9lcCAqZXApCiB9CiAKIHN0YXRp
YyBpbnQgZHdfcGxhdF9wY2llX2VwX3JhaXNlX2lycShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAs
IHU4IGZ1bmNfbm8sCi0JCQkJICAgICBlbnVtIHBjaV9lcGNfaXJxX3R5cGUgdHlwZSwKLQkJ
CQkgICAgIHUxNiBpbnRlcnJ1cHRfbnVtKQorCQkJCSAgICAgdW5zaWduZWQgaW50IHR5cGUs
IHUxNiBpbnRlcnJ1cHRfbnVtKQogewogCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19w
Y2llX2Zyb21fZXAoZXApOwogCiAJc3dpdGNoICh0eXBlKSB7Ci0JY2FzZSBQQ0lfRVBDX0lS
UV9MRUdBQ1k6CisJY2FzZSBQQ0lfSVJRX0xFR0FDWToKIAkJcmV0dXJuIGR3X3BjaWVfZXBf
cmFpc2VfbGVnYWN5X2lycShlcCwgZnVuY19ubyk7Ci0JY2FzZSBQQ0lfRVBDX0lSUV9NU0k6
CisJY2FzZSBQQ0lfSVJRX01TSToKIAkJcmV0dXJuIGR3X3BjaWVfZXBfcmFpc2VfbXNpX2ly
cShlcCwgZnVuY19ubywgaW50ZXJydXB0X251bSk7Ci0JY2FzZSBQQ0lfRVBDX0lSUV9NU0lY
OgorCWNhc2UgUENJX0lSUV9NU0lYOgogCQlyZXR1cm4gZHdfcGNpZV9lcF9yYWlzZV9tc2l4
X2lycShlcCwgZnVuY19ubywgaW50ZXJydXB0X251bSk7CiAJZGVmYXVsdDoKIAkJZGV2X2Vy
cihwY2ktPmRldiwgIlVOS05PV04gSVJRIHR5cGVcbiIpOwpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaAppbmRleCA2MTU2NjA2NDA4MDEuLmUw
MzkwODFlYjk0NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLmgKKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLmgKQEAgLTMyMCw3ICszMjAsNyBAQCBzdHJ1Y3QgZHdfcGNpZV9ycCB7CiBz
dHJ1Y3QgZHdfcGNpZV9lcF9vcHMgewogCXZvaWQJKCplcF9pbml0KShzdHJ1Y3QgZHdfcGNp
ZV9lcCAqZXApOwogCWludAkoKnJhaXNlX2lycSkoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1
OCBmdW5jX25vLAotCQkJICAgICBlbnVtIHBjaV9lcGNfaXJxX3R5cGUgdHlwZSwgdTE2IGlu
dGVycnVwdF9udW0pOworCQkJICAgICB1bnNpZ25lZCBpbnQgdHlwZSwgdTE2IGludGVycnVw
dF9udW0pOwogCWNvbnN0IHN0cnVjdCBwY2lfZXBjX2ZlYXR1cmVzKiAoKmdldF9mZWF0dXJl
cykoc3RydWN0IGR3X3BjaWVfZXAgKmVwKTsKIAkvKgogCSAqIFByb3ZpZGUgYSBtZXRob2Qg
dG8gaW1wbGVtZW50IHRoZSBkaWZmZXJlbnQgZnVuYyBjb25maWcgc3BhY2UKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUta2VlbWJheS5jIGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1rZWVtYmF5LmMKaW5kZXggZjkwZjM2YmFjMDE4
Li5jOTNmZDc5ZDQwMGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUta2VlbWJheS5jCisrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
a2VlbWJheS5jCkBAIC0yODQsMTkgKzI4NCwxOCBAQCBzdGF0aWMgdm9pZCBrZWVtYmF5X3Bj
aWVfZXBfaW5pdChzdHJ1Y3QgZHdfcGNpZV9lcCAqZXApCiB9CiAKIHN0YXRpYyBpbnQga2Vl
bWJheV9wY2llX2VwX3JhaXNlX2lycShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1bmNf
bm8sCi0JCQkJICAgICBlbnVtIHBjaV9lcGNfaXJxX3R5cGUgdHlwZSwKLQkJCQkgICAgIHUx
NiBpbnRlcnJ1cHRfbnVtKQorCQkJCSAgICAgdW5zaWduZWQgaW50IHR5cGUsIHUxNiBpbnRl
cnJ1cHRfbnVtKQogewogCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19wY2llX2Zyb21f
ZXAoZXApOwogCiAJc3dpdGNoICh0eXBlKSB7Ci0JY2FzZSBQQ0lfRVBDX0lSUV9MRUdBQ1k6
CisJY2FzZSBQQ0lfSVJRX0xFR0FDWToKIAkJLyogTGVnYWN5IGludGVycnVwdHMgYXJlIG5v
dCBzdXBwb3J0ZWQgaW4gS2VlbSBCYXkgKi8KIAkJZGV2X2VycihwY2ktPmRldiwgIkxlZ2Fj
eSBJUlEgaXMgbm90IHN1cHBvcnRlZFxuIik7CiAJCXJldHVybiAtRUlOVkFMOwotCWNhc2Ug
UENJX0VQQ19JUlFfTVNJOgorCWNhc2UgUENJX0lSUV9NU0k6CiAJCXJldHVybiBkd19wY2ll
X2VwX3JhaXNlX21zaV9pcnEoZXAsIGZ1bmNfbm8sIGludGVycnVwdF9udW0pOwotCWNhc2Ug
UENJX0VQQ19JUlFfTVNJWDoKKwljYXNlIFBDSV9JUlFfTVNJWDoKIAkJcmV0dXJuIGR3X3Bj
aWVfZXBfcmFpc2VfbXNpeF9pcnEoZXAsIGZ1bmNfbm8sIGludGVycnVwdF9udW0pOwogCWRl
ZmF1bHQ6CiAJCWRldl9lcnIocGNpLT5kZXYsICJVbmtub3duIElSUSB0eXBlICVkXG4iLCB0
eXBlKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNv
bS1lcC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1xY29tLWVwLmMKaW5k
ZXggMGZlN2YwNmYyMTAyLi4zZmFhYmM2NmYwN2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS1lcC5jCisrKyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtcWNvbS1lcC5jCkBAIC02NTUsMTQgKzY1NSwxNCBAQCBzdGF0aWMg
aW50IHFjb21fcGNpZV9lcF9lbmFibGVfaXJxX3Jlc291cmNlcyhzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2LAogfQogCiBzdGF0aWMgaW50IHFjb21fcGNpZV9lcF9yYWlzZV9pcnEo
c3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25vLAotCQkJCSAgZW51bSBwY2lfZXBj
X2lycV90eXBlIHR5cGUsIHUxNiBpbnRlcnJ1cHRfbnVtKQorCQkJCSAgdW5zaWduZWQgaW50
IHR5cGUsIHUxNiBpbnRlcnJ1cHRfbnVtKQogewogCXN0cnVjdCBkd19wY2llICpwY2kgPSB0
b19kd19wY2llX2Zyb21fZXAoZXApOwogCiAJc3dpdGNoICh0eXBlKSB7Ci0JY2FzZSBQQ0lf
RVBDX0lSUV9MRUdBQ1k6CisJY2FzZSBQQ0lfSVJRX0xFR0FDWToKIAkJcmV0dXJuIGR3X3Bj
aWVfZXBfcmFpc2VfbGVnYWN5X2lycShlcCwgZnVuY19ubyk7Ci0JY2FzZSBQQ0lfRVBDX0lS
UV9NU0k6CisJY2FzZSBQQ0lfSVJRX01TSToKIAkJcmV0dXJuIGR3X3BjaWVfZXBfcmFpc2Vf
bXNpX2lycShlcCwgZnVuY19ubywgaW50ZXJydXB0X251bSk7CiAJZGVmYXVsdDoKIAkJZGV2
X2VycihwY2ktPmRldiwgIlVua25vd24gSVJRIHR5cGVcbiIpOwpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jCmluZGV4IGUxZGI5MDlmNTNlYy4uY2Fm
Y2VmMGRhMjIzIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LXRlZ3JhMTk0LmMKKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdy
YTE5NC5jCkBAIC0xOTkzLDIwICsxOTkzLDE5IEBAIHN0YXRpYyBpbnQgdGVncmFfcGNpZV9l
cF9yYWlzZV9tc2l4X2lycShzdHJ1Y3QgdGVncmFfcGNpZV9kdyAqcGNpZSwgdTE2IGlycSkK
IH0KIAogc3RhdGljIGludCB0ZWdyYV9wY2llX2VwX3JhaXNlX2lycShzdHJ1Y3QgZHdfcGNp
ZV9lcCAqZXAsIHU4IGZ1bmNfbm8sCi0JCQkJICAgZW51bSBwY2lfZXBjX2lycV90eXBlIHR5
cGUsCi0JCQkJICAgdTE2IGludGVycnVwdF9udW0pCisJCQkJICAgdW5zaWduZWQgaW50IHR5
cGUsIHUxNiBpbnRlcnJ1cHRfbnVtKQogewogCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19k
d19wY2llX2Zyb21fZXAoZXApOwogCXN0cnVjdCB0ZWdyYV9wY2llX2R3ICpwY2llID0gdG9f
dGVncmFfcGNpZShwY2kpOwogCiAJc3dpdGNoICh0eXBlKSB7Ci0JY2FzZSBQQ0lfRVBDX0lS
UV9MRUdBQ1k6CisJY2FzZSBQQ0lfSVJRX0xFR0FDWToKIAkJcmV0dXJuIHRlZ3JhX3BjaWVf
ZXBfcmFpc2VfbGVnYWN5X2lycShwY2llLCBpbnRlcnJ1cHRfbnVtKTsKIAotCWNhc2UgUENJ
X0VQQ19JUlFfTVNJOgorCWNhc2UgUENJX0lSUV9NU0k6CiAJCXJldHVybiB0ZWdyYV9wY2ll
X2VwX3JhaXNlX21zaV9pcnEocGNpZSwgaW50ZXJydXB0X251bSk7CiAKLQljYXNlIFBDSV9F
UENfSVJRX01TSVg6CisJY2FzZSBQQ0lfSVJRX01TSVg6CiAJCXJldHVybiB0ZWdyYV9wY2ll
X2VwX3JhaXNlX21zaXhfaXJxKHBjaWUsIGludGVycnVwdF9udW0pOwogCiAJZGVmYXVsdDoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdW5pcGhpZXIt
ZXAuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdW5pcGhpZXItZXAuYwpp
bmRleCA0ZDBhNTg3YzBiYTUuLjQzYzI3MTM4YzNjNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS11bmlwaGllci1lcC5jCisrKyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtdW5pcGhpZXItZXAuYwpAQCAtMjU2LDE1ICsyNTYsMTQg
QEAgc3RhdGljIGludCB1bmlwaGllcl9wY2llX2VwX3JhaXNlX21zaV9pcnEoc3RydWN0IGR3
X3BjaWVfZXAgKmVwLAogfQogCiBzdGF0aWMgaW50IHVuaXBoaWVyX3BjaWVfZXBfcmFpc2Vf
aXJxKHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19ubywKLQkJCQkgICAgICBlbnVt
IHBjaV9lcGNfaXJxX3R5cGUgdHlwZSwKLQkJCQkgICAgICB1MTYgaW50ZXJydXB0X251bSkK
KwkJCQkgICAgICB1bnNpZ25lZCBpbnQgdHlwZSwgdTE2IGludGVycnVwdF9udW0pCiB7CiAJ
c3RydWN0IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJvbV9lcChlcCk7CiAKIAlzd2l0
Y2ggKHR5cGUpIHsKLQljYXNlIFBDSV9FUENfSVJRX0xFR0FDWToKKwljYXNlIFBDSV9JUlFf
TEVHQUNZOgogCQlyZXR1cm4gdW5pcGhpZXJfcGNpZV9lcF9yYWlzZV9sZWdhY3lfaXJxKGVw
KTsKLQljYXNlIFBDSV9FUENfSVJRX01TSToKKwljYXNlIFBDSV9JUlFfTVNJOgogCQlyZXR1
cm4gdW5pcGhpZXJfcGNpZV9lcF9yYWlzZV9tc2lfaXJxKGVwLCBmdW5jX25vLAogCQkJCQkJ
ICAgICAgaW50ZXJydXB0X251bSk7CiAJZGVmYXVsdDoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvcGNpZS1yY2FyLWVwLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaWUtcmNhci1lcC5jCmluZGV4IGY5NjgyZGYxZGE2MS4uMjE3MmRiMjM0M2Q5IDEwMDY0
NAotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcmNhci1lcC5jCisrKyBiL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1yY2FyLWVwLmMKQEAgLTQwMiwxNiArNDAyLDE1
IEBAIHN0YXRpYyBpbnQgcmNhcl9wY2llX2VwX2Fzc2VydF9tc2koc3RydWN0IHJjYXJfcGNp
ZSAqcGNpZSwKIH0KIAogc3RhdGljIGludCByY2FyX3BjaWVfZXBfcmFpc2VfaXJxKHN0cnVj
dCBwY2lfZXBjICplcGMsIHU4IGZuLCB1OCB2Zm4sCi0JCQkJICBlbnVtIHBjaV9lcGNfaXJx
X3R5cGUgdHlwZSwKLQkJCQkgIHUxNiBpbnRlcnJ1cHRfbnVtKQorCQkJCSAgdW5zaWduZWQg
aW50IHR5cGUsIHUxNiBpbnRlcnJ1cHRfbnVtKQogewogCXN0cnVjdCByY2FyX3BjaWVfZW5k
cG9pbnQgKmVwID0gZXBjX2dldF9kcnZkYXRhKGVwYyk7CiAKIAlzd2l0Y2ggKHR5cGUpIHsK
LQljYXNlIFBDSV9FUENfSVJRX0xFR0FDWToKKwljYXNlIFBDSV9JUlFfTEVHQUNZOgogCQly
ZXR1cm4gcmNhcl9wY2llX2VwX2Fzc2VydF9pbnR4KGVwLCBmbiwgMCk7CiAKLQljYXNlIFBD
SV9FUENfSVJRX01TSToKKwljYXNlIFBDSV9JUlFfTVNJOgogCQlyZXR1cm4gcmNhcl9wY2ll
X2VwX2Fzc2VydF9tc2koJmVwLT5wY2llLCBmbiwgaW50ZXJydXB0X251bSk7CiAKIAlkZWZh
dWx0OgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXJvY2tjaGlw
LWVwLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcm9ja2NoaXAtZXAuYwppbmRl
eCAwYWYwZTk2NWZiNTcuLjM5N2FkNTUxYzkxMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2llLXJvY2tjaGlwLWVwLmMKKysrIGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLXJvY2tjaGlwLWVwLmMKQEAgLTQwNywxNSArNDA3LDE0IEBAIHN0YXRpYyBp
bnQgcm9ja2NoaXBfcGNpZV9lcF9zZW5kX21zaV9pcnEoc3RydWN0IHJvY2tjaGlwX3BjaWVf
ZXAgKmVwLCB1OCBmbiwKIH0KIAogc3RhdGljIGludCByb2NrY2hpcF9wY2llX2VwX3JhaXNl
X2lycShzdHJ1Y3QgcGNpX2VwYyAqZXBjLCB1OCBmbiwgdTggdmZuLAotCQkJCSAgICAgIGVu
dW0gcGNpX2VwY19pcnFfdHlwZSB0eXBlLAotCQkJCSAgICAgIHUxNiBpbnRlcnJ1cHRfbnVt
KQorCQkJCSAgICAgIHVuc2lnbmVkIGludCB0eXBlLCB1MTYgaW50ZXJydXB0X251bSkKIHsK
IAlzdHJ1Y3Qgcm9ja2NoaXBfcGNpZV9lcCAqZXAgPSBlcGNfZ2V0X2RydmRhdGEoZXBjKTsK
IAogCXN3aXRjaCAodHlwZSkgewotCWNhc2UgUENJX0VQQ19JUlFfTEVHQUNZOgorCWNhc2Ug
UENJX0lSUV9MRUdBQ1k6CiAJCXJldHVybiByb2NrY2hpcF9wY2llX2VwX3NlbmRfbGVnYWN5
X2lycShlcCwgZm4sIDApOwotCWNhc2UgUENJX0VQQ19JUlFfTVNJOgorCWNhc2UgUENJX0lS
UV9NU0k6CiAJCXJldHVybiByb2NrY2hpcF9wY2llX2VwX3NlbmRfbXNpX2lycShlcCwgZm4s
IGludGVycnVwdF9udW0pOwogCWRlZmF1bHQ6CiAJCXJldHVybiAtRUlOVkFMOwpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtbWhpLmMgYi9k
cml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi1taGkuYwppbmRleCBkZGYw
YmFjZTRlMTguLmYyZmNkYTFjNWQ0ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvZW5kcG9p
bnQvZnVuY3Rpb25zL3BjaS1lcGYtbWhpLmMKKysrIGIvZHJpdmVycy9wY2kvZW5kcG9pbnQv
ZnVuY3Rpb25zL3BjaS1lcGYtbWhpLmMKQEAgLTE3Nyw3ICsxNzcsNyBAQCBzdGF0aWMgdm9p
ZCBwY2lfZXBmX21oaV9yYWlzZV9pcnEoc3RydWN0IG1oaV9lcF9jbnRybCAqbWhpX2NudHJs
LCB1MzIgdmVjdG9yKQogCSAqIE1ISSBzdXBwbGllcyAwIGJhc2VkIE1TSSB2ZWN0b3JzIGJ1
dCB0aGUgQVBJIGV4cGVjdHMgdGhlIHZlY3RvcgogCSAqIG51bWJlciB0byBzdGFydCBmcm9t
IDEsIHNvIHdlIG5lZWQgdG8gaW5jcmVtZW50IHRoZSB2ZWN0b3IgYnkgMS4KIAkgKi8KLQlw
Y2lfZXBjX3JhaXNlX2lycShlcGMsIGVwZi0+ZnVuY19ubywgZXBmLT52ZnVuY19ubywgUENJ
X0VQQ19JUlFfTVNJLAorCXBjaV9lcGNfcmFpc2VfaXJxKGVwYywgZXBmLT5mdW5jX25vLCBl
cGYtPnZmdW5jX25vLCBQQ0lfSVJRX01TSSwKIAkJCSAgdmVjdG9yICsgMSk7CiB9CiAKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLW50Yi5j
IGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtbnRiLmMKaW5kZXgg
OWFhYzJjNmYzYmI5Li5mYWQwMGIxYTgzMzUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL2Vu
ZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLW50Yi5jCisrKyBiL2RyaXZlcnMvcGNpL2VuZHBv
aW50L2Z1bmN0aW9ucy9wY2ktZXBmLW50Yi5jCkBAIC0xNDAsOSArMTQwLDkgQEAgc3RhdGlj
IHN0cnVjdCBwY2lfZXBmX2hlYWRlciBlcGZfbnRiX2hlYWRlciA9IHsKIHN0YXRpYyBpbnQg
ZXBmX250Yl9saW5rX3VwKHN0cnVjdCBlcGZfbnRiICpudGIsIGJvb2wgbGlua191cCkKIHsK
IAllbnVtIHBjaV9lcGNfaW50ZXJmYWNlX3R5cGUgdHlwZTsKLQllbnVtIHBjaV9lcGNfaXJx
X3R5cGUgaXJxX3R5cGU7CiAJc3RydWN0IGVwZl9udGJfZXBjICpudGJfZXBjOwogCXN0cnVj
dCBlcGZfbnRiX2N0cmwgKmN0cmw7CisJdW5zaWduZWQgaW50IGlycV90eXBlOwogCXN0cnVj
dCBwY2lfZXBjICplcGM7CiAJdTggZnVuY19ubywgdmZ1bmNfbm87CiAJYm9vbCBpc19tc2l4
OwpAQCAtMTU5LDcgKzE1OSw3IEBAIHN0YXRpYyBpbnQgZXBmX250Yl9saW5rX3VwKHN0cnVj
dCBlcGZfbnRiICpudGIsIGJvb2wgbGlua191cCkKIAkJCWN0cmwtPmxpbmtfc3RhdHVzIHw9
IExJTktfU1RBVFVTX1VQOwogCQllbHNlCiAJCQljdHJsLT5saW5rX3N0YXR1cyAmPSB+TElO
S19TVEFUVVNfVVA7Ci0JCWlycV90eXBlID0gaXNfbXNpeCA/IFBDSV9FUENfSVJRX01TSVgg
OiBQQ0lfRVBDX0lSUV9NU0k7CisJCWlycV90eXBlID0gaXNfbXNpeCA/IFBDSV9JUlFfTVNJ
WCA6IFBDSV9JUlFfTVNJOwogCQlyZXQgPSBwY2lfZXBjX3JhaXNlX2lycShlcGMsIGZ1bmNf
bm8sIHZmdW5jX25vLCBpcnFfdHlwZSwgMSk7CiAJCWlmIChyZXQpIHsKIAkJCWRldl9lcnIo
JmVwYy0+ZGV2LApkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25z
L3BjaS1lcGYtdGVzdC5jIGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1l
cGYtdGVzdC5jCmluZGV4IGZhOTkzZTcxYzIyNC4uNzZkZGY0YzkyNTExIDEwMDY0NAotLS0g
YS9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi10ZXN0LmMKKysrIGIv
ZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdGVzdC5jCkBAIC02MDIs
NyArNjAyLDcgQEAgc3RhdGljIHZvaWQgcGNpX2VwZl90ZXN0X3JhaXNlX2lycShzdHJ1Y3Qg
cGNpX2VwZl90ZXN0ICplcGZfdGVzdCwKIAlzd2l0Y2ggKHJlZy0+aXJxX3R5cGUpIHsKIAlj
YXNlIElSUV9UWVBFX0xFR0FDWToKIAkJcGNpX2VwY19yYWlzZV9pcnEoZXBjLCBlcGYtPmZ1
bmNfbm8sIGVwZi0+dmZ1bmNfbm8sCi0JCQkJICBQQ0lfRVBDX0lSUV9MRUdBQ1ksIDApOwor
CQkJCSAgUENJX0lSUV9MRUdBQ1ksIDApOwogCQlicmVhazsKIAljYXNlIElSUV9UWVBFX01T
SToKIAkJY291bnQgPSBwY2lfZXBjX2dldF9tc2koZXBjLCBlcGYtPmZ1bmNfbm8sIGVwZi0+
dmZ1bmNfbm8pOwpAQCAtNjEyLDcgKzYxMiw3IEBAIHN0YXRpYyB2b2lkIHBjaV9lcGZfdGVz
dF9yYWlzZV9pcnEoc3RydWN0IHBjaV9lcGZfdGVzdCAqZXBmX3Rlc3QsCiAJCQlyZXR1cm47
CiAJCX0KIAkJcGNpX2VwY19yYWlzZV9pcnEoZXBjLCBlcGYtPmZ1bmNfbm8sIGVwZi0+dmZ1
bmNfbm8sCi0JCQkJICBQQ0lfRVBDX0lSUV9NU0ksIHJlZy0+aXJxX251bWJlcik7CisJCQkJ
ICBQQ0lfSVJRX01TSSwgcmVnLT5pcnFfbnVtYmVyKTsKIAkJYnJlYWs7CiAJY2FzZSBJUlFf
VFlQRV9NU0lYOgogCQljb3VudCA9IHBjaV9lcGNfZ2V0X21zaXgoZXBjLCBlcGYtPmZ1bmNf
bm8sIGVwZi0+dmZ1bmNfbm8pOwpAQCAtNjIyLDcgKzYyMiw3IEBAIHN0YXRpYyB2b2lkIHBj
aV9lcGZfdGVzdF9yYWlzZV9pcnEoc3RydWN0IHBjaV9lcGZfdGVzdCAqZXBmX3Rlc3QsCiAJ
CQlyZXR1cm47CiAJCX0KIAkJcGNpX2VwY19yYWlzZV9pcnEoZXBjLCBlcGYtPmZ1bmNfbm8s
IGVwZi0+dmZ1bmNfbm8sCi0JCQkJICBQQ0lfRVBDX0lSUV9NU0lYLCByZWctPmlycV9udW1i
ZXIpOworCQkJCSAgUENJX0lSUV9NU0lYLCByZWctPmlycV9udW1iZXIpOwogCQlicmVhazsK
IAlkZWZhdWx0OgogCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byByYWlzZSBJUlEsIHVua25v
d24gdHlwZVxuIik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlv
bnMvcGNpLWVwZi12bnRiLmMgYi9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNp
LWVwZi12bnRiLmMKaW5kZXggYzhiNDIzYzNjMjZlLi5iYTJmZTBiYjQwMGEgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYworKysg
Yi9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12bnRiLmMKQEAgLTEx
NzIsMTEgKzExNzIsOCBAQCBzdGF0aWMgaW50IHZudGJfZXBmX3BlZXJfZGJfc2V0KHN0cnVj
dCBudGJfZGV2ICpuZGV2LCB1NjQgZGJfYml0cykKIAlmdW5jX25vID0gbnRiLT5lcGYtPmZ1
bmNfbm87CiAJdmZ1bmNfbm8gPSBudGItPmVwZi0+dmZ1bmNfbm87CiAKLQlyZXQgPSBwY2lf
ZXBjX3JhaXNlX2lycShudGItPmVwZi0+ZXBjLAotCQkJCWZ1bmNfbm8sCi0JCQkJdmZ1bmNf
bm8sCi0JCQkJUENJX0VQQ19JUlFfTVNJLAotCQkJCWludGVycnVwdF9udW0gKyAxKTsKKwly
ZXQgPSBwY2lfZXBjX3JhaXNlX2lycShudGItPmVwZi0+ZXBjLCBmdW5jX25vLCB2ZnVuY19u
bywKKwkJCQlQQ0lfSVJRX01TSSwgaW50ZXJydXB0X251bSArIDEpOwogCWlmIChyZXQpCiAJ
CWRldl9lcnIoJm50Yi0+bnRiLmRldiwgIkZhaWxlZCB0byByYWlzZSBJUlFcbiIpOwogCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9lbmRwb2ludC9wY2ktZXBjLWNvcmUuYyBiL2RyaXZl
cnMvcGNpL2VuZHBvaW50L3BjaS1lcGMtY29yZS5jCmluZGV4IDZjNTRmYTU2ODRkMi4uODM1
ZDU2OTIyY2JiIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9lbmRwb2ludC9wY2ktZXBjLWNv
cmUuYworKysgYi9kcml2ZXJzL3BjaS9lbmRwb2ludC9wY2ktZXBjLWNvcmUuYwpAQCAtMjE4
LDcgKzIxOCw3IEBAIEVYUE9SVF9TWU1CT0xfR1BMKHBjaV9lcGNfc3RhcnQpOwogICogSW52
b2tlIHRvIHJhaXNlIGFuIGxlZ2FjeSwgTVNJIG9yIE1TSS1YIGludGVycnVwdAogICovCiBp
bnQgcGNpX2VwY19yYWlzZV9pcnEoc3RydWN0IHBjaV9lcGMgKmVwYywgdTggZnVuY19ubywg
dTggdmZ1bmNfbm8sCi0JCSAgICAgIGVudW0gcGNpX2VwY19pcnFfdHlwZSB0eXBlLCB1MTYg
aW50ZXJydXB0X251bSkKKwkJICAgICAgdW5zaWduZWQgaW50IHR5cGUsIHUxNiBpbnRlcnJ1
cHRfbnVtKQogewogCWludCByZXQ7CiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGNp
LWVwYy5oIGIvaW5jbHVkZS9saW51eC9wY2ktZXBjLmgKaW5kZXggNWNiNjk0MDMxMDcyLi5m
NDk4ZjlhYTJhYjAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvcGNpLWVwYy5oCisrKyBi
L2luY2x1ZGUvbGludXgvcGNpLWVwYy5oCkBAIC0xOSwxMyArMTksNiBAQCBlbnVtIHBjaV9l
cGNfaW50ZXJmYWNlX3R5cGUgewogCVNFQ09OREFSWV9JTlRFUkZBQ0UsCiB9OwogCi1lbnVt
IHBjaV9lcGNfaXJxX3R5cGUgewotCVBDSV9FUENfSVJRX1VOS05PV04sCi0JUENJX0VQQ19J
UlFfTEVHQUNZLAotCVBDSV9FUENfSVJRX01TSSwKLQlQQ0lfRVBDX0lSUV9NU0lYLAotfTsK
LQogc3RhdGljIGlubGluZSBjb25zdCBjaGFyICoKIHBjaV9lcGNfaW50ZXJmYWNlX3N0cmlu
ZyhlbnVtIHBjaV9lcGNfaW50ZXJmYWNlX3R5cGUgdHlwZSkKIHsKQEAgLTc5LDcgKzcyLDcg
QEAgc3RydWN0IHBjaV9lcGNfb3BzIHsKIAkJCSAgICB1MTYgaW50ZXJydXB0cywgZW51bSBw
Y2lfYmFybm8sIHUzMiBvZmZzZXQpOwogCWludAkoKmdldF9tc2l4KShzdHJ1Y3QgcGNpX2Vw
YyAqZXBjLCB1OCBmdW5jX25vLCB1OCB2ZnVuY19ubyk7CiAJaW50CSgqcmFpc2VfaXJxKShz
dHJ1Y3QgcGNpX2VwYyAqZXBjLCB1OCBmdW5jX25vLCB1OCB2ZnVuY19ubywKLQkJCSAgICAg
ZW51bSBwY2lfZXBjX2lycV90eXBlIHR5cGUsIHUxNiBpbnRlcnJ1cHRfbnVtKTsKKwkJCSAg
ICAgdW5zaWduZWQgaW50IHR5cGUsIHUxNiBpbnRlcnJ1cHRfbnVtKTsKIAlpbnQJKCptYXBf
bXNpX2lycSkoc3RydWN0IHBjaV9lcGMgKmVwYywgdTggZnVuY19ubywgdTggdmZ1bmNfbm8s
CiAJCQkgICAgICAgcGh5c19hZGRyX3QgcGh5c19hZGRyLCB1OCBpbnRlcnJ1cHRfbnVtLAog
CQkJICAgICAgIHUzMiBlbnRyeV9zaXplLCB1MzIgKm1zaV9kYXRhLApAQCAtMjI5LDcgKzIy
Miw3IEBAIGludCBwY2lfZXBjX21hcF9tc2lfaXJxKHN0cnVjdCBwY2lfZXBjICplcGMsIHU4
IGZ1bmNfbm8sIHU4IHZmdW5jX25vLAogCQkJcGh5c19hZGRyX3QgcGh5c19hZGRyLCB1OCBp
bnRlcnJ1cHRfbnVtLAogCQkJdTMyIGVudHJ5X3NpemUsIHUzMiAqbXNpX2RhdGEsIHUzMiAq
bXNpX2FkZHJfb2Zmc2V0KTsKIGludCBwY2lfZXBjX3JhaXNlX2lycShzdHJ1Y3QgcGNpX2Vw
YyAqZXBjLCB1OCBmdW5jX25vLCB1OCB2ZnVuY19ubywKLQkJICAgICAgZW51bSBwY2lfZXBj
X2lycV90eXBlIHR5cGUsIHUxNiBpbnRlcnJ1cHRfbnVtKTsKKwkJICAgICAgdW5zaWduZWQg
aW50IHR5cGUsIHUxNiBpbnRlcnJ1cHRfbnVtKTsKIGludCBwY2lfZXBjX3N0YXJ0KHN0cnVj
dCBwY2lfZXBjICplcGMpOwogdm9pZCBwY2lfZXBjX3N0b3Aoc3RydWN0IHBjaV9lcGMgKmVw
Yyk7CiBjb25zdCBzdHJ1Y3QgcGNpX2VwY19mZWF0dXJlcyAqcGNpX2VwY19nZXRfZmVhdHVy
ZXMoc3RydWN0IHBjaV9lcGMgKmVwYywKLS0gCjIuNDEuMAoK

--------------6hZAHcSRh0mvN0jj5PooCif0--
