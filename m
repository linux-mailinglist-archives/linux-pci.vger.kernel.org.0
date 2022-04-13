Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE285001D2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 00:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiDMWYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 18:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbiDMWYO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 18:24:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A761126117
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 15:21:32 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bq30so6016776lfb.3
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J2ZiiX+Se2iGFk2CE7VRsbdwjF9gd6FgaTEan0NnU4Q=;
        b=x533paaDKxbXhn83ziLLT8WALXpFGBSOjWFu4nOiUYTRngCyFVvQ+TZ5Ou2KuDy3tJ
         gIhptZH0TQjLYtwzA/yyU6luQvLmX95oEZIeBRZYaQyceG1g3veO8W+OxplvD9KgKDTh
         z0z63EbF0fFYS4wSVXkHaCs+bKAoCBgf0ZhPyMCn1KCc0zoOh0iGldcXQEuAeJBLNuCl
         7j8XfHazfigSub7aXc70u13ECB+7lmSx01dKNDxGBh7gQWh9NdQsa0lIimwPuds1nNsN
         la9e0ieu3G2IPB+Rk2z7YlidA+bdWY8qEB++CUW80uVjx14Ds2l+LaoewIvzpR+AWmQT
         Z8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J2ZiiX+Se2iGFk2CE7VRsbdwjF9gd6FgaTEan0NnU4Q=;
        b=MyEIJjWugGtLGFVwYymRpWqF5POz0gPLmXAqVIyO4hZgdAwliV03kAaUFsEMvG3AEQ
         pH89aX2bSoL9hgzLXttsdM5l+4y3p51niOQUv5hHUBJQXfUNChkMFcwprpg8dRkuxkI/
         mEao6ETNNhmqtMusMYh8bx+TKl0GsNaJ6OfU+ht7MTEgT32vt7oBnH+z0OliHFsGJT+X
         t7sGxN76ybi5icLqE6wiWQQIazpOTfsfKd1TIJacotVQmU7xFhGVp2fDXZY/+xKAYbLv
         LUDYI0UQh3YYZvl6eUN2Fl2LFc4Gb3rDPvnl8NxZS9c6pHr1GKxr1QgSonTpvmnm5bIQ
         2Yyg==
X-Gm-Message-State: AOAM530AITYeQex+571SeGxW0eT+SR0lO7r7etkbVKmHMSsCVJqZ86KF
        f16eGq8xgYag75mLtCB4XzRvNw==
X-Google-Smtp-Source: ABdhPJzsJ2YZebEVr0v9IZVaxZ40eWC7SJ3gico4wisdoh9nIheDBB2RhRWSFELCE8RXxP9lqZzxvA==
X-Received: by 2002:ac2:4bc1:0:b0:46b:b9f3:ce9 with SMTP id o1-20020ac24bc1000000b0046bb9f30ce9mr6641677lfq.159.1649888490904;
        Wed, 13 Apr 2022 15:21:30 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u2-20020a197902000000b00448a4a7cfc3sm24573lfc.136.2022.04.13.15.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 15:21:30 -0700 (PDT)
Message-ID: <82c6813c-fcff-5097-56e0-0cb7aac2eac2@linaro.org>
Date:   Thu, 14 Apr 2022 01:21:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/5] clk: qcom: regmap-mux: add pipe clk implementation
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20220412193839.2545814-1-dmitry.baryshkov@linaro.org>
 <20220412193839.2545814-2-dmitry.baryshkov@linaro.org>
 <YlaUtCuMZZL4bM2U@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YlaUtCuMZZL4bM2U@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/04/2022 12:15, Johan Hovold wrote:
