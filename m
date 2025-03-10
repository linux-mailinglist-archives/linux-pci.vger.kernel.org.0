Return-Path: <linux-pci+bounces-23314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AFFA5952A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 13:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C451016D121
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33D0227B9E;
	Mon, 10 Mar 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1xpHGyH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86649225793;
	Mon, 10 Mar 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611186; cv=none; b=eObQxHKR6G37s0MAHbRE989srP+Odlq0lN/Q/DGjPEZhh8+aZMKyvR2qq18EwKASSFuTajFF35PSy9TA2io2AnKDhQ4q9Jv9gH8XGDyDvm1r1V1BW8sjIakDiEvdwwe2HyZ0V6fKLDVQyiYEQIdELXSbZ+o9VEwPqHy9zi7YS1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611186; c=relaxed/simple;
	bh=FBSUXcNcPFCcpOtQRczLMZaFejBzflBE1nRe+ghMkFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ6uIfNxSDK1CfCCR1p/pigdqxvb7eLNo9XNWzpmO+GLXzLttGr8pz/yuCCZMxa2cz/2b99UCgpBehlzIK9MSXr/CHIEsRA64GJ2I3QdTbD2e+hq+CFd0kBT066YcE4oYQ6LtLpB6DZSi4AEhRs+ZRfI2LzbS4/YsRXocetEtGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1xpHGyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80ECC4CEEA;
	Mon, 10 Mar 2025 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741611185;
	bh=FBSUXcNcPFCcpOtQRczLMZaFejBzflBE1nRe+ghMkFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1xpHGyHOLjcu3JPH1ihcI3UMcXLr4hpsnsK3J5oRjJ2ClI7K3A74ruv96mdYFWwp
	 59vRNoZ3e9625wkVVcnAvfxkDxKM52vXZ7go6hTapsTy+PZbdgoaK7Mahvy2aQJDEW
	 H/6NNIkho9IHoWWltEYreiwrbg1UojGelPTVNpVION/T2bE4fQH2mKr1y3s5dGKjmu
	 6Gju3EeqK9YPRyrbR0qxCvMh+le63kH9krb0wUzYMxYa8rOwL92WAvM/XXo1WiJYBz
	 mEJDd3R0YScWccXdnBZwF8umE/wFT03j/6tubc9wTu1id5LwCAapUnXt0/SY8uE9uW
	 yTY+jLRHIIB7g==
Date: Mon, 10 Mar 2025 07:53:04 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: fsl,layerscape-pcie-ep: Drop
 deprecated windows
Message-ID: <20250310125304.GA3881079-robh@kernel.org>
References: <20250307081327.35153-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307081327.35153-1-krzysztof.kozlowski@linaro.org>

On Fri, Mar 07, 2025 at 09:13:26AM +0100, Krzysztof Kozlowski wrote:
> The example DTS uses 'num-ib-windows' and 'num-ob-windows' properties
> but these are not defined in the binding.  Binding also does not
> reference snps,dw-pcie-common.yaml, probably because it is quite
> different even though the device is based on Synopsys controller.
> 
> The properties are actually deprecated, so simply drop them from the
> example.

How are we not getting warnings for them? That would be the bigger 
issue. "status" shouldn't matter.

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml         | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> index 399efa7364c9..1fdc899e7292 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> @@ -94,8 +94,6 @@ examples:
>          reg-names = "regs", "addr_space";
>          interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
>          interrupt-names = "pme";
> -        num-ib-windows = <6>;
> -        num-ob-windows = <8>;
>          status = "disabled";
>        };
>      };
> -- 
> 2.43.0
> 

