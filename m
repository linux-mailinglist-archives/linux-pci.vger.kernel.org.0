Return-Path: <linux-pci+bounces-32184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E433AB065D9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 20:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8063A75ED
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B34C2BDC03;
	Tue, 15 Jul 2025 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqKSF38q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1411DF98D;
	Tue, 15 Jul 2025 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603393; cv=none; b=WzmboHyEme49CQtNN2UL8m3TR+wFQPJAYswFtyCreFJIZuKNVcB/VopbghyDrL2c3n8vp3kS4Sr696iVQALCTFo0bTLrX6tNBSHljxHqsX+xWp9QhInvjt3LxCq0YpbtZH49o4ylqHCq692sWZ4lhE5m+aElUfP7/XYCpLFLhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603393; c=relaxed/simple;
	bh=aJGQyg78LrEPF1FzUGLMRvHSKN3yLtb4Tw/DC2FLpaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R0NS1Qet1y4hndy6dIt0Gdw60UXUY33su2YGjucP80U7g/vh5MA28lz/CJ+1KF0W9oHOn1ELqzzXCutvNXr5GXicL4YBma20r5ldjbUSP/EPbMQF6gkXp29+4OAqnrm6pt37tAxv0Gj8ut/vBP7IrLO7KO1w/YrNWLj7XbjwxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqKSF38q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A185DC4CEE3;
	Tue, 15 Jul 2025 18:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752603391;
	bh=aJGQyg78LrEPF1FzUGLMRvHSKN3yLtb4Tw/DC2FLpaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mqKSF38qTlq+kAYfIHmzyvW/cU1dNDP8c3V/VWuPpa6I7JinMKNnPzCC7abZ1kx/U
	 2eH/7u22VyuIFw62tj1rQ39ntaytbhwUwx+pf6fqvNY3tYamJFWixFHVGbKAwujqbN
	 KGDm19kH4xSQIB6lQSugEBFvT1cIyAazu/Y3bOEKCKvPiAv2tlATRP7tfMhhNqsKkp
	 41hnRd6uXURIdgPyBxBk2twUjT4ua+rpSqLMtZxDa8OMGharnobe3p/0kQqhLLppby
	 UXmDuVa2+1crfFTqFS9SAUaf8kvR/4w3ti0RYT6V2g/bWXEOSg/KrIDUko9aq1SVyc
	 F6TuTeFdZ0dtw==
Date: Tue, 15 Jul 2025 13:16:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mayank Rana <mayank.rana@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, will@kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	andersson@kernel.org, mani@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_ramkri@quicinc.com, quic_shazhuss@quicinc.com,
	quic_msarkar@quicinc.com, quic_nitegupt@quicinc.com
Subject: Re: [PATCH v5 3/4] dt-bindings: PCI: qcom,pcie-sa8255p: Document
 ECAM compliant PCIe root complex
Message-ID: <20250715181630.GA2469794@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616224259.3549811-4-mayank.rana@oss.qualcomm.com>

On Mon, Jun 16, 2025 at 03:42:58PM -0700, Mayank Rana wrote:
> Document the required configuration to enable the PCIe root complex on
> SA8255p, which is managed by firmware using power-domain based handling
> and configured as ECAM compliant.
> 
> Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/pci/qcom,pcie-sa8255p.yaml       | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
> new file mode 100644
> index 000000000000..88c8f012708c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,pcie-sa8255p.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SA8255p based firmware managed and ECAM compliant PCIe Root Complex
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +description:
> +  Qualcomm SA8255p SoC PCIe root complex controller is based on the Synopsys
> +  DesignWare PCIe IP which is managed by firmware, and configured in ECAM mode.
> +
> +properties:
> +  compatible:
> +    const: qcom,pcie-sa8255p
> +
> +  reg:
> +    description:
> +      The Configuration Space base address and size, as accessed from the parent
> +      bus. The base address corresponds to the first bus in the "bus-range"
> +      property. If no "bus-range" is specified, this will be bus 0 (the
> +      default).

Do you mind if I add "ECAM" to this description, e.g.,

  The base address and size of the ECAM area for accessing PCI
  Configuration Space, as accessed from the parent bus.

I think having the "ECAM" keyword would make this easier to grep for.

Bjorn

