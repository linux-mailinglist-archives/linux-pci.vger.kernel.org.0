Return-Path: <linux-pci+bounces-2565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9075483D2CD
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 04:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C43F285271
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 03:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2608F77;
	Fri, 26 Jan 2024 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMDCEg4a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE08CA47;
	Fri, 26 Jan 2024 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706238141; cv=none; b=et98Fc9BvCeqO0/UnP/fqLrz2Y9d+ws8fPtpzhaQutMqL0zlilFDQljJ7JQgeYfJWsP04ma0koAWsTGuUvnHUSR556x69Kx/qTKI5kO8ATUcfl8wmGGfnv8191am2Ft3Th7Y6A44ams1sMwrdYAz5XRdegPBNyOQX+yLjcwxdrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706238141; c=relaxed/simple;
	bh=r9G4OZgWE+kQAAnHVLTuQu4pUWRCO754y65LPOoZ4ZA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=cOKACpDRODs4o5hBrdQk1vxbx0NnBOsxPyt52gQJ4PA+FQ4AX+Prk5DrpD955FPjrBN6Q0G1rwtOSteaCWMXWy+weAoofiiAN6krSY16letxeeBpbijQebz1ixaMHHYZRA6E1JNJBH8DswCFsk9s8proPVtWJpNGDSL3ETNyeAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMDCEg4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AC0C433C7;
	Fri, 26 Jan 2024 03:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706238141;
	bh=r9G4OZgWE+kQAAnHVLTuQu4pUWRCO754y65LPOoZ4ZA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rMDCEg4a0T5ikq4vs10UbosLswFsGBZVAPtEQiFCByn2lKVPohK+KBrEj2j7LrgT9
	 rb/W8jL9N284WcB206GsNjrvJA0nPbLgXNrEyqvFxF/gmSZZzuaD5U1MaYn16ElSo/
	 kjfllcvZ6v+9ArYm+g32UrVpC/eXeqyr/w5HzsRNKbGPC49Fx73e/Fcs59C+Cq+5YC
	 ph80YBjwLFF1MEeF6oT0LIZF3QXjXGCEIGlQdK8CHMb5ed/4sFiSMKbifIOVT4A20P
	 nxbuDuXb7JjbHc7bUkXi9fGX+LTciyHz7cvzmJMpB+mMiCey8P2kv52wX0IBHPXoz+
	 eBfn5RE8Yvamg==
Date: Thu, 25 Jan 2024 21:02:19 -0600
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
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240125-dt-bindings-pci-qcom-split-v2-2-6b58efd91a7a@linaro.org>
References: <20240125-dt-bindings-pci-qcom-split-v2-0-6b58efd91a7a@linaro.org>
 <20240125-dt-bindings-pci-qcom-split-v2-2-6b58efd91a7a@linaro.org>
Message-Id: <170623813219.6729.5150130088127136653.robh@kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: PCI: qcom,pcie-sm8450: move SM8450
 to dedicated schema


On Thu, 25 Jan 2024 14:03:25 +0100, Krzysztof Kozlowski wrote:
> Move SM8450 PCIe devices from qcom,pcie.yaml binding to a dedicated file
> to make reviewing easier.
> 
> This creates equivalent schema file, except:
>  - Missing required compatible which is actually redundant.
>  - Expecting eight MSI interrupts, instead of only one, which was
>    incomplete hardware description.
> 
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  | 175 +++++++++++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie.yaml         |  67 --------
>  2 files changed, 175 insertions(+), 67 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.example.dtb: pcie@1c00000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'iommu-map', 'linux,pci-domain', 'max-link-speed', 'msi-map', 'msi-map-mask', 'num-lanes', 'perst-gpios', 'phy-names', 'phys', 'power-domains', 'ranges', 'wake-gpios' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sm8450.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240125-dt-bindings-pci-qcom-split-v2-2-6b58efd91a7a@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


