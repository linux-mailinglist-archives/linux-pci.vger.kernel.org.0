Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DB8590CDC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 09:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbiHLHwQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 03:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbiHLHwP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 03:52:15 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A650901A7
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 00:52:14 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s9so184560ljs.6
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 00:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Y1FgwE1S0sZxGVZfKzOP1495FUieOVb1Ijht3ICAFkg=;
        b=mL0W5VC6YSoWJdmliy79TMTZKdBE0ndlkNHtLaGGwh6t3xDn+H2ok9auBHCeQ88/Pr
         akeMAs/sbQxBsK39m3xjJHHbOo9x6yrGvlspQtODqTOgqChqdD1hKHnANPOhSTLnm00N
         I7n/2QBlBqTZ+PBv4evi+qLwiJos6vXDlo8lmnSoajfFbooNbIXyWsIlBGu9hjERgQgc
         QNt9VSW65T9PvyuMsZ17SkJBTzyXmqZkxIP1Y23gHfdCDPUI/sX0dvDVOFjE3qgRvQDO
         dr8x/65eK7Yfl7khzi00d7fI15M5Gdm+HZ3zc9Q9OYpqKXmSFFrsiGwbsCCaY98pCNBC
         lf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Y1FgwE1S0sZxGVZfKzOP1495FUieOVb1Ijht3ICAFkg=;
        b=LprEo40jVkpyGJ4NEtsnnjK/F6WXzcxZ2IDuAyvU7XdaAooI+2949dgXduM/O2+KHt
         maNX3UeLo0gXKGFaA4eQpqVH4sjURc8qUWLdyzks9Xb8JFKg/BZxw+5lzTCRZuWKbgro
         hC24VkbljEnRWirx/SxBayzXnIsy3XB7SyMZEtycnYTziB2dZNOd6Cz8qpcMdjYoaUl5
         /dfr+HrYXUn2Qh7W7B1RHui/8HjS467jg1JwUTmTiYIgJIqn+QwhKYY3Brd09Ab6gIJl
         OaQ2GDOo6IszaWVxG8mwU7I9AnqvDARPhmVcUEO76L35CJWyLNFXXF5QDkKXzheeESPs
         KWEA==
X-Gm-Message-State: ACgBeo1RsPphahQp6I7bpNxz9sGh+t/nUohdkJYK1HGSQxiUjfPFGXDP
        rXviYMPLBbm4P/dQWGM5skw2+Q==
X-Google-Smtp-Source: AA6agR7ieagGDwa45zL3pLJwwj3Fc73INAw9s0I68eA2wdC3N+LrYS0gii7eVHf8+1bD5EKhkVFLpQ==
X-Received: by 2002:a2e:bd89:0:b0:25a:9386:75d0 with SMTP id o9-20020a2ebd89000000b0025a938675d0mr866830ljq.431.1660290732392;
        Fri, 12 Aug 2022 00:52:12 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id i27-20020ac25b5b000000b0048b18fb378fsm124440lfp.119.2022.08.12.00.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 00:52:11 -0700 (PDT)
Message-ID: <edf3da1b-79dc-4e09-8d3e-73aca09e847f@linaro.org>
Date:   Fri, 12 Aug 2022 10:52:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/4] dt-bindings: PCI: microchip,pcie-host: fix missing
 address translation property
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220811203306.179744-1-mail@conchuod.ie>
 <20220811203306.179744-5-mail@conchuod.ie>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220811203306.179744-5-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/08/2022 23:33, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> When the PCI controller node was added to the PolarFire SoC dtsi,
> dt-schema was not able to detect the presence of some undocumented
> properties due to how it handled unevaluatedProperties. v2022.08
> introduces better validation, producing the following error:
> 
> arch/riscv/boot/dts/microchip/mpfs-polarberry.dtb: pcie@2000000000: Unevaluated properties are not allowed ('clock-names', 'microchip,axi-m-atr0' were unexpected)
>         From schema: Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> 
> Fixes: 528a5b1f2556 ("riscv: dts: microchip: add new peripherals to icicle kit device tree")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I feel like there's a pretty good chance that this is not the way this
> should have been done and the property should be marked as deprecated
> but I don't know enough about PCI to answer that.

It seems bindings were added incomplete and now based on DTS (which did
not match bindings), we keep adding "missing" properties. I don't think
it is good. It creates a precedence where someone might intentionally
sneak limited bindings (without controversial property) and later claim
"I forgot to include foo,bar".

Therefore the property should pass review just like it is newly added
property.

> ---
>  .../devicetree/bindings/pci/microchip,pcie-host.yaml  | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> index 9b123bcd034c..9ac34b33c4b2 100644
> --- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> @@ -71,6 +71,17 @@ properties:
>    msi-parent:
>      description: MSI controller the device is capable of using.
>  
> +  microchip,axi-m-atr0:

Name is not helping. If it is offset, add such suffix (see
brcm,iproc-pcie.yaml).

Unfortunately I don't know PCIe good enough to judge whether the
property makes any sense or some other ranges-style should be used.

> +    description: |
> +      Depending on the FPGA bitstream, the AXIM address translation table in the
> +      PCIe controllers bridge layer may need to be configured. Use this property
> +      to set the address offset. For more information, see Section 1.3.3,
> +      "PCIe/AXI4 Address Translation" of the PolarFire SoC PCIe User Guide:
> +      https://www.microsemi.com/document-portal/doc_download/1245812-polarfire-fpga-and-polarfire-soc-fpga-pci-express-user-guide
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    minItems: 2

minItems should not be needed, but you should instead describe the items
in the matrix.

> +    maxItems: 2


Best regards,
Krzysztof
