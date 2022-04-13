Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD2F4FFD44
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbiDMSA7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 14:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbiDMSAM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 14:00:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8F36D95A
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 10:57:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y32so4921973lfa.6
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DgNBNeaxdT3o36Zsbh9wOad1UIMZYrzaXuzC5eKUUtI=;
        b=gTLrthLQ/yvaEJnz2bm+XqNrxBh8VDG8rWa1b4AHnttyULJDgCDSlbfdtyMzk/b9vq
         XyPlOMAMgteD31EA4QZNjwZT4mOFGgoQ0DbZ+kLG94Hbj4Zrv5EMaAEp8kMMceC6mbBT
         7KSoelCFk46J7bNqPL/hZlgZqNl4hyPC6KNnZ8Pdnsk0RnQLMlVmWPJTdYUsPPggrLwp
         oWjxEUdf0CIQXSDJOulimFE0IGY6yCmerwGDuRdyAQHJLZRO3JEh0a7NTnGjPmQVmZa1
         PFMEzCthCYpHnL3FfWsxz567FRNr5EkwGcxyf9YC6AnptgnllJydn9ozbgCl05YP5lVA
         Fisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DgNBNeaxdT3o36Zsbh9wOad1UIMZYrzaXuzC5eKUUtI=;
        b=gvV++UABOtrAS5LoNjY9dp03WbWN+38xGly9a7BwNnlFbbps/t2qtm6ZL11EP8za5e
         HF95of/5TMhuK3kPVFngapOSElx3/xQXQ88nS8zBQTwHsZoXoCzYD1rOAL38XhQJShv2
         EDucm9lb5DTkTmhi8E3iWWf93SmswWBFePtI1E6/Z2eBnvV8MaBWs8IrEZb2CTwnT+WA
         MF7Zxk0dGiSvokCNKdspo4eftFgwx0fPLoz7brMFMbP6fEgoJM2FZ21lwtaexwfOIswp
         5RNSY7bR3XJE6PkfdrssG5YRB+cRGsj9rebHksui1L6+8WBeyV6Z0V0JdhUsj+ROhpPA
         gIAg==
X-Gm-Message-State: AOAM531siedhFQ3atFacz8cAoOfAbDNM3CRCrELRqkDzeg4Hk/Om4o6U
        ZlkF++7kQcETfr/6JzMqZcMoiA==
X-Google-Smtp-Source: ABdhPJx5gki33X9a+3cyqusr83PTfh+COSat4zzRTG6jPDRUE782f0rHYDxJpSWxyjXkGJGeYhbpsQ==
X-Received: by 2002:a05:6512:6d6:b0:46b:a67b:29ed with SMTP id u22-20020a05651206d600b0046ba67b29edmr11057787lff.101.1649872668524;
        Wed, 13 Apr 2022 10:57:48 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o23-20020ac24357000000b0044adb34b68csm4163740lfl.32.2022.04.13.10.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 10:57:48 -0700 (PDT)
Message-ID: <bbf1386f-0902-75ff-bb61-f4ebbc82f174@linaro.org>
Date:   Wed, 13 Apr 2022 20:57:47 +0300
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


I thought about this at some point. However it would still mean that the 
driver does the dance manually: disable pipe_clock, switch parent, 
sleep, switch the parent back, enable pipe clock. Switching parents is 
tied to disabling pipe_clock, so enforcing this link seems like a better 
option to me.

No to mention that it would complicate already overcomplicated QMP driver.

> That way there's no magic happening behind scenes, the clock framework
> always reports the actual state of the tree, and the reason for all of
> this can be documented in the QMP PHY driver once and for all.

We already have such 'magic' for the RCG2 (clk_rcg2_shared_ops), with 
the very practical reason. If the clock is running from the tcxo, it is 
as good as disabled from the practical purpose.

> The only change to the bindings compared to what this series proposes is
> that the PHY driver also needs a reference to bi_tcxo.

And this looks as bad, as providing bi_tcxo to the PCI device. From the 
schematics/silicon point of view neither of them actually uses these 
parents. Neither of them uses the pipe_clock_src. What do they need is 
just the pipe_clock. The rest should be in the programming API.

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
> 
> Furthermore, the current implementation appears to ignore locking and
> doesn't handle the case where set_parent() races with enable(). The
> former is protected by the prepare mutex and the latter by the enable
> spinlock and a driver that needs to serialise the two needs to handle
> that itself.
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
