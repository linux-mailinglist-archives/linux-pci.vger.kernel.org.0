Return-Path: <linux-pci+bounces-17881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C573C9E8193
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 19:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548981653C6
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F23154BF5;
	Sat,  7 Dec 2024 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOXsnVbC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35815442A;
	Sat,  7 Dec 2024 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733596253; cv=none; b=q3GT/HvV8Skk70H5NW19zWJNIGJN3Xy6mTIRql/YBKPAUmwM+5aBz1JXfgl+JPdFAX+yS6BDuCEjnvzKHHVN8xEvimqpfRFxT5pTKtsSnPDP3brVe9boGp1lXpeFB48J79JiZpEWpNvF0mDG+AFsHwdYpl1UNA8LzwASRYWjuHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733596253; c=relaxed/simple;
	bh=k/F05t+u2Lyl3OeKxVtvw0a1f1h7DzX6z7M92Z2YMDw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=MmviZm5o3g+QrWnnWJl4paWk/hY3nUB26rEDRpirvAECaKiWuvPokgnNG5pFUuQobCNYOWXTgKpOKPleyLk/GvfxQs+fSsr4cjxd7qcKa/VbE5lIb08SPiQl7O9/DzoWgPZIGhEKHZsasOA1a0AUafixlr4ZA/5dAWeInlwWYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOXsnVbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9ADC4CECD;
	Sat,  7 Dec 2024 18:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733596252;
	bh=k/F05t+u2Lyl3OeKxVtvw0a1f1h7DzX6z7M92Z2YMDw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=GOXsnVbCPpG8DTrT2cmhvOGLJ6syY0fw1dZRonhuO8zSnLy1EA0p4oyInHe0f1cLi
	 eWjsDmuFsbLaaRPCdIcifpvnX/wF6jigZWHjXeFsS3tbtk4hyecVa0JXAuQuPK+huX
	 SSyyahMHEatzVQ7f6e7lPl88zc8kh65nWBHH8kLKcVG7tpcqAhfa/jNAXhqOhPkyEz
	 XQXv4KxCf4UouMs43Vt2cO7kcddEuTSsfMyxHOOBAW/EX66Rbxh0AiFps+1odHKNb1
	 EO0CEibBIFaF6FnrNB6DWVRniIoOtJyv8Js8IXhkLk+Zx32sr9i60R7istu1DVWz22
	 qYM5U7YJOCwBw==
Date: Sat, 07 Dec 2024 12:30:51 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, michal.simek@amd.com, 
 bhelgaas@google.com, manivannan.sadhasivam@linaro.org, 
 linux-kernel@vger.kernel.org, lpieralisi@kernel.org, krzk+dt@kernel.org, 
 devicetree@vger.kernel.org, bharat.kumar.gogada@amd.com, 
 jingoohan1@gmail.com, kw@linux.com
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
In-Reply-To: <20241207171134.3253027-3-thippeswamy.havalige@amd.com>
References: <20241207171134.3253027-1-thippeswamy.havalige@amd.com>
 <20241207171134.3253027-3-thippeswamy.havalige@amd.com>
Message-Id: <173359624973.3074604.14570615251365278218.robh@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB
 PCIe Root Port Bridge


On Sat, 07 Dec 2024 22:41:33 +0530, Thippeswamy Havalige wrote:
> Add AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root Port Bridge.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Changes in v2:
> -------------
> - Modify patch subject.
> - Add pcie host bridge reference.
> - Modify filename as per compatible string.
> - Remove standard PCI properties.
> - Modify interrupt controller description.
> - Indentation
> 
> Changes in v3:
> -------------
> - Modified SLCR to lower case.
> - Add dwc schemas.
> - Remove common properties.
> - Move additionalProperties below properties.
> - Remove ranges property from required properties.
> - Drop blank line.
> - Modify pci@ to pcie@
> 
> Changes in v4:
> --------------
> - None.
> ---
>  .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.example.dtb: pcie@ed931000: reg-names:0: 'oneOf' conditional failed, one must be fixed:
	'dbi' was expected
	'dbi2' was expected
	'mdb_pcie_slcr' is not one of ['elbi', 'app']
	'atu' was expected
	'dma' was expected
	'phy' was expected
	'config' was expected
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.example.dtb: pcie@ed931000: reg-names:0: 'oneOf' conditional failed, one must be fixed:
		'mdb_pcie_slcr' is not one of ['apb', 'mgmt', 'link', 'ulreg', 'appl']
		'mdb_pcie_slcr' is not one of ['atu_dma']
		'mdb_pcie_slcr' is not one of ['smu', 'mpu']
		'mdb_pcie_slcr' is not one of ['ecam']
		['mdb_pcie_slcr'] was expected
	from schema $id: http://devicetree.org/schemas/pci/amd,versal2-mdb-host.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241207171134.3253027-3-thippeswamy.havalige@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


