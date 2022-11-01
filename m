Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1819614CB2
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 15:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiKAOgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 10:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiKAOfz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 10:35:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2C61B9D8;
        Tue,  1 Nov 2022 07:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4F7F615C5;
        Tue,  1 Nov 2022 14:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6E4C433C1;
        Tue,  1 Nov 2022 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313343;
        bh=O2IUvbj/N3TdgpyaE2KkKjkh22Z7LBbDiIgzXNXCzHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRLkanXej6i8EOQN3UiLQJkfEd12MjxwtNNz8t9QtHErH2uiBIO+V/yCK9axSsbJi
         pM4zy44Qyh9pRZeZuFnUm7nZhwUUpFU763+Hg8Shdvyt1O8AsV62bKfMS2HocEdIRk
         Mx119NNQFrG7nxuB8LxdME18RgcW852WBrEWAG9aN3PxziM1UETXUt3NXGxdtRei5W
         S0va1gvliT9wFSS3t9KZWlyfdu+1fwRESBopq8dus2yJm42S5kRBWCZZrJdMthvPVQ
         7tk6BP7z1yfyYn77U/CWW7zKFiGIXM2PcFNR2XMCxG1+EH/+c+C0xnapHShj1GuYQx
         8v6qTuEV+d3Rw==
Date:   Tue, 1 Nov 2022 20:05:29 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        quic_vbadigan@quicinc.com, Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add basic interconnect support
Message-ID: <20221101143529.GA244012@thinkpad>
References: <20221021064616.6380-1-johan+linaro@kernel.org>
 <20221021064616.6380-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221021064616.6380-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 21, 2022 at 08:46:16AM +0200, Johan Hovold wrote:
> On Qualcomm platforms like SC8280XP and SA8540P, interconnect bandwidth
> must be requested before enabling interconnect clocks.
> 
> Add basic support for managing an optional "pcie-mem" interconnect path
> by setting a low constraint before enabling clocks and updating it after
> the link is up.
> 
> Note that it is not possible for a controller driver to set anything but
> a maximum peak bandwidth as expected average bandwidth will vary with
> use case and actual use (and power policy?). This very much remains an
> unresolved problem with the interconnect framework.
> 
> Also note that no constraint is set for the SC8280XP/SA8540P "cpu-pcie"
> path for now as it is not clear what an appropriate constraint would be
> (and the system does not crash when left unspecified).
> 

I initially thought we should move this to dwc core but I'm not sure if the
interconnect path is going to be the same for all platforms. So keeping it
within Qcom driver is good for now. 

> Fixes: 70574511f3fc ("PCI: qcom: Add support for SC8280XP")
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 76 ++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 7db94a22238d..0c13f976626f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -12,6 +12,7 @@
>  #include <linux/crc8.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/interconnect.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> @@ -224,6 +225,7 @@ struct qcom_pcie {
>  	union qcom_pcie_resources res;
>  	struct phy *phy;
>  	struct gpio_desc *reset;
> +	struct icc_path *icc_mem;
>  	const struct qcom_pcie_cfg *cfg;
>  };
>  
> @@ -1644,6 +1646,74 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>  	.start_link = qcom_pcie_start_link,
>  };
>  
> +static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	int ret;
> +
> +	pcie->icc_mem = devm_of_icc_get(pci->dev, "pcie-mem");
> +	if (IS_ERR(pcie->icc_mem)) {
> +		ret = PTR_ERR(pcie->icc_mem);
> +		return ret;

return PTR_ERR(pcie->icc_mem);

> +	}
> +
> +	/*
> +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> +	 * to be set before enabling interconnect clocks.
> +	 *
> +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> +	 * for the pcie-mem path.
> +	 */
> +	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);

Move "ret);" to prior line. No need to keep up within 80 columns.

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	u32 offset, status, bw;
> +	int speed, width;
> +	int ret;
> +
> +	if (!pcie->icc_mem)
> +		return;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +
> +	/* Only update constraints if link is up. */
> +	if (!(status & PCI_EXP_LNKSTA_DLLLA))
> +		return;

What if the link comes back later? I'd suggest to call this function from
qcom_pcie_link_up(), whenever link is up.

> +
> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> +
> +	switch (speed) {
> +	case 1:
> +		bw = MBps_to_icc(250);
> +		break;
> +	case 2:
> +		bw = MBps_to_icc(500);
> +		break;
> +	default:
> +	case 3:

Why do you need explicit "case 3" and not just default case?

> +		bw = MBps_to_icc(985);
> +		break;
> +	}
> +
> +	ret = icc_set_bw(pcie->icc_mem, 0, width * bw);
> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);

Move "ret);" to prior line and save braces.

Thanks,
Mani

> +	}
> +}
> +
>  static int qcom_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1704,6 +1774,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> +	ret = qcom_pcie_icc_init(pcie);
> +	if (ret)
> +		goto err_pm_runtime_put;
> +
>  	ret = pcie->cfg->ops->get_resources(pcie);
>  	if (ret)
>  		goto err_pm_runtime_put;
> @@ -1722,6 +1796,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_phy_exit;
>  	}
>  
> +	qcom_pcie_icc_update(pcie);
> +
>  	return 0;
>  
>  err_phy_exit:
> -- 
> 2.37.3
> 

-- 
மணிவண்ணன் சதாசிவம்
