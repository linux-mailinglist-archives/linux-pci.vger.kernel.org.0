Return-Path: <linux-pci+bounces-5424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58311892436
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 20:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB23A28260F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 19:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71181136E01;
	Fri, 29 Mar 2024 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxcmKyo8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7881386A8
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740471; cv=none; b=VBtQdyN9KTnOrvOMv4THYsZC4rGrTl3rPu7oQFq9G/zAT9Ff+G4TgxUKuzmNrf/7g4TbNyTfVQljDrcBilltbxVRgy56SlVF5DYjGqwgVCRmHHkyXTPwfCBjXDcs7SeMGg2mit5PpydWcYSXCUVWM364OJwfYA5Hx5uRzhrmk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740471; c=relaxed/simple;
	bh=HQu5RRVz47jUdl+Bxn7MiN5S9bgEl42EXv8NwJt6Wow=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E/uRl3MoI9dzuuJd/+AZriU1k68bQvltMwIZpN951Z9qPIyY3yvO01+pm+XycOgZAKkumEJA2ZMga4HTFeayIGgGCjQRfVwcgkDfh6UdAZ0u2nxfPoch6BqvCYVv5e73YMzIrbMHNqsQYRMJ+nH9lUE29qDyhrnaxRCXLKO+afU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kxcmKyo8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4154471fb81so13420965e9.0
        for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 12:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711740468; x=1712345268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ypH1YCAf8GB4uY1YvbslKIBvLhcq3mEbEzkW3A0+meY=;
        b=kxcmKyo83US51szYlhKSYPQmbwbLWaLBbEuB6Fy+sbILF1zuIgHx36v+F4kQGfeVwg
         IV4HzCfdCQAIurHS9ZGrIV5SqOg/ze7GAB0gTq6SWj2VEqhK4zm9lMubdEu1mpkAheqd
         v24gpHhFAHlTjPlyW5xPviZg/EZAxGmDjka6wFzvswB9FvX7XR/c/h9M8boWqBdRWW+X
         QUpxKHxfmahnXqcdkQA7dNUdPWdlLJ6ZrZV4OA1UyglZbZYpzexJSvBzFs1KBRbjGTkK
         BI1oYF4/oNf+pl/KMBi0rIGgF91rlah29fOdV5n0nRY8h2V0IKe+/fQS9M34SQXUJVej
         a1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711740468; x=1712345268;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypH1YCAf8GB4uY1YvbslKIBvLhcq3mEbEzkW3A0+meY=;
        b=SUG81NEGdL2f4s4860Jmqq6keW29aF09n2LDOFy+ruyGR0Bht/qZDhSsjTDJ7Ca7XL
         RqEwqR4feXtLdk06ltQAzmiXIsMyKNzzOUNledV0VeQshsQzYdD7JY89LqY1kb0/DIFt
         BqT+nacg+8EaboNVbe8yX3HDDagTtttsehZQuy1vCaYg7F5sTTIxLKos0hnJ+FNXNWsS
         ivIdiE/jcuJUePYuxdbm4CMKVE+r0qf5d7NTGbMSX32u6285pm39ajPeAiO7j5ElwIwV
         fm5b0xxUJHCAxSLVnPwGyBQ5tWPQRljRKjFnG0dDuKLZqc5dHBgaPgXALbn+oC8dJanK
         SAGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLfm9WSX/uwf+zb6nF4WsAWDF0nzF2WKXUkH/KZ7/78sVYgkvEkgkazTb8BUXwZDZCh3g2VUGxd0MOwYEGHpyx5AG9lZVEWe4Q
X-Gm-Message-State: AOJu0YxSqv8F3pms48FRSsBiW7sKNXMPie42GH5ZVahW53v2LMJPNiFU
	2puxqAmINDrUtz9PXnhoKsJCW7rZ3iDKwcKsSV/TV3ubLAW2V7EIDhW37zxyfr4=
X-Google-Smtp-Source: AGHT+IFU5eq/3/POHnnKuPASTFQW+rfsPzR0soL9KpW9Y3B6mgDpecIBRzjTWMbYFtBtQZDBXZtEfA==
X-Received: by 2002:a05:600c:470e:b0:414:9141:14ba with SMTP id v14-20020a05600c470e00b00414914114bamr2490718wmo.22.1711740467493;
        Fri, 29 Mar 2024 12:27:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b0041469869d11sm9342245wmq.47.2024.03.29.12.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 12:27:46 -0700 (PDT)
Message-ID: <bfa6150b-e27e-41c3-a1a7-41e46f52f6ea@linaro.org>
Date: Fri, 29 Mar 2024 20:27:44 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pci: altera: covert to yaml
To: matthew.gerlach@linux.intel.com, joyce.ooi@intel.com,
 bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329170031.3379524-1-matthew.gerlach@linux.intel.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240329170031.3379524-1-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 18:00, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Covert the device tree bindings for the Altera Root
> Port controller from text to yaml.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---

...

> diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> new file mode 100644
> index 000000000000..8f1ad1362ad1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2024, Intel Corporation
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
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - altr,pcie-root-port-1.0
> +          - altr,pcie-root-port-2.0
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 3
> +
> +  reg-names:
> +    description:
> +      TX slave port region (Txs)
> +      Control register access region (Cra)
> +      Hard IP region if altr,pcie-root-port-2.0 (Hip)

All these go to reg as description of items.

Both - reg and reg-names - need constraints per variant in
allOf:if:then:. Move allOf: to bottom of file, just like example-schema
is showing.


> + 
> +    items:
> +      - const: Txs
> +      - const: Cra
> +      - const: Hip
> +    minItems: 2
> +
> +  device_type:
> +    const: pci

I don't think you need it.

> +
> +  "#address-cells":
> +    const: 3

Drop

> +
> +  "#size-cells":
> +    const: 2

Drop

> +
> +  interrupts:
> +    minItems: 1

This should be maxItems.

> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 0
> +      - const: 0
> +      - const: 0
> +      - const: 7

I guess as well.

> +
> +  interrupt-map:
> +    maxItems: 4
> +
> +  "#interrupt-cells":
> +    const: 1

Drop

> +
> +  msi-parent:
> +    description: Link to the hardware entity that serves as the MSI controller.

Just true.

Please open existing, recent PCI bindings and look how it is done.

> +
> +  bus-range:
> +    description: PCI bus numbers covered.

Drop

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - device_type
> +  - "#address-cells"
> +  - "#size-cells"
> +  - interrupts
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - "#interrupt-cells"

This also needs cleaning.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pcie_0: pcie@c00000000 {
> +        compatible = "altr,pcie-root-port-1.0";
> +        reg = <0xc0000000 0x20000000>,
> +            <0xff220000 0x00004000>;

Misaligned.

> +        reg-names = "Txs", "Cra";
> +        interrupt-parent = <&hps_0_arm_gic_0>;
> +        interrupts = <0 40 4>;

Use defines for common constnats.

> +        #interrupt-cells = <1>;
> +        bus-range = <0x0 0xFF>;

Lowercase hex

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
> +              0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;

Misaligned.


Best regards,
Krzysztof


