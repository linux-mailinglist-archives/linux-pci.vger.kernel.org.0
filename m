Return-Path: <linux-pci+bounces-9381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4591AB4E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 17:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA075B285BB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B9D198E89;
	Thu, 27 Jun 2024 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JU13wlmS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F06198E71;
	Thu, 27 Jun 2024 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502287; cv=none; b=YyILKoaAEPtCp4a3V6ZFXtZi+LD7pbzIGl4gAuHuLRTtUF7RXBrvFxTLLItevk394gQKpt1gePqkRn8s6z6/v7ZjIhRw568jY/P44SEfrDthYsYBsvDN34IbXvIRVfbVeEGIxi6PbiHwZ4qNLl2VKJvy99lY+vOZbUG0ch+EpWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502287; c=relaxed/simple;
	bh=wxLzTDpEy7fEUqTDhRZsA8Ui7D8BuLYyJagL/PF5qUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1YlaZvhylbORHR12W/3FO85Lm9b/PwGPc77J1pcUx2D5mMmhQ6cQvNK34lSD1GgITTt+id0Li1knAi8luTvmpMC0KXxzeRfB2oQ4LX/4RsIXkFC4ZwkFDwLo/fjWX3ardVF/6Z4UALWLh6EiUH8IKpgvIYmco7/P/32h276TZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU13wlmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE721C2BBFC;
	Thu, 27 Jun 2024 15:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719502287;
	bh=wxLzTDpEy7fEUqTDhRZsA8Ui7D8BuLYyJagL/PF5qUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JU13wlmSWUBHxHsfZ97TRsc/9fMuDshO44IMPpp5wIVEhfFOk/NTH1Qv/qetpmluT
	 1kx1VpMufyQFVyxfq1WQuVE9lZW25YRoetH8leXKF5od+/O+UgJv8Tnw0CVI5eQhZf
	 nqnpTt4O/bMpKPv6lfKtapMytVnhDUEqGxLG/EyVZ6wF/J/5ljxC+Hv96l9BM1lVX8
	 7wXTLZJKwecarQF0i6EbEXHpIyC3GLT8tyS3AMfsqbs1XUMYwrcdlbRSsD8nUpWJWD
	 rcPf8bYAV9FZXEBBA/3EZxi6rkyLp29xghivlitweBUQJObhUj1gn+iK82E3j6SIxh
	 YTrEH/BDjxzFQ==
Date: Thu, 27 Jun 2024 09:31:25 -0600
From: Rob Herring <robh@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/7] dt: bindings: add qcom,qps615.yaml
Message-ID: <20240627153125.GA3469266-robh@kernel.org>
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

On Wed, Jun 26, 2024 at 06:07:49PM +0530, Krishna chaitanya chundru wrote:
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
> +
> +  The power controlled by the GPIO's, if we enable the GPIO's the
> +  power to the switch will be on.
> +
> +  The QPS615 PCIe switch is configured through I2C interface before
> +  PCIe link is established.
> +

As a PCI device and implementing a PCI bus, you need to reference 
pci-pci-bridge.yaml. And you'll need to fix your example when you add 
that.

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
> +      Phandle to the vdd input voltage which are fixed regulators which
> +      in are mapped to the GPIO's.
> +
> +  switch-i2c-cntrl:
> +    description: |
> +      phandle to i2c controller which is used to configure the PCIe
> +      switch.

There's a somewhat standard property for this purpose: i2c-bus

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

Unless there's a h/w limitation, you don't need this.

> +
> +            qps615@0 {
> +                compatible = "pci1179,0623";
> +                reg = <0x10000 0x0 0x0 0x0 0x0>;
> +
> +                vdd-supply = <&vdd>;
> +		switch-i2c-cntrl = <&foo>;
> +            };
> +        };
> +    };
> 
> -- 
> 2.42.0
> 

