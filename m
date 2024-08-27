Return-Path: <linux-pci+bounces-12245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2135960193
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 08:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5BF1F22AC5
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 06:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DAA156886;
	Tue, 27 Aug 2024 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLtCluKm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5D14373F;
	Tue, 27 Aug 2024 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739951; cv=none; b=klo2bEeeTuD7tlhNTP4G8HgEBUjEDElTgGE3sWuIsYidT30aWN3EPKnLNryNJO3DifxcJxJ/eRwXLLkBHsBpmZSqGudHddm9UhIn9shkoI1dHqp+63slEEYEsD9VhA6eax462Cc8lYa9Po+SyAUA99eBsOQN0Y/0O+lzasyzKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739951; c=relaxed/simple;
	bh=fN1ZnF3+bANyj6nCHUeB1Vt6rRnkOrtSXJk+7r0jQKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDlBCUPfWPv7M9c/CE4D4iBKjxhFdBqcXq6yUX006tXTFpy3r9fzWaUChcC2hkOYNqziAArnDZEwSbjNj9eFu/AqAMRSF70IZF0tlbB392V+mmXyniLIeFl+eS5mKwpcyzC3yYeVQnr5JYwR7eX5gdEIv3MOW5tQTrULhPKRmf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLtCluKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB670C4FF63;
	Tue, 27 Aug 2024 06:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724739950;
	bh=fN1ZnF3+bANyj6nCHUeB1Vt6rRnkOrtSXJk+7r0jQKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLtCluKmvD0oXuf6N1ljeQMDrLNkQny4MvNscJbGF2J9y3EvvCTNBZN/NqLCzGDpP
	 fU5Vk2okwhe3QGihz7Lgf8gwKk2Y2Sg50Sj163jeOJspkybovyygXxMudrdf14K8dc
	 Ma7bUVWq9bdphXUWiL0iuwX1DxHPHOLujQ6GBGaoQg/uOMrICoClDQDiteZfRJmxl7
	 /+KGZk9JavCq2QFlSVAIqPbkbuD/6Kukll60DFRuopF8cTUUNhfazAezT/0phK0Gni
	 g2DS3Zs5IOH3r3KwWQDZNQ4PIVqaxQoKprtecnjf4X0OeLxEdlFlPjONs+BeNtBzjD
	 eV3O1G+QBAEfQ==
Date: Tue, 27 Aug 2024 08:25:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, robimarko@gmail.com
Subject: Re: [PATCH V2 3/6] phy: qcom: Introduce PCIe UNIPHY 28LP driver
Message-ID: <svraqyrvmyfvezj6zuzsoc5cy3lqklwxkmjdloquj2v4r5ik72@xnbaoigiikeu>
References: <20240827045757.1101194-1-quic_srichara@quicinc.com>
 <20240827045757.1101194-4-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827045757.1101194-4-quic_srichara@quicinc.com>

On Tue, Aug 27, 2024 at 10:27:54AM +0530, Sricharan R wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add Qualcomm PCIe UNIPHY 28LP driver support present
> in Qualcomm IPQ5018 SoC and the phy init sequence.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

...

> +static int qcom_uniphy_pcie_probe(struct platform_device *pdev)
> +{
> +	struct qcom_uniphy_pcie *phy;
> +	int ret;
> +	struct phy *generic_phy;
> +	struct phy_provider *phy_provider;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = of_node_get(dev->of_node);
> +
> +	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, phy);
> +	phy->dev = &pdev->dev;
> +
> +	phy->data = of_device_get_match_data(dev);
> +	if (!phy->data)
> +		return -EINVAL;
> +
> +	ret = qcom_uniphy_pcie_get_resources(pdev, phy);
> +	if (ret < 0)
> +		dev_err_probe(&pdev->dev, ret, "Failed to get resources:\n");

What the hell happened here? Read my review one more time and then git
grep for usage of dev_err_probe.

NAK.

Best regards,
Krzysztof


