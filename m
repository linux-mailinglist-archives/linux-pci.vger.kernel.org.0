Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD1F632195
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 13:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiKUMHt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 07:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKUMHs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 07:07:48 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE791DDD1
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 04:07:46 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bp15so18476927lfb.13
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 04:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfG4cik696zUtTBIcgQeTEQkmrpF/e/tKgc3C9UfvMI=;
        b=K7nx5lnfzyOxynPYjR0p0HHRc5IfrvUbf4CaMa1zyzlYDYq01CLKng1A6CbAfP1m2J
         lofU9IbY+WMrD65t1E2woswDiJrB6+bWX/yorIMPkji3TgJ7bjsaEh0ZMF1toWu86hx9
         N1XmMx9Ie0693BDRWwTbtwpHSqTzSc4CXlBKVQG5UsYX6q9PESI08f8NlxQxt7FzVO08
         4KQZpuWxuo1C9RF+vtp9hsmVYpvLAFdxi4bmD/v331ibMOSUJGB7VfLHxQ+6V9qosJgL
         BpinSHXE6DkS377Ydsa4KBVYqP1fekFNlLdcScLHdU7IOCgHiTfu/6MxX5WBAKQH6BUC
         n5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfG4cik696zUtTBIcgQeTEQkmrpF/e/tKgc3C9UfvMI=;
        b=BdwyeAvfqTieAC/Meutd5TEr+uJkPs+H0FYjjvZU7bIjL/dTeaBT6qcbzeprGhcLrR
         EhF6hKRCbB9WbrQIYNvBK7Qa91X1lQNcKcTza7wgSOryhD+fu5/NXN+vqlvyk9MdILBC
         2jCMfBVkEK4MkShtxQrLcQc59660dUDyXfgGIn1CQs7RbcvP7sLwWO/CxkecvR5N6OBh
         DO+6dDL49jZ/QjRZ//XSanU40kml/q6GmxRGjmzbWXzKcIKXJksYiXED7nYAHLmULJBB
         STawiK4DVbhv3nXD5gf4CXTbDYeJvTMKq8z9Zia1xjtJbsNjG9rYL3IKjMz2s2EFWft3
         2lCQ==
X-Gm-Message-State: ANoB5pmvbuFkv/G/Xry9ErV8ZFi3Cq4CXllZYAGWa+KjxoxsafWA+fDh
        DG9DFUI2n3CZYzqlMLKTjiuJQg==
X-Google-Smtp-Source: AA0mqf5rEQabyEzmEwn4ur6+5m8qVOBvPw935+wb9q5UxzKEspgNRcHmTLImdMuMncb0C35ujXdA0g==
X-Received: by 2002:a05:6512:3f89:b0:4ac:660b:1f02 with SMTP id x9-20020a0565123f8900b004ac660b1f02mr2247583lfa.9.1669032464923;
        Mon, 21 Nov 2022 04:07:44 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t22-20020ac25496000000b004b491fe071fsm1979285lfk.36.2022.11.21.04.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:07:44 -0800 (PST)
Message-ID: <646b30eb-ab89-b4c0-1a71-b296359bd00b@linaro.org>
Date:   Mon, 21 Nov 2022 13:07:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/6] PCI: dwc: fsd: Add FSD PCIe Controller driver support
Content-Language: en-US
To:     Shradha Todi <shradha.t@samsung.com>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, mani@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, rcsekar@samsung.com,
        sriranjani.p@samsung.com, bharat.uppal@samsung.com,
        s.prashar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        niyas.ahmed@samsung.com, chanho61.park@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20221121105210.68596-1-shradha.t@samsung.com>
 <CGME20221121104731epcas5p48f96c92e5bfb4ede56ce74a78887a2f3@epcas5p4.samsung.com>
 <20221121105210.68596-4-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121105210.68596-4-shradha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/11/2022 11:52, Shradha Todi wrote:
> Add PCIe controller driver file for PCIe controller
> found in fsd SoC family. This driver adds support for both RC
> and EP mode.
> 
> Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/Kconfig    |   35 +
>  drivers/pci/controller/dwc/Makefile   |    1 +
>  drivers/pci/controller/dwc/pcie-fsd.c | 1021 +++++++++++++++++++++++++
>  3 files changed, 1057 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-fsd.c
> 

Yeah, when Samsung started upstreaming Artpec-8 PCI and said "it is
entirely different, cannot be merged with anything else", I had a
feeling it will bite us.

So now we see one more.

Then in some days there will be separate PCI for Exynos in Google
products. Then in company X, then Y.

No, work on unified approach not 3 different drivers.

Best regards,
Krzysztof

