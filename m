Return-Path: <linux-pci+bounces-24324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC926A6B8D8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 11:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3654F19C583D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A853820DD4E;
	Fri, 21 Mar 2025 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2E3Xc0i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8778F5B;
	Fri, 21 Mar 2025 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553330; cv=none; b=aewxmlJaOq5qZN9uH9r/CDYwH7txYENuIB504a/2Ha2qimVnkW9Ndw+cwQt/ElgQMr9+TacBYK1td0/6UvIm5aA4AEKlzOY2y6tZPqc2YDXl1ydD8i2hP5fylq/qYrKdg/QVSuP+RP8jgmNrD+lFzQU2Re9gNY7Vy2MRmmeCiww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553330; c=relaxed/simple;
	bh=M38TozFdZmDwbMggCWzdf6+Uy65GEd34MS0QwbTZJZc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=bjVksbcRj1mhzJ5Si5ZBKG1MOVaZuuCxOKYZuSAp4kIBSXL8BdCy92YSmKfx0WKrXAirk7n6SylaMYJivBITyiGf2s173Va+YwprwDO2XBnG3O35+mw9BAEokBqq/asdHk8o7HI1Gp8n/n2qAyB0lfFg9jOzeU8f4QSsdUuUFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2E3Xc0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C97DC4CEE3;
	Fri, 21 Mar 2025 10:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742553329;
	bh=M38TozFdZmDwbMggCWzdf6+Uy65GEd34MS0QwbTZJZc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=P2E3Xc0i0Sk5jGWUFUfaZDF8yPFrugsZoR5m5uFXw6JGMB1qT4FrSCUZimP44PjQB
	 5w/7CM/cM0+OQut8Y1qrXPPeKJhpn9SjLCqsbVezuGmHyR2aBI4LyLAAn6yujp7Z1p
	 w/MyIX5Q2rKSvoM/d/UNj+0dV0EV/bKQejOfFT+lf5kR+bKSvYmNAKH40kgBg7os4K
	 5eZQLBH4msUkmXQs502Cou46mS1ZMJVhHftYe71iSiwR/VB3N1xWdJEXka0cIHoNQp
	 Zx7PBP17DLctq3mFU1oBeTkPAnZ+3SWhiESFDyrG2aZUStBW4CUcR8WCoQqZAVh4l9
	 jomkRFy0kUHIA==
Date: Fri, 21 Mar 2025 05:35:28 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Nitheesh Sekar <quic_nsekar@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 20250317100029.881286-2-quic_varada@quicinc.com, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, devicetree@vger.kernel.org, 
 linux-pci@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 linux-arm-msm@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
To: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <20250321-ipq5018-pcie-v5-1-aae2caa1f418@outlook.com>
References: <20250321-ipq5018-pcie-v5-0-aae2caa1f418@outlook.com>
 <20250321-ipq5018-pcie-v5-1-aae2caa1f418@outlook.com>
Message-Id: <174255332861.2810991.11878697286839237760.robh@kernel.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: phy: qcom: uniphy-pcie: Add
 ipq5018 compatible


On Fri, 21 Mar 2025 13:09:50 +0400, George Moussalem wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> The IPQ5018 SoC contains a Gen2 1 and 2-lane PCIe UNIPHY which is the
> same as the one found in IPQ5332. As such, add IPQ5018 compatible.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  .../bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml | 57 +++++++++++++++++++---
>  1 file changed, 49 insertions(+), 8 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:0:then:properties:clocks: {'minItems': 1, 'maxItems': 1, 'items': [{'description': 'pcie pipe clock'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:0:then:properties:clocks: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'pcie pipe clock'}] is too short
	False schema does not allow 1
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:0:then:properties:resets: {'minItems': 2, 'maxItems': 2, 'items': [{'description': 'phy reset'}, {'description': 'cfg reset'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:0:then:properties:resets: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'phy reset'}, {'description': 'cfg reset'}] is too long
	[{'description': 'phy reset'}, {'description': 'cfg reset'}] is too short
	False schema does not allow 2
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:1:then:properties:clocks: {'minItems': 2, 'maxItems': 2, 'items': [{'description': 'pcie pipe clock'}, {'description': 'pcie ahb clock'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:1:then:properties:clocks: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'pcie pipe clock'}, {'description': 'pcie ahb clock'}] is too long
	[{'description': 'pcie pipe clock'}, {'description': 'pcie ahb clock'}] is too short
	False schema does not allow 2
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:1:then:properties:resets: {'minItems': 3, 'maxItems': 3, 'items': [{'description': 'phy reset'}, {'description': 'ahb reset'}, {'description': 'cfg reset'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:1:then:properties:resets: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'phy reset'}, {'description': 'ahb reset'}, {'description': 'cfg reset'}] is too long
	[{'description': 'phy reset'}, {'description': 'ahb reset'}, {'description': 'cfg reset'}] is too short
	False schema does not allow 3
	1 was expected
	3 is greater than the maximum of 2
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250321-ipq5018-pcie-v5-1-aae2caa1f418@outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


