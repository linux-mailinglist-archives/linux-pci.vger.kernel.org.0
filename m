Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BD651723B
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 17:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385689AbiEBPJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 11:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385670AbiEBPJt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 11:09:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC02111C0E
        for <linux-pci@vger.kernel.org>; Mon,  2 May 2022 08:06:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x18so1497468plg.6
        for <linux-pci@vger.kernel.org>; Mon, 02 May 2022 08:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s8pjeahSmHY/+OfDcHKmgwUj5C2NupUjmimWcIWVuVA=;
        b=GO3DwQsw+bDp6jxdcdzvkV5ZGPj6VfYagmZEutUsfkKyU2tpNuayqkqMGid9akwLFv
         UkEGu6Z07uczzVKZNmbBZAe/Zan2mfvQI2AsQI30uO7d8EH6dx/imqYWobBaI9YqoeJN
         7MHf2JO8/41qqyolw7n3hRYOYPzLs78T9J61s5Eut3EskbjV6dXSJh/Rv9yLOebgTmoc
         AEy+VNySBqdf3yFc3R+GJua/W7+NQYGzP+ecqk7bsYFGDd9z+WooF9tPNhCN2w692F2V
         A4mgJy696eOzpHYVAvH0TQ1EaaQMh6SmTNq/crVUe36chYotRr0+aqKsWK8S+sESWbev
         Ot9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s8pjeahSmHY/+OfDcHKmgwUj5C2NupUjmimWcIWVuVA=;
        b=0nC8jXgwl4/s/0AjG0kkzYulCV1P7Icupe9geMSkDuNzNxqKo0K8IydxByRfgRLc1R
         4LLixRVAoFZPyjMAugKBwNB2N8O27dXVLCDbxFzxKZmnlcAvxxnnOlCl9EiHXY5s9tZ7
         Dhpk2wug6PDl628pgwjhiSZvKv1PjdafbLu+KrGAdImuCzsuNNimmI4z1GGzaDVbiFeK
         Ft+3X/wluS54SzMKQ6sJw4/n4z9lchxmAUjewAhooIQIYPBrsVvgyu7uFMPjKRXbpfTj
         u1pKwRkgir7wtwSmZsuSE56c1HB449B+Z2PK5lS/mqDQbsct6LOLtp3/fJ6ROXPWCczX
         ZvWg==
X-Gm-Message-State: AOAM532QaaAGqThfgysJdB0e3Pfzl8mV6GM2yr9L9JU75EKv9zMUNUnd
        eyALAIWVWR41ZRCOWvDztk/e
X-Google-Smtp-Source: ABdhPJy2Y0FbfXNrBSO760DSXBUAZna913vKcGrQdhh3QD/qvSQscxFtuaF8fgfULlBTSJLZS7kReQ==
X-Received: by 2002:a17:902:e812:b0:15e:a6cc:e015 with SMTP id u18-20020a170902e81200b0015ea6cce015mr4820605plg.93.1651503979130;
        Mon, 02 May 2022 08:06:19 -0700 (PDT)
Received: from thinkpad ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090a744700b001cd4989ff56sm15958634pjk.29.2022.05.02.08.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 08:06:18 -0700 (PDT)
Date:   Mon, 2 May 2022 20:36:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/5] clk: qcom: regmap: add pipe clk implementation
Message-ID: <20220502150611.GF98313@thinkpad>
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
 <20220501192149.4128158-3-dmitry.baryshkov@linaro.org>
 <20220502101053.GF5053@thinkpad>
 <c47616bf-a0c3-3ad5-c3e2-ba2ae33110d0@linaro.org>
 <20220502111004.GH5053@thinkpad>
 <29819e6d-9aa1-aca9-0ff6-b81098077f28@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29819e6d-9aa1-aca9-0ff6-b81098077f28@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 02, 2022 at 02:18:26PM +0300, Dmitry Baryshkov wrote:
