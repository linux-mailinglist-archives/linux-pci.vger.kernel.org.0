Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB15721FC4
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 09:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjFEHje (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 03:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjFEHjc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 03:39:32 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A25CA
        for <linux-pci@vger.kernel.org>; Mon,  5 Jun 2023 00:39:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso6859597a12.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Jun 2023 00:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685950769; x=1688542769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubs62QRWNI2vAlv+m7Vhuuq+/9gfWiWllr779JaDU0A=;
        b=jnGXVTMC0Zkjc/HL/jGD7myZeCu5nP5sXPdyMpkuYVGFzO9dUazTrH1PtnK/RrjAUz
         cJr6sBsYGNKfwayGO1e0Ydyp2QcPnx1guOoz92WwKLClJUTa/b4OkLtruMDCzAJSCk3X
         gzbXwnk2oQnbQ7191taZSYul3+HmOnDecgIXXNNmVNzZ1GtTwNBb3VzHriHilszMHrOU
         +qdSi33yR5QA9ct2qutgwcRe3MiOiSUHj6IgzQ5ecnh2Y4cIrNct/cVZyS+Mj54HDrJE
         9uBV7H1QRpbCFof5wB81smV5z/aEBIybB6lERbeVlcm3mxSucUEPrmleZfyRm0hlJnaJ
         j91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685950769; x=1688542769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubs62QRWNI2vAlv+m7Vhuuq+/9gfWiWllr779JaDU0A=;
        b=HyjHGRu1L8Pq7ao++eyRwprlnTEF5j3rq2fidIcFoEB5uQCesXB1a8enyf83oC7Tao
         cvbyfdx4iFZHt6bKL3VoWrXf6p8p+9+dr+ewXh4rp/nzy9V88Lr2G9HRmrLBKoiUfM1u
         tD1GVesK2bSszS/Gk9m55fCo+1qGLZxBLK2NhvcOWkIUpm+pf5i5TKKkHHC3nHLRS2kt
         3uNYRBZbQHSS9D6kkzjeoRdTGnGWwZkC8kVeacZ9Rr39A1RtJ0faiqXaQ6ZlNEbgWV1g
         fJ10ehBQsHCQ2W+H+fsDmFArjMBE0IoBqc0yiIun7KWUnHWj4t/M6shXr+YuQlIcRKwW
         7TgA==
X-Gm-Message-State: AC+VfDzj+ebsWAZs40uvJZ01wQRzdSHpcMkojQ9NHODtz341KWGK4QiQ
        SYh0NCAtX43kUV4z6YUYPtpfmA==
X-Google-Smtp-Source: ACHHUZ5Xcj/ZZfvN09R1XxWQ75z1e19Mx1wuq95BLvG60AU/XhmetaV8ngLrlLpQ+pox/hbhJ2Irag==
X-Received: by 2002:a17:907:7fa4:b0:974:9aa9:be3 with SMTP id qk36-20020a1709077fa400b009749aa90be3mr6456954ejc.28.1685950769545;
        Mon, 05 Jun 2023 00:39:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y11-20020a170906070b00b00974c32c9a75sm3679564ejb.216.2023.06.05.00.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 00:39:29 -0700 (PDT)
Message-ID: <a2086bb1-160e-1dee-a686-ffdaf3422595@linaro.org>
Date:   Mon, 5 Jun 2023 09:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas
 for Xilinx XDMA PCIe Root Port Bridge
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Cc:     lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        bharat.kumar.gogada@amd.com, michals@amd.com,
        nagaradhesh.yeleswarapu@amd.com
References: <20230531083825.985584-1-thippeswamy.havalige@amd.com>
 <20230531083825.985584-3-thippeswamy.havalige@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531083825.985584-3-thippeswamy.havalige@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31/05/2023 10:38, Thippeswamy Havalige wrote:
> Add YAML dtschemas of Xilinx XDMA Soft IP PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
> change in v4:


> +unevaluatedProperties: false
> +
> +examples:
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pcie@a0000000 {
> +            compatible = "xlnx,xdma-host-3.00";
> +            reg = <0x0 0xa0000000 0x0 0x10000000>;
> +            ranges = <0x2000000 0x0 0xB0000000 0x0 0xB0000000 0x0 0x1000000>,

If there is going to be resend, use lower-case hex everywhere.

Otherwise, it's fine:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

