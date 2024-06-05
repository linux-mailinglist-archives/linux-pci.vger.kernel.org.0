Return-Path: <linux-pci+bounces-8310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F6F8FC65C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 10:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5A41C22F7A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 08:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4FE18FDAA;
	Wed,  5 Jun 2024 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAyhy5fr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81A1946B9;
	Wed,  5 Jun 2024 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575933; cv=none; b=RH6RnkaEwurttuRM9MNBC7WGOasYRwlzehfQePoe6Kew4GvQxLL7uaLRtJOVBt4Nq2U9n+Zho6xRDn7YtpU8v0yfylaT3GWQesnvGVYBMUAQRw8akCtOp8uziNxLghav6ivgXOLJbBNapdYieWkXAh+vagleONOuUcNOHBkAZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575933; c=relaxed/simple;
	bh=MX+K9UMpqRLlI7KOc7RmhhnZeub6WWplH/Rz/Vol7Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYHp2SAzjcZNPQwGKwtLwBeDMFxnQnbKxD7fELR54E3/Z54BAF0H4heCq1khtrDON83XkiczQ2qyltM2aoW2p4t+lY+zVmMSQxOSOUqixRpfeJpAAqCwGt/Y3JYWBOzXiDAL7SEWVTw0aXa++Bvbo68Sl6EPD2VMknEtM65PaDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAyhy5fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6459C3277B;
	Wed,  5 Jun 2024 08:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717575931;
	bh=MX+K9UMpqRLlI7KOc7RmhhnZeub6WWplH/Rz/Vol7Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gAyhy5frrot4bwg/5NNiRISp3pgPYbRSS/go9NfjALdLDxrs7zB7ohJkAQ3WSDw8X
	 /+J3FQeuKk7q2E6k6atXJwA6b1fZyidAbFNUba/s2AyCH/m1ASengjIwPDPFztDrvt
	 xl/RhhVFEjO/Kipl5QxIYQuVjUbZwO63neqSxGP/RDf7VfLJTQfMAFTjg5hKjxwuCl
	 YMMEAHOebwU6p/lfkzThgBgGWvHl8/AfVaSRorONfXmI/7o0UK1rd9+8+mazU1Thj9
	 oNkmNWfnG1Q4vvdX6FJN8AgzvN0v7m0bWTutAw+ZCIp7pyyF9GBFcKWZQFKvvXPbRS
	 qyAXVjsTxLF3Q==
Date: Wed, 5 Jun 2024 13:55:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: qcom: x1e80100: Make the MHI reg
 region mandatory
Message-ID: <20240605082520.GM5085@thinkpad>
References: <20240605-x1e80100-pci-bindings-fix-v2-1-c465e87966fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605-x1e80100-pci-bindings-fix-v2-1-c465e87966fc@linaro.org>

On Wed, Jun 05, 2024 at 11:19:01AM +0300, Abel Vesa wrote:
> All PCIe controllers found on X1E80100 have MHI register region.
> So change the schema to reflect that.
> 
> Fixes: 692eadd51698 ("dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Note that this patch will trigger an MHI reg region
> warning until the following patch will also be merged:
> 
> https://lore.kernel.org/all/20240604-x1e80100-dts-fixes-pcie6a-v2-1-0b4d8c6256e5@linaro.org/
> ---
> Changes in v2:
> - Dropped the vddpe supply change as that will have to be reworked
>   in a different way, maybe on multiple platforms.
> - Added SoC name to the subject line
> - Link to v1: https://lore.kernel.org/r/20240604-x1e80100-pci-bindings-fix-v1-1-f4e20251b3d0@linaro.org
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> index 1074310a8e7a..a9db0a231563 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> @@ -19,11 +19,10 @@ properties:
>      const: qcom,pcie-x1e80100
>  
>    reg:
> -    minItems: 5
> +    minItems: 6
>      maxItems: 6
>  
>    reg-names:
> -    minItems: 5
>      items:
>        - const: parf # Qualcomm specific registers
>        - const: dbi # DesignWare PCIe registers
> 
> ---
> base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
> change-id: 20240604-x1e80100-pci-bindings-fix-196925d15260
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்

