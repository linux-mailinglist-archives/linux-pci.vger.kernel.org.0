Return-Path: <linux-pci+bounces-29040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54541ACF3B8
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 18:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0901B7A2D2A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CD41DE4F6;
	Thu,  5 Jun 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5NQgb4L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4AD7462;
	Thu,  5 Jun 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139609; cv=none; b=pZIMPniu+7oAq0cTX+fgDWwHRlo8j2grFNeyi0k+rrs/VuiU2lotZOtk3Wh651IbO0Jta8fXh0v6q+ERS3vaBjUwK5USL17tqOK2m+74FIgfRDyy9daAcWzh8SCRXN1iG53aquQ6xptWRZHWU1vKiZYXTGKAx/o+Ton2xzDEpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139609; c=relaxed/simple;
	bh=Af1uKcdbh6SEqUFsKACSRIB1K/ZURGKzj/oGDdF70vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1i6o6Lcn1PcSsoiiJWhnTEBb9f80hG1qVX9hgGra4aHd066AtmnGLab42tGZIAZpJw+CO9fHc6G1DTDEati6uyV0I33/aEYMk20/qF6L8XH+gD3bfnfqLvFqZIKV3QqW8AOh7axxHWgqxMqdNM41l6LTVkUbJhL+tfl5G16Qpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5NQgb4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEA1C4CEE7;
	Thu,  5 Jun 2025 16:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749139609;
	bh=Af1uKcdbh6SEqUFsKACSRIB1K/ZURGKzj/oGDdF70vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5NQgb4LcS6pItIgmi2W/ZqeFrQogpahRO8VADe6TI3jHmqxHteu3oGyZcC1x3alm
	 SoyZinjQf7Q9RMrmPeSfUCoLvupcCnnh5HfV3NAvW2l7GkwvbWQxV2s4DMNdL04i21
	 GstOeHMenHhklhzf2sMYxUd7bvO0Ze95Bx75Ygtki1F8Ais01yUGuD+XmXrJmeTlbQ
	 fFPv4Rpns4IxjefI3W6bvRHFGBtpYL9ojh362d8t87Nl5awp6r2QoyUeThKL3owCQY
	 LU9M8WdZulDg6PP0OT8aicaVx1iENVMDtjvLr/C0Oo/kzQ5sn70e/pGY1kox9tZdnV
	 1ZrNS/dV5zvcA==
Date: Thu, 5 Jun 2025 11:06:47 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: kishon@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
	neil.armstrong@linaro.org, abel.vesa@linaro.org,
	konradybcio@kernel.org, quic_qianyu@quicinc.com,
	andersson@kernel.org, vkoul@kernel.org, kw@linux.com,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	kwilczynski@kernel.org, krzk+dt@kernel.org,
	linux-phy@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	quic_krichai@quicinc.com
Subject: Re: [PATCH v6 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300
Message-ID: <174913960489.2681602.17404743256155518415.robh@kernel.org>
References: <20250529035635.4162149-1-quic_ziyuzhan@quicinc.com>
 <20250529035635.4162149-2-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529035635.4162149-2-quic_ziyuzhan@quicinc.com>


On Thu, 29 May 2025 11:56:30 +0800, Ziyue Zhang wrote:
> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
> specified in the device tree node. Hence, move the qcs8300 phy
> compatibility entry into the list of PHYs that require six clocks.
> 
> As no compatible need the entry which require seven clocks, delete it.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


