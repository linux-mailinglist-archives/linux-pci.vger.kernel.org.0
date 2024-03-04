Return-Path: <linux-pci+bounces-4458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8DD870874
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 18:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D06B255EA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ED4612F3;
	Mon,  4 Mar 2024 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3cNLiH6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC9612F0;
	Mon,  4 Mar 2024 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574083; cv=none; b=ZIr1lsi0q0c8YyLDab8/1RKFZ/gjOtgrIHL8S+ZdPgBtN/+HJHiuxxnloY83cht1dXAOuhiBCFGxyd2CH8aJe3ronEJc0OtH6NXg9L12DKfvBqC2BwiKW3aJmnfk2e1Dq13KFYnz/pCPA7LdS0rlI1/qqfX6esQWAWx4PSXGBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574083; c=relaxed/simple;
	bh=jhOZLqBkPD3zeVmeTDQUgpIO94j8OorF+PQ+rqZSOlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqIqX+AOjcm5THh4Bfgh82UGJX43RdI4H+aqkSPTCWCmOxF7iCGL+AY1szBNGKiyLRfN4OP+MXQ0F7v7uJxKqrwC5A/utBS50UEaeeOApZYvWa+gaJc1k72xQNVK2M3dvnfjoLF1HbjQ6b9d1uUfKM5t2bWPj2KZNveq/inYR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3cNLiH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9A1C433F1;
	Mon,  4 Mar 2024 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709574082;
	bh=jhOZLqBkPD3zeVmeTDQUgpIO94j8OorF+PQ+rqZSOlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3cNLiH6dm+MbhhR2gjsEO1M1MLbQJRV0E+ihS2eJeFUFn78AJ4Pvi3LFD8lYN9uj
	 tL1LR5fKflqYF2cNQtkzF+S2l0jUo2bsn3fvY93v8266DCNsYl9ukxt57PR3xlCukP
	 Wu8s5fAl2abOCYz2ergXBrizaMngC1tnMUN3GG//ZRCAS80t7vgyD1IuiLdjKDBgaJ
	 F3Ug2FFmU38aO7AhMd3Xx77R1n7ziA9QP9Mx0alPO7XVArOmsp3dj0HdEJAH+AXgws
	 belXPFXyRPvF+Z8oda97pshfIY44ck/LSfi+1Ehvr53e2aHjpqeZyemUqYnpDSy/7X
	 QEgdv6lbiRX5Q==
Date: Mon, 4 Mar 2024 23:11:11 +0530
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
	quic_nitegupt@quicinc.com, quic_parass@quicinc.com,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v8 3/7] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Message-ID: <20240304174111.GB31079@thinkpad>
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
 <20240302-opp_support-v8-3-158285b86b10@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240302-opp_support-v8-3-158285b86b10@quicinc.com>

On Sat, Mar 02, 2024 at 09:29:57AM +0530, Krishna chaitanya chundru wrote:
> To access PCIe registers, PCIe BAR space, config space the CPU-PCIe
> ICC (interconnect consumers) path should be voted otherwise it may
> lead to NoC (Network on chip) timeout. We are surviving because of
> other driver vote for this path.
> 
> As there is less access on this path compared to PCIe to mem path
> add minimum vote i.e 1KBps bandwidth always.

Please add the info that 1KBps is what shared by the HW team.

> 
> When suspending, disable this path after register space access
> is done.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 38 ++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 10f2d0bb86be..a0266bfe71f1 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -240,6 +240,7 @@ struct qcom_pcie {
>  	struct phy *phy;
>  	struct gpio_desc *reset;
>  	struct icc_path *icc_mem;
> +	struct icc_path *icc_cpu;
>  	const struct qcom_pcie_cfg *cfg;
>  	struct dentry *debugfs;
>  	bool suspended;
> @@ -1372,6 +1373,9 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>  	if (IS_ERR(pcie->icc_mem))
>  		return PTR_ERR(pcie->icc_mem);
>  
> +	pcie->icc_cpu = devm_of_icc_get(pci->dev, "cpu-pcie");
> +	if (IS_ERR(pcie->icc_cpu))
> +		return PTR_ERR(pcie->icc_cpu);
>  	/*
>  	 * Some Qualcomm platforms require interconnect bandwidth constraints
>  	 * to be set before enabling interconnect clocks.
> @@ -1381,7 +1385,19 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>  	 */
>  	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
>  	if (ret) {
> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +		dev_err(pci->dev, "failed to set interconnect bandwidth for pcie-mem: %d\n",

"PCIe-MEM"

> +			ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * The config space, BAR space and registers goes through cpu-pcie path
> +	 * Set peak bandwidth to 1KBps as recommended by HW team for this path
> +	 * all the time.

How about,

	"Since the CPU-PCIe path is only used for activities like register
	access, Config/BAR space access, HW team has recommended to use a
	minimal bandwidth of 1KBps just to keep the link active."

> +	 */
> +	ret = icc_set_bw(pcie->icc_cpu, 0, kBps_to_icc(1));
> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n",
>  			ret);
>  		return ret;
>  	}
> @@ -1573,7 +1589,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  	 */
>  	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
>  	if (ret) {
> -		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
> +		dev_err(dev, "Failed to set interconnect bandwidth for pcie-mem: %d\n", ret);

"PCIe-MEM"

>  		return ret;
>  	}
>  
> @@ -1597,6 +1613,18 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  		pcie->suspended = true;
>  	}
>  
> +	/* Remove CPU path vote after all the register access is done */

"Remove the vote for CPU-PCIe path now, since at this point onwards, no register
access will be done."

> +	ret = icc_disable(pcie->icc_cpu);
> +	if (ret) {
> +		dev_err(dev, "failed to disable icc path of cpu-pcie: %d\n", ret);

"CPU-PCIe"

> +		if (pcie->suspended) {
> +			qcom_pcie_host_init(&pcie->pci->pp);

Interesting. So if icc_disable() fails, can the IP continue to function?

> +			pcie->suspended = false;
> +		}
> +		qcom_pcie_icc_update(pcie);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1605,6 +1633,12 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>  	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>  	int ret;
>  
> +	ret = icc_enable(pcie->icc_cpu);
> +	if (ret) {
> +		dev_err(dev, "failed to enable icc path of cpu-pcie: %d\n", ret);

"CPU-PCIe"

- Mani

-- 
மணிவண்ணன் சதாசிவம்

