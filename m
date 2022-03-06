Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D674CEC1F
	for <lists+linux-pci@lfdr.de>; Sun,  6 Mar 2022 16:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiCFPip (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Mar 2022 10:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiCFPip (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Mar 2022 10:38:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63118DF2C
        for <linux-pci@vger.kernel.org>; Sun,  6 Mar 2022 07:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646581071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+EG5ZoN5dKDEhImu4B6iOHSdTTgzb/PcHdEoxTJUFR4=;
        b=M1APDMRAI9zkqsSvXwNunHrWq0cMUWgkb40KNPbyNMfJcsLFzBH9d8zNgkN86Tw8IsCkfk
        qGR7pm5vyLyyYzCBSebiD+4X0wWK1lLF7ovieEsWePqg4H35OAdpapSddQdV2LXsY6w4qB
        XzDCc3X36869JHI+r7UVG6yOAgRP4xM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-063kcgwrO1ihmNO21TXslw-1; Sun, 06 Mar 2022 10:37:49 -0500
X-MC-Unique: 063kcgwrO1ihmNO21TXslw-1
Received: by mail-oi1-f200.google.com with SMTP id h9-20020aca1809000000b002d9992b3979so3195152oih.14
        for <linux-pci@vger.kernel.org>; Sun, 06 Mar 2022 07:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+EG5ZoN5dKDEhImu4B6iOHSdTTgzb/PcHdEoxTJUFR4=;
        b=wSxFaL8OmL8vsJC2HMwIAghyzyFn7xcO9a/bu/7p4mW4ha6yAbbkFU/ELOBM/ZcvnP
         dv6t9zx/Y9iGbB474y3VNJKmQqZN3oHFb656EgT6FxZoGnGLQR9f3gMfW9qwiQeNbAbC
         sIKQexE900DnW19k0NTZnWpq4cYfplKNTrd/+wKChJCc9PZ02H1LoT0wvwqO3wLZa63A
         FxWeK+alLr+ilQ3U9w5+Iv8akRNTLQfFiUFwiz1jk9RGYiQ+DLCZreoAlS0xYfqgavG2
         8vz0nMp4bVdnW614Sky3s8ktB+AYsap0dMdabt1W/2UK9AlJsPfHVaa2lYRLVvUO8vYn
         bkaA==
X-Gm-Message-State: AOAM532Xz4w24YTaX/H85FNU8sHcqLcY/5D0FEK0Rmat5IfGPLbzEC6E
        +WpUfS6VfEe1iAr6fFxLrG308853KAxli0elnOfngpLie12z3Gz1ETR+M9CpDoxvWLIVT3hAczz
        DxR/UndqOlvMLgb7voH6W
X-Received: by 2002:a05:6808:128a:b0:2d7:8f0b:e9a8 with SMTP id a10-20020a056808128a00b002d78f0be9a8mr15583080oiw.174.1646581069141;
        Sun, 06 Mar 2022 07:37:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyreqCZKQRU6DE2UD+nV7uwMFiFA/fm+L0rSDFLM2D9m2xql4ezmaJW0qh4SxoQwGlSM2Qd0w==
X-Received: by 2002:a05:6808:128a:b0:2d7:8f0b:e9a8 with SMTP id a10-20020a056808128a00b002d78f0be9a8mr15583063oiw.174.1646581068891;
        Sun, 06 Mar 2022 07:37:48 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id u3-20020a056808114300b002d51f9b3263sm5328725oiu.28.2022.03.06.07.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 07:37:48 -0800 (PST)
Subject: Re: [PATCH V1 RESEND 2/4] Documentation: devicetree: bindings: add
 binding for PCIe endpoint bus
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Cc:     yilun.xu@intel.com, maxz@xilinx.com, sonal.santan@xilinx.com,
        yliu@xilinx.com, michal.simek@xilinx.com, stefanos@xilinx.com,
        mdf@kernel.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        Max Zhen <max.zhen@xilinx.com>
References: <20220305052304.726050-1-lizhi.hou@xilinx.com>
 <20220305052304.726050-3-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e4c058e9-6549-4ce2-be05-d09d5b1a9fc9@redhat.com>
Date:   Sun, 6 Mar 2022 07:37:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220305052304.726050-3-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lizhi,

Sorry for the delay, I am fighting with checking this with 'make 
dt_binding_check'

There is a recent failure in linux-next around display/mediatek,* 
between next-20220301 and next-20220302 that I am bisecting.

There are a couple of checkpatch --strict warnings for this set, the 
obvious one is adding to the MAINTAINERS for new files.

Tom

On 3/4/22 9:23 PM, Lizhi Hou wrote:
> Create device tree binding document for PCIe endpoint bus.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   .../devicetree/bindings/bus/pci-ep-bus.yaml   | 72 +++++++++++++++++++
>   1 file changed, 72 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
>
> diff --git a/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml b/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
> new file mode 100644
> index 000000000000..0ca96298db6f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/pci-ep-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe Endpoint Bus binding
> +
> +description: |
> +  PCIe device may use flattened device tree to describe apertures in its
> +  PCIe BARs. The Bus PCIe endpoint node is created and attached under the
> +  device tree root node for this kind of device. Then the flatten device
> +  tree overlay for this device is attached under the endpoint node.
> +
> +  The aperture address which is under the endpoint node consists of BAR
> +  index and offset. It uses the following encoding:
> +
> +    0xIooooooo 0xoooooooo
> +
> +  Where:
> +
> +    I = BAR index
> +    oooooo oooooooo = BAR offset
> +
> +  The endpoint is compatible with 'simple-bus' and contains 'ranges'
> +  property for translating aperture address to CPU address.
> +
> +allOf:
> +  - $ref: /schemas/simple-bus.yaml#
> +
> +maintainers:
> +  - Lizhi Hou <lizhi.hou@xilinx.com>
> +
> +properties:
> +  compatible:
> +    contains:
> +      const: pci-ep-bus
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    description: hardware apertures belong to this device.
> +    type: object
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pci-ep-bus@e0000000 {
> +            compatible = "pci-ep-bus", "simple-bus";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges = <0x0 0x0 0x0 0xe0000000 0x0 0x2000000
> +                      0x20000000 0x0 0x0 0xe4200000 0x0 0x40000>;
> +        };
> +    };

