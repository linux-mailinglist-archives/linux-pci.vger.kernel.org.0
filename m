Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C1169925F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjBPK4u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjBPK4t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:56:49 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCFFB776
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:55:54 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lf10so4181444ejc.5
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wELXWPPoXk4hvkrL0n24gtCGLJJqnUYYyY4uopwT0do=;
        b=sO5dU0gLMQb9Kor9OD9tiQaZ+g6Ijl3BCOZJ4uIa9xldCN2i5C2gFA5OTQQDsRmLC4
         VNuuRm3r/DPpu8zRw3zx6Yc0CXPWV92JPqXgzZbu/Y29G/LLShytWwVOrj4XvOuzGOxF
         2ZW+JAwylk9JKz9w3ZWQ1mmX0EtSFgdJMgn7PXSmo08zhj9m2voZWBh2dJJ7jNmPq4UQ
         zFDnD8sFX2uARQdfKOlBEnVvJb+1UAdE2MjNHDkRosMMjVhJt6J9vKxeteNV8P+c8Qw5
         rYdubt6NHPYnWhnJEuqO/pDWp+8YvOP2xs8zn9Nbf+ZZEebxOCoPO3dFeuryzSD1uI25
         3i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wELXWPPoXk4hvkrL0n24gtCGLJJqnUYYyY4uopwT0do=;
        b=XZdYH+ulQOkzdZJhLvgQkfWiUz80hWManwyIVUi6jPdIdLFO0kjdnA4bR60S4/4GZc
         zlIfYMK8KLdkOeTkvOP2OR5/ynVOjxJ2ihOAp8ecSMdnQ4NGgVkbYcE2RS5Ck3dbequQ
         SW1p4rOXbf7DmZP8GpuiGO67OL4Z31Tei5qsb5ywunT0iNgkF3UKvQROSGSZtf/45TgO
         WRFAHztNZpgrUMZON22PAolyJ/lphB1ngmSMkV9UKHy98eRz26QBSDPc+Jj4PuQBZPLf
         vw4XNsp6KUZ5LwfB+Swxkh245yRkE7usDaJGwjSelOTZ1syPoxpypt1IcnxSSyFJ2UAx
         jalg==
X-Gm-Message-State: AO0yUKVcJEDXlFt1GYzvQSY9GLL31gwwdwntuVFSYZ7VdKUpmnlbEJlZ
        xSIhg9AyGwueySR8HRyqJxV5Lw==
X-Google-Smtp-Source: AK7set/d4qp8Og+m+oKhKa3w+tTNVK0pbSJ3GHq2sgppAOaYduPGmD7LK7OQ+NQ7kXBno6gxbM+2CQ==
X-Received: by 2002:a17:906:6c95:b0:886:7eae:26c4 with SMTP id s21-20020a1709066c9500b008867eae26c4mr5133303ejr.5.1676544952785;
        Thu, 16 Feb 2023 02:55:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id gh15-20020a170906e08f00b008720c458bd4sm664172ejb.3.2023.02.16.02.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:55:52 -0800 (PST)
Message-ID: <d0d1db7e-e2a7-dddf-5c28-fed330b44cdb@linaro.org>
Date:   Thu, 16 Feb 2023 11:55:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 02/16] PCI: exynos: Rename Exynos PCIe driver to Samsung
 PCIe
Content-Language: en-US
To:     Shradha Todi <shradha.t@samsung.com>, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jingoohan1@gmail.com, Sergey.Semin@baikalelectronics.ru,
        lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com, tglx@linutronix.de,
        m.szyprowski@samsung.com, jh80.chung@samsung.co,
        pankaj.dubey@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214121333.1837-1-shradha.t@samsung.com>
 <CGME20230214121411epcas5p25efd5d4242c512f21165df0c2e81b8bc@epcas5p2.samsung.com>
 <20230214121333.1837-3-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214121333.1837-3-shradha.t@samsung.com>
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

On 14/02/2023 13:13, Shradha Todi wrote:
> The current PCIe controller driver is being used for Exynos5433
> SoC only. In order to extend this driver for all SoCs manufactured
> by Samsung using DWC PCIe controller, rename this driver and make
> it Samsung specific instead of any Samsung SoC name.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  MAINTAINERS                              |   4 +-
>  drivers/pci/controller/dwc/Kconfig       |   6 +-
>  drivers/pci/controller/dwc/Makefile      |   2 +-
>  drivers/pci/controller/dwc/pci-samsung.c | 443 +++++++++++++++++++++++

Rename missing. I am anyway not sure if this is good. What's wrong with
old name?

Best regards,
Krzysztof

