Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D7C516E35
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 12:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384645AbiEBKjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 06:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384540AbiEBKjG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 06:39:06 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE2A1121
        for <linux-pci@vger.kernel.org>; Mon,  2 May 2022 03:35:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q185so17858441ljb.5
        for <linux-pci@vger.kernel.org>; Mon, 02 May 2022 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JPi36Ptgl/jtMll86PTXlR5o1uXCZjkEd+ie0lzbuAE=;
        b=bsJKjJDpCcPqKit+kE3Yjc6BY2OQxj0Kb4tgD+OYgA6+IJWVXnc115ng78JEER9DYp
         VnKz6j41SSEHm7ppGUrslGfjfh0eu58D+D/Hz9XMo1Z4stQJOTiqexG+r1RjOXey5wsA
         d6rRlfqtENviL4mAz7rK4Mol9A7KSAARaJ5+RUQhBhKVzVyZuH6AoGJWtdG8blS4xxtp
         qYDI2kUZqKvMJEGgd45w3uaQ9tLSK6KMQBbvt4kEupfyMOg2IsIBgslg/UkdO2/I0EJR
         NsnCIGnDZo0TVNC1saGoa50dm4NdEmz4z0GpcK8zBSIlsPzUTJRxGu/siu8D2O+QundT
         qvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JPi36Ptgl/jtMll86PTXlR5o1uXCZjkEd+ie0lzbuAE=;
        b=sAA5rytJhavKW7XEsxwdJ4ag8P+4+SxXIXNBl8gMJRmJ8FvQtSRGZvFnsmCBuCtyNB
         1PtKNuBEJBZRBiDzlZlWKHynsDglP05nUwV8JIvIbwpX+RPTmoQqp/N7uaGsaBOd2U5j
         Fah8v4MGLacGV3vINm6gbFqTgsBuxU7LEb4tt8RZ9rSzZ1smoTq9g2ZO8Z0I16M3t4Vf
         p8On/Hw0Cv+i+5TJLgu3zHWya5FU8WUuBljj454rytLKI7up10M7EcIS3hv0MUnxHoFg
         xXZTS4ZJSGX9DzYJFTx1ndHD6HXpjyoF1XHtO5HE/tVWqRLCLK15UdhZzG/Lp+VN65X1
         wEgg==
X-Gm-Message-State: AOAM5322DHjF+CEaJHRcUk8hHtyVpRQNBQIBy+4C98O/y58u2InYihPh
        UWKU9cTjCvozdk2IzRhc+yJ1aA==
X-Google-Smtp-Source: ABdhPJwG1NDqsp3Jq/Yvec0IUonj0PRb5PNQDpASTzoJEfo+oSwH/l1/JHTJPx6VKrQXv72undkHFw==
X-Received: by 2002:a2e:9c0c:0:b0:24e:e2e0:f61e with SMTP id s12-20020a2e9c0c000000b0024ee2e0f61emr7649857lji.75.1651487736112;
        Mon, 02 May 2022 03:35:36 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c19-20020ac244b3000000b0047255d211b5sm667875lfm.228.2022.05.02.03.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 03:35:35 -0700 (PDT)
