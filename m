Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F17578511E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 09:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjHWHHS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 03:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjHWHHR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 03:07:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC51E62;
        Wed, 23 Aug 2023 00:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57CBE646E6;
        Wed, 23 Aug 2023 07:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E98C433C7;
        Wed, 23 Aug 2023 07:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692774432;
        bh=9lAErBwNVSX9i0L/x3hQKTCaogOpT3lhljOUK8I9jXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIuXPG6QtLR0bvZoo2ngJlyQk+7LsJVFPTU1jGmH8csY7KgRMPv7OIjKQfJRSS56S
         hT2LC0olMAeg4cHgTuJ5fGsUVUobfL971GvZiTGQwv07nTMs8/uFHbO7YP+6FtT1r+
         3HGMWCAWGS1J1kWE2hKABP50XiwBUGRREIFET2UHv7jz5B7SU7R8EfKep24UH5VF5Q
         OO+8NQKLQD30IzmdEJSdMSh2kN+Hzd9rkpUw0vp8XKaxjxTHSZB9Y1D2ExWkDKkuMe
         7Tl9Ht5vIbDNONrhmVS9C5FGhN2dOxYW63PvYPRvKOaCU+DVS9zQQef7ihvcFkHrqD
         XUWD9z6URI1Pw==
Date:   Wed, 23 Aug 2023 12:36:52 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com,
        krzysztof.kozlowski@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 4/4] PCI: qcom: Add OPP support for speed based
 performance state of RPMH
Message-ID: <20230823070652.GE3737@thinkpad>
References: <1692717141-32743-1-git-send-email-quic_krichai@quicinc.com>
 <1692717141-32743-5-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1692717141-32743-5-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Subject should be, "PCI: qcom: Add OPP support to scale performance state of
power domain"

On Tue, Aug 22, 2023 at 08:42:21PM +0530, Krishna chaitanya chundru wrote:
> Before link training vote for the maximum performance state of RPMH
> and once link is up, vote for the performance state based upon the link
> speed.
> 

Commit message should have the justification on why OPP support should be
addded, not just how you add it. The reasoning should be, "While scaling the
interconnect clocks based on PCIe link speed, it is also mandatory to scale the
power domain performance state so that the SoC can run under optimum power
conditions."

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 52 ++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 7a87a47..161fdad 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pci.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/pcie.h>
> @@ -1357,6 +1358,33 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static void qcom_pcie_opp_update(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	struct dev_pm_opp *opp;
> +	u32 offset, status;
> +	int speed, ret = 0;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +
> +	/* Only update constraints if link is up. */
> +	if (!(status & PCI_EXP_LNKSTA_DLLLA))
> +		return;
> +
> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> +

Since icc_update() also queries link status register, this could be moved inside
icc_update() to avoid code duplication and probably the function con be renamed
to "qcom_pcie_icc_opp_update()".

> +	opp = dev_pm_opp_find_level_exact(pci->dev, speed);
> +	if (!IS_ERR(opp)) {

As we decided for pcie-qcom-ep, let's return error from _update() function if
icc paths/opp support were specified in DT.

Use a separate patch for returning error from existing qcom_pcie_icc_update()
function and add opp support on top.

> +		ret = dev_pm_opp_set_opp(pci->dev, opp);
> +		if (ret)
> +			dev_err(pci->dev, "Failed to set opp: level %d ret %d\n",
> +						dev_pm_opp_get_level(opp), ret);
> +		dev_pm_opp_put(opp);
> +	}
> +
> +}
> +
>  static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci = pcie->pci;
> @@ -1439,8 +1467,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
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
> @@ -1511,6 +1541,23 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_pm_runtime_put;
>  
> +	/* OPP table is optional */
> +	ret = devm_pm_opp_of_add_table(dev);
> +	if (ret && ret != -ENODEV) {
> +		dev_err(dev, "Invalid OPP table in Device tree\n");

"Failed to add OPP table"

Also, use dev_err_probe() here and below.

> +		goto err_pm_runtime_put;
> +	}
> +
> +	/* vote for max level in the opp table */
> +	opp = dev_pm_opp_find_level_floor(dev, &max_level);

Use a bool flag to check whether opp support is present or not and use that to
decide calling these APIs.

> +	if (!IS_ERR(opp)) {
> +		ret = dev_pm_opp_set_opp(dev, opp);
> +		if (ret)
> +			dev_err(pci->dev, "Failed to set opp: level %d ret %d\n",
> +						dev_pm_opp_get_level(opp), ret);
> +		dev_pm_opp_put(opp);
> +	}
> +
>  	ret = pcie->cfg->ops->get_resources(pcie);
>  	if (ret)
>  		goto err_pm_runtime_put;
> @@ -1531,6 +1578,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	qcom_pcie_icc_update(pcie);
>  
> +	qcom_pcie_opp_update(pcie);
> +
>  	if (pcie->mhi)
>  		qcom_pcie_init_debugfs(pcie);
>  
> @@ -1577,6 +1626,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  	 */
>  	if (!dw_pcie_link_up(pcie->pci)) {
>  		qcom_pcie_host_deinit(&pcie->pci->pp);
> +		dev_pm_opp_set_opp(dev, NULL);

This will print error when OPP table was not specified in DT. So use the flag as
I suggested above.

- Mani

>  		pcie->suspended = true;
>  	}
>  
> @@ -1593,6 +1643,8 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>  		if (ret)
>  			return ret;
>  
> +		qcom_pcie_opp_update(pcie);
> +
>  		pcie->suspended = false;
>  	}
>  
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
