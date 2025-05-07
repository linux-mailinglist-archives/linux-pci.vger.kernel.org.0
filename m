Return-Path: <linux-pci+bounces-27323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BADFAAD4FF
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 07:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB747B3326
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 05:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ED41D63FC;
	Wed,  7 May 2025 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seliaUvN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723843398A;
	Wed,  7 May 2025 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746595031; cv=none; b=ZfJVPuQ70hFp1KhutpeuHpYFNieX22OdczHBZ3U8/UATRao5/ZfhU/VNOzcMFii+1EvSxGaLOfLb2CFtC/+f8muKXeaLNtnHZrbTZRy7iUrB5bwnW6ZEkiQt24gp5VBffAdYkrUk2OKlYtxjanfoSyvBOmPAlrDSbnsKZSbdVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746595031; c=relaxed/simple;
	bh=JG4V4RAp0WdhDOtz+o//0q+asbkWJORcl/Rb+VWLtiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpojVPSHlkElxb0+LQw9U+SjcRab/rVz2aiHVTP5Yd5NRPn1TJ1kV5inOK/3jNJ094Bka1RlaBCCbYfVK286h39Z6a4DT5HBkl6vlIm8US0DR4tRqrKrKCTPaDJRWWxn/GjfBnOGqTb7qstvTmS/p4KrWEzW/m1KS53gOK8ISC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seliaUvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF4DC4CEE7;
	Wed,  7 May 2025 05:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746595030;
	bh=JG4V4RAp0WdhDOtz+o//0q+asbkWJORcl/Rb+VWLtiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=seliaUvN9Z007kdddm7xTLEOgyINOOv5PHzeJ1A04mDMv9KcSGhL9W1j4CJfaVyuk
	 yIgCpXyI+jdJMIS7xS/h27FTPrwnUNtLEMxQQ7VLP7M/roZaBmzHE/MAlQKtlzAQta
	 FVuOPA11Ryf8FI2QigV31gIN9DSd4gzMD3erXFmyylYdnu76n0Ol6WwqL62FQIBqhm
	 FEh9wyGD2SEqmXPZqx2dXeBKGmlraqMWjx4aPVPeL8sThmOGR+R4xbt0M4PkCUFtCi
	 VieIIfBB6A4Yjq65pj1qXPumjar8aE84zLC8EWJ6vkBvEATFpaZisHq5AfGKuUmtE8
	 ZhD2davJROOzg==
Date: Wed, 7 May 2025 07:17:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@linaro.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, manivannan.sadhasivam@linaro.org, 
	lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, andersson@kernel.org, 
	konradybcio@kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	quic_qianyu@quicinc.com, quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v4 2/5] dt-bindings: PCI: qcom: Document the QCS615 PCIe
 Controller
Message-ID: <20250507-astute-realistic-ferret-bcdfce@kuoka>
References: <20250507031559.4085159-1-quic_ziyuzhan@quicinc.com>
 <20250507031559.4085159-3-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250507031559.4085159-3-quic_ziyuzhan@quicinc.com>

On Wed, May 07, 2025 at 11:15:56AM GMT, Ziyue Zhang wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Add dedicated schema for the PCIe controllers found on QCS615.
> Due to qcs615's clock-names do not match any of the existing
> dt-bindings, a new compatible for qcs615 is needed.

Other bindings for QCS615 were not finished, so I have doubts this is
done as well. Send your bindings once you finish them.

...

> +properties:
> +  compatible:
> +    const: qcom,qcs615-pcie
> +
> +  reg:
> +    minItems: 6
> +    maxItems: 6
> +
> +  reg-names:
> +    items:
> +      - const: parf # Qualcomm specific registers
> +      - const: dbi # DesignWare PCIe registers
> +      - const: elbi # External local bus interface registers
> +      - const: atu # ATU address space
> +      - const: config # PCIe configuration space
> +      - const: mhi # MHI registers
> +
> +  clocks:
> +    minItems: 5

Drop or use correct value - 6. I don't understand why this changed and
nothing in changelog explains this.

Best regards,
Krzysztof


