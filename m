Return-Path: <linux-pci+bounces-6061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B689FF36
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786361C233A7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD5317F391;
	Wed, 10 Apr 2024 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpUzsLSG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632E17F376;
	Wed, 10 Apr 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771743; cv=none; b=g1RKcSAOsEMRcbC09AccrTPHDDMCZC2JFhjl9XHWlstxPOs3gAAGBdQ85/VHYA2yNEAoaY6Lnd/oU/iFI90rdMNSxsbEn7+dE5mxY/pEtCY+nmCdeoxeOmM1+cq2YsttygFZlrivux8qirBiCPo+HphO+BrwQ9JRNXIoJ92yLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771743; c=relaxed/simple;
	bh=dn3s9v+ugyPIbkJ82h/zTt6Aiku1UOONkbAxvrR7jyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piKo4W7u5epNBK4tDBjHl8LtrNiZuRdwMRGRsrgahm1tEW8zLgul1xFtrCUScU1NR2rk/7oheajPCjgydLLQ53hWUsHic85tuaYR9h+eAWjIg0MDsE027+RpIAXSAALjQtgj2g49Snp1TzSLKdMGyG7dv04ec5XgkcCOPJdDNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpUzsLSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8713FC433C7;
	Wed, 10 Apr 2024 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712771742;
	bh=dn3s9v+ugyPIbkJ82h/zTt6Aiku1UOONkbAxvrR7jyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpUzsLSGnL5sS1FPnbAHM+SupDJSYxEEhgxEXj/LIJrVoazOecimqvkwlMp/t5gpz
	 o91wT8i8WD1ZZbuBSACUvKLBe6clAAnDzFYVDT6fk7nxnaGOgy/lXWLfQH+fi0lJLB
	 z8hmwmaKhAiBHMSC0vAR4C7GuRooP4Z33TKH0BUGNCxbnqltNkzFfk7y3VMzTIMXfe
	 PI/XPibfx+hhhGRQumNTUvoPYuff9ZgSlCnUjG6Kav98xRFY6exPQd4ScbYn4tdJIY
	 LHHOXgAjpI6EUH5zBHSbyoOlKWZzoKUTt5K4Tjb7Go4tL3CrnVYgvvNd1GF3z7kBQg
	 MHLNVbkrGV+oA==
Date: Wed, 10 Apr 2024 12:55:40 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
Subject: Re: [PATCH 3/3] dt-bindings: PCI: host-bridges: switch from
 deprecated pci-bus.yaml
Message-ID: <20240410175540.GA802090-robh@kernel.org>
References: <20240407102000.37213-1-krzysztof.kozlowski@linaro.org>
 <20240407102000.37213-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407102000.37213-3-krzysztof.kozlowski@linaro.org>

On Sun, Apr 07, 2024 at 12:20:00PM +0200, Krzysztof Kozlowski wrote:
> dtschema package with core schemas deprecated pci-bus.yaml schema in
> favor of pci-host-bridge.yaml.  Update all bindings to use the latter
> one.
> 
> The difference between pci-bus.yaml and pci-host-bridge.yaml is only in
> lack of "reg" property defined by the latter, which should not have any
> effect here, because all these bindings define the "reg".
> 
> The change is therefore quite trivial, except mediatek,mt7621-pcie.yaml
> binding which have children nodes being also host bridges, apparently.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/apple,pcie.yaml         | 2 +-
>  Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml    | 2 +-
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml      | 2 +-
>  Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml     | 2 +-
>  Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/host-generic-pci.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml | 2 +-
>  Documentation/devicetree/bindings/pci/loongson.yaml           | 2 +-
>  .../devicetree/bindings/pci/mediatek,mt7621-pcie.yaml         | 4 ++--
>  Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 2 +-
>  .../devicetree/bindings/pci/microchip,pcie-host.yaml          | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml          | 2 +-
>  Documentation/devicetree/bindings/pci/rcar-pci-host.yaml      | 2 +-
>  .../devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml        | 2 +-
>  .../devicetree/bindings/pci/rockchip,rk3399-pcie.yaml         | 2 +-
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml       | 2 +-
>  Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml   | 2 +-
>  Documentation/devicetree/bindings/pci/versatile.yaml          | 2 +-
>  Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml  | 2 +-
>  Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml | 2 +-
>  Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml      | 2 +-
>  Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml     | 2 +-
>  25 files changed, 26 insertions(+), 26 deletions(-)

This implicitly bumps the minimum version for dtschema. That's fine, but 
it should be explicit since we set it explicitly.

Rob

