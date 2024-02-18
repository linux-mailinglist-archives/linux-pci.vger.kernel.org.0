Return-Path: <linux-pci+bounces-3688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523838596AF
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 12:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37CE283254
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E48863123;
	Sun, 18 Feb 2024 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXqmIxBc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108BA4F1E4;
	Sun, 18 Feb 2024 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708256307; cv=none; b=DGAICXhdQLkI/H+ZdB6EPo8XCgDQMt2LWTJkBjKxhPV9soStrWoJoU0pF5P/1/X4FXxkKmFla9pslQAulLB5ayy46rrSXpiHTT/zlYw0GDPrdMP9L8k9FY/aiIICZMM8CcnL0mcpjfAhky4zy1bWSFHKw/SlX6VS8r8zurVRqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708256307; c=relaxed/simple;
	bh=Yu8h4JGO4tvWj2cYo3vHd57h7Iq/HmaQfzIqjJHJ2oQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=CF2wgx0aTEReHZW7hf2nX/NFHK49G5U0Msa1YEVQuxy1WTk21trFzJJSkOGQ/VPEJWtbXgbt0k4vM/ZECEbubTXNp3SdnM3zbpy33UiiFUXhl9SzEdNbAmQOXsG9ZKuxy0P/yxfuNLLbwd9lb3zcIVer70apz7cmcXdJpb9TyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXqmIxBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BEAC433F1;
	Sun, 18 Feb 2024 11:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708256306;
	bh=Yu8h4JGO4tvWj2cYo3vHd57h7Iq/HmaQfzIqjJHJ2oQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mXqmIxBcOQLoCwpK3mPZA9iiIi38UIfAumw9D0uLF0iadMUxVbum01FiY+x5QZbkn
	 E0u6/3gujGnMb0Unw1MLSRjy++Kb53T0suYolS6N38BXY4V062S843jbZ+kPVswi+f
	 LXMOLKIy4wpqBov1yz0S93xPhVf84x1Mc61VTHhFO9zCZm+YSuVdIZoW5aoz1mmNiM
	 b50Jxx9+HI4jv0zx9pQ2pRCLmDT/4zTRkMWfHYeT81rSAD+TU1mtuoDOrWgi5SsBqd
	 H6NbjOtRNqc0SAg7aC8T6X3NU9t1SiznflfpyS1Kw3h9HJ8ScTx5tcZMu7qf2qH9Ta
	 U4dQfBbmum3AQ==
Date: Sun, 18 Feb 2024 05:38:25 -0600
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
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-riscv@lists.infradead.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kevin Xie <kevin.xie@starfivetech.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, linux-pci@vger.kernel.org, 
 Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Mason Huo <mason.huo@starfivetech.com>, Conor Dooley <conor@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20240218101921.113528-4-minda.chen@starfivetech.com>
References: <20240218101921.113528-1-minda.chen@starfivetech.com>
 <20240218101921.113528-4-minda.chen@starfivetech.com>
Message-Id: <170825630433.819611.4605889577951919175.robh@kernel.org>
Subject: Re: [PATCH v15 19/23] dt-bindings: PCI: Add StarFive JH7110 PCIe
 controller


On Sun, 18 Feb 2024 18:19:17 +0800, Minda Chen wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240218101921.113528-4-minda.chen@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


