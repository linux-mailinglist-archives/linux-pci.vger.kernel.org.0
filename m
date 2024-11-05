Return-Path: <linux-pci+bounces-16033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83619BC803
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 09:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3450B21066
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 08:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EA71C1738;
	Tue,  5 Nov 2024 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gXWxeCPv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A2B2C1A2
	for <linux-pci@vger.kernel.org>; Tue,  5 Nov 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795416; cv=none; b=fFLXjbC1SWjPkRf19JsKwDCQDUVabm1NCTleglqt7AUciFnoetCnsA8JS7ObXKMJxOf1yE8oTIm3YjBxYWVPzLmF+yQWUzcdMCMBW9r2Y8H5Vvr79NuU015GFbu5GCGrDTllj7ObDdrmBMKvJb94BpwbmXHM92PMMSdo/tAYISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795416; c=relaxed/simple;
	bh=FEBIAaA2LrirNuL99GbWEPrHwblsHtQGutZPgiED1Ck=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8a6LZ1+1gWoeoagONVa57cLAwjmlYJmTE3m88pDMu3KDycs5u2RHamAIh7rdhLTRleD7dBqJngSl7kBC1QFT5D1BOyJNZteOdcl1Nv5tcO8AlgVlS7PhwRd581S4cCp5+dFMRUg/6Iwe7A//cuBHFZSzrJfKRIx4Ki0GVOKZjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gXWxeCPv; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a9a16b310f5so821366966b.0
        for <linux-pci@vger.kernel.org>; Tue, 05 Nov 2024 00:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730795412; x=1731400212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kpw01HNU/Sv0xgXPzYBXhrajrBvyrTSpHufBO5hxwkk=;
        b=gXWxeCPvzx0V+b4004tJQpXsCedVCh8oBzHppdgo9kob3s6NcBgamATPKGKP8MR+00
         tAqHPpTeJ/8cH/cSe7ZI3Em3Rt2n5+NUhH8pb/WrnKlSAKhXgm7FaQB5DXmjIwc6Fx5c
         j4vczbgDoeA54+3gQlNe5jbIRb3r50TVsxA/NpXMXZMNcsHn2Sjlxlg4wMQuQVaPaq3w
         7amZ223kAD9lpfK7OVuvLjPlkI5H5H4xmO6qXE1qhRwi4Hot7XqusET/Ld3aZ5YYZGBK
         EVxFsWKdMK2HWVaV4Jv5fbYqwmQ/AEVf4tPCA2jsyTbpdQCzw5trS6O+uKTZvrKdfasb
         gogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730795412; x=1731400212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kpw01HNU/Sv0xgXPzYBXhrajrBvyrTSpHufBO5hxwkk=;
        b=veCdgbPhwDmLK8xrLYz3nSZAfbwDlfMJxPpp0c0SCBdNU4rjGw733MrVSZ71FO9wTV
         yLcfgUVFm4+64NE6xo+WMQf2KDKuABqHaioHwyH4lrYznUnjM2s84YQmTX/9sr2snawB
         RmviHbhaEF6pmnUyVUI+wkhBALz2EguDKmahAqeKRjqOD2badAGaavH2NO6eb7dGO4Gh
         Sc4IuJrkud/eZluo2xsZ0Pp3yO/NlUT/u0489SbMHeTqjDHPR/JGXzy+C9v4RdzJoR7k
         O6hy/1B14icrOJY/blzPhY4N8LB+QSCewnhT4AuVJl+dGbMxfipSuYTM3/jSolnsy9iX
         S25g==
X-Forwarded-Encrypted: i=1; AJvYcCWYscrm2AhnichoVvtuzxRBDaRwmhifA5xjEWGl66tOpDTxWAHZRnze7WywSlRvSwoIhW2MDGHnA7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx9z4hdwl3Dm9EiVn/QllUlUCqLUMex9dvoPlWGre0xEWiYVuw
	gE+ZRxP3Q7sgFAAVFrFy/mA0vodkwniFSSOSf8yyiKFw3HzEGcwTJCPZRC/B9nE=
