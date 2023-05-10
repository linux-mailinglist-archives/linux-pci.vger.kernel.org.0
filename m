Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D356FD8B5
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 09:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbjEJH4U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbjEJH4Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 03:56:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320FA4200
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 00:56:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc22805d3so10558357a12.1
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 00:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683705369; x=1686297369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y9RFoN4O5XFIITa1Nf4m95eLoa2elYnCxA/759kt0FU=;
        b=kLY3wjNehkZwp8cU7rDh4jvPoK+/liRJjcWUMFoEf5+S6QQshsDBVcGbxAUtpXiv4z
         A5jNkENMTTvKKmMYnZwWvhNsHLv/uXGwpsfOjvmLm8hBMRV4rvqzPkLl5bx2C8ns5L0/
         AWoeiiC3eCFihew7jxWnppIelC6/6t5guAxfsqUNT77JiZJ2YuI/+4s2eYyhKDNKrbRZ
         7PFKM1XLFVEXhoV5uATJJlS4vmq4wdBwAXgPOyxMa5rXCCFpdnuSxJF+V8O8zYV473Uh
         QZbR0qJr+ysdiCeddo8co/bu6Lg8G2ER62CRCfNBRp6rDLQNVqT9r736JrjAUQMzS/Lk
         nycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683705369; x=1686297369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9RFoN4O5XFIITa1Nf4m95eLoa2elYnCxA/759kt0FU=;
        b=S+TnLHmPx462QUrmTQ1D8J9NovTCpQD0kp+pqmZlFZ7vLfNqLX7U90ukhEU0qlCWxH
         qW4BfxOR1e37+rBfyZcYxbsg773FJm+8YMp3YxUn7fg1VQKbroqJQ3inzIME4Cyn5O+S
         VhTSPTy+KkeAFOHKSAwUO7f30L6CR0Mil6IXO2v2UoYcmFjqfGF1HSPF8w6LjwQCZk7Y
         2sXkDpMNDH0KI6boEOUETceIaZ0F/luFpfXGjgnWbL0A8ti5guUyV/aMeUfELGygMcD6
         1T4DU01IGyfaHWVx4MHtNiVWvI147ptccT1eGpO81LKqhLxp2A1RMMljC9WXWnnRMAnX
         xv5g==
X-Gm-Message-State: AC+VfDzckD4WDFcdRCWV/vZeSSnwcWZmbXXDHzLwxjCn3OFC8VeTR/FR
        TsEtBa2vAKpWCk4DaOCaSMQVZA==
X-Google-Smtp-Source: ACHHUZ4Zsna71INf2aga4IE3V40t03Umq05b0Y5aPtBM2+siS110hJDZd9+0xlxWAcAEXuHQQ8I3Ag==
X-Received: by 2002:a17:906:eec5:b0:94b:cd7c:59f4 with SMTP id wu5-20020a170906eec500b0094bcd7c59f4mr13529347ejb.16.1683705369733;
        Wed, 10 May 2023 00:56:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id mz11-20020a1709071b8b00b009603d34cfecsm2311183ejc.164.2023.05.10.00.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:56:08 -0700 (PDT)
Message-ID: <8f9d4228-4414-a299-aa86-07baf5b95af9@linaro.org>
Date:   Wed, 10 May 2023 09:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: PCI: rcar-pci-host: add optional
 regulators
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230510065819.3987-1-wsa+renesas@sang-engineering.com>
 <20230510065819.3987-2-wsa+renesas@sang-engineering.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510065819.3987-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/05/2023 08:58, Wolfram Sang wrote:
> Support regulators found on the e.g. KingFisher board for miniPCIe and
> add a 12v regulator while we are here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Changes since RFC:
> * added 12V supply for completeness
> * use PCIe slot in the example instead of miniPCIe because that is what
>   the Koelsch board offers (just without the regulators ;))
> 
>  .../devicetree/bindings/pci/rcar-pci-host.yaml        | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

