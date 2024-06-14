Return-Path: <linux-pci+bounces-8829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0785A908BED
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 14:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC181C223E0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D96919AA7A;
	Fri, 14 Jun 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmpqYJaT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC3E19752F;
	Fri, 14 Jun 2024 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368954; cv=none; b=Y7SM3VXxhi58WVj6D09FVEDORYJNlBf7mWEJwzj+Rr55LeDWs5G/RxPPD+Q/7leyz+sL70URiZhTH5LB4FfFDNjbEiHkM/QZzULLDiKktYjf2w6Eru/apn9KSJxgspRcQEEdxwxBO1xTCNMpYPG1dK6hxdkDEsIq27Fu31WiCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368954; c=relaxed/simple;
	bh=WeBN0VZbib2KKwbwVhRG6ocqVa7whAD2cctLyv+c7Hc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cv47OdDiIUHP6lHb/Nnnqr+nIky6BC3JeIyTrHEuvEvwd3bNJiWApxiREDGnpeK7whfdFOlhXNfG7Tgaofxs3NhUtxa960VvQCO3Z7xBFRpimvEIDXalatQcH12ItX5FitQV6sqe5JO+ACTO8/kBadKjvdxNLGd9HzBCUtZDlYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmpqYJaT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718368952; x=1749904952;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WeBN0VZbib2KKwbwVhRG6ocqVa7whAD2cctLyv+c7Hc=;
  b=UmpqYJaTr5cOoJYvPZ3UdJXH5eVPBdD6Ayd/5R+P6qaeefPtAHcFG9eC
   qVDQSuanMW2Nb5rV0bXTDfrv2IM78TqcWIi0ahypZBwgvVE7JTBgsyWIb
   LXh4Odinrl5sOGFU4FScFcAmn7yJDcR2pwCEHQfFhU3+xp79nDARO6w/l
   oNC6rqwt1cpo6dPFDWOtxJOe/+LfGb7qvzl9mu+2HEK3lAkov5cHzP/MJ
   Fjw79hbU8TXTujGW50E24TWJz09gVgxU3m+Itn/st0Lqs0cPdnDI4fdmU
   iBu1aRYxrrTShG11ssJVm0+DW3S/NaeY64K7M+MmOLULH/ulDP3u2H64n
   g==;
X-CSE-ConnectionGUID: dMykDZ6QTp+Mu598AFc8hQ==
X-CSE-MsgGUID: vRWKSrXuSFuoS1XIqFk6fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="25927167"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="25927167"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 05:42:31 -0700
X-CSE-ConnectionGUID: N88e8vZ2TPiCe6N6J4VNAA==
X-CSE-MsgGUID: 9fL4jmExReaq/x4XC/0lkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="44861288"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 05:42:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Jun 2024 15:42:20 +0300 (EEST)
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
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org, vireshk@kernel.org, quic_vbadigan@quicinc.com, 
    quic_skananth@quicinc.com, quic_nitegupt@quicinc.com, 
    quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v14 4/4] PCI: qcom: Add OPP support to scale
 performance
In-Reply-To: <20240609-opp_support-v14-4-801cff862b5a@quicinc.com>
Message-ID: <04e7e509-9911-d5b2-619c-e7b87ed0ef50@linux.intel.com>
References: <20240609-opp_support-v14-0-801cff862b5a@quicinc.com> <20240609-opp_support-v14-4-801cff862b5a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 9 Jun 2024, Krishna chaitanya chundru wrote:

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
> As we are moving ICC voting as part of OPP, don't initialize ICC if OPP
> is supported.
> 
> Before PCIe link is initialized vote for highest OPP in the OPP table,
> so that we are voting for maximum voltage corner for the link to come up
> in maximum supported speed.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 93 +++++++++++++++++++++++++++-------
>  1 file changed, 75 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ff1d891c8b9a..296e2d5036f6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -21,6 +21,7 @@
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/pci.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/pcie.h>
> @@ -1404,15 +1405,13 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> -static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> +static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  {
> +	int speed, width, ret, freq_mbps;
>  	struct dw_pcie *pci = pcie->pci;
> +	unsigned long freq_kbps;
> +	struct dev_pm_opp *opp;
>  	u32 offset, status;
> -	int speed, width;
> -	int ret;
> -
> -	if (!pcie->icc_mem)
> -		return;
>  
>  	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> @@ -1424,10 +1423,26 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>  	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>  	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
>  
> -	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> -	if (ret) {
> -		dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
> -			ret);
> +	if (pcie->icc_mem) {
> +		ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> +		if (ret) {
> +			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
> +				ret);
> +		}
> +	} else {
> +		freq_mbps = pcie_link_speed_to_mbps(pcie_link_speed[speed]);
> +		if (freq_mbps < 0)
> +			return;
> +
> +		freq_kbps = freq_mbps * 1000;

Use define from units.h instead of literal.

> +		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width, true);
> +		if (!IS_ERR(opp)) {
> +			ret = dev_pm_opp_set_opp(pci->dev, opp);
> +			if (ret)
> +				dev_err(pci->dev, "Failed to set OPP for freq (%ld): %d\n",
> +					freq_kbps * width, ret);

Make width unsigned and use %lu ?

-- 
 i.

> +		}
> +		dev_pm_opp_put(opp);
>  	}
>  }
>  
> @@ -1471,7 +1486,9 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>  static int qcom_pcie_probe(struct platform_device *pdev)
>  {
>  	const struct qcom_pcie_cfg *pcie_cfg;
> +	unsigned long max_freq = INT_MAX;

Why isn't this ULONG_MAX ?

You should also include <linux/limits.h>.

>  	struct device *dev = &pdev->dev;
> +	struct dev_pm_opp *opp;
>  	struct qcom_pcie *pcie;
>  	struct dw_pcie_rp *pp;
>  	struct resource *res;
> @@ -1539,9 +1556,42 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> -	ret = qcom_pcie_icc_init(pcie);
> -	if (ret)
> +	/* OPP table is optional */
> +	ret = devm_pm_opp_of_add_table(dev);
> +	if (ret && ret != -ENODEV) {
> +		dev_err_probe(dev, ret, "Failed to add OPP table\n");
>  		goto err_pm_runtime_put;
> +	}
> +
> +	/*
> +	 * Before PCIe link is initialized vote for highest OPP in the OPP table,
> +	 * so that we are voting for maximum voltage corner for the link to come up
> +	 * in maximum supported speed. At the end of the probe(), OPP will be
> +	 * updated using qcom_pcie_icc_opp_update().
> +	 */
> +	if (!ret) {
> +		opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
> +		if (IS_ERR(opp)) {
> +			dev_err_probe(pci->dev, PTR_ERR(opp),
> +				      "Unable to find max freq OPP\n");
> +			goto err_pm_runtime_put;
> +		} else {
> +			ret = dev_pm_opp_set_opp(dev, opp);
> +		}
> +
> +		dev_pm_opp_put(opp);
> +		if (ret) {
> +			dev_err_probe(pci->dev, ret,
> +				      "Failed to set OPP for freq %ld\n",
> +				      max_freq);

It's unsigned so use %lu.

-- 
 i.

