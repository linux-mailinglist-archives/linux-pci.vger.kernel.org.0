Return-Path: <linux-pci+bounces-22079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89042A40769
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 11:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E81D7A7AB9
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 10:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3709207E02;
	Sat, 22 Feb 2025 10:32:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB661FCF53;
	Sat, 22 Feb 2025 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740220354; cv=none; b=Hmoqp7PGR1N65KFxauFf2zXqycF6LC0EtGyn6OlP+pQv6q4cyPpzvfQeO1gwKyerS7IUIr3Ia8jB/PVcnT1BGNNv/PvcvxGm130vtKhW077FqwGEOw7RhEiCU/Pk0M/PSIsuBLMlpGWg7qGMPjM3zubTUOP907B2v+jYvn1irKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740220354; c=relaxed/simple;
	bh=kHZVzKCLyaD9y1oJzBeEGb8gkHxy7ro381Fky/hmlEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3k0ik3no5zgf6HCLgq99lFgsIWcbgt/PoeswWhaMpZi9gxMLwEf+Tz/PoBLDFWAPIWGDpH4MWG0ATYEvpQG/G83btP08t30B6r6Xg3LZDcgQfKXbOwnLUNQpfz0Jt16sAg7nGcdJfD/WaaI/Yr9WjvO1kbPJkFQSAX/1y4azxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4F0C4CED1;
	Sat, 22 Feb 2025 10:32:33 +0000 (UTC)
Date: Sat, 22 Feb 2025 11:32:30 +0100
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mrinmay Sarkar <quic_msarkar@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: PCI: qcom-ep: describe optional IOMMU
Message-ID: <20250222-silent-snake-of-courage-f4ebdc@krzk-bin>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250221-sar2130p-pci-v3-2-61a0fdfb75b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221-sar2130p-pci-v3-2-61a0fdfb75b4@linaro.org>

On Fri, Feb 21, 2025 at 05:52:00PM +0200, Dmitry Baryshkov wrote:
> Some of Qualcomm platforms have an IOMMU unit between the PCIe IP and
> DDR. For example, SA8775P specifies the iommu alththough it is not a
> part of bindings. Change the schema in order to require the IOMMU for
> SA8775P and forbid it from being used on SDX55 (SM8450 will be handled
> in a later patch).
> 
> This fixes the following warning:
> 
> pcie-ep@1c10000: Unevaluated properties are not allowed ('iommus' was unexpected)
> 
> Fixes: 9d3d5e75f31c ("dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


