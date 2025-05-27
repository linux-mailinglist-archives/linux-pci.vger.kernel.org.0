Return-Path: <linux-pci+bounces-28474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56755AC5AD7
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 21:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FAD116BD8A
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 19:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13BD2882B4;
	Tue, 27 May 2025 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+sSydqP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D9412B93;
	Tue, 27 May 2025 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374552; cv=none; b=boCFlB8+tpzkohdBxyOF9lju6dOTK6IHUiXBAbcqD1sGIuBRY36alsEGrLCRuL+kdjVyrKUsteOw531kAN+7dF7FYmUUX1D1LrQXqT7eKot754a3Yy9/q2H9YGQZl69rOqQHYlVvUUMC7Dvme6c0Kl9RwWnAN2VuIxEbEIuch4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374552; c=relaxed/simple;
	bh=h4zhoTMI38sWqikCbt4K2joSWNXLc0BKXMI8jK3thK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce3ntRg3LtC2RfocnAw7nKBYSTDYLtaU041dJmn88DOnsV9/gP0QRYopY7qYEumclCV6bF8bgOWeXrh67ty2Oaj7lwTFwCip9rvJbsHaXIAjbql1b2EXnNSkKy3V0+ZSajbmIwkIbcs9IcN1fhz+GFaGsHCX9Dd3dw5VOM64cM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+sSydqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF79C4CEE9;
	Tue, 27 May 2025 19:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748374552;
	bh=h4zhoTMI38sWqikCbt4K2joSWNXLc0BKXMI8jK3thK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+sSydqP5tn9jeoRxzdTngtlfBBVE6Cl+O5HAaayPvtMv5LSsjRXdR5A79KFXAHyc
	 dR3OFtSGo0VJoXb+xzGazN/EXH7FH9VW/7nbJjIjOscTssd+ebtXqPA/sp7tqAMYh0
	 5tHfqhfV/TNlTFkNY2katYbMI2tDjm5kzWK+DGWCUpERnlQtJ8vPKB0GQWXLXByVat
	 dqWrgGtcaMv0NzF6jWkwTP0SySyHoHMvj9Ggck3WQuejZD2z394r7MYSEuODmBaO2y
	 WyFrf+mO8TNNuJE1huH7+Zrz3DRhXyqbFq32/j/BJUAwOiuClVeHrb7R2u2ZSYNC6W
	 iQzZ+3NdFAEwA==
Date: Tue, 27 May 2025 14:35:50 -0500
From: Rob Herring <robh@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	krzk+dt@kernel.org, manivannan.sadhasivam@linaro.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: Extend max-link-speed to support
 PCIe Gen5/Gen6
Message-ID: <20250527193550.GA1104855-robh@kernel.org>
References: <20250519160448.209461-1-18255117159@163.com>
 <20250519160448.209461-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519160448.209461-2-18255117159@163.com>

On Tue, May 20, 2025 at 12:04:46AM +0800, Hans Zhang wrote:
> Update the device tree binding documentation for PCI to include
> PCIe Gen5 and Gen6 support in the `max-link-speed` property.
> The original documentation limited the value to 1~4 (Gen1~Gen4),
> but the kernel now supports up to Gen6. This change ensures the
> documentation aligns with the actual code implementation.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

This file is now removed. Update the schema if you need to. It lives in 
dtschema project.

> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index 6a8f2874a24d..5ffd690e3fc7 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -22,8 +22,9 @@ driver implementation may support the following properties:
>     If present this property specifies PCI gen for link capability.  Host
>     drivers could add this as a strategy to avoid unnecessary operation for
>     unsupported link speed, for instance, trying to do training for
> -   unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
> -   for gen2, and '1' for gen1. Any other values are invalid.
> +   unsupported link speed, etc.  Must be '6' for gen6, '5' for gen5, '4' for
> +   gen4, '3' for gen3, '2' for gen2, and '1' for gen1. Any other values are
> +   invalid.
>  - reset-gpios:
>     If present this property specifies PERST# GPIO. Host drivers can parse the
>     GPIO and apply fundamental reset to endpoints.
> -- 
> 2.25.1
> 

