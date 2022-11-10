Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FD162441B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 15:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiKJOUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 09:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiKJOUP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 09:20:15 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2571A388
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 06:20:14 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id f37so3509429lfv.8
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 06:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKIM7k+YSkhSJchQG59Vcw7ysRCT3D7i5Em2qQX+ntk=;
        b=gOf/GguwT/ZqoSTDal1pRPsRe+sI+lt0qA65Q11J6hdecTXMqYYSNEwDEGH1ODv8ZZ
         NOqAIQtICm+O4yp5H1Xn6MAJoBmzgWxC09D/4yQh8VKBr9Ivs2HEuHXRQD7hf+fDJQt2
         7EOvBqo84G1TWsDEEpFCxMmKOKk2mBEYXPzPjvDpDzpQxbVkx1SxB2ae4AJDLHB1aHaM
         2gSIrNUyjCRw8BjEgwey6qGlKFpdBOlwFu4Dfo7qUqwvSJpoTANoGsI+52JT9kTPsX8J
         ogO+RK+maF8sXinpSDDMQ2/zK3XlSSGGSKARBVUTqnQxrj82a0X7Ke0wHg3qXZAUaLUA
         SIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKIM7k+YSkhSJchQG59Vcw7ysRCT3D7i5Em2qQX+ntk=;
        b=dQUJY0XRi0aFt5Y/KIpoEYEXqxtC8qicXHvw9V2c4nfBkpT8ntRFwbiiwDTqyb+nym
         aCsEayNePwU/CgVxBWkAKbbmJeTyL6YMpnNJji4ChBOHuWiVpEPsAKQGGcUulKfSpYTG
         3gEjxVskv5w8EIUDjkacWh6MQWOxH+OuUJzjShH231lRC6bjUeX9wXAJvJ9ZLr4mpyPz
         CSxWHp3U2Nbzupl0wcP8to/8D1+XFedruYYdkIYChLHX/9d7yOjf0VyaFzTTMv3t69R4
         Kj+RRcnZ6zo7xtVBEVwVvswWdMgvMV3dX6jq1NQa/aY76GBgWkrRH1Y5LA2bvdemAECL
         ri5A==
X-Gm-Message-State: ANoB5pmS7p55ABEzh5v+fkOOV1ZtKayNPVQL3blGrZha110AKXH04j39
        BKXFIBlqCGps2KeV9FMuC+RcKA==
X-Google-Smtp-Source: AA0mqf6UHa2taM8UHFO2M6pHk/KOhKDjydLDTxwianehLxR0LBkkmXjWc7S9lghiT8p+wT4pPK35JQ==
X-Received: by 2002:a05:6512:3b0f:b0:4b3:b6db:8ca7 with SMTP id f15-20020a0565123b0f00b004b3b6db8ca7mr1217969lfv.590.1668090012679;
        Thu, 10 Nov 2022 06:20:12 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u28-20020a2eb81c000000b0026dc7b59d8esm2700050ljo.22.2022.11.10.06.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 06:20:12 -0800 (PST)
Message-ID: <37fe9a22-7ca0-e4e5-ebff-4eb56dbb74eb@linaro.org>
Date:   Thu, 10 Nov 2022 17:20:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sm8350: add PCIe devices
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
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
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
References: <20221110103345.729018-1-dmitry.baryshkov@linaro.org>
 <20221110103345.729018-8-dmitry.baryshkov@linaro.org>
 <Y2zYHEZDbNoGumTl@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y2zYHEZDbNoGumTl@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/11/2022 13:53, Johan Hovold wrote:
> On Thu, Nov 10, 2022 at 01:33:44PM +0300, Dmitry Baryshkov wrote:
>> Add PCIe0 and PCIe1 (and corresponding PHY) devices found on SM8350
>> platform. The PCIe0 is a 1-lane Gen3 host, PCIe1 is a 2-lane Gen3 host.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 246 ++++++++++++++++++++++++++-
>>   1 file changed, 244 insertions(+), 2 deletions(-)
> 
>> @@ -1761,6 +1957,52 @@ tlmm: pinctrl@f100000 {
>>   			gpio-ranges = <&tlmm 0 0 204>;
>>   			wakeup-parent = <&pdc>;
>>   
>> +			pcie0_default_state: pcie0-default-state {
>> +				perst-pins {
>> +					pins = "gpio94";
>> +					function = "gpio";
>> +					drive-strength = <2>;
>> +					bias-pull-down;
>> +				};
>> +
>> +				clkreq-pins {
>> +					pins = "gpio95";
>> +					function = "pcie0_clkreqn";
>> +					drive-strength = <2>;
>> +					bias-pull-up;
>> +				};
>> +
>> +				wake-pins {
>> +					pins = "gpio96";
>> +					function = "gpio";
>> +					drive-strength = <2>;
>> +					bias-pull-up;
>> +				};
>> +			};
> 
> The pinconfig should go in the board file.

Usually yes. However for the PCIe we usually put them into the main 
.dtsi. See sm8[124]50.dtsi.

-- 
With best wishes
Dmitry

