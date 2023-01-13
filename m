Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3DF66921C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 10:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjAMJCg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 04:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjAMJCe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 04:02:34 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1114A34743
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2023 01:02:32 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id l22so21058288eja.12
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2023 01:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PH7OlCwVBqDHHfs+JSk/+04xmU8OFLEPIXeMIr7O+K4=;
        b=R6PTJjwBiwB9xYnySQbQq+6zMBNbkNQmJG1WPz1JIBywRDz8uFDoGZbAaBD98WpPrQ
         lTDtPEF4Kplo+VoCP7hPulTqFXD0pQSb/KBxuPoBNE4UppOWs02N0ZsSG5pnrY5Cdb9x
         V2iI62SRZhXDyyjqjFHQSULfG2qGDzCAw8HVBuEk14IXG4uX6LGKcPmEg3FRWbv08x3X
         J7F8mymJ1Jm3x8ePzCU42mfyJ5ac4EIS1O7F7K67VE24DRD19Ua+xotOSJ3qLP+T/pGd
         ErLpTgmZt5ChnLc7x3rhRtdWZ8TBQ1VodfVPfDyg13wtuIhbizLsIuwb7uwxc+LK32H0
         Sdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PH7OlCwVBqDHHfs+JSk/+04xmU8OFLEPIXeMIr7O+K4=;
        b=aQT5XqWZZoMc8UrnMK0Spigzme9jrWRgTc/NxCeG0l80fAp3sRlwt3TMDrnoH2KdK0
         SlOnJ2IIP4olm4oGPTo5TvCISGClGVdU2k4Tm89VM8Sc53NcBiyeMxafWspRjvTvqyBL
         ZSSJWKdezTagQG+XzFL7Jue/mzf+TvYUtd6HyyK0j/di9wbMw8GOd2LXaT1OW3yt5vne
         IH3tzZyiUfNo0w3k2oXYAdopfnZiA6yEtP/vbWUoimbDA0Ekwzk0XJA7/u9yLsMWeZ/8
         xgBHhMvkMHj9oFaPQxqix3hBO9JHvkaLUqbwEJQ6qIoWoO7MDzSnnApXFX1132QEK4YS
         D8Kg==
X-Gm-Message-State: AFqh2kqE4pMCZxi0M4RCJwA19w9CVnlfsy4pvV2fEmJSWlWuimfl/0Y8
        SjsQfT31uMg1sTDlGaAwIXaoPw==
X-Google-Smtp-Source: AMrXdXsyW969IDKKtuXbksmxNsiYIqySHVhsQ6MPJueutAvxOAcEwTbsLVVG0rhORP4+jJ4rKBACsA==
X-Received: by 2002:a17:906:7046:b0:7ae:8194:7e06 with SMTP id r6-20020a170906704600b007ae81947e06mr71277358ejj.56.1673600550596;
        Fri, 13 Jan 2023 01:02:30 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id lj1-20020a170906f9c100b0078d22b0bcf2sm8240254ejb.168.2023.01.13.01.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 01:02:30 -0800 (PST)
Message-ID: <7831a607-db55-274c-8fba-d01d5bac3a7a@linaro.org>
Date:   Fri, 13 Jan 2023 10:02:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] dt-bindings: PCI: qcom,pcie-ep: correct
 qcom,perst-regs
Content-Language: en-US
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <20221109113202.74406-1-krzysztof.kozlowski@linaro.org>
 <167240770788.754221.16859969124148517946.b4-ty@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <167240770788.754221.16859969124148517946.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/12/2022 14:42, Lorenzo Pieralisi wrote:
> On Wed, 9 Nov 2022 12:32:02 +0100, Krzysztof Kozlowski wrote:
>> qcom,perst-regs is an phandle array of one item with a phandle and its
>> arguments.
>>
>>
> 
> Applied to pci/dt, thanks!
> 
> [1/1] dt-bindings: PCI: qcom,pcie-ep: correct qcom,perst-regs
>       https://git.kernel.org/lpieralisi/pci/c/68909a813609

It's still not in linux-next. Is you tree correctly included in the next?

Best regards,
Krzysztof

