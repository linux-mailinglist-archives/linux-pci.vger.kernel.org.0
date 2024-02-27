Return-Path: <linux-pci+bounces-4136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AAE869C37
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 17:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B6B1F24124
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 16:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB13219ED;
	Tue, 27 Feb 2024 16:34:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404E6208A3;
	Tue, 27 Feb 2024 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051679; cv=none; b=h1BVEiFPc/1gWBTLorDwt/O8fdSv/IRnEqBFVNt/zg3WI4OJztMl4UvuVIk1NbzVYiHw3nmrsoew/B7uMDxXCM7jEwOTyYIxYpG1boSxlx/Miras+P9VapO2eMcrbeJ5ZsaKZdhNbJja6KHSOaD8+Y3REOncDPGMoIdQLf4Fa3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051679; c=relaxed/simple;
	bh=/i9MJCMqa/FgvoVRdOY5xFk2B/DagcY8PG/48I9wa8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmznGcWmj7TRQuE2IfNVjQfrsrTCdRVwUduJFJBtg6gikQoHZErdv9TldKESVvlveXzDJlC5S8Qqal5Erk3oRjz9BEk+IrmBWlpG0cwIKtTwYZ4NY8GZZpz3AV20eHKHysJ2NOW+3178iDqKpkN/mQzwi8fdpXlJ1SSJ930/98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-608ed07bdc5so25917397b3.3;
        Tue, 27 Feb 2024 08:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051675; x=1709656475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFhsBrNB0ZxotPvr7uksusf/c5UzUanJ2CNxp9l9FzM=;
        b=XKM3ED51zRayKO2o4PgUFf5Wrm5x3MoavVxc7uFW9enljGPpzaUQIF589zr+DsSmat
         dVbCKDcKjoq+7+gm8AESku9J1uniG0q2zp4LjE/yfmLgLmOSOXtWJCgvET/6CzN+d3p7
         MoknN5oQ3rvLx/wwWznt5mXyAlv1jFG1Jb5M4dulLwTWQIMgQE84oiwN/FjhqZ9hl/sf
         GiI1ZONWQ/ZzixAqivcZQJ806ioj97VIQr9/i5RXNW9daX8tEcQQW6oQ6QMOKzQnFNbu
         IhUFSwCEEqYaLXpcEG9UuCkF52h5O19FbFfpcxlIvnYyMfZtIGp7yKwf3fvBtwqJrNYf
         tt0A==
X-Forwarded-Encrypted: i=1; AJvYcCXlJ2ikc+7Fz0VwLIISkK8YNs6Rg2E+v2rA8NmgmjR4TzdU+TiRr74SBl4BOLnXj8h6GjLXmwyuMkf8jQ/h8Vb6yv+LtMpqar4yiZLzWF68eBL3lnw54NlexN5QGzjs9x3RUMEqIysIeifv1LAxJED2aLsRsPGGVl0mPnnLrv7TQOWKNC2KG48KRRHT0u66tZOEjJEVeJDkp7ugNZCyezRL2G6S6fMDgQfJFfsKek9J9QkhifzqvDFoSM/RL/I0HtPhledQ8W3OlIBcNrVMKPKpdL1LBzjtU0vUFT8ind/9mt3kqfFH1cK+83eYIfi8hb1BCpqHGPOxKHFmq1OT41AhldOHohLGxoyXl7bLiKrxfbl4toverL0=
X-Gm-Message-State: AOJu0YwDMrlI06s05jp4xPtx+GdcUnZbuybT6BSjGMU2LWWbhHPvekay
	MsT9WHZXbD7NDONnilrVWh9e5DnwVosH8+9JRdmUIMo2J8PdWJpU0mE08Kt4ysqi/Q==
