Return-Path: <linux-pci+bounces-35220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9467B3D88C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 07:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CF9177454
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 05:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C491B2629F;
	Mon,  1 Sep 2025 05:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+mVcWWK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E8133D8;
	Mon,  1 Sep 2025 05:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756703947; cv=none; b=eYPH86b623z+PH8QYomsA8YHKs7Usc7QT90BfW7VAS/XndGbKxMROoBrQcZncAPZ5QZv1Xk9E5zG3k0rYB74HTqLFWj0claqz0bf14mLn5ZIS/H80LZgkdTdDKIz4oYCjxruWyMd9i2GS3vlXWcJ+ng9btV378QFiOZjnplIEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756703947; c=relaxed/simple;
	bh=cwAMu5onj7dzRFFgnuDrLv7U2DyCY/Mo9N485T7Z6bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCNAEoPCYBxStwUA8DVYceAoDpV94JUCNIFoh2GFKx4p+02d0eTt3Hr1XZ9uVJECA9JCtxLHhpfJRAOkBygxwjaIbCLyIXbYy9fFcZ5AFRASNw0P2gYqbQTu/X67bmE1NNVBl6dpMJkdo97FzDhT3M4yi+T2Mjbq+MaxaTFthNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+mVcWWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797DCC4CEF0;
	Mon,  1 Sep 2025 05:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756703947;
	bh=cwAMu5onj7dzRFFgnuDrLv7U2DyCY/Mo9N485T7Z6bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+mVcWWKKMaqSFpvJpMQGGNtT0C5jGJPDpENupzxYPJMm9CyRZQQoFIUi/v5zficI
	 qTaVnAbuKus9KLI4Et9m4p/s5rGs56FXFmiy3vnjU67jWcvyMXtxCO2EE5WmL6sjk6
	 83Q0Y/DZX64b2cDu4PDnOojjhI1FBXqSJNcVXCPp8fTa83ZiyugAL2eSI/4lxzJG7d
	 ZVxe7/YJu5eOol0vsdvbgFjV5W/P4zjS4Rb8XzHx+7DBhHqEU4KLpgsf0bMx9yR7R1
	 0sb9OW8zsrsgaPcpUam1yimCvmjzfQO1F6pIQ9NUqlwyyr3KAJwgKtBGCNMBLkun0O
	 dWb45ye6Q41+g==
Date: Mon, 1 Sep 2025 07:19:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.zabel@pengutronix.de, johan+linaro@kernel.org, quic_schintav@quicinc.com, 
	shradha.t@samsung.com, cassel@kernel.org, thippeswamy.havalige@amd.com, 
	mayank.rana@oss.qualcomm.com, inochiama@gmail.com, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: eic7700: Add Eswin eic7700 PCIe
 host controller
Message-ID: <20250901-congenial-weightless-parakeet-42d2de@kuoka>
References: <20250829082021.49-1-zhangsenchuan@eswincomputing.com>
 <20250829082237.1064-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829082237.1064-1-zhangsenchuan@eswincomputing.com>

On Fri, Aug 29, 2025 at 04:22:37PM +0800, zhangsenchuan@eswincomputing.com wrote:
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +
> +properties:
> +  compatible:
> +    const: eswin,eic7700-pcie
> +
> +  reg:
> +    maxItems: 3
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +      - const: mgmt
> +
> +  ranges:
> +    maxItems: 3
> +
> +  num-lanes:
> +    const: 4

If that's const, you do not need it. It's implied by the compatible.
I see some other bindings do similarly and I think that's not the
correct choice.

Well, maybe @Rob knows if PCI is different here anyhow?

> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 9
> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +      - const: inta
> +      - const: intb
> +      - const: intc
> +      - const: intd
> +      - const: inte
> +      - const: intf
> +      - const: intg
> +      - const: inth
> +
> +  interrupt-map:
> +    maxItems: 4
> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 0
> +      - const: 0
> +      - const: 0
> +      - const: 7
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: mstr
> +      - const: dbi
> +      - const: pclk
> +      - const: aux
> +
> +  resets:
> +    maxItems: 3
> +
> +  reset-names:
> +    items:
> +      - const: cfg
> +      - const: powerup
> +      - const: pwren
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - num-lanes
> +  - interrupts
> +  - interrupt-names
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - '#interrupt-cells'
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@54000000 {
> +            compatible = "eswin,eic7700-pcie";
> +            reg = <0x0 0x54000000 0x0 0x4000000>,
> +                  <0x0 0x40000000 0x0 0x800000>,
> +                  <0x0 0x50000000 0x0 0x100000>;
> +            reg-names = "dbi", "config", "mgmt";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            ranges = <0x81000000 0x0 0x40800000 0x0 0x40800000 0x0 0x800000>,
> +                     <0x82000000 0x0 0x41000000 0x0 0x41000000 0x0 0xf000000>,
> +                     <0xc3000000 0x80 0x00000000 0x80 0x00000000 0x2 0x00000000>;
> +            bus-range = <0x0 0xff>;
> +            clocks = <&clock 562>,
> +                     <&clock 563>,
> +                     <&clock 564>,
> +                     <&clock 565>;
> +            clock-names = "mstr", "dbi", "pclk", "aux";
> +            resets = <&reset 8 (1 << 0)>,
> +                     <&reset 8 (1 << 1)>,
> +                     <&reset 8 (1 << 2)>;
> +            reset-names = "cfg", "powerup", "pwren";
> +            interrupts = <220>, <179>, <180>, <181>, <182>, <183>, <184>, <185>, <186>;
> +            interrupt-names = "msi", "inta", "intb", "intc", "intd",
> +                              "inte", "intf", "intg", "inth";
> +            interrupt-parent = <&plic>;
> +            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +            interrupt-map = <0x0 0x0 0x0 0x1 &plic 179>,
> +                            <0x0 0x0 0x0 0x2 &plic 180>,
> +                            <0x0 0x0 0x0 0x3 &plic 181>,
> +                            <0x0 0x0 0x0 0x4 &plic 182>;
> +            device_type = "pci";
> +            num-lanes = <0x4>;

That's not a hex number, but decimal.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


