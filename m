Return-Path: <linux-pci+bounces-4462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE6487090E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 19:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F67B2316B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191CB62154;
	Mon,  4 Mar 2024 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBo3kTAa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18C6214C;
	Mon,  4 Mar 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575519; cv=none; b=O0JtZFemzaMzAZlux+WdZRhL6jVjxfVdBU5trxMX4bFsle5jmxOrXtT2Ra286kn0wTqRDA/iv1SjrkcXq4nRhcAefJFYwOVC02F9AyyydHdUMylHAJc/dVSov/L5kQ/DhJ0hO2rYKGxHEyMWVzPwx2W3bVB+JDcWDy/z2NJSyX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575519; c=relaxed/simple;
	bh=ITqX/m4LMI7f8HrdMK/9Khp0LrIi2sxZUpdGbycpoq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwzIscmA19lg+7KNssadOMtsgNoO+cVlF6EzFQpJPbQwE9BhKPRQavwmqyvia1spQ4HyxQ4mRPFPZ7Sq5QUvFsMSe7tD7EGymy4EOKVdRZlEkMmWujmi5T3Mbr9XW7oK14IttUnFZoZ8x26NO6AQGRhQ5joAyXCXHtw5b6RarbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBo3kTAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31450C433F1;
	Mon,  4 Mar 2024 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709575518;
	bh=ITqX/m4LMI7f8HrdMK/9Khp0LrIi2sxZUpdGbycpoq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBo3kTAatAZMO7zhDLDphgexXMPY6kMyyAMrZXeBasREtmhsiJ7INJNGU5LZycxkP
	 PnSLRTis7zfRKpWD8C+upVt8GMgHwgx4SWF53h8xs6/fZ5XyDewiEFWyGPCrAeoHiT
	 Hegbo+76XaT4Fnok4CEswLxJZ9ac2uJLvxliJh1GzisQTQIByxZfP/NcODa+F5O6Zt
	 fixzstprzsw1vyx01Qb5qw6kGDndKAe6nS+74FCvLftrqaaeWUftjbTaF7cRoVaDYk
	 3owDU8NFSPAsCLqT1FTgJzulOINYOjS2LB90VXq2+6Cqi/3bgG+d5FyU6l5naNYwW4
	 IKKnmKAx6P/rA==
Date: Mon, 4 Mar 2024 23:35:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vireshk@kernel.org,
	quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
	quic_nitegupt@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v8 7/7] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20240304180506.GE31079@thinkpad>
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
 <20240302-opp_support-v8-7-158285b86b10@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240302-opp_support-v8-7-158285b86b10@quicinc.com>

