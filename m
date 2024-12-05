Return-Path: <linux-pci+bounces-17730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51A29E517F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 10:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8636B2843BE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFD51D63C4;
	Thu,  5 Dec 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFoBwUq9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5431D5175;
	Thu,  5 Dec 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391488; cv=none; b=eF8fkIvLF4JXOZWZiZB+bHP4vEqQRG5CROJ6ZwvK9/6CPJ+IAApFU5+QX7jxFnXpHdw8+9HQZ/ZPqoyOeZBegXOk7HXotEoGQG5oyULM/W5GAFg9eV+7R8wQNlgUKvTEfnFfsv3skIWHqpLsLlfK5vrMJUxUFDRMrHyie8grINs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391488; c=relaxed/simple;
	bh=HRontmhpAXB7zdihojZafgOYClH6jtz6uOSjDmx3JAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fqk98II6EWBvvxljJEVhvhcj3X6CIeP7fQDbAIrv2tkrfEJXonT7rxSnzz+8mnsZLb3xvURBdCydwYvB397WgTAV4+crXaYXPbTTCB3xHyemKZOoWTHyuaWRBRJ8paJg8nRRczRvuPTXeieRXfInJMxMHHupYcE/606HShAYjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFoBwUq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35C8C4CED1;
	Thu,  5 Dec 2024 09:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733391488;
	bh=HRontmhpAXB7zdihojZafgOYClH6jtz6uOSjDmx3JAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFoBwUq9bZELbs1gPcSWPBGsHkmsk3f/29dSssqqA6F50wGecvEPVdaSEEafRy5uN
	 P+2gXv0Voh/tJKZjq/0TGWE/TwzmSrh6GpidUcRJ+e2ELuzMNuLMhHq/oObNZUfc7i
	 2q5eaf4mVO1EdZssgcAxOvWdaLTHXUg605ovkVilAqH4xjRooGfLTwRF/axKPrAGxx
	 YU5B0hZGViS+Zn8ww2JN7cXN6lE4QtEas6qllxk/0P62nNJFmHvHOWW0h3GqFCuud5
	 5e+vZZjBNTRiwfgr+SDtznU0f33DxLzlaTymhGp8/v90+rB3RbSdKdyCLj0rMId3CE
	 +mo4+LgVOkg8w==
Date: Thu, 5 Dec 2024 10:38:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 1/6] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe
 uniphy
Message-ID: <7js7lswzde67izdradhuzgvlixwiblgf7aosdvavknbclbtjew@6w3y2e2k3mtk>
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-2-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204113329.3195627-2-quic_varada@quicinc.com>

On Wed, Dec 04, 2024 at 05:03:24PM +0530, Varadarajan Narayanan wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Document the Qualcomm UNIPHY PCIe 28LP present in IPQ5332.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Rename the file to match the compatible

Either I look at wrong v1 from your cover letter or there was no such
file in v1, so how it can be a rename?

What happened here?


>     Drop 'driver' from title
>     Dropped 'clock-names'
>     Fixed 'reset-names'
> --
>  .../bindings/phy/qcom,uniphy-pcie.yaml        | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,uniphy-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie.yaml b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie.yaml
> new file mode 100644
> index 000000000000..e0ad98a9f324
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie.yaml

This does not match compatible, so I don't see how it even matches your
changelog.

> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,uniphy-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm UNIPHY PCIe 28LP PHY
> +
> +maintainers:
> +  - Nitheesh Sekar <quic_nsekar@quicinc.com>
> +  - Varadarajan Narayanan <quic_varada@quicinc.com>
> +
> +description:
> +  PCIe and USB combo PHY found in Qualcomm IPQ5332 SoC
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq5332-uniphy-pcie-gen3x1

Odd naming. Did anyone suggest this? I would expect something matches
like everything else recent (see X1 for example).


> +      - qcom,ipq5332-uniphy-pcie-gen3x2
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2

What happened here? This cannot be minItems and it never was.

> +
> +  resets:
> +    minItems: 2
> +    maxItems: 3

Why this varies?

This patch is odd. Confusing changelog, v1 entirely different and not
matching what is here, unusual and incorrect code in the binding itself.

Provide changelog explaining WHY you did such odd changes.

Open *LATEST* existing Qcom bindings and look how they do it. Do not
implement things differently.

Best regards,
Krzysztof


