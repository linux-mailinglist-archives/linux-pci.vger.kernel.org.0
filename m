Return-Path: <linux-pci+bounces-8281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AC88FC474
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 09:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EFE1F22390
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B381922F3;
	Wed,  5 Jun 2024 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9z/xQJQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720A91922F1;
	Wed,  5 Jun 2024 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572178; cv=none; b=SuNnGAPHAFfJ+vBHgyJBlSpIGHUfpthYfq9a0dbSTfZBbDyFN924WS5V1FCniFNXcBazSFGZCOPH/xxrrRGqIyHwSLLhjY09H6z8Kf4w1d78mkyAT1/0rLnqDLkQkdI8A7cN0saHKiAc/F9oaXrJdfxKR9dNRPGjxYOIhoJsZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572178; c=relaxed/simple;
	bh=ePkMVJrWQ4WZRV2RJdInJDiWCIAVR1AVoROpcmVccWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAQwI1h7+6CtGy7hHnmYuFqIWkFRHgczMsxkg7pNURpUFzPl5oztEVgvMG+mmesUHvD/2iYAQlAEWJ10mvJ71+eLBZRPR5a6Z/yGOjzgoyzNx5+WbCwbuKSuKnidlPa3dBNR0FpPalbs7sL+w28YpeSFQO5Wwlw4tqjCDn8TWPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9z/xQJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC56EC3277B;
	Wed,  5 Jun 2024 07:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717572178;
	bh=ePkMVJrWQ4WZRV2RJdInJDiWCIAVR1AVoROpcmVccWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9z/xQJQ2wKJj0rHgvxbRCC2dXULarfzivWz5U5rxzhvi8nkHieIHP9QD3DldGFgQ
	 tamko3rwPCt+fEZmwUDSyXDTlWawYEOCcrOBAwyzF04x7xmZ8jXgL4ZkCOeu1le4Sc
	 YL/K4AAp2ON5tyaHOeoFQF9/+vWE1yc7iSMC5GoROjkU/avOJRLPsQnDoJLHm6XwUP
	 BqaPiVp+999QoDMXA24YETfwCm5uRTLTB11Ukx/Bdesyp/3QAIfH1mbnZLH/VUEa3/
	 kBoNaQX8yrOsAvJaF6oye1mxndC+NTjiCHbKMsgHDzcoVwcSsaIDmrVAjPgPKRF/sf
	 9KrVAasCc9+eA==
Date: Wed, 5 Jun 2024 12:52:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 01/13] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific reg-name
Message-ID: <20240605072245.GC5085@thinkpad>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-1-3dc00fe21a78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-1-3dc00fe21a78@kernel.org>

On Wed, May 29, 2024 at 10:28:55AM +0200, Niklas Cassel wrote:
> Considering that some drivers (e.g. pcie-dw-rockchip.c) already use the
> reg-name "apb" for the device tree binding in Root Complex mode
> (snps,dw-pcie.yaml), it doesn't make sense that those drivers should use a
> different reg-name when running in Endpoint mode (snps,dw-pcie-ep.yaml).
> 
> Therefore, since "apb" is already defined in snps,dw-pcie.yaml, add it
> also for snps,dw-pcie-ep.yaml.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> index bbdb01d22848..00dec01f1f73 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> @@ -100,7 +100,7 @@ properties:
>              for new bindings.
>            oneOf:
>              - description: See native 'elbi/app' CSR region for details.
> -              enum: [ link, appl ]
> +              enum: [ apb, link, appl ]
>              - description: See native 'atu' CSR region for details.
>                enum: [ atu_dma ]
>      allOf:
> 
> -- 
> 2.45.1
> 

-- 
மணிவண்ணன் சதாசிவம்

