Return-Path: <linux-pci+bounces-25879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12D4A88F1A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 00:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7865D3B1C4B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 22:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F701F3BB4;
	Mon, 14 Apr 2025 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBkQLXzj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069121B0F3C;
	Mon, 14 Apr 2025 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744669774; cv=none; b=q16QYPr9dYildzE6w2jnNRcJvYVD1GgzUs9++lIPbEcChiTFXouWnjiiqC/hT4C/sD1zJN1kL3UQc1GLqczbMc7i/euG5JQCy4ioEaX5YpQxmgJMrZBWrrssXMJnw3kxf6yhJ9T23c3sZZHRSGIVMBBDYcKduAYn8y4plQwIPsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744669774; c=relaxed/simple;
	bh=MVlqs/ATqHLPaxxaiCF96uREsAduXa5I6ciuYSAoyY4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Xzb4KKL/RETnPyqKJ+M4MU2HGvKOv8sxOJIgkA63n3lMfjr8/e0pctGzIT5SAtKmCnqI3uv0BIYqdlBq6cxNTWGWwVdEhWhcPLi91DUStehLBSel0WRPt4gpe4vZdaVis7xRfX+YG+eyqOZq3tIlApHGXi8j4OmqP8UGXKms2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBkQLXzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359CDC4CEE9;
	Mon, 14 Apr 2025 22:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744669773;
	bh=MVlqs/ATqHLPaxxaiCF96uREsAduXa5I6ciuYSAoyY4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=QBkQLXzjgmTSicJ4PFikso2I2Z5kVvuLAeNdpBP4+qrDAY5E0X2iKJqTGZXrN88vQ
	 eVJNJWuESjme3Rr6Z9NgPYdEr1n4HLoLXygL3NLibGrlAEJ1X1FrvN5y2HYoXoyGGg
	 13sMAeI0jNJcp0ETo9/F4M7c2tQfuLzLh0pHns3yMLBW5RpiZqq7KdbcRiDVWBHPES
	 6gls1PqBA2lZFJ3Ih9C1vf02htkTJXkkLj3S/N+QkdIGEBVZgRK4w8hXOAXsvimZth
	 VBqKFHNCAeaXBHYq83dIa/+vIyjHyvYga2wNlsAZFOn+zFtOSlbgA25UtI2yK70xYR
	 MbvuBohwZXktQ==
Date: Mon, 14 Apr 2025 17:29:31 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org
To: "Rob Herring (Arm)" <robh@kernel.org>
In-Reply-To: <20250414214135.1680076-1-robh@kernel.org>
References: <20250414214135.1680076-1-robh@kernel.org>
Message-Id: <174466977142.1877467.9140482106900041765.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Convert marvell,armada8k-pcie to
 schema


On Mon, 14 Apr 2025 16:41:33 -0500, Rob Herring (Arm) wrote:
> Convert the marvell,armada8k-pcie binding to DT schema. The binding
> uses different names for reg, clocks, and phys which have to be added
> to the common Synopsys DWC binding.
> 
> The "marvell,reset-gpio" property was not documented. Mark it deprecated
> as the "reset-gpios" property can be used instead. The "msi-parent"
> property was also not documented.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/pci/marvell,armada8k-pcie.yaml   | 100 ++++++++++++++++++
>  .../devicetree/bindings/pci/pci-armada8k.txt  |  48 ---------
>  .../bindings/pci/snps,dw-pcie-common.yaml     |   3 +-
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |   4 +-
>  MAINTAINERS                                   |   2 +-
>  5 files changed, 106 insertions(+), 51 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/marvell,armada8k-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/marvell,armada8k-pcie.example.dtb: pcie@f2600000 (marvell,armada8k-pcie): interrupts: [[0], [32], [4]] is too long
	from schema $id: http://devicetree.org/schemas/pci/marvell,armada8k-pcie.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250414214135.1680076-1-robh@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


