Return-Path: <linux-pci+bounces-27397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72420AAEC9C
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 22:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4AF1BC2610
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 20:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C4E1C5D5A;
	Wed,  7 May 2025 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6mwlKtE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44EF1A8F6D;
	Wed,  7 May 2025 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648087; cv=none; b=jIXWjTNiNJ/Uo03TqXCw+QBY58S7MqjdqEC9lz3YdMsbbm7RWzDrkcARxcLpn3Vx0ValBc2IgqjbB9Gn7g9QCDzyoSywDvaWRgU2uQpXBMYbhgmEvW8sho5qXd8xvFEWp9bowoen+IeJ+d+fTWsNvmW1TTueRB7xeXdq9Ix8bpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648087; c=relaxed/simple;
	bh=Ff/FoBwD94frMQpQAKcW8OUQEHCvCrShjHu7nQ/zEUU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=JOsdjTBYVSkeHV+cUY5Hfr66Kav+cP4Dpd8udUVDdxY5ciZ2Lx7RriArUMHRzFYyMcZSvmzfcGwt5ZTG2LLpqbOJ/jAz5nPNNtqcXwsT68gCOgtig/QfA883Mvs1BcjOSOas0JX7e7RfEFc0Slmpw1Z1T6rZPf7gxF5GK2KgDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6mwlKtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D76C4CEE2;
	Wed,  7 May 2025 20:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746648086;
	bh=Ff/FoBwD94frMQpQAKcW8OUQEHCvCrShjHu7nQ/zEUU=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=k6mwlKtEnhp9oBjormtnSuzXWBIqfDBZB6Sbg+9jQypLYFK/VDsrwU3RplkAhg9/A
	 Kju9Mxs/flthTRfsSlpVmIqdFsTJPyTTIAJmUJKBJcCwHnTUpeX4nsps0ptgOHuK8c
	 jpBKxDqlVhETqg5jKoMSClJQOsl0ZucniFjeypUJQPopBxeFU+Fr8SA0/nWWU1v6kc
	 2KeroGsDeGys6pcQRST70STBFh5Vf9llr6D0qSSZ1/N/qy8pOt1PhIcTqiU5ymJmmg
	 qyMIV9EM3Znstrf8r8N+p9tZAGJitFXZSR5V7Jlt+n635heXgug+1CSvAzYKxaVs7U
	 2CvqH/gFoCHnw==
Message-ID: <a61159b7b34c29323cdc428bb34acfa1@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e8a9c2cd6b4b2af8038048cda179ebbf70891ba7.1745347417.git.andrea.porta@suse.com>
References: <cover.1745347417.git.andrea.porta@suse.com> <e8a9c2cd6b4b2af8038048cda179ebbf70891ba7.1745347417.git.andrea.porta@suse.com>
Subject: Re: [PATCH v9 -next 04/12] clk: rp1: Add support for clocks provided by RP1
From: Stephen Boyd <sboyd@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herve Codina <herve.codina@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, Linus Walleij <linus.walleij@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Masahiro Yamada <masahiroy@kernel.org>, Matthias Brugger <mbrugger@suse.com>, Michael Turquette <mturquette@baylibre.com>, Phi
 l Elwell <phil@raspberrypi.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Stefan Wahren <wahrenst@gmx.net>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 07 May 2025 13:01:24 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Andrea della Porta (2025-04-22 11:53:13)
> diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> new file mode 100644
> index 000000000000..6b0b76fc6977
> --- /dev/null
> +++ b/drivers/clk/clk-rp1.c
> @@ -0,0 +1,1510 @@
[...]
> +static u8 rp1_clock_get_parent(struct clk_hw *hw)
> +{
> +       struct rp1_clk_desc *clock =3D container_of(hw, struct rp1_clk_de=
sc, hw);
> +       struct rp1_clockman *clockman =3D clock->clockman;
> +       const struct rp1_clock_data *data =3D clock->data;
> +       u32 sel, ctrl;
> +       u8 parent;
> +
> +       /* Sel is one-hot, so find the first bit set */
> +       sel =3D clockman_read(clockman, data->sel_reg);
> +       parent =3D ffs(sel) - 1;
> +
> +       /* sel =3D=3D 0 implies the parent clock is not enabled yet. */
> +       if (!sel) {
> +               /* Read the clock src from the CTRL register instead */
> +               ctrl =3D clockman_read(clockman, data->ctrl_reg);
> +               parent =3D (ctrl & data->clk_src_mask) >> CLK_CTRL_SRC_SH=
IFT;
> +       }
> +
> +       if (parent >=3D data->num_std_parents)
> +               parent =3D AUX_SEL;
> +
> +       if (parent =3D=3D AUX_SEL) {
> +               /*
> +                * Clock parent is an auxiliary source, so get the parent=
 from
> +                * the AUXSRC register field.
> +                */
> +               ctrl =3D clockman_read(clockman, data->ctrl_reg);
> +               parent =3D FIELD_GET(CLK_CTRL_AUXSRC_MASK, ctrl);
> +               parent +=3D data->num_std_parents;
> +       }
> +
> +       return parent;
> +}
> +
> +static int rp1_clock_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct rp1_clk_desc *clock =3D container_of(hw, struct rp1_clk_de=
sc, hw);
> +       struct rp1_clockman *clockman =3D clock->clockman;
> +       const struct rp1_clock_data *data =3D clock->data;
> +       u32 ctrl, sel;
> +
> +       spin_lock(&clockman->regs_lock);
> +       ctrl =3D clockman_read(clockman, data->ctrl_reg);
> +
> +       if (index >=3D data->num_std_parents) {
> +               /* This is an aux source request */
> +               if (index >=3D data->num_std_parents + data->num_aux_pare=
nts) {
> +                       spin_unlock(&clockman->regs_lock);
> +                       return -EINVAL;
> +               }
> +
> +               /* Select parent from aux list */
> +               ctrl &=3D ~CLK_CTRL_AUXSRC_MASK;
> +               ctrl |=3D FIELD_PREP(CLK_CTRL_AUXSRC_MASK, index - data->=
num_std_parents);
> +               /* Set src to aux list */
> +               ctrl &=3D ~data->clk_src_mask;
> +               ctrl |=3D (AUX_SEL << CLK_CTRL_SRC_SHIFT) & data->clk_src=
_mask;
> +       } else {
> +               ctrl &=3D ~data->clk_src_mask;
> +               ctrl |=3D (index << CLK_CTRL_SRC_SHIFT) & data->clk_src_m=
ask;
> +       }
> +
> +       clockman_write(clockman, data->ctrl_reg, ctrl);
> +       spin_unlock(&clockman->regs_lock);
> +
> +       sel =3D rp1_clock_get_parent(hw);
> +       WARN_ONCE(sel !=3D index, "(%s): Parent index req %u returned bac=
k %u\n",
> +                 clk_hw_get_name(hw), index, sel);

Is this debug code? Why do we need to read back the parent here?

> +
> +       return 0;
> +}
> +
> +static int rp1_clock_set_rate_and_parent(struct clk_hw *hw,
> +                                        unsigned long rate,
> +                                        unsigned long parent_rate,
> +                                        u8 parent)
> +{
> +       struct rp1_clk_desc *clock =3D container_of(hw, struct rp1_clk_de=
sc, hw);
> +       struct rp1_clockman *clockman =3D clock->clockman;
> +       const struct rp1_clock_data *data =3D clock->data;
> +       u32 div =3D rp1_clock_choose_div(rate, parent_rate, data);
> +
> +       WARN_ONCE(rate > data->max_freq,
> +                 "(%s): Requested rate (%lu) > max rate (%lu)\n",
> +                 clk_hw_get_name(hw), rate, data->max_freq);

If the determine_rate function is implemented properly this is
impossible because we round the rate before calling this clk_op.

> +
> +       if (WARN_ONCE(!div,
> +                     "clk divider calculated as 0! (%s, rate %lu, parent=
 rate %lu)\n",
> +                     clk_hw_get_name(hw), rate, parent_rate))
> +               div =3D 1 << CLK_DIV_FRAC_BITS;