X-Google-Smtp-Source: AGHT+IE4HmcRyyOJrLcIvLVZE/X26LsWeylyyS8o4KlNGwK33ooeQUPKh0OQozoC1twhQBug+FmFNg==
X-Received: by 2002:a17:907:7e8f:b0:a99:dde6:9f42 with SMTP id a640c23a62f3a-a9e50b935bcmr1654303266b.47.1730795411966;
        Tue, 05 Nov 2024 00:30:11 -0800 (PST)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16da0b6sm98946766b.76.2024.11.05.00.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 00:30:11 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 5 Nov 2024 09:30:38 +0100
To: Stephen Boyd <sboyd@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v3 07/12] clk: rp1: Add support for clocks provided by RP1
Message-ID: <ZynXrg8OlGvPcmWb@apocalypse>
References: <cover.1730123575.git.andrea.porta@suse.com>
 <c20e3d6d87c71691b149cdeeafc94009953346b2.1730123575.git.andrea.porta@suse.com>
 <01c2bb3609dcb32191a78293c1666b0a.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c2bb3609dcb32191a78293c1666b0a.sboyd@kernel.org>

Hi Stephen,

On 15:20 Mon 28 Oct     , Stephen Boyd wrote:
> Quoting Andrea della Porta (2024-10-28 07:07:24)
> > diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> > new file mode 100644
> > index 000000000000..69b9cf037cb2
> > --- /dev/null
> [...]
> > +
> > +struct rp1_clockman {
> > +       struct device *dev;
> > +       void __iomem *regs;
> 
> Do you still need this if there's a regmap?

Unfortunately the clk_divider registered in rp1_register_pll_divider()
mandates the use of a MMIO registeri, and yes, the divider and teh other
clock shares some registers. AFAICT there were attempts to upstream generic
regmap support for clk_divider, but right now there are just custom
implementations (e.g. drivers/clk/qcom/clk-regmap.c).  So, in order to
use regmap, that clock divider shoulf be first augmented with regmap
support. Please let me know if you think it's worth the effort.

> 
> > +       struct regmap *regmap;
> > +       spinlock_t regs_lock; /* spinlock for all clocks */
> 
> Do you need this or is the spinlock in the regmap sufficient?

The original code wrapped multiple registers write/read inside the spinlock,
so I suspect that using the internal regmap spinlock for each single
transaciton (so to open up for interleaved register access, although I have
no evidence of that) could have side-effects so I would prefer to stay safe
and manage the lock from outside. I could easily use regmap_multi_reg_write()
and friends to synchronize access across multiple registers but then we would
have the problem above about missing regmap support in clk_divider, since now
it's solved by passing the same spinlock to it too. I'm open to alternatives
here...

> 
> > +
> > +       /* Must be last */
> > +       struct clk_hw_onecell_data onecell;
> > +};
> > +
> > +struct rp1_pll_core_data {
> > +       const char *name;
> 
> These 'name' members can move to clk_init_data?

You've read my mind, I was exactly planning that for the next revision

> 
> > +       u32 cs_reg;
> > +       u32 pwr_reg;
> > +       u32 fbdiv_int_reg;
> > +       u32 fbdiv_frac_reg;
> > +       unsigned long flags;
> 
> And probably flags as well? It seems like clk_init_data should be
> declared at the same time as struct rp1_pll_core_data is.

Ditto.

> 
> > +       u32 fc0_src;
> > +};
> > +
> > +struct rp1_pll_data {
> > +       const char *name;
> > +       u32 ctrl_reg;
> > +       unsigned long flags;
> > +       u32 fc0_src;
> > +};
> > +
> > +struct rp1_pll_ph_data {
> > +       const char *name;
> > +       unsigned int phase;
> > +       unsigned int fixed_divider;
> > +       u32 ph_reg;
> > +       unsigned long flags;
> > +       u32 fc0_src;
> > +};
> > +
> > +struct rp1_pll_divider_data {
> > +       const char *name;
> > +       u32 sec_reg;
> > +       unsigned long flags;
> > +       u32 fc0_src;
> > +};
> > +
> > +struct rp1_clock_data {
> > +       const char *name;
> > +       int num_std_parents;
> > +       int num_aux_parents;
> > +       unsigned long flags;
> > +       u32 oe_mask;
> > +       u32 clk_src_mask;
> > +       u32 ctrl_reg;
> > +       u32 div_int_reg;
> > +       u32 div_frac_reg;
> > +       u32 sel_reg;
> > +       u32 div_int_max;
> > +       unsigned long max_freq;
> > +       u32 fc0_src;
> > +};
> > +
> > +struct rp1_clk_desc {
> > +       struct clk_hw *(*clk_register)(struct rp1_clockman *clockman,
> > +                                      struct rp1_clk_desc *desc);
> > +       const void *data;
> > +       struct clk_hw hw;
> > +       struct rp1_clockman *clockman;
> > +       unsigned long cached_rate;
> > +       struct clk_divider div;
> > +};
> > +
> > +#define FIELD_SET(_reg, _mask, _val)           \
> > +do {                                           \
> > +       u32 mask = (_mask);                     \
> > +       (_reg) &= ~mask;                        \
> > +       (_reg) |= FIELD_PREP(mask, (_val));     \
> 
> Please just write
> 
> 	reg &= ~mask
> 	reg |= FIELD_PREP(mask, val);
> 
> instead of using this macro.

Ack.

> 
> > +} while (0)
> > +
> > +
> [...]
> > +
> > +static struct clk_hw *rp1_register_pll_core(struct rp1_clockman *clockman,
> > +                                           struct rp1_clk_desc *desc)
> > +{
> > +       const struct rp1_pll_core_data *pll_core_data = desc->data;
> > +       struct clk_init_data init = { };
> > +       int ret;
> > +
> > +       /* All of the PLL cores derive from the external oscillator. */
> > +       init.parent_data = desc->hw.init->parent_data;
> > +       init.num_parents = desc->hw.init->num_parents;
> > +       init.name = pll_core_data->name;
> > +       init.ops = &rp1_pll_core_ops;
> > +       init.flags = pll_core_data->flags | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL;
> > +
> > +       desc->clockman = clockman;
> > +       desc->hw.init = &init;
> > +
> > +       ret = devm_clk_hw_register(clockman->dev, &desc->hw);
> > +
> > +       if (ret)
> > +               return ERR_PTR(ret);
> > +
> > +       return &desc->hw;
> > +}
> > +
> > +static struct clk_hw *rp1_register_pll(struct rp1_clockman *clockman,
> > +                                      struct rp1_clk_desc *desc)
> > +{
> > +       const struct rp1_pll_data *pll_data = desc->data;
> > +       struct clk_init_data init = { };
> > +       int ret;
> > +
> > +       init.parent_data = desc->hw.init->parent_data;
> > +       init.num_parents = desc->hw.init->num_parents;
> > +       init.name = pll_data->name;
> > +       init.ops = &rp1_pll_ops;
> > +       init.flags = pll_data->flags | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL;
> > +
> > +       desc->clockman = clockman;
> > +       desc->hw.init = &init;
> > +
> > +       ret = devm_clk_hw_register(clockman->dev, &desc->hw);
> > +
> > +       if (ret)
> > +               return ERR_PTR(ret);
> > +
> > +       return &desc->hw;
> > +}
> > +
> > +static struct clk_hw *rp1_register_pll_ph(struct rp1_clockman *clockman,
> > +                                         struct rp1_clk_desc *desc)
> > +{
> > +       const struct rp1_pll_ph_data *ph_data = desc->data;
> > +       struct clk_init_data init = { };
> > +       int ret;
> > +
> > +       init.parent_data = desc->hw.init->parent_data;
> > +       init.num_parents = desc->hw.init->num_parents;
> > +       init.name = ph_data->name;
> > +       init.ops = &rp1_pll_ph_ops;
> > +       init.flags = ph_data->flags | CLK_IGNORE_UNUSED;
> > +
> > +       desc->clockman = clockman;
> > +       desc->hw.init = &init;
> > +
> > +       ret = devm_clk_hw_register(clockman->dev, &desc->hw);
> > +
> > +       if (ret)
> > +               return ERR_PTR(ret);
> > +
> > +       return &desc->hw;
> > +}
> > +
> > +static struct clk_hw *rp1_register_pll_divider(struct rp1_clockman *clockman,
> > +                                              struct rp1_clk_desc *desc)
> > +{
> > +       const struct rp1_pll_data *divider_data = desc->data;
> > +       struct clk_init_data init = { };
> > +       int ret;
> > +
> > +       init.parent_data = desc->hw.init->parent_data;
> > +       init.num_parents = desc->hw.init->num_parents;
> > +       init.name = divider_data->name;
> > +       init.ops = &rp1_pll_divider_ops;
> > +       init.flags = divider_data->flags | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL;
> > +
> > +       desc->div.reg = clockman->regs + divider_data->ctrl_reg;
> 
> Why is 'regs' used here? Isn't everything using a regmap now so it's all
> offsets?

Already explained above.

> 
> > +       desc->div.shift = PLL_SEC_DIV_SHIFT;
> > +       desc->div.width = PLL_SEC_DIV_WIDTH;
> > +       desc->div.flags = CLK_DIVIDER_ROUND_CLOSEST;
> > +       desc->div.flags |= CLK_IS_CRITICAL;
> > +       desc->div.lock = &clockman->regs_lock;
> > +       desc->div.hw.init = &init;
> > +       desc->div.table = pll_sec_div_table;
> > +
> > +       desc->clockman = clockman;
> > +
> > +       ret = devm_clk_hw_register(clockman->dev, &desc->div.hw);
> > +
> > +       if (ret)
> > +               return ERR_PTR(ret);
> > +
> > +       return &desc->div.hw;
> > +}
> > +
> > +static struct clk_hw *rp1_register_clock(struct rp1_clockman *clockman,
> > +                                        struct rp1_clk_desc *desc)
> > +{
> > +       const struct rp1_clock_data *clock_data = desc->data;
> > +       struct clk_init_data init = { };
> > +       int ret;
> > +
> > +       if (WARN_ON_ONCE(MAX_CLK_PARENTS <
> > +              clock_data->num_std_parents + clock_data->num_aux_parents))
> > +               return NULL;
> > +
> > +       /* There must be a gap for the AUX selector */
> > +       if (WARN_ON_ONCE(clock_data->num_std_parents > AUX_SEL &&
> > +                        desc->hw.init->parent_data[AUX_SEL].index != -1))
> > +               return NULL;
> > +
> > +       init.parent_data = desc->hw.init->parent_data;
> > +       init.num_parents = desc->hw.init->num_parents;
> > +       init.name = clock_data->name;
> > +       init.flags = clock_data->flags | CLK_IGNORE_UNUSED;
> > +       init.ops = &rp1_clk_ops;
> > +
> > +       desc->clockman = clockman;
> > +       desc->hw.init = &init;
> > +
> > +       ret = devm_clk_hw_register(clockman->dev, &desc->hw);
> > +
> > +       if (ret)
> > +               return ERR_PTR(ret);
> > +
> > +       return &desc->hw;
> > +}
> > +
> > +/* Assignment helper macros for different clock types. */
> > +#define _REGISTER(f, ...)      { .clk_register = f, __VA_ARGS__ }
> > +
> > +#define PARENT_CLK(pnum, ...)  .hw.init = &(const struct clk_init_data) { \
> 
> Instead of this macro just use CLK_HW_INIT_HW() or
> CLK_HW_INIT_PARENTS_DATA()?

