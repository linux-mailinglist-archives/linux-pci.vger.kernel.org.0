Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56A34C843D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 07:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiCAGmq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 01:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiCAGmq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 01:42:46 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B685B3D3;
        Mon, 28 Feb 2022 22:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646116925; x=1677652925;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+NdqiysR3P7r86QCWKa44zgmY0F6oK3UcxdyTMbyOhM=;
  b=jD85c6IbEXbfpg5T1oNtVIMb1Bvg9feu2cMq7ueZ7iZvWhGTAtoy9Tzh
   v4Vx1IIIO+mmXKf/cnOLV8J+AsDXRyoxWngU3/2QyhZBRxodBZXEpM3ej
   cNDgyQHjj8jDOgVdDY6baZkOXIu7sULq7GTPGqH6EPkqSNZbrejiCDHcu
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Feb 2022 22:42:04 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:42:04 -0800
Received: from [10.216.49.101] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 28 Feb
 2022 22:41:59 -0800
Message-ID: <3bc0461d-3a2e-f994-e712-dfc8be04c9b4@quicinc.com>
Date:   Tue, 1 Mar 2022 12:12:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 03/11] clk: qcom: gdsc: add support for clocks tied to
 the GDSC
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
 <20220204144645.3016603-4-dmitry.baryshkov@linaro.org>
 <Yf2jRAf5UKYSMYxe@builder.lan>
 <f521a273-7250-ddca-0e56-b1b27bd75117@linaro.org>
From:   Prasad Malisetty <quic_pmaliset@quicinc.com>
In-Reply-To: <f521a273-7250-ddca-0e56-b1b27bd75117@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

++ Taniya

Hi Dmitry,

Greetings !!!

I discussed with internal team. setting gcc_pcie_n_pipe_clk src in pcie 
driver doesn't have any relation with gdsc.

But we are making sure that gcc_pcie_n_pipe_clk src is bi_tcxo before 
enabling the clocks and switching to pipe_clk src after PHY is enalbe.

During suspend switching back to bi_tcxo as we enabling the clock as 
part of resume.

  Hi Taniya,

Please provide your inputs.

Thanks

