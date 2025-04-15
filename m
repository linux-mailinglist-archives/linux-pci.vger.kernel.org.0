Return-Path: <linux-pci+bounces-25928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEBEA8A28D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 17:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3457A65CD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81381D7E4A;
	Tue, 15 Apr 2025 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSafZpYm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95A52DFA37;
	Tue, 15 Apr 2025 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744730073; cv=none; b=GugWbU/iub+ZBzN7z4CTvBz+MCuuhtvvFtV5Z4bqrT7GLhhM716BEsMOYxntRm/E1NUA7jgs2Q1yZSTMOjt2RNpGwuYIhEXZYK9T0kyDPIG3YLK4uhsBrhH62TIHIwz028lgXDJwoktcnGFvgzz6c7fhMkXS17HjoSYSoaHek7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744730073; c=relaxed/simple;
	bh=gD0cmObSHxYd8bgM73eRn1ghAqi73Kk6fOmAAfdaZKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMrtfgQhnIhw+XETNnte2D/bg0TPpYnvHGEmK/CyTTu1NsMLxlghGL0HBf6ZzW/nrfU3lvgnkRv+EsXoWDZafoyRJz5qMcJUEAqYvC2G6D+eCbp1qfmR39GautXfDnwQesQJp5iU60oEOFTxchy1nQ42KbiYOVlt/lTvx9M3zro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSafZpYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DB6C4CEEB;
	Tue, 15 Apr 2025 15:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744730073;
	bh=gD0cmObSHxYd8bgM73eRn1ghAqi73Kk6fOmAAfdaZKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uSafZpYmqe51N/TKEuPKox9rzCSy/nYX4sAommp3vsni/I5odJAfoDIY4BV0Rfo7k
	 RkhFjcOc8Vetd7Wgw9Qd1SgAVwCtjSf4Ueyb75g9Ciqr1ppkQ1Y5/mQzKsU0xxuD4l
	 sRsml09qhQ8oURfC9/6Jjy7GI9/kU3d6B1VsW7JTLeUTXMRR3YG9R6h+ERziSlItbL
	 HWNHaYtM+c5yNoHJblQdR+rN70WeC6klZOJvVSgBHw60MnLRb+p21J7hUO51686KPB
	 qjx4b0rCm0aS8lbyFGlpsTLbFQ8wEaX095hFWZx1wQ7dGTpl63bnMCfYP27rZI+VUP
	 66CzN/Oy4GFCA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2963dc379so943869166b.2;
        Tue, 15 Apr 2025 08:14:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqlAefWQpbAYB9cJ3IEGal6SLYo43m8I0xhGwoXzxnB6geHHcIK6x0LhYEQyGRRpYgbz7BMPKPPYBWDXt+@vger.kernel.org, AJvYcCVGCEsUidmjUkweH39UE6acmPSJ4seIXxB5gayK4oReGimWuFxxowTgr7qHiZMKB6GSR2DC1GMHaN+V@vger.kernel.org, AJvYcCXisZmK07WsQTx+jNIvwrY3fulje5w0yxXfDTSY6/4bqRyFtR1zium1tenGIEGzhU2C+izutR/LxwAU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ZYMYpt83lDLwcd+DB9ycMLWva63bKFoQm84wypGxtqBFP43F
	vcv3MKtYEPLg+1xlGXM/JXteuiK0E5PHbT/LLNpf5fUPWiBcFTHms+rxKUF6CU+z5z9fSYsYCkz
	5Y/trJ5quPMCykq7PD8a0qFEWLg==
X-Google-Smtp-Source: AGHT+IEUzUqVPUBjh4HKSirKc2PT7Kum3sp+RXYYtJjDM6hVuDVxtEtFPs/ve7h6W24RoFtDIYrOgQG2iWs/Ezl2CPc=
X-Received: by 2002:a17:907:dab:b0:ac7:95ae:747f with SMTP id
 a640c23a62f3a-acad36a3f79mr1448223466b.45.1744730071715; Tue, 15 Apr 2025
 08:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414032304.862779-1-sai.krishna.musham@amd.com> <20250414032304.862779-2-sai.krishna.musham@amd.com>
In-Reply-To: <20250414032304.862779-2-sai.krishna.musham@amd.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 15 Apr 2025 10:14:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJvRFR1Su8ajWOiAKaz2n1JH9RK0RojhhPKsiKsGeGm4Q@mail.gmail.com>
X-Gm-Features: ATxdqUGHsQF9Gw0uE7e4ZeB3yGu01jMsGh4Mx_GAgeR_dmsPGtuFO598otWvFBo
Message-ID: <CAL_JsqJvRFR1Su8ajWOiAKaz2n1JH9RK0RojhhPKsiKsGeGm4Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v7 1/2] dt-bindings: PCI: xilinx-cpm: Add `cpm_crx`
 and `cpm5nc_fw_attr` properties
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	cassel@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michal.simek@amd.com, 
	bharat.kumar.gogada@amd.com, thippeswamy.havalige@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2025 at 10:23=E2=80=AFPM Sai Krishna Musham
