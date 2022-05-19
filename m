Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7BF52D143
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 13:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbiESLQ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 07:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiESLQ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 07:16:27 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BEA45525
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 04:16:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id g16so5844606lja.3
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 04:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gXflK4UhrUagmJzU5oFjeXwmmPoO0pXf0gC0h4SEjzU=;
        b=JyAT2f/j1K+rUcpbXtyGc7AumEcnByBEXSHbbkXCi1Ld+lUxLk3WTfaswX1HzsySfS
         R6XSnyce/W7E2rneBqfyypjVtWTC+y/UQP09dqI8+7QZUom8UUy/GbUBM5JGw8KfR8Xv
         dWfxPJadbxEAbEExRUDh1lDgAWiX5+P8xZM47ob4Q5Us1Szu8l7l7Ey0cHDC9Ez+xmSA
         CT4SAy+wXzivS2eaAjmDw7ulNOU0h3c/OtRrDa4wX5GeK3EFqncJSzKKvyCI7QPQCtcU
         TbbOLlimehGl+KDT2S8p/Zj2Va/xFNIjKR9QCn+B8IW6HRTYo0a7tq/4ouXYAh+TNPxC
         x0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gXflK4UhrUagmJzU5oFjeXwmmPoO0pXf0gC0h4SEjzU=;
        b=1to+8JeLW01ch8DY7d4PMAaZ8mYkONH+O8KH8LqWS4kv0BPb/rnLSbhndc+QoCJYss
         j5efn/YB/lHG7El+8STr0/Bos/PQUp8ydXnNv2GTLiSk+RtIomHk/+qU1n+1IlKlNMhH
         f16tSmr5y7u1XVlO+tqyUg7yA3I0NWKl5RbLOKq6GZ7uwWgnBMinQC2Yi+yHxY0Wh9t1
         bK4Y9YIj26OLXh/tAd8tuaPJLjxHmaAHCWU5246SkL6MQqqm2xvdC0moWqs0FajtsHXI
         fD0jRjL25PZ9zAI5/uJZmq9ZNk8YVUfkeJzTdvHNSYXfV34daBi9hJs7SkgOC7wzzX6V
         0sqA==
X-Gm-Message-State: AOAM532MbxQIIYPXIvkrUhdMQU0e57l6aJLurwWx+LO8OePMxJmCONne
        NjX6f4EcneiXXISYUPV7UTdnhw==
X-Google-Smtp-Source: ABdhPJxor+uJT9MTp9D/hfxSooOEP7GXMOniqoHd77e+746+hg/qoqk2uRExOR7X8Zsu51Jk0B+LZw==
X-Received: by 2002:a2e:a406:0:b0:253:c7e8:d4e8 with SMTP id p6-20020a2ea406000000b00253c7e8d4e8mr2367271ljn.205.1652958982061;
        Thu, 19 May 2022 04:16:22 -0700 (PDT)
Received: from ?IPV6:2001:470:dd84:abc0::8a5? ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id w10-20020ac254aa000000b0047255d21117sm256076lfk.70.2022.05.19.04.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 04:16:21 -0700 (PDT)
Message-ID: <fa94b8f3-a88d-5d9c-9d8a-7c0316f15cfa@linaro.org>
Date:   Thu, 19 May 2022 14:16:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 2/5] clk: qcom: regmap: add PHY clock source
 implementation
Content-Language: en-GB
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
 <20220513175339.2981959-3-dmitry.baryshkov@linaro.org>
 <20220518175808.EC29AC385A5@smtp.kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220518175808.EC29AC385A5@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/05/2022 20:58, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2022-05-13 10:53:36)
>> diff --git a/drivers/clk/qcom/clk-regmap-phy-mux.c b/drivers/clk/qcom/clk-regmap-phy-mux.c
>> new file mode 100644
>> index 000000000000..d7a45f7fa1aa
>> --- /dev/null
>> +++ b/drivers/clk/qcom/clk-regmap-phy-mux.c
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
> 
> clk-provider.h for clk_hw/clk_ops usage. It helps with grep to identify
> clk providers.
> 
>> +
>> +#include "clk-regmap-phy-mux.h"
> 
> Same for clk-regmap.h, avoid include hell.

I couldn't catch this comment. I think we need clk-regmap.h in 
clk-regmap-phy-mux.h as clk_regmap is a part of defined structure.

