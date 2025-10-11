Return-Path: <linux-pci+bounces-37837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D813ABCEFB8
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 06:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13816189EEEC
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 04:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2976487BE;
	Sat, 11 Oct 2025 04:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRuz2D9o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BDA34BA49;
	Sat, 11 Oct 2025 04:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760155852; cv=none; b=n/ibeOuzk16+wv7jCq3ltWWTqht2QWZE1P5Qp8Qg6K6lZNBpa7aAhRVI3gR1YvdARgrmT3HdzJn7Oi7ysi3tF8WBGHh3UuZaJTFOss9udRydSrjXaOAJPaaBdKoR0dNenO2jiXH9eqvdrsmyGKlcMThE/NL5sVQeT39/CjiLDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760155852; c=relaxed/simple;
	bh=1TcDCsDbWWLfOUPUJCIkonnjk/XXqEKJQPgi+pm+cMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/YsLYTggvKd6hCx6MRYIziRr4NXPMg28YA6QcBYgiHvLD4+0MqTZ3GrFN4jxaLVPP799MXa5DmL3XxJefcbQ0jKfiXxgS+tSPZ5rFH0C4RMqWwEpaXxwBNrcgY4faDgZph476C2Z/SdQQSV8hqoUiXnFrWuXdIeHG/svmgLe58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRuz2D9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA7AC4CEF4;
	Sat, 11 Oct 2025 04:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760155852;
	bh=1TcDCsDbWWLfOUPUJCIkonnjk/XXqEKJQPgi+pm+cMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bRuz2D9oWCkn1JDYcV2fFoPaclEDopN3AmhMfY+PW28wkRq8wFQ81I/2gJrnvKjly
	 4czS0kGWXIlkcxWqJmR0Uc2nXZvnJJVhTWySefeHGoVLaaV6d/HXqmgo7Dw03H0iA6
	 TY3Fw/us9I4nMcvDf2iN2ihB5AmUdHQEG26377EvngzpAvDomQ1yz6ynszBUgLuEP4
	 O5AHzLQcB0f/E0ths3bebydoQN7AUsh85DZ7NAhIiat7YnJO0zSCGdHklx/wOh/AJm
	 QOftBUIfL/GsaoWMYjCNlyEQXtmQ1NOAi/jySKGIflO0hw5whnF0HNkKKZXdtAV6bt
	 iTLcbzundEfVQ==
Date: Fri, 10 Oct 2025 21:10:50 -0700
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abraham I <kishon@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] dt-bindings: PCI: qcom: Enforce check for PHY,
 PERST# and WAKE# properties
Message-ID: <3euh4nn2ceyigu3fd46f42ibsyep3c2m7b66uqezwvdkzoh5jo@t2b3rty3dzhs>
References: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
 <20251010-pci-binding-v1-2-947c004b5699@oss.qualcomm.com>
 <176012477191.896715.1769779927734963381.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176012477191.896715.1769779927734963381.robh@kernel.org>

On Fri, Oct 10, 2025 at 02:33:23PM -0500, Rob Herring (Arm) wrote:
> 
> On Fri, 10 Oct 2025 11:25:48 -0700, Manivannan Sadhasivam wrote:
> > Currently, the binding supports specifying the PHY, PERST#, WAKE#
> > properties in two ways:
> > 
> > 1. Controller node (deprecated)
> > 	- phys
> > 	- perst-gpios
> > 	- wake-gpios
> > 
> > 2. Root Port node
> > 	- phys
> > 	- reset-gpios
> > 	- wake-gpios
> > 
> > But there is no check to make sure that the both variants are not mixed.
> > For instance, if the Controller node specifies 'phys', 'reset-gpios',
> > 'wake-gpios' or if the Root Port node specifies 'phys', 'perst-gpios',
> > 'wake-gpios', then the driver will fail as reported. Hence, enforce the
> > check in the binding to catch these issues.
> > 
> > It is also possible that DTs could have 'phys' property in Controller node
> > and 'reset-gpios/wake-gpios' properties in the Root Port node. It will also
> > be a problem, but it is not possible to catch these cross-node issues in
> > the binding.
> > 
> > Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Closes: https://lore.kernel.org/linux-pci/8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com
> > Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/pci/qcom,pcie-common.yaml    | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.example.dtb: pcie@1c00000 (qcom,pcie-sc8180x): 'oneOf' conditional failed, one must be fixed:
> 	'perst-gpios' is a required property
> 	'wake-gpios' is a required property
> 	False schema does not allow [[4294967295]]
> 	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sc8180x.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.example.dtb: pcie@1c00000 (qcom,pcie-sc8180x): Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'dma-coherent', 'interconnect-names', 'interconnects', 'interrupt-map', 'interrupt-map-mask', 'iommu-map', 'linux,pci-domain', 'num-lanes', 'phy-names', 'phys', 'power-domains', 'ranges' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sc8180x.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.example.dtb: pcie@1c08000 (qcom,pcie-sc7280): pcie@0: 'oneOf' conditional failed, one must be fixed:
> 	'wake-gpios' is a required property
> 	False schema does not allow [[4294967295]]
> 	False schema does not allow [[4294967295, 2, 1]]
> 	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sc7280.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.example.dtb: pcie@1c08000 (qcom,pcie-sc7280): Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'dma-coherent', 'interrupt-map', 'interrupt-map-mask', 'iommu-map', 'linux,pci-domain', 'num-lanes', 'pcie@0', 'power-domains', 'ranges', 'vddpe-3v3-supply' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sc7280.yaml#
> 

I need to add the missing properties to the example nodes in these bindings.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

