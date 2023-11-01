Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F14A7DDCAF
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 07:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjKAGdo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 02:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjKAGdo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 02:33:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7685A98;
        Tue, 31 Oct 2023 23:33:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320C1C433C8;
        Wed,  1 Nov 2023 06:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698820420;
        bh=3O26v4tTyNO7eM9tG/OxIgXtPpBxiNbtzfURLi8HCZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CcnVKKv8EfTeuBLyyOLKSRwG+qCSvPSCwkfxkbo3TzyH3Hq0Y52w+78vCkJQRXpVA
         svekU5rFtLritpMRc9Gn+pvR4ZkWPHYHKQQAhOYSFZAzd2u2yiIbtfP5BB3bU0YMWA
         chrek2JJ+UXrd0CEtV3/RM9vbdorPAlFHyQ2N7yx4WNoWhCC9hktyArQWzTI5YNYYz
         SCyRKTCVzT+JYFE/QWO7u0A1l+X4NW3sZHo/3GFZkbqvyQQHhC6cEwAI4MbSerUoWk
         iEeqbJBlkrMAKNazjKGPbg0ke5dJVE4hd2w07id/zHg6CinmLBl1fohgw3Xsl8UMk9
         QDi6xA2BsfbWQ==
Date:   Wed, 1 Nov 2023 12:03:23 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v5 5/5] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20231101063323.GH2897@thinkpad>
References: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
 <1694066433-8677-6-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1694066433-8677-6-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 07, 2023 at 11:30:33AM +0530, Krishna chaitanya chundru wrote:
> While scaling the interconnect clocks based on PCIe link speed, it is also
> mandatory to scale the power domain performance state so that the SoC can
> run under optimum power conditions.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 58 ++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ca6350b..1817e96 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -22,6 +22,7 @@
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pci.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/pcie.h>
> @@ -240,6 +241,7 @@ struct qcom_pcie {
>  	const struct qcom_pcie_cfg *cfg;
>  	struct dentry *debugfs;
>  	bool suspended;
> +	bool opp_supported;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1357,14 +1359,13 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> -static int qcom_pcie_icc_update(struct qcom_pcie *pcie)
> +static int qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci = pcie->pci;
> +	struct dev_pm_opp *opp;
>  	u32 offset, status, bw;
>  	int speed, width;
> -
> -	if (!pcie->icc_mem)
> -		return 0;
> +	int ret;
>  
>  	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> @@ -1391,7 +1392,21 @@ static int qcom_pcie_icc_update(struct qcom_pcie *pcie)
>  		break;
>  	}
>  
> -	return icc_set_bw(pcie->icc_mem, 0, width * bw);
> +	if (pcie->opp_supported) {
> +		opp = dev_pm_opp_find_level_exact(pci->dev, speed);
> +		if (!IS_ERR(opp)) {
> +			ret = dev_pm_opp_set_opp(pci->dev, opp);
> +			if (ret)
> +				dev_err(pci->dev, "Failed to set opp: level %d ret %d\n",
> +					dev_pm_opp_get_level(opp), ret);
> +			dev_pm_opp_put(opp);
> +		}
> +	}
> +
> +	if (pcie->icc_mem)
> +		ret = icc_set_bw(pcie->icc_mem, 0, width * bw);

I think you should tie interconnect scaling with OPP as suggested by Viresh,
since you are updating both OPP and BW at the same time.

- Mani

> +
> +	return ret;
>  }
>  
>  static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
> @@ -1434,8 +1449,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>  static int qcom_pcie_probe(struct platform_device *pdev)
>  {
>  	const struct qcom_pcie_cfg *pcie_cfg;
> +	unsigned long max_level = INT_MAX;
>  	struct device *dev = &pdev->dev;
>  	struct qcom_pcie *pcie;
> +	struct dev_pm_opp *opp;
>  	struct dw_pcie_rp *pp;
>  	struct resource *res;
>  	struct dw_pcie *pci;
> @@ -1506,6 +1523,27 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_pm_runtime_put;
>  
> +	/* OPP table is optional */
> +	ret = devm_pm_opp_of_add_table(dev);
> +	if (ret && ret != -ENODEV) {
> +		dev_err_probe(dev, ret, "Failed to add OPP table\n");
> +		goto err_pm_runtime_put;
> +	}
> +
> +	/* vote for max level in the opp table if opp table is present */
> +	if (ret != -ENODEV) {
> +		opp = dev_pm_opp_find_level_floor(dev, &max_level);
> +		if (!IS_ERR(opp)) {
> +			ret = dev_pm_opp_set_opp(dev, opp);
> +			if (ret)
> +				dev_err_probe(pci->dev, ret,
> +					      "Failed to set opp: level %d\n",
> +					      dev_pm_opp_get_level(opp));
> +			dev_pm_opp_put(opp);
> +		}
> +		pcie->opp_supported = true;
> +	}
> +
>  	ret = pcie->cfg->ops->get_resources(pcie);
>  	if (ret)
>  		goto err_pm_runtime_put;
> @@ -1524,9 +1562,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_phy_exit;
>  	}
>  
> -	ret = qcom_pcie_icc_update(pcie);
> +	ret = qcom_pcie_icc_opp_update(pcie);
>  	if (ret)
> -		dev_err(dev, "failed to update interconnect bandwidth: %d\n",
> +		dev_err(dev, "failed to update interconnect bandwidth/opp: %d\n",
>  			ret);
>  
>  	if (pcie->mhi)
> @@ -1575,6 +1613,8 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  	 */
>  	if (!dw_pcie_link_up(pcie->pci)) {
>  		qcom_pcie_host_deinit(&pcie->pci->pp);
> +		if (pcie->opp_supported)
> +			dev_pm_opp_set_opp(dev, NULL);
>  		pcie->suspended = true;
>  	}
>  
> @@ -1594,9 +1634,9 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>  		pcie->suspended = false;
>  	}
>  
> -	ret = qcom_pcie_icc_update(pcie);
> +	ret = qcom_pcie_icc_opp_update(pcie);
>  	if (ret)
> -		dev_err(dev, "failed to update interconnect bandwidth: %d\n",
> +		dev_err(dev, "failed to update interconnect bandwidth/opp: %d\n",
>  			ret);
>  
>  	return 0;
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
