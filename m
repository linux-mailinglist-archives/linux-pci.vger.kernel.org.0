Return-Path: <linux-pci+bounces-27464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71702AB0482
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 22:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D6B9C3BA1
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 20:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C42C28B7E4;
	Thu,  8 May 2025 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fhK4ZCtZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614B128B7D6
	for <linux-pci@vger.kernel.org>; Thu,  8 May 2025 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735645; cv=none; b=JvGu50/Dm03HS/RYOqfUGzB1vwDePq9Ysnp7AsDotb6ViOWKgecxOOcnnn+Xu5zYqe3+DkMEd4eJrCZ2lCgZlVTQ4cY0nOzB9DRiIG7WziOZCdVQ/tUQpus4dxzDJSe2nRF88+ZkwK2mJV4Ip7D5sauX9869TDXj/sYXwh31NCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735645; c=relaxed/simple;
	bh=bTYyFAW/yeRI0k8vsOxZbUhU/gnf3b7gIfNhkQ9aK3k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3ZiL7NohkYP9LgP1gOZmjS1hXt3gQA4NJ9ZXTdreN+Y/FZbppbKEZfIZK14jDKhzelVRZWFYPY7UxhxELtXIHgogS1QASQ+yEuM7lgTzW317neMldr1no+vz0snQSxujidwFIuAKyJ6Kp4Zk+OHYsM9yz6YWZqsRUckSZ0aivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fhK4ZCtZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5fc8c68dc9fso2450142a12.1
        for <linux-pci@vger.kernel.org>; Thu, 08 May 2025 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746735640; x=1747340440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+0HDmOq93rWprCUfN2a1cuCbw50LvApIv2LTytQEH44=;
        b=fhK4ZCtZxZvMTzkq4ShNqtqsF8JtZhMh5o7XJyFBcl45wKT2zLqwJRyl9SctRo1T2S
         hKwY1dW9qIWl2smLjyrVXUGXyJkMf1E/zevmVNl3yaUItcewJ5NiLc0SX8D9fOWiaTqC
         KzEzPzisIZfX+2Smbrd5fidTdGcD4catkYCPlO2WwIV8C6snnj4gOnhoxsodHDCdd0k/
         nXDKmoMNWM6yz3Zx8vrXTiASkbtUc0PYCkxmxHzUlgp1aTIRiX87h4B4BRv5UqMke8VW
         irRJaKAq2XvHlQRSP/nkEGIJyj+MwJESKKtrbwZePCiP4c8NCMsfhjYDeBQaYqzEwUV2
         BGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746735640; x=1747340440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0HDmOq93rWprCUfN2a1cuCbw50LvApIv2LTytQEH44=;
        b=AfpK9gFN+q62Wh3sOR2vmgOgfXNUcxaklhk6TDWCMrprE2u7y+1yGfca845qy+96E3
         Zv9Q/X/FrOIhDnbvNfAeJRirDp0R624x9ZHSEbEW23ignXK265sUJvsLIu8wWEmEKMgk
         fZxjrIcP7M5Ed5lwtTrrcNKvATcgokCB2jolPH1xjXpMGknkQ1HDB+lqvEXnqWIu3Jwk
         ykUEby9S+kF3MPt6zQT5T9lV3SrvfaWJZkUqxeAuQQO1A8HjQ5/7Td1AdGtlscUewYKE
         kJwgnE0i/AeQVll1rrUNW4zcg2NYvyhrk2UMema18dgH8cKjxIvFzqTEYaOmqupq79Av
         9qpA==
X-Forwarded-Encrypted: i=1; AJvYcCXDBXQV8tHzT8gPvpvA6jqjFySS4n506cXQ7CbR9xber7H918DuG4Go7XbPMWL9g8oyQs+S1ZSabVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQaFOWMIbVYemnVdYuXzbxzV+6QAxvE3w+DxTordh1dRX58sLH
	A7x6s3HHkxaEsRM3QpboO5wdqSeZgjIiBjXuTIWR9BUzGvI8LQBC7celP+x+3pI=
