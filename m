Return-Path: <linux-pci+bounces-21334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C739A33AC9
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 10:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49EC3AB551
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 09:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8535211A2A;
	Thu, 13 Feb 2025 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4xw9V3n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74333211A0D;
	Thu, 13 Feb 2025 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437798; cv=none; b=Oxd+/4Z7/ZeVsGp1lIG337jTNApa23wUhSzdI533JzRmJ0oiCe0c2guX+2gk0DTSCxYCyl+bYwfuJtbTPjMMwI5C/Fsyg+B2oRwKaf1Tlte9OtGw+PqzMGB9ZT3RMASBx0QJMb3jIhObZDMfw3qCY3xSLJ9fYSw0geQ58cHXMr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437798; c=relaxed/simple;
	bh=yzTo+VSqdbP5hYD2auan7a+l2E2+Wwt1B7liKWHLG5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hE3M20ri2ObC9GezMnZeqDGGwZ7FF1jx5CNnEPFw1Ln1zaPbxmkHv48OANtiLpcA3CFoT4LWa1GSo8We+4nimJ2aWaxCrP7DRhJNhPEuEgw5q2RF93vnKGIgDOLZOvMA5vkHEbakajsk22kqW6zzshCYe4ERWXD20qWLMqNnDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4xw9V3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1E3C4CEE6;
	Thu, 13 Feb 2025 09:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739437798;
	bh=yzTo+VSqdbP5hYD2auan7a+l2E2+Wwt1B7liKWHLG5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4xw9V3nRsRa6ghT9q+jymjVNL2RKfNOZ2YBFCEGAkzEyQWHExLusTZusYF8k7vaF
	 kIkkKWGJEIZUucKG7cSvSytTwjgRa6WiLUGWQU9LX8JLeVoFewPLUv+ZIvDahdhSpZ
	 E+k/ZRDjgWb0+NwPxPjtHcJuFMxFP3uwgeCBkI+nPdVsrj7vAKNw9LUrMXz3KWvzFm
	 /qf9TC0syXuIecZUGTaFX8/+QF4Ug6oVsyAVx4sQ4uNP23Wj7HKcGu6dA0PkvSyHUQ
	 mFZXoKFadv37t+Cdqk4Kb8sBcTAnJ/3kPdyGqvgCKEVDLwSEDPCLHPCzhnrAxoLAeJ
	 Jl1FczADjsROA==
Date: Thu, 13 Feb 2025 10:09:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Marc Zyngier <maz@kernel.org>, Stan Skowronek <stan@corellium.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: pci: apple,pcie: Add t6020 support
Message-ID: <20250213-faithful-ibex-of-feminism-3aea45@krzk-bin>
References: <20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io>
 <20250211-pcie-t6-v1-1-b60e6d2501bb@rosenzweig.io>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211-pcie-t6-v1-1-b60e6d2501bb@rosenzweig.io>

On Tue, Feb 11, 2025 at 02:54:26PM -0500, Alyssa Rosenzweig wrote:
> This shuffles some registers versus t6000, so requires a new compatible.
> 
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
>  Documentation/devicetree/bindings/pci/apple,pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


