Return-Path: <linux-pci+bounces-33166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77788B15D92
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 11:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D2556570B
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E523326E71A;
	Wed, 30 Jul 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqjE9TQ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3379269AFB;
	Wed, 30 Jul 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869349; cv=none; b=Nx+qYs0srM6a5Q7LCZNKg9s91Xgezh2DAD3jocEF+eW/O9ZJ+tG7gkyF+DUFT1dt6asA+Vss70XckZHJeZ/WLYAqyZ86lPhgblpa6zJ4nQdW5rWduCLSUKbHwE4VQjMYLbxIbvJhD2cOdSXsqElDMW2Wlnm3nIYURSca0ALC3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869349; c=relaxed/simple;
	bh=FqV1olhUgft990I/oyZdVydA0AezeH5ltbHMVflBEyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqNYVZHfxw1JHbp/zTg3Bu1rfIhlGcO4HH5Rt/1Kdwoq14Mse1wAX76m2HHeh7ZY7ZtSIk8WnVreRMdbP06jz5d3Ex2OICDTrY/hfC6tFApLKyfT9DxI6tIUHWCykKC82gVCqktod8g3ImexLQ+w2Mg3gN147kO1UQXyMbbuWVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqjE9TQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABB0C4CEF5;
	Wed, 30 Jul 2025 09:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753869349;
	bh=FqV1olhUgft990I/oyZdVydA0AezeH5ltbHMVflBEyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VqjE9TQ0NooUsJykjVTLtlDpM2IjROOWmoZQeKXPI2UDXExgyqqZ37HESjkbJcp7j
	 XGX9xNfsJSfgsp+8c2hiVm3L6U+TRqizMEvf3rfBAZd/p6axkEBkt5gGFMkAedxrzU
	 v/xFtq5fLgRwLHOPdZ2Lf3Y1RwclrR5J4xkgC25w3owQGvFCuu25IKG6LnHoyAmnq0
	 bsJ7TA4QmeInt+0k90dNCkVg/XyJlzlAWMMfXzwNzkYPStpWjgUa7yJQLXfXOISryn
	 Arn5MIaGRb+N+RcXy5Ywc+ztAn0PHTIEjQHzD8U5YoqRskFvhRdK++1k7gtrQ64zC1
	 KiDwDcg+GGHSA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uh3XJ-000000006JN-3FwZ;
	Wed, 30 Jul 2025 11:55:49 +0200
Date: Wed, 30 Jul 2025 11:55:49 +0200
From: Johan Hovold <johan@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
	kw@linux.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v9 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300
Message-ID: <aInsJbZSqgRYkB5x@hovoldconsulting.com>
References: <20250725104037.4054070-1-ziyue.zhang@oss.qualcomm.com>
 <20250725104037.4054070-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725104037.4054070-2-ziyue.zhang@oss.qualcomm.com>

On Fri, Jul 25, 2025 at 06:40:33PM +0800, Ziyue Zhang wrote:
> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
> specified in the device tree node. Hence, move the qcs8300 phy
> compatibility entry into the list of PHYs that require six clocks.
> 
> Removed the phy_aux clock from the PCIe PHY binding as it is no longer
> used by any instance.
> 
> Fixes: e46e59b77a9e ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS8300 QMP PCIe PHY Gen4 x2")
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml  | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index b6f140bf5b3b..e04d5940a498 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -65,7 +65,6 @@ properties:
>        - enum: [rchng, refgen]
>        - const: pipe
>        - const: pipediv2
> -      - const: phy_aux

Just realised that you forgot to update clocks: maxItems above, with
that fixed you can add my:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

