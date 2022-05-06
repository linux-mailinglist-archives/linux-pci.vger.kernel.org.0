Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CDF51D807
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 14:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392076AbiEFMoY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 08:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392100AbiEFMoF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 08:44:05 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB4A10B6
        for <linux-pci@vger.kernel.org>; Fri,  6 May 2022 05:40:21 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m23so9135625ljc.0
        for <linux-pci@vger.kernel.org>; Fri, 06 May 2022 05:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zS/e7RhGXKmqiHAbEFyOUVLEzjgj8L6c5oYAEfYX0K0=;
        b=aPgP6QTOywI+TMZ+tCPOIafKNL0MGQXdN5L0NkVA3VYtssEWKi0DO29bOC/HfX1YFt
         iVLF2s3u/vXW62JRwYoNoIC1yXAQkhx3wF4hLUlVYg/zbJh565uzfUVAV3KatSfc5pEP
         j83MhTgcpQ2oJjzFiJ8TumZimc9XuobdODoPv7RB3w9AxXpHYCwys+BKXhNgJwsKg13c
         4a/z0Z/R0GU0nWf6ykcwoyvuiUZdNNFgEGmviGFHFgHB1s1wNlq9CfxcVqkaCLsQTLlk
         misVbdipPaclOsgCM2Xi5us3G/S6yC3M6c3f7Qu17Miou2hg64MyV2QdP9QLVzwAiamv
         7k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zS/e7RhGXKmqiHAbEFyOUVLEzjgj8L6c5oYAEfYX0K0=;
        b=Ogb5LOvwWai/yAcK5Ro2oOV9NvfGKlAzXGomr2lKIkXpvom8WaFQMOjGBWajc3+hT+
         mVx1cBGHR+NLEEU4k/QOvwmfzIYNbm1wV8vyJk8nqnHGHK3s58rYaEUllHBk8dy35eyn
         NMepR7lzRaRkdL5qsDwrcIuJmfpIaYASyWsOoLeymUoeS7SlE6s21fL1o5zDlQaHi6PL
         4bDOSnuqUnoRWt7Y6ezLUJ7S85nWDA4jXq99+Hecm5FUvb8LjhQUSIhACBZER87CkmH/
         7vTb6/Y/ETi6FDqDc+Ub6olBX5ftz+IyNxgkm+utkgt7ODJUKXxmuNjL+QGnlf0fglg4
         2ryQ==
X-Gm-Message-State: AOAM530eLckTnm71OlhKcc0NFxnKEa1smFSyGB12+Ts0SW1yG6yp3iXO
        HkB7CXGL9f79GziKHAsfGKjhjQ==
X-Google-Smtp-Source: ABdhPJyHNyp/R0XwPQv4OgWPSlzWDQvX2YWw/1IGnbVSiwunuu30SjbIZpLdAvqFRxhwo9TuOgeycA==
X-Received: by 2002:a05:651c:1a0b:b0:250:5c9e:d7e8 with SMTP id by11-20020a05651c1a0b00b002505c9ed7e8mr1917544ljb.84.1651840819562;
        Fri, 06 May 2022 05:40:19 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v27-20020ac25b1b000000b0047255d21195sm670707lfn.196.2022.05.06.05.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 05:40:19 -0700 (PDT)
Message-ID: <1b32940e-e402-6196-fd7e-0e34a7a18495@linaro.org>
Date:   Fri, 6 May 2022 15:40:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 2/5] clk: qcom: regmap: add pipe clk implementation
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
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
 <20220501192149.4128158-3-dmitry.baryshkov@linaro.org>
 <YnUVCCXybHUSAYx2@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YnUVCCXybHUSAYx2@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/05/2022 15:31, Johan Hovold wrote:
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
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> I think this is much better and it addresses most of my concerns with
> the previous approach by keeping things simple and using a dedicated
> implementation (i.e. separate from regmap-mux).
> 
> The purpose of the clock implementation can be documented in the source
> and is reflected in the naming. It avoids the issues related to the
> caching (locking and deferred muxing) which wasn't really needed in the
> first place as these muxes are binary.
> 
> By implementing is_enabled() you also allow for inspecting the state
> that the boot firmware left the mux in.
> 
> The only thing that comes to mind that wouldn't be possible is to
> set the mux state using an assigned clock parent in devicetree to make
> sure that XO is always selected before toggling the GDSC at probe.
> 
> But since that doesn't seem to work anyway when the boot firmware has
> set things up (e.g. causes a modem here to reset) that would probably
> need to be handled in the GDSC driver anyway (i.e. make sure the source
> is XO before enabling the GDSC but only when it was actually disabled).
> 
> Taking that one step further would be to implement all this in the GDSC
> driver from the start so that the PHY PLL is always muxed in while the
> power domain is enabled (and only then)...

I think, if we move this to the gdsc driver, we'd loose the part of the 
clock tree.

> 
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
> 
> Since pipe is so overloaded already can we call this "pipe_mux" or
> "pipe_src" instead of just "pipe"?

I'd settle on the pipe_src then.
If you don't mind, I'll wait for your Tested-by and will post the rename 
patchset afterwards.

> 
> And similarly for
> 
> 	pipe_mux_is_enabled()
> 	struct clk_regmap_pipe_mux
> 	struct clk_regmap_pipe_mux_ops
> 
> etc.
> 
>> +	struct clk_regmap *clkr = to_clk_regmap(hw);
>> +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
>> +	unsigned int val;
>> +
>> +	regmap_read(clkr->regmap, pipe->reg, &val);
>> +	val = (val & mask) >> pipe->shift;
>> +
>> +	WARN_ON(unlikely(val != pipe->enable_val && val != pipe->disable_val));
> 
> This is not a hot path and there's rarely a need for unlikely().

Ack.

> 
>> +
>> +	return val == pipe->enable_val;
>> +}
> 
> Johan


-- 
With best wishes
Dmitry
