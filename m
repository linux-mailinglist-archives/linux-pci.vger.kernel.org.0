Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC0B516EBF
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 13:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377785AbiEBLV6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 07:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiEBLV5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 07:21:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2865BCB0
        for <linux-pci@vger.kernel.org>; Mon,  2 May 2022 04:18:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c15so17978111ljr.9
        for <linux-pci@vger.kernel.org>; Mon, 02 May 2022 04:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TotUOUOYG1IlyrXP9/XB6b/aq6YmW9z2gThsa334rwM=;
        b=R15p0KXa6CKtjtdQ99ASAXTnpiAMzCJL6HoDIsDp0m62PcFxz6N1FcRedsynqS/0Hr
         1OQ9IdR/Tf10/kqi8vrseJZDEKDn/LXpvKJR6uppBHwu7SaIil/SuOFANADNPsnYW4ro
         X/rTgXYNG98abuF6MHZfJR6JY6Z/GTSST8bJoptsAAZfQE9MIDpWhIWF03bOr5/czG9l
         laOl3k/hwlnG9jGKaLMU0Bw5bSUjIi0RXaC6abyicksyQ42ZCoR2ouHAbV5axLBVt6gs
         m5ICsgTPhhWYWvtnPw8SVe5iMJ+vys6enDsEyk0+H5rM6wAv1H8hqI2XCqr3alaKXc4W
         4nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TotUOUOYG1IlyrXP9/XB6b/aq6YmW9z2gThsa334rwM=;
        b=hXtQlUVeWAys9wNubwp97EQ8+0BPlz1wyTL8zgLHFVa2j8fruUCgtVjVNuHaZyci4e
         6/G7GMbe0Bqg90nlhJzm9JDF7ea2bSCm8nwTV5vg5YU06Y2XF36RsuRa75gIPTcrNAQ7
         QQlCGJMcLy7V1AOZwHbR8dizsWQk/20CAxybjxY0lXuE+WTHOQLdqM+c6ZbIo6YcTgL/
         7GkGVwKgyXzxScNuiAGxUhFcNRQykrN7yBpFVxL7u/kY9VpkVyLDTQ7zabXC5dUjLUtf
         wGu6bI69L4XjyP+6sgNso5HogcFTfdaReCYQfT1hjr46193QcCS7PEkjgrnercQ2wPnV
         UXWg==
X-Gm-Message-State: AOAM531mAxcI7eOHLGd+R+oyQyrH9OP68xR3YRqQ49eSlQ9eO/Pe0mUt
        XyCem8vmj811Sz2a9f02qSkxQyx9/Y7LvA==
X-Google-Smtp-Source: ABdhPJz7OsceSRMLM8FKgIVwURJKiA4EzOrQCM7nPmxNRRBzlns1LFyOJGywdpfMK19+tYljy7sBxA==
X-Received: by 2002:a05:651c:1214:b0:24f:72c:d102 with SMTP id i20-20020a05651c121400b0024f072cd102mr7522557lja.377.1651490307062;
        Mon, 02 May 2022 04:18:27 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t24-20020ac24c18000000b0047255d21162sm672686lfq.145.2022.05.02.04.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 04:18:26 -0700 (PDT)
Message-ID: <29819e6d-9aa1-aca9-0ff6-b81098077f28@linaro.org>
Date:   Mon, 2 May 2022 14:18:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 2/5] clk: qcom: regmap: add pipe clk implementation
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
 <20220501192149.4128158-3-dmitry.baryshkov@linaro.org>
 <20220502101053.GF5053@thinkpad>
 <c47616bf-a0c3-3ad5-c3e2-ba2ae33110d0@linaro.org>
 <20220502111004.GH5053@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220502111004.GH5053@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02/05/2022 14:10, Manivannan Sadhasivam wrote:
> On Mon, May 02, 2022 at 01:35:34PM +0300, Dmitry Baryshkov wrote:
> 
> [...]
> 
>>>> +static int pipe_is_enabled(struct clk_hw *hw)
>>>> +{
>>>> +	struct clk_regmap_pipe *pipe = to_clk_regmap_pipe(hw);
>>>> +	struct clk_regmap *clkr = to_clk_regmap(hw);
>>>> +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
>>>> +	unsigned int val;
>>>> +
>>>> +	regmap_read(clkr->regmap, pipe->reg, &val);
>>>> +	val = (val & mask) >> pipe->shift;
>>>> +
>>>> +	WARN_ON(unlikely(val != pipe->enable_val && val != pipe->disable_val));
>>>> +
>>>> +	return val == pipe->enable_val;
>>>
>>> Selecting the clk parents in the enable/disable callback seems fine to me but
>>> the way it is implemented doesn't look right.
>>>
>>> First this "pipe_clksrc" is a mux clk by design, since we can only select the
>>> parent. But you are converting it to a gate clk now.
>>>
>>> Instead of that, my proposal would be to make this clk a composite one i.e,.
>>> gate clk + mux clk. So even though the gate clk here would be a hack, we are
>>> not changing the definition of mux clk.
>>
>> This is what I had before, in revisions 1-3. Which proved to work, but is
>> problematic a bit.
>>
>> In the very end, it is not easily possible to make a difference between a
>> clock reparented to the bi_tcxo and a disabled clock. E.g. if some user
>> reparents the clock to the tcxo, then the driver will consider the clock
>> disabled, but the clock framework will think that the clock is still
>> enabled.
> 
> I don't understand this. How can you make this clock disabled? It just has 4
> parents, right?

It has 4 parents. It uses just two of them (pipe and tcxo).

And like the clk_rcg2_safe clock we'd like to say that these clocks are 
disabled by reparenting ("parking") them to the tcxo source. Yes, this 
makes a lot of code simpler. The clock framework will switch the clock 
to the "safe" state instead of disabling it during the unused clocks 
evaporation. The PHY can just disable the gcc_pcie_N_pipe_clock, which 
will end up in parking this clock to a safe state too, etc.

> 
>>
>> Thus we have to remove "safe" clock (bi_tcxo) from the list of parents. In
>> case of pipe clocks (and ufs symbol clocks) this will leave us with just a
>> single possible parent. Then having the mux part just doesn't make sense. It
>> is just a gated clock. And this simplified a lot of things.
>>
>>>
>>> So you can introduce a new ops like "clk_regmap_mux_gate_ops" and implement the
>>> parent switching logic in the enable/disable callbacks. Additional benefit of
>>> this ops is, in the future we can also support "gate + mux" clks easily.
>>
>> If the need arises, we can easily resurrect the regmap_mux_safe patchset,
>> fix the race pointed out by Johan, remove extra src-val mapping for safe
>> value and use it for such clocks. I can post it separately, if you wish. But
>> I'm not sure that it makes sense to use it for single-parent clocks.
>>
>>>
>>> Also, please don't use the "enable_val/disable_val" members. It should be
>>> something like "mux_sel_pre/mux_sel_post".
>>
>> Why? Could you please elaborate?
>>
> 
> It aligns with my question above. I don't see how this clk can be
> enabled/disabled.

I see. Let's settle on the first question then.

-- 
With best wishes
Dmitry
