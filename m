Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B9B6992A4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 12:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBPLEE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 06:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjBPLEC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 06:04:02 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E432CC52
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 03:03:56 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id lf10so4232554ejc.5
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 03:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05B24lj495gL3YgwvcUcNmRG4nf0y5CDDgfLMqhmDlI=;
        b=AeryuDonyuYJ7Hb5MmF/zv0+FLwJd++pz8huBoO5AqbCUwcZ4mMVuERpuPR+XV4yYi
         1oOgnlDpgT06Njx5YsgGW8+6JljVIacIzekxindg5vMPjmct3YtqnsC5+UF6XL1+Mj4p
         anbf9TDfAlb6apUfwdk4VpuQhoEReQiumgrDvfUJuRwOyLkG1xyGMAlWxIOS6hu6H2o0
         rpyUU2u7kg+ADGadWT/77AOFIncvVYoiYigD7CZy0woPTokiC3VIPr8YoXQs/vQOyC20
         7OT63MZoDwCneVCMmOnfVo+45fvJUEmyDupE6eKNbi8O0Xh/DLQS/qfGq9Y/rj4H9uS8
         nPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05B24lj495gL3YgwvcUcNmRG4nf0y5CDDgfLMqhmDlI=;
        b=kGcY5YzkMFGk0jNfJjt93NTwCy/vk23MXYVcgXgwjsrL2Ik7WIBERSAvZEhu/OXgTZ
         0qyBpDtVLmrEZSOxxYguPe0Dou22kIC/HzvpONQ0O+bnurFhrDXDVPr3d34PlY2Meq7Y
         B/fDamoN+Vvp44Flmtn4UKeZaVrvOWuX/y4hAI4HDxNbgqHZd7ngdJYrhfyyQITzYEsP
         y0VCo2+m4B+c8pWpd8Iy7NqbUasnaEIsQHJj8ZIYUIuN0BJDfGe055DtepPJLVLToBGi
         cMFoYrFhOPVsGCf6yRHeeoHafgusiY3OdoY6UOwwe6S0a3/UiCP83XXUsBKzfWT2NaCT
         n79A==
X-Gm-Message-State: AO0yUKWH8bW/sGRfsltMSLvAXaBYTLwdcueyzuhaoCP9Kgf+Emjx3PpG
        o+jrVNDwM2AxuO7gqxtCgeLSRg==
X-Google-Smtp-Source: AK7set+ApyxJAXzJUJINfPF5aCfGR9rzmp4xtUXimX8JKkp1pC42vnAebEWKLzmYkAONLKPN3rJnmw==
X-Received: by 2002:a17:906:dd:b0:88b:a30:25f0 with SMTP id 29-20020a17090600dd00b0088b0a3025f0mr6214535eji.32.1676545435434;
        Thu, 16 Feb 2023 03:03:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id jt8-20020a170906dfc800b008b13ce1c460sm667328ejc.40.2023.02.16.03.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 03:03:55 -0800 (PST)
Message-ID: <31e377b7-88bf-8737-0397-44ecca8cff54@linaro.org>
Date:   Thu, 16 Feb 2023 12:03:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 06/16] arm64: dts: exynos: Rename the term elbi to appl
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
 <CGME20230214121428epcas5p3d91e877e62a78008d2b0d6066efea059@epcas5p3.samsung.com>
 <20230214121333.1837-7-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214121333.1837-7-shradha.t@samsung.com>
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
> DT uses the name elbi in reg-names for application logic
> registers which is a wrong nomenclature. This patch fixes
> the same.
> 
> This commit shouldn't be applied without changes
> "dt-bindings: PCI: Rename the term elbi to appl" and
> "PCI: samsung: Rename the term elbi to appl"

Dependencies and patch ordering goes after '---', because there is no
point to store it in git history.

Anyway, that's an ABI break and Exynos5433 is quite stable, so without
clear indication of fixed bug, we should not do this.


Best regards,
Krzysztof