>> +
>> +static inline struct clk_regmap_phy_mux *to_clk_regmap_phy_mux(struct clk_hw *hw)
>> +{
>> +       return container_of(to_clk_regmap(hw), struct clk_regmap_phy_mux, clkr);
>> +}
>> +
>> +static int phy_mux_is_enabled(struct clk_hw *hw)
>> +{
>> +       struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(hw);
>> +       struct clk_regmap *clkr = to_clk_regmap(hw);
>> +       unsigned int mask = GENMASK(phy_mux->width + phy_mux->shift - 1, phy_mux->shift);
>> +       unsigned int val;
>> +
>> +       regmap_read(clkr->regmap, phy_mux->reg, &val);
>> +       val = (val & mask) >> phy_mux->shift;
> 
> Can this use FIELD_GET?
> 
>> +
>> +       WARN_ON(val != phy_mux->phy_src_val && val != phy_mux->ref_src_val);
>> +
>> +       return val == phy_mux->phy_src_val;
>> +}
>> +
>> +static int phy_mux_enable(struct clk_hw *hw)
>> +{
>> +       struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(hw);
>> +       struct clk_regmap *clkr = to_clk_regmap(hw);
>> +       unsigned int mask = GENMASK(phy_mux->width + phy_mux->shift - 1, phy_mux->shift);
>> +       unsigned int val;
>> +
>> +       val = phy_mux->phy_src_val << phy_mux->shift;
> 
> Can this use FIELD_PREP?
> 
>> +
>> +       return regmap_update_bits(clkr->regmap, phy_mux->reg, mask, val);
>> +}
>> +
>> +static void phy_mux_disable(struct clk_hw *hw)
>> +{
>> +       struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(hw);
>> +       struct clk_regmap *clkr = to_clk_regmap(hw);
>> +       unsigned int mask = GENMASK(phy_mux->width + phy_mux->shift - 1, phy_mux->shift);
>> +       unsigned int val;
>> +
>> +       val = phy_mux->ref_src_val << phy_mux->shift;
>> +
>> +       regmap_update_bits(clkr->regmap, phy_mux->reg, mask, val);
>> +}
>> +
>> +const struct clk_ops clk_regmap_phy_mux_ops = {
>> +       .enable = phy_mux_enable,
>> +       .disable = phy_mux_disable,
>> +       .is_enabled = phy_mux_is_enabled,
>> +};
>> +EXPORT_SYMBOL_GPL(clk_regmap_phy_mux_ops);
>> diff --git a/drivers/clk/qcom/clk-regmap-phy-mux.h b/drivers/clk/qcom/clk-regmap-phy-mux.h
>> new file mode 100644
>> index 000000000000..6260912191c5
>> --- /dev/null
>> +++ b/drivers/clk/qcom/clk-regmap-phy-mux.h
>> @@ -0,0 +1,37 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022, Linaro Ltd.
>> + * Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> + */
>> +
>> +#ifndef __QCOM_CLK_REGMAP_PHY_MUX_H__
>> +#define __QCOM_CLK_REGMAP_PHY_MUX_H__
>> +
>> +#include <linux/clk-provider.h>
>> +#include "clk-regmap.h"
>> +
>> +/*
>> + * A special clock implementation for PHY pipe and symbols clock sources.
> 
> Remove "special" please. Everything is special :)
> 
>> + *
>> + * If the clock is running off the from-PHY source, report it as enabled.
> 
> from-PHY is @phy_src_val? Maybe add that information like "from-PHY
> source (@phy_src_val)"
> 
>> + * Report it as disabled otherwise (if it uses reference source).
> 
> Same for @ref_src_val
> 
>> + *
>> + * This way the PHY will disable the pipe clock before turning off the GDSC,
>> + * which in turn would lead to disabling corresponding pipe_clk_src (and thus
>> + * it being parked to a safe, reference clock source). And vice versa, after
>> + * enabling the GDSC the PHY will enable the pipe clock, which would cause
>> + * pipe_clk_src to be switched from a safe source to the working one.
> 
> Might as well make it into real kernel-doc at the same time.
> 
>> + */
>> +
>> +struct clk_regmap_phy_mux {
>> +       u32                     reg;
>> +       u32                     shift;
>> +       u32                     width;
> 
> Technically neither of these need to be u32 and could be u8 to save a
> byte or two. The other thing is that possibly the width and shift never
> changes? The RCG layout is pretty well fixed. Does hardcoding it work?
> 
>> +       u32                     phy_src_val;
>> +       u32                     ref_src_val;
> 
> I feel like "_val" is redundant. Just "ref_src" and "phy_src"? Shorter
> is nice.
> 
>> +       struct clk_regmap       clkr;
>> +};
>> +
>> +extern const struct clk_ops clk_regmap_phy_mux_ops;


-- 
With best wishes
Dmitry
