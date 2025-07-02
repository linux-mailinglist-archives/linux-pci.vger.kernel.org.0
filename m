Return-Path: <linux-pci+bounces-31285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9439AF5D56
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 17:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7CF44417D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3562B303DC3;
	Wed,  2 Jul 2025 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCGgA+c9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B972D0C9E;
	Wed,  2 Jul 2025 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470419; cv=none; b=fV1ihhJetIMif23aFqEQScJimd1Ve47+4Ml+LCCkMYZeZrYG+DjLTomuOdHcl3Y97GXuDQeLkPEP/rcPE5fc53LhoG98szXRwB8KssFm2crR69y7xytw9XcCDHsfvXR9MNTIpKXhr63JVFol80+FnDy/D81v7zxuU/FF8HO++Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470419; c=relaxed/simple;
	bh=m4jNXgT+w4Hs09jExxagGWXs5YRAnZ/7SVfxbiR92Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0jm/UZ2T7m1rShcOdLMkhczFoXvB6gGASUcZ28ncNBqnQ9eS+NOUJ9EzXeTrqyU3aCusaqUtNYrh0DFkRY/GjbMNiEkfY+5ZjQBo4CrPZwey3WlrSY3At0bFNO+Eo2uxD0S4jBBnKGXtLPeIlTv4JOVj1Yizs2J+hFZG3iKmUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCGgA+c9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77315C4CEE7;
	Wed,  2 Jul 2025 15:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751470418;
	bh=m4jNXgT+w4Hs09jExxagGWXs5YRAnZ/7SVfxbiR92Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LCGgA+c9TFzb/8uksnZ2Tj1ghRaQm6VM0g/MJYbMQ1521YHgfeqEZR7CQJrApug9P
	 0+Pcpa11cSgNytCUmkvrP7LZzgluUoktRaxJR9yAWJZMlGaWaVhj6fMzpXtx6kUHJy
	 9jsSwjGpDw2+ryhZoogfhphKmZOiofVVfH5WPa7TgOlkTOCY7pbey7nOH1FvmYPB2R
	 K3FnnKfK08IF8KdiLIltGVesNdNtPWJreWfJD0QDrXq7/wg/3RPHfJ9vwb9cqOJuJZ
	 schKz4Wufn+rbeAtuTZnq8+IjUpyqMVVceL85N8aAP1koCkDUawU4C7oGxY39NFkTC
	 HR4cYpJRstw6g==
Date: Wed, 2 Jul 2025 21:03:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v5 2/2] PCI: qcom: Add support for multi-root port
Message-ID: <ws2kdznvbrvuvb6k4jov5cd4qzvadeaffjqgeso7u72stormlg@2ffiexejkrk6>
References: <20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com>
 <20250702-perst-v5-2-920b3d1f6ee1@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702-perst-v5-2-920b3d1f6ee1@qti.qualcomm.com>

On Wed, Jul 02, 2025 at 04:50:42PM GMT, Krishna Chaitanya Chundru wrote:

[...]

> -	ret = phy_init(pcie->phy);
> -	if (ret)
> -		goto err_pm_runtime_put;
> +	for_each_available_child_of_node(dev->of_node, of_port) {
> +		ret = qcom_pcie_parse_port(pcie, of_port);
> +		of_node_put(of_port);
> +		if (ret) {
> +			if (ret != -ENOENT) {
> +				dev_err_probe(pci->dev, ret,
> +					      "Failed to parse port nodes %d\n",
> +					      ret);
> +				goto err_port_del;
> +			}
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * In the case of properties not populated in root port, fallback to the
> +	 * legacy method of parsing the host bridge node. This is to maintain DT
> +	 * backwards compatibility.
> +	 */
> +	if (ret) {
> +		pcie->phy = devm_phy_optional_get(dev, "pciephy");
> +		if (IS_ERR(pcie->phy)) {
> +			ret = PTR_ERR(pcie->phy);
> +			goto err_pm_runtime_put;

Shouldn't this and below be err_port_del?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