X-Google-Smtp-Source: AGHT+IG/+lq49W5+DZmfo4BbEzDWtQqgWdhMf1/CYwEzfkOCQEIxMO4LHmjQJpE6Y0sNQ63PuX0kVQ==
X-Received: by 2002:a25:3d41:0:b0:dcf:afe3:11bf with SMTP id k62-20020a253d41000000b00dcfafe311bfmr46802yba.0.1709051675212;
        Tue, 27 Feb 2024 08:34:35 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id i18-20020a259d12000000b00dcd512855d4sm1452496ybp.58.2024.02.27.08.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 08:34:34 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-608ccac1899so40440007b3.1;
        Tue, 27 Feb 2024 08:34:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRfSAaYeki1tJMlnVSrB1iOBc+LJfvNgErV+m7Z/l8BUaVyuP5+aTrARF/blVrkk6rLhl5v0UPPG0U92mqiv0UPfbRVS7gPN35ZiGs/pmu3htJdwEN8CJAQQV1xR5T3xTYx3mcFzch1LGoi89/eMPbnFE5JUvx9vit72pA/v0p98zWwxBfmUvSDyUoueLZlU6kBEBcOKMssN7ORmT+70Gkwa3DJBAP54Q0xvsN438UUMFuzTR7Z+ZhONs42W9mFar45sKQQF45cFtVUk9xpm2Tu2tPuL2SyxLbC7ISVatfiBvte0/+X1q1Ia+CB4rtB+qWkaQ/qbCP8Cp6nmgWgDwirEdIzXxrTO5Yl+vYDaVywNMzvideldk=
X-Received: by 2002:a25:dc07:0:b0:dcf:9019:a2fe with SMTP id
 y7-20020a25dc07000000b00dcf9019a2femr2483100ybe.64.1709051673849; Tue, 27 Feb
 2024 08:34:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704788539.git.ysato@users.sourceforge.jp> <28b339d21fa7b74c75f181d3dc710f667da5f228.1704788539.git.ysato@users.sourceforge.jp>
In-Reply-To: <28b339d21fa7b74c75f181d3dc710f667da5f228.1704788539.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 17:34:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVPSDdjGa=AF_9g_RMSv2iv862WVcrmAgvPay+ceNrzgQ@mail.gmail.com>
Message-ID: <CAMuHMdVPSDdjGa=AF_9g_RMSv2iv862WVcrmAgvPay+ceNrzgQ@mail.gmail.com>
Subject: Re: [DO NOT MERGE v6 15/37] clk: renesas: Add SH7750/7751 CPG Driver
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Lee Jones <lee@kernel.org>, 
	Helge Deller <deller@gmx.de>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Yang Xiwen <forbidden405@foxmail.com>, Sebastian Reichel <sre@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@suse.cz>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	David Rientjes <rientjes@google.com>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Azeem Shaikh <azeemshaikh38@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Bin Meng <bmeng@tinylab.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jacky Huang <ychuang3@nuvoton.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Sam Ravnborg <sam@ravnborg.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sato-san,

On Tue, Jan 9, 2024 at 9:24=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Renesas SH7750 and SH7751 series CPG driver.
> This driver supported frequency control and clock gating.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/drivers/clk/renesas/Kconfig
> +++ b/drivers/clk/renesas/Kconfig
> @@ -193,6 +196,10 @@ config CLK_SH73A0
>         select CLK_RENESAS_CPG_MSTP
>         select CLK_RENESAS_DIV6
>
> +config CLK_SH7750
> +       bool "SH7750/7751 family clock support" if COMPILE_TEST
> +       help
> +         This is a driver for SH7750 / SH7751 CPG.

This is a duplicate of the below. Please drop it.

>
>  # Family
>  config CLK_RCAR_CPG_LIB
> @@ -223,6 +230,11 @@ config CLK_RZG2L
>         bool "Renesas RZ/{G2L,G2UL,G3S,V2L} family clock support" if COMP=
ILE_TEST
>         select RESET_CONTROLLER
>
> +config CLK_SH7750
> +       bool "Renesas SH7750/7751 family clock support" if COMPILE_TEST
> +       help
> +         This is a driver for SH7750 / SH7751 CPG.
> +
>  # Generic
>  config CLK_RENESAS_CPG_MSSR
>         bool "CPG/MSSR clock support" if COMPILE_TEST

> --- /dev/null
> +++ b/drivers/clk/renesas/clk-sh7750.c