X-Gm-Gg: ASbGncs1IJFQoUPUV+OTaOdU3RYedTLJfpxftgWdEVBjq4b6RUTrH7Lvh1VpP1Uth3B
	q6eIB212xRTP23tVvxAFw0AvgQcsMVBbePIQIUkXX/UJG/LAQQXtrARzeAzWfabRC3BCUpKgmEV
	5jM9m86gmVCWzhK2qMb66gKL3NDF3vV9Ksqc5b7NAxj2w86VANS+I//ePoRSRs31rarVEWOUI4w
	fvqWvtANiXX7idzgxAs2JdsLobkwquwCqTtIMZAyP8fK4XcObrPPeUbKI1Uzue/pDQL26++EPF+
	Xbf4gKyVWnUYxaOvkoy8CNbOTCjnMP9QQlmd/wa3lQlYuvMEJvNqWOluAr5gxeWvzcIJ9v0=
X-Google-Smtp-Source: AGHT+IEI/7uf0d58ww/vPGIkb9Rp22etgucrO2Ag5lYkTnkwmaIknxrOUtu+MUmCpl+havrQV2w1xw==
X-Received: by 2002:a17:907:969f:b0:ace:bead:5ee1 with SMTP id a640c23a62f3a-ad219131246mr103603366b.42.1746735639533;
        Thu, 08 May 2025 13:20:39 -0700 (PDT)
