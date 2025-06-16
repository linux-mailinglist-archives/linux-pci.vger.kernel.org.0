Return-Path: <linux-pci+bounces-29866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB042ADB201
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 15:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBF43A4D26
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8839C285CA3;
	Mon, 16 Jun 2025 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOZXM28g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8600320C029
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080624; cv=none; b=m76N9bMcYDCSXb4K+QoKB3zmWpBMUOOUJ4SjUS0tG1SXn39TXCVpnClMR7YKkCFiPQ6Zzoo3YM4R/qFox9zqI2DUNCkBkZWRpIqigq8ppnmpFR68zI5IhCxkwg55Rxj/MxTVZ/eWER+9JoCG4XTKEHnIBWqxHhDkxJ5yeFkHGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080624; c=relaxed/simple;
	bh=4Zfd7f0oSTyDjhyyLNFCOi5jeoQIXrDItP4SyLWb99s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsY0mviELU2LNqdVDrvSOpPfyvt3O9pWG2JDttV62A+q/66bDNu6g/IBA1dhSKWEk4HuLr7isAp5xMNbyKroaA7xq2PRHV4GnAK5aZHHNBoZikSE+tYNhRmQwcqEyHraAh2yv3VBnRaU0O+M2ZRrM39WbC+kR5gRZAkv0fSkFiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VOZXM28g; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e81877c1ed6so4872817276.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750080621; x=1750685421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8dIM4ggq6nkqhLbVMKcT1ezBsK840f8IM9RKNGuYHjk=;
        b=VOZXM28gJWu1vtHOVXPd4JllO/Nz4hljwAtGy/NTTFqx4sFZAoktaklYs3/0AO1zwr
         s8Bs8c4S8RQAf/S6s8xkvhKLKBXz2LH7lOa9UCKs92RogaANj4nhH8yucEzHKhHccwlT
         E6OhXRIhlrtu5aoUYs0XPZVqMddfNmbbuzj/54GmWWHAwTawvRgmOlrZL5bkAguDTt+g
         48inRBhIuUixx887ZOITRZJfQJEBvQkauQXFmsmV1GCzMFYDb6owUm1GXTXkvoADFM3a
         KKmEA4XPHzI0qDYfHSC4JNfjQEbQQb2EphKSOIq7QhZRGcveAh7/eCjJB+Dyw6bfOkp6
         dc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080621; x=1750685421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dIM4ggq6nkqhLbVMKcT1ezBsK840f8IM9RKNGuYHjk=;
        b=wAZ2EfyJ1GW1Wwb2/1/la70PBDXKTXfwh7G29/jNcLlAYsPXC56G0HgZmP/BvxCqeM
         PU6EBZ8PQQi+zZtTsaQ9o6B99D0vp1cn2npPA/+FMQvDQ8n+uzwQ/MFTC66RaqAV3CzS
         gQYI8M9h5NmtB/42verniw3sDiRxBbtG/Hgoj9gSedAxcrBOOxdtZwMASOK824lq5jPL
         G2QMKNTwxEF6UU/c7SARJCFpMvncKCa6JG0du57Q0UNiMu2kZis3/e0me9t2zz1QyVEx
         /QSrnFn3JH0dOjLjjucukpeyM5ZYEaCcHG8koTo9ZWRncwjdZuGWPLes6Ns/CgBOL85E
         WGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8aGM+uHRUNHX540cmFks7R2kkgu5CJah8WNzs42VTWBRAmpES0vsb8CY/lA1q7NDHP4PRYRctMG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdfK7tL2FpDKe2iIkKfyOU4kXsKYsKfGTi6LZWAkIZ24y5F37u
	ilEQUC1SXmPBBTnHorWiomgWnZdIhaYFVVovrf/Z7Mvmvtw9nDE/k5vxAYnL80w4sRThV7uO58x
	Wk2FBjLd2QLn+u8fP5hinAkGHtytLEAcnv5h4EuLk1w==
