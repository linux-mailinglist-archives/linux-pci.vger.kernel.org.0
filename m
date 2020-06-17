Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0301FD7E9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 23:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFQVuk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 17:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQVuk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 17:50:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF1AC06174E;
        Wed, 17 Jun 2020 14:50:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v24so1547679plo.6;
        Wed, 17 Jun 2020 14:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2inp6DL1Tpkycn57HGb7bKgExPCkT7AU0S7N4Zm5vFs=;
        b=Gwvvo9mOU5t201a9zj5JmgtflABhfhYczUd+LVugvwo8+GDqTuA5Mkec/W06P8aNIB
         dDo0nW2p8dh9+V9NSxCHvhVQiRYywvotNaAX5duHdVGnOIa1YAsQXM6lF6qYzE0d1S8q
         7CACGCuNASoQIEoi1nT8NkEULYYgzcsVFqOqFhtZdw094seNXsZur69I1czBiEPz7mqI
         tmi/pMSL+OrVvq5RG4+KJUYwdzOWMBaIp8IbN++5K/ThkY7kam+ezfkqPhcDkpeY45IO
         SQRAA6d9wG14qiuo6VxD/C6YsV5jw5Y/U4MYKBqG+ompA39r2egYNBJbFFrBS90fYmNM
         Utfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2inp6DL1Tpkycn57HGb7bKgExPCkT7AU0S7N4Zm5vFs=;
        b=SJEL8aaVvbF/2fNhK8/xqO0QME5IhhDUFdZCCTRj2zLN+O5jPXu4cRxnh4G/eEkbwL
         +tO+qLlM6l6mAjIKLcHe7r0f0VZ3Nb/VGhF1HvLYinwk2xvgeEjfgrH5mV6Gr3xMSawB
         GWwGPtiKn8qilgPx7L/zIJ4RVW9RoA3dzhXVGLsJkUWZjjaiILPmo379F5jiTEapF1ID
         cddh+MopxdHfUcZSTjryrMjzlAinPWBmsSYEU+MpeDoKAkri9CKPSKC2XZoa89vfvioF
         yiipbG+XcJApglIIQ8eR6+lXwiqoRP5/RWMovwj9LMHyvc5YdroFsReI45mNR/oFAFjX
         WrVw==
X-Gm-Message-State: AOAM533ZuPakEl3LRP1vqMpvtYbUS5AfPkVPy4VDRWVT2/cY/22s+Wob
        cY+O9S41+li3r8AwppnCaLZhpTe8
X-Google-Smtp-Source: ABdhPJwIUupeR6Q/8kfiMpacfI9dNWprV9GMSeiLVuJ66LCtcmufPiwuObOjIBZDi8wPQlZL4kq13w==
X-Received: by 2002:a17:90b:4c4b:: with SMTP id np11mr1077511pjb.58.1592430638848;
        Wed, 17 Jun 2020 14:50:38 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j17sm666204pgk.66.2020.06.17.14.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:50:38 -0700 (PDT)
Subject: Re: [PATCH 2/3] dt-bindings: Document BCM6328 PCIe Host Controller
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        bhelgaas@google.com, robh+dt@kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        jiaxun.yang@flygoat.com, paulburton@kernel.org, info@metux.net,
        allison@lohutok.net, kstewart@linuxfoundation.org,
        tglx@linutronix.de, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20200617102556.3792821-1-noltari@gmail.com>
 <20200617102556.3792821-3-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e4831ec7-dfe7-ce4d-585f-bf11a1cb1baa@gmail.com>
Date:   Wed, 17 Jun 2020 14:50:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617102556.3792821-3-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/17/2020 3:25 AM, Álvaro Fernández Rojas wrote:
> BCM6328 PCIe host controller is found on BCM6328, BCM6362 and BCM63268 SoCs.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  .../bindings/pci/brcm,bcm6328-pcie.yaml       | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,bcm6328-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,bcm6328-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,bcm6328-pcie.yaml
> new file mode 100644
> index 000000000000..d2bd4933a5fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/brcm,bcm6328-pcie.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/brcm,bcm6328-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BCM6328 PCIe Host Controller Device Tree Bindings
> +
> +maintainers:
> +  - Álvaro Fernández Rojas <noltari@gmail.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +     - brcm,bcm6328-pcie
> +     - brcm,bcm6362-pcie
> +     - brcm,bcm63268-pcie
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: pcie
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupt-map-mask:
> +    maxItems: 1
> +
> +  interrupt-map:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ranges:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 4
> +
> +  reset-names:
> +    items:
> +      - const: pcie
> +      - const: pcie-core
> +      - const: pcie-ext
> +      - const: pcie-hard
> +
> +required:
> +  - brcm,serdes
> +  - clocks
> +  - clock-names
> +  - "#interrupt-cells"
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - ranges
> +  - reg
> +  - resets
> +  - reset-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    serdes_cntl: syscon@10001800 {
> +      compatible = "syscon";
> +      reg = <0x10001800 0x4>;
> +      native-endian;
> +    };

I believe you could be modelling the SerDes as generic PHY driver which
would be a little cleaner than the syscon approach. In newer chips like
6318 it looks like you should be able to use pcie-brcmstb.c since the
controller appears to be nearly the same and the PHY abstraction would
work nicely there.
-- 
Florian