> On Tue, Apr 12, 2022 at 10:38:35PM +0300, Dmitry Baryshkov wrote:
>> On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
>> muxes which must be parked to the "safe" source (bi_tcxo) when
>> corresponding GDSC is turned off and on again. Currently this is
>> handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
>> clock. However the same code sequence should be applied in the
>> pcie-qcom endpoint, USB3 and UFS drivers.
> 
> I'm starting to think this really belongs in the PHY driver which is the
> provider of the pipe clock. Moving it there would also allow the code to
> be shared between PCIe, USB, and UFS.
> 
> The PHY driver enables the pipe clock by starting the PHY and before
> doing so there's no point in updating the mux. Similarly, the PHY driver
> can restore the "safe" source after disabling the pipe clock.
> 
> That way there's no magic happening behind scenes, the clock framework
> always reports the actual state of the tree, and the reason for all of
> this can be documented in the QMP PHY driver once and for all.
> 
> The only change to the bindings compared to what this series proposes is
> that the PHY driver also needs a reference to bi_tcxo.
> 
> Also note that updating the mux separately from starting the PHY as this
> series allows for, doesn't really make the pipe clock any safer to use.
> 
> Either way, there are also some problems with this safe-mux
> implementation that I point out below.
> 
>> Rather than copying this sequence over and over again, follow the
>> example of clk_rcg2_shared_ops and implement this parking in the
>> enable() and disable() clock operations. As we are changing the parent
>> behind the back of the clock framework, also implement custom
>> set_parent() and get_parent() operations behaving accroding to the clock
>> framework expectations (cache the new parent if the clock is in disabled
>> state, return cached parent).
>>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/clk/qcom/clk-regmap-mux.c | 78 +++++++++++++++++++++++++++++++
>>   drivers/clk/qcom/clk-regmap-mux.h |  3 ++
>>   2 files changed, 81 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-regmap-mux.c b/drivers/clk/qcom/clk-regmap-mux.c
>> index 45d9cca28064..c39ee783ee83 100644
>> --- a/drivers/clk/qcom/clk-regmap-mux.c
>> +++ b/drivers/clk/qcom/clk-regmap-mux.c
>> @@ -49,9 +49,87 @@ static int mux_set_parent(struct clk_hw *hw, u8 index)
>>   	return regmap_update_bits(clkr->regmap, mux->reg, mask, val);
>>   }
>>   
>> +static u8 mux_safe_get_parent(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
>> +	unsigned int val;
>> +
>> +	if (clk_hw_is_enabled(hw))
>> +		return mux_get_parent(hw);
>> +
>> +	val = mux->stored_parent_cfg;
>> +
>> +	if (mux->parent_map)
>> +		return qcom_find_cfg_index(hw, mux->parent_map, val);
>> +
>> +	return val;
>> +}
>> +
>> +static int mux_safe_set_parent(struct clk_hw *hw, u8 index)
>> +{
>> +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
>> +
>> +	if (clk_hw_is_enabled(hw))
>> +		return mux_set_parent(hw, index);
>> +
>> +	if (mux->parent_map)
>> +		index = mux->parent_map[index].cfg;
>> +
>> +	mux->stored_parent_cfg = index;
>> +
>> +	return 0;
>> +}
>> +
>> +static void mux_safe_disable(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
>> +	struct clk_regmap *clkr = to_clk_regmap(hw);
>> +	unsigned int mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
>> +	unsigned int val;
>> +
>> +	regmap_read(clkr->regmap, mux->reg, &val);
>> +
>> +	mux->stored_parent_cfg = (val & mask) >> mux->shift;
>> +
>> +	val = mux->safe_src_parent;
>> +	if (mux->parent_map) {
>> +		int index = qcom_find_src_index(hw, mux->parent_map, val);
>> +
>> +		if (WARN_ON(index < 0))
>> +			return;
>> +
>> +		val = mux->parent_map[index].cfg;
>> +	}
>> +	val <<= mux->shift;
>> +
>> +	regmap_update_bits(clkr->regmap, mux->reg, mask, val);
>> +}
>> +
>> +static int mux_safe_enable(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
>> +	struct clk_regmap *clkr = to_clk_regmap(hw);
>> +	unsigned int mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
>> +	unsigned int val;
>> +
>> +	val = mux->stored_parent_cfg;
>> +	val <<= mux->shift;
>> +
>> +	return regmap_update_bits(clkr->regmap, mux->reg, mask, val);
>> +}
> 
> The caching of the parent is broken since set_parent() is typically not
> called before enabling the clock.
> 
> This means that the above code will set the mux to its zero-initialised
> value, which currently only works by chance as the pipe clock config
> value happens to be zero.
> 
> For this to work generally, you'd also need to define also the
> (default/initial) non-safe parent for each mux. Handling handover from
> the bootloader might also be tricky.

It's not tricky at all. We can set stored_parent_cfg from gcc probe from 
function. Or set statically from the config. I'll probably do the latter.

> Furthermore, the current implementation appears to ignore locking and
> doesn't handle the case where set_parent() races with enable(). The
> former is protected by the prepare mutex and the latter by the enable
> spinlock and a driver that needs to serialise the two needs to handle
> that itself.

Since I'm trying to remove pipe_clk usage from pcie driver itself, there 
is just one user left - qmp phy. And while you are correct that there is 
a race, I think we can neglect that for now. Or shift enable/disable ops 
to prepare/unprepare, thus using the same mutex everywhere.


> 
>> +
>>   const struct clk_ops clk_regmap_mux_closest_ops = {
>>   	.get_parent = mux_get_parent,
>>   	.set_parent = mux_set_parent,
>>   	.determine_rate = __clk_mux_determine_rate_closest,
>>   };
>>   EXPORT_SYMBOL_GPL(clk_regmap_mux_closest_ops);
>> +
>> +const struct clk_ops clk_regmap_mux_safe_ops = {
>> +	.enable = mux_safe_enable,
>> +	.disable = mux_safe_disable,
>> +	.get_parent = mux_safe_get_parent,
>> +	.set_parent = mux_safe_set_parent,
>> +	.determine_rate = __clk_mux_determine_rate_closest,
>> +};
>> +EXPORT_SYMBOL_GPL(clk_regmap_mux_safe_ops);
>> diff --git a/drivers/clk/qcom/clk-regmap-mux.h b/drivers/clk/qcom/clk-regmap-mux.h
>> index db6f4cdd9586..f86c674ce139 100644
>> --- a/drivers/clk/qcom/clk-regmap-mux.h
>> +++ b/drivers/clk/qcom/clk-regmap-mux.h
>> @@ -14,10 +14,13 @@ struct clk_regmap_mux {
>>   	u32			reg;
>>   	u32			shift;
>>   	u32			width;
>> +	u8			safe_src_parent;
>> +	u8			stored_parent_cfg;
>>   	const struct parent_map	*parent_map;
>>   	struct clk_regmap	clkr;
>>   };
>>   
>>   extern const struct clk_ops clk_regmap_mux_closest_ops;
>> +extern const struct clk_ops clk_regmap_mux_safe_ops;
>>   
>>   #endif
> 
> Johan


-- 
With best wishes
Dmitry
