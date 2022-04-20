Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1375084CA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 11:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359423AbiDTJW6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 05:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377115AbiDTJW4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 05:22:56 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E4237CB
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 02:20:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u15so2179845ejf.11
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 02:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nAIc8jlNaoNP4j8LrfgKPUem0987eG/5mImWoVHHT10=;
        b=rSRtnZiF0xfnneRi/FQEzgnTo4L29Yzksiymt9g7h909EamxwG1M03+cfLGJz2BCOj
         30CAL0kYOBVzStPIrvYb0monKtCFSnzsD3kwCqSU+bWHouMJvSzgKzZ6TdGkdgNy2yzz
         C01rq4MLEeIVrGL5bI2/gmeJphR7o7jGVzdRCQK8jV3eM/SIu9DarQScr8dPeApgsm4q
         PVkvnWdJ0MciYcWlYYKEOAtj/lRtmYDnu4oNkN19u4GUIU3PjvK/cEdkwCiD73LdOoQg
         xyjB1TqyC1taYNXURg86XIpc8UnubKhBcODOIH7ohGWzGoAIPK9A3eD02O9kuRE3/jfE
         /lCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nAIc8jlNaoNP4j8LrfgKPUem0987eG/5mImWoVHHT10=;
        b=DQxlrgKu/KzeJDY2GB5dPV/wl3kpS688DO+oVoMhTZHxdYOZOTxYk7zTvz7LEtS3St
         Me6QovIRIkxoLpRD4GUiKlBezwDfszHkjlms5ehpvvbqicjYf57KKKrB8mYqy+BA3zbY
         zUehcxW8kmhN8IGpjv4py2ucMcSmfG69lM0+HPyGg0zU9XppGlWXKlnt4g6QCR0V5/g0
         FcRBb38rS3UyjYUlb98c8O0Ztn/jDlFzavqewiv8cQsU2m6tnnVcYSPXPottd3r5JDXH
         vy481aLEaVEz8KGsv8NO56O08dElEgMkmmFc+5lrne1W0KQ068A6acLuMPYWjJ7NVzDN
         QO4g==
X-Gm-Message-State: AOAM530dsBMeN1Ju2fhz0ibNOE7WWQvkLEzFeRJXNH6h/9wmVw0QLA2n
        DeKOAmwcOOaAHIQHx0UygodZEA==
X-Google-Smtp-Source: ABdhPJzOe0WrGTYQeCapieJbroGE75Jk3m16hGQK/9UYOPl2KmErfi3BqssRPBI5BShzU5h2D40NFw==
X-Received: by 2002:a17:906:7a51:b0:6e8:8e6c:f182 with SMTP id i17-20020a1709067a5100b006e88e6cf182mr17160922ejo.506.1650446408596;
        Wed, 20 Apr 2022 02:20:08 -0700 (PDT)
Received: from [192.168.0.223] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170907774500b006e1382b8192sm6643906ejc.147.2022.04.20.02.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 02:20:08 -0700 (PDT)
Message-ID: <529de1fd-7e98-1634-c61e-0e69ddcd9e73@linaro.org>
Date:   Wed, 20 Apr 2022 11:20:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 00/12] Fix broken usage of driver_override (and kfree
 of static memory)
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/04/2022 13:34, Krzysztof Kozlowski wrote:

Hi Greg, Rafael,

The patchset was for some time on the lists, got some reviews, some
changes/feedback which I hope I applied/responded.

Entire set depends on the driver core changes, so maybe you could pick
up everything via drivers core tree?

> Dependencies (and stable):
> ==========================
> 1. All patches, including last three fixes, depend on the first patch
>    introducing the helper.
> 2. The last three commits - fixes - are probably not backportable
>    directly, because of this dependency. I don't know how to express
>    this dependency here, since stable-kernel-rules.rst mentions only commits as
>    possible dependencies.


Best regards,
Krzysztof
