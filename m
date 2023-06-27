Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7146973FF2A
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 17:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjF0PBh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 11:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjF0PBg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 11:01:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CBC1A2;
        Tue, 27 Jun 2023 08:01:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A53611CE;
        Tue, 27 Jun 2023 15:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488C6C433C0;
        Tue, 27 Jun 2023 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687878093;
        bh=u8Fu1ii2Wu0qFPl2ucIu36KR7dRPnenXA6Y1Ih8OBSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QuSa27+Vpx+7TWKHR+Alj1db884hAyAR+IafE4ucqGibCOR7EfN9lucyeJU8pLTaT
         jRPof+0sA8k7AyLOsl5LvpoqpnfIEKDSsPSazX1DuLrpvwEZ4Wy8JrfNm+iQsczmzp
         CWNC1kLwRDOAs+fX2WpxIeUADOxY7ZSMBnMQWFT+SSXVYClMG70EoaZBGGGZRyygaw
         wkihUTNR3LniYzt9kOp11jRqxZDYaSmGsgkW+vlpPUZXUxgtSQfFb42hreZRhBHmTW
         /ZxvgOLpzqYpw8JYt5iKfZ97ttGF66EVMfMgjrbBsqE1E33azLAcFsE6qVZT8hF/CN
         V3/+iQTMHvETg==
Date:   Tue, 27 Jun 2023 20:31:18 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, krzysztof.kozlowski@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Message-ID: <20230627150118.GI5490@thinkpad>
References: <1687827692-6181-1-git-send-email-quic_krichai@quicinc.com>
 <1687827692-6181-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1687827692-6181-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 27, 2023 at 06:31:31AM +0530, Krishna chaitanya chundru wrote:
> Add support to vote for ICC bandwidth based on the link
> speed and width.
> 
> This patch is inspired from pcie-qcom driver to add basic
> interconnect support.
> 
> Reference: commit c4860af88d0c ("PCI: qcom: Add basic interconnect
> support").
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 73 +++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 1435f51..b613817 100644
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
> @@ -128,11 +130,19 @@
>  /* DBI register fields */
>  #define DBI_CON_STATUS_POWER_STATE_MASK		GENMASK(1, 0)
>  
> +#define DBI_LINKCTRLSTATUS			0x80
> +#define DBI_LINKCTRLSTATUS_SHIFT		16

not used?

> +
>  #define XMLH_LINK_UP				0x400
>  #define CORE_RESET_TIME_US_MIN			1000
>  #define CORE_RESET_TIME_US_MAX			1005
>  #define WAKE_DELAY_US				2000 /* 2 ms */
>  
> +#define PCIE_GEN1_BW_MBPS			250
> +#define PCIE_GEN2_BW_MBPS			500
> +#define PCIE_GEN3_BW_MBPS			985
> +#define PCIE_GEN4_BW_MBPS			1969
> +
>  #define to_pcie_ep(x)				dev_get_drvdata((x)->dev)
>  
>  enum qcom_pcie_ep_link_status {
> @@ -178,6 +188,8 @@ struct qcom_pcie_ep {
>  	struct phy *phy;
>  	struct dentry *debugfs;
>  
> +	struct icc_path *icc_mem;
> +
>  	struct clk_bulk_data *clks;
>  	int num_clks;
>  
> @@ -253,9 +265,51 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
>  	disable_irq(pcie_ep->perst_irq);
>  }
>  
> +static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
> +{
> +	struct dw_pcie *pci = &pcie_ep->pci;
> +	u32 offset, status, bw;
> +	int speed, width;
> +	int ret;
> +
> +	if (!pcie_ep->icc_mem)
> +		return;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +
> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> +
> +	switch (speed) {
> +	case 1:
> +		bw = MBps_to_icc(PCIE_GEN1_BW_MBPS);
> +		break;
> +	case 2:
> +		bw = MBps_to_icc(PCIE_GEN2_BW_MBPS);
> +		break;
> +	case 3:
> +		bw = MBps_to_icc(PCIE_GEN3_BW_MBPS);
> +		break;
> +	default:
> +		dev_warn(pci->dev, "using default GEN4 bandwidth\n");
> +		fallthrough;
> +	case 4:
> +		bw = MBps_to_icc(PCIE_GEN4_BW_MBPS);
> +		break;
> +	}
> +
> +	ret = icc_set_bw(pcie_ep->icc_mem, 0, width * bw);
> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);

No need of braces for single line.

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
> @@ -277,6 +331,20 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>  	if (ret)
>  		goto err_phy_exit;
>  
> +	/*
> +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> +	 * to be set before enabling interconnect clocks.
> +	 *
> +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> +	 * for the pcie-mem path.
> +	 */
> +	ret = icc_set_bw(pcie_ep->icc_mem, 0, MBps_to_icc(PCIE_GEN1_BW_MBPS));
> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);
> +		goto err_phy_exit;

Again, you should power off the PHY in the case of error. err_phy_exit is not
doing that for you.

- Mani

> +	}
> +
>  	return 0;
>  
>  err_phy_exit:
> @@ -550,6 +618,10 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
>  	if (IS_ERR(pcie_ep->phy))
>  		ret = PTR_ERR(pcie_ep->phy);
>  
> +	pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
> +	if (IS_ERR(pcie_ep->icc_mem))
> +		ret = PTR_ERR(pcie_ep->icc_mem);
> +
>  	return ret;
>  }
>  
> @@ -573,6 +645,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
>  		dev_dbg(dev, "Received BME event. Link is enabled!\n");
>  		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
> +		qcom_pcie_ep_icc_update(pcie_ep);
>  		pci_epc_bme_notify(pci->ep.epc);
>  	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
>  		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
