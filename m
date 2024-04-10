Return-Path: <linux-pci+bounces-6076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AA58A00A3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 21:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F10A286E35
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F523181335;
	Wed, 10 Apr 2024 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq4rrWfX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348D181322;
	Wed, 10 Apr 2024 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777553; cv=none; b=e/mQ06VkSWAXIrCuSc05MtA3uv8WGh4NhXwkGuhKDH07PPDrAPWBVAr7QAIn9+1sqg0AaJtt7z6nnRLzrVmxncFWrnv2pTXd4TG9ZC8BUyd/K771IZIwaUZMIQRtXpFyiK4GFwHxrvT54VvUouPCaMUUZE3W89ZpLZ71VgiXSJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777553; c=relaxed/simple;
	bh=WW5sMpVOz0tGbMU1O5onTUR51y42uNFu9wn05WPtkWY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=d8fzlFMknzzDdOw9Ya/qxCVLVE/zzVJnQWH/LWVdqvFUvHTsJS34wOlPY9tQ41W0abVnxkKFqExT8WoI4Xe2bnLLBoifJLZiOc0n4LUmaogtqnl1+Xp9KJIamL3yAwbnnBT2Q91q66+dwUzogrO5x8rWAwf3kg1WuzXfgmBs0rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq4rrWfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88179C43390;
	Wed, 10 Apr 2024 19:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712777552;
	bh=WW5sMpVOz0tGbMU1O5onTUR51y42uNFu9wn05WPtkWY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tq4rrWfX9sfVjyG1eyRA5JQGhmGUZZ7uZmnP8xeGteU4tmjtBJwX1rIwj8QFaJQjX
	 hazgBdZOKaDhWWOOpBX6HrGOSdUUKtAERdIR/r8t0ihV2Y0E50ZsNeIdGCuECZsGc4
	 MVhev7smKrOV3LTOgTQd6psiBKajiUbE3PItXRb805uwXE93PscA8sScGPOQ0bD2h3
	 yL4o4fFtnh+PyXMspoVkdeCYh+yHEbJJA7uBTYcP8lE1egXnKItFj4r5SyFia/wVYd
	 et+x2ylnr2iBKZZMb3xWvQ/x8CxEmBdAQqRiw1NTwJlG9b10JfdjTo1V82rU5g43Wu
	 5YHbgdVHo6jUg==
Date: Wed, 10 Apr 2024 14:32:31 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-rockchip@lists.infradead.org, 
 Scott Branden <sbranden@broadcom.com>, 
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>, 
 Sergio Paracuellos <sergio.paracuellos@gmail.com>, 
 Will Deacon <will@kernel.org>, Sven Peter <sven@svenpeter.dev>, 
 Heiko Stuebner <heiko@sntech.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org, 
 Jim Quinlan <jim2101024@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, 
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>, asahi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Tom Joseph <tjoseph@cadence.com>, linux-renesas-soc@vger.kernel.org, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 linux-mediatek@lists.infradead.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Srikanth Thokala <srikanth.thokala@intel.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Bjorn Andersson <andersson@kernel.org>, 
 Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20240410181521.269431-4-krzysztof.kozlowski@linaro.org>
References: <20240410181521.269431-1-krzysztof.kozlowski@linaro.org>
 <20240410181521.269431-4-krzysztof.kozlowski@linaro.org>
Message-Id: <171277754988.1212749.4199877903133990039.robh@kernel.org>
Subject: Re: [PATCH v2 4/4] dt-bindings: PCI: mediatek,mt7621-pcie: switch
 from deprecated pci-bus.yaml


On Wed, 10 Apr 2024 20:15:21 +0200, Krzysztof Kozlowski wrote:
> dtschema package with core schemas deprecated pci-bus.yaml schema in
> favor of individual schemas per host, device and pci-pci.
> 
> Switch Mediatek MT7621 PCIe host bridge binding to this new schema.
> 
> This requires dtschema package newer than v2024.02 to work fully.
> v2024.02 will partially work: with a warning.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Important: v2024.03 (said dtschema newer than v2024.02) was not yet
> released, therefore this patch probably should wait a bit. Previous
> patches do not depend anyhow on future release, so they can be taken as
> is.
> 
> Changes in v2:
> 1. New patch
> 2. Split mediatek,mt7621-pcie to separate patch as it uses
>    pci-pci-bridge schema.
> ---
>  .../devicetree/bindings/pci/mediatek,mt7621-pcie.yaml         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.example.dtb: pcie@1e140000: pcie@0,0: Unevaluated properties are not allowed ('clocks', 'phy-names', 'phys', 'resets' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/mediatek,mt7621-pcie.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.example.dtb: pcie@1e140000: pcie@1,0: Unevaluated properties are not allowed ('clocks', 'phy-names', 'phys', 'resets' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/mediatek,mt7621-pcie.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.example.dtb: pcie@1e140000: pcie@2,0: Unevaluated properties are not allowed ('clocks', 'phy-names', 'phys', 'resets' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/mediatek,mt7621-pcie.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240410181521.269431-4-krzysztof.kozlowski@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


