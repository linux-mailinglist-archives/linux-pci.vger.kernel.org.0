Return-Path: <linux-pci+bounces-17575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3AD9E1D7B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 14:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272EA164B0E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748671E7648;
	Tue,  3 Dec 2024 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1iB8Kw8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B961B0F39;
	Tue,  3 Dec 2024 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232278; cv=none; b=hc8pwqM/9Ko9irAGtQvzx4FvqHZ8HJ34lUlMAoS4/nkg3ogRULgasgbLoTa9tUkp8GXj7RMVJWwcFK8r/2fWuuDWehPCTqo5naaN4u/JnVMqi2gppzJDj3o19yGTQaEnaWiiAA+bmGexuFQxWgqaIUOfjrqnpFeJeadJwW1kH1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232278; c=relaxed/simple;
	bh=W5skNtS2qJ7Ukf1XBAMfccxob+Vl5KkMcv8VnjEJ84Y=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=oIGWbgu5VgS0uCegSOxs5px93Ts8zrtL0ETgC3i35Ioulq/KNyPk/LVGzLRzDAxuV0j4FabnIYfl5v+JXqg4pCBGBRwyXPzqPvgvP99jRGo3Xfuwv+iZ6DzcCU2Yz0q1hkv689lij7kXwlztKoS/4O1iot+aatiJowqRd+0TojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1iB8Kw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCBDC4CECF;
	Tue,  3 Dec 2024 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733232277;
	bh=W5skNtS2qJ7Ukf1XBAMfccxob+Vl5KkMcv8VnjEJ84Y=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=e1iB8Kw8FW8i8thSCt8e30tHAK9qLpt3NlGfGVpoOnLf3rimjvUM6hZGYoypJfKn8
	 +ODdcjPQwZyQTg2PfQmyshDVM9xzyT88fbsAMnbzkAby/eyUb9wXKKD5t08BzvebKe
	 mBdwpIIM8Q5BCCB5mwm7fuZq5Hgbw17tbP5BHhXMrIsaDrP+xoPgrzJqUAvilbluTA
	 hQRfzaJUdRMvRe4vRYogYTBN5ES9JyeutNkhiXxiEgz2sGt/VedWEJ1R8LKTCF97Dm
	 jcjx5gMhC+4upEQA+WikpKR9H33aPIkw4wl7NKtZj2x4WZYPZZtpNcc8nSUHAgE3SL
	 2XX2iTtCFjE5Q==
Date: Tue, 03 Dec 2024 07:24:35 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org, 
 bharat.kumar.gogada@amd.com, lpieralisi@kernel.org, 
 linux-pci@vger.kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 bhelgaas@google.com, devicetree@vger.kernel.org, michal.simek@amd.com, 
 kw@linux.com, jingoohan1@gmail.com
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
In-Reply-To: <20241203123608.2944662-2-thippeswamy.havalige@amd.com>
References: <20241203123608.2944662-1-thippeswamy.havalige@amd.com>
 <20241203123608.2944662-2-thippeswamy.havalige@amd.com>
Message-Id: <173323227578.1564578.13597091753228653730.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB
 PCIe Root Port Bridge


On Tue, 03 Dec 2024 18:06:07 +0530, Thippeswamy Havalige wrote:
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
> ---
>  .../bindings/pci/amd,versal2-mdb-host.yaml    | 132 ++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/pci/amd,mdb-pcie.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241203123608.2944662-2-thippeswamy.havalige@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