> +static int register_pll(struct device_node *node, struct cpg_priv *cpg)
> +{
> +       const char *clk_name =3D node->name;
> +       const char *parent_name;
> +       struct clk_init_data init =3D {
> +               .name =3D PLLOUT,
> +               .ops =3D &pll_ops,
> +               .flags =3D 0,
> +               .num_parents =3D 1,
> +       };
> +       int ret;
> +
> +       parent_name =3D of_clk_get_parent_name(node, 0);
> +       init.parent_names =3D &parent_name;
> +       cpg->hw.init =3D &init;
> +
> +       ret =3D of_clk_hw_register(node, &cpg->hw);
> +       if (ret < 0) {
> +               pr_err("%s: failed to register %s pll clock (%d)\n",
> +                      __func__, clk_name, ret);
> +               return ret;
> +       }
> +       if (ret < 0)
> +               pr_err("%s: failed to add provider %s (%d)\n",
> +                      __func__, clk_name, ret);

Bogus check and error message.

> +       return ret;
> +}

> +static int register_div(struct device_node *node, struct cpg_priv *cpg)
> +{
> +       static const char * const divout[] =3D {
> +               "fck", "bck", "ick",
> +       };
> +       static const char * const stbcrout[] =3D {
> +               "sci_clk", "rtc_clk", "tmu012_clk",     /* STBCR */
> +               "scif_clk", "dmac_clk",                 /* STBCR */
> +               "ubc_clk", "sq_clk",                    /* STBCR2 */
> +       };
> +       static const char * const clkstpout[] =3D {
> +               "intc_clk", "tmu34_clk", "pcic_clk",    /* CLKSTP00 */
> +       };
> +
> +       unsigned int i;
> +       int ret;
> +       struct clk_hw_onecell_data *data;
> +       struct clk_hw *reg_hw;
> +       int num_clk =3D ARRAY_SIZE(divout) + ARRAY_SIZE(stbcrout) + ARRAY=
_SIZE(clkstpout);
> +
> +       data =3D kzalloc(struct_size(data, hws, num_clk + 1), GFP_KERNEL)=
;
> +       if (!data)
> +               return -ENOMEM;
> +
> +       num_clk =3D 0;
> +       for (i =3D 0; i < ARRAY_SIZE(divout); i++) {
> +               reg_hw =3D __clk_hw_register_divider(NULL, node, divout[i=
],
> +                                                  PLLOUT, NULL, NULL,
> +                                                  0, cpg->frqcr, i * 3, =
3,
> +                                                  CLK_DIVIDER_REG_16BIT,
> +                                                  (i =3D=3D 0) ? pdiv_ta=
ble : div_table,
> +                                                  &cpg->clklock);
> +               if (IS_ERR(reg_hw)) {
> +                       ret =3D PTR_ERR(reg_hw);
> +                       goto error;
> +               }
> +               data->hws[num_clk++] =3D reg_hw;
> +       }
> +       for (i =3D 0; i < ARRAY_SIZE(stbcrout); i++) {
> +               u32 off =3D  (i < 5) ? STBCR : STBCR2;
> +
> +               if (i >=3D 5 && !(cpg->feat & MSTP_CR2))
> +                       break;

Alternatively, you could set the maximum loop counter upfront

    n =3D cpg->feat & MSTP_CR2 ? ARRAY_SIZE(stbcrout) : 5;
    for (i =3D 0; i < n; i++) ...

> +               reg_hw =3D __clk_hw_register_gate(NULL, node, stbcrout[i]=
,
> +                                               divout[0], NULL, NULL,
> +                                               0, cpg->frqcr + off, i % =
5,
> +                                               CLK_GATE_REG_8BIT | CLK_G=
ATE_SET_TO_DISABLE,
> +                                               &cpg->clklock);
> +               if (IS_ERR(reg_hw)) {
> +                       ret =3D PTR_ERR(reg_hw);
> +                       goto error;
> +               }
> +               data->hws[num_clk++] =3D reg_hw;
> +       }
> +       if (cpg->feat & MSTP_CLKSTP) {
> +               for (i =3D 0; i < ARRAY_SIZE(clkstpout); i++) {
> +                       if (i =3D=3D 2 && !(cpg->feat & MSTP_CSTP2))
> +                               continue;

Set maximum loop counter upfront?

> +                       reg_hw =3D clk_hw_register_clkstp(node, clkstpout=
[i],
> +                                                       divout[0], cpg->c=
lkstp00,
> +                                                       i, &cpg->clklock)=
;
> +                       if (IS_ERR(reg_hw)) {
> +                               ret =3D PTR_ERR(reg_hw);
> +                               goto error;
> +                       }
> +                       data->hws[num_clk++] =3D reg_hw;
> +               }
> +       }
> +       data->num =3D num_clk;
> +       ret =3D of_clk_add_hw_provider(node, of_clk_hw_onecell_get, data)=
;
> +       if (ret < 0)
> +               goto error;
> +       return 0;
> +
> +error:
> +       pr_err("%pOF: failed to register clock (%d)\n",
> +                      node, ret);
> +       for (num_clk--; num_clk >=3D 0; num_clk--)
> +               kfree(data->hws[num_clk]);
> +       kfree(data);
> +       return ret;
> +}
> +
> +static struct cpg_priv *sh7750_cpg_setup(struct device_node *node, u32 f=
eat)
> +{
> +       unsigned int num_parents;
> +       u32 mode;
> +       struct cpg_priv *cpg;
> +       int ret =3D 0;
> +
> +       num_parents =3D of_clk_get_parent_count(node);
> +       if (num_parents < 1) {
> +               pr_err("%s: no parent found", node->name);
> +               return ERR_PTR(-ENODEV);
> +       }

Do you need num_parents?

> +
> +       of_property_read_u32_index(node, "renesas,mode", 0, &mode);

mode may be used uninitialized, if "renesas,mode" is missing.

> +       if (mode >=3D 7) {
> +               pr_err("%s: Invalid clock mode setting (%u)\n",
> +                      node->name, mode);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       cpg =3D kzalloc(sizeof(struct cpg_priv), GFP_KERNEL);
> +       if (!cpg)
> +               return ERR_PTR(-ENOMEM);
> +
> +       cpg->frqcr =3D of_iomap(node, 0);
> +       if (cpg->frqcr =3D=3D NULL) {
> +               pr_err("%pOF: failed to map divide register", node);
> +               ret =3D -ENODEV;
> +               goto cpg_free;
> +       }
> +
> +       if (feat & MSTP_CLKSTP) {
> +               cpg->clkstp00 =3D of_iomap(node, 1);
> +               if (cpg->clkstp00 =3D=3D NULL) {
> +                       pr_err("%pOF: failed to map clkstp00 register", n=
ode);
> +                       ret =3D -ENODEV;
> +                       goto unmap_frqcr;
> +               }
> +       }
> +       cpg->feat =3D feat;
> +       cpg->mode =3D mode;
> +
> +       ret =3D register_pll(node, cpg);
> +       if (ret < 0)
> +               goto unmap_clkstp00;
> +
> +       ret =3D register_div(node, cpg);
> +       if (ret < 0)
> +               goto unmap_clkstp00;
> +

Perhaps "cpg_data =3D cpg;" here, and return an error code instead? ...

> +       return cpg;
> +
> +unmap_clkstp00:
> +       iounmap(cpg->clkstp00);
> +unmap_frqcr:
> +       iounmap(cpg->frqcr);
> +cpg_free:
> +       kfree(cpg);
> +       return ERR_PTR(ret);
> +}
> +
> +static void __init sh7750_cpg_init(struct device_node *node)
> +{
> +       cpg_data =3D sh7750_cpg_setup(node, cpg_feature[CPG_SH7750]);
> +       if (IS_ERR(cpg_data))
> +               cpg_data =3D NULL;

... then all cpg_data handling can be removed here...

> +}

> +static int sh7750_cpg_probe(struct platform_device *pdev)
> +{
> +       u32 feature;
> +
> +       if (cpg_data)
> +               return 0;
> +       feature =3D *(u32 *)of_device_get_match_data(&pdev->dev);
> +       cpg_data =3D sh7750_cpg_setup(pdev->dev.of_node, feature);
> +       if (IS_ERR(cpg_data))
> +               return PTR_ERR(cpg_data);
> +       return 0;

... and this can be simplified to

    return sh7750_cpg_setup(...);

> +}

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

