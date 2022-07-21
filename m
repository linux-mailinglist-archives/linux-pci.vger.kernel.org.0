Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C2957C710
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 11:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiGUJEI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 05:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiGUJEH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 05:04:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E795491FD
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 02:04:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z25so1772138lfr.2
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 02:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qOhFQavxJkvkRKqQgOoA5BchNmvzO4jziMu32JUVuNA=;
        b=QNll75k6VEea9CaxOaIqrXRacFYtNT3F2Bq/yWxrAhnNJRCSumd9rM9kVEns5mq0r1
         U/B9TB7RsXf1gS5hcws1WFcFdA8ZW0GsU4IYok0wx7o31IFwdNjiQ6w+3VayslxIcg4y
         Pz/MHe9t1EoO0sbXkdEoatUHtBYkAajEGt6UNdat+csjNevWWF/ZYnzxQhVgMCD3km/B
         93nrPvREJIogZIZqjmjnQK+bSL3rCHZIxoCRTWEfmkwerhFUwTtO0rhaIvTwI7nvNeDH
         A1DtJKugWVoy3PNWaPCeXjX1Qxw+V7z5tGLd8LgjgcuA7KQoQ9BRukuHUiRx1m4nxMys
         5ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qOhFQavxJkvkRKqQgOoA5BchNmvzO4jziMu32JUVuNA=;
        b=yB7eNz3FGikmoG8OMbnRQecn6Hi8kYXJUZqFQcJyRuhizgVdVxfomEoQ+OnriELl8O
         Nk1TT5s1GkmQ+Clr0Pf12PUYWRZrFbZy54hRVP4g4JL7DM6blXgCzPasmQjWABDPOxrq
         hyUCLTTI4YcNUiMmRyKjdB9h9kW7Kven0+rSRz/Qv7q7NxIxnjK37E0XgFTXDIEbkgoN
         sbX0PFmCFbTbd1Q5r6QaJA1GDhDoIvmeejDQwVNrnXRRJQ4n/Njbhe67RoHThXl4xTpY
         IOTogsUrnQRqeWbl/lPTlH60fiqYsWvZnjEFVnoFdQloKInGBXpcT4Cj22Pq7AHgCuva
         G9lw==
X-Gm-Message-State: AJIora/CzBzPfiVT0/5k2CPFO9Yvub8SY7+//B0pgmFTzAWs9j/SEQEc
        5X2UNl+vRD5yxSejkwzWFqUq+w==
X-Google-Smtp-Source: AGRyM1ush+aEGmuDIEZDFrboDoGXmSzQ7CNf3N7FSQSEBZ71eG+3L8h9AZRDlRReQksfSBw+oJSTIA==
X-Received: by 2002:a05:6512:228f:b0:489:c924:d44a with SMTP id f15-20020a056512228f00b00489c924d44amr20793946lfu.252.1658394244694;
        Thu, 21 Jul 2022 02:04:04 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id o23-20020ac24e97000000b004867a427026sm318964lfr.40.2022.07.21.02.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:04:03 -0700 (PDT)
Message-ID: <226ac31e-2ac4-cb73-ab67-62f86d5e5783@linaro.org>
Date:   Thu, 21 Jul 2022 11:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Content-Language: en-US
To:     wangseok.lee@samsung.com,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>
Cc:     Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
References: <20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p5>
 <CGME20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p3>
 <20220720060112epcms2p30a05414992cf814e5886af2b70c0f58f@epcms2p3>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720060112epcms2p30a05414992cf814e5886af2b70c0f58f@epcms2p3>
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

On 20/07/2022 08:01, Wangseok Lee wrote:
> Add support Axis, ARTPEC-8 SoC. ARTPEC-8 is the SoC platform of Axis
> Communications. This is based on arm64 and support GEN4 & 2lane. This
> PCIe controller is based on DesignWare Hardware core and uses DesignWare
> core functions to implement the driver. "pcie-artpec6. c" supports artpec6
> and artpec7 H/W. artpec8 can not be expanded because H/W configuration is
> completely different from artpec6/7. PHY and sub controller are different.
> 
> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> Signed-off-by: Jaeho Cho <jaeho79.cho@samsung.com>
> ---
> v3->v4 :
> -Remove unnecessary enum type
> -Fix indentation
> 

Thanks for the changes. This starts to look good, however I am not going
to ack it. This is also not a strong NAK, as I would respect Bjorn and
other maintainers decision.

I don't like the approach of creating only Artpec-8 specific driver.
Samsung heavily reuses its block in all Exynos devices. Now it re-uses
them for other designs as well. Therefore, even if merging with existing
Exynos PCIe driver is not feasible (we had such discussions), I expect
this to cover all Samsung Foundry PCIe devices. From all current designs
up to future licensed blocks, including some new Samsung Exynos SoC. Or
at least be ready for it.

However it seems you are interested only in achieving one goal here -
satisfy Axis. I believe it is not the "upstream approach". Next month
you come up with same driver for different customer and you keep
insisting "it's different!".

To get my ack I want to see something generic for Samsung Exynos SoC and
other licensed or designed blocks, instead of something made for only
one of your customers.

Best regards,
Krzysztof