Ack.

> 
> > +                               .parent_data = (const struct               \
> > +                                               clk_parent_data[]) {       \
> > +                                                       __VA_ARGS__        \
> > +                                               },                         \
> > +                               .num_parents = pnum }
> > +
> > +#define CLK_DATA(type, ...)    .data = &(struct type) { __VA_ARGS__ }
> > +
> > +#define REGISTER_PLL_CORE(...) _REGISTER(&rp1_register_pll_core,       \
> > +                                         __VA_ARGS__)
> > +
> > +#define REGISTER_PLL(...)      _REGISTER(&rp1_register_pll,            \
> > +                                         __VA_ARGS__)
> > +
> > +#define REGISTER_PLL_PH(...)   _REGISTER(&rp1_register_pll_ph,         \
> > +                                         __VA_ARGS__)
> > +
> > +#define REGISTER_PLL_DIV(...)  _REGISTER(&rp1_register_pll_divider,    \
> > +                                         __VA_ARGS__)
> > +
> > +#define REGISTER_CLK(...)      _REGISTER(&rp1_register_clock,          \
> > +                                         __VA_ARGS__)
> > +
> > +static struct rp1_clk_desc clk_desc_array[] = {
> > +       [RP1_PLL_SYS_CORE] = REGISTER_PLL_CORE(PARENT_CLK(1, { .index = 0 }),
> > +                               CLK_DATA(rp1_pll_core_data,
> > +                                        .name = "pll_sys_core",
> > +                                        .cs_reg = PLL_SYS_CS,
> > +                                        .pwr_reg = PLL_SYS_PWR,
> > +                                        .fbdiv_int_reg = PLL_SYS_FBDIV_INT,
> > +                                        .fbdiv_frac_reg = PLL_SYS_FBDIV_FRAC,
> > +                               )),
> > +
> > +       [RP1_PLL_AUDIO_CORE] = REGISTER_PLL_CORE(PARENT_CLK(1, { .index = 0 }),
> > +                               CLK_DATA(rp1_pll_core_data,
> > +                                        .name = "pll_audio_core",
> > +                                        .cs_reg = PLL_AUDIO_CS,
> > +                                        .pwr_reg = PLL_AUDIO_PWR,
> > +                                        .fbdiv_int_reg = PLL_AUDIO_FBDIV_INT,
> > +                                        .fbdiv_frac_reg = PLL_AUDIO_FBDIV_FRAC,
> > +                               )),
> > +
> > +       [RP1_PLL_VIDEO_CORE] = REGISTER_PLL_CORE(PARENT_CLK(1, { .index = 0 }),
> > +                               CLK_DATA(rp1_pll_core_data,
> > +                                        .name = "pll_video_core",
> > +                                        .cs_reg = PLL_VIDEO_CS,
> > +                                        .pwr_reg = PLL_VIDEO_PWR,
> > +                                        .fbdiv_int_reg = PLL_VIDEO_FBDIV_INT,
> > +                                        .fbdiv_frac_reg = PLL_VIDEO_FBDIV_FRAC,
> > +                               )),
> > +
> > +       [RP1_PLL_SYS] = REGISTER_PLL(PARENT_CLK(1,
> > +                               { .hw = &clk_desc_array[RP1_PLL_SYS_CORE].hw }
> > +                               ),
> > +                               CLK_DATA(rp1_pll_data,
> > +                                        .name = "pll_sys",
> > +                                        .ctrl_reg = PLL_SYS_PRIM,
> > +                                        .fc0_src = FC_NUM(0, 2),
> > +                               )),
> > +
> > +       [RP1_CLK_ETH_TSU] = REGISTER_CLK(PARENT_CLK(1, { .index = 0 }),
> > +                               CLK_DATA(rp1_clock_data,
> > +                                        .name = "clk_eth_tsu",
> > +                                        .num_std_parents = 0,
> > +                                        .num_aux_parents = 1,
> > +                                        .ctrl_reg = CLK_ETH_TSU_CTRL,
> > +                                        .div_int_reg = CLK_ETH_TSU_DIV_INT,
> > +                                        .sel_reg = CLK_ETH_TSU_SEL,
> > +                                        .div_int_max = DIV_INT_8BIT_MAX,
> > +                                        .max_freq = 50 * HZ_PER_MHZ,
> > +                                        .fc0_src = FC_NUM(5, 7),
> > +                               )),
> > +
> > +       [RP1_CLK_SYS] = REGISTER_CLK(PARENT_CLK(3,
> > +                               { .index = 0 },
> > +                               { .index = -1 },
> > +                               { .hw = &clk_desc_array[RP1_PLL_SYS].hw }
> > +                               ),
> > +                               CLK_DATA(rp1_clock_data,
> > +                                        .name = "clk_sys",
> > +                                        .num_std_parents = 3,
> > +                                        .num_aux_parents = 0,
> > +                                        .ctrl_reg = CLK_SYS_CTRL,
> > +                                        .div_int_reg = CLK_SYS_DIV_INT,
> > +                                        .sel_reg = CLK_SYS_SEL,
> > +                                        .div_int_max = DIV_INT_24BIT_MAX,
> > +                                        .max_freq = 200 * HZ_PER_MHZ,
> > +                                        .fc0_src = FC_NUM(0, 4),
> > +                                        .clk_src_mask = 0x3,
> > +                               )),
> > +
> > +       [RP1_PLL_SYS_PRI_PH] = REGISTER_PLL_PH(PARENT_CLK(1,
> > +                               { .hw = &clk_desc_array[RP1_PLL_SYS].hw }
> > +                               ),
> > +                               CLK_DATA(rp1_pll_ph_data,
> > +                                        .name = "pll_sys_pri_ph",
> > +                                        .ph_reg = PLL_SYS_PRIM,
> > +                                        .fixed_divider = 2,
> > +                                        .phase = RP1_PLL_PHASE_0,
> > +                                        .fc0_src = FC_NUM(1, 2),
> > +                               )),
> > +
> > +       [RP1_PLL_SYS_SEC] = REGISTER_PLL_DIV(PARENT_CLK(1,
> > +                               { .hw = &clk_desc_array[RP1_PLL_SYS_CORE].hw }
> > +                               ),
> > +                               CLK_DATA(rp1_pll_data,
> > +                                        .name = "pll_sys_sec",
> > +                                        .ctrl_reg = PLL_SYS_SEC,
> > +                                        .fc0_src = FC_NUM(2, 2),
> > +                               )),
> > +};
> > +
> > +static const struct regmap_range rp1_reg_ranges[] = {
> > +       regmap_reg_range(PLL_SYS_CS, PLL_SYS_SEC),
> > +       regmap_reg_range(PLL_AUDIO_CS, PLL_AUDIO_TERN),
> > +       regmap_reg_range(PLL_VIDEO_CS, PLL_VIDEO_SEC),
> > +       regmap_reg_range(GPCLK_OE_CTRL, GPCLK_OE_CTRL),
> > +       regmap_reg_range(CLK_SYS_CTRL, CLK_SYS_DIV_INT),
> > +       regmap_reg_range(CLK_SYS_SEL, CLK_SYS_SEL),
> > +       regmap_reg_range(CLK_SLOW_SYS_CTRL, CLK_SLOW_SYS_DIV_INT),
> > +       regmap_reg_range(CLK_SLOW_SYS_SEL, CLK_SLOW_SYS_SEL),
> > +       regmap_reg_range(CLK_DMA_CTRL, CLK_DMA_DIV_INT),
> > +       regmap_reg_range(CLK_DMA_SEL, CLK_DMA_SEL),
> > +       regmap_reg_range(CLK_UART_CTRL, CLK_UART_DIV_INT),
> > +       regmap_reg_range(CLK_UART_SEL, CLK_UART_SEL),
> > +       regmap_reg_range(CLK_ETH_CTRL, CLK_ETH_DIV_INT),
> > +       regmap_reg_range(CLK_ETH_SEL, CLK_ETH_SEL),
> > +       regmap_reg_range(CLK_PWM0_CTRL, CLK_PWM0_SEL),
> > +       regmap_reg_range(CLK_PWM1_CTRL, CLK_PWM1_SEL),
> > +       regmap_reg_range(CLK_AUDIO_IN_CTRL, CLK_AUDIO_IN_DIV_INT),
> > +       regmap_reg_range(CLK_AUDIO_IN_SEL, CLK_AUDIO_IN_SEL),
> > +       regmap_reg_range(CLK_AUDIO_OUT_CTRL, CLK_AUDIO_OUT_DIV_INT),
> > +       regmap_reg_range(CLK_AUDIO_OUT_SEL, CLK_AUDIO_OUT_SEL),
> > +       regmap_reg_range(CLK_I2S_CTRL, CLK_I2S_DIV_INT),
> > +       regmap_reg_range(CLK_I2S_SEL, CLK_I2S_SEL),
> > +       regmap_reg_range(CLK_MIPI0_CFG_CTRL, CLK_MIPI0_CFG_DIV_INT),
> > +       regmap_reg_range(CLK_MIPI0_CFG_SEL, CLK_MIPI0_CFG_SEL),
> > +       regmap_reg_range(CLK_MIPI1_CFG_CTRL, CLK_MIPI1_CFG_DIV_INT),
> > +       regmap_reg_range(CLK_MIPI1_CFG_SEL, CLK_MIPI1_CFG_SEL),
> > +       regmap_reg_range(CLK_PCIE_AUX_CTRL, CLK_PCIE_AUX_DIV_INT),
> > +       regmap_reg_range(CLK_PCIE_AUX_SEL, CLK_PCIE_AUX_SEL),
> > +       regmap_reg_range(CLK_USBH0_MICROFRAME_CTRL, CLK_USBH0_MICROFRAME_DIV_INT),
> > +       regmap_reg_range(CLK_USBH0_MICROFRAME_SEL, CLK_USBH0_MICROFRAME_SEL),
> > +       regmap_reg_range(CLK_USBH1_MICROFRAME_CTRL, CLK_USBH1_MICROFRAME_DIV_INT),
> > +       regmap_reg_range(CLK_USBH1_MICROFRAME_SEL, CLK_USBH1_MICROFRAME_SEL),
> > +       regmap_reg_range(CLK_USBH0_SUSPEND_CTRL, CLK_USBH0_SUSPEND_DIV_INT),
> > +       regmap_reg_range(CLK_USBH0_SUSPEND_SEL, CLK_USBH0_SUSPEND_SEL),
> > +       regmap_reg_range(CLK_USBH1_SUSPEND_CTRL, CLK_USBH1_SUSPEND_DIV_INT),
> > +       regmap_reg_range(CLK_USBH1_SUSPEND_SEL, CLK_USBH1_SUSPEND_SEL),
> > +       regmap_reg_range(CLK_ETH_TSU_CTRL, CLK_ETH_TSU_DIV_INT),
> > +       regmap_reg_range(CLK_ETH_TSU_SEL, CLK_ETH_TSU_SEL),
> > +       regmap_reg_range(CLK_ADC_CTRL, CLK_ADC_DIV_INT),
> > +       regmap_reg_range(CLK_ADC_SEL, CLK_ADC_SEL),
> > +       regmap_reg_range(CLK_SDIO_TIMER_CTRL, CLK_SDIO_TIMER_DIV_INT),
> > +       regmap_reg_range(CLK_SDIO_TIMER_SEL, CLK_SDIO_TIMER_SEL),
> > +       regmap_reg_range(CLK_SDIO_ALT_SRC_CTRL, CLK_SDIO_ALT_SRC_DIV_INT),
> > +       regmap_reg_range(CLK_SDIO_ALT_SRC_SEL, CLK_SDIO_ALT_SRC_SEL),
> > +       regmap_reg_range(CLK_GP0_CTRL, CLK_GP0_SEL),
> > +       regmap_reg_range(CLK_GP1_CTRL, CLK_GP1_SEL),
> > +       regmap_reg_range(CLK_GP2_CTRL, CLK_GP2_SEL),
> > +       regmap_reg_range(CLK_GP3_CTRL, CLK_GP3_SEL),
> > +       regmap_reg_range(CLK_GP4_CTRL, CLK_GP4_SEL),
> > +       regmap_reg_range(CLK_GP5_CTRL, CLK_GP5_SEL),
> > +       regmap_reg_range(CLK_SYS_RESUS_CTRL, CLK_SYS_RESUS_CTRL),
> > +       regmap_reg_range(CLK_SLOW_SYS_RESUS_CTRL, CLK_SLOW_SYS_RESUS_CTRL),
> > +       regmap_reg_range(FC0_REF_KHZ, FC0_RESULT),
> > +       regmap_reg_range(VIDEO_CLK_VEC_CTRL, VIDEO_CLK_VEC_DIV_INT),
> > +       regmap_reg_range(VIDEO_CLK_VEC_SEL, VIDEO_CLK_DPI_DIV_INT),
> > +       regmap_reg_range(VIDEO_CLK_DPI_SEL, VIDEO_CLK_MIPI1_DPI_SEL),
> > +};
> > +
> > +static const struct regmap_access_table rp1_reg_table = {
> > +       .yes_ranges = rp1_reg_ranges,
> > +       .n_yes_ranges = ARRAY_SIZE(rp1_reg_ranges),
> > +};
> > +
> > +static const struct regmap_config rp1_clk_regmap_cfg = {
> > +       .reg_bits = 32,
> > +       .val_bits = 32,
> > +       .reg_stride = 4,
> > +       .max_register = PLL_VIDEO_SEC,
> > +       .name = "rp1-clk",
> > +       .rd_table = &rp1_reg_table,
> > +};
> > +
> > +static int rp1_clk_probe(struct platform_device *pdev)
> > +{
> > +       const size_t asize = ARRAY_SIZE(clk_desc_array);
> > +       struct rp1_clk_desc *desc;
> > +       struct device *dev = &pdev->dev;
> > +       struct rp1_clockman *clockman;
> > +       struct clk_hw **hws;
> > +       unsigned int i;
> > +
> > +       clockman = devm_kzalloc(dev, struct_size(clockman, onecell.hws, asize),
> > +                               GFP_KERNEL);
> > +       if (!clockman)
> > +               return -ENOMEM;
> > +
> > +       spin_lock_init(&clockman->regs_lock);
> > +       clockman->dev = dev;
> > +
> > +       clockman->regs = devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(clockman->regs))
> > +               return PTR_ERR(clockman->regs);
> > +
> > +       clockman->regmap = devm_regmap_init_mmio(dev, clockman->regs,
> > +                                                &rp1_clk_regmap_cfg);
> > +       if (IS_ERR(clockman->regmap)) {
> > +               dev_err(dev, "could not init clock regmap\n");
> 
> return dev_err_probe()?

Ack.

Many thanks,
Andrea

> 
> > +               return PTR_ERR(clockman->regmap);
> > +       }
> > +
> > +       clockman->onecell.num = asize;
> > +       hws = clockman->onecell.hws;
> > +
> > +       for (i = 0; i < asize; i++) {
> > +               desc = &clk_desc_array[i];
> > +               if (desc->clk_register && desc->data) {
> > +                       hws[i] = desc->clk_register(clockman, desc);
> > +                       if (IS_ERR_OR_NULL(hws[i]))
> > +                               dev_err_probe(dev, PTR_ERR(hws[i]),
> > +                                             "Unable to register clock: %s\n",
> > +                                             clk_hw_get_name(hws[i]));
> > +               }
> > +       }
> > +
> > +       platform_set_drvdata(pdev, clockman);
> > +
> > +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> > +                                          &clockman->onecell);
> > +}

