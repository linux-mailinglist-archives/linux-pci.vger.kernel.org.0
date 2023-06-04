Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AF2721B0E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 01:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjFDXWv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Jun 2023 19:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjFDXWu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jun 2023 19:22:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0325EA8;
        Sun,  4 Jun 2023 16:22:45 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b1af9ef7a9so31465401fa.1;
        Sun, 04 Jun 2023 16:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685920963; x=1688512963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2tV6aCCDr+64Sl9bt5cf9WYlQuY0ArW/ks3hvzgl0t0=;
        b=e5lnISQPb+KesZ3PeVd5RIYIf+hdP8Jl9o6tyfzjSaVFxGcaLL7mGg5SE0czNTHQU+
         J3WbG13zA89oPpHSY66O+pt6nF9NIBYd+zJxIvusv9Y/psNNjx92xEzdZd1nAyeF5/QA
         THtK9BdjWYQARseODW6opoAvK5vXe6lM9YMSSbvAV0lpmZU+8m/BgmSWvZ5LC/eLYBZx
         tgM669U+TQL2E+ekgKbjTsQA/bE5WCRfQCsEWZGkLOxVJESohrzTwV3wSOk/PSyxU7Sq
         Q27osACEtqTQRJOsErqIXKgL5OmMHznXpRoTjuOofXxfa7LMC/O9EHevsrmIweRUGS0i
         PsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685920963; x=1688512963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tV6aCCDr+64Sl9bt5cf9WYlQuY0ArW/ks3hvzgl0t0=;
        b=PDEUOkq+qaGcu6gvjHTEq8ZYDFtKOFcOnHPRH2+lhpetUZAwKntRSGteRVHB9G3LTr
         5pTMne2nn1DgnWdGyM0CfHShM2j6p6RCZIJmfNDXTyTL6fKfJI9d9aiS2lXN0QgUQoso
         mMGvWgUlEHXf4L94YhedgUtylU43PmFNqQbBU23J3wyP8/BAzNyovKxCDH6bCZNYa0td
         iQWWt6R1Mayfg6nCkJXWAhdJdEMzDjXrFluaT1UuioYNcLf8BHTQbbQZxepi+wffYicy
         EcxJwJYtIbErUrB7RmTtC3cb347v9jwcnMau6pIl7J+02kdD5lmFFr2tcsLAgnamW40/
         qRVQ==
X-Gm-Message-State: AC+VfDxP62pw21x8wiGcwRnzBOicLCTsoXtHSMRUJPdR5+b17mrSpAYk
        rTtSNxCh2OIA+Qa6Q4P4ldA=
X-Google-Smtp-Source: ACHHUZ5/KEu3dtNTR2dQUOC9Csue5mbcYWGtzV423Y0p3tjFSzmwUs1TGrtcUXki0TLer+ByLI4aqw==
X-Received: by 2002:a2e:8e8f:0:b0:2ac:8261:5f4b with SMTP id z15-20020a2e8e8f000000b002ac82615f4bmr3144723ljk.28.1685920963096;
        Sun, 04 Jun 2023 16:22:43 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id t8-20020a2e9c48000000b002b1b7e2b16csm894479ljj.66.2023.06.04.16.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 16:22:42 -0700 (PDT)
Date:   Mon, 5 Jun 2023 02:22:39 +0300
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
Subject: Re: [PATCH v16 04/22] PCI: Rename PCI_EPC_IRQ_LEGACY to
 PCI_EPC_IRQ_INTX
Message-ID: <20230604232239.luomflcdbwbgrzqc@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-5-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-5-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 03:22:16PM +0900, Yoshihiro Shimoda wrote:
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
> Cc: Srikanth Thokala <srikanth.thokala@intel.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Kishon Vijay Abraham I <kishon@kernel.org>

I doubt that that long Cc-tags list of much use in this case
especially seeing the change is mainly relevant to the PCIe
subsystem core. In order to still let git send-email to create a
pre-defined Cc-list I normally move all the Cc'es to be below the
"---" line. Thus the specified developers will be added by the
send-email tool to the list of recipients but git am will ignore
everything below "---" so the mainline commit won't have these
Cc-tags.

-Serge(y)

> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com> # ARTPEC
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
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
> index 623b08caa998..6beb3f2b0afb 100644
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
