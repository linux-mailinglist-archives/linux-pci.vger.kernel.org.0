Return-Path: <linux-pci+bounces-15501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E86F9B3DA4
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 23:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F353F1F220E8
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 22:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BE01EE00D;
	Mon, 28 Oct 2024 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eThQFJzq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E618B463;
	Mon, 28 Oct 2024 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154058; cv=none; b=XGl0qoG8JNZsBPHOjSBhYY3BGfhSj13wXyJJwoRwIHmS9YJu/Q7fYIYfSl40pOAN9z0TU/zqu+C+UjStHR4w4202js5QtwCvexZs/jnWbWHQ/YsmzBoVtyhf5+HW99B5rTQLdvdbotl+VL6eD6MQID0wN1HNWLRxicVD3sewGvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154058; c=relaxed/simple;
	bh=WMRYUcLavYqTE8EbUvXmi+7VuPnEgFChTWF8ent1nGs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=MyQu5GcdvuKlO4zkLrMIVkTEZ0H5hluN9qY41xhe4jIuocGSqD1E/blmFA72qfqdx+Kevu/fOGtmIRMki9ap2Sa5kxR3281pKa3ncUAt4pVfdXUhI81XFn9jS9fLWWzI1VqGXWGhG+v8b2ccHdP0lrUsPYLJVhRPDd+gB2VEcL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eThQFJzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4936AC4CEC3;
	Mon, 28 Oct 2024 22:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730154057;
	bh=WMRYUcLavYqTE8EbUvXmi+7VuPnEgFChTWF8ent1nGs=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=eThQFJzqw1ihWb+jcjbbv5tNbStxcjfWnv+sE1PVK0ANUT1lH/q9Mn6WxDQQ+/6JZ
	 VBmceCKdEu7m128vPrRKJUelwViykA4O2zK7/x4uKHmh0BmNgMj1wzUk2nSERxgb6l
	 hTPOa7JsojXTp2SYwroHEOT1Qog1P4xHsmEaPim343KqkTjCGmVuLlgCNr4UczWWlT
	 c7h++mBHrr21zIPvwuOw80ZjMj0K4P7HKabfrF04O7A3Hrc3gjHoAh8M1v6BzlG70r
	 xvpZ04g54Z7Aiwcq8RD2BoJ/rpJo18eiHAYerKKgZQ9LKa96ghuhyzmahp3fkHx7LN
	 8FxGG+Ea6U5Cw==
Message-ID: <01c2bb3609dcb32191a78293c1666b0a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c20e3d6d87c71691b149cdeeafc94009953346b2.1730123575.git.andrea.porta@suse.com>
References: <cover.1730123575.git.andrea.porta@suse.com> <c20e3d6d87c71691b149cdeeafc94009953346b2.1730123575.git.andrea.porta@suse.com>
Subject: Re: [PATCH v3 07/12] clk: rp1: Add support for clocks provided by RP1
From: Stephen Boyd <sboyd@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herve Codina <herve.codina@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, Linus Walleij <linus.walleij@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Masahiro Yamada <masahiroy@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Stefan Wahren <wahr
 enst@gmx.net>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Date: Mon, 28 Oct 2024 15:20:55 -0700
User-Agent: alot/0.10

