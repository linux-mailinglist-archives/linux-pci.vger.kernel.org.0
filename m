Return-Path: <linux-pci+bounces-17103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4039D34FB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 09:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860D21F22C69
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2C1591EA;
	Wed, 20 Nov 2024 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8iRK7jH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D935336D;
	Wed, 20 Nov 2024 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089896; cv=none; b=MK/mDMUH+AAxLeBHOChGPZWJVbtdXSFUi6l60uaI1ae8fC47z80iPzGWTQewqPPtFWU0HsfGtPYZIlIlgAleYZ+heZ4HRE3TPOJMd4GKpbyYR13voTmwVmXGLRERCMQkJb8wD6iuoKl/tbXEHYwdE00tqFNk7/UkTN89hRAmXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089896; c=relaxed/simple;
	bh=iGKl/Y3E1jeBjeExLymZF7rppvxpUdPzqh2T3yISSPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pALdKAA/KalTaUUbFYXX/8IWAKrzljJAedQ6tRhmjCznFVQG72aT8JMgSyWhujNVvstCpyIdB9jIEzw6NKrozSoMd8wcJ8edw/HjqDIXwOha7EsCmH9OgVnsTei7P87sB+TWJ20guUPLc7UNAjLO+qS27i1WtI+vv0Ldlo6rRAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8iRK7jH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9103BC4CECD;
	Wed, 20 Nov 2024 08:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732089895;
	bh=iGKl/Y3E1jeBjeExLymZF7rppvxpUdPzqh2T3yISSPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X8iRK7jH2oLFfGhGkOTiM4239uxIClShweDK0V5gnqe+78QgMm3P07EHEqnZIPF59
	 FV4ZUBiXN6yTMvNLR/DZhOpoNaHK4Eec76bt80YQNUCQcSqwtRDxlqGXgqxC2oMeEl
	 gERlZHqERzvjDV6kq5D13R6wQTZSn8XtL2Nf5ngPhmxGDMoxByxbuhnXmP13QUtEbB
	 G7RsDDy5Vh6clRMbTZSmAASdJ/lLWFyzqUdjodoEwJMTiWdaHfQ1zWSraSkDZ+9GQE
	 5O3O8YS9yYGxlP0PTys+4qCkoHz49MWRyrTqcfO0p1F0cFI3bFQXTmGg8jvAVeO2+d
	 ERX2dkfw9YOOQ==
Date: Wed, 20 Nov 2024 09:04:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Message-ID: <poruhxgxnkhvqij5q7z4toxzcsk2gvkyj6ewicsfxj6xl3i3un@msgyeeyb6hsf>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>

On Tue, Nov 12, 2024 at 08:31:33PM +0530, Krishna chaitanya chundru wrote:
> Add binding describing the Qualcomm PCIe switch, QPS615,
> which provides Ethernet MAC integrated to the 3rd downstream port
> and two downstream PCIe ports.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,qps615.yaml       | 205 +++++++++++++++++++++
>  1 file changed, 205 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
> new file mode 100644
> index 000000000000..e6a63a0bb0f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml

Isn't "qcom,qps615" a SoC name? This is supposed to be matching
compatible, in your case probably qcom,qps615-whatever-this-is?

...

> +  qps615,axi-clk-freq-hz:

That's a downstream code you send us.

Anyway, why assigned clock rates do not work for you? You are
re-implementing legacy property now under different name :/


> +    description:
> +      AXI clock rate which is internal bus of the switch
> +      The switch only runs in two frequencies i.e 250MHz and 125MHz.
> +    enum: [125000000, 250000000]
> +
> +allOf:
> +  - $ref: "#/$defs/qps615-node"
> +
> +patternProperties:
> +  "@1?[0-9a-f](,[0-7])?$":
> +    description: child nodes describing the internal downstream ports
> +      the qps615 switch.
> +    type: object
> +    $ref: "#/$defs/qps615-node"
> +    unevaluatedProperties: false
> +
> +$defs:
> +  qps615-node:
> +    type: object
> +
> +    properties:
> +      qcom,l0s-entry-delay-ns:
> +        description: Aspm l0s entry delay.
> +
> +      qcom,l1-entry-delay-ns:
> +        description: Aspm l1 entry delay.
> +
> +      qcom,tx-amplitude-millivolt:

-microvolt does not work for you?

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Change Tx Margin setting for low power consumption.
> +
> +      qcom,no-dfe-support:
> +        type: boolean
> +        description: Disable DFE (Decision Feedback Equalizer), which mitigates
> +          intersymbol interference and some reflections caused by impedance mismatches.
> +
> +      qcom,nfts:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Number of Fast Training Sequence (FTS) used during L0s to L0 exit
> +          for bit and Symbol lock.

Use some of these properties in the example. I saw only one.

> +
> +    allOf:
> +      - $ref: /schemas/pci/pci-bus.yaml#
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - vdd18-supply
> +  - vdd09-supply
> +  - vddc-supply
> +  - vddio1-supply
> +  - vddio2-supply
> +  - vddio18-supply
> +  - i2c-parent
> +  - reset-gpios
> +
> +examples:
> +  - |
> +

Drop blank line

> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        pcie@0 {
> +            device_type = "pci";
> +            reg = <0x0 0x0 0x0 0x0 0x0>;

Best regards,
Krzysztof


