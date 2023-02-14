Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30373695F38
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 10:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjBNJaK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 04:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjBNJ3n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 04:29:43 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230FA24480
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 01:29:22 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id z13so10518161wmp.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 01:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ythUlK/OLggowkWK9K17VcyS5ieTPwSsB/PXOw/JWM=;
        b=LnKyQdydP+brArWTbP3dQk6j+mOsK0ZdEK2VGtbZ/HhY9NYepDsoqSJrFEKnYCWPz3
         s7DHFUnqnDSU52ZpgPaz/asdMOyQ/+1Ddij7awjyOTJFSbdMrwcPb1KU4/VoSovriAwt
         63hIonfjsTsuK5g0jJk/AC761nIdLCWie4lTpbWT6D0JkL65cDwWI0eJylNOcGmYiTTi
         UKITaZyk0b+44oaOw1i0yqNORpjtPS63zOBwbWms7GK9BQpdFwoqWetfB2vjG8htn6L9
         ZfCO2Sf8WV3J9lrBZ1oNZ+HAZ636ldnkHVTL6yrWmaLmOu+oK996JNdOwhofVLeErTu6
         lTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ythUlK/OLggowkWK9K17VcyS5ieTPwSsB/PXOw/JWM=;
        b=d+Ag+tddHv7YOM1rWreMPnSQYer2PYKbjWWgvBz0/GtMYEP7WbGrEJ7cLQuewUjAhQ
         nL2e72yXstAyDOVf91PyF8iuEJRtmEzs/wT6rcm1rGc3acuCPuomkVbBwOGHT3iXs+1c
         XL0g366amiLI5Us2ocH1zkZEgfh8y0e3RXPgxKxB7mcdB1dpwytm6JqgcOfb0Gyjg6Y7
         V7ff6Yr+M54xjnprUyRDtmQkBz38nTadwxXC+osEjASlx0c4Q2J+H0gNpZuN8Kp9C8Ta
         afBSGbgwhTaFf77z/I6FtJwKWhrgNBYKFU6SOaT0xwE2kJCuMBADwnod5z9YpM79CyFd
         klrA==
X-Gm-Message-State: AO0yUKV2396vQ96ZXdEqjFmBw+2WG6re9MyMT+SugrD30p5fxPaQQvHB
        5wtpXDS7LyVZmXPkxkJoJ9IIrA==
X-Google-Smtp-Source: AK7set8kUzeqp9A/9vWm2O2rkuEAB2X/6PnUxrdRgNbDalEjuQdJGMa/9sfWp+Z8Q8Ys/K3lLsC+Iw==
X-Received: by 2002:a05:600c:3541:b0:3dc:42d2:aee4 with SMTP id i1-20020a05600c354100b003dc42d2aee4mr1348458wmq.25.1676366958713;
        Tue, 14 Feb 2023 01:29:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b003e001afa274sm17614410wmo.2.2023.02.14.01.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:29:18 -0800 (PST)
Message-ID: <3e02f098-c3b6-1a0b-68b4-d5e2b8cb6045@linaro.org>
Date:   Tue, 14 Feb 2023 10:29:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: (subset) [PATCH 1/4] dt-bindings: PCI: qcom: add MSM8998 specific
 compatible
Content-Language: en-US
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221115125310.184012-1-krzysztof.kozlowski@linaro.org>
 <167239846281.742638.918628227544664589.b4-ty@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <167239846281.742638.918628227544664589.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/12/2022 12:08, Lorenzo Pieralisi wrote:
> On Tue, 15 Nov 2022 13:53:07 +0100, Krzysztof Kozlowski wrote:
>> Add new compatible for MSM8998 (compatible with MSM8996) to allow
>> further customizing if needed and to accurately describe the hardware.
>>
>>
> 
> Applied to pci/dt, thanks!
> 
> [1/4] dt-bindings: PCI: qcom: add MSM8998 specific compatible
>       https://git.kernel.org/lpieralisi/pci/c/c427f45c1e99

Hi Lorenzo and Bjorn,

This commit was applied with a change:
[bhelgaas: sort msm8996 before msm8998]

This is a list ("items"), thus the order is important. Reversing order
broke it.

Please kindly do not amend the commits. If the commit is incorrect,
please bounce it and ask submitter (me in this case) to fix it. The same
when commit does not apply cleanly - submitter should resend after
rebasing the patch. There were already few mistakes introduced by
maintainers (not PCI, but others) when using git mergetool or some
Patchwork merge-something while applying.

https://lore.kernel.org/all/20230214091202.2187321-1-konrad.dybcio@linaro.org/

Best regards,
Krzysztof

