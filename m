Return-Path: <linux-pci+bounces-4210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217E286B990
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 22:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A6F28CB9F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 21:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077B18627B;
	Wed, 28 Feb 2024 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6iUtNUz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA733FBA7;
	Wed, 28 Feb 2024 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154215; cv=none; b=PSe0vsVlk/kXsHpa9CyoQZXvsRkFxjwjtYHrvOV9ryTXVqUh/BxucriYdvqiXtBguiWZYYyaEDpsnpbZXypsEylRbGh8GuQ7Q5HXo+PlKFfT5pJQ5UFJOiQ4yWhxPgvQFXInxrQMZ3xj1G9LMb35SdFOXN5QJmamgNwMimi0nrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154215; c=relaxed/simple;
	bh=gmx8cY6GIxTKI6ChtMQnSHg95w03BF7mUK1y3uLwjWY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=j+UuzbgVqbt6HabJky3XpqvAHIs5IOp+2qJJGe3N8UB8rNZITe0Mac7+weqaItNcAq+FhQccOhPWiukFha0xW826TeqIHkL6y27gPoaw2VRz9QewSoc/O33GW3sPGkczalSmIEwi48GLlaPXBmsraGWFmTpRhr+1oyLygus1mEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6iUtNUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18775C433F1;
	Wed, 28 Feb 2024 21:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709154215;
	bh=gmx8cY6GIxTKI6ChtMQnSHg95w03BF7mUK1y3uLwjWY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=P6iUtNUzbW3rCRY1R/ymSpK0iyD80CYsDia5rSiS+6j68VA8+RPYrD6M9VgL05UrT
	 wxHGKRJr2aNgwwAh09NjtjMWhIdCq+r7w57JUoBP75VeZudRop2Cv9lSXJp6qLn2Zu
	 /rWBeeeUtlrSwJVAhBUo1oSawO9TPiB+3NapPBoGOjq93hDEVMvILe3tQ3CXTvGZyi
	 bL+aiIjRCjeCOKgX4UNUJI/270tqHAALzQkE9Edpht5Zh9lv/H6wMNT4RvFmRPAMUX
	 zl9CNg//gZMC+VDGtIWz2hhlM21f1x/DTgPgFpmaUtks0jKRDSX6wwDXlV7ic1qwu8
	 qwpnqPrhU5Lsg==
Date: Wed, 28 Feb 2024 15:03:34 -0600
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
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bhelgaas@google.com, helgaas@kernel.org, 
 conor@kernel.org, imx@lists.linux.dev, conor+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, kw@linux.com, lpieralisi@kernel.org
In-Reply-To: <20240228190321.580846-5-Frank.Li@nxp.com>
References: <20240228190321.580846-1-Frank.Li@nxp.com>
 <20240228190321.580846-5-Frank.Li@nxp.com>
Message-Id: <170915421044.759781.8000424616534058738.robh@kernel.org>
Subject: Re: [PATCH v5 4/5] dt-bindings: pci: layerscape-pci-ep: Add
 snps,dw-pcie-ep.yaml reference


On Wed, 28 Feb 2024 14:03:20 -0500, Frank Li wrote:
> Add snps,dw-pcie-ep.yaml.
> 
> Remove context that exist in snps,dw-pcie-ep.yaml.
> 
> Add an example for pcie-ep.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 54 ++++++++++---------
>  1 file changed, 29 insertions(+), 25 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.example.dtb: pcie-ep@3400000: 'fsl,pcie-scfg' is a required property
	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.example.dtb: pcie-ep@3400000: 'dma-coherence' is a required property
	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240228190321.580846-5-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


