Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2062FFFB
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 23:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiKRWX1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 17:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiKRWW6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 17:22:58 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD326B4061
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 14:22:14 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id x21so8441362ljg.10
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 14:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YoNPSXK+wcRdMRmvgHL8qJyp7aIYHmPBQaLIexRJUkU=;
        b=Lwtw+o1CSW5vTgwEV62MVCpfbASyzQP5oi1qPCptojRzLi2J5/4BFTpdmRXkT/kE3q
         581fBqcYj69ttvdlf5pZ3PaGL+/bQrnwVZANkzaSQyUOWvBylUl8vJ3wV6Mdh318fDz6
         vTpsvqSN14tw2ZTI7utBW7cN/ft3e0BtAhx7xUAAuYhaQJL3WeugaW1+kGYYxDa8feJU
         1VvWioswrTuuYwvF2yMwdStQHSNlCQVkSXLbLruAeuA6xZ64StoNuO08L/6PBvmG7Hcl
         5Wwho1zCjbcUcUUz9stLhyRI9RgJGfLls9LXPgGFscjJbbgLWHHFI+GU5VbFXoVNWJNw
         BztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YoNPSXK+wcRdMRmvgHL8qJyp7aIYHmPBQaLIexRJUkU=;
        b=lh0/Limmg2v+jfJq8EKw1NUbt7m1ZL1SwbZi/Ds0snXdjr8marZiprNEarGlQKFwU6
         9Zx8b4yE8amclGOI/f1OYbzZZaCIP+IcDa6QmgmHWOJRN2213meB57yGaO1MyIDxHvEx
         V00+zvTYHYbnYGdJDLtVDg59pJOoglAnOqKrv5spFKyUPL4k4K55Ph6BE8UHDIwqKc6Z
         +GkFdQU7T0Fjf7EWYFnKaJbAyV29hP1o0rEZnitcLDWhv/uTuVc1YCZh2oxal0sFKeZn
         FnFFvgTpvDR49qUaxfGg0GeFcK4V5h9T+22kEkxv6uhlQpdUkYj0l5/aWMNMySr7nkiw
         0r3A==
X-Gm-Message-State: ANoB5plh47i+4HIumkTStCyFwab/WtQmBcU0qryqMP9Rt6y+Ik6CJnq3
        ucT5lXs2WJx2jZv7FDk9kvqt2w==
X-Google-Smtp-Source: AA0mqf4xKLzMyHjJcZVQhYHe2UfYLPh7BuXdM1ZHd3LjrlsM5RJwX4Wn7PSA6vQqB+mkqWcZ8PwJ5g==
X-Received: by 2002:a2e:b5d3:0:b0:277:c57:e914 with SMTP id g19-20020a2eb5d3000000b002770c57e914mr2924887ljn.53.1668810133015;
        Fri, 18 Nov 2022 14:22:13 -0800 (PST)
Received: from [192.168.1.129] ([194.204.33.9])
        by smtp.gmail.com with ESMTPSA id i5-20020a0565123e0500b004978e51b691sm828413lfv.266.2022.11.18.14.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 14:22:12 -0800 (PST)
Message-ID: <62058431-b2bf-4d1b-df98-2b84adf87a83@linaro.org>
Date:   Sat, 19 Nov 2022 00:22:10 +0200
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
 <37fe9a22-7ca0-e4e5-ebff-4eb56dbb74eb@linaro.org>
 <Y3TzG4HGsFSU3sky@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y3TzG4HGsFSU3sky@hovoldconsulting.com>
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

On 16/11/2022 16:26, Johan Hovold wrote:
> On Thu, Nov 10, 2022 at 05:20:11PM +0300, Dmitry Baryshkov wrote:
>> On 10/11/2022 13:53, Johan Hovold wrote:
>>> On Thu, Nov 10, 2022 at 01:33:44PM +0300, Dmitry Baryshkov wrote:
>>>> Add PCIe0 and PCIe1 (and corresponding PHY) devices found on SM8350
>>>> platform. The PCIe0 is a 1-lane Gen3 host, PCIe1 is a 2-lane Gen3 host.
>>>>
>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sm8350.dtsi | 246 ++++++++++++++++++++++++++-
>>>>    1 file changed, 244 insertions(+), 2 deletions(-)
>>>
>>>> @@ -1761,6 +1957,52 @@ tlmm: pinctrl@f100000 {
>>>>    			gpio-ranges = <&tlmm 0 0 204>;
>>>>    			wakeup-parent = <&pdc>;
>>>>    
>>>> +			pcie0_default_state: pcie0-default-state {
>>>> +				perst-pins {
>>>> +					pins = "gpio94";
>>>> +					function = "gpio";
>>>> +					drive-strength = <2>;
>>>> +					bias-pull-down;
>>>> +				};
>>>> +
>>>> +				clkreq-pins {
>>>> +					pins = "gpio95";
>>>> +					function = "pcie0_clkreqn";
>>>> +					drive-strength = <2>;
>>>> +					bias-pull-up;
>>>> +				};
>>>> +
>>>> +				wake-pins {
>>>> +					pins = "gpio96";
>>>> +					function = "gpio";
>>>> +					drive-strength = <2>;
>>>> +					bias-pull-up;
>>>> +				};
>>>> +			};
>>>
>>> The pinconfig should go in the board file.
>>
>> Usually yes. However for the PCIe we usually put them into the main
>> .dtsi. See sm8[124]50.dtsi.
> 
> Yeah, I noticed that too and had this discussion with Bjorn for
> sc8280xp some months ago. Even if you may save a few lines by providing
> defaults in a dtsi, the pin configuration is board specific and belongs
> in the dts.

I see that you've ended up with no pin configuration at all in 
sc8280xp.dtsi. I must admit, this is an interesting approach. However I 
fear that this might increase c&p amount. Let's see how it goes in the 
long term.

> 
> Also note that 'perst' and 'wake' above could in principle be connected
> to other GPIOs on different boards.

Yes. Do we see that in wild? No.

-- 
With best wishes
Dmitry