This one also looks weird, does it assume round_rate didn't constrain
the incoming rate?

> +
> +       spin_lock(&clockman->regs_lock);
> +
> +       clockman_write(clockman, data->div_int_reg, div >> CLK_DIV_FRAC_B=
ITS);
> +       if (data->div_frac_reg)
> +               clockman_write(clockman, data->div_frac_reg, div << (32 -=
 CLK_DIV_FRAC_BITS));
> +
> +       spin_unlock(&clockman->regs_lock);
> +
> +       if (parent !=3D 0xff)
> +               rp1_clock_set_parent(hw, parent);
> +
> +       return 0;
> +}
> +
> +static int rp1_clock_set_rate(struct clk_hw *hw, unsigned long rate,
> +                             unsigned long parent_rate)
> +{
> +       return rp1_clock_set_rate_and_parent(hw, rate, parent_rate, 0xff);
> +}
> +
> +static void rp1_clock_choose_div_and_prate(struct clk_hw *hw,
> +                                          int parent_idx,
> +                                          unsigned long rate,
> +                                          unsigned long *prate,
> +                                          unsigned long *calc_rate)
> +{
> +       struct rp1_clk_desc *clock =3D container_of(hw, struct rp1_clk_de=
sc, hw);
> +       const struct rp1_clock_data *data =3D clock->data;
> +       struct clk_hw *parent;
> +       u32 div;
> +       u64 tmp;
> +
> +       parent =3D clk_hw_get_parent_by_index(hw, parent_idx);
> +
> +       *prate =3D clk_hw_get_rate(parent);
> +       div =3D rp1_clock_choose_div(rate, *prate, data);
> +
> +       if (!div) {
> +               *calc_rate =3D 0;
> +               return;
> +       }
> +
> +       /* Recalculate to account for rounding errors */
> +       tmp =3D (u64)*prate << CLK_DIV_FRAC_BITS;
> +       tmp =3D div_u64(tmp, div);
> +
> +       /*
> +        * Prevent overclocks - if all parent choices result in
> +        * a downstream clock in excess of the maximum, then the
> +        * call to set the clock will fail.
> +        */
> +       if (tmp > data->max_freq)
> +               *calc_rate =3D 0;
> +       else
> +               *calc_rate =3D tmp;
> +}
> +
> +static int rp1_clock_determine_rate(struct clk_hw *hw,
> +                                   struct clk_rate_request *req)
> +{
> +       struct clk_hw *parent, *best_parent =3D NULL;
> +       unsigned long best_rate =3D 0;
> +       unsigned long best_prate =3D 0;
> +       unsigned long best_rate_diff =3D ULONG_MAX;
> +       unsigned long prate, calc_rate;
> +       size_t i;
> +
> +       /*
> +        * If the NO_REPARENT flag is set, try to use existing parent.
> +        */
> +       if ((clk_hw_get_flags(hw) & CLK_SET_RATE_NO_REPARENT)) {
> +               i =3D rp1_clock_get_parent(hw);
> +               parent =3D clk_hw_get_parent_by_index(hw, i);
> +               if (parent) {
> +                       rp1_clock_choose_div_and_prate(hw, i, req->rate, =
&prate,
> +                                                      &calc_rate);
> +                       if (calc_rate > 0) {
> +                               req->best_parent_hw =3D parent;
> +                               req->best_parent_rate =3D prate;
> +                               req->rate =3D calc_rate;
> +                               return 0;
> +                       }
> +               }
> +       }
> +
> +       /*
> +        * Select parent clock that results in the closest rate (lower or
> +        * higher)
> +        */
> +       for (i =3D 0; i < clk_hw_get_num_parents(hw); i++) {
> +               parent =3D clk_hw_get_parent_by_index(hw, i);
> +               if (!parent)
> +                       continue;
> +
> +               rp1_clock_choose_div_and_prate(hw, i, req->rate, &prate,
> +                                              &calc_rate);
> +
> +               if (abs_diff(calc_rate, req->rate) < best_rate_diff) {
> +                       best_parent =3D parent;
> +                       best_prate =3D prate;
> +                       best_rate =3D calc_rate;
> +                       best_rate_diff =3D abs_diff(calc_rate, req->rate);
> +
> +                       if (best_rate_diff =3D=3D 0)
> +                               break;
> +               }
> +       }
> +
> +       if (best_rate =3D=3D 0)
> +               return -EINVAL;
> +
> +       req->best_parent_hw =3D best_parent;
> +       req->best_parent_rate =3D best_prate;
> +       req->rate =3D best_rate;
> +
> +       return 0;
> +}
> +
> +static const struct clk_ops rp1_pll_core_ops =3D {
> +       .is_prepared =3D rp1_pll_core_is_on,
> +       .prepare =3D rp1_pll_core_on,
> +       .unprepare =3D rp1_pll_core_off,
> +       .set_rate =3D rp1_pll_core_set_rate,
> +       .recalc_rate =3D rp1_pll_core_recalc_rate,
> +       .round_rate =3D rp1_pll_core_round_rate,
> +};
> +
> +static const struct clk_ops rp1_pll_ops =3D {
> +       .set_rate =3D rp1_pll_set_rate,
> +       .recalc_rate =3D rp1_pll_recalc_rate,
> +       .round_rate =3D rp1_pll_round_rate,
> +};
> +
> +static const struct clk_ops rp1_pll_ph_ops =3D {
> +       .is_prepared =3D rp1_pll_ph_is_on,
> +       .prepare =3D rp1_pll_ph_on,
> +       .unprepare =3D rp1_pll_ph_off,
> +       .recalc_rate =3D rp1_pll_ph_recalc_rate,
> +       .round_rate =3D rp1_pll_ph_round_rate,
> +};
> +
> +static const struct clk_ops rp1_pll_divider_ops =3D {
> +       .is_prepared =3D rp1_pll_divider_is_on,
> +       .prepare =3D rp1_pll_divider_on,
> +       .unprepare =3D rp1_pll_divider_off,
> +       .set_rate =3D rp1_pll_divider_set_rate,
> +       .recalc_rate =3D rp1_pll_divider_recalc_rate,
> +       .round_rate =3D rp1_pll_divider_round_rate,
> +};
> +
> +static const struct clk_ops rp1_clk_ops =3D {
> +       .is_prepared =3D rp1_clock_is_on,
> +       .prepare =3D rp1_clock_on,
> +       .unprepare =3D rp1_clock_off,
> +       .recalc_rate =3D rp1_clock_recalc_rate,
> +       .get_parent =3D rp1_clock_get_parent,
> +       .set_parent =3D rp1_clock_set_parent,
> +       .set_rate_and_parent =3D rp1_clock_set_rate_and_parent,
> +       .set_rate =3D rp1_clock_set_rate,
> +       .determine_rate =3D rp1_clock_determine_rate,
> +};
> +
> +static struct clk_hw *rp1_register_pll(struct rp1_clockman *clockman,
> +                                      struct rp1_clk_desc *desc)
> +{
> +       int ret;
> +
> +       desc->clockman =3D clockman;
> +
> +       ret =3D devm_clk_hw_register(clockman->dev, &desc->hw);
> +

Please drop this newline.

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
> +       int ret;
> +
> +       desc->div.reg =3D clockman->regs + divider_data->ctrl_reg;
> +       desc->div.shift =3D __ffs(PLL_SEC_DIV_MASK);
> +       desc->div.width =3D __ffs(~(PLL_SEC_DIV_MASK >> desc->div.shift));
> +       desc->div.flags =3D CLK_DIVIDER_ROUND_CLOSEST;
> +       desc->div.lock =3D &clockman->regs_lock;
> +       desc->div.hw.init =3D desc->hw.init;
> +       desc->div.table =3D pll_sec_div_table;
> +
> +       desc->clockman =3D clockman;
> +
> +       ret =3D devm_clk_hw_register(clockman->dev, &desc->div.hw);
> +

Please drop this newline.

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
> +       int ret;
> +
> +       if (WARN_ON_ONCE(MAX_CLK_PARENTS <
> +              clock_data->num_std_parents + clock_data->num_aux_parents))
> +               return NULL;

Return an error pointer?

> +
> +       /* There must be a gap for the AUX selector */
> +       if (WARN_ON_ONCE(clock_data->num_std_parents > AUX_SEL &&
> +                        desc->hw.init->parent_data[AUX_SEL].index !=3D -=
1))

Why is there a gap? Can't the parents that the clk framework sees be

	[0, num_std_parents) + [num_std_parents, num_aux_parents + num_std_parents)

without an empty parent in the middle?

> +               return NULL;

Return an error pointer?

> +
> +       desc->clockman =3D clockman;
> +
> +       ret =3D devm_clk_hw_register(clockman->dev, &desc->hw);
> +

Drop this newline please.

> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &desc->hw;
> +}
[...]
> +
> +static const struct clk_parent_data clk_eth_parents[] =3D {
> +       { .hw =3D &pll_sys_sec_desc.div.hw },
> +       { .hw =3D &pll_sys_desc.hw },
> +};
> +
> +static struct rp1_clk_desc clk_eth_desc =3D REGISTER_CLK(
> +       .hw.init =3D CLK_HW_INIT_PARENTS_DATA(
> +               "clk_eth",
> +               clk_eth_parents,
> +               &rp1_clk_ops,
> +               0
> +       ),
> +       CLK_DATA(rp1_clock_data,
> +                .num_std_parents =3D 0,
> +                .num_aux_parents =3D 2,
> +                .ctrl_reg =3D CLK_ETH_CTRL,
> +                .div_int_reg =3D CLK_ETH_DIV_INT,
> +                .sel_reg =3D CLK_ETH_SEL,
> +                .div_int_max =3D DIV_INT_8BIT_MAX,
> +                .max_freq =3D 125 * HZ_PER_MHZ,
> +                .fc0_src =3D FC_NUM(4, 6),
> +       )
> +);
> +
> +static const struct clk_parent_data clk_sys_parents[] =3D {
> +       { .index =3D 0 },
> +       { .index =3D -1 },

Why is there a gap here?

> +       { .hw =3D &pll_sys_desc.hw },
> +};
> +
[...]
> +
> +static const struct regmap_config rp1_clk_regmap_cfg =3D {
> +       .reg_bits =3D 32,
> +       .val_bits =3D 32,
> +       .reg_stride =3D 4,
> +       .max_register =3D PLL_VIDEO_SEC,
> +       .name =3D "rp1-clk",
> +       .rd_table =3D &rp1_reg_table,

Do you want to set the 'disable_locking' field because you're
explicitly locking in this driver?

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
> +               dev_err_probe(dev, PTR_ERR(clockman->regmap),
> +                             "could not init clock regmap\n");
> +               return PTR_ERR(clockman->regmap);
> +       }
> +
> +       clockman->onecell.num =3D asize;
> +       hws =3D clockman->onecell.hws;
> +
> +       for (i =3D 0; i < asize; i++) {
> +               desc =3D clk_desc_array[i];
> +               if (desc && desc->clk_register && desc->data) {
> +                       hws[i] =3D desc->clk_register(clockman, desc);
> +                       if (IS_ERR_OR_NULL(hws[i]))

Why is NULL a possible return value?

> +                               dev_err_probe(dev, PTR_ERR(hws[i]),
> +                                             "Unable to register clock: =
%s\n",
> +                                             clk_hw_get_name(hws[i]));

We pushed this into the core now so you can drop this. See commit
12a0fd23e870 ("clk: Print an error when clk registration fails").

> +               }
> +       }
> +
> +       platform_set_drvdata(pdev, clockman);
> +
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                          &clockman->onecell);
> +}
> +

