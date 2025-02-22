Return-Path: <linux-pci+bounces-22080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D09A40771
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 11:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCEE3BA209
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 10:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E1206F01;
	Sat, 22 Feb 2025 10:32:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4721FF1D5;
	Sat, 22 Feb 2025 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740220374; cv=none; b=qpa/itl08ahp2DCny7zWrQ50P88/ZpbrslAJTHJNvbcBDuv1gF2DThqlXV96fC+WHs6WbhFim8Yp/bUMaJTwb2iVYEfNX0jtvE1M8M8cMyuFeRFxMsatOUH9FvkyLlTF0fxHN2cy2eLRVZyUwunL097a8rzxudRQqlgTNiaORYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740220374; c=relaxed/simple;
	bh=7+z25uzKSnhfSpSiKS/ZJPg+H4l8p2XmukHgGS3a6FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRjS2cEp72TLqE+iTFRjW3h/989kI64U9Q7eT93oRwrETzySzo1DOF4C84eW7KOMpGG4IaGk0jdYhic4+M657v/lyzwqDwDOUYZq9arNY01g9FsOqFPLdHQcQdp33bKgcg3MPQPrOeE01TLWhNckLvp1YwhAGfw5cxBEOx81bSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1648AC4CED1;
	Sat, 22 Feb 2025 10:32:51 +0000 (UTC)
Date: Sat, 22 Feb 2025 11:32:49 +0100
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
Subject: Re: [PATCH v3 3/8] dt-bindings: PCI: qcom-ep: enable DMA for SM8450
Message-ID: <20250222-radiant-optimal-ape-8c14f9@krzk-bin>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250221-sar2130p-pci-v3-3-61a0fdfb75b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221-sar2130p-pci-v3-3-61a0fdfb75b4@linaro.org>

On Fri, Feb 21, 2025 at 05:52:01PM +0200, Dmitry Baryshkov wrote:
> Qualcomm SM8450 platform can (and should) be using DMA for the PCIe EP
> transfers. Extend the MMIO regions and interrupts in order to acommodate
> for the DMA resources, mark iommus property as required for the
> platform.
> 
> Upstream DT doesn't provide support for the EP mode of the PCIe
> controller, so while this is an ABI break, it doesn't break any of the
> supported platforms.
> 
> Fixes: 63e445b746aa ("dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC")
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


