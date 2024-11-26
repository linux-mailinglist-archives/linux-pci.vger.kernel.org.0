Return-Path: <linux-pci+bounces-17354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D439D99C0
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 15:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370D928372A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE11D5CC2;
	Tue, 26 Nov 2024 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWGqYGU+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0001D5AB7;
	Tue, 26 Nov 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732631914; cv=none; b=MlAZjHVzTEBgv3leZR520gegyjfSeQigOkBVd2c/jwtGST9WgeFybcm9lu5bVKjmuroAt84hdH0zrgW7jCrjEjD5I9xpgh6BFx1S9hrcvbeC0b9ckKgDJwmHrVTVLowWG5aoispdo4soBvzOxrltcAcl8CgNLlNOxj7YouOsKxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732631914; c=relaxed/simple;
	bh=gaEdBLAIz7P49l/o5H51QYLoUNT4ajXgna3oxySU6X0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=aKD0hrVrHitCyumxj3nDMMljUqveBMYCEGm2V8+r7qcDg8EMJes4NU+nJ3OEZevQp/9aT3q5Loe49Vwk8mFIvPAu6hucJt5MsibagJ+2OjNL/AIHzse9GA9N/iGjLFQzB5KfB6fYUnG7ki4FBcxFHgcpQ/u8yLG0kYytRNQbnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWGqYGU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A0CC4CECF;
	Tue, 26 Nov 2024 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732631913;
	bh=gaEdBLAIz7P49l/o5H51QYLoUNT4ajXgna3oxySU6X0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=QWGqYGU+7lxDyWQ8GeVwa/EskJ57WuPDmJc0ZGG66OFNNvafWBoJ8aT/8lI8IH+3p
	 2JIycrGmAyWX72drR7fejKuWiLjLnrXMX22HviT0VACSLoIa578e28lkp+11Abjxa2
	 o0s9QLoEruipfKCI+6JkM16sxH1F9R7yYWPIK/B9ggQA0SET3+qyBgrmkb2FU/Vpwh
	 ZJaUHYwB/AUh0ypc/4DMGeTZH4I0thXfJVdrI96162zNPbQIsB6T+yMcb+31Yhk03a
	 WkgOUV4u90G7dE+WIZSKkmjL8FyvwcJjU0zMEcgQzVdpCo5nCnak43MCmOq4GMeBmr
	 nAc0kUCrFYyug==
Date: Tue, 26 Nov 2024 08:38:31 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: bhelgaas@google.com, cassel@kernel.org, fabrice.gasnier@foss.st.com, 
 quic_schintav@quicinc.com, linux-pci@vger.kernel.org, lpieralisi@kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, kw@linux.com, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 p.zabel@pengutronix.de, mcoquelin.stm32@gmail.com, krzk+dt@kernel.org, 
 devicetree@vger.kernel.org, alexandre.torgue@foss.st.com, 
 manivannan.sadhasivam@linaro.org
To: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <20241126130004.1570091-2-christian.bruel@foss.st.com>
References: <20241126130004.1570091-1-christian.bruel@foss.st.com>
 <20241126130004.1570091-2-christian.bruel@foss.st.com>
Message-Id: <173263191160.224313.7510313063987746316.robh@kernel.org>
Subject: Re: [PATCH v1 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root
 complex bindings


On Tue, 26 Nov 2024 14:00:00 +0100, Christian Bruel wrote:
> Document the bindings for STM32MP25 PCIe Controller configured in
> root complex mode.
> 
> Supports 4 legacy interrupts and MSI interrupts from the ARM
> GICv2m controller.
> 
> STM32 PCIe may be in a power domain which is the case for the STM32MP25
> based boards.
> 
> Supports wake# from wake-gpios
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  .../bindings/pci/st,stm32-pcie-common.yaml    | 45 +++++++++
>  .../bindings/pci/st,stm32-pcie-host.yaml      | 99 +++++++++++++++++++
>  2 files changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml:45:1: [warning] too many blank lines (2 > 1) (empty-lines)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241126130004.1570091-2-christian.bruel@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


