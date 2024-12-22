Return-Path: <linux-pci+bounces-18938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87899FA466
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 07:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD0B166B6C
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 06:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90232157465;
	Sun, 22 Dec 2024 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3rrlRR9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC514A09A;
	Sun, 22 Dec 2024 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734849554; cv=none; b=kN0JP2zgKJyPOb0sVeIpvuflgu9naNjabbM1qddnbAugmT0S2n+nd9r50Awrhy9l6Ui0ru7TazM8T+F0GWNHuFBSVa0d7rb4bv3Qb+8ybe8hGXHDy6/DhTAeBCsxaMg6wKuCG0waoqJHBhnR+Pttb2bJjqH7E8zKqHTdAccyCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734849554; c=relaxed/simple;
	bh=nIOy5NCy3gDF4Qi+nRoagjQkpM+p9VfglSZHcEXfLYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1MEFPsh8tQWqb4m8jTNLBg8V0L82qnTyOb5iSl4Is55qMlfZtvbO++q0j+yi6mBfXF0AUtNqp8gbBHJSEjp+pOgKiMHsEZSrOJKQukyl3r8F296tGgPWPP5hOyfgOe1LO7BJDsmo0YMiykwaHK3mZuVaorybKjVDGXCLS+UDGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3rrlRR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5982AC4CECD;
	Sun, 22 Dec 2024 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734849554;
	bh=nIOy5NCy3gDF4Qi+nRoagjQkpM+p9VfglSZHcEXfLYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3rrlRR9PQsPOivUhgeYNC0FseGfba6OJjMQHSF3zyLNJys2QlXAEpUmIn9E7jkWI
	 4BzgvZjLs7O2ZIyyUnw2YyxVEeBOLgG31jS0uP46ZUXz/+fPqvIAPzrcBuCedcOBWO
	 fvvHJLAnICDeUFdcEoqaXngpnLHerAkZR8My8HJG1w8Go0XHdgvs3cF0w2PwrJWFBs
	 upgkkP8pEDtQJsEReW26CLZtEQg6FxLuoi7fcJv5Nx5FdtGXcYP3YyZslRCUHudLpG
	 Dxyyhjpp8SAGIU+QLdHHVARKMwiiqi89ayuKs2y5ESTw6gj7eGnshnm90Yjy2PV5ve
	 rq9G3oRKr4O8A==
Date: Sun, 22 Dec 2024 07:39:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	Simon Xue <xxm@rock-chips.com>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/7] dt-bindings: PCI: dwc: rockchip: Add rk3576
 support
Message-ID: <n4iwrjmgtpetajccfsaz2nqv2g2of6md4moyus7vdwfcp6tgt2@4qe7qkvjrix2>
References: <20241220101551.3505917-1-kever.yang@rock-chips.com>
 <20241220101551.3505917-3-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241220101551.3505917-3-kever.yang@rock-chips.com>

On Fri, Dec 20, 2024 at 06:15:46PM +0800, Kever Yang wrote:
> rk3576 is using dwc controller, but use msi interrupt instead of its,
> so the msi-map is not required, and need to add a new 'msi' interrupt name.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v2:
> - remove required 'msi-map'
> - add interrupt name 'msi'
> 
>  .../devicetree/bindings/pci/rockchip-dw-pcie-common.yaml      | 1 +
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml   | 4 +---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> index cc9adfc7611c..e5e1a2c7ae05 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> @@ -81,6 +81,7 @@ properties:
>        - const: msg
>        - const: legacy
>        - const: err
> +      - const: msi

ABI break without clear reasons.

Best regards,
Krzysztof


