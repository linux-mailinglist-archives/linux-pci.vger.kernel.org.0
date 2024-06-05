Return-Path: <linux-pci+bounces-8282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947008FC47A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 09:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA0DBB21AE6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 07:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C6C1922D1;
	Wed,  5 Jun 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKVsIfM2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4521C27;
	Wed,  5 Jun 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572282; cv=none; b=FFdvWYe2O9qA9UCm8+lJ5DksGNWYVjRxRk3PALyPfFKUyhuPPvFt0WtajwjWi8a8E904wKptVL7xfjThXBhKk0cIK4GFLAfx3s8ZbrHpbONOWxPv2aZzHjNG5JFeLokxEcIaucRyMOFQFCt9BrAkz/KCjcESWF51Ao6DDDZ+neE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572282; c=relaxed/simple;
	bh=SUY8FX2smZKlev1msDZHqJH0TCRWfu6CpWzZA69uFGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqxNghb1RNjInVIZQCTTlvkoGZ6prYvL6qXcSw6E7FspTztDj+xS6BJZucN1s2DhogTtz7IZSz4C4Ykw63UqKzdCoS/oZzw3e6XU97woSzpJ3I01zT2xNNkx+ImdqE0UMdl4p/cc4rcJ304MBLtTOUPiJglP9OoxEO/cQrQ7sIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKVsIfM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C190FC3277B;
	Wed,  5 Jun 2024 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717572282;
	bh=SUY8FX2smZKlev1msDZHqJH0TCRWfu6CpWzZA69uFGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKVsIfM2bLSzcud8xuu6cEk8uPQtyMQ2K5mUeyNh80mcW8sXU3DVnfPW/d7Cjk+3d
	 FfH9zXWzYntPEkk39M9JMt2B3Sc70et+NlpTIrUR18LDbZUvmMYz9JTZLOVNVgZxUk
	 1Zm67HkwmUDNuciEWL/Vmb7AHRLK8TMFuZFW2YYZqUdWDaPvF1D1RV0CA881mjNHwT
	 WuvaVOF+4an8JBh8V5Z3peh9Y++TZRgsYefDkTZlOA3cK5A07Gy8gjf9IWYTGdX2P7
	 G8tTIbxwB5irjgWPIyWcsg9IKaMWX8t36L9qnh8UDRNi5MeUaKIAv/44VQbCEE5i3R
	 PQ/vV/rv93/yQ==
Date: Wed, 5 Jun 2024 12:54:29 +0530
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
Subject: Re: [PATCH v4 02/13] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific interrupt-names
Message-ID: <20240605072429.GD5085@thinkpad>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-2-3dc00fe21a78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-2-3dc00fe21a78@kernel.org>

On Wed, May 29, 2024 at 10:28:56AM +0200, Niklas Cassel wrote:
> Considering that some drivers (e.g. pcie-dw-rockchip.c) already use the
> interrupt-names "sys", "pmc", "msg", "err" for the device tree binding in
> Root Complex mode (snps,dw-pcie.yaml), it doesn't make sense that those
> drivers should use different interrupt-names when running in Endpoint mode
> (snps,dw-pcie-ep.yaml).
> 
> Therefore, since "sys", "pmc", "msg", "err" are already defined in
> snps,dw-pcie.yaml, add them also for snps,dw-pcie-ep.yaml.
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
> index 00dec01f1f73..f5f12cbc2cb3 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> @@ -156,7 +156,7 @@ properties:
>              for new bindings.
>            oneOf:
>              - description: See native "app" IRQ for details
> -              enum: [ intr ]
> +              enum: [ intr, sys, pmc, msg, err ]
>  
>    max-functions:
>      maximum: 32
> 
> -- 
> 2.45.1
> 

-- 
மணிவண்ணன் சதாசிவம்