-Prasad
On 2/12/2022 1:22 AM, Dmitry Baryshkov wrote:
> On 05/02/2022 01:05, Bjorn Andersson wrote:
>> On Fri 04 Feb 08:46 CST 2022, Dmitry Baryshkov wrote:
>>
>>> On newer Qualcomm platforms GCC_PCIE_n_PIPE_CLK_SRC should be 
>>> controlled
>>> together with the PCIE_n_GDSC. The clock should be fed from the TCXO
>>> before switching the GDSC off and can be fed from PCIE_n_PIPE_CLK once
>>> the GDSC is on.
>>>
>>> Since commit aa9c0df98c29 ("PCI: qcom: Switch pcie_1_pipe_clk_src after
>>> PHY init in SC7280") PCIe controller driver tries to manage this on 
>>> it's
>>> own, resulting in the non-optimal code. Furthermore, if the any of the
>>> drivers will have the same requirements, the code would have to be
>>> dupliacted there.
>>>
>>> Move handling of such clocks to the GDSC code, providing special GDSC
>>> type.
>>>
>>
>> As discussed on IRC, I'm inclined not to take this, because looks to me
>> to be the same situation that we have with all GDSCs in SM8350 and
>> onwards - that some clocks must be parked on a safe parent before the
>> associated GDSC can be toggled.
>>
>> Prasad, please advice on what the actual requirements are wrt the
>> gcc_pipe_clk_src. When does it need to provide a valid signal and when
>> does it need to be parked?
>
> [Excuse me for the duplicate, Prasad's email was bouncing]
>
> Prasad, any comments?
>
>>
>> Regards,
>> Bjorn
>>
>>> Cc: Prasad Malisetty <pmaliset@codeaurora.org>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>   drivers/clk/qcom/gdsc.c | 41 
>>> +++++++++++++++++++++++++++++++++++++++++
>>>   drivers/clk/qcom/gdsc.h | 14 ++++++++++++++
>>>   2 files changed, 55 insertions(+)
>>>
>>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>>> index 7e1dd8ccfa38..9913d1b70947 100644
>>> --- a/drivers/clk/qcom/gdsc.c
>>> +++ b/drivers/clk/qcom/gdsc.c
>>> @@ -45,6 +45,7 @@
>>>   #define TIMEOUT_US        500
>>>     #define domain_to_gdsc(domain) container_of(domain, struct gdsc, 
>>> pd)
>>> +#define domain_to_pipe_clk_gdsc(domain) container_of(domain, struct 
>>> pipe_clk_gdsc, base.pd)
>>>     enum gdsc_status {
>>>       GDSC_OFF,
>>> @@ -549,3 +550,43 @@ int gdsc_gx_do_nothing_enable(struct 
>>> generic_pm_domain *domain)
>>>       return 0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
>>> +
>>> +/*
>>> + * Special operations for GDSCs with attached pipe clocks.
>>> + * The clock should be parked to safe source (tcxo) before turning 
>>> off the GDSC
>>> + * and can be switched on as soon as the GDSC is on.
>>> + *
>>> + * We remove respective clock sources from clocks map and handle 
>>> them manually.
>>> + */
>>> +int gdsc_pipe_enable(struct generic_pm_domain *domain)
>>> +{
>>> +    struct pipe_clk_gdsc *sc = domain_to_pipe_clk_gdsc(domain);
>>> +    int i, ret;
>>> +
>>> +    ret = gdsc_enable(domain);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    for (i = 0; i< sc->num_clocks; i++)
>>> +        regmap_update_bits(sc->base.regmap, sc->clocks[i].reg,
>>> +                BIT(sc->clocks[i].shift + sc->clocks[i].width) - 
>>> BIT(sc->clocks[i].shift),
>>> +                sc->clocks[i].on_value << sc->clocks[i].shift);
>>> +
>>> +    return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(gdsc_pipe_enable);
>>> +
>>> +int gdsc_pipe_disable(struct generic_pm_domain *domain)
>>> +{
>>> +    struct pipe_clk_gdsc *sc = domain_to_pipe_clk_gdsc(domain);
>>> +    int i;
>>> +
>>> +    for (i = sc->num_clocks - 1; i >= 0; i--)
>>> +        regmap_update_bits(sc->base.regmap, sc->clocks[i].reg,
>>> +                BIT(sc->clocks[i].shift + sc->clocks[i].width) - 
>>> BIT(sc->clocks[i].shift),
>>> +                sc->clocks[i].off_value << sc->clocks[i].shift);
>>> +
>>> +    /* In case of an error do not try turning the clocks again. We 
>>> can not be sure about the GDSC state. */
>>> +    return gdsc_disable(domain);
>>> +}
>>> +EXPORT_SYMBOL_GPL(gdsc_pipe_disable);
>>> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
>>> index d7cc4c21a9d4..b1a2f0abe41c 100644
>>> --- a/drivers/clk/qcom/gdsc.h
>>> +++ b/drivers/clk/qcom/gdsc.h
>>> @@ -68,11 +68,25 @@ struct gdsc_desc {
>>>       size_t num;
>>>   };
>>>   +struct pipe_clk_gdsc {
>>> +    struct gdsc base;
>>> +    int num_clocks;
>>> +    struct {
>>> +        u32 reg;
>>> +        u32 shift;
>>> +        u32 width;
>>> +        u32 off_value;
>>> +        u32 on_value;
>>> +    } clocks[];
>>> +};
>>> +
>>>   #ifdef CONFIG_QCOM_GDSC
>>>   int gdsc_register(struct gdsc_desc *desc, struct 
>>> reset_controller_dev *,
>>>             struct regmap *);
>>>   void gdsc_unregister(struct gdsc_desc *desc);
>>>   int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain);
>>> +int gdsc_pipe_enable(struct generic_pm_domain *domain);
>>> +int gdsc_pipe_disable(struct generic_pm_domain *domain);
>>>   #else
>>>   static inline int gdsc_register(struct gdsc_desc *desc,
>>>                   struct reset_controller_dev *rcdev,
>>> -- 
>>> 2.34.1
>>>
>
>
