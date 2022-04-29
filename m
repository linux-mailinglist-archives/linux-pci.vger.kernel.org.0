Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414335158A1
	for <lists+linux-pci@lfdr.de>; Sat, 30 Apr 2022 00:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381599AbiD2Wn7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 18:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381611AbiD2Wnw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 18:43:52 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718CF1E3FC
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 15:40:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s27so12123985ljd.2
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 15:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WQqv5jsy5NviH5hoj1FwHfKerTy0YHKg1MYY89svw0E=;
        b=NhcMfwsBGmuuvMDSnGKLhEipmq5u7KXFLey1k25yxf9GNyl2DUB1DDAcjdmyERdWDO
         fPIfoDzkTdsnxptZYC4G+DRM0nKqUAWj7PMRGrDv86h83qAOg+VObA+zMJs0Bo1ciFlJ
         VrUiuAO+7DkHMxo5rgPgK5KV7+4bD6gsL2/o426Y85j6K/pj0FFzorRloCKs6dhVhJWj
         h738gPMZts4YXUJRyKwmWVhwamEE1IhNIm707HBm72g7aVjOGNfKiVrcm9Y8y30noRmD
         4a0Q1QFFp04wAqFT+YTH5opAaQ+0YILINVVOurmodBIB+pcx8yiyrcWSl0zPIlHWBj+W
         il4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WQqv5jsy5NviH5hoj1FwHfKerTy0YHKg1MYY89svw0E=;
        b=xokxVi1PCgbObryk1hNIqHfC01rMd2KLx5XWAUFuCivcsOydyP19wN7F8+6gY6cK0v
         WpiCFCgROri3eLa5960HgkIynjwJMI8+aKPQ1trxdACIfjAC++XpZheZ7YOq8f473o/S
         6Lne5Ke9IuGT47iupyzQ5Giz3nVUbEoy+HrOkYf6Rb9U623GZFvnu4mQCI3TJchcwkCt
         c0v5utWmql1dCn/uPgvo8y41t+NNvmtTfaOxIO4ER0P0FoDid5hMGNpleWRwQQMRUZTY
         UlfSs6EfkEIOMSm23rVkdTNBo0pbXOEderOpO4+N96QLEwvmyNzZc6PncE+HE4spITs9
         a8HQ==
X-Gm-Message-State: AOAM5334WhdFS4izu2k6l45nHr4nHriLnNIYu+waXa76py6WxkTXpshG
        EWzykVtYBvqBeXls9Iusr1dsiQ==
X-Google-Smtp-Source: ABdhPJxcY4iY9iCSvmLH7RshXVp/DOdqX+TlgZcg3q06hsfa2wp3WccpsPLzEa0yojGQvpYuNlr3FA==
X-Received: by 2002:a05:651c:179a:b0:247:d37b:6ec5 with SMTP id bn26-20020a05651c179a00b00247d37b6ec5mr848389ljb.112.1651272030783;
        Fri, 29 Apr 2022 15:40:30 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s4-20020a05651c048400b0024f3d1daeaesm381377ljc.54.2022.04.29.15.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 15:40:30 -0700 (PDT)
Message-ID: <0f240264-a6cd-156b-ecd0-d94197b18ede@linaro.org>
Date:   Sat, 30 Apr 2022 01:40:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 2/8] dt-bindings: PCI: qcom: Do not require resets on
 msm8996 platforms
Content-Language: en-GB
To:     Bjorn Helgaas <helgaas@kernel.org>
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20220429220233.GA110383@bhelgaas>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220429220233.GA110383@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/04/2022 01:02, Bjorn Helgaas wrote:
> On Sat, Apr 30, 2022 at 12:30:26AM +0300, Dmitry Baryshkov wrote:
>> On MSM8996/APQ8096 platforms the PCIe controller doesn't have any
>> resets. So move the requirement stance under the corresponding if
>> condition.
> 
> Nit: Pretty sure you mean "stanza" instead of "stance".  Only
> mentioning it because I pointed it out last time but it was buried
> down in some text that I should have trimmed out.

Yes, and you even pointed that out. Completely forgot about it while 
updating the patches.


-- 
With best wishes
Dmitry
