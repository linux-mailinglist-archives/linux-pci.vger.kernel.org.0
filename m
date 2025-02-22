Return-Path: <linux-pci+bounces-22078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3879EA4075F
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 11:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B885E3B4CA0
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 10:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6330206F34;
	Sat, 22 Feb 2025 10:31:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA41FCF53;
	Sat, 22 Feb 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740220295; cv=none; b=ug/c3Wbsrn6Sh24hYQBCSY2l2v4fA9IeoXv42mEPrH/wHKwvnjmgIm2/YG5VFM/Jz3wTsSFUkfkjPtTOfC25ikQ1XW2HJn9RhB6AvQHWOKA5w2YP2HS9iMtMgopKhWCPHAVmNn79VfVPN/PH8mFq04l1ADyvGSneZUHaFgSgDTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740220295; c=relaxed/simple;
	bh=ORDyt1jb5yDi5v+AM5GRVZ+4ZTDKVdYPatrUDYzKHLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P799GGaQKYhUvZ4+6IVWWWWgDyayCKRnmtYtQTMtCrUvlMHPgGu53r7b6wLJa+O/zaLHj0MZM21hLXvRCrjGauNxEaVugaSKRLS45mML5meXnrCszmFjfZph+XuvZX/P07tLFD+/0JHFgUN3PGUqEz8k5cTjBAGOj+2Pnp1+mF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7504BC4CED1;
	Sat, 22 Feb 2025 10:31:34 +0000 (UTC)
Date: Sat, 22 Feb 2025 11:31:31 +0100
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
Subject: Re: [PATCH v3 1/8] dt-bindings: PCI: qcom-ep: describe optional
 dma-coherent property
Message-ID: <20250222-hasty-chachalaca-of-greatness-a9cc1c@krzk-bin>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250221-sar2130p-pci-v3-1-61a0fdfb75b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221-sar2130p-pci-v3-1-61a0fdfb75b4@linaro.org>

On Fri, Feb 21, 2025 at 05:51:59PM +0200, Dmitry Baryshkov wrote:
> Qualcomm SA8775P supports cache coherency on the PCIe EP controller.
> Allow 'dma-coherent' property to be used for this device. This fixes
> a part of the following error (the second part is fixed in the next
> commit):
> 
> pcie-ep@1c10000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)
> 
> Fixes: 4b220c6fa9f3 ("arm64: dts: qcom: sa8775p: Mark PCIe EP controller as cache coherent")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


