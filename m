Return-Path: <linux-pci+bounces-20059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F66A151DE
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 15:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605ED3AB335
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C7A15FA7B;
	Fri, 17 Jan 2025 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZGtD/tx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1439A15B0EF;
	Fri, 17 Jan 2025 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124336; cv=none; b=Nj2A1tU1BABpjlAYiwgFlUrUJ250eB53CsRKRYONACD2t3HvNDSxzkGeM/oSj2Cfa4txM2soz3DK2gQXZFx5ZuukzhvrkIWochz3Jv1xrh2GtJYkQs685F6nnR0lS7MtlwBWlpsYDSgnbyJQmqTBlFyYlR6Kvb7ar3zgOZ/wKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124336; c=relaxed/simple;
	bh=0QzG2CTtuEAlF3DE/XbMOfWpPhdvkjgAMBiTKD9IiBs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=qOrXiXLI8Suh5J5lu2J4l8jW0vnVYz5kP7Yl4HWi7yy9iouWsdHA++VLHauxou4d/zdurhU6/c0O8GLc6G1pnDIn7unvuGXiPUtNFmj2xntvTsaWDKJFSNuR3GTp3DvCDEn4+cr3T0WBLyFKe6CYE2WIqRqlytfhm3nss/n+5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZGtD/tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E66EC4CEDD;
	Fri, 17 Jan 2025 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737124335;
	bh=0QzG2CTtuEAlF3DE/XbMOfWpPhdvkjgAMBiTKD9IiBs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YZGtD/txLzXSylWTTWa9HUopa1qjTdX/3tNILgC3V+DBX705/JYia7Pim6SBCR2C7
	 /DIDpMnJQCKY04OAcT3GEY8p/s6aJBn0uaYM0uvIc4Tp3PA6cGseo1nklxjJTIVkyc
	 dNlHR3MEjvVrJ4ckZ8d/BKPRb3qdfsw6KTU+pByWU0mrrWwV3Ppn8IpcA/hS5SJ/iG
	 qDmmk0QHZeVPi9KXFNhQB/kfXoP+ROr6FaW+pHkSbAsYas+9DrgOsg540PgP9LuwZi
	 F7OWfqtO7gdq8J5OvRUnJotYloHvA7tiuzhs2pUXaJCNrMUvgdps/5rWqezH+2XPCJ
	 9E9J14jLHznVA==
Date: Fri, 17 Jan 2025 08:32:13 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Simon Xue <xxm@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 heiko@sntech.de
To: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250117032742.2990779-1-kever.yang@rock-chips.com>
References: <20250117032742.2990779-1-kever.yang@rock-chips.com>
Message-Id: <173712392444.809947.13861859181056356292.robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576
 support


On Fri, 17 Jan 2025 11:27:41 +0800, Kever Yang wrote:
> rk3576 is using dwc controller, with msi interrupt directly to gic instead
> of to gic its, so
> - no its support is required and the 'msi-map' is not need anymore,
> - a new 'msi' interrupt is needed.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v5:
> - Add constraints per device for interrupt-names due to the interrupt is
> different from rk3588.
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
>  .../bindings/pci/rockchip-dw-pcie-common.yaml | 53 +++++++++++++++----
>  .../bindings/pci/rockchip-dw-pcie.yaml        |  4 +-
>  2 files changed, 44 insertions(+), 13 deletions(-)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250117032742.2990779-1-kever.yang@rock-chips.com:

arch/arm64/boot/dts/rockchip/rk3566-pinetab2-v2.0.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-pinetab2-v2.0.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dtb: pcie@fe170000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v2.1.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v2.1.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dtb: pcie@fe170000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6b-io.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6b-io.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-powkiddy-rgb10max3.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dtb: pcie@fe180000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6b-io.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6b-io.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6b-io.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6b-io.dtb: pcie@fe160000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6b-io.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6b-io.dtb: pcie@fe170000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb: pcie@fe170000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dtb: pcie@fe170000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dtb: pcie@fe270000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dtb: pcie@fe280000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg-arc-s.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dtb: pcie@fe270000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dtb: pcie@fe280000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dtb: pcie@fe270000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dtb: pcie@fe280000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dtb: pcie@fe270000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dtb: pcie@fe280000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: pcie@fe180000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353ps.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dtb: pcie@fe180000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: pcie@fe160000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: pcie@fe170000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dtb: pcie@fe270000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dtb: pcie@fe280000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtb: pcie@fe160000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtb: pcie@fe170000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pcie@2a200000: interrupt-names:5: 'dma0' was expected
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pcie@2a200000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err', 'msi'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pcie@2a210000: interrupt-names:5: 'dma0' was expected
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pcie@2a210000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err', 'msi'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dtb: pcie@fe160000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dtb: pcie@fe170000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtb: pcie@fe270000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtb: pcie@fe280000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: pcie@fe180000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-powkiddy-rgb30.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353vs.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-powkiddy-x55.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtb: pcie@fe270000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtb: pcie@fe280000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dtb: pcie@fe280000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: pcie@fe170000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-powkiddy-rgb20sx.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dtb: pcie@fe280000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dtb: pcie@fe280000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dtb: pcie@fe180000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3-io.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3e.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtb: pcie@fe180000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dtb: pcie@fe180000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dtb: pcie@fe170000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dtb: pcie@fe180000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-odroid-m1s.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-odroid-m1s.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dtb: pcie@fe170000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dtb: pcie@fe180000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dtb: pcie@fe170000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dtb: pcie@fe280000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3w.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: pcie@fe180000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtb: pcie@fe180000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353v.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: pcie@fe170000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v1.1.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v1.1.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtb: pcie@fe170000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dtb: pcie@fe180000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-box-demo.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-powkiddy-rk2023.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: pcie@fe180000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dtb: pcie@fe280000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-pinenote-v1.1.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg503.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-pinenote-v1.2.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: pcie@fe180000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: pcie@fe180000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: pcie@fe190000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: pcie@fe190000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: pcie@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: pcie@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: pcie@fe160000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: pcie@fe160000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: pcie@fe170000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353p.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg-arc-d.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb: pcie@fe270000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb: pcie@fe280000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb: pcie@fe280000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-pinetab2-v0.1.dtb: pcie@fe260000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3566-pinetab2-v0.1.dtb: pcie@fe260000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#






