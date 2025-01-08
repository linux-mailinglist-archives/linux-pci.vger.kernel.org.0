Return-Path: <linux-pci+bounces-19516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12834A0551F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 09:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A6F3A3ACA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C299D1AB537;
	Wed,  8 Jan 2025 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN9rihRi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DAD2594B3;
	Wed,  8 Jan 2025 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736324199; cv=none; b=kmMJs3ddpUqumYx2s+lXE/oXnuoydscbxRWrSjwVLR0f1mIVUpE77qVuSndyIWqiL2NlrXD6w9zPpDTgEm+gpKF2uZVAoHAcVwDJHPEqyRBYWBoacLeJF/Uo7Rpc+ndyCgw7V+VzGhrqyXfT5zG5ji0bAvB2rpuZZWaCDeQ+C9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736324199; c=relaxed/simple;
	bh=RYpqzehaxcbuCAQe6zrPlG3oflSe5JINhcfNw0oboaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asFocF7PjHVBovXA+WUtz611NNiSfm3IkhQT64egIJSQBlRZ+BUXGLSkgHiw+wEOydSNpjJtfdeEulQHD3fi670MLeWn1BuFbT8md/LwHpbjGL+AS0dR4zmZX0Ta1QyA/8WbjQgzCL2z0BNgZ3VKvzy1oKiJZxPiz7hBOwy4Hb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN9rihRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AC8C4CEE0;
	Wed,  8 Jan 2025 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736324199;
	bh=RYpqzehaxcbuCAQe6zrPlG3oflSe5JINhcfNw0oboaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SN9rihRiNeZ6JiTIV9G8AhvKNqTV65xqUUlJ6zm3F6KFLgu21kpDjS7GaMDz/nlj1
	 7AEZWS6jajD7fdAa9NdRFU+z29OUbylvSL9N2/fvCjkH1itEXOr8uovDc/n5pmRRR/
	 pRd6B9NjZhNcQhFeuTU9YRYRgvnbY7LdgOcPQ9eBwJ0GeT8OGD1jLY2QcRTcomk9/b
	 eGJf/tY+XVwTrCLBpR1qGY0M2vDb5DlKLyFkJvyG4EuLPUmXzfhEJvA0GqP1Zb8/Ps
	 6stQQ35xCMsudVnMco5Sv8x8WNMIgXprRSzPzULtFEWsJEFROzMEXEERRovyteLcHh
	 4c5v4d0woNtMQ==
Date: Wed, 8 Jan 2025 09:16:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	Simon Xue <xxm@rock-chips.com>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/7] dt-bindings: PCI: dw: rockchip: Add rk3576 support
Message-ID: <tsxho4vhadrl6tsb2k5e2vxaeuun3k5pdkojzwjruqkof54dyd@gs3wsuxzwu4a>
References: <20250107074911.550057-1-kever.yang@rock-chips.com>
 <20250107074911.550057-3-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107074911.550057-3-kever.yang@rock-chips.com>

On Tue, Jan 07, 2025 at 03:49:06PM +0800, Kever Yang wrote:
> rk3576 is using dwc controller, with msi interrupt directly to gic instead
> of to gic its, so
> - no its support is required and the 'msi-map' is not need anymore,
> - a new 'msi' interrupt is needed.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v4:
> - Fix wrong indentation in dt_binding_check report by Rob
> 
> Changes in v3:
> - Fix dtb check broken on rk3588
> - Update commit message
> 
> Changes in v2:
> - remove required 'msi-map'
> - add interrupt name 'msi'
> 
>  .../devicetree/bindings/pci/rockchip-dw-pcie-common.yaml      | 4 +++-
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml   | 4 +---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> index cc9adfc7611c..e4fcc2dff413 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> @@ -81,7 +81,9 @@ properties:
>        - const: msg
>        - const: legacy
>        - const: err
> -      - const: dma0
> +      - enum:
> +          - msi
> +          - dma0

Commit msg said new interrupt, but this basically replaces existing DMA0
interrupt. Maybe that's the problem with this common binding and you
just miss constraining in each device binding. If so: fix also them.

Also: your interrupts property does not match this anymore.

Best regards,
Krzysztof


