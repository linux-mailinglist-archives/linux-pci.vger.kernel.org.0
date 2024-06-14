Return-Path: <linux-pci+bounces-8826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC542908B5B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 14:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476A91F29281
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826941836C8;
	Fri, 14 Jun 2024 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8u6thVP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D49612F5A0;
	Fri, 14 Jun 2024 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367263; cv=none; b=lxTBl2eRLdecB8dxetEeZtHSYCPpxXSoqVRYeP8T1tdqM9atsKs5BEw6AWFs6eWz0SNGYJezqunrNwC8c3IVqnyOorgJwrFzXr9TKnM3klPEpL4POfgjHgNTL47R9UVYzZrPYSuxYDvgh7R2794sW83YYkB66pZlIU0m6mFHywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367263; c=relaxed/simple;
	bh=dPIklw6ohanKTOAOsDw7cJcdcYgn9pLKByUY3V1XJW0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=huyhXUsqBES2JtqUPc9PjiJweM/ymm3Q/vanoPUYVz7gvE6V0XakdcFtn1/G1GsVo9qMrCgTqIF+pzWwl0gTsAVdm7gTvDbMZZVW76Ho/yf5t1yDPQ9F/APlCkLyo6++OOpnEYPsOZhy9iOaHuhuHlXKjQxvJPXvDTRfh+lCDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8u6thVP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718367261; x=1749903261;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dPIklw6ohanKTOAOsDw7cJcdcYgn9pLKByUY3V1XJW0=;
  b=X8u6thVPR0tLS7kceaaVji6WYdrblC/XTpTdHBnA51zeA+vRJqp/PhMZ
   1LNN9Hof/NVmVR5GgeSN6oQjnqei4KSxtfUw892o8peiF4ZSleS+DfTeg
   h6Yduiqt+5/Hc8/oJ/+kEyPBgH/+G8nKJ+ltU7Xu6+NNC41ndu5EB/Xb5
   6Dr6+BNDqSXPwV3djBU9RJB/h2ASonoDV4nGYEaMq4zTTzE2n2mbT5dHY
   bYRxBn8xCLA1xmmPjl/4D/ZO5aajAFvq9f9szCpJ+pBWKNYpdlcQ9R80A
   AAUSj0OBBWTlEKW/5tuULf7BYsMAwhWRHo04EdCV54HDfjZ6IjoQhL5Kk
   Q==;
X-CSE-ConnectionGUID: rglAaCWQSBu8SxmGrSumiA==
X-CSE-MsgGUID: Qb96joCwSuWN5gApSqcGBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="14983206"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="14983206"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 05:14:20 -0700
X-CSE-ConnectionGUID: y7i4fjE8RQyGRDzpNF2WoA==
X-CSE-MsgGUID: WHNXkfMoRNmGx+6hfllaSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="44855762"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 05:14:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Jun 2024 15:14:10 +0300 (EEST)
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
cc: Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, johan+linaro@kernel.org, 
    bmasney@redhat.com, djakov@kernel.org, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-pci@vger.kernel.org, vireshk@kernel.org, quic_vbadigan@quicinc.com, 
    quic_skananth@quicinc.com, quic_nitegupt@quicinc.com, 
    quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v14 1/4] PCI: qcom: Add ICC bandwidth vote for CPU to
 PCIe path
In-Reply-To: <20240609-opp_support-v14-1-801cff862b5a@quicinc.com>
Message-ID: <1b5f11a6-52e3-55ca-8c80-dca8f7e0c7c7@linux.intel.com>
References: <20240609-opp_support-v14-0-801cff862b5a@quicinc.com> <20240609-opp_support-v14-1-801cff862b5a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 9 Jun 2024, Krishna chaitanya chundru wrote:

> To access the host controller registers of the host controller and the
> endpoint BAR/config space, the CPU-PCIe ICC (interconnect) path should
> be voted otherwise it may lead to NoC (Network on chip) timeout.
> We are surviving because of other driver voting for this path.
> 
> As there is less access on this path compared to PCIe to mem path
> add minimum vote i.e 1KBps bandwidth always which is sufficient enough
> to keep the path active and is recommended by HW team.
> 
> During S2RAM (Suspend-to-RAM), the DBI access can happen very late (while
> disabling the boot CPU). So do not disable the CPU-PCIe interconnect path
> during S2RAM as that may lead to NoC error.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 45 +++++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 5f9f0ff19baa..ff1d891c8b9a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -253,6 +253,7 @@ struct qcom_pcie {
>  	struct phy *phy;
>  	struct gpio_desc *reset;
>  	struct icc_path *icc_mem;
> +	struct icc_path *icc_cpu;
>  	const struct qcom_pcie_cfg *cfg;
>  	struct dentry *debugfs;
>  	bool suspended;
> @@ -1369,6 +1370,9 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>  	if (IS_ERR(pcie->icc_mem))
>  		return PTR_ERR(pcie->icc_mem);
>  
> +	pcie->icc_cpu = devm_of_icc_get(pci->dev, "cpu-pcie");
> +	if (IS_ERR(pcie->icc_cpu))
> +		return PTR_ERR(pcie->icc_cpu);
>  	/*
>  	 * Some Qualcomm platforms require interconnect bandwidth constraints
>  	 * to be set before enabling interconnect clocks.
> @@ -1378,11 +1382,25 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>  	 */
>  	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
>  	if (ret) {
> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +		dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
>  			ret);

I think it would be better to separate these message clarifications into a 
separate patch. It would make both patches more into the point.

Other than that, the change looked okay to me.

-- 
 i.

>  		return ret;
>  	}
>  
> +	/*
> +	 * Since the CPU-PCIe path is only used for activities like register
> +	 * access of the host controller and endpoint Config/BAR space access,
> +	 * HW team has recommended to use a minimal bandwidth of 1KBps just to
> +	 * keep the path active.
> +	 */
> +	ret = icc_set_bw(pcie->icc_cpu, 0, kBps_to_icc(1));
> +	if (ret) {
> +		dev_err(pci->dev, "Failed to set bandwidth for CPU-PCIe interconnect path: %d\n",
> +			ret);
> +		icc_set_bw(pcie->icc_mem, 0, 0);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1408,7 +1426,7 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>  
>  	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
>  	if (ret) {
> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +		dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
>  			ret);
>  	}
>  }
> @@ -1570,7 +1588,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  	 */
>  	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
>  	if (ret) {
> -		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
> +		dev_err(dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -1594,7 +1612,18 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  		pcie->suspended = true;
>  	}
>  
> -	return 0;
> +	/*
> +	 * Only disable CPU-PCIe interconnect path if the suspend is non-S2RAM.
> +	 * Because on some platforms, DBI access can happen very late during the
> +	 * S2RAM and a non-active CPU-PCIe interconnect path may lead to NoC
> +	 * error.
> +	 */
> +	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
> +		ret = icc_disable(pcie->icc_cpu);
> +		if (ret)
> +			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
> +	}
> +	return ret;
>  }
>  
>  static int qcom_pcie_resume_noirq(struct device *dev)
> @@ -1602,6 +1631,14 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>  	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>  	int ret;
>  
> +	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
> +		ret = icc_enable(pcie->icc_cpu);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable CPU-PCIe interconnect path: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	if (pcie->suspended) {
>  		ret = qcom_pcie_host_init(&pcie->pci->pp);
>  		if (ret)
> 
> 

