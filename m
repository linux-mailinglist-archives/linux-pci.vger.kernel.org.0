Return-Path: <linux-pci+bounces-31050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D909AED3EB
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 07:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C3D3B2C39
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 05:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8BE1A23A5;
	Mon, 30 Jun 2025 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwkW6ylx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0CC1EB5B;
	Mon, 30 Jun 2025 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751261818; cv=none; b=INLDup2Y6bzmt2/p4C2/FW8KDkERiKebopHOLHF9IGlKHvRx9r9shdh+VPyDvM9xVN4SuaHZOCSLVZA7lZboULFms+AP4GjP5iisNvfxnRHtYJuiLCLvQCeiRLFb2Y3sSNfFMqW/MyIN9PitHNb4PL9N9czeir3DXWYjex/qHXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751261818; c=relaxed/simple;
	bh=YjChSVKYFT8affKGS4Ws6DzxVEVZ031Y5oU6hWwkaNY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NYzPDqM34afq1bIYluhReBsQpwc9hGmA3AsRSxp4i9SGbMaME7IoT/faPrn7SBwjoLMqDIzY+fwc90XL0tnpv7LciAQfMm6W12xFCN1dc2HDr1JqOzOPkrXjH4LfCwqToky2QySmX1xJXQmImkHHygQQVBJB3oUFGWrCZi7sCRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwkW6ylx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3E7C4CEE3;
	Mon, 30 Jun 2025 05:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751261818;
	bh=YjChSVKYFT8affKGS4Ws6DzxVEVZ031Y5oU6hWwkaNY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=XwkW6ylxT4O07Ffmn/mmUQdTFmFvt1FNBnrYEnoFVWleD8lOK6HD/OE8WOhMcSsKP
	 UwQ3aNVSy97gTjYtxSw3icCAsLzsK90H31QcKU/YinAKpuRjGhZKOrJb4bHX53mTHV
	 SodskMCsHloYeOODfabKO05XG7undMLCkuuLLJypmTFpyN7yZvDL82Nq/3T4qbfuqw
	 GAvDHIL7U5E+XcVJvPBsPOIaFMjTG2dVXAZXKvXyd7y0SU1tMHmo4YqZt5n8cOlynz
	 fh5Hh03USlPUH4up4RpnAiSvuSYIqOdORtApJwZImgw0GSIB9O9FFji2QP+ert/zFd
	 mfFH2WkRaD96Q==
Date: Mon, 30 Jun 2025 00:36:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, kw@linux.com, mpillai@cadence.com, 
 lpieralisi@kernel.org, krzk+dt@kernel.org, fugang.duan@cixtech.com, 
 kwilczynski@kernel.org, linux-pci@vger.kernel.org, mani@kernel.org, 
 guoyin.chen@cixtech.com, bhelgaas@google.com, devicetree@vger.kernel.org, 
 conor+dt@kernel.org, cix-kernel-upstream@cixtech.com, 
 peter.chen@cixtech.com
To: hans.zhang@cixtech.com
In-Reply-To: <20250630041601.399921-11-hans.zhang@cixtech.com>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-11-hans.zhang@cixtech.com>
Message-Id: <175126181720.1510160.1051786130000478053.robh@kernel.org>
Subject: Re: [PATCH v5 10/14] dt-bindings: PCI: Add CIX Sky1 PCIe Root
 Complex bindings


On Mon, 30 Jun 2025 12:15:57 +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Document the bindings for CIX Sky1 PCIe Controller configured in
> root complex mode with five root port.
> 
> Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>
> ---
>  .../bindings/pci/cix,sky1-pcie-host.yaml      | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml: properties:compatible:oneOf: [{'const': 'cix,sky1-pcie-host'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
Error: Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dts:29.47-48 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250630041601.399921-11-hans.zhang@cixtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


