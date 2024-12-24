Return-Path: <linux-pci+bounces-19010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E79339FBF51
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 15:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552551885A63
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 14:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C867638F91;
	Tue, 24 Dec 2024 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Otof7nH1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E08F7D;
	Tue, 24 Dec 2024 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735051602; cv=none; b=eqo/1oGZ6/TulU/1dY7/0dGYqHNL5e9wAurHLyZB9tPdZL2qFe+9Mt2HCTLDJ6Nwy+WJUnemhiZtosNwJiF8kHycKLiOWv5sKgJ9+fN3s5uDFkKFrK9BrBDP/aAsw3DdIYsihFZE+Vf2TnobNgQoFmMJE9dC2avYs94RViMrvN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735051602; c=relaxed/simple;
	bh=AHk13ZAMnRVat3D717PVrU2yOWEilqokAf0OwV++COU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUKObA9ZvoygfwBKZe+ujOUOOrsiflQKUPt+sApsv+jMS8SAY2RXQSfjSam6L5jsrKDrH5VOuIvs0ljY01Xq+jSKzo0sffnfq/k+hrZo8qTjL3K/WPVMiK8NKH1HyuLcjE/H/0Uc7GxFZarSD6YHmUysDLKs6+Er/+ySMFac8sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Otof7nH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B8AC4CED0;
	Tue, 24 Dec 2024 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735051602;
	bh=AHk13ZAMnRVat3D717PVrU2yOWEilqokAf0OwV++COU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Otof7nH112K8AJcYznBV7brNq8It2SurJ/dKqozubjmABDw42TrOwQeOyWhdvAMyC
	 kPAgTwimX4vhoRfcbR1mwKrmtVTZl7LYv24ejiYmtQSxzl3lZyIvBG0jGnodKpNTic
	 qJqF8sk20nxoOiQ0/NUBZarEnvOO8fLR6BgeL25HCqesT3vZC+2MbojcA3LBTR83K+
	 TA3MAClI1JGuELZA3mGRcAudbu3XhEOfICpfs2ah71lfUFnWNOY6Ddzb+KaASrIiPi
	 A3bfK2+jqJ5I+RPfpQFAqhbJJUv06Wu7Bht45xpC26Uu2V6Y+HFtNoNSx812hADr7e
	 +qpuhItqRaESw==
Date: Tue, 24 Dec 2024 20:16:38 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com,
	dmitry.baryshkov@linaro.org, quic_srichara@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 2/5] phy: qcom: Introduce PCIe UNIPHY 28LP driver
Message-ID: <Z2rJTgYxNMqnZuyi@vaman>
References: <20241217100359.4017214-1-quic_varada@quicinc.com>
 <20241217100359.4017214-3-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217100359.4017214-3-quic_varada@quicinc.com>

On 17-12-24, 15:33, Varadarajan Narayanan wrote:

> +#define RST_ASSERT_DELAY_MIN_US		100
> +#define RST_ASSERT_DELAY_MAX_US		150
> +#define PIPE_CLK_DELAY_MIN_US		5000
> +#define PIPE_CLK_DELAY_MAX_US		5100
> +#define CLK_EN_DELAY_MIN_US		30
> +#define CLK_EN_DELAY_MAX_US		50
> +#define CDR_CTRL_REG_1		0x80
> +#define CDR_CTRL_REG_2		0x84
> +#define CDR_CTRL_REG_3		0x88
> +#define CDR_CTRL_REG_4		0x8C

Lower case here and other places and please be consistent

> +static inline int phy_pipe_clk_register(struct qcom_uniphy_pcie  *phy,
> +					struct device_node *np)
> +{
> +	const struct qcom_uniphy_pcie_data *data = phy->data;
> +	struct clk_hw *hw;
> +	char name[64];
> +	int ret;
> +
> +	snprintf(name, sizeof(name), "%s_pipe_clk_src", np->name);
> +	hw = devm_clk_hw_register_fixed_rate(phy->dev, name, NULL, 0,
> +					     data->pipe_clk_rate);
> +	if (IS_ERR(hw))
> +		return dev_err_probe(phy->dev, PTR_ERR(hw),
> +				     "Unable to register %s\n", name);
> +
> +	ret = devm_of_clk_add_hw_provider(phy->dev, of_clk_hw_simple_get, hw);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

just return devm_of_clk_add_hw_provider()

-- 
~Vinod

