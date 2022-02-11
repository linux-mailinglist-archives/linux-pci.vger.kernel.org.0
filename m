Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB554B2E09
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 20:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353009AbiBKTwr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 14:52:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242073AbiBKTwq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 14:52:46 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58416125
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 11:52:44 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cf2so17972455edb.9
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 11:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fp+y6DOsivVL6RhrTrD/vUxmQahZjj9bC6Sr+HW1xsA=;
        b=s0/lcCFg/cGMV/PachOPe19E/4okmq6zazTrgSBlgf0EeCmMHQqdWPPppv/F2e+KAy
         u/UeO+4WDlBG1K3pkoaIyteSMdGMiUKklZS59dYDdgN/4aDLQDt9PKDQewCUtILgMG90
         PfN/MzK8+6N2CBf2tWPw7ndeo7gqZt+QWdR7sIO+rpCUorbWDOg3YCtcKb2EH59zOG1X
         TBP0FVE4SHODYzCfXyiDA/tl9cmLZGQJkUzzZnMHkwTfwSxY2GL7g42jFhaYx+PBJNnR
         YexIUMZ4omGjDXXpvE1FqZ2WIVme6oBMrZ4WUZKLJygEZQt6wVyBP/mu6K2Lre4ndIs4
         /6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fp+y6DOsivVL6RhrTrD/vUxmQahZjj9bC6Sr+HW1xsA=;
        b=d9O+ONhH32YvB1LyS6HqTKJBbpE6ds7Gfz5yeScsyCz+L5wX1xyZvDN5Ed00NVMqDX
         iI60eGVcmHQiKfNS0NWirr0rN03TBWXUhyLwS7gePhxt4rSospu/JLo7eqBFM+lHUqNV
         1l9XqdvV+sBhwMOssPZYLt1YD1tDvsvc8WMww9KUsjyJ21/6dkYUSzSEJPPnJ7AJToTZ
         2NhL50JPhsyzOGDSL6vDj8R/uHCndnxrFVoO6thYQxW0NP/kq4NqgXoe8qODIt2CI/su
         44XnC1912Vp+bwWRlOQshIqhXwOkl0hQZpdjwM66WZZGUgabVyQ44h+QcJCmMZI6B3aI
         Gu6Q==
X-Gm-Message-State: AOAM532A++jPdcfZqmkjWRtO4iIVUtVR7pZ7QukU0GiLrzHCjGJZQ7V2
        Cl5Ew+pb+60l0d+8iilSRTiAmnDxcaVUrQ==
X-Google-Smtp-Source: ABdhPJwstj2iq985ZbAIqESpOE2g87yC0N+8Cx4Jdn4ksCj9RhGuX5Uh3kjYp3vDRjBcnZ41CuQ0CA==
X-Received: by 2002:a05:651c:b12:: with SMTP id b18mr1972242ljr.44.1644609152444;
        Fri, 11 Feb 2022 11:52:32 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f6sm1060615lfe.182.2022.02.11.11.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 11:52:31 -0800 (PST)
Message-ID: <f521a273-7250-ddca-0e56-b1b27bd75117@linaro.org>
Date:   Fri, 11 Feb 2022 22:52:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 03/11] clk: qcom: gdsc: add support for clocks tied to
 the GDSC
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
 <20220204144645.3016603-4-dmitry.baryshkov@linaro.org>
 <Yf2jRAf5UKYSMYxe@builder.lan>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Yf2jRAf5UKYSMYxe@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/02/2022 01:05, Bjorn Andersson wrote:
> On Fri 04 Feb 08:46 CST 2022, Dmitry Baryshkov wrote:
> 
>> On newer Qualcomm platforms GCC_PCIE_n_PIPE_CLK_SRC should be controlled
>> together with the PCIE_n_GDSC. The clock should be fed from the TCXO
>> before switching the GDSC off and can be fed from PCIE_n_PIPE_CLK once
>> the GDSC is on.
>>
>> Since commit aa9c0df98c29 ("PCI: qcom: Switch pcie_1_pipe_clk_src after
>> PHY init in SC7280") PCIe controller driver tries to manage this on it's
>> own, resulting in the non-optimal code. Furthermore, if the any of the
>> drivers will have the same requirements, the code would have to be
>> dupliacted there.
>>
>> Move handling of such clocks to the GDSC code, providing special GDSC
>> type.
>>
> 
> As discussed on IRC, I'm inclined not to take this, because looks to me
> to be the same situation that we have with all GDSCs in SM8350 and
> onwards - that some clocks must be parked on a safe parent before the
> associated GDSC can be toggled.
> 
> Prasad, please advice on what the actual requirements are wrt the
> gcc_pipe_clk_src. When does it need to provide a valid signal and when
> does it need to be parked?

[Excuse me for the duplicate, Prasad's email was bouncing]

Prasad, any comments?

> 
> Regards,
> Bjorn
> 
>> Cc: Prasad Malisetty <pmaliset@codeaurora.org>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/clk/qcom/gdsc.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/clk/qcom/gdsc.h | 14 ++++++++++++++
>>   2 files changed, 55 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>> index 7e1dd8ccfa38..9913d1b70947 100644
>> --- a/drivers/clk/qcom/gdsc.c
>> +++ b/drivers/clk/qcom/gdsc.c
>> @@ -45,6 +45,7 @@
>>   #define TIMEOUT_US		500
>>   
>>   #define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
>> +#define domain_to_pipe_clk_gdsc(domain) container_of(domain, struct pipe_clk_gdsc, base.pd)
>>   
>>   enum gdsc_status {
>>   	GDSC_OFF,
>> @@ -549,3 +550,43 @@ int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
>> +
>> +/*
>> + * Special operations for GDSCs with attached pipe clocks.
>> + * The clock should be parked to safe source (tcxo) before turning off the GDSC
>> + * and can be switched on as soon as the GDSC is on.
>> + *
>> + * We remove respective clock sources from clocks map and handle them manually.
>> + */
>> +int gdsc_pipe_enable(struct generic_pm_domain *domain)
>> +{
>> +	struct pipe_clk_gdsc *sc = domain_to_pipe_clk_gdsc(domain);
>> +	int i, ret;
>> +
>> +	ret = gdsc_enable(domain);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i< sc->num_clocks; i++)
>> +		regmap_update_bits(sc->base.regmap, sc->clocks[i].reg,
>> +				BIT(sc->clocks[i].shift + sc->clocks[i].width) - BIT(sc->clocks[i].shift),
>> +				sc->clocks[i].on_value << sc->clocks[i].shift);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(gdsc_pipe_enable);
>> +
>> +int gdsc_pipe_disable(struct generic_pm_domain *domain)
>> +{
>> +	struct pipe_clk_gdsc *sc = domain_to_pipe_clk_gdsc(domain);
>> +	int i;
>> +
>> +	for (i = sc->num_clocks - 1; i >= 0; i--)
>> +		regmap_update_bits(sc->base.regmap, sc->clocks[i].reg,
>> +				BIT(sc->clocks[i].shift + sc->clocks[i].width) - BIT(sc->clocks[i].shift),
>> +				sc->clocks[i].off_value << sc->clocks[i].shift);
>> +
>> +	/* In case of an error do not try turning the clocks again. We can not be sure about the GDSC state. */
>> +	return gdsc_disable(domain);
>> +}
>> +EXPORT_SYMBOL_GPL(gdsc_pipe_disable);
>> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
>> index d7cc4c21a9d4..b1a2f0abe41c 100644
>> --- a/drivers/clk/qcom/gdsc.h
>> +++ b/drivers/clk/qcom/gdsc.h
>> @@ -68,11 +68,25 @@ struct gdsc_desc {
>>   	size_t num;
>>   };
>>   
>> +struct pipe_clk_gdsc {
>> +	struct gdsc base;
>> +	int num_clocks;
>> +	struct {
>> +		u32 reg;
>> +		u32 shift;
>> +		u32 width;
>> +		u32 off_value;
>> +		u32 on_value;
>> +	} clocks[];
>> +};
>> +
>>   #ifdef CONFIG_QCOM_GDSC
>>   int gdsc_register(struct gdsc_desc *desc, struct reset_controller_dev *,
>>   		  struct regmap *);
>>   void gdsc_unregister(struct gdsc_desc *desc);
>>   int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain);
>> +int gdsc_pipe_enable(struct generic_pm_domain *domain);
>> +int gdsc_pipe_disable(struct generic_pm_domain *domain);
>>   #else
>>   static inline int gdsc_register(struct gdsc_desc *desc,
>>   				struct reset_controller_dev *rcdev,
>> -- 
>> 2.34.1
>>


-- 
With best wishes
Dmitry