<sai.krishna.musham@amd.com> wrote:
>
> Add the `cpm_crx` property to manage the PCIe IP reset, and
> `cpm5nc_fw_attr` property to clear firewall after link reset, while
> maintaining backward compatibility with existing device trees.

You aren't adding properties. You are adding entries to 'reg'.

But the real problem here is you are adding reset and firewall
controls, but not using the respective bindings. It looks like you
need to use the 'resets' and possibly the 'access-controllers'
bindings. Unless these controls are really part of the PCIe bridge
(and only for it).

>
> Also, incorporate `reset-gpios` in example for GPIO-based handling of
> the PCIe Root Port (RP) PERST# signal for enabling assert and deassert
> control.

"Also" is a red flag for that change should be a separate commit.

>
> The `reset-gpios` and `cpm_crx` properties must be provided for CPM,
> CPM5 and CPM5_HOST1. For CPM5NC, all three properties - `reset-gpios`,
> `cpm_crx` and `cpm5nc_fw_attr` must be explicitly defined to ensure
> proper functionality.
>
> Include an example DTS node and complete the binding documentation for
> CPM5NC. Also, fix the bridge register address size in the example for
> CPM5.
>
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes for v7:
> - Update CPM5NC device tree binding.
> - Add CPM5NC device tree example node.
> - Update commit message.
>
> Changes for v6:
> - Resolve ABI break.
> - Update commit message.
>
> Changes for v5:
> - Remove `reset-gpios` property from required as it is already present
>   in pci-bus-common.yaml
> - Update commit message
>
> Changes for v4:
> - Add CPM clock and reset control registers base to handle PCIe IP
>   reset.
> - Update commit message.
>
> Changes for v3:
> - None
>
> Changes for v2:
> - Add define from include/dt-bindings/gpio/gpio.h for PERST# polarity
> - Update commit message
> ---
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 129 +++++++++++++++---
>  1 file changed, 109 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml=
 b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index d674a24c8ccc..ed07896f763e 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -9,9 +9,6 @@ title: CPM Host Controller device tree for Xilinx Versal =
SoCs
>  maintainers:
>    - Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
>
> -allOf:
> -  - $ref: /schemas/pci/pci-host-bridge.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -21,18 +18,12 @@ properties:
>        - xlnx,versal-cpm5nc-host
>
>    reg:
> -    items:
> -      - description: CPM system level control and status registers.
> -      - description: Configuration space region and bridge registers.
> -      - description: CPM5 control and status registers.
>      minItems: 2
> +    maxItems: 4
>
>    reg-names:
> -    items:
> -      - const: cpm_slcr
> -      - const: cfg
> -      - const: cpm_csr
>      minItems: 2
> +    maxItems: 4
>
>    interrupts:
>      maxItems: 1
> @@ -64,18 +55,94 @@ properties:
>  required:
>    - reg
>    - reg-names
> -  - "#interrupt-cells"
> -  - interrupts
> -  - interrupt-map
> -  - interrupt-map-mask
>    - bus-range
>    - msi-map
> -  - interrupt-controller
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - xlnx,versal-cpm-host-1.00
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: CPM system level control and status registers=
.
> +            - description: Configuration space region and bridge registe=
rs.
> +            - description: CPM clock and reset control registers.
> +          minItems: 2
> +        reg-names:
> +          items:
> +            - const: cpm_slcr
> +            - const: cfg
> +            - const: cpm_crx

The xlnx,versal-cpm-host-1.00 no longer has cpm_csr registers? Where
did they go? This is an ABI issue.

> +          minItems: 2
> +      required:
> +        - "#interrupt-cells"
> +        - interrupts
> +        - interrupt-map
> +        - interrupt-map-mask
> +        - interrupt-controller
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - xlnx,versal-cpm5-host
> +              - xlnx,versal-cpm5-host1
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: CPM system level control and status registers=
.
> +            - description: Configuration space region and bridge registe=
rs.
> +            - description: CPM5 control and status registers.
> +            - description: CPM clock and reset control registers.
> +          minItems: 3
> +        reg-names:
> +          items:
> +            - const: cpm_slcr
> +            - const: cfg
> +            - const: cpm_csr
> +            - const: cpm_crx
> +          minItems: 3
> +      required:
> +        - "#interrupt-cells"
> +        - interrupts
> +        - interrupt-map
> +        - interrupt-map-mask
> +        - interrupt-controller
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - xlnx,versal-cpm5nc-host
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: CPM system level control and status registers=
.
> +            - description: Configuration space region and bridge registe=
rs.
> +            - description: CPM clock and reset control registers.
> +            - description: CPM5NC Firewall attribute register.

Just 1 register?

> +          minItems: 2
> +        reg-names:
> +          items:
> +            - const: cpm_slcr
> +            - const: cfg
> +            - const: cpm_crx
> +            - const: cpm5nc_fw_attr

The block name in the entry is redundant. Drop 'cpm5nc_'.

> +          minItems: 2
>
>  unevaluatedProperties: false
>
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
>
>      versal {
>                 #address-cells =3D <2>;

