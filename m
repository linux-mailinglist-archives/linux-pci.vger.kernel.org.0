Return-Path: <linux-pci+bounces-33634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F21B1E92F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 15:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF6D3B0C82
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4843A27E05B;
	Fri,  8 Aug 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTwrI4HN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E527C84B;
	Fri,  8 Aug 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754659742; cv=none; b=mrvRNPrYElmMnT8VBgs8jFktzZWCiwRBpM0iucjN7qMuvKR7Tm0fNRMQlf2ZPRENaJRrKrb+ctiJzN3OVmibAa6s2KC6QaPE9yoqj0JIDx0P//ebWGlA0ylK8a1bprKFo5Ir5Ly4WQfOttgf+dRtdPF+3vMj6RQwgejTU2TIvWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754659742; c=relaxed/simple;
	bh=hfPJSMtqw2tJZNaG7y3abjrWTa3qv4AxzlReGYo3tdI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Plo3nR9dNxliP6F1W9aVyicSaKb8zt6zUrJ6k+qqdefu6t//lXxyLWicwrqJwb9IaI3DYai85v0ugMhk3pSQgSSXKwzzRWfQrDFaag/dbwlFvXdH1uuOK8e8daV+8kG7lmk4id/w1DPkrvQhmG/t3afFL4lap27CvLOtITF+oLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTwrI4HN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13A9C4CEF4;
	Fri,  8 Aug 2025 13:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754659741;
	bh=hfPJSMtqw2tJZNaG7y3abjrWTa3qv4AxzlReGYo3tdI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=rTwrI4HNFH+ORRfvJkxPZUl8sVqUnI8MuBDcRe/5FTsex5noMpYTVlUbneeWavA3U
	 YxmZg15UPZVl/rXG3AFI/eVI1LyyxBXft4hgLLJXHU0JVqmf70N3c98asGxwC0ItLq
	 oKyZKxPrxrVwwTJQ/cRnHmUND1UG4T30UNDDVkpHdS0bJitWQ2e2HQqScZXgOoZFmM
	 dOUA3xr6CTZ6jgd/rwQ2i0E/uoqRe8SrYK9jE9AGt5j59VaLqooYnKQiy4BG4KoJLL
	 GDLMzTfUhCpC2Wl4JQ13pqad0Zx7yi8dRtJnl0yktd7JeNwmRpbUb6z4ZgEa476Gcf
	 GUvEzUEiYFnSQ==
Date: Fri, 08 Aug 2025 08:28:59 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, guoyin.chen@cixtech.com, 
 krzk+dt@kernel.org, cix-kernel-upstream@cixtech.com, conor+dt@kernel.org, 
 mani@kernel.org, linux-pci@vger.kernel.org, peter.chen@cixtech.com, 
 devicetree@vger.kernel.org, mpillai@cadence.com, 
 linux-kernel@vger.kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
 fugang.duan@cixtech.com
To: hans.zhang@cixtech.com
In-Reply-To: <20250808072929.4090694-8-hans.zhang@cixtech.com>
References: <20250808072929.4090694-1-hans.zhang@cixtech.com>
 <20250808072929.4090694-8-hans.zhang@cixtech.com>
Message-Id: <175465973854.5889.2255011303498628193.robh@kernel.org>
Subject: Re: [PATCH v6 07/12] dt-bindings: PCI: Add CIX Sky1 PCIe Root
 Complex bindings


On Fri, 08 Aug 2025 15:29:24 +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Document the bindings for CIX Sky1 PCIe Controller configured in
> root complex mode with five root port.
> 
> Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>  .../bindings/pci/cix,sky1-pcie-host.yaml      | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml: properties:compatible:oneOf: [{'const': 'cix,sky1-pcie-host'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dts:27.13-29.83: Warning (ranges_format): /example-0/pcie@a010000:ranges: "ranges" property has invalid length (84 bytes) (parent #address-cells == 1, child #address-cells == 3, #size-cells == 2)
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: pcie@a010000 (cix,sky1-pcie-host): ranges: 'oneOf' conditional failed, one must be fixed:
	[[16777216, 0, 1611661312, 0, 1611661312, 0], [1048576, 33554432, 0, 1612709888, 0, 1612709888], [0, 534773760, 1124073472, 24, 0, 24], [0, 4, 0]] is not of type 'boolean'
	1048576 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
	0 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
	[0, 4, 0] is too short
	from schema $id: http://devicetree.org/schemas/pci/cix,sky1-pcie-host.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: pcie@a010000 (cix,sky1-pcie-host): reg: [[0, 167837696], [0, 65536], [0, 738197504], [0, 67108864], [0, 167772160], [0, 65536], [0, 1610612736], [0, 1048576]] is too long
	from schema $id: http://devicetree.org/schemas/pci/cix,sky1-pcie-host.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: pcie@a010000 (cix,sky1-pcie-host): Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'msi-map', 'ranges', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/cix,sky1-pcie-host.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.example.dtb: pcie@a010000 (cix,sky1-pcie-host): ranges: 'oneOf' conditional failed, one must be fixed:
	[[16777216, 0, 1611661312, 0, 1611661312, 0], [1048576, 33554432, 0, 1612709888, 0, 1612709888], [0, 534773760, 1124073472, 24, 0, 24], [0, 4, 0]] is not of type 'boolean'
	1048576 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
	0 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
	[0, 4, 0] is too short
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250808072929.4090694-8-hans.zhang@cixtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


