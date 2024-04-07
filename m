Return-Path: <linux-pci+bounces-5834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6744589B004
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 11:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852FD1C20974
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6944D12E4A;
	Sun,  7 Apr 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovpYySem"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA50125DE
	for <linux-pci@vger.kernel.org>; Sun,  7 Apr 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712481087; cv=none; b=FzsVrWqrgMlO4gQsHHOZCj9kC5FCZwQY3gfubJUQmIf4Z2noqjdejigfyC9vmGdaIPFH2cXswc6BOLvWTVsZsqE9SOOBhVL1joj1+m9sd4+yPhVpluQ5P6C0pIrp+8AZPZKcCTSz0SPGIUhEt6WQ5EklWXIJyzb+LDEOkuHRK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712481087; c=relaxed/simple;
	bh=lXul3KyzGjRuiUvtWHlr7bqBlU2M6CPHl9ZLwiyZbGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eNNDxwVOiOzhQdI7nutxMVzfIGS2yDCMIIdySPV7CAHkRAWIQpimf7vnLr5oBq0wYfuzk7ZW9DbD5r+P4dj7RHqB+X4DfK0duc6ZiBo/e0FjYNMh2SvgH5fdmSK5DBpJ+8r1IAMZHi5MuZUzzqN35sb4r2WJNmxOpv0jswut3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ovpYySem; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51a80b190bso148282466b.3
        for <linux-pci@vger.kernel.org>; Sun, 07 Apr 2024 02:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712481084; x=1713085884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P4+Ds6zMskgTtFTucouK+9QjpIsEysLLyxn6ITWVq4w=;
        b=ovpYySemNLD0G4T6Lu54xvQ9rgNsAJjrTN8Yzcm5a21FpcltuCh9u5GHTeSvbHG0Q8
         pIvBqRUMbp/PyUwqMRtjYPAg1mHwqlZWaoSkXFDTj+JsNHk7rJmXYP7IrkvtgN6rRGoK
         TUKydj0aFgK5Fnaul1fiXVnU8E2kIozHrk5n/bYKmvQDO8vQ7p/Pq3MxFS9RpJf/sRM9
         mPFPJjkl/ccgk3Z0tXnvzHTb+AZarKMG/pzoicm64swDqrBXGqk9wOCRZBy9xLeP+JaN
         ul0ZFTtkA0Fzfn9P/TZHei3Zu1Zqa/r7YJTUkDZFBJez3in6jM+/A4oPEFBG80DmTi/Z
         aTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712481084; x=1713085884;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4+Ds6zMskgTtFTucouK+9QjpIsEysLLyxn6ITWVq4w=;
        b=h66ZN9KUBDyuMKHMDXmrKsqiXo41DPr4luUssKt8Uvxo/71VbbgTvX09L4IJYIEY7f
         OByVXxV/ERh89Xc5Yc1yJg1HmE++ccTvP5I38fjfogf62fHyDimTXpjuGULxCnxzvB1e
         I+4sLuv6zS/GviJjy3z4/ClRni+rceSW14PKwRuvwRODubHuAaLEaQIFVBLDhZsGlK65
         oQ5JXlrDfxM0eE4ILYIDBHSZd5qJmVk7t/3BT32tWX15JTVzo8+I3Q2tPQ6FzztXW6pQ
         wu7EN+FiGihrz0vEYeGkYUiCCx/jPzKkKHyVtKsZSk/S/pImWNr6StLGFqG7lLGHbdji
         Q9OA==
X-Forwarded-Encrypted: i=1; AJvYcCU/+/JbXA94TLBQ8tF7XwgBCtWDnaDyq1edDXRJJhkmsTy3t0Z0XKGLRvUYAnFyk45jfkcU0UzGSpzvT8pD+KG6R1jbTMWIeMcl
X-Gm-Message-State: AOJu0YwrCHswok1beLoaVMZFbFCaZ4EW6YLvF4+cse/coQETyKbVe9sH
	hz0bdeAm1jObOcisPwRJmaIk9zBHA5tTaaG7HNB3k30F2NaAiVZC57voihlbQOc=
X-Google-Smtp-Source: AGHT+IHW3MCBV9fAzKY313gU9vtRgWeCJoixZyjUuRHZHYE5Ty5D2Xu17vGhgWSq7U8DnloBWGqJFg==
X-Received: by 2002:a50:8ad1:0:b0:56b:d1c2:9b42 with SMTP id k17-20020a508ad1000000b0056bd1c29b42mr5907261edk.29.1712481083695;
        Sun, 07 Apr 2024 02:11:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id eo9-20020a056402530900b0056c1380a972sm2703802edb.74.2024.04.07.02.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 02:11:23 -0700 (PDT)
Message-ID: <2ece9ac2-899c-4185-b0f3-8ab939afc1e5@linaro.org>
Date: Sun, 7 Apr 2024 11:11:21 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: PCI: altera: Convert to YAML
To: matthew.gerlach@linux.intel.com, bhelgaas@google.com,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240405145322.3805828-1-matthew.gerlach@linux.intel.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240405145322.3805828-1-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 16:53, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Convert the device tree bindings for the Altera Root Port PCIe controller
> from text to YAML.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v2:
>  - Move allOf: to bottom of file, just like example-schema is showing

No, just open it and you will see it is placed differently...

