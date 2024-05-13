Return-Path: <linux-pci+bounces-7435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ED58C4985
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 00:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E2E1F2139B
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 22:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC8B84A53;
	Mon, 13 May 2024 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqEHOgEc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C52C1A9;
	Mon, 13 May 2024 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715638365; cv=none; b=F5tPzp0XQCagnupLwNiZipNADnU87ZyrsDNrc4LYg8CRGllu1+PGLZ4pH4wypEjwIzt4DxCCW3hyRns2SjeWlo3MIzjA1sCT4qrWvrNdIKep5I2fJZ83rN9WLs5kGixVuklAlHrfU4VrhVjptTIBpQU8DCxI8fikFxJnoSuFkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715638365; c=relaxed/simple;
	bh=sA2GkAzui82ivR8UWlwQO0jUVrYnIPKmWlnjf5dHsTg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=rU4OtOwJhGykXowkzlYzGdGycprHND30zri35620UGGrlNUru7Hx1ogMzzTfJzeC4DdcrVS1p4Dy9xr0VjrCni1cmkpThn0ldarCIam0jaf5ynjMi5jATLhNSbU9Zc7Ti2NdbE+/hK1o0WWdoa8ddehXskQyo9W3bh1z9TVyDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqEHOgEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7FBC113CC;
	Mon, 13 May 2024 22:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715638364;
	bh=sA2GkAzui82ivR8UWlwQO0jUVrYnIPKmWlnjf5dHsTg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MqEHOgEcUb69CXqiQog9QH+6VVlTLgTEXv6JmxVuzbqPhcH+7kcWPwj4a+GjCq7na
	 cBButhe4Lpa/Re8mJHsScIwhnNcSIwJmCpTxScnyFZEsgmF1L4086aNbEoENXB7nwe
	 lgA50/jJmSZx/yo4hVGtVTAM03hE6st0QnXM41Ovtihj419lmDE0cW48Em6KvcA3/N
	 RlLdM/7Z/noQ/oP2PMTFAU82V8VbL1p6LvYO2UClv1MEdBecsP14XiRk62Fl84Ug6w
	 4g6UZz7gENVJohd0u68YAwkKOM3t/VZ+0Dd3u+wHHUcHlSslvKUkBvxv6/qJP3qSPK
	 PpoeHYYHyy9oQ==
Date: Mon, 13 May 2024 17:12:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
 lpieralisi@kernel.org, krzysztof.kozlowski+dt@linaro.org, kw@linux.com, 
 bhelgaas@google.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240513205913.313592-1-matthew.gerlach@linux.intel.com>
References: <20240513205913.313592-1-matthew.gerlach@linux.intel.com>
Message-Id: <171563836233.3319279.14962600621083837198.robh@kernel.org>
Subject: Re: [PATCH v5] dt-bindings: PCI: altera: Convert to YAML


On Mon, 13 May 2024 15:59:13 -0500, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Convert the device tree bindings for the Altera Root Port PCIe controller
> from text to YAML.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v5:
>  - add interrupt-conntroller #interrupt-cells to required field
>  - don't touch original example dts
> 
> v4:
>  - reorder reg-names to match original binding
>  - move reg and reg-names to top level with limits.
> 
> v3:
>  - Added years to copyright
>  - Correct order in file of allOf and unevaluatedProperties
>  - remove items: in compatible field
>  - fix reg and reg-names constraints
>  - replace deprecated pci-bus.yaml with pci-host-bridge.yaml
>  - fix entries in ranges property
>  - remove device_type from required
> 
> v2:
>  - Move allOf: to bottom of file, just like example-schema is showing
>  - add constraint for reg and reg-names
>  - remove unneeded device_type
>  - drop #address-cells and #size-cells
>  - change minItems to maxItems for interrupts:
>  - change msi-parent to just "msi-parent: true"
>  - cleaned up required:
>  - make subject consistent with other commits coverting to YAML
>  - s/overt/onvert/g
> ---
>  .../devicetree/bindings/pci/altera-pcie.txt   | 50 ----------
>  .../bindings/pci/altr,pcie-root-port.yaml     | 93 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/altr,pcie-root-port.example.dtb: pcie@c00000000: interrupt-map: [[0, 0, 0, 1, 2, 1, 0, 0, 0], [2, 2, 2, 0, 0, 0, 3, 2, 3], [0, 0, 0, 4, 2, 4]] is too short
	from schema $id: http://devicetree.org/schemas/altr,pcie-root-port.yaml#

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pci/altera-pcie.txt
MAINTAINERS: Documentation/devicetree/bindings/pci/altera-pcie.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240513205913.313592-1-matthew.gerlach@linux.intel.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


