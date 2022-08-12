Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC2F590CAA
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 09:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbiHLHmm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 03:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiHLHml (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 03:42:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDC4A5C7A
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 00:42:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id x10so171067ljq.4
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=sBayUxRV4uPcA67ScjufKHzSC2Zb9c963r0CFb87BtI=;
        b=ZxmhqxbLyYEKBoaek1kELjS9zWam3584fB7+hC/D/yOL5VIzNTYK2p+l0hnDNec9la
         PwxLpp7lD6asWrVMYpbxrj8CbVyUjv+NVMDvJQ01IIQ3ojDKu3SMAzbB9PvJGAfK3fCK
         lkPqvEEQ8nOZyQOfiBSseOBQ7ZNyvByQ1xgfkWez5dbQam9X0jF7DEuJvdUItPIMj2D2
         8ZDjhhQJFeNyqQOi02JzoFx5Kx2hfyqAuoAih/KeJAK3t/ha771sLC3pi1DeUhwxVRiF
         9/iQ6NkHA47vsEsZ2Tl7BU0G13wAuZtxRxVCb6yhix5INR8JKJEsY1rHWI+KVd/0i0pu
         9dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=sBayUxRV4uPcA67ScjufKHzSC2Zb9c963r0CFb87BtI=;
        b=TqFX6+wAAEYQ2/fGbJbLDk4Ol+HhTBrmlw75Ib92nJt7Ml9EeRlLlp/fvOLzfND3Z0
         uJEKXFtilkV2l2IvF6K6DlCWlw9xnV4mj035kwylwZSVvj+dDtyQtTmzmwcnQsbdOgrf
         EOL5qfJmHGE9tt+8xEzc/fmRVWGniGQVnhWGW/y6WCmvSRtINnqfRtDMB3izWQcd6KrM
         QMYxBGLL5eY7kwp7lN3QbO1chj13/DRuLQM22BxJskCEVuWvO3Ew/xnBbhHRH+bzZV3U
         LOw9aCgguF0vyZqxue5y4RZc+Va+bm+SAEqkI0FSF4RDuA7y12PG7+8M/m6A1ybHToLU
         k2aQ==
X-Gm-Message-State: ACgBeo1lEEidb3vosAuQ6tLNlrfGHc7oDSrME+WAaiOXLTw50RQMhddZ
        k0h3NIfDS0et2SX559SCGjESVA==
X-Google-Smtp-Source: AA6agR5MQ83Hq/A33QupzFIOLxPxAA89VBM9ILO2jMHCQZcILllbnmG9wAY/i+GQ4ZHqX8XArqLi1Q==
X-Received: by 2002:a2e:9941:0:b0:247:dce8:b0ec with SMTP id r1-20020a2e9941000000b00247dce8b0ecmr871902ljj.404.1660290158243;
        Fri, 12 Aug 2022 00:42:38 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id b19-20020a056512071300b0048b16fb79a0sm118602lfs.214.2022.08.12.00.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 00:42:37 -0700 (PDT)
Message-ID: <721ccb76-c162-30ee-68cc-3316a2d62554@linaro.org>
Date:   Fri, 12 Aug 2022 10:42:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/4] dt-bindings: PCI: microchip,pcie-host: fix incorrect
 child node name
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
 <20220811203306.179744-4-mail@conchuod.ie>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220811203306.179744-4-mail@conchuod.ie>
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
> v2022.08 of dt-schema improved checking of unevaluatedProperties, and
> exposed a previously unseen warning for the PCIe controller's interrupt
> controller node name:
> 
> arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: pcie@2000000000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'legacy-interrupt-controller', 'microchip,axi-m-atr0' were unexpected)
>         From schema: Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> 
> Make the property in the binding match the node name actually used in
> the dts.
> 
> Fixes: dcd49679fb3a ("dt-bindings: PCI: Fix 'unevaluatedProperties' warnings")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> This is another one Rob where I feel like I'm doing the wrong thing.
> The Linux driver gets the child node without using the name, but
> another OS etc could in theory (or reality), right?

Yes and we had such cases when renaming device nodes caused regression.
My interpretation is that node name is not part of ABI, so anyone
depending on it made a mistake and they need to fix their stuff. I think
actually that is really poor coding and poor solution to parse device
node names and expect specific name.

Other folks interpretation is that we never break the users of kernel,
regardless what is documented in the ABI... so it depends. :)

Here however it is not a device node name, but a property name (although
still a node). Bindings require these to be specific, thus such name is
a part of ABI.

For your case, I wonder why it was called "legacy-interrupt-controller"
in the first place? Node names - also for properties - should be
generic, so generic name is just "interrupt-controller".

> ---
>  .../devicetree/bindings/pci/microchip,pcie-host.yaml          | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> index 2a2166f09e2c..9b123bcd034c 100644
> --- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> @@ -71,7 +71,7 @@ properties:
>    msi-parent:
>      description: MSI controller the device is capable of using.
>  
> -  interrupt-controller:
> +  legacy-interrupt-controller:


Best regards,
Krzysztof
