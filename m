Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5DB4D4802
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 14:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242386AbiCJNZu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 08:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242362AbiCJNZt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 08:25:49 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83EBD64EC
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 05:24:48 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 31A403F60B
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 13:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646918687;
        bh=AC2QV+BOHtvgXwOifEM5ca7aMnsr4tiE4ebM/MHFh6A=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=qyHJdoGNlIK0srWqi4VrDXjZsdZ9cWdy7a87s78PZy32tSo2ZAktOA2rI8z+fMNm+
         +saeeae/TAO2ttLDHFHqzUu/9aphnYtcsgypfsBP7sxGcuAaKO8NmfVwKVYSigYByf
         Sshb7APxwH4ydWUVWyt0TUtm4SdFxJJjvjlSlBOXBDHJzazFY6uaOmjV2hhSMGMvHl
         x0rW+PoOurcjywDK+1XQg82Hae0rDxfYB8BGsdtlIfaOYAyczU2lzIuwlheDrLdCSp
         CLKYIwDlPhubJQYkW8oDPdm7jjqqCiV7D+R2PdBH+hmkn0WeTYAxH59Rk/hFV4zG+c
         v714aKTmfD1PQ==
Received: by mail-ej1-f70.google.com with SMTP id h22-20020a1709060f5600b006b11a2d3dcfso3109449ejj.4
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 05:24:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AC2QV+BOHtvgXwOifEM5ca7aMnsr4tiE4ebM/MHFh6A=;
        b=BdCQek+JJZAikHS0aBy8PbbdxwbVfHkFjt0bk3n5yaHf7aG5tK4NdQ9lzPAWAskFPK
         sWpckWsyGq/f/0HLoUUfsbpRbHn3BfwerkAUF9YlvAYpEs6hPq4GjB2WJ+39whz8A/bL
         Z0fuRzo8B7t4P2f/hBFaesFMM+7kiWABhAOCbCQ3CbTFCipjHoLXJyDB0Rch+f4CPbqZ
         A7DGB7u6DlHpLMDIT7R0OdAUI8GXGPDXd/ufN3BdGvwc1yJdrN1Q0MGpDMTVLZO0dvyH
         bA5qax07VogkgfpL36zoWgCWsM4dzm1ldTvIEbBI+xMyBNoJX7SG+Cxts9RAjwXG9GeV
         /Pfg==
X-Gm-Message-State: AOAM530ib4xWi5xN8/JaqbVexrzPYV+0sHg7Pvt1QjeRpL5x+vgW5+Ch
        IZ7h5Cm/DB3W2vtTpqqUwUXjRTbgF0dy6xUYfizPeAFhdwnohFN3hTgnDjrCyHoAVKoRfZPrpvC
        qcSzPNp6i0fVLRDdsNtCipeberpyJaEBHY4DXZA==
X-Received: by 2002:a17:907:c16:b0:6db:682:c8c9 with SMTP id ga22-20020a1709070c1600b006db0682c8c9mr4311066ejc.153.1646918686618;
        Thu, 10 Mar 2022 05:24:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxh96pIcaZjepw8fDG5gEIFBY3lCXTrIeHF6wSWe/4lVWb3KtEgtjp2SDkTN4L1ahVqkj5lJg==
X-Received: by 2002:a17:907:c16:b0:6db:682:c8c9 with SMTP id ga22-20020a1709070c1600b006db0682c8c9mr4311039ejc.153.1646918686230;
        Thu, 10 Mar 2022 05:24:46 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906161800b006d420027b63sm1780101ejd.18.2022.03.10.05.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 05:24:45 -0800 (PST)
Message-ID: <6f34f80e-da06-337d-167e-2410309e0f4d@canonical.com>
Date:   Thu, 10 Mar 2022 14:24:45 +0100
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

You removed here list of items, which should stay. See also
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/example-schema.yaml#L91
how to do it.

>  
>    reg-names:
> -    items:
> -      - const: cfg
> -      - const: cpm_slcr
> +    minItems: 2
> +    maxItems: 3

The same.


Best regards,
Krzysztof