Quoting Andrea della Porta (2024-10-28 07:07:24)
> diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> new file mode 100644
> index 000000000000..69b9cf037cb2
> --- /dev/null
[...]
> +
> +struct rp1_clockman {
> +       struct device *dev;
> +       void __iomem *regs;

Do you still need this if there's a regmap?

> +       struct regmap *regmap;
> +       spinlock_t regs_lock; /* spinlock for all clocks */

Do you need this or is the spinlock in the regmap sufficient?

> +
> +       /* Must be last */
> +       struct clk_hw_onecell_data onecell;
> +};
> +
> +struct rp1_pll_core_data {
> +       const char *name;

These 'name' members can move to clk_init_data?

> +       u32 cs_reg;
> +       u32 pwr_reg;
> +       u32 fbdiv_int_reg;
> +       u32 fbdiv_frac_reg;
> +       unsigned long flags;

And probably flags as well? It seems like clk_init_data should be
declared at the same time as struct rp1_pll_core_data is.

> +       u32 fc0_src;
> +};
> +
> +struct rp1_pll_data {
> +       const char *name;
> +       u32 ctrl_reg;
> +       unsigned long flags;
> +       u32 fc0_src;
> +};
> +
> +struct rp1_pll_ph_data {
> +       const char *name;
> +       unsigned int phase;
> +       unsigned int fixed_divider;
> +       u32 ph_reg;
> +       unsigned long flags;
> +       u32 fc0_src;
> +};
> +
> +struct rp1_pll_divider_data {
> +       const char *name;
> +       u32 sec_reg;
> +       unsigned long flags;
> +       u32 fc0_src;
> +};
> +
> +struct rp1_clock_data {
> +       const char *name;
> +       int num_std_parents;
> +       int num_aux_parents;
> +       unsigned long flags;
> +       u32 oe_mask;
> +       u32 clk_src_mask;
> +       u32 ctrl_reg;
> +       u32 div_int_reg;
> +       u32 div_frac_reg;
> +       u32 sel_reg;
> +       u32 div_int_max;
> +       unsigned long max_freq;
> +       u32 fc0_src;
> +};
> +
> +struct rp1_clk_desc {
> +       struct clk_hw *(*clk_register)(struct rp1_clockman *clockman,
> +                                      struct rp1_clk_desc *desc);
> +       const void *data;
> +       struct clk_hw hw;
> +       struct rp1_clockman *clockman;
> +       unsigned long cached_rate;
> +       struct clk_divider div;
> +};
> +
> +#define FIELD_SET(_reg, _mask, _val)           \
> +do {                                           \
> +       u32 mask =3D (_mask);                     \
> +       (_reg) &=3D ~mask;                        \
> +       (_reg) |=3D FIELD_PREP(mask, (_val));     \

Please just write

	reg &=3D ~mask
	reg |=3D FIELD_PREP(mask, val);

instead of using this macro.

> +} while (0)
> +
> +
[...]
> +
> +static struct clk_hw *rp1_register_pll_core(struct rp1_clockman *clockma=
n,
> +                                           struct rp1_clk_desc *desc)
> +{
> +       const struct rp1_pll_core_data *pll_core_data =3D desc->data;
> +       struct clk_init_data init =3D { };
> +       int ret;
> +
> +       /* All of the PLL cores derive from the external oscillator. */
> +       init.parent_data =3D desc->hw.init->parent_data;
> +       init.num_parents =3D desc->hw.init->num_parents;
> +       init.name =3D pll_core_data->name;
> +       init.ops =3D &rp1_pll_core_ops;
> +       init.flags =3D pll_core_data->flags | CLK_IGNORE_UNUSED | CLK_IS_=
CRITICAL;
> +
> +       desc->clockman =3D clockman;
> +       desc->hw.init =3D &init;
> +
> +       ret =3D devm_clk_hw_register(clockman->dev, &desc->hw);
> +
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &desc->hw;
> +}
> +
> +static struct clk_hw *rp1_register_pll(struct rp1_clockman *clockman,
> +                                      struct rp1_clk_desc *desc)
> +{
> +       const struct rp1_pll_data *pll_data =3D desc->data;
> +       struct clk_init_data init =3D { };
> +       int ret;
> +
> +       init.parent_data =3D desc->hw.init->parent_data;
> +       init.num_parents =3D desc->hw.init->num_parents;
> +       init.name =3D pll_data->name;
> +       init.ops =3D &rp1_pll_ops;
> +       init.flags =3D pll_data->flags | CLK_IGNORE_UNUSED | CLK_IS_CRITI=
CAL;
> +
> +       desc->clockman =3D clockman;
> +       desc->hw.init =3D &init;
> +
> +       ret =3D devm_clk_hw_register(clockman->dev, &desc->hw);
> +
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &desc->hw;
> +}
> +
> +static struct clk_hw *rp1_register_pll_ph(struct rp1_clockman *clockman,
> +                                         struct rp1_clk_desc *desc)
> +{
> +       const struct rp1_pll_ph_data *ph_data =3D desc->data;
> +       struct clk_init_data init =3D { };
> +       int ret;
> +
> +       init.parent_data =3D desc->hw.init->parent_data;
> +       init.num_parents =3D desc->hw.init->num_parents;
> +       init.name =3D ph_data->name;
> +       init.ops =3D &rp1_pll_ph_ops;
> +       init.flags =3D ph_data->flags | CLK_IGNORE_UNUSED;
> +
> +       desc->clockman =3D clockman;
> +       desc->hw.init =3D &init;
> +
> +       ret =3D devm_clk_hw_register(clockman->dev, &desc->hw);
> +
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &desc->hw;
> +}
> +
> +static struct clk_hw *rp1_register_pll_divider(struct rp1_clockman *cloc=
kman,
> +                                              struct rp1_clk_desc *desc)
> +{
> +       const struct rp1_pll_data *divider_data =3D desc->data;
> +       struct clk_init_data init =3D { };
> +       int ret;
> +
> +       init.parent_data =3D desc->hw.init->parent_data;
> +       init.num_parents =3D desc->hw.init->num_parents;
> +       init.name =3D divider_data->name;
> +       init.ops =3D &rp1_pll_divider_ops;
> +       init.flags =3D divider_data->flags | CLK_IGNORE_UNUSED | CLK_IS_C=
RITICAL;
> +
> +       desc->div.reg =3D clockman->regs + divider_data->ctrl_reg;

Why is 'regs' used here? Isn't everything using a regmap now so it's all
offsets?

> +       desc->div.shift =3D PLL_SEC_DIV_SHIFT;
> +       desc->div.width =3D PLL_SEC_DIV_WIDTH;
> +       desc->div.flags =3D CLK_DIVIDER_ROUND_CLOSEST;
> +       desc->div.flags |=3D CLK_IS_CRITICAL;
> +       desc->div.lock =3D &clockman->regs_lock;
> +       desc->div.hw.init =3D &init;
> +       desc->div.table =3D pll_sec_div_table;
> +
> +       desc->clockman =3D clockman;
> +
> +       ret =3D devm_clk_hw_register(clockman->dev, &desc->div.hw);
> +
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &desc->div.hw;
> +}
> +
> +static struct clk_hw *rp1_register_clock(struct rp1_clockman *clockman,
> +                                        struct rp1_clk_desc *desc)
> +{
> +       const struct rp1_clock_data *clock_data =3D desc->data;
> +       struct clk_init_data init =3D { };
> +       int ret;
> +
> +       if (WARN_ON_ONCE(MAX_CLK_PARENTS <
> +              clock_data->num_std_parents + clock_data->num_aux_parents))
> +               return NULL;
> +
> +       /* There must be a gap for the AUX selector */
> +       if (WARN_ON_ONCE(clock_data->num_std_parents > AUX_SEL &&
> +                        desc->hw.init->parent_data[AUX_SEL].index !=3D -=
1))
> +               return NULL;
> +
> +       init.parent_data =3D desc->hw.init->parent_data;
> +       init.num_parents =3D desc->hw.init->num_parents;
> +       init.name =3D clock_data->name;
> +       init.flags =3D clock_data->flags | CLK_IGNORE_UNUSED;
> +       init.ops =3D &rp1_clk_ops;
> +
> +       desc->clockman =3D clockman;
> +       desc->hw.init =3D &init;
> +
> +       ret =3D devm_clk_hw_register(clockman->dev, &desc->hw);
> +
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &desc->hw;
> +}
> +
> +/* Assignment helper macros for different clock types. */
> +#define _REGISTER(f, ...)      { .clk_register =3D f, __VA_ARGS__ }
> +
> +#define PARENT_CLK(pnum, ...)  .hw.init =3D &(const struct clk_init_data=
) { \

Instead of this macro just use CLK_HW_INIT_HW() or
CLK_HW_INIT_PARENTS_DATA()?

> +                               .parent_data =3D (const struct           =
    \
> +                                               clk_parent_data[]) {     =
  \
> +                                                       __VA_ARGS__      =
  \
> +                                               },                       =
  \
> +                               .num_parents =3D pnum }
> +
> +#define CLK_DATA(type, ...)    .data =3D &(struct type) { __VA_ARGS__ }
> +
> +#define REGISTER_PLL_CORE(...) _REGISTER(&rp1_register_pll_core,       \
> +                                         __VA_ARGS__)
> +
> +#define REGISTER_PLL(...)      _REGISTER(&rp1_register_pll,            \
> +                                         __VA_ARGS__)
> +
> +#define REGISTER_PLL_PH(...)   _REGISTER(&rp1_register_pll_ph,         \
> +                                         __VA_ARGS__)
> +
> +#define REGISTER_PLL_DIV(...)  _REGISTER(&rp1_register_pll_divider,    \
> +                                         __VA_ARGS__)
> +
> +#define REGISTER_CLK(...)      _REGISTER(&rp1_register_clock,          \
> +                                         __VA_ARGS__)
> +
> +static struct rp1_clk_desc clk_desc_array[] =3D {
> +       [RP1_PLL_SYS_CORE] =3D REGISTER_PLL_CORE(PARENT_CLK(1, { .index =
=3D 0 }),
> +                               CLK_DATA(rp1_pll_core_data,
> +                                        .name =3D "pll_sys_core",
> +                                        .cs_reg =3D PLL_SYS_CS,
> +                                        .pwr_reg =3D PLL_SYS_PWR,
> +                                        .fbdiv_int_reg =3D PLL_SYS_FBDIV=
_INT,
> +                                        .fbdiv_frac_reg =3D PLL_SYS_FBDI=
V_FRAC,
> +                               )),
> +
> +       [RP1_PLL_AUDIO_CORE] =3D REGISTER_PLL_CORE(PARENT_CLK(1, { .index=
 =3D 0 }),
> +                               CLK_DATA(rp1_pll_core_data,
> +                                        .name =3D "pll_audio_core",
> +                                        .cs_reg =3D PLL_AUDIO_CS,
> +                                        .pwr_reg =3D PLL_AUDIO_PWR,
> +                                        .fbdiv_int_reg =3D PLL_AUDIO_FBD=
IV_INT,
> +                                        .fbdiv_frac_reg =3D PLL_AUDIO_FB=
DIV_FRAC,
> +                               )),
> +
> +       [RP1_PLL_VIDEO_CORE] =3D REGISTER_PLL_CORE(PARENT_CLK(1, { .index=
 =3D 0 }),
> +                               CLK_DATA(rp1_pll_core_data,
> +                                        .name =3D "pll_video_core",
> +                                        .cs_reg =3D PLL_VIDEO_CS,
> +                                        .pwr_reg =3D PLL_VIDEO_PWR,
> +                                        .fbdiv_int_reg =3D PLL_VIDEO_FBD=
IV_INT,
> +                                        .fbdiv_frac_reg =3D PLL_VIDEO_FB=
DIV_FRAC,
> +                               )),
> +
> +       [RP1_PLL_SYS] =3D REGISTER_PLL(PARENT_CLK(1,
> +                               { .hw =3D &clk_desc_array[RP1_PLL_SYS_COR=
E].hw }
> +                               ),
> +                               CLK_DATA(rp1_pll_data,
> +                                        .name =3D "pll_sys",
> +                                        .ctrl_reg =3D PLL_SYS_PRIM,
> +                                        .fc0_src =3D FC_NUM(0, 2),
> +                               )),
> +
> +       [RP1_CLK_ETH_TSU] =3D REGISTER_CLK(PARENT_CLK(1, { .index =3D 0 }=
),
> +                               CLK_DATA(rp1_clock_data,
> +                                        .name =3D "clk_eth_tsu",
> +                                        .num_std_parents =3D 0,
> +                                        .num_aux_parents =3D 1,
> +                                        .ctrl_reg =3D CLK_ETH_TSU_CTRL,
> +                                        .div_int_reg =3D CLK_ETH_TSU_DIV=
_INT,
> +                                        .sel_reg =3D CLK_ETH_TSU_SEL,
> +                                        .div_int_max =3D DIV_INT_8BIT_MA=
X,
> +                                        .max_freq =3D 50 * HZ_PER_MHZ,
> +                                        .fc0_src =3D FC_NUM(5, 7),
> +                               )),
> +
> +       [RP1_CLK_SYS] =3D REGISTER_CLK(PARENT_CLK(3,
> +                               { .index =3D 0 },
> +                               { .index =3D -1 },
> +                               { .hw =3D &clk_desc_array[RP1_PLL_SYS].hw=
 }
> +                               ),
> +                               CLK_DATA(rp1_clock_data,
> +                                        .name =3D "clk_sys",
> +                                        .num_std_parents =3D 3,
> +                                        .num_aux_parents =3D 0,
> +                                        .ctrl_reg =3D CLK_SYS_CTRL,
> +                                        .div_int_reg =3D CLK_SYS_DIV_INT,
> +                                        .sel_reg =3D CLK_SYS_SEL,
> +                                        .div_int_max =3D DIV_INT_24BIT_M=
AX,
> +                                        .max_freq =3D 200 * HZ_PER_MHZ,
> +                                        .fc0_src =3D FC_NUM(0, 4),
> +                                        .clk_src_mask =3D 0x3,
> +                               )),
> +
> +       [RP1_PLL_SYS_PRI_PH] =3D REGISTER_PLL_PH(PARENT_CLK(1,
> +                               { .hw =3D &clk_desc_array[RP1_PLL_SYS].hw=
 }
> +                               ),
> +                               CLK_DATA(rp1_pll_ph_data,
> +                                        .name =3D "pll_sys_pri_ph",
> +                                        .ph_reg =3D PLL_SYS_PRIM,
> +                                        .fixed_divider =3D 2,
> +                                        .phase =3D RP1_PLL_PHASE_0,
> +                                        .fc0_src =3D FC_NUM(1, 2),
> +                               )),
> +
> +       [RP1_PLL_SYS_SEC] =3D REGISTER_PLL_DIV(PARENT_CLK(1,
> +                               { .hw =3D &clk_desc_array[RP1_PLL_SYS_COR=
E].hw }
> +                               ),
> +                               CLK_DATA(rp1_pll_data,
> +                                        .name =3D "pll_sys_sec",
> +                                        .ctrl_reg =3D PLL_SYS_SEC,
> +                                        .fc0_src =3D FC_NUM(2, 2),
> +                               )),
> +};
> +
> +static const struct regmap_range rp1_reg_ranges[] =3D {
> +       regmap_reg_range(PLL_SYS_CS, PLL_SYS_SEC),
> +       regmap_reg_range(PLL_AUDIO_CS, PLL_AUDIO_TERN),
> +       regmap_reg_range(PLL_VIDEO_CS, PLL_VIDEO_SEC),
> +       regmap_reg_range(GPCLK_OE_CTRL, GPCLK_OE_CTRL),
> +       regmap_reg_range(CLK_SYS_CTRL, CLK_SYS_DIV_INT),
> +       regmap_reg_range(CLK_SYS_SEL, CLK_SYS_SEL),
> +       regmap_reg_range(CLK_SLOW_SYS_CTRL, CLK_SLOW_SYS_DIV_INT),
> +       regmap_reg_range(CLK_SLOW_SYS_SEL, CLK_SLOW_SYS_SEL),
> +       regmap_reg_range(CLK_DMA_CTRL, CLK_DMA_DIV_INT),
> +       regmap_reg_range(CLK_DMA_SEL, CLK_DMA_SEL),
> +       regmap_reg_range(CLK_UART_CTRL, CLK_UART_DIV_INT),
> +       regmap_reg_range(CLK_UART_SEL, CLK_UART_SEL),
> +       regmap_reg_range(CLK_ETH_CTRL, CLK_ETH_DIV_INT),
> +       regmap_reg_range(CLK_ETH_SEL, CLK_ETH_SEL),
> +       regmap_reg_range(CLK_PWM0_CTRL, CLK_PWM0_SEL),
> +       regmap_reg_range(CLK_PWM1_CTRL, CLK_PWM1_SEL),
> +       regmap_reg_range(CLK_AUDIO_IN_CTRL, CLK_AUDIO_IN_DIV_INT),
> +       regmap_reg_range(CLK_AUDIO_IN_SEL, CLK_AUDIO_IN_SEL),
> +       regmap_reg_range(CLK_AUDIO_OUT_CTRL, CLK_AUDIO_OUT_DIV_INT),
> +       regmap_reg_range(CLK_AUDIO_OUT_SEL, CLK_AUDIO_OUT_SEL),
> +       regmap_reg_range(CLK_I2S_CTRL, CLK_I2S_DIV_INT),
> +       regmap_reg_range(CLK_I2S_SEL, CLK_I2S_SEL),
> +       regmap_reg_range(CLK_MIPI0_CFG_CTRL, CLK_MIPI0_CFG_DIV_INT),
> +       regmap_reg_range(CLK_MIPI0_CFG_SEL, CLK_MIPI0_CFG_SEL),
> +       regmap_reg_range(CLK_MIPI1_CFG_CTRL, CLK_MIPI1_CFG_DIV_INT),
> +       regmap_reg_range(CLK_MIPI1_CFG_SEL, CLK_MIPI1_CFG_SEL),
> +       regmap_reg_range(CLK_PCIE_AUX_CTRL, CLK_PCIE_AUX_DIV_INT),
> +       regmap_reg_range(CLK_PCIE_AUX_SEL, CLK_PCIE_AUX_SEL),
> +       regmap_reg_range(CLK_USBH0_MICROFRAME_CTRL, CLK_USBH0_MICROFRAME_=
DIV_INT),
> +       regmap_reg_range(CLK_USBH0_MICROFRAME_SEL, CLK_USBH0_MICROFRAME_S=
EL),
> +       regmap_reg_range(CLK_USBH1_MICROFRAME_CTRL, CLK_USBH1_MICROFRAME_=
DIV_INT),
> +       regmap_reg_range(CLK_USBH1_MICROFRAME_SEL, CLK_USBH1_MICROFRAME_S=
EL),
> +       regmap_reg_range(CLK_USBH0_SUSPEND_CTRL, CLK_USBH0_SUSPEND_DIV_IN=
T),
> +       regmap_reg_range(CLK_USBH0_SUSPEND_SEL, CLK_USBH0_SUSPEND_SEL),
> +       regmap_reg_range(CLK_USBH1_SUSPEND_CTRL, CLK_USBH1_SUSPEND_DIV_IN=
T),
> +       regmap_reg_range(CLK_USBH1_SUSPEND_SEL, CLK_USBH1_SUSPEND_SEL),
> +       regmap_reg_range(CLK_ETH_TSU_CTRL, CLK_ETH_TSU_DIV_INT),
> +       regmap_reg_range(CLK_ETH_TSU_SEL, CLK_ETH_TSU_SEL),
> +       regmap_reg_range(CLK_ADC_CTRL, CLK_ADC_DIV_INT),
> +       regmap_reg_range(CLK_ADC_SEL, CLK_ADC_SEL),
> +       regmap_reg_range(CLK_SDIO_TIMER_CTRL, CLK_SDIO_TIMER_DIV_INT),
> +       regmap_reg_range(CLK_SDIO_TIMER_SEL, CLK_SDIO_TIMER_SEL),
> +       regmap_reg_range(CLK_SDIO_ALT_SRC_CTRL, CLK_SDIO_ALT_SRC_DIV_INT),
> +       regmap_reg_range(CLK_SDIO_ALT_SRC_SEL, CLK_SDIO_ALT_SRC_SEL),
> +       regmap_reg_range(CLK_GP0_CTRL, CLK_GP0_SEL),
> +       regmap_reg_range(CLK_GP1_CTRL, CLK_GP1_SEL),
> +       regmap_reg_range(CLK_GP2_CTRL, CLK_GP2_SEL),
> +       regmap_reg_range(CLK_GP3_CTRL, CLK_GP3_SEL),
> +       regmap_reg_range(CLK_GP4_CTRL, CLK_GP4_SEL),
> +       regmap_reg_range(CLK_GP5_CTRL, CLK_GP5_SEL),
> +       regmap_reg_range(CLK_SYS_RESUS_CTRL, CLK_SYS_RESUS_CTRL),
> +       regmap_reg_range(CLK_SLOW_SYS_RESUS_CTRL, CLK_SLOW_SYS_RESUS_CTRL=
),
> +       regmap_reg_range(FC0_REF_KHZ, FC0_RESULT),
> +       regmap_reg_range(VIDEO_CLK_VEC_CTRL, VIDEO_CLK_VEC_DIV_INT),
> +       regmap_reg_range(VIDEO_CLK_VEC_SEL, VIDEO_CLK_DPI_DIV_INT),
> +       regmap_reg_range(VIDEO_CLK_DPI_SEL, VIDEO_CLK_MIPI1_DPI_SEL),
> +};
> +
> +static const struct regmap_access_table rp1_reg_table =3D {
> +       .yes_ranges =3D rp1_reg_ranges,
> +       .n_yes_ranges =3D ARRAY_SIZE(rp1_reg_ranges),
> +};
> +
> +static const struct regmap_config rp1_clk_regmap_cfg =3D {
> +       .reg_bits =3D 32,
> +       .val_bits =3D 32,
> +       .reg_stride =3D 4,
> +       .max_register =3D PLL_VIDEO_SEC,
> +       .name =3D "rp1-clk",
> +       .rd_table =3D &rp1_reg_table,
> +};
> +
> +static int rp1_clk_probe(struct platform_device *pdev)
> +{
> +       const size_t asize =3D ARRAY_SIZE(clk_desc_array);
> +       struct rp1_clk_desc *desc;
> +       struct device *dev =3D &pdev->dev;
> +       struct rp1_clockman *clockman;
> +       struct clk_hw **hws;
> +       unsigned int i;
> +
> +       clockman =3D devm_kzalloc(dev, struct_size(clockman, onecell.hws,=
 asize),
> +                               GFP_KERNEL);
> +       if (!clockman)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&clockman->regs_lock);
> +       clockman->dev =3D dev;
> +
> +       clockman->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(clockman->regs))
> +               return PTR_ERR(clockman->regs);
> +
> +       clockman->regmap =3D devm_regmap_init_mmio(dev, clockman->regs,
> +                                                &rp1_clk_regmap_cfg);
> +       if (IS_ERR(clockman->regmap)) {
> +               dev_err(dev, "could not init clock regmap\n");

return dev_err_probe()?

> +               return PTR_ERR(clockman->regmap);
> +       }
> +
> +       clockman->onecell.num =3D asize;
> +       hws =3D clockman->onecell.hws;
> +
> +       for (i =3D 0; i < asize; i++) {
> +               desc =3D &clk_desc_array[i];
> +               if (desc->clk_register && desc->data) {
> +                       hws[i] =3D desc->clk_register(clockman, desc);
> +                       if (IS_ERR_OR_NULL(hws[i]))
> +                               dev_err_probe(dev, PTR_ERR(hws[i]),
> +                                             "Unable to register clock: =
%s\n",
> +                                             clk_hw_get_name(hws[i]));
> +               }
> +       }
> +
> +       platform_set_drvdata(pdev, clockman);
> +
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                          &clockman->onecell);
> +}

