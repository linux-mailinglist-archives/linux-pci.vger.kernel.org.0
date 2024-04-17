Return-Path: <linux-pci+bounces-6374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDB48A8A82
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 19:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66DB1C22247
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F87E172BA5;
	Wed, 17 Apr 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WApZKAf1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5AD146D59;
	Wed, 17 Apr 2024 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376407; cv=none; b=RcCaBcG2EjqgUC1DVaesU1Dk/7vqOkVglms1JgM/9SAwCMPgm5kusj4pvu/nsqVFECJbkOjCq9gCqzaqbz5XOrPfN9lGZdRA3K1g/2vx45roAvjG68FNZwYZqHBoBRQzRrCLR43xsrdrDtygbZ6KPvlvjD4Zc143UM+4pDO3eD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376407; c=relaxed/simple;
	bh=QLWfuCo19n+5G8TriwcT49BQW1kf42mY8DE2wIQXSdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxsnGodWiYqSVLB4G9Qh7LvlfWVxtz3v5o5n2Bk1jrb4lGdMNsKyL/kXUd0BoifuLSsuzagNEtRdcGCZ3rAX4fuv5HUmBh5qw2tfI8MUxyUWmarcQ1UsMih8TkpWWJAIP6cXMiWLv8j5+x1yVRhbFKrDkM6CcOrXltDiiUFuP9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WApZKAf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BA2C072AA;
	Wed, 17 Apr 2024 17:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713376406;
	bh=QLWfuCo19n+5G8TriwcT49BQW1kf42mY8DE2wIQXSdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WApZKAf1+rnM9gBKe0B/xfeClV8LsXGKwunncvfSxR0fDWYiFxcPgKYK4CBxoSr+b
	 8nXQbKv2BiJm0GMgsjVddbtOZT5DjjJQk+5aMRHwMxi+LPXtLePZLoCvBFf4NRDJys
	 JwR7QtX3SOU1jzLDopc9fDMUUEiT0Y/f2IH7BROmWshh5Z/iLtM4A/0biyZD7QPNg2
	 gc8uXnb+WytmaAspvIn7QSBu/mUtANqSn8MsnepiosJ0Lb+DFllbeUQR1ZzFoVOK1D
	 0zZMvM/6MOsLhtlngEe+wDbd8GJnjgcW9+eizHsd8icDgAravQsa7xu2rXBg49HxZt
	 YywCAU8OSd/Dg==
Date: Wed, 17 Apr 2024 12:53:24 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Tom Joseph <tjoseph@cadence.com>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Hector Martin <marcan@marcan.st>, Will Deacon <will@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jim Quinlan <jim2101024@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, asahi@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-renesas-soc@vger.kernel.org, Sven Peter <sven@svenpeter.dev>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-rockchip@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Michal Simek <michal.simek@amd.com>, Ray Jui <rjui@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: PCI: host-bridges: switch from
 deprecated pci-bus.yaml
Message-ID: <171337631676.2838286.7798730496718117728.robh@kernel.org>
References: <20240413151617.35630-1-krzysztof.kozlowski@linaro.org>
 <20240413151617.35630-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413151617.35630-3-krzysztof.kozlowski@linaro.org>


On Sat, 13 Apr 2024 17:16:16 +0200, Krzysztof Kozlowski wrote:
> dtschema package with core schemas deprecated pci-bus.yaml schema in
> favor of pci-host-bridge.yaml.  Update all bindings to use the latter
> one.
> 
> The difference between pci-bus.yaml and pci-host-bridge.yaml is only in
> lack of "reg" property defined by the latter, which should not have any
> effect here, because all these bindings define the "reg".
> 
> The change is therefore quite trivial, however it requires dtschema
> package v2024.02 or newer.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # Renesas
> Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v3:
> 1. None
> 
> Changes in v2:
> 1. Add tags.
> 2. Split mediatek,mt7621-pcie to separate patch as it uses
>    pci-pci-bridge schema.
> ---
>  Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml     | 2 +-
>  Documentation/devicetree/bindings/pci/apple,pcie.yaml           | 2 +-
>  Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml      | 2 +-
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml        | 2 +-
>  Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml       | 2 +-
>  Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml     | 2 +-
>  Documentation/devicetree/bindings/pci/host-generic-pci.yaml     | 2 +-
>  Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml     | 2 +-
>  Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/loongson.yaml             | 2 +-
>  Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml  | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml     | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml            | 2 +-
>  Documentation/devicetree/bindings/pci/rcar-pci-host.yaml        | 2 +-
>  .../devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml          | 2 +-
>  Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml | 2 +-
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml         | 2 +-
>  Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml     | 2 +-
>  Documentation/devicetree/bindings/pci/versatile.yaml            | 2 +-
>  Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml    | 2 +-
>  Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml        | 2 +-
>  Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml       | 2 +-
>  24 files changed, 24 insertions(+), 24 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


