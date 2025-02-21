Return-Path: <linux-pci+bounces-21981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4721FA3F443
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 13:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E916D3BB895
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DDB20ADC7;
	Fri, 21 Feb 2025 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDWs/cKw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B779B209F2E;
	Fri, 21 Feb 2025 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740140969; cv=none; b=evcW6eoQacqHIfdovvbSx/ogs11yoktM+hE2HbbAc+o6BtJfR0V8p7VOJvKMVGoO3KvvxQp/8rsASGZjsdlCgHcLvbfNlehDuZrP/PYpYnQCMfz6U3i3A3+LOfvHf4p5nPvcKN/F9X1xfeKBt+ei6SsBWW0rJvy/x2/NLzvAPvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740140969; c=relaxed/simple;
	bh=yeXSTli4MjZbx7FP0/Y3On8xKZiLQ1Wgmzdq+wGSUmg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=WgP9aFuupVe7F01CWmTJ3bClrcf4zG1hgY6KeBP+GDZO6IzaKssaxFNZA45u71RqcNIm3MOfR8fKJDD6fh/HemS/uXeH8mQ3zUrj8yne6oOUfleHlG9lu0TyfdPJNMfd7B3ouu23Y/+WM7Y3+ttRDegOvbeb+0ARmJ2hxh8Bvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDWs/cKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E56EC4CEDD;
	Fri, 21 Feb 2025 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740140969;
	bh=yeXSTli4MjZbx7FP0/Y3On8xKZiLQ1Wgmzdq+wGSUmg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=KDWs/cKwawUW6RUJpFTguLvs6ax6RrAFU9bAFB2Om9yvjH2i/1RXMvDs1s8x4ilad
	 VpGg8HGVR3Aq6NUzjMe9PdYjkvcf7chFBOkkGIM99T+MV2ena0gM+qXFq40b0Z/way
	 IdZKWm58LDy9pIWGoEU7LHLhRbcJO5xmQ9gekIP1+tsqH24cS5RZaaSg8XXbiqxkhc
	 oyJolu1DDUQ3jl54N+KARxpfxIE/NO3bSe9tVeI9uSdMF6kJLz1reojsuHsawo3Jt1
	 AWNg7/t7+UsgL4Od+JmS96abev+jaYpMT6Tj9EESw7hyvV/G3n3fw4ax2x7DGMBnA8
	 G7F9/Hy1W1leg==
Date: Fri, 21 Feb 2025 06:29:27 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 devicetree@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 heiko@sntech.de, linux-rockchip@lists.infradead.org, 
 Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Simon Xue <xxm@rock-chips.com>
To: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250221104357.1514128-2-kever.yang@rock-chips.com>
References: <20250221104357.1514128-1-kever.yang@rock-chips.com>
 <20250221104357.1514128-2-kever.yang@rock-chips.com>
Message-Id: <174014096734.2508114.17981034112064393929.robh@kernel.org>
Subject: Re: [RFC PATCH v6 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576
 support


On Fri, 21 Feb 2025 18:43:56 +0800, Kever Yang wrote:
> rk3576 is using dwc controller, with msi interrupt directly to gic instead
> of to gic its, so
> - no its support is required and the 'msi-map' is not need anymore,
> - a new 'msi' interrupt is needed.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v6:
> - Fix make dt_binding_check and make CHECK_DTBS=y
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
>  .../bindings/pci/rockchip-dw-pcie-common.yaml | 59 +++++++++++++++----
>  .../bindings/pci/rockchip-dw-pcie.yaml        |  4 +-
>  2 files changed, 50 insertions(+), 13 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml: anyOf:1:then:properties:interrupt-names: {'type': 'array', 'items': [{'const': 'sys'}, {'const': 'pmc'}, {'const': 'msg'}, {'const': 'legacy'}, {'const': 'err'}, {'const': 'msi'}], 'minItems': 6, 'maxItems': 6} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml: anyOf:1:then:properties:interrupt-names: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'sys'}, {'const': 'pmc'}, {'const': 'msg'}, {'const': 'legacy'}, {'const': 'err'}, {'const': 'msi'}] is too long
	[{'const': 'sys'}, {'const': 'pmc'}, {'const': 'msg'}, {'const': 'legacy'}, {'const': 'err'}, {'const': 'msi'}] is too short
	False schema does not allow 6
	1 was expected
	6 is greater than the maximum of 2
	6 is greater than the maximum of 3
	6 is greater than the maximum of 4
	6 is greater than the maximum of 5
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.example.dtb: pcie-ep@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err', 'dma0', 'dma1', 'dma2', 'dma3'] is too long
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie-ep.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.example.dtb: pcie-ep@fe150000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie-ep.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250221104357.1514128-2-kever.yang@rock-chips.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


