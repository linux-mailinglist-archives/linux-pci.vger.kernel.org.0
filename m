Return-Path: <linux-pci+bounces-8334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6558FD054
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 16:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140C41F24C24
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6CED2E6;
	Wed,  5 Jun 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKZCc/ii"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C53EDE;
	Wed,  5 Jun 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596110; cv=none; b=coWqj92kuFLWlf5jEglE4Y7zZ5EPfeLsoh87MeJdfCKN+2h0rAfdYYrYH0M7cmdEa3awAWI2CPIwzK7qLOOgi2U/hWqIy9mc7LnKwPrL/ifg+fqdZbyfANlrVHe7Hs8MMSKa1zF2edWJjbQiT5H4kZdevopFzFuKTWxN9NZURDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596110; c=relaxed/simple;
	bh=jriMY1eGjZZJGc7/fbBZnLvt2Ng1NGbn0bR4NnYeCJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqg7d3rTJYvccs2+PhuWrwhqiQEXva7CBJyK1/yB7+RjnDW5PuPgok9HNAlfcjF0AVl5BiuZfR4hnLFGB2wx2494txhiydUo+sMtZ/H9HsZd8OIU6xjXCAMB+7pn8CPAa9/qADfHTH4RHE0G6Ri/WVfKSzImWGweXTzCRp9Sx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKZCc/ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC3DC3277B;
	Wed,  5 Jun 2024 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717596109;
	bh=jriMY1eGjZZJGc7/fbBZnLvt2Ng1NGbn0bR4NnYeCJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKZCc/iiM6SihAawkOdZ7jQ0z8niwdvkaRmntAd44zO4nq1J5A/yYqBfCBxHcxv5C
	 AZsGKNhFpLlUUq2uDwZgjusUxTcXRMt0G/6paETr+Ti1LQcjFMGhnuUZ068iUPhvDh
	 KZoyRB0jsf426zCPtladva3yDG4khGSrsiHawGuyE6V5zWwULnkF/Ls/lxNI6+ACEY
	 5zX4VGFGGgp/ZPz5a9CtcqRovDuHibOK/5WWnSzXGSkHyFOBNiXvl2H9vrHdXW49Ns
	 qdSgPOVfVBz20VS6CP7BAymNG7zjbcqcqdJGJN4/4s2qk+8zzdK990oSrbizsYt68d
	 agFVz79Mn3ZPw==
Date: Wed, 5 Jun 2024 08:01:47 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: PCI: qcom: x1e80100: Make the MHI reg
 region mandatory
Message-ID: <171759610335.2612101.16286259446773159357.robh@kernel.org>
References: <20240605-x1e80100-pci-bindings-fix-v2-1-c465e87966fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-x1e80100-pci-bindings-fix-v2-1-c465e87966fc@linaro.org>


On Wed, 05 Jun 2024 11:19:01 +0300, Abel Vesa wrote:
> All PCIe controllers found on X1E80100 have MHI register region.
> So change the schema to reflect that.
> 
> Fixes: 692eadd51698 ("dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


