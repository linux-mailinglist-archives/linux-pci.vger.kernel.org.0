Return-Path: <linux-pci+bounces-37197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E93BA93E8
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 14:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02549189F230
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 12:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD49F302CD6;
	Mon, 29 Sep 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjFJCBU/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18E42FAC12;
	Mon, 29 Sep 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759150474; cv=none; b=HaMX7h6DJ+1jNviMoeKyUyryt1cRAiM1ijZKFmotXm22ggfbeg4Sr3gNdQ9huipoRyK0SNjZSrJIdS0wcBtmLzIQApR6N/1cZrKLeGudQVu1v6pZw2+1JjfGFs02fVfQl9JuA8F5EQnFN5HVzjN1apGfwWka2nGuygFR775nlZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759150474; c=relaxed/simple;
	bh=P/BYUfk/mkzHib6TOHlBmvk32uOprykrIp5dMYZHmwc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=C9iTTU/MtytK3uj43wUMXe3xoyvh63+JkU/J9NpbxHlA/UL157inhihkGJoX6aiHrk1EpcR/5At4GYtAOqW369cos9ei5WutKJmV5EEzaibrf38Wc+nqISeX6CbsnR22dTfwFXH8lY+UCIIUojfeS60D7sSmeiVFYff4Ahfa/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjFJCBU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8BFC4CEF4;
	Mon, 29 Sep 2025 12:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759150474;
	bh=P/BYUfk/mkzHib6TOHlBmvk32uOprykrIp5dMYZHmwc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=rjFJCBU/Hz0ffTlTH+O4WgtWOn2phyXD9UHUaxOepC3ZxWMOgu5fPYJhKMHBfU8fl
	 OMnmxdK7d1npNHMOth1kdw9ZIn5QwpwJGxGlpLKWYk/sV8KS/IsLfSIvcnkU36J7Nh
	 CzyBYwGJpbRS+kgOcOVO1gDMc+sG/8yoHz2cwpybHe7E/KowWHSCzmEQHy3z1cPz1D
	 8a5tezd3JiTs0Rim9CYT5azieX6XBSUMk6JzGkuF+2SHMGPQ+h30Y5F8uMwqQRh1Kl
	 g2Ah/YioPPMnTzb6zGzke2xm0r6EPo+fvANlshwsKbnUG4UhBD/udVtvtmQCo8dhCb
	 uYGht/F5lj3oQ==
Date: Mon, 29 Sep 2025 07:54:33 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-pci@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ryder Lee <ryder.lee@mediatek.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250929113806.2484-4-ansuelsmth@gmail.com>
References: <20250929113806.2484-1-ansuelsmth@gmail.com>
 <20250929113806.2484-4-ansuelsmth@gmail.com>
Message-Id: <175915047324.3882585.17769722251535304485.robh@kernel.org>
Subject: Re: [PATCH v4 3/5] dt-bindings: PCI: mediatek: Add support for
 Airoha AN7583


On Mon, 29 Sep 2025 13:38:02 +0200, Christian Marangi wrote:
> Introduce Airoha AN7583 SoC compatible in mediatek PCIe controller
> binding.
> 
> Similar to GEN3, the Airoha AN7583 GEN2 PCIe controller require the
> PBUS csr property to permit the correct functionality of the PCIe
> controller.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/pci/mediatek-pcie.yaml           | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/mediatek-pcie.example.dtb: pcie@1fa92000 (airoha,an7583-pcie): Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/mediatek-pcie.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250929113806.2484-4-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


