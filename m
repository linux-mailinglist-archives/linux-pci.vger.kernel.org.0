Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072E26A0F44
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 19:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjBWSMc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 13:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjBWSMX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 13:12:23 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0BD18A8B
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 10:12:21 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id da10so46597223edb.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 10:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XcNcjTbGilqBFvSaP95ds+AOY0Sg3ycWjre6wkeObA=;
        b=vgTBIVEy5TmD7m/Nin7C3TEn+OkXdt/iTICubDVjjr7vgx8mJNAwWkyk8CdTzKGoxw
         62Pc4ghtUJmbrccf791CV/wmpWuK7Tma/NbVNV4Zg2dOLWrd0gMNB4O/i0FwPqFSzG3C
         2tcnB7KtfVMa+kYzWEFhGNAkEJtNmS/QXCDreDM9pjeJxEIJIAcegEjKBOQJXDBQx/34
         JLk514sQBQcsAs7YpCjNm4NzvBSAhKTLK5EcQkzXIW+sEtkiJk1Ru1d+Rjx5uNxiKIkS
         84SrX1A+QeTPFj28+VNrvRZNzBO7j5cD3IKWQPy5FDewbUEkMDOriFiWUB5YUM8C5qoQ
         6U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XcNcjTbGilqBFvSaP95ds+AOY0Sg3ycWjre6wkeObA=;
        b=nB5KMafAcmD2984jagjqRTzuuUSHhp85iJXjZc70HpyjAh1D0WFFHi0WpBYkwDSe89
         0ECqujbhSy5P9zsMfkEHBX6nUYl2R45J6Lp/dNLCtZNdaM+RFAsu97bc0cTSSN8jB1+Z
         puXoWnO+AKZSMdiOE5ymlqBgwNItWgZHHb7QmJAD1qEl2U9Pimj6TQCSdJIUNxr5HmBh
         pPVYYtLDfQS+vlfgYt8WbPuPKj9H0mOpdZRCIqu2jH4XMC8LRCaZOQ4n2k5TRv0Nqmlz
         yfwlO+ZbcLzvaCk6BC8NydSCfl1qsGSr0WET4pMjMyYbyHVNtjUDDaiCMc1bxWoq6r6K
         hT1g==
X-Gm-Message-State: AO0yUKV1nQsJLiGeGlKvTX0yc+ZjU3em9NAR6tfyMXG6YtG9ASeu6KQ4
        HQ2vVz1dmWk9IPj0b5MtYR7C5w==
X-Google-Smtp-Source: AK7set/0TI9/IGIRPb7wNuaey7VzvLJXk2ZeAmp0C8JDikvIw28X7Dd+4ZC8Bot5PtmWvbcilYfCsA==
X-Received: by 2002:a05:6402:8d0:b0:4ac:be7c:4bf9 with SMTP id d16-20020a05640208d000b004acbe7c4bf9mr11858209edz.10.1677175939608;
        Thu, 23 Feb 2023 10:12:19 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u23-20020a50d517000000b004acdf09027esm5360874edi.4.2023.02.23.10.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 10:12:19 -0800 (PST)
Message-ID: <6dfde695-16d5-57ac-fbdd-b86ec91322a9@linaro.org>
Date:   Thu, 23 Feb 2023 19:12:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 4/7] dt-bindings: PCI: dwc: add DMA, region mask bits
Content-Language: en-US
To:     Elad Nachman <enachman@marvell.com>, thomas.petazzoni@bootlin.com,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230223180531.15148-1-enachman@marvell.com>
 <20230223180531.15148-5-enachman@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230223180531.15148-5-enachman@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/02/2023 19:05, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add properties to support configurable DMA mask bits
> and region mask bits.
> configurable DMA mask bits is needed for Marvell AC5/AC5X SOCs which
> have their physical DDR memory start at address 0x2_0000_0000.
> Configurable region mask bits is needed for the Marvell Armada
> 7020/7040/8040 SOCs when the DT file places the PCIe window above the
> 4GB region.
> The Synopsis Designware PCIe IP in these SOCs is too old to specify the
> highest memory location supported by the PCIe, but practically supports
> such locations. Allow these locations to be specified in the DT file.

This formatting is so bad it makes difficult to read. Make these proper
sentences with proper wrapping.


> First DT property is called num-dmamask,
> and can range between 33 and 64.

Wrong mapping and we see it in the code. No need to code it again in
commit msg. Especially that you already said it in the first sentence.

> Second DT property is called num-regionmask,
> and can range between 33 and 64.


> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml   | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index d87e13496834..a1b06ff19ca7 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -261,6 +261,16 @@ properties:
>  
>    dma-coherent: true
>  
> +  num-dmamask:
> +    description: |
> +      number of dma mask bits to use, if different than default 32

minimum: 33 (from commit msg)
default: 32... which does not make now sense...

> +    maximum: 64
> +
> +  num-regionmask:
> +    description: |
> +      number of region limit mask bits to use, if different than default 32
> +    maximum: 64
> +
>  additionalProperties: true
>  
>  ...

Best regards,
Krzysztof

