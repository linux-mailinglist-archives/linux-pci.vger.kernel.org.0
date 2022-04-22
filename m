Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB3650B800
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 15:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383443AbiDVNO3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 09:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447698AbiDVNO2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 09:14:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B78247AE4
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 06:11:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k23so16358233ejd.3
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V4rCAl/VsMXGRmoKV9M0tqPzlmugWmFVKZTuciVyBE8=;
        b=NIUu32ceaN+2jg59UOiopsetEcXfblHX7Es0mNEWnRHjXzzeib2CADsLB3GjXK2nEa
         u/UW6265JDDb8ekuAAW79pM806946jRzYTAPDX0CDGyctsiR7WwtPW8/rYaDokB9JkiI
         tveItcHZfq0Pt/B4W5tcMSk1XF0sIsx8aVCS7vdS6fodKH4NKfvhPtho+590kgBIbsZp
         pjsERH9MOuSAQPuXSgOXhzdZjsjbzeELrqSvEo6bWm9eT5WZA1FIBEBRQ1dsPmDFGNZA
         spJg3uOIfY8AH42EY6TejHxPhEHwXswKP5Py0gslWwvaxo1jP9LtsuhZ1ZBPhh1S14cU
         kX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V4rCAl/VsMXGRmoKV9M0tqPzlmugWmFVKZTuciVyBE8=;
        b=tFAXYOezE8Ja/LijFGtz2WiysKOh4i4cAzDTwiJQ6/UJBybGQ1/7K2WB3n18zEX9k7
         2U4n3IqrwH7neu35MvvRcaRh2Vz/MDf9Gzc8sPQYPlUkTavd2nUP1Ip6MT7bjnJMLEwM
         6eFnzy5lFdLuzQW+SAfR3J0pP6/dqTUsOy4kfF/RMNd7FE6NmmtydBq1sxFGZg9BnMT+
         yH3rPa1VDkNNwb823NQQ9ZLMPSOkDxhJRL5M1eodHI4Ue5IeF8hD2NLRiYKAS7K04P9A
         wLDrn68Oh3YvKJPmid8/+XTwJ0vm3xvAaDvVGne9uS3XS1cMV/Dh0qBB0Ls4XuhIE324
         zM5w==
X-Gm-Message-State: AOAM532l2UqJOdtwWGas6UjdNb2pN750tKKHmWVzQ+dTWfCYBxEJ/Pwz
        7mzlQ8H+ju7fMtNv9uwgLEBVHA==
X-Google-Smtp-Source: ABdhPJyFelF5DC6xKgnvaCZLaxSeczfq56UmZfRD2s0izYrrnztbpdg6AIL3KyCPXSmSE2Cen3tsUA==
X-Received: by 2002:a17:907:c1b:b0:6f0:1335:6fb with SMTP id ga27-20020a1709070c1b00b006f0133506fbmr4207848ejc.294.1650633090731;
        Fri, 22 Apr 2022 06:11:30 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id br14-20020a170906d14e00b006e88db05620sm760722ejb.146.2022.04.22.06.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 06:11:30 -0700 (PDT)
Message-ID: <d0884594-d962-d423-e34d-9ab123ebccc1@linaro.org>
Date:   Fri, 22 Apr 2022 15:11:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/6] dt-bindings: pci/qcom,pcie: add schema for sc7280
 chipset
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
 <20220422114841.1854138-3-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422114841.1854138-3-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/04/2022 13:48, Dmitry Baryshkov wrote:
> Add support for sc7280-specific clock and reset definitions.

Add it at the end, please. First all the cleanups and changes, then new
devices.

Best regards,
Best regards,
Krzysztof
