Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6009624956
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 19:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiKJSY6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 13:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiKJSY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 13:24:58 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D6D11C1F
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 10:24:56 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z24so1889603ljn.4
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 10:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTCljyMcfKbw9XuCwVZ96+0GS37u6vdCB1YXTkk2DbY=;
        b=vgY5Suhil67GTfIoiXw9WZ7OJAiXbWsB4vAomJN5mRDzZhxWWYIGtG4xXlaRZBVa+Q
         3IX5M7+4kBtM8jmo5CaVSSckv6h0t/XEkpMYp6mPOrv+r8oMX41YEhUQaqJErBaKFUTC
         xVZiSUmc0YTowc2kBjowNF9AG3gMLSqq9RblZW125yG00f3P7eidSvxx+AN30nETvTBd
         ycMuObSamOfl5KDXJEPcDNSBfEk6QWCPlk7YF5pXh68FC2sNYFv8YMvoKLbNgInue0py
         9upgXDIuRj3mFqML8LMsFOvnpsjreizn8WUFZ6oGrorR6AUhcQwjQXrmr+ZkjdefjHtS
         ea0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTCljyMcfKbw9XuCwVZ96+0GS37u6vdCB1YXTkk2DbY=;
        b=5ppJai44A0uhWYrehzSX8fUgT6UnSApG7qXMCI/VN4RLAFf2j4qfBE3noqx6lhLb9f
         gpvvK14kgw086go3zwXU+p+Le72LNqYf1U3R0QorhqwBUkSaIkAoSA+iGLhy/tnJHKWe
         LcD173JoWxDPaRsKmxLiy84cmWgd7XivB+lVoIJgK11eoCwqlxfWAxw4bE+VyQfuVnTo
         aApv/QpU9CDbtnzi15EKSpmuOh87mySrgbsNgl4CLeqMncue3srTVYqb9JKKiHRRvQ6P
         YhRz0eG4lyHyfn60kYIuOOSlamrVDl8xulusydeWxh67VnBk3RVHms7x6+QG7ZN7Edpy
         4v5g==
X-Gm-Message-State: ACrzQf1ZHnYWrJ0K0pWi5IFImML8+hP0VXpBa2h7s8/OSbNbh2AE2jaB
        UNlXCXeiShy/dLTozTa852fooY9qHMPECg==
X-Google-Smtp-Source: AMsMyM76w/nQzUSHmnb3AL1cENN8yfaY5B4sedrM44S2hCEC45mvyP0EBMTkqxR882LvtfQBzQJtdA==
X-Received: by 2002:a2e:9110:0:b0:277:aed:be6b with SMTP id m16-20020a2e9110000000b002770aedbe6bmr9330937ljg.322.1668104693699;
        Thu, 10 Nov 2022 10:24:53 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id h8-20020a05651c124800b0027758f0619fsm21005ljh.132.2022.11.10.10.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 10:24:53 -0800 (PST)
Message-ID: <a480bc4a-7088-dfed-7cd7-a14665022d15@linaro.org>
Date:   Thu, 10 Nov 2022 21:24:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 6/8] phy: qcom-qmp-pcie: add support for sm8350
 platform
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20221110103345.729018-1-dmitry.baryshkov@linaro.org>
 <20221110103345.729018-7-dmitry.baryshkov@linaro.org>
In-Reply-To: <20221110103345.729018-7-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/11/2022 13:33, Dmitry Baryshkov wrote:
> Add support for a single-lane and two-lane PCIe PHYs found on Qualcomm
> SM8350 platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 120 ++++++++++++++++++++++-
>   1 file changed, 119 insertions(+), 1 deletion(-)

Argh, this will not compile against the current phy/next. I'll have to 
send v3.

> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 4a55b2439952..a1f5d31d161b 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c

-- 
With best wishes
Dmitry

