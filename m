Return-Path: <linux-pci+bounces-39947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 077B0C26207
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 17:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86F324E75CB
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 16:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3AD20409A;
	Fri, 31 Oct 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjMFujyp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8734D22301;
	Fri, 31 Oct 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928270; cv=none; b=aIN82VFxIHEcBCAVNsEQcTPxFLxyt4GtGwmAt81tOIQr/llqMrwhttrvE6t7TLNkFLTf2Yq2rNFtt72If5smlRyL7caki8pz95kNotN/rz8ZzfPFK9ahMuhkWtLLaWD2E7i5E60cQKG+cWotmMCTgg32clAFnDLOaAKySGSfW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928270; c=relaxed/simple;
	bh=GELBmyWpjSc3VgISCM5QOTpO/OCBxi0Vy2YmJFKBNYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ko0RKD7NawCkqs8f8Yw3efnqjijR2JDbKfoB3m0Oivn4Hbf2ByRxRojbXLwxk/XWNzfjVIJhi7s04zLq8Yo9QVw+gqYonjHb8vBxrYrsv/fLwVmfGbOVTXGJ+yNhIwY/kveJpvyZpCToIlp2BY1G/0z8M+e3hvD3XnHK6meT57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjMFujyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A74DC4CEE7;
	Fri, 31 Oct 2025 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761928270;
	bh=GELBmyWpjSc3VgISCM5QOTpO/OCBxi0Vy2YmJFKBNYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjMFujyp/7yiA00ntfE1LOlY+aMvI5O4JwoC3+MZvNuOmvCCLchOSWEKjcZI7yVWO
	 /DjJRouRWVs+A0f0w0fiLqRwBuS77AJCvea/yMKMANDGBwfjBNMCRAXDQGJXfnC8na
	 Vt0+StQDLIPBWKxgvYvt6bbJWNntUZgCoXYzGq2kIXp++fxHmQCBycwZqPtjS8eAT4
	 4YifDbZF2XqUAQx6GZUQ4DbWscOqTW1dyHEDpOZW3ZoX2Wy57m+I5laW1cwUA2M87A
	 J9sWolpx2xgcUnIjPCFmdO7wo2c8CymAC8CtFLWGH2tq7jeDTyk2FRbi6hf/MiORgq
	 uGgFm15ZABrvA==
Date: Fri, 31 Oct 2025 11:31:08 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/9] dt-bindings: PCI: qcom: Add missing required
 power-domains and resets
Message-ID: <20251031163108.GA989164-robh@kernel.org>
References: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-0-28c1f11599fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-0-28c1f11599fe@linaro.org>

On Thu, Oct 30, 2025 at 09:50:43AM +0100, Krzysztof Kozlowski wrote:
> Changes in v2:
> - Add also resets
> - Drop cc-stable tag in the last patch
> - Link to v1: https://patch.msgid.link/20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org
> 
> Recent binding changes forgot to make power-domains and resets required.
> 
> I am not updating SC8180xp because it will be fixed other way in my next
> patchset.
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (9):
>       dt-bindings: PCI: qcom,pcie-sa8775p: Add missing required power-domains and resets
>       dt-bindings: PCI: qcom,pcie-sc7280: Add missing required power-domains and resets
>       dt-bindings: PCI: qcom,pcie-sc8280xp: Add missing required power-domains and resets
>       dt-bindings: PCI: qcom,pcie-sm8150: Add missing required power-domains and resets
>       dt-bindings: PCI: qcom,pcie-sm8250: Add missing required power-domains and resets
>       dt-bindings: PCI: qcom,pcie-sm8350: Add missing required power-domains and resets
>       dt-bindings: PCI: qcom,pcie-sm8450: Add missing required power-domains and resets
>       dt-bindings: PCI: qcom,pcie-sm8550: Add missing required power-domains and resets
>       dt-bindings: PCI: qcom,pcie-x1e80100: Add missing required power-domains and resets
> 
>  Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 3 +++
>  Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml   | 5 +++++
>  Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml | 3 +++
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml   | 5 +++++
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml   | 5 +++++
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml   | 5 +++++
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml   | 5 +++++
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml   | 5 +++++
>  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 5 +++++
>  9 files changed, 41 insertions(+)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

