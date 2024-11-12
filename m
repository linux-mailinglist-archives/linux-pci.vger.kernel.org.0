Return-Path: <linux-pci+bounces-16561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D37E9C60D3
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 19:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E20FB60A0D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF17205120;
	Tue, 12 Nov 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYOBihfF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9C20409A;
	Tue, 12 Nov 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427156; cv=none; b=aaNeMedXmHyYlJ2pk8yQ2V4tmx+0G3gBouKmFMMlBJYB4JUvtGwfp1i/p2TTQcqFvWPLHwv5EY/EMNVsdbIn5X1eyit1hLk1/JNmSTsUkm84lIuqBsdDk0W5HYxyNbY7GVZEcC+jGLNPb1iUth6PgmdAStXExd0v3nnStrHRiRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427156; c=relaxed/simple;
	bh=BleI3g/9Mgelj0hSQNkzA4/4uDaRN4Z/XLhqKzmcEOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cazjbap+KJlvxcGfuRQUG2BPtDdbi8qHieJmpNgZVK3v8Mh1Q6evJIpBDDE7m66HsCAoshu/F1DNSDVyuThXWMn3NH2YQfPuRdqdhZYz7Ri5+oMcRKqVWL2gkePbtiolTiyeUdUz4mA8jpBb9IMassrE9qPc9ClgemRGO7m6kxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYOBihfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CB1C4CECD;
	Tue, 12 Nov 2024 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731427155;
	bh=BleI3g/9Mgelj0hSQNkzA4/4uDaRN4Z/XLhqKzmcEOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYOBihfFEvWfaR9x6HoxpRiixjrLPzdHw3AC7d65JT0zJmFcqRaDU3DqumpVMuP3U
	 L+dKz61++MfqjLtTY8YrAE+kOlFaGCXB6xfFwbOymCnKB0chgXMfkf9+lPjXgMO5+S
	 cwZyeqY6VIAYir3vd2tPSscqw9BxZ/kEXtl8m0ZE7gFkcjlNef36otxZHhOX4dsyVl
	 y8BRMr1SGH7a0VdwTaoU7QGu3Cob6eoURtLb6XqbXddsLah+3aeWxixUn/tyBgIxiT
	 1mLoTxCaYtAYx9MyyXv4FzmlKk6pu8kBQOtIC8XOE+OciASiGo53fIb9IshrIi4kjj
	 B9gyxnpKVOfxw==
Date: Tue, 12 Nov 2024 09:59:13 -0600
From: Rob Herring <robh@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, bhelgaas@google.com, unicorn_wang@outlook.com,
	conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
	krzk+dt@kernel.org, lee@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pbrobinson@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: Re: [PATCH 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Message-ID: <20241112155913.GA973575-robh@kernel.org>
References: <cover.1731303328.git.unicorn_wang@outlook.com>
 <1edbed1276a459a144f0cb0815859a1eb40bfcbf.1731303328.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1edbed1276a459a144f0cb0815859a1eb40bfcbf.1731303328.git.unicorn_wang@outlook.com>

On Mon, Nov 11, 2024 at 01:59:37PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add binding for Sophgo SG2042 PCIe host controller.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
> new file mode 100644
> index 000000000000..d4d2232f354f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/sophgo,sg2042-pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 PCIe Host (Cadence PCIe Wrapper)
> +
> +description: |+

Don't need '|+'

> +  Sophgo SG2042 PCIe host controller is based on the Cadence PCIe core.

> +  It shares common features with the PCIe core and inherits common properties
> +  defined in Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml.

That's clear from the $ref. No need to say that in prose.

> +
> +maintainers:
> +  - Chen Wang <unicorn_wang@outlook.com>
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2042-pcie-host
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: reg
> +      - const: cfg
> +
> +  sophgo,syscon-pcie-ctrl:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the SYSCON entry

Please describe what you need to access.

> +
> +  sophgo,link-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Cadence IP link ID.

Is this an index or related to the syscon? Nak for the former, use 
linux,pci-domain. For the latter, add an arg to sophgo,syscon-pcie-ctrl.

> +
> +  sophgo,internal-msi:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Identifies whether the PCIE node uses internal MSI controller.

Wouldn't 'msi-parent' work for this purpose?

> +
> +  vendor-id:
> +    const: 0x1f1c
> +
> +  device-id:
> +    const: 0x2042
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: msi
> +
> +allOf:
> +  - $ref: cdns-pcie-host.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - sophgo,syscon-pcie-ctrl
> +  - sophgo,link-id
> +  - vendor-id
> +  - device-id
> +  - ranges

ranges is already required in the common schemas.

> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    pcie@62000000 {
> +      compatible = "sophgo,sg2042-pcie-host";
> +      device_type = "pci";
> +      reg = <0x62000000  0x00800000>,
> +            <0x48000000  0x00001000>;
> +      reg-names = "reg", "cfg";
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
> +               <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
> +      bus-range = <0x80 0xbf>;
> +      vendor-id = <0x1f1c>;
> +      device-id = <0x2042>;
> +      cdns,no-bar-match-nbits = <48>;
> +      sophgo,link-id = <0>;
> +      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
> +      sophgo,internal-msi;
> +      interrupt-parent = <&intc>;
> +    };
> -- 
> 2.34.1
> 

