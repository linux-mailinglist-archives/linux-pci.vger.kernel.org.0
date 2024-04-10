Return-Path: <linux-pci+bounces-6085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2078A01F1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 23:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CAD9B24CCC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 21:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCA21836E7;
	Wed, 10 Apr 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7uw442U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32AE1836CE;
	Wed, 10 Apr 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784401; cv=none; b=AdoObEr7Di2ZtUF4ipPNja3TUCdUKDfndtH1GaRgAYCVQEQ2QflGuB6L3fN3YeK2LJVNJPekEneyncpLsRNEmblHp7LKdMS19gaB+3DyUlNznBhgmOSGapaWr2w6q7UDf5Rw2qlcZpywRlOByfAMkOAkqTeM2WyQDqYSKDOSuDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784401; c=relaxed/simple;
	bh=ZHY0Qb2p6hZj2F9UUpHFyF1+cCJBE7U8HaVGMIWgfJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gSC5sLKRCxDYWJbmzE9UalWM1Zp8qkjhwaoUoMR0dVba0Axb001SaEuyt0SZGt7AywHsJsMyJjmbA8YXGjiZeBIxHzwZubESgLCcMVGSnQDZtBhwNzEIbMwFM3zZXEG1zdM4qHtjp1Q5iplJRPLCbg0o1lJVrDCvnpahd+OPvc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7uw442U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5B8C433F1;
	Wed, 10 Apr 2024 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712784400;
	bh=ZHY0Qb2p6hZj2F9UUpHFyF1+cCJBE7U8HaVGMIWgfJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=X7uw442UbgIpqeMvt0lGFcXg86xEWI2esbZmYrlcuSZ0IHUAEfYztCnABCY3OWfcN
	 qha3LHFaAPenRfxa13l39CP+7GGIX0nvuojS+bJEjDEo/05E+SEw4/981rCoRB7mZ8
	 AiCC0TmbExTNmCkcQyOEEymnER7zgHtneM1Ex3ay5q4H0OOK9cRxPP9m9yKRxq/6Zo
	 Kd9xqDj2EzKSRE0wcXWJAeACN6Slg9b5ZPc42hYpHHJ/9g/3XlaGWpH6fKTo1jFdGv
	 wtWzLc4tD0iN1BOu/0zmhzyFLK8qGFJjMIMUEWb18MkFUt8L+lqhYbq+ugp0UKiIGb
	 RxRImDtJqxM1w==
Date: Wed, 10 Apr 2024 16:26:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Tom Joseph <tjoseph@cadence.com>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: PCI: mediatek,mt7621: add missing
 child node reg
Message-ID: <20240410212638.GA2159326@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410181521.269431-2-krzysztof.kozlowski@linaro.org>

On Wed, Apr 10, 2024 at 08:15:19PM +0200, Krzysztof Kozlowski wrote:
> MT7621 PCI host bridge has children which apparently are also PCI host
> bridges, at least that's what the binding suggest.

What does it even mean for a PCI host bridge to have a child that is
also a PCI host bridge?

Does this mean a driver binds to the "parent" host bridge, enumerates
the PCI devices below it, and finds a "child" host bridge?

> The children have
> "reg" property, but do not explicitly define it.  Instead they rely on
> pci-bus.yaml schema, but that one has "reg" without any constraints.
> 
> Define the "reg" for the children, so the binding will be more specific
> and later will allow dropping reference to deprecated pci-bus.yaml
> schema.
> 
> Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Add tags.
> ---
>  .../devicetree/bindings/pci/mediatek,mt7621-pcie.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> index e63e6458cea8..61d027239910 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> @@ -36,6 +36,9 @@ patternProperties:
>      $ref: /schemas/pci/pci-bus.yaml#
>  
>      properties:
> +      reg:
> +        maxItems: 1
> +
>        resets:
>          maxItems: 1
>  
> -- 
> 2.34.1
> 

