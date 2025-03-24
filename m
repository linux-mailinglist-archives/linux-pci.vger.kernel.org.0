Return-Path: <linux-pci+bounces-24493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F68A6D572
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 08:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97177169BC4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B4B2512C3;
	Mon, 24 Mar 2025 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgJNRZsl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC6818DB34;
	Mon, 24 Mar 2025 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802626; cv=none; b=HO2x2QgRK0XlY11sxK2Wq+g7GYWnyBpQzpD7NXBJK2MAmI7+uJqhtcCaO7yoiGQM6Y2O6YdDmZ96ppWTFzhLhza44uosGI5rSWKyC0BJGmuPR9oz+Wogm8jhSTANy/zrBvGy49TEp5QHPPo0T26GXlPuN4C0fpo5K4GE6nhRPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802626; c=relaxed/simple;
	bh=mCJVEVFLift9Eye+00vD3JluUEBLGyRiq6JmsMqAy80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn3HvLfyxM5Bc0UfI/gYBgTDyD9zneZZ9j9ytC2s9h/LIGMuePNvok5IPNoCkgeeI/AqcKUgY9OM9plKhCC/pIAIg+rI7wvpIQC0sIlTHa2MDGfskPpvv608kidsdx+aITJ+koxPFAgMZ5278co9eXVQybiPePul/zUtu89NPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgJNRZsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DDCC4CEDD;
	Mon, 24 Mar 2025 07:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742802625;
	bh=mCJVEVFLift9Eye+00vD3JluUEBLGyRiq6JmsMqAy80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgJNRZslYyer7oKuYSsTjXGy1I4wrYapQgM6QroZKKtU744GwQt2AxYm2jlybjnTe
	 9LCAAaB7pbrysnlu63ECR6CCSo9G8Xc66PUniMWfpifID6HcJYm5RD60CSGqXld6b+
	 ozBBXRnuUcKzqFcATV5sMNGeiwuYuQhxidL+y50muiese0tAckpa/id3TEcw5oLoAI
	 RprEF96GKpzUKkNpjHnJcLlVzgSe6virir95NAmgRzx8IXZMLL7kx7EuwXW8ZIDE0b
	 VQfZMa4riUf9mhUDvQtOAQHYDpn5lOPVsMEwbXjyJlajOylPCQWENskA89z5S3Md1S
	 iP2xYpDuCF8WQ==
Date: Mon, 24 Mar 2025 08:50:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nitheesh Sekar <quic_nsekar@quicinc.com>, Varadarajan Narayanan <quic_varada@quicinc.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	20250317100029.881286-2-quic_varada@quicinc.com, Sricharan Ramabadhran <quic_srichara@quicinc.com>
Subject: Re: [PATCH v6 3/6] dt-bindings: PCI: qcom: Add IPQ5018 SoC
Message-ID: <20250324-knowing-vagabond-grebe-fa0a00@krzk-bin>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
 <20250321-ipq5018-pcie-v6-3-b7d659a76205@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321-ipq5018-pcie-v6-3-b7d659a76205@outlook.com>

On Fri, Mar 21, 2025 at 04:14:41PM +0400, George Moussalem wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add support for the PCIe controller on the Qualcomm
> IPQ5108 SoC to the bindings.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


