Return-Path: <linux-pci+bounces-8273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7D38FC040
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 01:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C46AB226A2
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 23:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B78614E2D2;
	Tue,  4 Jun 2024 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDAkVbRt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4B14B94E;
	Tue,  4 Jun 2024 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717545489; cv=none; b=A83Gikhga9orGGxL9g6ewIiKRs1S02iSdc9kGlUH7srTixQ+Fyo4QUaZQAy9UCqArqNUjEgjGuqp6/OJySDyBnRGRN6pixIGykTVjQeP8k+qAm1HkNieTO6qnmzHvU1sVo2P4gt+UYJhDAfMjWYG701DEy+BpW5bD3/toqseDBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717545489; c=relaxed/simple;
	bh=z/x7lnVHh6tGjQq6E7OKzagc09tZ4NbFq5Ho8k3qWiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6qmcz8inue31pCdRKY8RaopQJi71M1s6wAJfQ91Tc7k5l4UdVDvrQ4dOvADLLXMSfKbXWyp6nJdJuhO7klOcOt4Y21dSP9X+IWGxe9qAOgkD3nnIkwemA2Xfc6O+x28AA9CdM3iYzekXXz0boGPFYKaZ0hn5sz8mCH2lvazZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDAkVbRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372FFC2BBFC;
	Tue,  4 Jun 2024 23:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717545488;
	bh=z/x7lnVHh6tGjQq6E7OKzagc09tZ4NbFq5Ho8k3qWiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDAkVbRtBndrf0AUTpV5MC0DtJMsL7G0G3A7j7SJMOS8/m2xo6ixOtMt1Duj9c0iv
	 KBGi1PUX1lSSA7W3DTunVgu7Fixuum8fyqYWMfSEB2H5AM9OfBq8kbdJczQvGs4CYg
	 3tdfSQF6aIQEufKjukhOoU0bKa5j/AOnZcUKlbH5UO1wt2k2aOlWQHrY1T6qR0e3jI
	 XeGfovm2YXsYzPCrrSnZNC6FR1XtbIrHYe1uisepl64YPkL0ohcWzLvd7dfIFTDoU2
	 eROjrOCP6QdVhSqO3Uxk8md4Fz1hvsPc8kEO53ebGMKdMGfP6TCEHjPPBueHI+f5o1
	 oW/RguEWs0u9Q==
Date: Tue, 4 Jun 2024 17:58:06 -0600
From: Rob Herring <robh@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Fix register maps items and add
 3.3V supply
Message-ID: <20240604235806.GA1903493-robh@kernel.org>
References: <20240604-x1e80100-pci-bindings-fix-v1-1-f4e20251b3d0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604-x1e80100-pci-bindings-fix-v1-1-f4e20251b3d0@linaro.org>

On Tue, Jun 04, 2024 at 07:05:12PM +0300, Abel Vesa wrote:
> All PCIe controllers found on X1E80100 have MHI register region and
> VDDPE supplies. Add them to the schema as well.
> 
> Fixes: 692eadd51698 ("dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> This patchset fixes the following warning:
> https://lore.kernel.org/all/171751454535.785265.18156799252281879515.robh@kernel.org/
> 
> Also fixes a MHI reg region warning that will be triggered by the following patch:
> https://lore.kernel.org/all/20240604-x1e80100-dts-fixes-pcie6a-v2-1-0b4d8c6256e5@linaro.org/
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> index 1074310a8e7a..7ceba32c4cf9 100644
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
> @@ -71,6 +70,9 @@ properties:
>        - const: pci # PCIe core reset
>        - const: link_down # PCIe link down reset
>  
> +  vddpe-3v3-supply:
> +    description: A phandle to the PCIe endpoint power supply

TBC, this is a rail on the host side provided to a card? If so, we have 
standard properties for standard PCI voltage rails. It is also preferred 
that you put them in a root port node rather than the host bridge.

Rob

