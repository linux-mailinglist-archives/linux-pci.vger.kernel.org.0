Return-Path: <linux-pci+bounces-11377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C1094980B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 21:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A46F1C228C8
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65B780025;
	Tue,  6 Aug 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF7hcLy0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6A4F8A0;
	Tue,  6 Aug 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971525; cv=none; b=Oi4axgJle2a3XjzbjRWEZsqJWSaIu8wNkj27kXXWqHTbccu/gjhhyqAi9i6zebJnog2ri2PQnv/INIZNz2d6AWwTpnmYzNXnys4OtggD9aMRMWFugTd4ON3fHsObSY5qozUVa5xviItWxvLMk3RciNKRLYYIREYGb5BcSpbsfW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971525; c=relaxed/simple;
	bh=MUntDv2gD5+r+bQ9Gq55BzMlclzgUuGCotLVqMS29C8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VpF/Sa0qzQQ6mxbfAbTAe1YM33E1/6HTXn72FNM3dLpty3eJcd8ma+ID7HDADqcXYOLiKDyVV9Gpn5V9QmuYWzgOvM7OV4TtYIDr218c4QIl8auvmIA1fX0Zz7e6vJFYwi6W6cylysNJiAip+U17f+vqPnAlhm7I30SMSgRcax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF7hcLy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF02C32786;
	Tue,  6 Aug 2024 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722971525;
	bh=MUntDv2gD5+r+bQ9Gq55BzMlclzgUuGCotLVqMS29C8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eF7hcLy04y8SklVvaENBicO1NsGIl5KbsF37nza/Xt5zlCAp60c00afp8+p72rvpF
	 Cgx0mn1gWokiW68mKXvEIdBD42b2TMdsmbs1wedysOqm8GPdmIjWTWUtknEaNcb1Lf
	 Ta8NGJOWxvP/AG0e7t41JjEl8/EuNWUuTXSU1AdQiGAXT50L3OAMoG6qIw+nHHeF7L
	 ktM/Ly8qy4L9NUBZIuBaFpmNYg/F8G097FtCkwdOAZEqRFJ+YqMY+7c8rfM3w1DSsA
	 iIK68nGhgRl3bdpEfSw71nf6iXxoKUbo41sSuLBF06X6+kU9gSaN0Mpg6jXe2uIQvr
	 pC+AviepEa6QA==
Date: Tue, 6 Aug 2024 14:12:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	cros-qcom-dts-watchers@chromium.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	andersson@kernel.org, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 7/8] PCI: qcom: Add support for host_stop_link() &
 host_start_link()
Message-ID: <20240806191203.GA73014@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803-qps615-v2-7-9560b7c71369@quicinc.com>

On Sat, Aug 03, 2024 at 08:52:53AM +0530, Krishna chaitanya chundru wrote:
> For the switches like QPS615 which needs to configure it before
> the PCIe link is established.
> 
> if the link is not up assert the PERST# and disable LTSSM bit so
> that PCIe controller will not participate in the link training
> as part of host_stop_link().
> 
> De-assert the PERST# and enable LTSSM bit back in host_start_link().
> 
> Introduce ltssm_disable function op to stop the link training.

pcie-qcom.c is a driver for a PCIe host controller.  Apparently QPS615
is a switch in a hierarchy that could be below any PCIe host
controller, so I'm missing the connection with pcie-qcom.c.

Does this fix a problem that only occurs with pcie-qcom.c?  What
happens if you put a QPS615 below some other controller?

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 39 ++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0180edf3310e..f4a6df53139c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -233,6 +233,7 @@ struct qcom_pcie_ops {
>  	void (*host_post_init)(struct qcom_pcie *pcie);
>  	void (*deinit)(struct qcom_pcie *pcie);
>  	void (*ltssm_enable)(struct qcom_pcie *pcie);
> +	void (*ltssm_disable)(struct qcom_pcie *pcie);
>  	int (*config_sid)(struct qcom_pcie *pcie);
>  };
>  
> @@ -555,6 +556,41 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static int qcom_pcie_host_start_link(struct dw_pcie *pci)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +
> +	if (!dw_pcie_link_up(pcie->pci))  {
> +		qcom_ep_reset_deassert(pcie);
> +
> +		if (pcie->cfg->ops->ltssm_enable)
> +			pcie->cfg->ops->ltssm_enable(pcie);
> +	}
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_host_stop_link(struct dw_pcie *pci)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +
> +	if (!dw_pcie_link_up(pcie->pci))  {
> +		qcom_ep_reset_assert(pcie);
> +
> +		if (pcie->cfg->ops->ltssm_disable)
> +			pcie->cfg->ops->ltssm_disable(pcie);
> +	}
> +}
> +
> +static void qcom_pcie_2_3_2_ltssm_disable(struct qcom_pcie *pcie)
> +{
> +	u32 val;
> +
> +	val = readl(pcie->parf + PARF_LTSSM);
> +	val &= ~LTSSM_EN;
> +	writel(val, pcie->parf + PARF_LTSSM);
> +}
> +
>  static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
>  {
>  	u32 val;
> @@ -1306,6 +1342,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>  	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>  	.deinit = qcom_pcie_deinit_2_7_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +	.ltssm_disable = qcom_pcie_2_3_2_ltssm_disable,
>  	.config_sid = qcom_pcie_config_sid_1_9_0,
>  };
>  
> @@ -1363,6 +1400,8 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> +	.host_start_link = qcom_pcie_host_start_link,
> +	.host_stop_link = qcom_pcie_host_stop_link,
>  };
>  
>  static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
> 
> -- 
> 2.34.1
> 

