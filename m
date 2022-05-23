Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8859B530FAB
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiEWNDt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 09:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbiEWNDs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 09:03:48 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E7762C5
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 06:03:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c19so12373682lfv.5
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 06:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z71NrWZ4zknsDrIoo+iB7dCvZtP2uMdNm3QPfhAif8o=;
        b=bzd1qj/qFKT8OfqgUqAT3Wtl+EmZf7RH0b71HR/rrXg8NYApV+cGqSsZ+AZV1V7rud
         9ySbTNcdwNtJIoHRuyQX5bQxvsNdJENR3BC1hgHyooGer/9nIJjCpCKjNxpRKMqQ9W/A
         IPQBEGPFJLoQPL7Fl7RiTgbRFCEq2VnZlHO9aFBDQH1aydu8ZTsj0xa9XQOQy/tJ1r53
         j5DHW2fuqbA+sGi8IMlHjwcM2FrfzGOvjtfpyGce7NTiWd9j4qHpH0JsTjIaGDEHb3Wz
         FnAoSBkQWGH23lna51WTqbWpLOnainyACCGSdLrCkHZ+fBjR1AytIi+4qVeKiS0R5+2H
         ziwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z71NrWZ4zknsDrIoo+iB7dCvZtP2uMdNm3QPfhAif8o=;
        b=XQ4I0cdc0MOldro7iLkNLr2GHqhLubPHkMO1dKCjzwpa86bw4HGu+Joq6VnJXcKe/U
         T6SvYTXrppKUdgu1sL3VSfSriwzusjzkYB3nPqW1EgP4KjxaWWsiENxdUrcICxf0APFp
         9nvPT8yoXBjWlb4IUx4xq9/SFLEwaHSg8v5WscrqVe4UWK6QERgBDMltm6vzkygo/IdF
         WS0oHLtSDLzT0hKWQ5MhQLN48EvyLFWwqWtZb6eKMdNhzsCChxwdCD4k+HFMWA8Y4hcY
         j8OYrqrP6EuzaXK1+e+qNQUyxHxtz0cHO+OBgf+V7piEhMklBvm2Pjvmay/j3+U9+Cst
         tlWA==
X-Gm-Message-State: AOAM531a3RYKJNfIZ4/l0Qo2CUzGgX98YPD8Ns/Lw0nETzMHGxFss2mM
        Z0XRV/SlO6NrP7eVlsuAdsf1Dw==
X-Google-Smtp-Source: ABdhPJyq6y9OSMA4U7e6i2YMcuLgOdxRayWbuMH/9MhLJwISF/h6mzK0bZFByAbvBLNQzUdsZ7wHag==
X-Received: by 2002:a05:6512:2256:b0:473:d27f:dd93 with SMTP id i22-20020a056512225600b00473d27fdd93mr16900739lfu.512.1653311024297;
        Mon, 23 May 2022 06:03:44 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f10-20020ac2508a000000b0047255d2115csm1968683lfm.139.2022.05.23.06.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 06:03:43 -0700 (PDT)
Message-ID: <1af9f5ff-2115-1809-15b1-fea306a11877@linaro.org>
Date:   Mon, 23 May 2022 16:03:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v11 0/7] PCI: qcom: Fix higher MSI vectors handling
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20220520183114.1356599-1-dmitry.baryshkov@linaro.org>
 <Yos6zKHUKywKcmzy@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Yos6zKHUKywKcmzy@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/05/2022 10:42, Johan Hovold wrote:
> On Fri, May 20, 2022 at 09:31:07PM +0300, Dmitry Baryshkov wrote:
>> I have replied with my Tested-by to the patch at [2], which has landed
>> in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
>> Add support for handling MSIs from 8 endpoints"). However lately I
>> noticed that during the tests I still had 'pcie_pme=nomsi', so the
>> device was not forced to use higher MSI vectors.
>>
>> After removing this option I noticed that hight MSI vectors are not
>> delivered on tested platforms. After additional research I stumbled upon
>> a patch in msm-4.14 ([1]), which describes that each group of MSI
>> vectors is mapped to the separate interrupt. Implement corresponding
>> mapping.
>>
>> The first patch in the series is a revert of  [2] (landed in pci-next).
>> Either both patches should be applied or both should be dropped.
>>
>> Patchseries dependecies: [3] (for the schema change).
>>
>> Changes since v10:
>>   - Remove has_split_msi_irqs flag. Trust DT and use split MSI IRQs if
>>     they are described in the DT. This removes the need for the
>>     pcie-qcom.c changes (everything is handled by the core (suggested by
>>     Johan).
> 
> You could also mention the rebase and fixed warnings with less than
> eight msi.
>   
>> [1] https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/commit/671a3d5f129f4bfe477152292ada2194c8440d22
>> [2] https://lore.kernel.org/linux-arm-msm/20211214101319.25258-1-manivannan.sadhasivam@linaro.org/
>> [3] https://lore.kernel.org/linux-arm-msm/20220422211002.2012070-1-dmitry.baryshkov@linaro.org/
>>
>>
>> Dmitry Baryshkov (7):
>>    PCI: dwc: Convert msi_irq to the array
>>    PCI: dwc: split MSI IRQ parsing/allocation to a separate function
>>    PCI: dwc: Handle MSIs routed to multiple GIC interrupts
>>    PCI: dwc: Implement special ISR handler for split MSI IRQ setup
>>    dt-bindings: PCI: qcom: Support additional MSI interrupts
>>    arm64: dts: qcom: sm8250: provide additional MSI interrupts
>>    dt-bindings: mfd: qcom,qca639x: add binding for QCA639x defvice
> 
> Looks like you used the wrong offsets from HEAD or something when
> generating the series as the first two patches ([1] above, which is not
> yet in linux-next, and the dw_pcie_free_msi() fix) are now missing and
> the last patch is new and unrelated.

Ugh. Please excuse me.

> 
> Johan


-- 
With best wishes
Dmitry
