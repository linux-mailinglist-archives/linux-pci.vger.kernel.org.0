Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DE5726637
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 18:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjFGQnb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 12:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjFGQna (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 12:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C719D;
        Wed,  7 Jun 2023 09:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D435D638E1;
        Wed,  7 Jun 2023 16:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4222C433D2;
        Wed,  7 Jun 2023 16:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686156208;
        bh=Q1Q3s5JCfTB3dZnO7rVtD8EIpp4qchUspjNS+KlR6eA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gEw86Td2wYQPKDjOF06GWTTMwvQLgQr9eQ5b7IkSdq+miHBUX49xJYaDbKCjsp1Tu
         aL0o1JaJdP3AhnO69z7/KM5SEpJc/Az14VLa0ZeHurbBvh6FGxhRvTJltC51JdFHzv
         X6stEhOKRDo658DSt5BSfRUWyH/x+oDIevbPi7yApCX43sL7Iaf7C9dl70ASOWy5qF
         ElbOSRm/66ezV6+PTtveRpAxKHsDi2ag7Qmu0AH7uTKSCzEgk/u+4ukz9hT410f8pm
         GkzM1akJk/8H7qkIOG6Bd7mrSqFLhcs8GmOilYKRr6ceN1HH6g0AOylOaIrYqq1DFj
         zeUVJwXnCVPtQ==
Date:   Wed, 7 Jun 2023 11:43:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Message-ID: <20230607164326.GA1167111@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686154687-29356-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 07, 2023 at 09:48:07PM +0530, Krishna chaitanya chundru wrote:
> Add support to vote for ICC bandwidth based on the link
> speed and width.
> 
> This patch is inspired from pcie-qcom driver to add basic
> interconnect support.

Wrap to fill 75 columns like the rest of the git history.

> Link:https://patchwork.kernel.org/project/linux-pci/patch/20221102090705.23634-3-johan+linaro@kernel.org/

Add space after "Link:"

Probably better to use a lore link
(https://lore.kernel.org/r/20221102090705.23634-3-johan+linaro@kernel.org/)
because I think lore is more general-purpose than patchwork and we
don't get any benefit from the patchwork features here.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 68 +++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 19b3283..5f9139d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -13,6 +13,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/interconnect.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/phy/pcie.h>
>  #include <linux/phy/phy.h>
> @@ -28,6 +29,7 @@
>  #define PARF_SYS_CTRL				0x00
>  #define PARF_DB_CTRL				0x10
>  #define PARF_PM_CTRL				0x20
> +#define PARF_PM_STTS				0x24
>  #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>  #define PARF_MHI_BASE_ADDR_LOWER		0x178
>  #define PARF_MHI_BASE_ADDR_UPPER		0x17c
> @@ -128,6 +130,9 @@
>  /* DBI register fields */
>  #define DBI_CON_STATUS_POWER_STATE_MASK		GENMASK(1, 0)
>  
> +#define DBI_LINKCTRLSTATUS			0x80
> +#define DBI_LINKCTRLSTATUS_SHIFT		16
> +
>  #define XMLH_LINK_UP				0x400
>  #define CORE_RESET_TIME_US_MIN			1000
>  #define CORE_RESET_TIME_US_MAX			1005
> @@ -178,6 +183,8 @@ struct qcom_pcie_ep {
>  	struct phy *phy;
>  	struct dentry *debugfs;
>  
> +	struct icc_path *icc;

Seems gratuitously different from the "icc_mem" name used in
pcie-qcom.  Use the same name unless there's a reason to be different.

>  	struct clk_bulk_data *clks;
>  	int num_clks;
>  
> @@ -253,9 +260,51 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
>  	disable_irq(pcie_ep->perst_irq);
>  }
>  
> +static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
> +{
> +	struct dw_pcie *pci = &pcie_ep->pci;
> +	int speed, width;
> +	u32 val, bw;
> +	int ret;
> +
> +	if (!pcie_ep->icc)
> +		return;
> +
> +	val = dw_pcie_readl_dbi(pci, DBI_LINKCTRLSTATUS);
> +	val = val >> DBI_LINKCTRLSTATUS_SHIFT;
> +
> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);

This whole function is basically identical to qcom_pcie_icc_update().
Could a single implementation be shared?  qcom_pcie_icc_update() uses
dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) instead of the hard-coded
DBI_LINKCTRLSTATUS, but there are other instances of
dw_pcie_find_capability() in pcie-qcom-ep.c, so it seems possible that
the same code could be used both places.

> +	switch (speed) {
> +	case 1:
> +		bw = MBps_to_icc(250);	/* BW for GEN1 per lane: 250MBps */
> +		break;
> +	case 2:
> +		bw = MBps_to_icc(500);	/* BW for GEN2 per lane: 500MBps */
> +		break;
> +	case 3:
> +		bw = MBps_to_icc(985);	/* BW for GEN3 per lane: 985MBps */
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		fallthrough;
> +	case 4:
> +		bw = MBps_to_icc(1969);	/* BW for GEN4 per lane: 985MBps */
> +		break;
> +	}
> +
> +	ret = icc_set_bw(pcie_ep->icc, 0, width * bw);
> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);
> +	}
> +}
> +
>  static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>  {
>  	int ret;
> +	struct dw_pcie *pci = &pcie_ep->pci;
>  
>  	ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
>  	if (ret)
> @@ -277,6 +326,20 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>  	if (ret)
>  		goto err_phy_exit;
>  
> +	/*
> +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> +	 * to be set before enabling interconnect clocks.
> +	 *
> +	 * Set an initial average bandwidth corresponding to single-lane Gen 1
> +	 * for the pcie to mem path.
> +	 */
> +	ret = icc_set_bw(pcie_ep->icc, 0, MBps_to_icc(250)); /* BW for GEN1 per lane: 250MBps */

Reformat the comment so this all fits in 80 columns like the rest of
the file.

> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);
> +		goto err_phy_exit;
> +	}

This plus the pcie_ep->icc init below is basically identical to
qcom_pcie_icc_init() in pcie_qcom.c.  Why not use the same structure
here, with a qcom_pcie_icc_init() function?  It's better to be the
same than different (when possible, of course).

>  	return 0;
>  
>  err_phy_exit:
> @@ -550,6 +613,10 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
>  	if (IS_ERR(pcie_ep->phy))
>  		ret = PTR_ERR(pcie_ep->phy);
>  
> +	pcie_ep->icc = devm_of_icc_get(dev, "pcie-mem");
> +	if (IS_ERR(pcie_ep->icc))
> +		ret = PTR_ERR(pcie_ep->icc);
> +
>  	return ret;
>  }
>  
> @@ -572,6 +639,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
>  		dev_dbg(dev, "Received BME event. Link is enabled!\n");
>  		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
> +		qcom_pcie_ep_icc_update(pcie_ep);
>  	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
>  		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
>  		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
> -- 
> 2.7.4
> 
