Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FBB6F354C
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 20:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjEAR77 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 13:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEAR77 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 13:59:59 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC9A1701;
        Mon,  1 May 2023 10:59:56 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2a8bbea12d7so27193251fa.3;
        Mon, 01 May 2023 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682963995; x=1685555995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LUj8HUmmFTfcWzzLfwf6Hzp+rt3esHZIRfUjX3jark=;
        b=fn7UrSNWRMML1H1Y8GQO8geL2uBd3+ILSh0TWCNppNCxfB7NRoCUszfoCkvwQ94mQQ
         tuExbjLC39LPaYK7idGuXXHuvWcnBzeWNp7WQqRe0YnXerCv5bv85hY5LyN9QVnD7z2Y
         6zLJgYQZgCEU+thHgEhinfe1fWhdM4Uo6MPkJlG3A75eIm/l3vnSzXIqsX71ill3gKKb
         huByxU4LZS/uKfWC607XdGspp8xNxFKH2TEaWlcvZHr7lZowopMu08boJ8uLB7ZXCN6k
         41oQXnGyrE+BHqwH//pWFal14H9FrYi6GO0m2FrHU+g76T+576evEr0AX96qDSOvmOcF
         dWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682963995; x=1685555995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LUj8HUmmFTfcWzzLfwf6Hzp+rt3esHZIRfUjX3jark=;
        b=fAxof9+zpY45LayIbN2Ok0uYdigAUMFrLFmiB7cXcLcHXYw2ijnJD2s0o7BV0uNzZp
         FcYcAd+L11Q2mrTxyTer8/jn8+3H/HZPWYvaMVY/xp/lK/yqz3Rxz0IGDsdWXiWHjN/f
         YF9T14X257lBPv8BMYOnWJckCzgDj2fyClSWgNK5CZ32BhkYmxfq4NqbWg2/X+yc6yLW
         NY7Y8LEasJRX+ETDMP4n5LNTzGC/daiygKpb3SvrM1FJuJxnM2dVWJZrvpGkFb7MKFc/
         lgpuF4ZdnodjH/LeTbEdUloWPDUCBNT5fD2sP5nh9egYvg7+F9Nvvs/aw9SR/+aKmYA7
         eBlQ==
X-Gm-Message-State: AC+VfDyxBX+htM/TKk3sKdXgDP8EODxZx8K7YlgQLVYiHVUA4veLvWRs
        EF+Gg67Ts9KCjqlcLs+46JE=
X-Google-Smtp-Source: ACHHUZ68yXPJlEwpnySMoQPMS5gBKduen5K3a50pJCfdvIgMiZFpOwMOe0CZsmzkzxHGI79h6GuzsA==
X-Received: by 2002:a2e:9188:0:b0:2a9:f94f:d2ff with SMTP id f8-20020a2e9188000000b002a9f94fd2ffmr3868743ljg.25.1682963994558;
        Mon, 01 May 2023 10:59:54 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id b23-20020a2e9897000000b002a93e0605ebsm4797840ljj.8.2023.05.01.10.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 10:59:53 -0700 (PDT)
Date:   Mon, 1 May 2023 20:59:51 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
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
        Heiko Stuebner <heiko@sntech.de>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH v14 04/21] PCI: Rename PCI_EPC_IRQ_LEGACY to
 PCI_EPC_IRQ_INTX
Message-ID: <20230501175951.qqqzxfrtfmii3ezy@mobilestation>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-5-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426045557.3613826-5-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 26, 2023 at 01:55:40PM +0900, Yoshihiro Shimoda wrote:
> Using "INTx" instead of "legacy" is more specific. So, rename
> PCI_EPC_IRQ_LEGACY to PCI_EPC_IRQ_INTX.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
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
> Cc: Serge Semin <fancer.lancer@gmail.com>
> Cc: Srikanth Thokala <srikanth.thokala@intel.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Kishon Vijay Abraham I <kishon@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com> # ARTPEC
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

LGTM. Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

>  drivers/pci/controller/pcie-rcar-ep.c             |  2 +-
>  drivers/pci/controller/pcie-rockchip-ep.c         |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c     | 12 ++++++------
>  include/linux/pci-epc.h                           |  4 ++--
>  15 files changed, 21 insertions(+), 21 deletions(-)
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
> index 4ae807e7cf79..b42fb1cc8bc8 100644
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
> index 52906f999f2b..1f39e733ce19 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1062,7 +1062,7 @@ static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
>  	case PCI_EPC_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 78818853af9e..3806f5530937 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -908,7 +908,7 @@ static int ks_pcie_am654_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		ks_pcie_am654_raise_legacy_irq(ks_pcie);
>  		break;
>  	case PCI_EPC_IRQ_MSI:
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index c640db60edc6..ab3306e206d8 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -65,7 +65,7 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
>  	case PCI_EPC_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index 98102079e26d..128cb1118e3a 100644
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
> index 1fcfb840f238..fc3b02949218 100644
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
> index f90f36bac018..ceb940b327cb 100644
> --- a/drivers/pci/controller/dwc/pcie-keembay.c
> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> @@ -290,7 +290,7 @@ static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		/* Legacy interrupts are not supported in Keem Bay */
>  		dev_err(pci->dev, "Legacy IRQ is not supported\n");
>  		return -EINVAL;
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 19b32839ea26..077afce48d0b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -658,7 +658,7 @@ static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
>  	case PCI_EPC_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 09825b4a075e..4adba379b83d 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1980,7 +1980,7 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		return tegra_pcie_ep_raise_legacy_irq(pcie, interrupt_num);
>  
>  	case PCI_EPC_IRQ_MSI:
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> index 4d0a587c0ba5..7787eedf87f4 100644
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
> index d1a200b93b2b..ef9d1f6c382a 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -477,7 +477,7 @@ static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
>  	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_EPC_IRQ_INTX:
>  		return rockchip_pcie_ep_send_legacy_irq(ep, fn, 0);
>  	case PCI_EPC_IRQ_MSI:
>  		return rockchip_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 172e5ac0bd96..36a2a8120653 100644
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
> @@ -606,9 +606,9 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq_type,
>  	reg->status |= STATUS_IRQ_RAISED;
>  
>  	switch (irq_type) {
> -	case IRQ_TYPE_LEGACY:
> +	case IRQ_TYPE_INTX:
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_EPC_IRQ_LEGACY, 0);
> +				  PCI_EPC_IRQ_INTX, 0);
>  		break;
>  	case IRQ_TYPE_MSI:
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> @@ -649,10 +649,10 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  		goto reset_handler;
>  	}
>  
> -	if (command & COMMAND_RAISE_LEGACY_IRQ) {
> +	if (command & COMMAND_RAISE_INTX_IRQ) {
>  		reg->status = STATUS_IRQ_RAISED;
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_EPC_IRQ_LEGACY, 0);
> +				  PCI_EPC_IRQ_INTX, 0);
>  		goto reset_handler;
>  	}
>  
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 301bb0e53707..c2572a93d73d 100644
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
> -- 
> 2.25.1
> 
