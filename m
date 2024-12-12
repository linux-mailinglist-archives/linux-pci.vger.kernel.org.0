Return-Path: <linux-pci+bounces-18223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ADB9EE12C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 09:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7D018837BD
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 08:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A436D20C462;
	Thu, 12 Dec 2024 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VleVo90u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724F820C030;
	Thu, 12 Dec 2024 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991767; cv=none; b=g2BirX+OMojlwUhbA18Y3QjCMrjEr9dJRnPQ/WgEIjP1hFg/MOGs/Cu7p29kmw3Y0F6PuYHsQYa4/SB7xOLpHup/4Y9aDQ+DPx17KYdz0IKf4bOeU3BupFM8CxJ6r4LXbm2yHOCc8D07XYCF3G4RqILR5N105WygaIy8fPtZ+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991767; c=relaxed/simple;
	bh=3w6JwqEh1b6LGc9CdhEWu+2Vi3hcS2jK0TgPSdAt/0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViBqv60Pq0nEJNMPW6K3DT48kOrsad7fpL8LxRAWxuSCL0m/KZ6Q0Hzim346rcVK3VInC2Zi/v7faaoN4hIljLK9C6f7HCBbINpKkBIztI4TNtArsDximfktTn6g5ERCQPgYG8f+7FH/HBHt5HhAMxHSHWodQBlqbQNGp6fzl30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VleVo90u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A339C4CECE;
	Thu, 12 Dec 2024 08:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733991767;
	bh=3w6JwqEh1b6LGc9CdhEWu+2Vi3hcS2jK0TgPSdAt/0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VleVo90uZS4UD97FBA4QOHW9ymIgoFO0+bupgBIfksChmKYI2uAb6hEnMNDzgLY1z
	 0zzoDIVAAyeP0t8YEtbobF3MDiHY/b/xwyRRVhL/ErfnnXRTfWM9jwSqrao1dlpoJG
	 hu9FcDWfUdNNHmuUnfO7zAOH4Gop7GfvJYyhtmfAMgcHY6dJvaJrhCJviraLUwjcH/
	 kBNagXr0NVbtBSkYn1fPK2nfcRxLdsryrLquvmt+nkrvyCEUvrkzgRkyuDiTMUA+7J
	 +02/zl+VZ/aIyaBTmQIOBYGdOCG4qAx3Rax01PM2DwMVFUw/ZMRQdmgywrzYO400gb
	 HWbckcvUh9SkA==
Date: Thu, 12 Dec 2024 09:22:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Frank <Li@nxp.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: PCI: mobiveil: convert
 mobiveil-pcie.txt to yaml format
Message-ID: <elx5pr5pvq24useuomzoxtsetmcw6admoo3iyte44kxpt47snf@w6w7kwpwonqm>
References: <20241211171318.4129818-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211171318.4129818-1-Frank.Li@nxp.com>

On Wed, Dec 11, 2024 at 12:13:16PM -0500, Frank Li wrote:
> Convert device tree binding doc mobiveil-pcie.txt to yaml format. Merge
> layerscape-pcie-gen4.txt into this file.
> 
> Additional change:
> - interrupt-names: "aer", "pme", "intr", which align order in examples.
> - reg-names: reorder as csr_axi_slave, config_axi_slave to match
> layerscape-pcie-gen4 and existed Layerscape DTS users.
> 
> Fix below CHECK_DTBS warning:
> arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/pcie@3400000: failed to match any schema with compatible: ['fsl,lx2160a-pcie']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


