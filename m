Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6FD55F623
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiF2GFV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiF2GFN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:05:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E30917062
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 23:05:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q6so30293158eji.13
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 23:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uGY+jOQ2fDtGwhpBG0jOGtMDvHqQPy+lwiNiTo9tAGI=;
        b=cU3RsXB7qJInbLOuBSrC30bSU4N38bE5ivi1ybaT3QdSZsHMZLnZNKMw7An9Y7Ktp6
         eH5OBkK9gJImXGJQnY2TyQVYghECaPvsH/5L0Dbxa4wVov00ETIjspX7mAWpHmsxjUwQ
         n3XBJCU1ON3a15RksIfFywIpTyvbzMbhnlDEXv6CJqhjQPKM+H0NFwcQrPDLHZEuSXfK
         A982nTDFM7gIQkwCfJP77i+Wkob9qnnRZYnAd9y+mpieiV5mOx0Z9DR9qR5x0hTkIcJT
         Q/79G3udrYYLwtK/zFvMKjaf6MjDzNY2AwN0g4arX9HEOTK7xHfIl1SkrB0q8VkiI/vd
         Gxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uGY+jOQ2fDtGwhpBG0jOGtMDvHqQPy+lwiNiTo9tAGI=;
        b=SAuEvi0xS2/V7MIj79CIXLvlyWV9kUNm4AmOJciuCMxITXkhI7BemY1UGxaua075AH
         wURTcSHbzUebsIwOZdLfOf4YX4R7MISTDZxisgZ4FwZri34SonYNX+ykHEFJUdYmbjIe
         M90RCGSMi1MuNRtVHTXhgSXJQO7OITrWr9z+OrofvLKwm3sIyGjZDuGHqvjCJodqImC4
         N9wwvNtNDzffwiEi8pgowaEif1BsHUUCYpWYWNuFCEGGDeNNqhSrX8CJIVjYIMb4DnnP
         y4eXTmTxauxYZQgLEBHi04gQXR6lxeSZynqiGoAH1HX2GZ9Iflh2UgzVhQuWwx+ExpyD
         DwlA==
X-Gm-Message-State: AJIora9ZsbLmwdMCFbs4Z9Kuj9ghuf4yPC+HjjJE3wPDZkuFwmnQ5/mE
        WJjsDtxc6weNhEHE3rU7jfRlIw==
X-Google-Smtp-Source: AGRyM1vGU72GMkFkoo/ffWzfMP4gjWTNAd01+PTMiL3WQsSd9gW5N5OlaaRS+NAtsf/jdGEZlA0z/w==
X-Received: by 2002:a17:907:2814:b0:72a:3758:e948 with SMTP id eb20-20020a170907281400b0072a3758e948mr658896ejc.8.1656482708846;
        Tue, 28 Jun 2022 23:05:08 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i23-20020aa7c9d7000000b0042de3d661d2sm10692507edt.1.2022.06.28.23.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 23:05:08 -0700 (PDT)
Message-ID: <19b5c553-466a-14c6-bf29-577323d9ec29@linaro.org>
Date:   Wed, 29 Jun 2022 08:05:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] PCI: dwc: exynos: Correct generic PHY usage
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20220628220409.26545-1-m.szyprowski@samsung.com>
 <CGME20220628220441eucas1p2098d46abc47ec1888781fdc5319dec67@eucas1p2.samsung.com>
 <20220628220409.26545-2-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628220409.26545-2-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/06/2022 00:04, Marek Szyprowski wrote:
> The proper initialization for generic PHYs is to call first phy_init(),
> then phy_power_on().
> 
> While touching this, lets remove the phy_reset() call. It is just a
> left-over from the obsoleted Exynos5440 support and current exynos-pcie
> PHY driver doesn't even support this function. It is also rarely used by
> other drivers.
> 
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
