Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA6E51DBE7
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 17:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390522AbiEFP3s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 11:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442814AbiEFP3s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 11:29:48 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74DF6899D
        for <linux-pci@vger.kernel.org>; Fri,  6 May 2022 08:26:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fv2so7314255pjb.4
        for <linux-pci@vger.kernel.org>; Fri, 06 May 2022 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iGapkGE60Ffp9Dn3FwYexU8rjobxhlsX80rf5yE5Vjs=;
        b=f9uM7cC/GaS4cQVSQZojtKIz32bLjFaJ+lWtzkVLxkOgtdFA4e/M/SeEAGW1tssIgV
         Goou3HGyVtCULN13GwNh6eTc+ck/MwsDYOtHMUZXyR/jaJXPGBkagH2dQQ5jc83AjYWR
         5meOU1IpoTnlb/AcHQk4sqWPsKqxWBoir2yh1HggD4pNbhyDolRqkAWKTYSz2bBwy1xO
         pVqFW8+aCJwf6G+GgBZgaDDTRhdLdEcfSMowidixPZRzjIuDIu6/PDHBxtlAb9nRPPmO
         9ml+NxB9FCdMqV3tl7JRGUoXHD1Iqwt35i+3ziDurwGGK3NVrAhUAOhzNyGk/prgsobG
         TUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iGapkGE60Ffp9Dn3FwYexU8rjobxhlsX80rf5yE5Vjs=;
        b=k114qYOJuXoRrmhPRIUM0KITZ8RURikIVgoYCQSnFzlCJRJD5IN+hOtPE2rfyokYqy
         VN1Cqy5/I3vqwHf1ESajvby25wF4Dt6kbDcQZfQjgEAjmTlXqekr1sDRTmDiYB2JR2z7
         Pmx4Lec3d8anm4THiTC4YeDwhh0jHRuleKa6LsfIE7jGhgfFnOElPmxoA3FwHiuGrnbl
         fjDKvq3Zt8TIecPAOkd7DnHl3WAZLUHvy4XBXiuw9Yhk7tnH2c3MUydyuASN5S1qJLSv
         7NQMtAy6uHofEK5UHz3CYL8jd75kS/06yG8NwJ8aJczi5OuF5HkZFBC6YjRI/MltgS28
         6/Dw==
X-Gm-Message-State: AOAM531Ay0pEo8vHNHHnm8hq33BbpVJjy4rXSgI60V34ZJlG6b+gIJIH
        OH35eZhLUxLyTboGnRFv3QaZ
X-Google-Smtp-Source: ABdhPJxRHQ1fSI73te9IorgJaSG7Tug/yMs0bB1EYetO1etF/9nUgYGFqgHAyTidzPAwZSI/J7S+UQ==
X-Received: by 2002:a17:902:ef45:b0:156:1858:71fc with SMTP id e5-20020a170902ef4500b00156185871fcmr4071899plx.23.1651850764099;
        Fri, 06 May 2022 08:26:04 -0700 (PDT)
Received: from thinkpad ([27.111.75.233])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902b20b00b0015ea9aabd19sm1858160plr.241.2022.05.06.08.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 08:26:03 -0700 (PDT)
Date:   Fri, 6 May 2022 20:55:58 +0530
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
Message-ID: <20220506152558.GA5907@thinkpad>
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
 <20220501192149.4128158-3-dmitry.baryshkov@linaro.org>
 <20220502101053.GF5053@thinkpad>
 <c47616bf-a0c3-3ad5-c3e2-ba2ae33110d0@linaro.org>
 <20220502111004.GH5053@thinkpad>
 <29819e6d-9aa1-aca9-0ff6-b81098077f28@linaro.org>
 <20220502150611.GF98313@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220502150611.GF98313@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 02, 2022 at 08:36:19PM +0530, Manivannan Sadhasivam wrote:
