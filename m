Return-Path: <linux-pci+bounces-36600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E40EB8D203
	for <lists+linux-pci@lfdr.de>; Sun, 21 Sep 2025 00:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C175C7ADE67
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 22:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B66621FF24;
	Sat, 20 Sep 2025 22:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2VD451v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6661E491B;
	Sat, 20 Sep 2025 22:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758408121; cv=none; b=mu++fLPFkC5+bzEzKxRLHJW0IyKYkBHlnKNkUvoZWTJY5UCvckF8i03POTUpQs/mZUPIO3b1GACK1wpbWdpAPBlM6+Wuf1N9Yoh4l4BpJVoRG6gMxrozp8T0QpYTvSM2cGs28WSKJ2C5oRPU2sNl0HRhcjLWhqdXCmW8y4Hb2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758408121; c=relaxed/simple;
	bh=Dt8VKsI0bzzPWavc0PQi4CMaYsaPhVChPxt1pBUrkF4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ln87ulYu587Cma4jdPH6OrspFJnLaPyGcPOhiYl0vXm9zJOb5lKnEnfjyVKwXxVC8iwOnMVZkJySOf4W+9JXIT+FrheWa88KSVgNnCnkhTZNLqEc6sUN8Lx+7YEzhiuFrmQmUkiFZzRos5WWzKjQLEWo+816hjWdWUblEJ+niXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2VD451v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDD5C4CEEB;
	Sat, 20 Sep 2025 22:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758408121;
	bh=Dt8VKsI0bzzPWavc0PQi4CMaYsaPhVChPxt1pBUrkF4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=O2VD451vT9HNTTN9Ot+gYm+T7u5XS4TeGU3KNlq3MyYzbPc/WfKyJ5YsAal0YSqZa
	 xVtREVHKDSzLplyY10SBSdmsSkd8v5ip1Co82UnaMPTaNqgxCQbGA18E8DeWVBE2Zo
	 SPYF0+SvJAmBHV64T2e37DNfLhT5tv8ICq0uLqr/KChDAFAk3cxcyoFYaBYj8TEvYu
	 tFnngljlcAoDTqs1yknnMrQY7rGzRV3q8ZPQ4pR3BcK5CAvsPT0GYyQPXbCNhMKRpw
	 GIQRLcZwMYeIxTY63zUOhMNQchRVFai5QcRRjKXe54mpAmHWTldY9qzCM9oUtlMk28
	 Pmn+JiZra4uYA==
Date: Sat, 20 Sep 2025 17:41:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jianjun Wang <jianjun.wang@mediatek.com>, 
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250920114103.16964-1-ansuelsmth@gmail.com>
References: <20250920114103.16964-1-ansuelsmth@gmail.com>
Message-Id: <175838993594.10832.1517003373145392481.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: mediatek: Convert to YAML schema


On Sat, 20 Sep 2025 13:41:01 +0200, Christian Marangi wrote:
> Convert the PCI mediatek Documentation to YAML schema to enable
> validation of the supported GEN1/2 Mediatek PCIe controller.
> 
> While converting, lots of cleanup were done from the .txt with better
> specifying what is supported by the various PCIe controller variant and
> drop of redundant info that are part of the standard PCIe Host Bridge
> schema.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/pci/mediatek-pcie.txt | 289 ---------
>  .../bindings/pci/mediatek-pcie.yaml           | 564 ++++++++++++++++++
>  2 files changed, 564 insertions(+), 289 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek-pcie.example.dtb: syscon@1a000000 (mediatek,mt7623-hifsys): compatible: 'oneOf' conditional failed, one must be fixed:
	['mediatek,mt7623-hifsys', 'mediatek,mt2701-hifsys', 'syscon'] is too long
	'mediatek,mt7623-hifsys' is not one of ['mediatek,mt2701-hifsys', 'mediatek,mt7622-hifsys']
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt2701-hifsys.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek-pcie.example.dtb: pcie@0,0: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek-pcie.example.dtb: pcie@1,0: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek-pcie.example.dtb: pcie@2,0: 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250920114103.16964-1-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