>  - add constraint for reg and reg-names

Not complete...

>  - remove unneeded device_type
>  - drop #address-cells and #size-cells
>  - change minItems to maxItems for interrupts:
>  - change msi-parent to just "msi-parent: true"
>  - cleaned up required:
>  - make subject consistent with other commits coverting to YAML
>  - s/overt/onvert/g
> ---
>  .../devicetree/bindings/pci/altera-pcie.txt   |  50 ---------
>  .../bindings/pci/altr,pcie-root-port.yaml     | 106 ++++++++++++++++++
>  2 files changed, 106 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
> deleted file mode 100644
> index 816b244a221e..000000000000
> --- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -* Altera PCIe controller
> -
> -Required properties:
> -- compatible :	should contain "altr,pcie-root-port-1.0" or "altr,pcie-root-port-2.0"
> -- reg:		a list of physical base address and length for TXS and CRA.
> -		For "altr,pcie-root-port-2.0", additional HIP base address and length.
> -- reg-names:	must include the following entries:
> -		"Txs": TX slave port region
> -		"Cra": Control register access region
> -		"Hip": Hard IP region (if "altr,pcie-root-port-2.0")
> -- interrupts:	specifies the interrupt source of the parent interrupt
> -		controller.  The format of the interrupt specifier depends
> -		on the parent interrupt controller.
> -- device_type:	must be "pci"
> -- #address-cells:	set to <3>
> -- #size-cells:		set to <2>
> -- #interrupt-cells:	set to <1>
> -- ranges:	describes the translation of addresses for root ports and
> -		standard PCI regions.
> -- interrupt-map-mask and interrupt-map: standard PCI properties to define the
> -		mapping of the PCIe interface to interrupt numbers.
> -
> -Optional properties:
> -- msi-parent:	Link to the hardware entity that serves as the MSI controller
> -		for this PCIe controller.
> -- bus-range:	PCI bus numbers covered
> -
> -Example
> -	pcie_0: pcie@c00000000 {
> -		compatible = "altr,pcie-root-port-1.0";
> -		reg = <0xc0000000 0x20000000>,
> -			<0xff220000 0x00004000>;
> -		reg-names = "Txs", "Cra";
> -		interrupt-parent = <&hps_0_arm_gic_0>;
> -		interrupts = <0 40 4>;
> -		interrupt-controller;
> -		#interrupt-cells = <1>;
> -		bus-range = <0x0 0xFF>;
> -		device_type = "pci";
> -		msi-parent = <&msi_to_gic_gen_0>;
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie_0 1>,
> -			            <0 0 0 2 &pcie_0 2>,
> -			            <0 0 0 3 &pcie_0 3>,
> -			            <0 0 0 4 &pcie_0 4>;
> -		ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
> -			  0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
> -	};
> diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> new file mode 100644
> index 000000000000..999dcda05f55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2024, Intel Corporation

This is derivative of previous work, which is easily visible by doing
the same mistakes in DTS as they were before.

You now added fresh copyrights ignoring all previous work, even though
you copied it. I don't agree.

If you want to ignore previous copyrights, then at least don't copy
existing code... although even that would not be sufficient.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/altr,pcie-root-port.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera PCIe Root Port
> +
> +maintainers:
> +  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
> +
> +properties:
> +  compatible:
> +    items:

Drop items.

> +      - enum:
> +          - altr,pcie-root-port-1.0
> +          - altr,pcie-root-port-2.0
> +

Missing reg with constraints.

> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 0
> +      - const: 0
> +      - const: 0
> +      - const: 7
> +
> +  interrupt-map:
> +    maxItems: 4
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  msi-parent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - device_type
> +  - interrupts
> +  - interrupt-map
> +  - interrupt-map-mask
> +
> +unevaluatedProperties: false
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#

That's deprecated, as explained in its description.  You should use
pci-host-bridge.yaml.



> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - altr,pcie-root-port-1.0
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: TX slave port region
> +            - description: Control register access region
> +
> +        reg-names:
> +          items:
> +            - const: Txs
> +            - const: Cra
> +
> +    else:
> +      properties:
> +        reg:
> +          items:
> +            - description: Hard IP region
> +            - description: TX slave port region
> +            - description: Control register access region
> +
> +        reg-names:
> +          items:
> +            - const: Hip
> +            - const: Txs
> +            - const: Cra
> +

unevaluated goes here, just like example-schema.

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    pcie_0: pcie@c00000000 {
> +        compatible = "altr,pcie-root-port-1.0";
> +        reg = <0xc0000000 0x20000000>,
> +              <0xff220000 0x00004000>;
> +        reg-names = "Txs", "Cra";
> +        interrupt-parent = <&hps_0_arm_gic_0>;
> +        interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +        #interrupt-cells = <1>;
> +        bus-range = <0x0 0xff>;
> +        device_type = "pci";
> +        msi-parent = <&msi_to_gic_gen_0>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        interrupt-map-mask = <0 0 0 7>;
> +        interrupt-map = <0 0 0 1 &pcie_intc 1>,
> +                        <0 0 0 2 &pcie_intc 2>,
> +                        <0 0 0 3 &pcie_intc 3>,
> +                        <0 0 0 4 &pcie_intc 4>;
> +        ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
> +                  0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;

That's two entries.

Best regards,
Krzysztof