> On Mon, May 02, 2022 at 02:18:26PM +0300, Dmitry Baryshkov wrote:
> > On 02/05/2022 14:10, Manivannan Sadhasivam wrote:
> > > On Mon, May 02, 2022 at 01:35:34PM +0300, Dmitry Baryshkov wrote:
> > > 
> > > [...]
> > > 
> > > > > > +static int pipe_is_enabled(struct clk_hw *hw)
> > > > > > +{
> > > > > > +	struct clk_regmap_pipe *pipe = to_clk_regmap_pipe(hw);
> > > > > > +	struct clk_regmap *clkr = to_clk_regmap(hw);
> > > > > > +	unsigned int mask = GENMASK(pipe->width + pipe->shift - 1, pipe->shift);
> > > > > > +	unsigned int val;
> > > > > > +
> > > > > > +	regmap_read(clkr->regmap, pipe->reg, &val);
> > > > > > +	val = (val & mask) >> pipe->shift;
> > > > > > +
> > > > > > +	WARN_ON(unlikely(val != pipe->enable_val && val != pipe->disable_val));
> > > > > > +
> > > > > > +	return val == pipe->enable_val;
> > > > > 
> > > > > Selecting the clk parents in the enable/disable callback seems fine to me but
> > > > > the way it is implemented doesn't look right.
> > > > > 
> > > > > First this "pipe_clksrc" is a mux clk by design, since we can only select the
> > > > > parent. But you are converting it to a gate clk now.
> > > > > 
> > > > > Instead of that, my proposal would be to make this clk a composite one i.e,.
> > > > > gate clk + mux clk. So even though the gate clk here would be a hack, we are
> > > > > not changing the definition of mux clk.
> > > > 
> > > > This is what I had before, in revisions 1-3. Which proved to work, but is
> > > > problematic a bit.
> > > > 
> > > > In the very end, it is not easily possible to make a difference between a
> > > > clock reparented to the bi_tcxo and a disabled clock. E.g. if some user
> > > > reparents the clock to the tcxo, then the driver will consider the clock
> > > > disabled, but the clock framework will think that the clock is still
> > > > enabled.
> > > 
> > > I don't understand this. How can you make this clock disabled? It just has 4
> > > parents, right?
> > 
> > It has 4 parents. It uses just two of them (pipe and tcxo).
> > 
> > And like the clk_rcg2_safe clock we'd like to say that these clocks are
> > disabled by reparenting ("parking") them to the tcxo source. Yes, this makes
> > a lot of code simpler. The clock framework will switch the clock to the
> > "safe" state instead of disabling it during the unused clocks evaporation.
> > The PHY can just disable the gcc_pcie_N_pipe_clock, which will end up in
> > parking this clock to a safe state too, etc.
> 
> If I get the logic behind this "parking" thing right, then it is required
> for producing a stable pipe_clk from GCC when the PHY is about to initialize.
> Also to make sure that there is no glitch observed on pipe_clk while
> initializing the PHY. And once it is powered ON properly, the pipe_clksrc
> should be used as the parent for pipe_clk.
> 
> So with that logic, we cannot say that this clk is disabled.
> 
> Please correct me if my understanding is wrong.
> 

After going through the previous iterations and PHY patches, this
implementation makes sense to me now (modelling this pipe_clk_src as gate clk
alone).

But as Johan said, you should change the "pipe_clk" to "pipe_clk_src" or
something similar. As this clk is defined as "pipe_clk_src" in GCC.

Regarding the {enable/disable}_val variables, I'm not fully convinced about the
naming but I don't object it strongly. But irrespective of that, please add a
brief comment in the driver about its purpose and what it does enable/disable
callbacks.

Thanks,
Mani

> Thanks,
> Mani
> 
> > 
> > > 
> > > > 
> > > > Thus we have to remove "safe" clock (bi_tcxo) from the list of parents. In
> > > > case of pipe clocks (and ufs symbol clocks) this will leave us with just a
> > > > single possible parent. Then having the mux part just doesn't make sense. It
> > > > is just a gated clock. And this simplified a lot of things.
> > > > 
> > > > > 
> > > > > So you can introduce a new ops like "clk_regmap_mux_gate_ops" and implement the
> > > > > parent switching logic in the enable/disable callbacks. Additional benefit of
> > > > > this ops is, in the future we can also support "gate + mux" clks easily.
> > > > 
> > > > If the need arises, we can easily resurrect the regmap_mux_safe patchset,
> > > > fix the race pointed out by Johan, remove extra src-val mapping for safe
> > > > value and use it for such clocks. I can post it separately, if you wish. But
> > > > I'm not sure that it makes sense to use it for single-parent clocks.
> > > > 
> > > > > 
> > > > > Also, please don't use the "enable_val/disable_val" members. It should be
> > > > > something like "mux_sel_pre/mux_sel_post".
> > > > 
> > > > Why? Could you please elaborate?
> > > > 
> > > 
> > > It aligns with my question above. I don't see how this clk can be
> > > enabled/disabled.
> > 
> > I see. Let's settle on the first question then.
> > 
> > -- 
> > With best wishes
> > Dmitry

-- 
மணிவண்ணன் சதாசிவம்
