Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB61373B019
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 07:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjFWFfF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 01:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjFWFfF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 01:35:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F5E212E;
        Thu, 22 Jun 2023 22:35:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5527661986;
        Fri, 23 Jun 2023 05:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3756EC433C8;
        Fri, 23 Jun 2023 05:34:57 +0000 (UTC)
Date:   Fri, 23 Jun 2023 11:04:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Message-ID: <20230623053448.GA5611@thinkpad>
References: <1686752666-13426-1-git-send-email-quic_krichai@quicinc.com>
 <1686752666-13426-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1686752666-13426-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 14, 2023 at 07:54:26PM +0530, Krishna chaitanya chundru wrote:
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
> index 19b3283..5d146ec 100644
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
> +		WARN_ON_ONCE(1);

We can drop WARN_ON_ONCE and print a warning saying that default GEN4 bandwidth
is being used.

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
> +	 * Set an initial average bandwidth corresponding to GEN1x1

Keep the comment same as the other driver.

> +	 * for the pcie to mem path.
> +	 */
> +	ret = icc_set_bw(pcie_ep->icc_mem, 0, MBps_to_icc(PCIE_GEN1_BW_MBPS));
> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);
> +		goto err_phy_exit;

PHY should be powered off in the case of error.

Rest looks good.

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
> @@ -572,6 +644,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
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

-- 
மணிவண்ணன் சதாசிவம்
