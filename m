Return-Path: <linux-pci+bounces-18904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B29F918A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 12:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D33A189377C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 11:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248451C3F13;
	Fri, 20 Dec 2024 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3mLsHPs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BEB1C3029;
	Fri, 20 Dec 2024 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734695040; cv=none; b=kEBQT8/RWoF+XpXWpwpU+u2ybsFYZeRvxePrQx5teeKG5qiF6I+Z8vbQcywk3MM+r9b4anfvs6EX1ewRf7CtoS2DJKd2H4PJ56NIOLYX43gXPQMjI37hYkGEtLW5TQBfPhRtQ7PnqjF6RJDh+9hWJ7fiYsFVak7a81Gd0xhPnxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734695040; c=relaxed/simple;
	bh=1qaji/tPXJ3XFWsCN7ydyqQqoYJ3IFUXjpiRi1Tvqos=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=dLLs8O6q6fVGEDDrr+p7eTBRssJUhA9bQWYX2IfNLje1H+m/XwzFQomvBiKse6OYTQG3TNWE7W1zgUhZ+nxWWTwajsASmIv+gUmscs+ThN/irsK51wwjfhO8FFIEZ6bNogQQdBpxeoFwNmHTzCaaQBSpP5tIiI3KTFrriPL0ryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3mLsHPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F39EC4CECD;
	Fri, 20 Dec 2024 11:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734695039;
	bh=1qaji/tPXJ3XFWsCN7ydyqQqoYJ3IFUXjpiRi1Tvqos=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=N3mLsHPsylqpb12A3xvUwgV8NZl0bbI9kcs45hj4BqnkU6osyxMMBlQFie65QfwsS
	 mBW+X6SzrmWicuTrBDsGUhI5h2oeAJA+FxR+LrF/DHMw3INKYEmXhnJG6BlEgig64s
	 8g0mkjguAbx1YiWJe5rC+4Yr/5gajiaO0B7PjkGwLfmjyA8p8JIGg1DLsFkogdQkW9
	 gMA89iOlR32OtqKVjFjrk0wF2Fs+GiRoHxkKg/+Uq43LnrsYo6OR5iQUAe9U6/Tnyb
	 chhOQRFYaEvBFOPONMcDGRL+gAMh65LnDRTzQgiB1rDr0wSBEyQhGYl5DGkrMv7Q8b
	 wpz4Ct9dYYkBw==
Date: Fri, 20 Dec 2024 05:43:57 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, heiko@sntech.de, 
 linux-rockchip@lists.infradead.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Simon Xue <xxm@rock-chips.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241220101551.3505917-3-kever.yang@rock-chips.com>
References: <20241220101551.3505917-1-kever.yang@rock-chips.com>
 <20241220101551.3505917-3-kever.yang@rock-chips.com>
Message-Id: <173469503748.2890446.9450914997693920466.robh@kernel.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: PCI: dwc: rockchip: Add rk3576
 support


On Fri, 20 Dec 2024 18:15:46 +0800, Kever Yang wrote:
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.example.dtb: pcie-ep@fe150000: interrupt-names:5: 'msi' was expected
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie-ep.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.example.dtb: pcie-ep@fe150000: interrupt-names:6: 'dma0' was expected
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie-ep.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.example.dtb: pcie-ep@fe150000: interrupt-names:7: 'dma1' was expected
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie-ep.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.example.dtb: pcie-ep@fe150000: interrupt-names:8: 'dma2' was expected
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie-ep.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.example.dtb: pcie-ep@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie-ep.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241220101551.3505917-3-kever.yang@rock-chips.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


