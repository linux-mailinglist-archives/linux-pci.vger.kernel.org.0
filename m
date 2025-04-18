Return-Path: <linux-pci+bounces-26209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566FCA93497
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 10:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050E81B6628A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 08:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CF726B2C4;
	Fri, 18 Apr 2025 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jeu8QH+M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1884B268C55;
	Fri, 18 Apr 2025 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744964678; cv=none; b=oJAulFQb3ibNg1lC26mea1Pbt2mBmN+LBDb8DFasBzGJbPICrZ0RdDFjyh3o6rx2yb85Yerbsf7Ye+iBQmxWhyGb7mXykatamUG58+z+Vk4r80SV8ua1i33wclb/9itZpp8bMrsrk7n7mr5BIAuy1iM9ewiGuCmExCXjkDZ2uRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744964678; c=relaxed/simple;
	bh=/9OfrWnCUxMfe0bzWWpOCEaGqaGAQjbwJjWfCuAqTJo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=JOGb3BJogmtqYrBHoh67YdEvVEdMcTE7K94IuFjQe93wRVHl0ZsuGIiKPT7jFaZWBjsc8Vc+GjjKjtX8gTU4uwyzvj3H/ddI62p20HHPz8ID9X0OdVg0tksrJzP6v6aUxCU/8k89/lo6P7smGxTCpaPU+eYkpF02aSKuxasz6BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jeu8QH+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E8CC4CEE2;
	Fri, 18 Apr 2025 08:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744964677;
	bh=/9OfrWnCUxMfe0bzWWpOCEaGqaGAQjbwJjWfCuAqTJo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Jeu8QH+M1Br42zGYHGcZhAAXWDmCsjRzAlZ5hrEVlRdeHLRNgShMGYULuWj2jXTUu
	 Gz7qZ/eC1LrK3mZRFcZPWAT+IQyGAZenZFtPYjcTwJ1eHyVOd433z8hLR083M13UnG
	 Yz/+BNG057GgyY5KPqpOgSbRjjTVgnHLeq1Ud0qZ2tGps68D/qD0WQ7yukthbeyyXl
	 Paw/QUmFQnR9Kbj1T+Hv5MbVp9AdYXzzTInkm93qqgjZdJGkWNWWB3uLc4zoT3AMWE
	 N6c8o0QTJOlGOc0MMWELCLcwB8D4a+uh/yHZFCLHNgGQafGvhfq5bL0WPin3TZ3DYa
	 lL5fCH47k7yLw==
Date: Fri, 18 Apr 2025 03:24:34 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: nm@ti.com, baocheng.su@siemens.com, linux-pci@vger.kernel.org, 
 diogo.ivo@siemens.com, krzk+dt@kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, kw@linux.com, 
 robin.murphy@arm.com, jan.kiszka@siemens.com, kristo@kernel.org, 
 s-vadapalli@ti.com, linux-arm-kernel@lists.infradead.org, 
 lpieralisi@kernel.org, vigneshr@ti.com, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, bhelgaas@google.com, helgaas@kernel.org, 
 m.szyprowski@samsung.com, devicetree@vger.kernel.org, conor+dt@kernel.org, 
 ssantosh@kernel.org
To: huaqian.li@siemens.com
In-Reply-To: <20250418073026.2418728-3-huaqian.li@siemens.com>
References: <20241030205703.GA1219329@bhelgaas>
 <20250418073026.2418728-1-huaqian.li@siemens.com>
 <20250418073026.2418728-3-huaqian.li@siemens.com>
Message-Id: <174496467399.2597920.14844354232532512833.robh@kernel.org>
Subject: Re: [PATCH v7 2/8] dt-bindings: PCI: ti,am65: Extend for use with
 PVU


On Fri, 18 Apr 2025 15:30:20 +0800, huaqian.li@siemens.com wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
> to specific regions of host memory. Add the optional property
> "memory-regions" to point to such regions of memory when PVU is used.
> 
> Since the PVU deals with system physical addresses, utilizing the PVU
> with PCIe devices also requires setting up the VMAP registers to map the
> Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
> mapped to the system physical address. Hence, describe the VMAP
> registers which are optional unless the PVU shall be used for PCIe.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> ---
>  .../bindings/pci/ti,am65-pci-host.yaml        | 34 +++++++++++++++++--
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/ti,am65-pci-host.example.dtb: pcie@5500000 (ti,am654-pcie-rc): 'memory-region' is a required property
	from schema $id: http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250418073026.2418728-3-huaqian.li@siemens.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


