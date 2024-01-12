Return-Path: <linux-pci+bounces-2116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B9A82C3E5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 17:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46C2286149
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 16:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1409B7762B;
	Fri, 12 Jan 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KITWq1LX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74AF6DD08;
	Fri, 12 Jan 2024 16:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E740C433C7;
	Fri, 12 Jan 2024 16:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705078034;
	bh=XLbIi+FzvkY5/phGa7UWlshotiTTgXJvXXEBTRX287o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KITWq1LXFy2rWhdf5KnEM7ohv/qcZ55BbfDOZBpd8DML1T75Q9kxR6YdsoyoN7cKw
	 n/A67rKfrGZmJXi7sdecwb9zAmbeTEckeP/sRFs9/nNL44Y5nBu6c7FHDz0xD/2K7J
	 v7+jqnXqmL21ttSZcbwROoZ11hoK9+s1lcHXTIeAzzGWNLiXB2e0OPJtwMB7awUFdE
	 491D6uhQF7JgEDokUBbrPI9BhPl5v59BhzdXMt58jWccx2qdowY7NAlbCxxHeZjb43
	 CSaVCyHK0vDEzDaPlyojrZ3bjNWvU2bWcdtK4Q+5inRKXt4HnhWR+Am7bNCxYORePR
	 Dl6g86OSZWdSg==
Date: Fri, 12 Jan 2024 10:47:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 3/6] PCI: qcom: Add missing icc bandwidth vote for cpu
 to PCIe path
Message-ID: <20240112164712.GA2271535@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>

Capitalize "ICC" and "CPU" to make the subject easier to read.
"Missing" might be superfluous in the subject?  It would be nice to
have the ICC expansion once in the commit log as a hook for newbies
like me :)

On Fri, Jan 12, 2024 at 07:52:02PM +0530, Krishna chaitanya chundru wrote:
> CPU-PCIe path consits for registers PCIe BAR space, config space.
> As there is less access on this path compared to pcie to mem path
> add minimum vote i.e GEN1x1 bandwidth always.

"GEN1x1" is unnecessarily ambiguous, and the spec recommends avoiding
it (PCIe r6.0, sec 1.2).  Use the actual bandwidth numbers instead.

"PCIe" to match above.  Also below in comments and messages.

> In suspend remove the cpu vote after register space access is done.

"CPU" to match above.

> Fixes: c4860af88d0c ("PCI: qcom: Add basic interconnect support")
> cc: stable@vger.kernel.org
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 11c80555d975..035953f0b6d8 100644
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
> @@ -1381,7 +1385,18 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>  	 */
>  	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
>  	if (ret) {
> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +		dev_err(pci->dev, "failed to set interconnect bandwidth for pcie-mem: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * The config space, BAR space and registers goes through cpu-pcie path.
> +	 * Set peak bandwidth to single-lane Gen1 for this path all the time.

Numbers instead of "Gen1".

> +	 */
> +	ret = icc_set_bw(pcie->icc_cpu, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n",
>  			ret);
>  		return ret;
>  	}
> @@ -1573,7 +1588,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  	 */
>  	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
>  	if (ret) {
> -		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
> +		dev_err(dev, "Failed to set interconnect bandwidth for pcie-mem: %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -1597,6 +1612,12 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  		pcie->suspended = true;
>  	}
>  
> +	/* Remove cpu path vote after all the register access is done */
> +	ret = icc_set_bw(pcie->icc_cpu, 0, 0);
> +	if (ret) {
> +		dev_err(dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n", ret);
> +		return ret;
> +	}
>  	return 0;
>  }
>  
> @@ -1605,6 +1626,12 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>  	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>  	int ret;
>  
> +	ret = icc_set_bw(pcie->icc_cpu, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> +	if (ret) {
> +		dev_err(dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n", ret);
> +		return ret;
> +	}
> +
>  	if (pcie->suspended) {
>  		ret = qcom_pcie_host_init(&pcie->pci->pp);
>  		if (ret)
> 
> -- 
> 2.42.0
> 

