Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2094B007C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 23:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiBIWlq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 17:41:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiBIWlq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 17:41:46 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E67E04FF00
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 14:41:47 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u6so7002581lfc.3
        for <linux-pci@vger.kernel.org>; Wed, 09 Feb 2022 14:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xfbJumfno58ziWvDD+Jp7tnvjCMlLu2zll9g2xMdATc=;
        b=YP+ZirJ6KlzSlxybJyHUL1BcGATx9ofl+4dPCPtEu6/M/tQCGtqMXWebwy2ktLbQMt
         n+YZyUWUkGjU2CzSzpKQlARxaLoHu4Cycrfs78HMEMXupr9lLfKQUxtxYGrJCBgGZOO1
         EUrBAjvLrVioSbWgB/JmSoRR7tfcZw0LUnmXDlkAoB9j+ubF++XnbeZ2U7eDtwGmLssY
         jXtdEVcU1EsGGBnEDq5UuGwCC+X77HUzmgBtDkX5ghyScELg/jmoA1mcJyg1hw4Df9tt
         QzAdtfsrD0Ioyx+qH+go1YMfU95aVRDq99xlAjBQIBlfYqKKT+9ilwe+t18s4si5ByHU
         QbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xfbJumfno58ziWvDD+Jp7tnvjCMlLu2zll9g2xMdATc=;
        b=rYih0rNGmLT7wZ6tJYzNZR+/bxc75FNPhixSdhA5TYA8rNYJ7PMICQHY3L6BT75+Qb
         tWW+ismn6Dz8AL1Tha/0/0wIg0YP8PEzIVcQ4RCJf7KjPNERAgYaCM4v4HYbOZ+yNqw3
         kjTeMF0fZChIr+VPvdxZrulrfS1ovT4XCbkNpPTYECHPJGjcnyLaN+/4O1rYkB0/fzvD
         GlRh6wbIHizYrmJ7BSXJaPlcFKnjda/KheZyy2vmQMfpzQRObLkVyPDxW1Ar140qXvS9
         JDE4S3SDb1x5GD9NfzD8YVSnetUhf58wViMM66zUQJnUCTtwGXa7avvHl9Ds6FOrXQXm
         cEiA==
X-Gm-Message-State: AOAM5311gNX7Z09cAcXi1EFuFeaBIDTxA3UjzU02s/b4bMf/MO4u1w71
        Q5VWqsbpDNJriaqhEHq7tcxvPg==
X-Google-Smtp-Source: ABdhPJybdtw8wKhrN+sqYekgmLsbcbynpGit8lsK3XdBoCnH6y+wXxn5BBa+xZEMoPsdr9Wv4CcXOw==
X-Received: by 2002:a05:6512:22c6:: with SMTP id g6mr3154441lfu.326.1644446505872;
        Wed, 09 Feb 2022 14:41:45 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k17sm595492lfv.81.2022.02.09.14.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 14:41:45 -0800 (PST)
Message-ID: <b7e0ad58-b837-7dcf-4386-ab7ff82ee65c@linaro.org>
Date:   Thu, 10 Feb 2022 01:41:44 +0300
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
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Prasad Malisetty <pmaliset@codeaurora.org>
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
