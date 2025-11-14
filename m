Return-Path: <linux-pci+bounces-41262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 35269C5ECAB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 19:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7635384F1F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 17:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1423F346794;
	Fri, 14 Nov 2025 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu0OuBEW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76682D29D1;
	Fri, 14 Nov 2025 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143061; cv=none; b=tYJ50XDW4EP5vZD0pRaCbyp56rg+efjZTjvYsDTbTA5URSXZ/DW7wfxDiCjJ4tfCTxDi7SUHZLBbdPmaG2maDGND/evjFOA3WneP+6kWat0E0JOctrVc6Smbus/zC6Dn2Qe8AJazc1a6My7iYjiRT7+DNmpC77flx4dnOSBrcPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143061; c=relaxed/simple;
	bh=vfL1Pl5c9TiW8/PwiGRW6nnpwuYEWu4MfO4FlaLmKHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHbsZvGrYsPC6W0ZbEfS7Q7/BGCwStjtjZ0+D+KJcsuMSTlwc6Jt6G+Y2utVgaOpPL39qXd3OCHl0nOyZBH4pRisgbd7cdsnVD/YMGvfRFTHiJb2QIXCgB9TDa35UPsUeJ4oUhXggIQmcn7Bzh1OsarZXSHMFmO6Tx2ypK40XBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu0OuBEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E157C4CEF1;
	Fri, 14 Nov 2025 17:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763143061;
	bh=vfL1Pl5c9TiW8/PwiGRW6nnpwuYEWu4MfO4FlaLmKHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xu0OuBEWCNcolV9hhQObYp9kEcBWREwXELrFxs6Dn5F2/wauksne/QZLElvFfOcOJ
	 /KpeikNwouH60qUgW8TB4qMGaiId5DNDddBrp1NPKER/Dfmxl3bm7pim1IbSxFIB2B
	 i97Qi4e1nvvr3hSFz4YqtfVti2Bg6kIpvqJP1NGVPw/dclDCR9ewE/mzoB1zy2Vbum
	 RYMqOvufhORb6Do3p3d06qiM6vI+QHCea+0jbUF+qLau8jljoW0TM6+c/8Vu8TL0fV
	 3YBHnaIIvL02TNvlqkVAlYJPhSCjExbFzP098OfwyMFXS7j5w9nWiA4L0hDFzUSdv4
	 Qh3MysW9mB8UQ==
Date: Fri, 14 Nov 2025 11:57:39 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] dt-bindings: PCI: qcom: Move remaining devices to
 dedicated schema
Message-ID: <20251114175739.GA3805640-robh@kernel.org>
References: <20251103-dt-bindings-pci-qcom-v1-0-c0f6041abf9b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-dt-bindings-pci-qcom-v1-0-c0f6041abf9b@linaro.org>

On Mon, Nov 03, 2025 at 04:14:40PM +0100, Krzysztof Kozlowski wrote:
> Some time ago I already moved several devices from qcom,pcie.yaml
> binding to a dedicated binding files for easier reviewing and
> maintenance.
> 
> Move the remaining one which makes the qcom,pcie.yaml empty thus can be
> entirely removed.
> 
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

