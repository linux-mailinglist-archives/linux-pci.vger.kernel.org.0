Return-Path: <linux-pci+bounces-2732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B30A840AB5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 17:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9491F2671A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64FB155313;
	Mon, 29 Jan 2024 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkR+Sn31"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32BD1552FE;
	Mon, 29 Jan 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544025; cv=none; b=MukbeoP4L0oeXZg1VeLzoVDvHkT6MRvrDbLpk2ximvohRlZik8A8ClISaPjtyomFRYvTFE0Ci8zKOo+WMDLtdcWMG6uiLnJPSIrHxmdaj3QbL4etUyDm5KWTox/Ys/3BCCgkzPrwNDbGMYx/viCBmAb7JgPGOXyecCMmePieQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544025; c=relaxed/simple;
	bh=d7kTJL5yA5KYsTfmmiVBkb+irsEYdcGncOobIUTBvxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxzXNoEifFBtMvUVLRJIlL7lV1YwVCwZoz8Heorpi58/xn6k9js5C/CTfsjNst6nrMJvn+oopRkJY1VF6NpKl+To0cytj0NyEQQQlO7UOKJFJ+zZ7Whx8JpqzWPscRmvXszu6fSNdQbuc3Yh4Ba/te35qpTbvlB7b8Xv4isr/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkR+Sn31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB10C43390;
	Mon, 29 Jan 2024 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706544024;
	bh=d7kTJL5yA5KYsTfmmiVBkb+irsEYdcGncOobIUTBvxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkR+Sn31qxVYwJj06PpjCcnkbakbuOXyswHUgHAnUQxfxXuPYNH9/AdJPIr9DFudP
	 7LD2UJC56+6JehOKTitGXlPtwrjbpzXsQhY19AOlKRn4t9RNs42NrunwuYV9vv6lA1
	 SiSCglNYWNiqIQw5ttetpifKZ3RfoiXarniIMKQ5NUSMMT08dXxutjpUURWMjl+tGQ
	 2wio/1VoLqIPLC8pvOO0mJhnQGWhgY6K24EazISnuG88jFNx2Dzo5N7gn9LTFOPEV1
	 sUa4FhHgfBDMvX+gGwGd0/ozZQvf3lOKBqq9Q1PK0pmooqSXJSRJDNUc1GWYpPuaGl
	 /uJICIXalHPaw==
Date: Mon, 29 Jan 2024 21:30:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20240129160000.GF22617@thinkpad>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-6-77bbf7d0cc37@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240112-opp_support-v6-6-77bbf7d0cc37@quicinc.com>

On Fri, Jan 12, 2024 at 07:52:05PM +0530, Krishna chaitanya chundru wrote:
> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> maintains hardware state of a regulator by performing max aggregation of
> the requests made by all of the processors.
> 

s/processors/clients

> PCIe controller can operate on different RPMh performance state of power
> domain based up on the speed of the link. And this performance state varies
> from target to target.
> 
> It is manadate to scale the performance state based up on the PCIe speed
> link operates so that SoC can run under optimum power conditions.
> 
> Add Operating Performance Points(OPP) support to vote for RPMh state based
> upon GEN speed link is operating.
> 
> OPP can handle ICC bw voting also, so move icc bw voting through opp
> framework if opp entries are present.
> 
> In PCIe certain gen speeds like GEN1x2 & GEN2X1 or GEN3x2 & GEN4x1 use
> same icc bw and has frequency, so use frequency based search to reduce
> number of entries in the opp table.
> 
> Don't initialize icc if opp is supported.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 83 ++++++++++++++++++++++++++++------
>  1 file changed, 70 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 035953f0b6d8..31512dc9d6ff 100644
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
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1404,16 +1406,14 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
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
>  	int ret;
>  
> -	if (!pcie->icc_mem)
> -		return;
> -
>  	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
>  
> @@ -1424,11 +1424,42 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>  	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>  	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
>  
> -	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> -	if (ret) {
> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> -			ret);
> +	if (pcie->opp_supported) {
> +		switch (speed) {
> +		case 1:
> +			freq = 2500000;
> +			break;
> +		case 2:
> +			freq = 5000000;
> +			break;
> +		case 3:
> +			freq = 8000000;
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			fallthrough;
> +		case 4:
> +			freq = 16000000;
> +			break;
> +		}

This switch case is PCIe generic, so need to be moved to drivers/pci/pci.c.
There is already an API, pcie_link_speed_mbps() that returns the frequency in
MBps but uses the pcie_capability_read_word() API to read LNKSTA of the device.

But you can move the switch case inside that API to a separate function and
reuse that here.

> +
> +		opp = dev_pm_opp_find_freq_exact(pci->dev, freq * width, true);
> +		if (!IS_ERR(opp)) {
> +			ret = dev_pm_opp_set_opp(pci->dev, opp);
> +			if (ret)
> +				dev_err(pci->dev, "Failed to set opp: freq %ld ret %d\n",
> +					dev_pm_opp_get_freq(opp), ret);
> +			dev_pm_opp_put(opp);
> +		}
> +	} else {
> +		ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> +		if (ret) {
> +			dev_err(pci->dev, "failed to set interconnect bandwidth for pcie-mem: %d\n",
> +				ret);
> +		}
>  	}
> +
> +	return;
>  }
>  
>  static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
> @@ -1471,8 +1502,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
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
> @@ -1539,9 +1572,33 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
> +	/* vote for max freq in the opp table if opp table is present */

/*
 * Use highest OPP here if the OPP table is present. At the end of the probe(),
 * OPP will be updated using qcom_pcie_icc_opp_update().
 */

- Mani

-- 
மணிவண்ணன் சதாசிவம்

