Return-Path: <linux-pci+bounces-9311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F305C918520
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1FD1F23D7E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55B2188CAF;
	Wed, 26 Jun 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRE7ME/f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385A186E33;
	Wed, 26 Jun 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414125; cv=none; b=KVzj6QPNUb6Hhn2kgxJ8ESbTxoTIgD1fGv+OBOvyZSUmP7F3WD/by7qfEfW0Bk1C+E6+e1MsibPGgLQEeAKiOXCbI8RyxuC71a5xjxQnW1k1DSJkV6AmKnZFmwq1VRl5kU/NNL3VBskaKsoyh5KTJOG2ue6jAgWh+AX2tCy7DV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414125; c=relaxed/simple;
	bh=fgMMM7pNiJxo+jmp2NMUAPW1f/KDpo2M0f8YCbewTSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7QKGj6Y0kbbUOT8+s+PB8gFlvT9KWhav/L1//A2NbuMNQLMO8LFrBLJJPqpMGccfkooJgBsbKZRU/wKtYnzFl6vdMsfuV6S8pkqIjX1Nna+ASEv3GflKLts05eUfq/J7rNl9nC/raO9U6G4pDadT5n/DPF6yZNXqnC7U+K1zFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRE7ME/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0EEC116B1;
	Wed, 26 Jun 2024 15:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719414125;
	bh=fgMMM7pNiJxo+jmp2NMUAPW1f/KDpo2M0f8YCbewTSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRE7ME/fBH+rbV9VoOpFrdt/9Cgtz2ZR+BfinfbTIX1tSU/RRBahafOnNoWtz42bi
	 pCOzSDwAKYAELnpfMZ9xdmKXf+R3YjRZAnGAM+KMvTjX+HQ+LVDJRumjecPyaKq4hq
	 NmEvtNv9E8wU9Uq/LPUchAvcltjsGl4/LV6+wwA5hBTrk+/cpX9NDepTnDqKtC/5vO
	 yB6Lo9UWW9aa1JRPp22W4158dneYTX1oZdV1wnPgYWu8+XvjWU47Mgq591MmXCJU+s
	 tXh7g6T5VZVELUps3bxEDexzxn89ZPqDVWT/BOVaL3qaQNjhgI7tyZq1elvvjneAIw
	 9WfHskj4MX+0A==
Date: Wed, 26 Jun 2024 10:01:31 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com, quic_skananth@quicinc.com, 
	quic_nitegupt@quicinc.com, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/7] dt: bindings: add qcom,qps615.yaml
Message-ID: <4ivdeyp74faiztnrimxtdvslf4kcnmxd3omx2255pdfl27v55e@w7otowwnfeah>
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
 <20240626-qps615-v1-1-2ade7bd91e02@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-qps615-v1-1-2ade7bd91e02@quicinc.com>

On Wed, Jun 26, 2024 at 06:07:49PM GMT, Krishna chaitanya chundru wrote:
> qps615 is a driver for Qualcomm PCIe switch driver which controls
> power & configuration of the hardware.
> Add a bindings document for the driver.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,qps615.yaml       | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
> new file mode 100644
> index 000000000000..f090683f9e2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,pcie-qps615.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QPS615 PCIe switch
> +
> +maintainers:
> +  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
> +
> +description: |
> +  Qualcomm QPS615 PCIe switch has one upstream and three downstream
> +  ports. One of the downstream ports is used as endpoint device of
> +  Ethernet MAC. Other two downstream ports are supposed to connect
> +  to external device.

Hopefully this isn't the only possible use of QPS615, so I'd suggest
that you omit the rbg3gen2-specific integration details from this
binding. In other words, describe the QPS615, not the QPS615 in rb3gen2.

> +
> +  The power controlled by the GPIO's, if we enable the GPIO's the
> +  power to the switch will be on.
> +
> +  The QPS615 PCIe switch is configured through I2C interface before
> +  PCIe link is established.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci1179,0623
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: |

'|' means "preserve formatting", but there's nothing here to preserve,
please drop it.

> +      Phandle to the vdd input voltage which are fixed regulators which
> +      in are mapped to the GPIO's.

The binding for a regulator consumer should not document how the
providing regulator is implemented. Only thing to describe here it which
"supply pin" this refers to, which turns this into "vdd input" or "vdd
pin supply" (if that's what the datasheet call this pin on the QPS615)
and as such you can drop the description because the name of the
property already states that.

> +
> +  switch-i2c-cntrl:

I'd prefer you call it "i2c-adapter" or perhaps "i2c-bus", because it's
not "the switch controller".

> +    description: |
> +      phandle to i2c controller which is used to configure the PCIe
> +      switch.

"Reference to the i2c adapter/bus used to configure the QPS615"

But I wonder if this somehow should be described on the particular i2c
bus and be referenced from here instead.

It's not obvious how to describe these components that sits on two
different busses - although I believe this binding refers to the
"configuration interface" sitting on the i2c bus, abut it's described on
the PCIe bus as it relates to power sequencing.

> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - switch-i2c-cntrl
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        pcie@0 {
> +            device_type = "pci";
> +            reg = <0x0 0x0 0x0 0x0 0x0>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            ranges;
> +
> +            bus-range = <0x01 0xff>;
> +
> +            qps615@0 {
> +                compatible = "pci1179,0623";
> +                reg = <0x10000 0x0 0x0 0x0 0x0>;
> +
> +                vdd-supply = <&vdd>;
> +		switch-i2c-cntrl = <&foo>;

Indentation looks off here.

Regards,
Bjorn

> +            };
> +        };
> +    };
> 
> -- 
> 2.42.0
> 

