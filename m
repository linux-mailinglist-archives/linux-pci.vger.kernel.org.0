Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8925B4D4819
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 14:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiCJNe1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 08:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbiCJNe0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 08:34:26 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F5E14E958
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 05:33:25 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0241E3F1AF
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 13:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646919202;
        bh=pf7ItnfaW7ig7cvFz3o50P7qA0KQs4HS2dTOLYB9BVI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Vo69Rhny5iDE0DvEP60/qpvNNvLF/YEp68NEpgqEiTseF/PyoZuecjkouDpXsHkMz
         JvezpAWAEqqXRDI3mlBCV2hX3y3I2m3W/Um1LTie93x330kI5o+YeyW3+Y0kkVCqvI
         TN9Hm2BqWilGv8miFqDNkjH0gPvFBQLOT/Sc2e8VHIBWh4NPpQr+lHMA+1FOWIgb2S
         6rLXFSveE1Ubz4IaWCImJETmV26dEuEqArlxjTFQ6guzdWNBa3ohC2fPjMVG+HIKHt
         MoY5dDMsrE0NZRjjb1Y44ZIoY6/5fk2xjCef2kpjaqm6hx1kNHN48rOghg0SjMyCbR
         WHxEAEFIcoH1A==
Received: by mail-ej1-f70.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso3092258eje.20
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 05:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pf7ItnfaW7ig7cvFz3o50P7qA0KQs4HS2dTOLYB9BVI=;
        b=QfOXrd6pWz4ZcCkBKdy3/RoTDqZVkho5vSDItNxGq6b6E8fCP5o+tq8L+bGq6YE5j7
         lw7XDCUjlAj+a9ay33tEaitZYFhqaZjTo9Bkg7Zpm6hcSbqDL9gi+5cfLkZ1lpb8/4L+
         U+D/fp18QGVS0AJbXdS8XVTU5xmIPSM6JQy5k2Vz+yl2WyXbbYZdugocvhsIDod5UC4B
         lzaD8pF5+WhqIULtn91snSINdNb3KYPE2wWZcst5u19ZdZmtS1K5a62DLAxf1tsYg49g
         0WwuP0eXjfv2Q1yhVtBscpwK6CN29tfIqTeW7KsE2LBzrKWyRkDKVWgdcwj5pH7O96oh
         7ZHw==
X-Gm-Message-State: AOAM531xdcoCLgjE3iq3TAJrrAnoWU/QxYyItBtrDotAD4iAgy75vWul
        Ee80EUREijy9ddZnFpdmJLdsISG5abLlXZacSSrNf7hSjuSGxB3OxJaX2cBP5pimj6ZlhRKTLXI
        lQqoqGgAcxEvM10OgJMhMP095bKocxy1himm/og==
X-Received: by 2002:a17:906:74c3:b0:6da:be6d:d64b with SMTP id z3-20020a17090674c300b006dabe6dd64bmr4324837ejl.695.1646919201542;
        Thu, 10 Mar 2022 05:33:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCCnILWS6O8NF0QccmUIZKB7piFBemuWv5RosCsexSn5KFanUN3loK37T97Thy/V43ongQTg==
X-Received: by 2002:a17:906:74c3:b0:6da:be6d:d64b with SMTP id z3-20020a17090674c300b006dabe6dd64bmr4324818ejl.695.1646919201311;
        Thu, 10 Mar 2022 05:33:21 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b006daecedee44sm1821076ejb.220.2022.03.10.05.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 05:33:20 -0800 (PST)
Message-ID: <75695818-3d74-b809-bd40-ffbf4724df47@canonical.com>
Date:   Thu, 10 Mar 2022 14:33:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root
 Port
Content-Language: en-US
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, michals@xilinx.com,
        robh@kernel.org
References: <20220309120025.6721-1-bharat.kumar.gogada@xilinx.com>
 <20220309120025.6721-2-bharat.kumar.gogada@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220309120025.6721-2-bharat.kumar.gogada@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/03/2022 13:00, Bharat Kumar Gogada wrote:
> Xilinx Versal Premium series has CPM5 block which supports Root Port
> functioning at Gen5 speed.
> 
> Add support for YAML schemas documentation for Versal CPM5 Root Port driver.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 47 ++++++++++++++++---
>  1 file changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index 32f4641085bc..97c7229d7f91 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -14,17 +14,21 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: xlnx,versal-cpm-host-1.00
> +    contains:
> +      enum:
> +        - xlnx,versal-cpm-host-1.00
> +        - xlnx,versal-cpm5-host-1.00
>  
>    reg:
> -    items:
> -      - description: Configuration space region and bridge registers.
> -      - description: CPM system level control and status registers.
> +    description: |
> +      Should contain cpm_slcr, cfg registers location and length.
> +      For xlnx,versal-cpm5-host-1.00, it should also contain cpm_csr.
> +    minItems: 2
> +    maxItems: 3
>  
>    reg-names:
> -    items:
> -      - const: cfg
> -      - const: cpm_slcr
> +    minItems: 2
> +    maxItems: 3
>  

One more thought - it seems three items are required on cpm5, so you
miss later proper allOf-if: which enforces this.

Best regards,
Krzysztof