X-Gm-Gg: ASbGncudUylj+d7BcfLx1tZsG0ap0UbaKcGwmI9Fsg0hqS5uW3jHeXtStZ8QHNzPBRW
	e2Od3jd849hbTFcvbJ5S2VUUrRl+DtJoqh4UrP1E2ua68D6qVOsL/51YSP/istsGdfsz0dWCSlt
	h01GADmKToMNIMqoxcnrINZY0yQilPnTpp7KILxStEw2UL
X-Google-Smtp-Source: AGHT+IHvwFdTtrctzoiWIaPE71W/8FTAI+xhZY2HkhDJbIaDsGip4BNw9qrbXT3Tk9Kd8tGyhyS35T/gDOg+zFs+nYI=
X-Received: by 2002:a05:6902:703:b0:e81:566c:3085 with SMTP id
 3f1490d57ef6-e8227f0e61bmr12875927276.1.1750080620760; Mon, 16 Jun 2025
 06:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com> <20250612-byeword-update-v1-2-f4afb8f6313f@collabora.com>
In-Reply-To: <20250612-byeword-update-v1-2-f4afb8f6313f@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 16 Jun 2025 15:29:44 +0200
X-Gm-Features: AX0GCFucmmVjhuxKNu1-kopwQ1Ifcn7b36ykDZEf_SV72XMHIWGaSa8Aqxa6A60
Message-ID: <CAPDyKFr_-aQ+YoRqYVUFhRR=94NWOredaSYQsVb-xvot83HJ3w@mail.gmail.com>
Subject: Re: [PATCH 02/20] mmc: dw_mmc-rockchip: switch to HWORD_UPDATE macro
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
	Shreeya Patel <shreeya.patel@collabora.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Qin Jian <qinjian@cqplus1.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 20:57, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
> drivers that use constant masks.
>
> Switch to the new HWORD_UPDATE macro in bitfield.h, which has error
> checking. Instead of redefining the driver's HIWORD_UPDATE macro in this
> case, replace the two only instances of it with the new macro, as I
> could test that they result in an equivalent value.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index baa23b51773127b4137f472581259b61649273a5..9e3d17becf65ffb60fe3d32d2cdec341fbd30b1e 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -5,6 +5,7 @@
>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/mmc/host.h>
>  #include <linux/of_address.h>
> @@ -24,8 +25,6 @@
>  #define ROCKCHIP_MMC_DELAYNUM_OFFSET   2
>  #define ROCKCHIP_MMC_DELAYNUM_MASK     (0xff << ROCKCHIP_MMC_DELAYNUM_OFFSET)
>  #define ROCKCHIP_MMC_DELAY_ELEMENT_PSEC        60
> -#define HIWORD_UPDATE(val, mask, shift) \
> -               ((val) << (shift) | (mask) << ((shift) + 16))
>
>  static const unsigned int freqs[] = { 100000, 200000, 300000, 400000 };
>
> @@ -148,9 +147,9 @@ static int rockchip_mmc_set_internal_phase(struct dw_mci *host, bool sample, int
>         raw_value |= nineties;
>
>         if (sample)
> -               mci_writel(host, TIMING_CON1, HIWORD_UPDATE(raw_value, 0x07ff, 1));
> +               mci_writel(host, TIMING_CON1, HWORD_UPDATE(GENMASK(11, 1), raw_value));
>         else
> -               mci_writel(host, TIMING_CON0, HIWORD_UPDATE(raw_value, 0x07ff, 1));
> +               mci_writel(host, TIMING_CON0, HWORD_UPDATE(GENMASK(11, 1), raw_value));
>
>         dev_dbg(host->dev, "set %s_phase(%d) delay_nums=%u actual_degrees=%d\n",
>                 sample ? "sample" : "drv", degrees, delay_num,
>
> --
> 2.49.0
>

