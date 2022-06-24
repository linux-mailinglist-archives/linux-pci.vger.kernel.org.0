Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D832655A083
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 20:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiFXSIC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 14:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFXSIC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 14:08:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924F51145B
        for <linux-pci@vger.kernel.org>; Fri, 24 Jun 2022 11:08:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k22so4132657wrd.6
        for <linux-pci@vger.kernel.org>; Fri, 24 Jun 2022 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JQitULWmHnKy7C2KWjW3JWCf8vDb5NvNlwl4b24k9NQ=;
        b=yQ289iPIrenzsMATI9KyJ7iKpC12z1HDpCP3uaB+If+6X4HrWwmpIVkXWJy2rRLTSj
         DsFX84I6XSTweQtQPxPiS3ZCjz3CJji+hv6qyGcZoQeWZjKzJR21XVlOXeqwOEfQx73N
         BL8MXnEBQYKoqGZLvi8kVDT64A4UBxAhvtZ6cx26TzpXDaYJmjI5ZZIf2dMaDrLRxLai
         1d3UhzWObsLmTg96qpGBmZqp/8hu1W5wHxbQSfYmWi+KZxFQkNv2y3aFInAskYhRd4WN
         tjh7GLS8nlPM6hTxheACc5aLBlB8OCk0JuP/6bp9gKYkbEFxFekUt24Wa0vfAcMgPsc1
         UYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JQitULWmHnKy7C2KWjW3JWCf8vDb5NvNlwl4b24k9NQ=;
        b=OYYKd9n+UaYPFS/RTK9H7g1GOMLV3ym4iszwY4zga3Nn/GHwE3IvMlGhGN9JrrSeOf
         LJsEK8WvmAUKZVp7cx7vnTBr3O0X05k7Uv1P+rouAwTNh/pd2ybhuhzwGFf7s0gaX0Qm
         lSvMU/HjEfPoJBLVOl630jnZNEys9gBI7uaA4l9wpF5JIgth6bnjtSSvC46alJahRXLM
         vq2Wtz56vkiRhjGmhPR+5Jmvyw8w1sRBQ8PtlQWLoSHOR1mJWN+cpnP8t8sZbWbuzDZC
         5JBPvc3i2B9fXcJwFmW3FTvLMV/rIr+fS0ZHntxKAtI7y3EQbarh9D/csiPh6jsKAkDu
         7Y5A==
X-Gm-Message-State: AJIora/FqayQfMmLIBxs5O/H9nRonk8R31i/WTZmg4sD/5EaLtjOwhSJ
        Pwb7JzAyZLDEWDEyJnFsk8sZow==
X-Google-Smtp-Source: AGRyM1vH2dwrQTE+lvYQLwlqgfGnCgkakQOQnLE1QU3ILOlC7Duc8q7H8ZEN76zExDlSPxpr7QuXhA==
X-Received: by 2002:a05:6000:18a9:b0:218:7791:a9ad with SMTP id b9-20020a05600018a900b002187791a9admr438347wri.116.1656094079135;
        Fri, 24 Jun 2022 11:07:59 -0700 (PDT)
Received: from [192.168.0.237] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d5544000000b0021a39f5ba3bsm3004772wrw.7.2022.06.24.11.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 11:07:58 -0700 (PDT)
Message-ID: <c0c802c0-82e1-e7bb-48be-974ac23b5a15@linaro.org>
Date:   Fri, 24 Jun 2022 20:07:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: pci-exynos.c phy_init() usage
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220624173541.GA1543581@bhelgaas>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624173541.GA1543581@bhelgaas>
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

On 24/06/2022 19:35, Bjorn Helgaas wrote:
> In exynos_pcie_host_init() [1], we call:
> 
>   phy_reset(ep->phy);
>   phy_power_on(ep->phy);
>   phy_init(ep->phy);
> 
> The phy_init() function comment [2] says it must be called before
> phy_power_on().  Is exynos doing this backwards?

Looks like. I don't have Exynos hardware with a PCI, so cannot
test/fix/verify.

Luckily for Exynos ;-) it's not alone in this pattern:
drivers/net/ethernet/marvell/sky2.c
drivers/usb/dwc2/platform.c

> 
> Bjorn
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-exynos.c?id=v5.19-rc1#n252
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/phy-core.c?id=v5.19-rc1#n233


Best regards,
Krzysztof
