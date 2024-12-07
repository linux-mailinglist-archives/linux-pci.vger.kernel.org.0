Return-Path: <linux-pci+bounces-17880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB37F9E8190
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 19:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9490281BE2
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 18:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2527F460;
	Sat,  7 Dec 2024 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xtwx+wvc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25991DFE1;
	Sat,  7 Dec 2024 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733596252; cv=none; b=lI7KGQWqvqmAVYIQRL6hFiOsiRZ8I/psSHvO25pGdzrTywa38sfktGRRP2nke4/7pu73738e3ZRpVgq8dIb3WZfKQuCy8XroPnaaW2JmYS1DwaEu/sZQEtd8rhL7ZeVlXgmm5034QN42vAUkEanacj5fmAtT/toWc8kEe5qxy7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733596252; c=relaxed/simple;
	bh=UcRUAoyevshtUTI50E53rSGPikA3EEs10vxHqbChKgU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jX9dhpO/FPrb1p8QOegSdSVezrhiPwhH8A7+0rDjMksEb3kY58slXd/0Y6RGSRM3udC4mq+JJYfLVFk4nPHXcf6TLnRIhaF/uNYYzDgNyCioPNvAKCWGfCHvmInfN+bj3+DX1nSqM/FRbsWZDqccTxCrJ7LKLRIcs3xWfxY0a7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xtwx+wvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513D5C4CECD;
	Sat,  7 Dec 2024 18:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733596251;
	bh=UcRUAoyevshtUTI50E53rSGPikA3EEs10vxHqbChKgU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Xtwx+wvcEfkSDsB7w38jsIVJ8034q3dz6Xv+MJdRSTMp+nbGsbeY6Vi+WOKIW7ivg
	 BQAyhOgStiP9AFRWAQrghBXq7QVWFlgn5BV40AYOoIrYccJFOcfhaKvt+TMLaroT2X
	 FLScwldlVLGdBgowN+uhr+bis7SdgjOxW8nLVf5SeALp1AHygOm8tW6Z3S5Wt5QCVy
	 YmTISiFUbqyfVs66wPFVWRdjdp3gg74hPc6CpPVr7rvtPIS0M+gkd+U1adMYnR/IZF
	 DDRWlhe3b8LrfbN/uAExukRmvVZl4SSeP4AEy1I/hUaCb5WeeBgByH1YNXdK/Oq0VP
	 ULj/PEIVZ6KQw==
Date: Sat, 07 Dec 2024 12:30:49 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 michal.simek@amd.com, kw@linux.com, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, 
 bharat.kumar.gogada@amd.com, lpieralisi@kernel.org, bhelgaas@google.com, 
 manivannan.sadhasivam@linaro.org
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
In-Reply-To: <20241207171134.3253027-2-thippeswamy.havalige@amd.com>
References: <20241207171134.3253027-1-thippeswamy.havalige@amd.com>
 <20241207171134.3253027-2-thippeswamy.havalige@amd.com>
Message-Id: <173359624889.3074557.9170426259183871962.robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr
 support


On Sat, 07 Dec 2024 22:41:32 +0530, Thippeswamy Havalige wrote:
> Add support for mdb slcr aperture that is only supported for AMD Versal2
> devices.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Changes in v4:
> --------------
> Change enum to const.
> 
> Changes in v3:
> -------------
> - Introduced below changes in dwc yaml schema.
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml: properties:reg-names:items: 'oneOf' conditional failed, one must be fixed:
	{'oneOf': [{'description': 'Basic DWC PCIe controller configuration-space accessible over the DBI interface. This memory space is either activated with CDM/ELBI = 0 and CS2 = 0 or is a contiguous memory region with all spaces. Note iATU/eDMA CSRs are indirectly accessible via the PL viewports on the DWC PCIe controllers older than v4.80a.', 'const': 'dbi'}, {'description': "Shadow DWC PCIe config-space registers. This space is selected by setting CDM/ELBI = 0 and CS2 = 1. This is an intermix of the PCI-SIG PCIe CFG-space with the shadow registers for some PCI Header space, PCI Standard and Extended Structures. It's mainly relevant for the end-point controller configuration, but still there are some shadow registers available for the Root Port mode too.", 'const': 'dbi2'}, {'description': "External Local Bus registers. It's an application-dependent registers normally defined by the platform engineers. The space can be selected by setting CDM/ELBI = 1 and CS2 = 0 wires or can be acces
 sed over some platform-specific means (for instance as a part of a system controller).", 'enum': ['elbi', 'app']}, {'description': "iATU/eDMA registers common for all device functions. It's an unrolled memory space with the internal Address Translation Unit and Enhanced DMA, which is selected by setting CDM/ELBI = 1 and CS2 = 1. For IP-core releases prior v4.80a, these registers have been programmed via an indirect addressing scheme using a set of viewport CSRs mapped into the PL space. Note iATU is normally mapped to the 0x0 address of this region, while eDMA is available at 0x80000 base address.", 'const': 'atu'}, {'description': 'Platform-specific eDMA registers. Some platforms may have eDMA CSRs mapped in a non-standard base address. The registers offset can be changed or the MS/LS-bits of the address can be attached in an additional RTL block before the MEM-IO transactions reach the DW PCIe slave interface.', 'const': 'dma'}, {'description': 'PHY/PCS configuration registers. So
 me platforms can have the PCS and PHY CSRs accessible over a dedicated memory mapped region, but mainly these registers are indirectly accessible either by means of the embedded PHY viewport schema or by some platform-specific method.', 'const': 'phy'}, {'description': 'Outbound iATU-capable memory-region which will be used to access the peripheral PCIe devices configuration space.', 'const': 'config'}, {'description': 'Vendor-specific CSR names. Consider using the generic names above for new bindings.', 'oneOf': [{'description': "See native 'elbi/app' CSR region for details.", 'enum': ['apb', 'mgmt', 'link', 'ulreg', 'appl']}, {'description': "See native 'atu' CSR region for details.", 'enum': ['atu_dma']}, {'description': 'Syscon-related CSR regions.', 'enum': ['smu', 'mpu']}, {'description': 'Tegra234 aperture', 'enum': ['ecam']}, {'description': 'AMD MDB PCIe slcr region', 'const': ['mdb_pcie_slcr']}]}]} is not of type 'array'
	['mdb_pcie_slcr'] is not of type 'integer', 'string'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml: properties:reg-names:items:oneOf:7:oneOf:4:const: ['mdb_pcie_slcr'] is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241207171134.3253027-2-thippeswamy.havalige@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