Message-ID: <c47616bf-a0c3-3ad5-c3e2-ba2ae33110d0@linaro.org>
Date:   Mon, 2 May 2022 13:35:34 +0300
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220502101053.GF5053@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02/05/2022 13:10, Manivannan Sadhasivam wrote:
> On Sun, May 01, 2022 at 10:21:46PM +0300, Dmitry Baryshkov wrote:
>> On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
>> muxes which must be parked to the "safe" source (bi_tcxo) when
>> corresponding GDSC is turned off and on again. Currently this is
>> handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
>> clock. However the same code sequence should be applied in the
>> pcie-qcom endpoint, USB3 and UFS drivers.
>>
>> Rather than copying this sequence over and over again, follow the
>> example of clk_rcg2_shared_ops and implement this parking in the
>> enable() and disable() clock operations. Suppliement the regmap-mux with
>> the new regmap-pipe implementation, which hides multiplexer behind
>> simple branch-like clock. This is possible since each of this
>> multiplexers has just two clock sources: working (pipe) and safe
>> (bi_tcxo) clock sources. If the clock is running off the external pipe
>> source, report it as enable and report it as disabled otherwise.
>>
> 
> Sorry for chiming in late and providing comments that might have been addressed
> before. But I have few questions below:
> 
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/clk/qcom/Makefile          |  1 +
>>   drivers/clk/qcom/clk-regmap-pipe.c | 62 ++++++++++++++++++++++++++++++
>>   drivers/clk/qcom/clk-regmap-pipe.h | 24 ++++++++++++
>>   3 files changed, 87 insertions(+)
>>   create mode 100644 drivers/clk/qcom/clk-regmap-pipe.c
>>   create mode 100644 drivers/clk/qcom/clk-regmap-pipe.h
>>
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index 671cf5821af1..882c8ecc2e93 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -11,6 +11,7 @@ clk-qcom-y += clk-branch.o
>>   clk-qcom-y += clk-regmap-divider.o
>>   clk-qcom-y += clk-regmap-mux.o
>>   clk-qcom-y += clk-regmap-mux-div.o
>> +clk-qcom-y += clk-regmap-pipe.o
>>   clk-qcom-$(CONFIG_KRAIT_CLOCKS) += clk-krait.o
>>   clk-qcom-y += clk-hfpll.o
>>   clk-qcom-y += reset.o
>> diff --git a/drivers/clk/qcom/clk-regmap-pipe.c b/drivers/clk/qcom/clk-regmap-pipe.c
>> new file mode 100644
>> index 000000000000..9a7c27cc644b
>> --- /dev/null
>> +++ b/drivers/clk/qcom/clk-regmap-pipe.c
>> @@ -0,0 +1,62 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022, Linaro Ltd.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/bitops.h>
>> +#include <linux/regmap.h>
>> +#include <linux/export.h>
>> +
>> +#include "clk-regmap-pipe.h"
>> +
>> +static inline struct clk_regmap_pipe *to_clk_regmap_pipe(struct clk_hw *hw)
>> +{
>> +	return container_of(to_clk_regmap(hw), struct clk_regmap_pipe, clkr);
>> +}
>> +
>> +static int pipe_is_enabled(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap_pipe *pipe = to_clk_regmap_pipe(hw);
>> +	struct clk_regmap *clkr = to_clk_regmap(hw);
>> +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
>> +	unsigned int val;
>> +
>> +	regmap_read(clkr->regmap, pipe->reg, &val);
>> +	val = (val & mask) >> pipe->shift;
>> +
>> +	WARN_ON(unlikely(val != pipe->enable_val && val != pipe->disable_val));
>> +
>> +	return val == pipe->enable_val;
> 
> Selecting the clk parents in the enable/disable callback seems fine to me but
> the way it is implemented doesn't look right.
> 
> First this "pipe_clksrc" is a mux clk by design, since we can only select the
> parent. But you are converting it to a gate clk now.
> 
> Instead of that, my proposal would be to make this clk a composite one i.e,.
> gate clk + mux clk. So even though the gate clk here would be a hack, we are
> not changing the definition of mux clk.

This is what I had before, in revisions 1-3. Which proved to work, but 
is problematic a bit.

In the very end, it is not easily possible to make a difference between 
a clock reparented to the bi_tcxo and a disabled clock. E.g. if some 
user reparents the clock to the tcxo, then the driver will consider the 
clock disabled, but the clock framework will think that the clock is 
still enabled.

Thus we have to remove "safe" clock (bi_tcxo) from the list of parents. 
In case of pipe clocks (and ufs symbol clocks) this will leave us with 
just a single possible parent. Then having the mux part just doesn't 
make sense. It is just a gated clock. And this simplified a lot of things.

> 
> So you can introduce a new ops like "clk_regmap_mux_gate_ops" and implement the
> parent switching logic in the enable/disable callbacks. Additional benefit of
> this ops is, in the future we can also support "gate + mux" clks easily.

If the need arises, we can easily resurrect the regmap_mux_safe 
patchset, fix the race pointed out by Johan, remove extra src-val 
mapping for safe value and use it for such clocks. I can post it 
separately, if you wish. But I'm not sure that it makes sense to use it 
for single-parent clocks.

> 
> Also, please don't use the "enable_val/disable_val" members. It should be
> something like "mux_sel_pre/mux_sel_post".

Why? Could you please elaborate?

> 
>> +}
>> +
>> +static int pipe_enable(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap_pipe *pipe = to_clk_regmap_pipe(hw);
>> +	struct clk_regmap *clkr = to_clk_regmap(hw);
>> +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
>> +	unsigned int val;
>> +
>> +	val = pipe->enable_val << pipe->shift;
>> +
>> +	return regmap_update_bits(clkr->regmap, pipe->reg, mask, val);
>> +}
>> +
>> +static void pipe_disable(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap_pipe *pipe = to_clk_regmap_pipe(hw);
>> +	struct clk_regmap *clkr = to_clk_regmap(hw);
>> +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
>> +	unsigned int val;
>> +
>> +	val = pipe->disable_val << pipe->shift;
>> +
>> +	regmap_update_bits(clkr->regmap, pipe->reg, mask, val);
>> +}
>> +
>> +const struct clk_ops clk_regmap_pipe_ops = {
>> +	.enable = pipe_enable,
>> +	.disable = pipe_disable,
>> +	.is_enabled = pipe_is_enabled,
>> +};
>> +EXPORT_SYMBOL_GPL(clk_regmap_pipe_ops);
>> diff --git a/drivers/clk/qcom/clk-regmap-pipe.h b/drivers/clk/qcom/clk-regmap-pipe.h
>> new file mode 100644
>> index 000000000000..cfaa792a029b
>> --- /dev/null
>> +++ b/drivers/clk/qcom/clk-regmap-pipe.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022, Linaru Ltd.
> 
> Linaro

ack

> 
>> + * Author: Dmitry Baryshkov
> 
> No email?
> 
> Thanks,
> Mani
> 
>> + */
>> +
>> +#ifndef __QCOM_CLK_REGMAP_PIPE_H__
>> +#define __QCOM_CLK_REGMAP_PIPE_H__
>> +
>> +#include <linux/clk-provider.h>
>> +#include "clk-regmap.h"
>> +
>> +struct clk_regmap_pipe {
>> +	u32			reg;
>> +	u32			shift;
>> +	u32			width;
>> +	u32			enable_val;
>> +	u32			disable_val;
>> +	struct clk_regmap	clkr;
>> +};
>> +
>> +extern const struct clk_ops clk_regmap_pipe_ops;
>> +
>> +#endif
>> -- 
>> 2.35.1
>>


-- 
With best wishes
Dmitry
