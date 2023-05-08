Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378486FADF5
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 13:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbjEHLkI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 07:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbjEHLjx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 07:39:53 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E5A411A3
        for <linux-pci@vger.kernel.org>; Mon,  8 May 2023 04:39:43 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ac770a99e2so48517021fa.3
        for <linux-pci@vger.kernel.org>; Mon, 08 May 2023 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683545982; x=1686137982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MexXMEnvHcUnDYaMqmVY/MSHM/LherZWjP+20kmXVqY=;
        b=WCaDKEpWxQvYqhKslJuI6E4qcU2uFvPbdI0djxGp1xxik6KdDtp3q/nCsmctEdIW4j
         vY4QK6uYYiF5F1KhSwXAJklU7araihN5GvHeR+hKFACwW351mpY3IPEGlIXEvc1aqYml
         Xf/dahyqCmciWP+mgnmI92CcOLnQ80BN/gAMzqMti9qX+qswfnOAaQ20DZ0tZ2xWjSbZ
         iQM/QCHgaAz3oCANYf2DdpwZmGten6ADoW0ZeIRICeOvwv1042ybx8TIZAwjM8xQBcFx
         PSkLN66PUh8Z6Xp3v/loqrmTIdSvwxnaMgCHMaoJtiDOkT1YLsj8s8Kg3C9tCt9sy31a
         0ZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545982; x=1686137982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MexXMEnvHcUnDYaMqmVY/MSHM/LherZWjP+20kmXVqY=;
        b=Hp9B8IIZnZeGLxjP0AjUhls44EoxGpfe2IeOT9xTIuPA+5hUfkOL9WHz8htQJvd1sG
         BdRZDlE4Cx6ymG25zzpi+t+CiateehVCicWmfx0Pc2CCzDm5IYfNKMI4z1QdzMx6BkpA
         vun7pyZ+MOD5BmhV2MUi9z55z83ibEqGFARdB9xRCQEzevOdn9+/9kQdbXHTIrw5Fb4M
         ivpJ8pW+N6gNSrjDM9ME2TYkljy5Y420fkCLNTBvQZbIYsBIwjMmBQTN1hDsSwSUEJjr
         RNbVhpku4gHT1VKYabG/UtLrWSd6yd3wWTeiaPNFdQUcg9XBI7pnqnf2KSAd3zdPz33d
         3EFQ==
X-Gm-Message-State: AC+VfDylLdEbRN+V5noz6GDIe5P0Ok/UXSLZPLbmudLqAw0Da9/fdsI7
        Ny+8tr7ppo9eqmCQWz/50RmUTg==
X-Google-Smtp-Source: ACHHUZ66251TTq/ybOlW2YVgnvnqHsTExmFa9F/UDFJGUqL7omt0e4DgRvnmXKm0af1SqwTOmRcpOA==
X-Received: by 2002:a2e:900d:0:b0:2a8:c7f8:58ef with SMTP id h13-20020a2e900d000000b002a8c7f858efmr2638998ljg.22.1683545981956;
        Mon, 08 May 2023 04:39:41 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id o13-20020a2e9b4d000000b002ad92dff470sm377803ljj.134.2023.05.08.04.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 04:39:41 -0700 (PDT)
Message-ID: <fdf697c1-16a3-6b8c-90fa-51ef7137d546@linaro.org>
Date:   Mon, 8 May 2023 14:39:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 5/6] arm64: dts: qcom: ipq9574: Enable PCIe PHYs and
 controllers
Content-Language: en-GB
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, mani@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
References: <20230421124938.21974-1-quic_devipriy@quicinc.com>
 <20230421124938.21974-6-quic_devipriy@quicinc.com>
 <CAA8EJpqx1jv_xEnS-2rOOGCtEB=1vo477H7XLGGvH=o7NHJD7w@mail.gmail.com>
 <6c962760-d81c-af52-bce2-49090f66f4ee@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <6c962760-d81c-af52-bce2-49090f66f4ee@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/05/2023 13:55, Devi Priya wrote:
> 
> 
> On 4/22/2023 5:43 AM, Dmitry Baryshkov wrote:
>> On Fri, 21 Apr 2023 at 15:51, Devi Priya <quic_devipriy@quicinc.com> 
>> wrote:
>>>
>>> Enable the PCIe controller and PHY nodes corresponding to
>>> RDP 433.
>>>
>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>> ---
>>>   Changes in V3:
>>>          - No change
>>>
>>>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 62 +++++++++++++++++++++
>>>   1 file changed, 62 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts 
>>> b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>> index 7be578017bf7..3ae38cf327ea 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>> @@ -8,6 +8,7 @@
>>>
>>>   /dts-v1/;
>>>
>>> +#include <dt-bindings/gpio/gpio.h>
>>>   #include "ipq9574.dtsi"
>>>
>>>   / {
>>> @@ -43,6 +44,42 @@
>>>          };
>>>   };
>>>
>>> +&pcie1_phy {
>>> +       status = "okay";
>>> +};
>>> +
>>> +&pcie1 {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&pcie_1_pin>;
>>> +
>>> +       perst-gpios = <&tlmm 26 GPIO_ACTIVE_LOW>;
>>
>> Usually qcom PCIe hosts also define wake-gpios.
> In IPQ9574, we do not have hot plug support and host always starts the
> enumeration for the device. Hence no wake pin is required.

None of the qcom PCIe hosts support hotplug, if I remember correctly. 
This is not a reason not to describe the hardware.

>>
>>> +       status = "okay";
>>> +};
>>> +
>>> +&pcie2_phy {
>>> +       status = "okay";
>>> +};
>>> +
>>> +&pcie2 {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&pcie_2_pin>;
>>> +
>>> +       perst-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
>>> +       status = "okay";
>>> +};
>>> +
>>> +&pcie3_phy {
>>> +       status = "okay";
>>> +};
>>> +
>>> +&pcie3 {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&pcie_3_pin>;
>>> +
>>> +       perst-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
>>> +       status = "okay";
>>> +};
>>> +
>>>   &sdhc_1 {
>>>          pinctrl-0 = <&sdc_default_state>;
>>>          pinctrl-names = "default";
>>> @@ -60,6 +97,31 @@
>>>   };
>>>
>>>   &tlmm {
>>> +
>>> +       pcie_1_pin: pcie-1-state {
>>> +               pins = "gpio26";
>>> +               function = "gpio";
>>> +               drive-strength = <8>;
>>> +               bias-pull-down;
>>> +               output-low;
>>
>> No clkreq and no wake gpios?
> We do not use any PCIe low power states and link is always in L0.

Again. We = software. Please describe the hardware here.

> 
> Thanks,
> Devi Priya
>>
>>> +       };
>>> +
>>> +       pcie_2_pin: pcie-2-state {
>>> +               pins = "gpio29";
>>> +               function = "gpio";
>>> +               drive-strength = <8>;
>>> +               bias-pull-down;
>>> +               output-low;
>>> +       };
>>> +
>>> +       pcie_3_pin: pcie-3-state {
>>> +               pins = "gpio32";
>>> +               function = "gpio";
>>> +               drive-strength = <8>;
>>> +               bias-pull-up;
>>> +               output-low;
>>> +       };
>>> +
>>>          sdc_default_state: sdc-default-state {
>>>                  clk-pins {
>>>                          pins = "gpio5";
>>> -- 
>>> 2.17.1
>>>
>>
>>

-- 
With best wishes
Dmitry

