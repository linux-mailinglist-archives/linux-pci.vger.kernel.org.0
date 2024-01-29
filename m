Return-Path: <linux-pci+bounces-2740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF97284157E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 23:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F361F23AD3
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 22:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9C015956E;
	Mon, 29 Jan 2024 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioTaToqJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D3433C8;
	Mon, 29 Jan 2024 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566874; cv=none; b=Hh4AkTd2POU1CZLnVoqcg49ZO6muqjhCFV1iEIZcwXCoCHiiG97KxyfiBqfYH1nt4Zd9m8EfjADpOu3n8A4tBYuUrPj/TWyNhRLonghtGYvSfnNn5DIrbfyIO6TA4ENvb1b/JSSwgJerpcsnBhX3ALnDhuz/XmVKf5MgGItU0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566874; c=relaxed/simple;
	bh=HPUoP6eW0UIad8w+O0F0hkehgUlt/2XjPLLSrb9Sz/s=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qZ6e1LN4LP4AKfNPLHQ/SAv2QXDPX2hKwlEeC/V/DfdH1JPjA6RDjYOR/smFqO9zfs8SrcXYiKyLwmWJIR2pWCUWXOGPNozbmDpR6owaJ/R4jjxeXMs+6y0aix+cMEKzfBK8nkdXjZ4vXknDZAmNoWxxXJAoJKMh3lMyjm06tLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioTaToqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D415BC433F1;
	Mon, 29 Jan 2024 22:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706566874;
	bh=HPUoP6eW0UIad8w+O0F0hkehgUlt/2XjPLLSrb9Sz/s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ioTaToqJpsbXqfc8N3OnyUxt/4NvmFgDBQVEAi8DoZvPAZTa2Ce6GJ+iefQvXvLUu
	 qBAirrsMSlaD+b5bzden4b+b1EEyqXq0NIPswLcAUlRpKhQgmPNWKDte72r5Atn0Eu
	 PfDZcijwXm7mYODqBHNqizbuTrNVxwJQloOnm3naJXLHPOHsPOEVZVJeyuNNWmOY1B
	 ZjOBlDD3cj+/JDMdCvk4D4pfBvksMlvyGr1Fabpb68AZ2HLVnqMEecL1gdzlYUBRfS
	 HyXbk7AFwPnOT4R01w7kdLiD2bzmr/T2z6YaCObsRBqURBhJtx6EbL64TN2bfYW24s
	 5XuvOEPBBsLrg==
Date: Mon, 29 Jan 2024 16:21:12 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Kevin Xie <kevin.xie@starfivetech.com>, 
 Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-pci@vger.kernel.org, Daire McNamara <daire.mcnamara@microchip.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
 Mason Huo <mason.huo@starfivetech.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Conor Dooley <conor@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
In-Reply-To: <20240129010142.3732-4-minda.chen@starfivetech.com>
References: <20240129010142.3732-1-minda.chen@starfivetech.com>
 <20240129010142.3732-4-minda.chen@starfivetech.com>
Message-Id: <170656679886.3057.12378312489853176077.robh@kernel.org>
Subject: Re: [PATCH v14,RESEND 19/22] dt-bindings: PCI: Add StarFive JH7110
 PCIe controller


On Mon, 29 Jan 2024 09:01:39 +0800, Minda Chen wrote:
> Add StarFive JH7110 SoC PCIe controller dt-bindings. JH7110 using PLDA
> XpressRICH PCIe host controller IP.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/pci/plda,xpressrich3-axi-common.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.example.dtb: pcie@940000000: False schema does not allow {'compatible': ['starfive,jh7110-pcie'], 'reg': [[9, 1073741824, 0, 268435456], [0, 721420288, 0, 16777216]], 'reg-names': ['cfg', 'apb'], '#address-cells': [[3]], '#size-cells': [[2]], '#interrupt-cells': [[1]], 'device_type': ['pci'], 'ranges': [[2181038080, 0, 805306368, 0, 805306368, 0, 134217728], [3271557120, 9, 0, 9, 0, 0, 1073741824]], 'starfive,stg-syscon': [[4294967295]], 'bus-range': [[0, 255]], 'interrupts': [[56]], 'interrupt-map-mask': [[0, 0, 0, 7]], 'interrupt-map': [[0, 0, 0, 1, 2, 1], [0, 0, 0, 2, 2, 2], [0, 0, 0, 3, 2, 3], [0, 0, 0, 4, 2, 4]], 'msi-controller': True, 'clocks': [[4294967295, 86], [4294967295, 10], [4294967295, 8], [4294967295, 9]], 'clock-names': ['noc', 'tl', 'axi_mst0', 'apb'], 'resets': [[4294967295, 11], [4294967295, 12], [4294967295, 13], [4294967295, 14], [4294967295, 15], [4294967295, 16]], 
 'perst-gpios': [[4294967295, 26, 1]], 'phys': [[4294967295]], 'interrupt-controller': {'#address-cells': [[0]], '#interrupt-cells': [[1]], 'interrupt-controller': True, 'phandle': [[2]]}, '$nodename': ['pcie@940000000']}
	from schema $id: http://devicetree.org/schemas/pci/starfive,jh7110-pcie.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.example.dtb: pcie@940000000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-controller', 'interrupt-map', 'interrupt-map-mask', 'interrupts', 'msi-controller', 'ranges', 'reg', 'reg-names' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/starfive,jh7110-pcie.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240129010142.3732-4-minda.chen@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


