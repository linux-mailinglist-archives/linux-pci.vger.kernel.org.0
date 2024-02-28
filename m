Return-Path: <linux-pci+bounces-4209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AE386B98E
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 22:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D62BB286A0
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EAA86258;
	Wed, 28 Feb 2024 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrkyTZJD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403986243;
	Wed, 28 Feb 2024 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154213; cv=none; b=kOzceupYRUVfznay/0AQSTQH2hC3M3RGi+r/t8yee27l0GoIbO7ZY48avuymqqgImKKfHCHc2YKSKaUwsrRnl0chkNlaScvbv1of46X11LMGJUvZdu8IZQbFMj8VEneTqk0HOR1DrG341Vf5KTvhhyc0NUUzl8FP1RYdcU8HHEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154213; c=relaxed/simple;
	bh=r43Y3ax8yrgzcuKb4kJ4hBtYQR5CvsR1h+DbExjvf5s=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=makgnyER+xVDBZ+cLRYSX7s7G2HAXJoeC5VOVFydRTtyoFZczsITiUDupsuKzIgwx+WoFtCdOBP/MXT1i4uwbaDqeQxYaZRRJYaR6rIJESuPJ5Erla0vrGRak0zPQJSQQQWZAyGsD1wX0VtTe9VbMCDvjxnCD+B09QiWd00IZfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrkyTZJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9180AC433F1;
	Wed, 28 Feb 2024 21:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709154212;
	bh=r43Y3ax8yrgzcuKb4kJ4hBtYQR5CvsR1h+DbExjvf5s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nrkyTZJD/wZ2TaRJLa66dUeQ5erWlrIcsaDeEntRTr2eD4V4N5UosTfofmYR4B6ZY
	 z88wW2R8mDP4XksWDKHZZHaA+m9bLPy/6huiy2Q9r1yaQ/Ps/lFIS0Lv3sfN5/rKyK
	 I+WGJOYuNpCMbGSaMvvMivdkJg9qvA/CA41qzTyPK4z3DD1HZaRnrrs4ZHFEW0P/4f
	 wvygV3s+sPhEPSgLAvhklKzb3N+z9f7LhQ0EdjJqgT2+Z4KaL32yXYN8U6+AfWp6xt
	 CU/Q4hT71OZNyqw1l8iCFJnWgYvDGXkwpxroLORJ6wPd9wDwP8gf97qDKTQj9lZl83
	 c+nCVq8Rrs54g==
Date: Wed, 28 Feb 2024 15:03:31 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev, conor@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, kw@linux.com, 
 linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
 linux-pci@vger.kernel.org, lpieralisi@kernel.org, helgaas@kernel.org, 
 bhelgaas@google.com, devicetree@vger.kernel.org
In-Reply-To: <20240228190321.580846-2-Frank.Li@nxp.com>
References: <20240228190321.580846-1-Frank.Li@nxp.com>
 <20240228190321.580846-2-Frank.Li@nxp.com>
Message-Id: <170915420970.759733.12998246565079147606.robh@kernel.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: pci: layerscape-pci: Convert to
 yaml format


On Wed, 28 Feb 2024 14:03:17 -0500, Frank Li wrote:
> Split layerscape-pci.txt into two yaml files: fsl,layerscape-pcie-ep.yaml
> and fsl,layerscape-pcie.yaml.
> yaml files contain the same content as the original txt file.
> 
> The subsequent commit will fix DTB_CHECK failure.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  89 +++++++++++++
>  .../bindings/pci/fsl,layerscape-pcie.yaml     | 123 ++++++++++++++++++
>  .../bindings/pci/layerscape-pci.txt           |  79 -----------
>  3 files changed, 212 insertions(+), 79 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.example.dtb: pcie@3400000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'iommu-map', 'msi-parent', 'ranges', 'reg-names' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.example.dtb: pcie@3400000: 'fsl,pcie-scfg' is a required property
	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.example.dtb: pcie@3400000: 'dma-coherence' is a required property
	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240228190321.580846-2-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


