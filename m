Return-Path: <linux-pci+bounces-37830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671B4BCE677
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 21:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4E719A845F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 19:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9F330149E;
	Fri, 10 Oct 2025 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb57EscF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07824EA90;
	Fri, 10 Oct 2025 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124805; cv=none; b=Ev0tToou5JPNG8hCDrvxCOzeB4tIJgEh/a23M9MASeXKNRGWj4hWkhBV7MEHB4ieO/5xW77e1hfWnBUQPRkfLA+hPo73yaOTsexCWLWm6RWHTk445ilzNh6dnm6XEbNm9LyIbD6bHiDqq+9p6b21EOGAs9VcBuKqewCDp5rNoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124805; c=relaxed/simple;
	bh=eABqgzuatD7PalQ8vLZDv079rCz+8GRnm4epSDSasiE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=FG+LDcAHuirxXyM9sSXcctx2WrUsCqx/86Jx0EpiyCia4VoRfu3wz/KQvXcE3jQj2FnhJAkRauNh3Vtv5TtjF7iSfMcEI84dymC1XOTaz0EHcNUw5mULSWtV+k240w1NBckJt6afPJ/wg8KVxHZs2DDwh3Mj/+dWyD9WTmRNj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb57EscF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CFEC4CEF1;
	Fri, 10 Oct 2025 19:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760124805;
	bh=eABqgzuatD7PalQ8vLZDv079rCz+8GRnm4epSDSasiE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Eb57EscFOJiZ1PG2TyfESS43A5sXWtNT+poo+OI6AERp75jWz/d8SfuPVi60lWbme
	 ysS6Wsbm8xuXyNGcqPAMN7kZXUj/418pwXFXhNa4yO77uIQT/8p9hVd1mKpvvnICPe
	 oWqcEZ2aOEwcmiPcrSzpGDRIijroQg2Hyb/1iCDfPKlMYzTxIN/9jDMVyxNL4cRLqJ
	 sl6X6e2ZvJFLigj8i9Y+zTrv0jP4yF/PRaOWNYDR2a25LsoAlHDiZfBelK9EM5LyYL
	 LuWFJMwHc6N4jdSqZ+H3JjJOq+jJjPF2eE+9VZZrxtASkvoN42Vz91swIvrVBdBZDt
	 9y/XFvu5QoKxg==
Date: Fri, 10 Oct 2025 14:33:23 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
In-Reply-To: <20251010-pci-binding-v1-2-947c004b5699@oss.qualcomm.com>
References: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
 <20251010-pci-binding-v1-2-947c004b5699@oss.qualcomm.com>
Message-Id: <176012477191.896715.1769779927734963381.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: PCI: qcom: Enforce check for PHY,
 PERST# and WAKE# properties


On Fri, 10 Oct 2025 11:25:48 -0700, Manivannan Sadhasivam wrote:
> Currently, the binding supports specifying the PHY, PERST#, WAKE#
> properties in two ways:
> 
> 1. Controller node (deprecated)
> 	- phys
> 	- perst-gpios
> 	- wake-gpios
> 
> 2. Root Port node
> 	- phys
> 	- reset-gpios
> 	- wake-gpios
> 
> But there is no check to make sure that the both variants are not mixed.
> For instance, if the Controller node specifies 'phys', 'reset-gpios',
> 'wake-gpios' or if the Root Port node specifies 'phys', 'perst-gpios',
> 'wake-gpios', then the driver will fail as reported. Hence, enforce the
> check in the binding to catch these issues.
> 
> It is also possible that DTs could have 'phys' property in Controller node
> and 'reset-gpios/wake-gpios' properties in the Root Port node. It will also
> be a problem, but it is not possible to catch these cross-node issues in
> the binding.
> 
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Closes: https://lore.kernel.org/linux-pci/8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-common.yaml    | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.example.dtb: pcie@1c00000 (qcom,pcie-sc8180x): 'oneOf' conditional failed, one must be fixed:
	'perst-gpios' is a required property
	'wake-gpios' is a required property
	False schema does not allow [[4294967295]]
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sc8180x.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.example.dtb: pcie@1c00000 (qcom,pcie-sc8180x): Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'dma-coherent', 'interconnect-names', 'interconnects', 'interrupt-map', 'interrupt-map-mask', 'iommu-map', 'linux,pci-domain', 'num-lanes', 'phy-names', 'phys', 'power-domains', 'ranges' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sc8180x.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.example.dtb: pcie@1c08000 (qcom,pcie-sc7280): pcie@0: 'oneOf' conditional failed, one must be fixed:
	'wake-gpios' is a required property
	False schema does not allow [[4294967295]]
	False schema does not allow [[4294967295, 2, 1]]
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sc7280.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.example.dtb: pcie@1c08000 (qcom,pcie-sc7280): Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'dma-coherent', 'interrupt-map', 'interrupt-map-mask', 'iommu-map', 'linux,pci-domain', 'num-lanes', 'pcie@0', 'power-domains', 'ranges', 'vddpe-3v3-supply' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sc7280.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251010-pci-binding-v1-2-947c004b5699@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


