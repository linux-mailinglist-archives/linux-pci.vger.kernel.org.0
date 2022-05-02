Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA761516E93
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 13:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiEBLNl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 07:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiEBLNl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 07:13:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCDEEA
        for <linux-pci@vger.kernel.org>; Mon,  2 May 2022 04:10:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id v11so2562125pff.6
        for <linux-pci@vger.kernel.org>; Mon, 02 May 2022 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KrF+TMnGCTeovFvjPgVgunVgkeXw/MuqtYvkepZGc08=;
        b=alHG6KJXpdw4d3fBStv6nml/ENg2l9DEd0i9Ma5ATUJhKoJqg6got97jJQmvh9Xy5R
         7l/zUHZ2pqGfenLg0vTHzQTCwZls0Y7jtYDsW105vhR33fF7SBf27RhwKRFMfrlH4Px8
         rBJRZYWgDErx1Z3C8OrlG6CpUnRoCH0JaHBAwyK8AGGYUVJZEzFFZBhFly4AEqdkos3y
         OVCtxGfgo6x9RNG0Lejhl5n1nVrk9/ZW4BqDVxSDRW6oPsnUfHql7UwGExaC9UlXptU0
         OqP4N+8OhEGH7rhVNSsgCkOMrCR1jzqZuYggzKJB5hxfnicNlh8i7O55WqGIJuD/j70r
         z29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KrF+TMnGCTeovFvjPgVgunVgkeXw/MuqtYvkepZGc08=;
        b=AXMwIesTGpWXhs8pVxJf+/3j4ejgzyh7Sg6KbeQq28vUe9Dme8kVroswmgm/SvlpS0
         wfbSyY9MN9VZoYFUU9+QvQxkcQ70AP5Ou3tRmN82BemIhFmLN0Of6NNkC+x0f0WKrYbo
         FNGlSpTa3qQ4aFASrLr4Gm1P6kdJeQEnJHbZmaVRFPKVA2BtLU1Hy8eWGSeepHmb0Su9
         e3HZqC+WKzeZXx7dvcNnW3LtCYqiz2EsP9kbUBZLlxv+LdmgAe/FTZzO8lgZAPytmOEa
         s8VIhET8PptXEXzuEf8pJ8jfhLSqzzYREoafXPsYn4y1a/jI8qFky/WkJRSu6pINkzJv
         sgiQ==
X-Gm-Message-State: AOAM533z9beb4G8u7CMRLz2+N3SlMYGRolejGFxKgx8IZm2u5/Iop7Kw
        rM6rB8HGQXFJOftsYRsUGYPe
X-Google-Smtp-Source: ABdhPJxJATpPVf0pr5Mxh9mR3AeVjIQkpjJ+0bwHEfrPTdXP6Fe6nf46rZ2NDPIu/8bs5EIa8MKDTQ==
X-Received: by 2002:a63:84c3:0:b0:3aa:f229:45c5 with SMTP id k186-20020a6384c3000000b003aaf22945c5mr9272188pgd.415.1651489810845;
        Mon, 02 May 2022 04:10:10 -0700 (PDT)
Received: from thinkpad ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id r20-20020a170902ea5400b0015e8d4eb22esm4378162plg.120.2022.05.02.04.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 04:10:10 -0700 (PDT)
Date:   Mon, 2 May 2022 16:40:04 +0530
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
Message-ID: <20220502111004.GH5053@thinkpad>
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
 <20220501192149.4128158-3-dmitry.baryshkov@linaro.org>
 <20220502101053.GF5053@thinkpad>
 <c47616bf-a0c3-3ad5-c3e2-ba2ae33110d0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c47616bf-a0c3-3ad5-c3e2-ba2ae33110d0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 02, 2022 at 01:35:34PM +0300, Dmitry Baryshkov wrote:

[...]

> > > +static int pipe_is_enabled(struct clk_hw *hw)
> > > +{
> > > +	struct clk_regmap_pipe *pipe = to_clk_regmap_pipe(hw);
> > > +	struct clk_regmap *clkr = to_clk_regmap(hw);
> > > +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
> > > +	unsigned int val;
> > > +
> > > +	regmap_read(clkr->regmap, pipe->reg, &val);
> > > +	val = (val & mask) >> pipe->shift;
> > > +
> > > +	WARN_ON(unlikely(val != pipe->enable_val && val != pipe->disable_val));
> > > +
> > > +	return val == pipe->enable_val;
> > 
> > Selecting the clk parents in the enable/disable callback seems fine to me but
> > the way it is implemented doesn't look right.
> > 
> > First this "pipe_clksrc" is a mux clk by design, since we can only select the
> > parent. But you are converting it to a gate clk now.
> > 
> > Instead of that, my proposal would be to make this clk a composite one i.e,.
> > gate clk + mux clk. So even though the gate clk here would be a hack, we are
> > not changing the definition of mux clk.
> 
> This is what I had before, in revisions 1-3. Which proved to work, but is
> problematic a bit.
> 
> In the very end, it is not easily possible to make a difference between a
> clock reparented to the bi_tcxo and a disabled clock. E.g. if some user
> reparents the clock to the tcxo, then the driver will consider the clock
> disabled, but the clock framework will think that the clock is still
> enabled.

I don't understand this. How can you make this clock disabled? It just has 4
parents, right?

> 
> Thus we have to remove "safe" clock (bi_tcxo) from the list of parents. In
> case of pipe clocks (and ufs symbol clocks) this will leave us with just a
> single possible parent. Then having the mux part just doesn't make sense. It
> is just a gated clock. And this simplified a lot of things.
> 
> > 
> > So you can introduce a new ops like "clk_regmap_mux_gate_ops" and implement the
> > parent switching logic in the enable/disable callbacks. Additional benefit of
> > this ops is, in the future we can also support "gate + mux" clks easily.
> 
> If the need arises, we can easily resurrect the regmap_mux_safe patchset,
> fix the race pointed out by Johan, remove extra src-val mapping for safe
> value and use it for such clocks. I can post it separately, if you wish. But
> I'm not sure that it makes sense to use it for single-parent clocks.
> 
> > 
> > Also, please don't use the "enable_val/disable_val" members. It should be
> > something like "mux_sel_pre/mux_sel_post".
> 
> Why? Could you please elaborate?
> 

It aligns with my question above. I don't see how this clk can be
enabled/disabled.

Thanks,
Mani
