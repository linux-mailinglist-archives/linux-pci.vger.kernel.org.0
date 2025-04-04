Return-Path: <linux-pci+bounces-25321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBB8A7C6B1
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 01:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657661893BBB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 23:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D81AAE2E;
	Fri,  4 Apr 2025 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbLc694d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BCEAE7;
	Fri,  4 Apr 2025 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743808915; cv=none; b=APYRQAoGiVYXlo6Js2EzdaYDKWJ2nstRZVmt3Ocb/JxHv6cq+vVDJ3X1X9Xmf8ZtWFtlJWt55YmBb3BYBW7cF+Pv/DwuhTGo9lIHlXXTFjxVM2Ci461lvk0F8VNys9t8vqN65eBbvd6UJ8zE5eoCyk1d17VG6KTcRoc9hV1r3Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743808915; c=relaxed/simple;
	bh=Gm8Zt0VZ+DLPaLzEL02DKMogNGkFGDwzUgpS52iDy9g=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ZhBnc0o2FO527a5KXGDoTRLXkj3V6qL1rDU70zj42tyoUYP2Il3vHFYonjH4r594u1X3tNlozhYjzYD0zcl8XOFMcZ5rg6i4cbXY+Bvx2gKotQ1HXwPkWi9sfj+JJRmeNoWDl2AkfGs1sbqrnaydI7/i/lvgo/lhX+ybPKAs8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbLc694d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5195AC4CEDD;
	Fri,  4 Apr 2025 23:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743808914;
	bh=Gm8Zt0VZ+DLPaLzEL02DKMogNGkFGDwzUgpS52iDy9g=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=RbLc694d3072I53nw1YOFQ5tBaCoSjvh8qoU8x49VffN57MvE9vRqoGk4ErF9Pkrw
	 thq7G6KdMUrLexg6IBjxsxO4g3pyQ8sJwglfB/m9dJ92NAyt2DrlTVVwisRl1jwZah
	 do3JCGcUWPJrHjPks+enpRZ1iDwOt8TNyX/TqWDWXbC+pmk2iRA7AYhElsju9x59Xf
	 7pp4r/BhCnsVbdlJZK9oW81Xa0E95nNogSlzowlw/S3bvFlutwcsBeqkWf/66/de4J
	 ZwYrVnD4VBWnNOHIRLQ7RZYiw1o3AhlqsL5fqyX7RaKoCSuflsaLXOkqUMgHy+I4X4
	 6nrW4/XRS/7xw==
Date: Fri, 04 Apr 2025 18:21:53 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Vidya Sagar <vidyas@nvidia.com>, 
 Frank Li <Frank.li@nxp.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
In-Reply-To: <20250404221559.552201-1-robh@kernel.org>
References: <20250404221559.552201-1-robh@kernel.org>
Message-Id: <174380891321.749968.3085053836966154334.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Remove obsolete .txt docs


On Fri, 04 Apr 2025 17:15:57 -0500, Rob Herring (Arm) wrote:
> The content in these files has been moved to the schemas in dtschema.
> pci.txt is covered by pci-bus-common.yaml and pci-host-bridge.yaml.
> pci-iommu.txt is covered by pci-iommu.yaml. pci-msi.txt is covered in
> msi-map property in pci-host-bridge.yaml.
> 
> Cc: Frank Li <Frank.li@nxp.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/pci/nvidia,tegra194-pcie-ep.yaml |   2 +-
>  .../devicetree/bindings/pci/pci-iommu.txt     | 171 --------------
>  .../devicetree/bindings/pci/pci-msi.txt       | 220 ------------------
>  Documentation/devicetree/bindings/pci/pci.txt |  84 -------
>  4 files changed, 1 insertion(+), 476 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci-msi.txt
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/virtio/pci-iommu.yaml references a file that doesn't exist: Documentation/devicetree/bindings/pci/pci.txt
Documentation/devicetree/bindings/virtio/pci-iommu.yaml: Documentation/devicetree/bindings/pci/pci.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250404221559.552201-1-robh@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


