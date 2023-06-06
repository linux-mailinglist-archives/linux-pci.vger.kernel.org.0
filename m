Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D327D7240CA
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 13:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjFFLZD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 07:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjFFLZC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 07:25:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673ACB1;
        Tue,  6 Jun 2023 04:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03DB863056;
        Tue,  6 Jun 2023 11:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9633C433D2;
        Tue,  6 Jun 2023 11:24:56 +0000 (UTC)
Date:   Tue, 6 Jun 2023 16:54:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: qcom-ep: Add ICC bandwidth voting support
Message-ID: <20230606112452.GA51623@thinkpad>
References: <1686030570-5439-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1686030570-5439-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 06, 2023 at 11:19:29AM +0530, Krishna chaitanya chundru wrote:
> Add support to vote for ICC bandwidth based up on the link

based on

> speed and width.
> 

Looks like the code got inspiration from pcie-qcom driver. So it should be
mentioned in the commit message.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Devicetree bindings update should precede this patch.

> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 73 +++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 19b3283..79e7559 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -17,6 +17,7 @@
>  #include <linux/phy/pcie.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/interconnect.h>

Includes are sorted alphabetically

>  #include <linux/pm_domain.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
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
> +#define DBI_LINKCTRKSTATUS_SHIFT	16

Use GENMASK macro

> +
>  #define XMLH_LINK_UP				0x400
>  #define CORE_RESET_TIME_US_MIN			1000
>  #define CORE_RESET_TIME_US_MAX			1005
> @@ -187,6 +192,8 @@ struct qcom_pcie_ep {
>  	enum qcom_pcie_ep_link_status link_status;
>  	int global_irq;
>  	int perst_irq;
> +
> +	struct icc_path *icc;

Place this under debugfs entry.

>  };
>  
>  static int qcom_pcie_ep_core_reset(struct qcom_pcie_ep *pcie_ep)
> @@ -253,9 +260,56 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
>  	disable_irq(pcie_ep->perst_irq);
>  }
>  
> +static void qcom_pcie_icc_update(struct qcom_pcie_ep *pcie_ep)

qcom_pcie_ep_icc_update

> +{
> +	struct dw_pcie *pci = &pcie_ep->pci;
> +	u32 val, bw;
> +	int speed, width;
> +	int ret;
> +

Follow reverse Xmas tree order for local variables.

> +	if (!pcie_ep->icc)
> +		return;
> +
> +	val = dw_pcie_readl_dbi(pci, DBI_LINKCTRLSTATUS);
> +	val = val >> DBI_LINKCTRKSTATUS_SHIFT;
> +

Use FIELD_GET macro combined with GENMASK

> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
> +
> +	/*
> +	 * ICC needs avg bw in KBps.

s/avg bw/BW
...everywhere

> +	 *
> +	 * For example for 2Gbps the avg BW = 2x1000x1000x1000/8*1000 = 250000
> +	 */
> +	switch (speed) {
> +	case 1:
> +		bw = 250000;	/* avg bw for GEN1 per lane: 2Gbps, peak bw: no vote */

To align with pcie-qcom driver, specify the value in MBps. Also, use the
MBps_to_icc() macro.

> +		break;
> +	case 2:
> +		bw = 500000;	/* avg bw for GEN2 per lane: 4Gbps, peak bw no vote */
> +		break;
> +	case 3:
> +		bw = 1000000;	/* avg bw for GEN3 per lane: 8Gbps, peak bw no vote */
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		fallthrough;
> +	case 4:
> +		bw = 2000000;	/* avg bw for GEN4 per lane: 16Gbps, peak bw no vote */
> +		break;
> +	}
> +
> +	ret = icc_set_bw(pcie_ep->icc, width * bw, 0);

AFAIU, avg bandwidth should be less than peak bandwidth. So use the vote for
peak bandwidth, leaving 0 as avg. Also, the comment above should be adjusted
accordingly.

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
> +	 * Set an initial average bandwidth corresponding to single-lane Gen 1
> +	 * for the pcie to mem path.
> +	 */
> +	ret = icc_set_bw(pcie_ep->icc, 250000, 0); /* avg bw: 2Gbps, peak bw: no vote */

Same as above

> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);
> +		goto err_phy_exit;
> +	}
> +
>  	return 0;
>  
>  err_phy_exit:
> @@ -550,6 +618,10 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
>  	if (IS_ERR(pcie_ep->phy))
>  		ret = PTR_ERR(pcie_ep->phy);
>  
> +	pcie_ep->icc = devm_of_icc_get(dev, "pci");

This should specify the icc path like pcie-mem as specified in pcie-qcom driver.
This helps in adding other icc paths if required in the future.

- Mani

> +	if (IS_ERR(pcie_ep->icc))
> +		ret = PTR_ERR(pcie_ep->icc);
> +
>  	return ret;
>  }
>  
> @@ -572,6 +644,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
>  		dev_dbg(dev, "Received BME event. Link is enabled!\n");
>  		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
> +		qcom_pcie_icc_update(pcie_ep);
>  	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
>  		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
>  		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
