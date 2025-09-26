Return-Path: <linux-pci+bounces-37094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0910EBA3C41
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 15:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1583AF947
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 13:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2946E2F5A0F;
	Fri, 26 Sep 2025 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXcK1nDI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19512512D7;
	Fri, 26 Sep 2025 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892190; cv=none; b=W2lVuqa2qd4ua1z3+Ty0D3gIaZxJRYUmnFP037SWIRa2aqLQt4l3BB556c3V5XWp28Of6AAnUt8maLt+YlCV7zRPckOPxZ34JjwWn98n+NlTQw5uMOGHrh5S2hTnDwieUbxl4phePhs2bA0h7LftkkcMnGG9BoEy2rihv2KX03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892190; c=relaxed/simple;
	bh=mwabqBGG6iWvuFZvZoI0mQPGdSAIVB5imUltnMh99k8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NhQqm+X9/z3AE+AAtlowoklkxjnR7cFeeZp9KOgDWTuExnUxi2/AbsEKJJEKi1vKnt7ecAg8NW4aDl9OaH1SYMeessDoa+GadEA+iCXojb/O3RWN0NaLIEHTrmiIF1lZIbRnOtJ35qhdJg/iKWxZuILcDloOOiJj8w9ZggUKLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXcK1nDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4EAC4CEF4;
	Fri, 26 Sep 2025 13:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758892189;
	bh=mwabqBGG6iWvuFZvZoI0mQPGdSAIVB5imUltnMh99k8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=KXcK1nDI5gb72U8fmIArJ4u6fgmjbXHQgW4d7jdB21V2HOosIgdJca9dXxb5ovUqB
	 vSB/f5oMqM2MkMgBH4u4f6J+MfTPiQ01bSIoWumjDXwIie7zKfxpiA6h7CCoLRoVXm
	 By1bPcC1Wvby+9xkjppyFL/zZsBffbGM/ev4PclVMzgv6FsmXodeP1xBdvNhWSzjOQ
	 w0Ino0XlmFt/ddQtpdXNLw+T+W7v01dIp6RnGjcPbAx40r/E1QKC1m6uAdNHoDs2ZG
	 ZxnvC2s1KzcEXWmkbMatm0AC0HrRxUACYK4Co6XIQ8HTvQL4Yaf9FQHv2rg8eL6RKh
	 i/wOqKQ+nHyFw==
Date: Fri, 26 Sep 2025 08:09:47 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, Jianjun Wang <jianjun.wang@mediatek.com>
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250925162332.9794-3-ansuelsmth@gmail.com>
References: <20250925162332.9794-1-ansuelsmth@gmail.com>
 <20250925162332.9794-3-ansuelsmth@gmail.com>
Message-Id: <175889218783.498491.9868084189301535953.robh@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: mediatek: Convert to YAML
 schema


On Thu, 25 Sep 2025 18:23:16 +0200, Christian Marangi wrote:
> Convert the PCI mediatek Documentation to YAML schema to enable
> validation of the supported GEN1/2 Mediatek PCIe controller.
> 
> While converting, lots of cleanup were done from the .txt with better
> specifying what is supported by the various PCIe controller variant and
> drop of redundant info that are part of the standard PCIe Host Bridge
> schema.
> 
> To reduce schema complexity the .txt is split in 2 YAML, one for
> mt7623/mt2701 and the other for every other compatible.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/pci/mediatek-pcie-mt7623.yaml    | 173 ++++++++
>  .../devicetree/bindings/pci/mediatek-pcie.txt | 289 -------------
>  .../bindings/pci/mediatek-pcie.yaml           | 404 ++++++++++++++++++
>  3 files changed, 577 insertions(+), 289 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.example.dtb: syscon@1a000000 (mediatek,mt7623-hifsys): compatible: 'oneOf' conditional failed, one must be fixed:
	['mediatek,mt7623-hifsys', 'mediatek,mt2701-hifsys', 'syscon'] is too long
	'mediatek,mt7623-hifsys' is not one of ['mediatek,mt2701-hifsys', 'mediatek,mt7622-hifsys']
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt2701-hifsys.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250925162332.9794-3-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