On Sat, Mar 02, 2024 at 09:30:01AM +0530, Krishna chaitanya chundru wrote:
> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> maintains hardware state of a regulator by performing max aggregation of
> the requests made by all of the clients.
> 
> PCIe controller can operate on different RPMh performance state of power
> domain based on the speed of the link. And this performance state varies
> from target to target, like some controllers support GEN3 in NOM (Nominal)
> voltage corner, while some other supports GEN3 in low SVS (static voltage
> scaling).
> 
> The SoC can be more power efficient if we scale the performance state
> based on the aggregate PCIe link bandwidth.
> 
> Add Operating Performance Points (OPP) support to vote for RPMh state based
> on the aggregate link bandwidth.
> 
> OPP can handle ICC bw voting also, so move ICC bw voting through OPP
> framework if OPP entries are present.
> 
> Different link configurations may share the same aggregate bandwidth,
> e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1 link have the same bandwidth
> and share the same OPP entry.
> 
> As we are moving ICC voting as part of OPP, don't initialize ICC if OPP
> is supported.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 81 +++++++++++++++++++++++++++-------
>  1 file changed, 66 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a0266bfe71f1..2ec14bfafcfc 100644
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
> @@ -244,6 +245,7 @@ struct qcom_pcie {
>  	const struct qcom_pcie_cfg *cfg;
>  	struct dentry *debugfs;
>  	bool suspended;
> +	bool opp_supported;

You can just use "pcie->icc_mem" to differentiate between OPP and ICC. No need
of a new flag. 

>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1405,15 +1407,13 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> -static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> +static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci = pcie->pci;
> -	u32 offset, status;
> +	u32 offset, status, freq;
> +	struct dev_pm_opp *opp;
>  	int speed, width;
> -	int ret;
> -
> -	if (!pcie->icc_mem)
> -		return;
> +	int ret, mbps;
>  
>  	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> @@ -1425,11 +1425,30 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>  	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>  	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
>  
> -	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> -	if (ret) {
> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> -			ret);
> +	if (pcie->opp_supported) {
> +		mbps = pcie_link_speed_to_mbps(pcie_link_speed[speed]);
> +		if (mbps < 0)
> +			return;
> +
> +		freq = mbps * 1000;
> +		opp = dev_pm_opp_find_freq_exact(pci->dev, freq * width, true);
> +		if (!IS_ERR(opp)) {
> +			ret = dev_pm_opp_set_opp(pci->dev, opp);
> +			if (ret)
> +				dev_err(pci->dev, "Failed to set opp: freq %ld ret %d\n",
> +					dev_pm_opp_get_freq(opp), ret);
> +			dev_pm_opp_put(opp);
> +		}
> +	} else {
> +		ret = icc_set_bw(pcie->icc_mem, 0,
> +				 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> +		if (ret) {
> +			dev_err(pci->dev,
> +				"failed to set interconnect bandwidth for pcie-mem: %d\n", ret);

"PCIe-MEM"

> +		}
>  	}
> +
> +	return;
>  }
>  
>  static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
> @@ -1472,8 +1491,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>  static int qcom_pcie_probe(struct platform_device *pdev)
>  {
>  	const struct qcom_pcie_cfg *pcie_cfg;
> +	unsigned long max_freq = INT_MAX;
>  	struct device *dev = &pdev->dev;
>  	struct qcom_pcie *pcie;
> +	struct dev_pm_opp *opp;
>  	struct dw_pcie_rp *pp;
>  	struct resource *res;
>  	struct dw_pcie *pci;
> @@ -1540,9 +1561,36 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> -	ret = qcom_pcie_icc_init(pcie);
> -	if (ret)
> +	 /* OPP table is optional */
> +	ret = devm_pm_opp_of_add_table(dev);
> +	if (ret && ret != -ENODEV) {
> +		dev_err_probe(dev, ret, "Failed to add OPP table\n");
>  		goto err_pm_runtime_put;
> +	}
> +
> +	/*
> +	 * Use highest OPP here if the OPP table is present. At the end of

Why highest opp? For ICC, we set minimal bandwidth before.

> +	 * the probe(), OPP will be updated using qcom_pcie_icc_opp_update().
> +	 */
> +	if (ret != -ENODEV) {

if (!ret)

> +		opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
> +		if (!IS_ERR(opp)) {
> +			ret = dev_pm_opp_set_opp(dev, opp);
> +			if (ret)
> +				dev_err_probe(pci->dev, ret,
> +					      "Failed to set opp: freq %ld\n",

	"Failed to set OPP for freq: %ld\n"

> +					      dev_pm_opp_get_freq(opp));
> +			dev_pm_opp_put(opp);
> +		}
> +		pcie->opp_supported = true;
> +	}
> +
> +	/* Skip ICC init if OPP is supported as ICC bw is handled by OPP */
> +	if (!pcie->opp_supported) {
> +		ret = qcom_pcie_icc_init(pcie);

First check whether ICC is present or not and then check OPP as a fallback. This
avoids an extra flag.

- Mani

> +		if (ret)
> +			goto err_pm_runtime_put;
> +	}
>  
>  	ret = pcie->cfg->ops->get_resources(pcie);
>  	if (ret)
> @@ -1562,7 +1610,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_phy_exit;
>  	}
>  
> -	qcom_pcie_icc_update(pcie);
> +	qcom_pcie_icc_opp_update(pcie);
>  
>  	if (pcie->mhi)
>  		qcom_pcie_init_debugfs(pcie);
> @@ -1621,10 +1669,13 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  			qcom_pcie_host_init(&pcie->pci->pp);
>  			pcie->suspended = false;
>  		}
> -		qcom_pcie_icc_update(pcie);
> +		qcom_pcie_icc_opp_update(pcie);
>  		return ret;
>  	}
>  
> +	if (pcie->opp_supported)
> +		dev_pm_opp_set_opp(pcie->pci->dev, NULL);
> +
>  	return 0;
>  }
>  
> @@ -1647,7 +1698,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>  		pcie->suspended = false;
>  	}
>  
> -	qcom_pcie_icc_update(pcie);
> +	qcom_pcie_icc_opp_update(pcie);
>  
>  	return 0;
>  }
> 
> -- 
> 2.42.0
> 

-- 
மணிவண்ணன் சதாசிவம்

