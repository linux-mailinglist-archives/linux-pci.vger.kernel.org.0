Return-Path: <linux-pci+bounces-10013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2292C181
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 19:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D586286C76
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF01D1AC450;
	Tue,  9 Jul 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NycS/DkI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D931AC42B;
	Tue,  9 Jul 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542554; cv=none; b=eo52i0YqPS66dh90BXCqpom6+dw3kvpkJkc+oeRoBQz6PAZOIsTzqZ80nunqBIDugQ0zgKcit1bjo2FhHCfoAjQNSwhkfmnwytjr0aKaSZ5mpxNvLXgMpacQlKchDG4kZfYUCwZIHarYngMz+lq51dYZnXDxIrttcp2Dloe4Q40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542554; c=relaxed/simple;
	bh=RhV3fJwYtKN6ViNUPQofsewkE0uvNr9XIDbS7PLjJpE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J5qzoWofJcWN6ab+9yuT/+AsJU9ESBL6c/X0l/BUz/EVH9pyv8/uWP2S7shyfmFU/Rpgjq+A7aw2H7Zjze75MwmeNS2aYiuMWgxJlHopKqs1+KwomxCIX/0x3JO8yClU9U8EJU6IIt5kebs+Nb1YjsUBsqcTsQAnkhYLc+tgVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NycS/DkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EBEC32782;
	Tue,  9 Jul 2024 16:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542554;
	bh=RhV3fJwYtKN6ViNUPQofsewkE0uvNr9XIDbS7PLjJpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NycS/DkI7P9OF8H7e3aIHR6J18UeZ3d2k6bf2FQxhS/x45SkstJat09iSyVjn7+Ez
	 RP+Ll0mLC3OIvrHnagNJwjfpHVPX5Qmzttc4icEnTFA20a4L2U+vRdk9a1jYGIRdLt
	 jeUhwZnTy+I1jSwBAuFH1pnu699lKjEDQJi/DqrIRtd1HtQn+d30kLkrZVFT0kKQQy
	 Q2V38FOoy1WTcmc05qi3X+8TFtbhZ62hEogDtoV3kloxhTQpS843Czd+BbwmFU6rlv
	 +rmEYVY0JvOrChWyMzHWXRXIWxh7ScxSxMbG2MQMMIyEStlSWkjpM+ZEUf9rTSd32B
	 EeCHYTCpIYJng==
Date: Tue, 9 Jul 2024 11:29:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: Document compatible for QCS9100
Message-ID: <20240709162912.GA176161@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709-add_qcs9100_pcie_compatible-v2-1-04f1e85c8a48@quicinc.com>

On Tue, Jul 09, 2024 at 10:59:29PM +0800, Tengfei Fan wrote:
> Document compatible for QCS9100 platform.

Add blank line for paragraph breaks.

> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
> platform use non-SCMI resource. In the future, the SA8775p platform will
> move to use SCMI resources and it will have new sa8775p-related device
> tree. Consequently, introduce "qcom,pcie-qcs9100" to describe non-SCMI
> based PCIe.

Not connected to the patch below.  Move to where it is relevant.

> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> index efde49d1bef8..4de33df6963f 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> @@ -16,7 +16,10 @@ description:
>  
>  properties:
>    compatible:
> -    const: qcom,pcie-sa8775p
> +    items:
> +      - enum:
> +          - qcom,pcie-qcs9100
> +          - qcom,pcie-sa8775p
>  
>    reg:
>      minItems: 6
> 
> -- 
> 2.25.1
> 

