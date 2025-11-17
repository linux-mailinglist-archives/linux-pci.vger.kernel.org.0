Return-Path: <linux-pci+bounces-41405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B13C64535
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E93A74E9D72
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63143329374;
	Mon, 17 Nov 2025 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ud1sBkeI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4D3191D5;
	Mon, 17 Nov 2025 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763385075; cv=none; b=HdXq4ZkXryDTlDFgCK+H83x/o61quPkDHF2lBfBLedS3hjOKoBwUg/YrhKsxaaLPh154MQZ5xZaQwB77jKK70hlpTb7lDH4fhpH9AzBnPqrImf3BpHWDbY89njJiAEZcfiSkA7kOeTnkbecCVTPmwna183ft8J5dFZLbueVR8l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763385075; c=relaxed/simple;
	bh=afbf98xxoxrYAsyDxUue+ddYrMOu3g9haZyYcYEoHn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9/PA4lJoNeEq543/E80YvDNzLgYC8cG5/tJm2QwTDdEg5FXen85UQkbrDJGU0Al49vqoyo8kSShDffIJ8NdyoXUZowYXPTfqYwGbmxgMFKHSX/+B88liAahWl3aavF/jCbQ6Mr75hTyM8+5YZ5qv7HIfWAm0eBitAzQbWWvexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ud1sBkeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90821C113D0;
	Mon, 17 Nov 2025 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763385074;
	bh=afbf98xxoxrYAsyDxUue+ddYrMOu3g9haZyYcYEoHn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ud1sBkeIuofEHXfy7QpXQpwCm3U2lBLsfVtKYN5NPTawTUpV/qqaPwQQLl6J6GLQ4
	 LZufGMbBMHHJQQCt5hfwX7a4oIeshPPpfoIxVmlC4lV1adSmAwhvtCjKZZ8TYAhiYP
	 /APEE2vDBKtXw0wpGZhAPwxMy2/heZTKf4jaIooroOJCSO9H2wDdUglTmB0CMdPnLS
	 +vECSsWDtSJwbrT460S7Fr1jjYn70JuZqUM6v/ExuFRMzx75a4btGEP52wA+uTX1MG
	 i32duE2cmr0/p6V0JVJ3lmIlcuvow0k/DZ2w48cYU171QW6C+uxYBE8Qv/Z6DRNzaS
	 CpHfdI6gKTBjw==
Date: Mon, 17 Nov 2025 18:41:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] dt-bindings: PCI: qcom: Move remaining devices to
 dedicated schema
Message-ID: <pipaqad6gzb4qq6kpg75xw3q35jdelbdvhgkwnc4e4r2y6bvry@uaqzrzkeqvru>
References: <20251103-dt-bindings-pci-qcom-v1-0-c0f6041abf9b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251103-dt-bindings-pci-qcom-v1-0-c0f6041abf9b@linaro.org>

On Mon, Nov 03, 2025 at 04:14:40PM +0100, Krzysztof Kozlowski wrote:
> Some time ago I already moved several devices from qcom,pcie.yaml
> binding to a dedicated binding files for easier reviewing and
> maintenance.
> 
> Move the remaining one which makes the qcom,pcie.yaml empty thus can be
> entirely removed.
> 

Series failed to apply to pci/dt-binding [1] branch (probably due to your other
series [2]). Please rebase and resend.

- Mani

[1] https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=dt-binding
[2] https://lore.kernel.org/linux-pci/20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-0-28c1f11599fe@linaro.org

> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (12):
>       dt-bindings: PCI: qcom,pcie-sm8150: Merge SC8180x into SM8150
>       dt-bindings: PCI: qcom,pcie-sdx55: Move SDX55 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-sdm845: Move SDM845 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-qcs404: Move QCS404 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-ipq5018: Move IPQ5018 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-ipq6018: Move IPQ6018 and IPQ8074 Gen3 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-ipq8074: Move IPQ8074 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-ipq4019: Move IPQ4019 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-ipq9574: Move IPQ9574 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-apq8064: Move APQ8064 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-msm8996: Move MSM8996 to dedicated schema
>       dt-bindings: PCI: qcom,pcie-apq8084: Move APQ8084 to dedicated schema
> 
>  .../devicetree/bindings/pci/qcom,pcie-apq8064.yaml | 170 +++++
>  .../devicetree/bindings/pci/qcom,pcie-apq8084.yaml | 109 +++
>  .../devicetree/bindings/pci/qcom,pcie-ipq4019.yaml | 146 ++++
>  .../devicetree/bindings/pci/qcom,pcie-ipq5018.yaml | 189 +++++
>  .../devicetree/bindings/pci/qcom,pcie-ipq6018.yaml | 179 +++++
>  .../devicetree/bindings/pci/qcom,pcie-ipq8074.yaml | 165 +++++
>  .../devicetree/bindings/pci/qcom,pcie-ipq9574.yaml | 183 +++++
>  .../devicetree/bindings/pci/qcom,pcie-msm8996.yaml | 156 ++++
>  .../devicetree/bindings/pci/qcom,pcie-qcs404.yaml  | 131 ++++
>  .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml | 168 -----
>  .../devicetree/bindings/pci/qcom,pcie-sdm845.yaml  | 190 +++++
>  .../devicetree/bindings/pci/qcom,pcie-sdx55.yaml   | 172 +++++
>  .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  |   1 +
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 782 ---------------------
>  14 files changed, 1791 insertions(+), 950 deletions(-)
> ---
> base-commit: 503fcb70f99075032f5bbf528cec4650cb7dd7d0
> change-id: 20251029-dt-bindings-pci-qcom-cc448e48ab58
> 
> Best regards,
> -- 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்