Received: from localhost (93-44-188-26.ip98.fastwebnet.it. [93.44.188.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2192cf5casm38239766b.2.2025.05.08.13.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 13:20:39 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 8 May 2025 22:22:08 +0200
To: Stephen Boyd <sboyd@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
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
	Matthias Brugger <mbrugger@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Phi l Elwell <phil@raspberrypi.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 -next 04/12] clk: rp1: Add support for clocks provided
 by RP1
Message-ID: <aB0ScIyG-HTLGVQ7@apocalypse>
References: <cover.1745347417.git.andrea.porta@suse.com>
 <e8a9c2cd6b4b2af8038048cda179ebbf70891ba7.1745347417.git.andrea.porta@suse.com>
 <a61159b7b34c29323cdc428bb34acfa1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61159b7b34c29323cdc428bb34acfa1@kernel.org>

Hi Stephen,

On 13:01 Wed 07 May     , Stephen Boyd wrote:
> Quoting Andrea della Porta (2025-04-22 11:53:13)
> > diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> > new file mode 100644
> > index 000000000000..6b0b76fc6977
> > --- /dev/null
> > +++ b/drivers/clk/clk-rp1.c
> > @@ -0,0 +1,1510 @@
> [...]
> > +static u8 rp1_clock_get_parent(struct clk_hw *hw)
> > +{
> > +       struct rp1_clk_desc *clock = container_of(hw, struct rp1_clk_desc, hw);
> > +       struct rp1_clockman *clockman = clock->clockman;
> > +       const struct rp1_clock_data *data = clock->data;
> > +       u32 sel, ctrl;
> > +       u8 parent;
> > +
> > +       /* Sel is one-hot, so find the first bit set */
> > +       sel = clockman_read(clockman, data->sel_reg);
> > +       parent = ffs(sel) - 1;
> > +
> > +       /* sel == 0 implies the parent clock is not enabled yet. */
> > +       if (!sel) {
> > +               /* Read the clock src from the CTRL register instead */
> > +               ctrl = clockman_read(clockman, data->ctrl_reg);
> > +               parent = (ctrl & data->clk_src_mask) >> CLK_CTRL_SRC_SHIFT;
> > +       }
> > +
> > +       if (parent >= data->num_std_parents)
> > +               parent = AUX_SEL;
> > +
> > +       if (parent == AUX_SEL) {
> > +               /*
> > +                * Clock parent is an auxiliary source, so get the parent from
> > +                * the AUXSRC register field.
> > +                */
> > +               ctrl = clockman_read(clockman, data->ctrl_reg);
> > +               parent = FIELD_GET(CLK_CTRL_AUXSRC_MASK, ctrl);
> > +               parent += data->num_std_parents;
> > +       }
> > +
> > +       return parent;
> > +}
> > +
> > +static int rp1_clock_set_parent(struct clk_hw *hw, u8 index)
> > +{
> > +       struct rp1_clk_desc *clock = container_of(hw, struct rp1_clk_desc, hw);
> > +       struct rp1_clockman *clockman = clock->clockman;
> > +       const struct rp1_clock_data *data = clock->data;
> > +       u32 ctrl, sel;
> > +
> > +       spin_lock(&clockman->regs_lock);
> > +       ctrl = clockman_read(clockman, data->ctrl_reg);
> > +
> > +       if (index >= data->num_std_parents) {
> > +               /* This is an aux source request */
> > +               if (index >= data->num_std_parents + data->num_aux_parents) {
> > +                       spin_unlock(&clockman->regs_lock);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               /* Select parent from aux list */
> > +               ctrl &= ~CLK_CTRL_AUXSRC_MASK;
> > +               ctrl |= FIELD_PREP(CLK_CTRL_AUXSRC_MASK, index - data->num_std_parents);
> > +               /* Set src to aux list */
> > +               ctrl &= ~data->clk_src_mask;
> > +               ctrl |= (AUX_SEL << CLK_CTRL_SRC_SHIFT) & data->clk_src_mask;
> > +       } else {
> > +               ctrl &= ~data->clk_src_mask;
> > +               ctrl |= (index << CLK_CTRL_SRC_SHIFT) & data->clk_src_mask;
> > +       }
> > +
> > +       clockman_write(clockman, data->ctrl_reg, ctrl);
> > +       spin_unlock(&clockman->regs_lock);
> > +
> > +       sel = rp1_clock_get_parent(hw);
> > +       WARN_ONCE(sel != index, "(%s): Parent index req %u returned back %u\n",
> > +                 clk_hw_get_name(hw), index, sel);
> 
> Is this debug code? Why do we need to read back the parent here?

This is more of like a sanity check, but I agree that without taking action
it is not very helpful. Maybe we can use this check to return an appropriate
error code in case the parent check is failing. With appropriate changes, also
rp1_clock_set_rate_and_parent() could benefit from that. So I'll drop the WARN
and it turn into a conditional return -EINVAL, for the error to be propagated
to the CCF.

> 
> > +
> > +       return 0;
> > +}
> > +
> > +static int rp1_clock_set_rate_and_parent(struct clk_hw *hw,
> > +                                        unsigned long rate,
> > +                                        unsigned long parent_rate,
> > +                                        u8 parent)
> > +{
> > +       struct rp1_clk_desc *clock = container_of(hw, struct rp1_clk_desc, hw);
> > +       struct rp1_clockman *clockman = clock->clockman;
> > +       const struct rp1_clock_data *data = clock->data;
> > +       u32 div = rp1_clock_choose_div(rate, parent_rate, data);
> > +
> > +       WARN_ONCE(rate > data->max_freq,
> > +                 "(%s): Requested rate (%lu) > max rate (%lu)\n",
> > +                 clk_hw_get_name(hw), rate, data->max_freq);
> 
> If the determine_rate function is implemented properly this is
> impossible because we round the rate before calling this clk_op.

Right, rp1_clock_choose_div_and_prate() which is called by rp1_clock_determine_rate()
is doing the relevant check on max_freq, so I'll drop this WARN as it should never
be true.

> 
> > +
> > +       if (WARN_ONCE(!div,
> > +                     "clk divider calculated as 0! (%s, rate %lu, parent rate %lu)\n",
> > +                     clk_hw_get_name(hw), rate, parent_rate))
> > +               div = 1 << CLK_DIV_FRAC_BITS;
> 
> This one also looks weird, does it assume round_rate didn't constrain
> the incoming rate?
> 

Indeed, div can be 0 here but rp1_clock_determine_rate() would have returned an error,
never reaching this conditional, so I think I can drop it.

> > +
> > +       spin_lock(&clockman->regs_lock);
> > +
> > +       clockman_write(clockman, data->div_int_reg, div >> CLK_DIV_FRAC_BITS);
> > +       if (data->div_frac_reg)
> > +               clockman_write(clockman, data->div_frac_reg, div << (32 - CLK_DIV_FRAC_BITS));
> > +
> > +       spin_unlock(&clockman->regs_lock);
> > +
> > +       if (parent != 0xff)
> > +               rp1_clock_set_parent(hw, parent);
> > +
> > +       return 0;
> > +}
> > +
> > +static int rp1_clock_set_rate(struct clk_hw *hw, unsigned long rate,
> > +                             unsigned long parent_rate)
> > +{
> > +       return rp1_clock_set_rate_and_parent(hw, rate, parent_rate, 0xff);
> > +}
> > +
> > +static void rp1_clock_choose_div_and_prate(struct clk_hw *hw,
> > +                                          int parent_idx,
> > +                                          unsigned long rate,
> > +                                          unsigned long *prate,
> > +                                          unsigned long *calc_rate)
> > +{
> > +       struct rp1_clk_desc *clock = container_of(hw, struct rp1_clk_desc, hw);
> > +       const struct rp1_clock_data *data = clock->data;
> > +       struct clk_hw *parent;
> > +       u32 div;
> > +       u64 tmp;
> > +
> > +       parent = clk_hw_get_parent_by_index(hw, parent_idx);
> > +
> > +       *prate = clk_hw_get_rate(parent);
> > +       div = rp1_clock_choose_div(rate, *prate, data);
> > +
> > +       if (!div) {
> > +               *calc_rate = 0;
> > +               return;
> > +       }
> > +
> > +       /* Recalculate to account for rounding errors */
> > +       tmp = (u64)*prate << CLK_DIV_FRAC_BITS;
> > +       tmp = div_u64(tmp, div);
> > +
> > +       /*
> > +        * Prevent overclocks - if all parent choices result in
> > +        * a downstream clock in excess of the maximum, then the
> > +        * call to set the clock will fail.
> > +        */
> > +       if (tmp > data->max_freq)
> > +               *calc_rate = 0;
> > +       else
> > +               *calc_rate = tmp;
> > +}
> > +
> > +static int rp1_clock_determine_rate(struct clk_hw *hw,
> > +                                   struct clk_rate_request *req)
> > +{
> > +       struct clk_hw *parent, *best_parent = NULL;
> > +       unsigned long best_rate = 0;
> > +       unsigned long best_prate = 0;
> > +       unsigned long best_rate_diff = ULONG_MAX;
> > +       unsigned long prate, calc_rate;
> > +       size_t i;
> > +
> > +       /*
> > +        * If the NO_REPARENT flag is set, try to use existing parent.
> > +        */
> > +       if ((clk_hw_get_flags(hw) & CLK_SET_RATE_NO_REPARENT)) {
> > +               i = rp1_clock_get_parent(hw);
> > +               parent = clk_hw_get_parent_by_index(hw, i);
> > +               if (parent) {
> > +                       rp1_clock_choose_div_and_prate(hw, i, req->rate, &prate,
> > +                                                      &calc_rate);
> > +                       if (calc_rate > 0) {
> > +                               req->best_parent_hw = parent;
> > +                               req->best_parent_rate = prate;
> > +                               req->rate = calc_rate;
> > +                               return 0;
> > +                       }
> > +               }
> > +       }
> > +
> > +       /*
> > +        * Select parent clock that results in the closest rate (lower or
> > +        * higher)
> > +        */
> > +       for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
> > +               parent = clk_hw_get_parent_by_index(hw, i);
> > +               if (!parent)
> > +                       continue;
> > +
> > +               rp1_clock_choose_div_and_prate(hw, i, req->rate, &prate,
> > +                                              &calc_rate);
> > +
> > +               if (abs_diff(calc_rate, req->rate) < best_rate_diff) {
> > +                       best_parent = parent;
> > +                       best_prate = prate;
> > +                       best_rate = calc_rate;
> > +                       best_rate_diff = abs_diff(calc_rate, req->rate);
> > +
> > +                       if (best_rate_diff == 0)
> > +                               break;
> > +               }
> > +       }
> > +
> > +       if (best_rate == 0)
> > +               return -EINVAL;
> > +
> > +       req->best_parent_hw = best_parent;
> > +       req->best_parent_rate = best_prate;
> > +       req->rate = best_rate;
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct clk_ops rp1_pll_core_ops = {
> > +       .is_prepared = rp1_pll_core_is_on,
> > +       .prepare = rp1_pll_core_on,
> > +       .unprepare = rp1_pll_core_off,
> > +       .set_rate = rp1_pll_core_set_rate,
> > +       .recalc_rate = rp1_pll_core_recalc_rate,
> > +       .round_rate = rp1_pll_core_round_rate,
> > +};
> > +
> > +static const struct clk_ops rp1_pll_ops = {
> > +       .set_rate = rp1_pll_set_rate,
> > +       .recalc_rate = rp1_pll_recalc_rate,
> > +       .round_rate = rp1_pll_round_rate,
> > +};
> > +
> > +static const struct clk_ops rp1_pll_ph_ops = {
> > +       .is_prepared = rp1_pll_ph_is_on,
> > +       .prepare = rp1_pll_ph_on,
> > +       .unprepare = rp1_pll_ph_off,
> > +       .recalc_rate = rp1_pll_ph_recalc_rate,
> > +       .round_rate = rp1_pll_ph_round_rate,
> > +};
> > +
> > +static const struct clk_ops rp1_pll_divider_ops = {
> > +       .is_prepared = rp1_pll_divider_is_on,
> > +       .prepare = rp1_pll_divider_on,
> > +       .unprepare = rp1_pll_divider_off,
> > +       .set_rate = rp1_pll_divider_set_rate,
> > +       .recalc_rate = rp1_pll_divider_recalc_rate,
> > +       .round_rate = rp1_pll_divider_round_rate,
> > +};
> > +
> > +static const struct clk_ops rp1_clk_ops = {
> > +       .is_prepared = rp1_clock_is_on,
> > +       .prepare = rp1_clock_on,
> > +       .unprepare = rp1_clock_off,
> > +       .recalc_rate = rp1_clock_recalc_rate,
> > +       .get_parent = rp1_clock_get_parent,
> > +       .set_parent = rp1_clock_set_parent,
> > +       .set_rate_and_parent = rp1_clock_set_rate_and_parent,
> > +       .set_rate = rp1_clock_set_rate,
> > +       .determine_rate = rp1_clock_determine_rate,
> > +};
> > +
> > +static struct clk_hw *rp1_register_pll(struct rp1_clockman *clockman,
> > +                                      struct rp1_clk_desc *desc)
> > +{
> > +       int ret;
> > +
> > +       desc->clockman = clockman;
> > +
> > +       ret = devm_clk_hw_register(clockman->dev, &desc->hw);
> > +
> 
> Please drop this newline.

Ack.

> 
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
> > +       int ret;
> > +
> > +       desc->div.reg = clockman->regs + divider_data->ctrl_reg;
> > +       desc->div.shift = __ffs(PLL_SEC_DIV_MASK);
> > +       desc->div.width = __ffs(~(PLL_SEC_DIV_MASK >> desc->div.shift));
> > +       desc->div.flags = CLK_DIVIDER_ROUND_CLOSEST;
> > +       desc->div.lock = &clockman->regs_lock;
> > +       desc->div.hw.init = desc->hw.init;
> > +       desc->div.table = pll_sec_div_table;
> > +
> > +       desc->clockman = clockman;
> > +
> > +       ret = devm_clk_hw_register(clockman->dev, &desc->div.hw);
> > +
> 
> Please drop this newline.

Ack.

> 
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
> > +       int ret;
> > +
> > +       if (WARN_ON_ONCE(MAX_CLK_PARENTS <
> > +              clock_data->num_std_parents + clock_data->num_aux_parents))
> > +               return NULL;
> 
> Return an error pointer?

Ack.

> 
> > +
> > +       /* There must be a gap for the AUX selector */
> > +       if (WARN_ON_ONCE(clock_data->num_std_parents > AUX_SEL &&
> > +                        desc->hw.init->parent_data[AUX_SEL].index != -1))
> 
> Why is there a gap? Can't the parents that the clk framework sees be
> 
> 	[0, num_std_parents) + [num_std_parents, num_aux_parents + num_std_parents)
> 
> without an empty parent in the middle?

Not sure why it was done that way. Need to check with Raspberry guys.

> 
> > +               return NULL;
> 
> Return an error pointer?

Ack.

> 
> > +
> > +       desc->clockman = clockman;
> > +
> > +       ret = devm_clk_hw_register(clockman->dev, &desc->hw);
> > +
> 
> Drop this newline please.

Ack.

> 
> > +       if (ret)
> > +               return ERR_PTR(ret);
> > +
> > +       return &desc->hw;
> > +}
> [...]
> > +
> > +static const struct clk_parent_data clk_eth_parents[] = {
> > +       { .hw = &pll_sys_sec_desc.div.hw },
> > +       { .hw = &pll_sys_desc.hw },
> > +};
> > +
> > +static struct rp1_clk_desc clk_eth_desc = REGISTER_CLK(
> > +       .hw.init = CLK_HW_INIT_PARENTS_DATA(
> > +               "clk_eth",
> > +               clk_eth_parents,
> > +               &rp1_clk_ops,
> > +               0
> > +       ),
> > +       CLK_DATA(rp1_clock_data,
> > +                .num_std_parents = 0,
> > +                .num_aux_parents = 2,
> > +                .ctrl_reg = CLK_ETH_CTRL,
> > +                .div_int_reg = CLK_ETH_DIV_INT,
> > +                .sel_reg = CLK_ETH_SEL,
> > +                .div_int_max = DIV_INT_8BIT_MAX,
> > +                .max_freq = 125 * HZ_PER_MHZ,
> > +                .fc0_src = FC_NUM(4, 6),
> > +       )
> > +);
> > +
> > +static const struct clk_parent_data clk_sys_parents[] = {
> > +       { .index = 0 },
> > +       { .index = -1 },
> 
> Why is there a gap here?

Same comment as above. Need to check.

> 
> > +       { .hw = &pll_sys_desc.hw },
> > +};
> > +
> [...]
> > +
> > +static const struct regmap_config rp1_clk_regmap_cfg = {
> > +       .reg_bits = 32,
> > +       .val_bits = 32,
> > +       .reg_stride = 4,
> > +       .max_register = PLL_VIDEO_SEC,
> > +       .name = "rp1-clk",
> > +       .rd_table = &rp1_reg_table,
> 
> Do you want to set the 'disable_locking' field because you're
> explicitly locking in this driver?

Yes, let's avoid redundancy.

> 
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
> > +               dev_err_probe(dev, PTR_ERR(clockman->regmap),
> > +                             "could not init clock regmap\n");
> > +               return PTR_ERR(clockman->regmap);
> > +       }
> > +
> > +       clockman->onecell.num = asize;
> > +       hws = clockman->onecell.hws;
> > +
> > +       for (i = 0; i < asize; i++) {
> > +               desc = clk_desc_array[i];
> > +               if (desc && desc->clk_register && desc->data) {
> > +                       hws[i] = desc->clk_register(clockman, desc);
> > +                       if (IS_ERR_OR_NULL(hws[i]))
> 
> Why is NULL a possible return value?

Right, IS_ERR() would be enough here since devm_clk_hw_register() in the rp1_register*()
functions will return an error in faulty cases, and &desc->hw couldn't even be
NULL.
 
> 
> > +                               dev_err_probe(dev, PTR_ERR(hws[i]),
> > +                                             "Unable to register clock: %s\n",
> > +                                             clk_hw_get_name(hws[i]));
> 
> We pushed this into the core now so you can drop this. See commit
> 12a0fd23e870 ("clk: Print an error when clk registration fails").

Dropped.

Many thanks,
Andrea

> 
> > +               }
> > +       }
> > +
> > +       platform_set_drvdata(pdev, clockman);
> > +
> > +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> > +                                          &clockman->onecell);
> > +}
> > +

