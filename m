Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3E450B842
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 15:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447753AbiDVNXK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 09:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447937AbiDVNWv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 09:22:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D86826F4
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 06:19:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t25so10399252edt.9
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yJbptOkd/cZz/GfYU4+IDbdafJmc3PeinKk+q4pV2k4=;
        b=kmxFgqkY24ORMaFFAv19mODIB5jA2fVy05ncS+P0DnHbjhl/flfzf4R9QXLFMUs0NE
         CluZVmQckLhDFB4EuB8JvmaJ4R0su4JwxauywO3v2fyENCSebwdHtkSk8IiOGsuL+vzZ
         +tJ+qlq7B5ofFu2lvTqCDPD5epHPFbpJ6XHxYhtwOl2LlrgeUcptb85nBQQMcIBKkdKS
         vJOdR8ZHeyd4jAz8NMKkHMsdU10LCQ+RPbZK1fNuuHiC7xWUUUDqYn7HYR0sAZKoSfUJ
         TCcpq25tc1ucxNGJP2nxKBzS1AQ5OcfIU59liEt363tT85wVK6wV6K58/bU+8Wbrvwbx
         wnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yJbptOkd/cZz/GfYU4+IDbdafJmc3PeinKk+q4pV2k4=;
        b=g2yk+zJLdtu2/JM3sxLAswCVsUusOi98QN9vNLStbmohIuS3Ks3gGYGClsji4tZoNy
         EzUliq+a9YKDKccNtxszdUQFtgPNFPGzJd9n8VBveRwbvCPXySBGKBjkNgrMqgHcF5wd
         I0xdIb1bxYphk414AnUHL6Rmg4rkAvKFN08h5I2hAluSYQQfq2Zn1QROytDt0JuKEP3M
         fF7bSSqMM5L83tyKsR8uUJuCBnKmm9HaAIvrZZOxtDb7vKx8JukbS2n0g92juCqGDVOk
         579FTFujZxzDlQrK930n4DC8TVDoRgL+6eG6Lzf5ZYbuKOKUb7hkEnMudQwUBnY67LNB
         34/A==
X-Gm-Message-State: AOAM533/ezydToVm8nFHnM4eht7O0B59Gz9wJ1z1L2ZRSi3hu2orlKgh
        0J6UNqJ1n4kU0iUdRXVUAr8aKQ==
X-Google-Smtp-Source: ABdhPJzSOMVO/jUTGcyUdjl5DIMsazmbecRom5rdhR56/ZDXiJYvhxrLPtlonu8EwFfpXhKj3JCf1A==
X-Received: by 2002:a05:6402:50c9:b0:423:e4b1:baac with SMTP id h9-20020a05640250c900b00423e4b1baacmr4910573edb.146.1650633595873;
        Fri, 22 Apr 2022 06:19:55 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o24-20020aa7dd58000000b00420ca195de9sm880185edw.25.2022.04.22.06.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 06:19:55 -0700 (PDT)
Message-ID: <d199653c-b11b-f3cd-5fc4-7e304abbd20b@linaro.org>
Date:   Fri, 22 Apr 2022 15:19:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/6] arm: dts: qcom: stop using snps,dw-pcie falback
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
 <20220422114841.1854138-7-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422114841.1854138-7-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/04/2022 13:48, Dmitry Baryshkov wrote:
> Qualcomm PCIe devices are not really compatible with the snps,dw-pcie.
> Unlike the generic IP core, they have special requirements regarding
> enabling clocks, toggling resets, using the PHY, etc.
> 
> This is not to mention that platform snps-dw-pcie driver expects to find
> two IRQs declared, while Qualcomm platforms use just one.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064.dtsi | 2 +-
>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