> On 02/05/2022 14:10, Manivannan Sadhasivam wrote:
> > On Mon, May 02, 2022 at 01:35:34PM +0300, Dmitry Baryshkov wrote:
> > 
> > [...]
> > 
> > > > > +static int pipe_is_enabled(struct clk_hw *hw)
> > > > > +{
> > > > > +	struct clk_regmap_pipe *pipe = to_clk_regmap_pipe(hw);
> > > > > +	struct clk_regmap *clkr = to_clk_regmap(hw);
> > > > > +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
> > > > > +	unsigned int val;
> > > > > +
> > > > > +	regmap_read(clkr->regmap, pipe->reg, &val);
> > > > > +	val = (val & mask) >> pipe->shift;
> > > > > +
> > > > > +	WARN_ON(unlikely(val != pipe->enable_val && val != pipe->disable_val));
> > > > > +
> > > > > +	return val == pipe->enable_val;
> > > > 
> > > > Selecting the clk parents in the enable/disable callback seems fine to me but
> > > > the way it is implemented doesn't look right.
> > > > 
> > > > First this "pipe_clksrc" is a mux clk by design, since we can only select the
> > > > parent. But you are converting it to a gate clk now.
> > > > 
> > > > Instead of that, my proposal would be to make this clk a composite one i.e,.
> > > > gate clk + mux clk. So even though the gate clk here would be a hack, we are
> > > > not changing the definition of mux clk.
> > > 
> > > This is what I had before, in revisions 1-3. Which proved to work, but is
> > > problematic a bit.
> > > 
> > > In the very end, it is not easily possible to make a difference between a
> > > clock reparented to the bi_tcxo and a disabled clock. E.g. if some user
> > > reparents the clock to the tcxo, then the driver will consider the clock
> > > disabled, but the clock framework will think that the clock is still
> > > enabled.
> > 
> > I don't understand this. How can you make this clock disabled? It just has 4
> > parents, right?
> 
> It has 4 parents. It uses just two of them (pipe and tcxo).
> 
> And like the clk_rcg2_safe clock we'd like to say that these clocks are
> disabled by reparenting ("parking") them to the tcxo source. Yes, this makes
> a lot of code simpler. The clock framework will switch the clock to the
> "safe" state instead of disabling it during the unused clocks evaporation.
> The PHY can just disable the gcc_pcie_N_pipe_clock, which will end up in
> parking this clock to a safe state too, etc.

If I get the logic behind this "parking" thing right, then it is required
for producing a stable pipe_clk from GCC when the PHY is about to initialize.
Also to make sure that there is no glitch observed on pipe_clk while
initializing the PHY. And once it is powered ON properly, the pipe_clksrc
should be used as the parent for pipe_clk.

So with that logic, we cannot say that this clk is disabled.

Please correct me if my understanding is wrong.

Thanks,
Mani

> 
> > 
> > > 
> > > Thus we have to remove "safe" clock (bi_tcxo) from the list of parents. In
> > > case of pipe clocks (and ufs symbol clocks) this will leave us with just a
> > > single possible parent. Then having the mux part just doesn't make sense. It
> > > is just a gated clock. And this simplified a lot of things.
> > > 
> > > > 
> > > > So you can introduce a new ops like "clk_regmap_mux_gate_ops" and implement the
> > > > parent switching logic in the enable/disable callbacks. Additional benefit of
> > > > this ops is, in the future we can also support "gate + mux" clks easily.
> > > 
> > > If the need arises, we can easily resurrect the regmap_mux_safe patchset,
> > > fix the race pointed out by Johan, remove extra src-val mapping for safe
> > > value and use it for such clocks. I can post it separately, if you wish. But
> > > I'm not sure that it makes sense to use it for single-parent clocks.
> > > 
> > > > 
> > > > Also, please don't use the "enable_val/disable_val" members. It should be
> > > > something like "mux_sel_pre/mux_sel_post".
> > > 
> > > Why? Could you please elaborate?
> > > 
> > 
> > It aligns with my question above. I don't see how this clk can be
> > enabled/disabled.
> 
> I see. Let's settle on the first question then.
> 
> -- 
> With best wishes
> Dmitry
