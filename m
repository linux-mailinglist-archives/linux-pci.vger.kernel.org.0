Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F27B604B20
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 17:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiJSPVf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 11:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiJSPUz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 11:20:55 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ACB4DF18
        for <linux-pci@vger.kernel.org>; Wed, 19 Oct 2022 08:14:42 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id bb5so11830202qtb.11
        for <linux-pci@vger.kernel.org>; Wed, 19 Oct 2022 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/qjJ08JU/nokrfccNNsGXG1NRnGmT82iKK0zORnPFE=;
        b=C7cvr0iYIzQZH95BpzZw4rJXXTdBJsWDMfX+CHM8JxUEevFwIlF1kYW7pC99QB5f5/
         /y2K1lwKqDhtwk2JiCoryPo4LF577k14bg1a+cV4BAJY7kX3IlmlpiNqHATESDL9ROO7
         swbR/jqOqpKJHUNrxjWy3pnlGMIPgFTCNGVv7JyxzDX/jfDT46nuA7N/XAssSFtXvidP
         MYcVob5qXcUTgwFYJodU3Sx7Wk+CMdnR1AquZd5U4sVl3VqEWHfU4oO2Cow4V96kzPtj
         Ikm9KKQaYF8IeFN4vAl9Jf1g6z6gfJdNRcg88jH426WjpXQHyEUeRKGBbkrPuWFXE/x3
         VKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/qjJ08JU/nokrfccNNsGXG1NRnGmT82iKK0zORnPFE=;
        b=Xr9rJUkzruFf+L3MjyEoBjZNhK0TjBuE+LjyHqAZ754kEyqoT+8L8ubSyNS1D9oluD
         t1GSoSblEaYZoEpMNdZzATuh0jRDwKwy9KFCnp8Ltb2UqWYq+wSJV3bEjQ3RB3n6S0q6
         wxYEA13L5GAEm3uttIyPwT7sgVb/IPGoNUeCXQmFW2x3idshph3zv25VS1J7jVxNYfPX
         NX2EDvFK0uVZmdhmIVHbez4b1lTGBXscvsKvtIHDEa/x9IpyeOf9ASeqv4ZMGcwWoWrd
         V0dTkbH/e8pgT3E41MDdm5VSkhbAbuc/SuMXKn1sUA3XzYRUqoSf3jWbQ0hIxg+uXzpl
         7rfw==
X-Gm-Message-State: ACrzQf1zzFnHmX2ycCu8fhFTu4vXZgE218Q7F6UZI9tzz5LXhZ6vngOh
        ZDdmNKywibOdyN648vGcGPk9BA==
X-Google-Smtp-Source: AMsMyM7i1zxfEr8Q170RjgVzKH2IP4Yh9mf8xVQXflM9hJlN3TbtBJrxW3Z8G0qBR0SqGAQPfyH9Lg==
X-Received: by 2002:a05:622a:1787:b0:39c:d695:8590 with SMTP id s7-20020a05622a178700b0039cd6958590mr6865239qtk.104.1666192409077;
        Wed, 19 Oct 2022 08:13:29 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id r2-20020ae9d602000000b006ceb933a9fesm4946019qkk.81.2022.10.19.08.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 08:13:28 -0700 (PDT)
Message-ID: <86e2a49b-557a-0a91-3e54-e64115fec736@linaro.org>
Date:   Wed, 19 Oct 2022 11:13:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML schemas
 of Xilinx NWL PCIe Root Port Bridge
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        bharat.kumar.gogada@amd.com
References: <20221019144640.9458-1-thippeswamy.havalige@amd.com>
 <20221019144640.9458-2-thippeswamy.havalige@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019144640.9458-2-thippeswamy.havalige@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/10/2022 10:46, Thippeswamy Havalige wrote:
> Convert to YAML schemas for Xilinx NWL PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>

(...)

> diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.yaml
> new file mode 100644
> index 000000000000..97a33e8cc171
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/xilinx-nwl-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx NWL PCIe Root Port Bridge DT description

Same comments apply.

> +
> +maintainers:
> +  - Thippeswamy Havalige <thippesw@xilinx.com>

Use current email address.

> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    const: xlnx,nwl-pcie-2.11
> +
> +  reg:
> +    items:
> +      - description: PCIe bridge registers location.
> +      - description: PCIe Controller registers location.
> +      - description: PCIe Configuration space region.
> +
> +  reg-names:
> +    items:
> +      - const: breg
> +      - const: pcireg
> +      - const: cfg
> +
> +  interrupts:
> +    items:
> +      - description: msi0 interrupt asserted when an MSI is received
> +      - description: msi1 interrupt asserted when an MSI is received
> +      - description: interrupt asserted when a legacy interrupt is received
> +      - description: unused interrupt(dummy)
> +      - description: interrupt asserted when miscellaneous interrupt is received
> +
> +  interrupt-names:
> +    minItems: 5

maxItems instead

> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 0
> +      - const: 0
> +      - const: 0
> +      - const: 7
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  msi-controller:
> +    description: Identifies the node as an MSI controller.

If it is a MSI controller, shouldn't you reference
/schemas/interrupt-controller/msi-controller.yaml ?

> +
> +  msi-parent:
> +    description: MSI controller the device is capable of using.

msi-parent: true

> +
> +  interrupt-map:
> +    maxItems: 4
> +
> +  legacy-interrupt-controller:
> +    description: Interrupt controller node for handling legacy PCI interrupts.
> +    type: object

Same comments apply.

> +    properties:
> +      "#address-cells":
> +        const: 0
> +      "#interrupt-cells":
> +        const: 1
> +      "interrupt-controller": true
> +

what happened to clocks? You did not describe any changes in commit msg.

> +required:

compatible

> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - "#interrupt-cells"
> +  - interrupt-map
> +  - msi-controller
> +  - msi-parent
> +  - interrupt-map-mask
> +  - legacy-interrupt-controller

Drop properties required by referenced schema.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +
> +    soc {
> +          #address-cells = <2>;
> +          #size-cells = <2>;
> +          nwl_pcie: pcie@fd0e0000 {
> +                     #address-cells = <3>;

Mess up indentation

Use 4 spaces for example indentation.

> +                     #size-cells = <2>;
> +                     compatible = "xlnx,nwl-pcie-2.11";

Same comments apply

> +                     #interrupt-cells = <1>;
> +                     msi-controller;
> +                     device_type = "pci";
> +                     interrupt-parent = <&gic>;
> +                     interrupts = <0 114 4>, <0 115 4>, <0 116 4>, <0 117 4>, <0 118 4>;
> +                     interrupt-names = "msi0", "msi1", "intx", "dummy", "misc";
> +                     interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +                     interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,
> +                                     <0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
> +                                     <0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
> +                                     <0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
> +
> +                     msi-parent = <&nwl_pcie>;
> +                     reg = <0x0 0xfd0e0000 0x0 0x1000>,
> +                           <0x0 0xfd480000 0x0 0x1000>,
> +                           <0x80 0x00000000 0x0 0x1000000>;

This is a second property in the list (followed by reg-names, ranges)

> +                     reg-names = "breg", "pcireg", "cfg";
> +                     ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000
> +                               0x43000000 0x00000006 0x0 0x00000006 0x0 0x00000002 0x0>;
> +
> +                     pcie_intc: legacy-interrupt-controller {
> +                     interrupt-controller;

That's even worse...

> +                     #address-cells = <0>;
> +                     #interrupt-cells = <1>;
> +                     };
> +
> +           };
> +        };

Best regards,
Krzysztof

