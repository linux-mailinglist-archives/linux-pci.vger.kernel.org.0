Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EED56C5302
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 18:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCVRus (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 13:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCVRuq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 13:50:46 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975085FEB8
        for <linux-pci@vger.kernel.org>; Wed, 22 Mar 2023 10:50:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w9so76310887edc.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Mar 2023 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679507443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qhu19poKmOfI0jrMdEB3kJmLH0MXChRpbmedgDg94Yc=;
        b=Y/ee/jxbolabZQuEKHsf/mztwU0X5MaIZB1IR05kch78vXKRIAP+u3e8/qw3zxwpxK
         xHdwJy0NOMaKpDzIyKy/5GIeOQgaTeovWENo9LyiE7OdBJBcXzGUIRGWlUNlFVmZDAJT
         3hVdCcubuKobfVIFg83DTgu8T7p2vo9YPf36ZYqNpdHgNS7URNwLUhZBTjqIk2j26SdP
         +rP/ueWKDgCIMw6R5yuquXmrrV1mLCROvy1gXWV0wRXOAMsMKcEdcoRMMNCCRwksYflu
         fNk/PYUJ6zxg1BOr1rqJCx8u0tE3lPxxx4j9ixXOTe9dSCwDoY1a3COjTTWe5rKwL5ZJ
         ShtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679507443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qhu19poKmOfI0jrMdEB3kJmLH0MXChRpbmedgDg94Yc=;
        b=y/M24trtjtIuE7M8t1bAKanCTUjIulRnrIHXKREiVZLEnx1rNs1qAEeW50kytWOvJT
         +aCh13leEGhDUdwTjnS1ItcOVyi17L0no1tms2rbR+9J4uCDI5qlCNXVItneHaYLBWOL
         dJK9bUbnNuTz63bYxfihqFUNCM9FIj2Bgodj0yIgYRoe2ldsilX2hnZoPnk7fgEL1gdQ
         OcySc6WH5hhvF3to/P2L/t5axD8T1ErhDTElo7Pw/77FOT3u8ehpjny5oorxMBPbi6za
         yGYGJbXUJSoYRvjgyA8hIsSm4WVDK8mXBLFsRUtdWsyudB9fwcPRZusSolkYGLLOxHmn
         t/sg==
X-Gm-Message-State: AO0yUKU3LxTO4Xs1klOs5nmSYoG+Zg3O+pYqOR5DQsZqXdhHMFKluw2O
        i/kCa8RFE0yxl01z6Tt4jDQLSw==
X-Google-Smtp-Source: AK7set8AArAxA6nlpq0FqatP6y9UpIfuGYiiKDS18vWs0UtLd1i8Ir05bFXg7s547q8uu2GJi0Woeg==
X-Received: by 2002:a05:6402:104b:b0:500:2cac:332c with SMTP id e11-20020a056402104b00b005002cac332cmr6838875edu.25.1679507443082;
        Wed, 22 Mar 2023 10:50:43 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id m11-20020a50998b000000b004c13fe8fabfsm8055646edb.84.2023.03.22.10.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:50:42 -0700 (PDT)
Message-ID: <cd4aa9b3-5e0c-675d-de7e-8b5b2b1660e5@linaro.org>
Date:   Wed, 22 Mar 2023 18:50:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v3 11/11] memory: tegra186-emc: fix interconnect
 registration race
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230320182441.11904-1-sumitg@nvidia.com>
 <20230320182441.11904-12-sumitg@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320182441.11904-12-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/03/2023 19:24, Sumit Gupta wrote:
> The current interconnect provider registration interface is inherently
> racy as nodes are not added until the after adding the provider. This
> can specifically cause racing DT lookups to fail.
> 
> Switch to using the new API where the provider is not registered until
> after it has been fully initialised.
> 
> Fixes: ("memory: tegra: add interconnect support for DRAM scaling in Tegra234")

Same problem and also send it separately.

Best regards,
Krzysztof

