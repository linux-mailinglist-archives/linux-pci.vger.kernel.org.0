Return-Path: <linux-pci+bounces-10426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C3933939
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 10:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50E82827B2
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 08:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87238FA1;
	Wed, 17 Jul 2024 08:39:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF741A94;
	Wed, 17 Jul 2024 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205546; cv=none; b=kmlIlVWfuZKjFrxuHwqT9ByB8Y0puj9HkamcBrSEL7KNTv8d0q1G7uQIh4m2aMvUmGeTRbjVbMBFv3VlckHWb6NOjusZoHqc1938PMy+6XOrJjCawpL2lgPWoR+v7X4/Tvv/s99oj9r8O+Jnw1ywx0exB4SJdqxlEfIKtAiMlf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205546; c=relaxed/simple;
	bh=+0JnY0BRZ9gFkA3BfeIiX/VZb78v6eNHC2ZKCKCZMlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/Mrvcol1nbzjhJBi3IC3ASUJsmmxX9/7VyjvQYd2lYvS0Qg1nfJIZt7KrqeHwAcosHH4sZCrmfuZbtTvqr9+Cb3yVnC8mTuBZCj7A90CvnZkUfzjQS2rzEi4CzjYno4lVOR6XCmFPIUVdAYj2+bUUKw4/saShJBizxgLEm2j5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1C9C32782;
	Wed, 17 Jul 2024 08:39:00 +0000 (UTC)
Date: Wed, 17 Jul 2024 14:08:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	devi priya <quic_devipriy@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Anusha Rao <quic_anusha@quicinc.com>
Subject: Re: [PATCH V6 4/4] PCI: qcom: Add support for IPQ9574
Message-ID: <20240717083856.GD2574@thinkpad>
References: <20240716092347.2177153-1-quic_srichara@quicinc.com>
 <20240716092347.2177153-5-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716092347.2177153-5-quic_srichara@quicinc.com>

On Tue, Jul 16, 2024 at 02:53:47PM +0530, Sricharan R wrote:
> From: devi priya <quic_devipriy@quicinc.com>
> 
> The IPQ9574 platform has four Gen3 PCIe controllers:
> two single-lane and two dual-lane based on SNPS core 5.70a.
> 
> QCOM IP rev is 1.27.0 and Synopsys IP rev is 5.80a.
> Add a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'
> which reuses all the members of 'ops_2_9_0' except for the
> post_init as the SLV_ADDR_SPACE_SIZE configuration differs
> between 2_9_0 and 1_27_0.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [V6] Fixed all Manivannan's and Bjorn Helgaas comments.
>       Removed the SLV_ADDR_SPACE_SZ_1_27_0 macro to have default value.
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 31 ++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0180edf3310e..26acd9f5385e 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1116,16 +1116,13 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
>  	return clk_bulk_prepare_enable(res->num_clks, res->clks);
>  }
>  
> -static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> +static int qcom_pcie_post_init(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci = pcie->pci;
>  	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	u32 val;
>  	int i;
>  
> -	writel(SLV_ADDR_SPACE_SZ,
> -		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> -
>  	val = readl(pcie->parf + PARF_PHY_CTRL);
>  	val &= ~PHY_TEST_PWR_DOWN;
>  	writel(val, pcie->parf + PARF_PHY_CTRL);
> @@ -1165,6 +1162,18 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
> +{
> +	return qcom_pcie_post_init(pcie);
> +}
> +
> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> +{
> +	writel(SLV_ADDR_SPACE_SZ, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> +

As discussed in [1], DBI/ATU mirroring should be disabled completely to avoid
the enumeration issue you are seeing on this platform. Please rebase on top of
the referenced patch (once v2 gets posted).

- Mani

[1] https://lore.kernel.org/linux-arm-msm/a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com/
-- 
மணிவண்ணன் சதாசிவம்

