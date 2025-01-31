Return-Path: <linux-pci+bounces-20600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B7FA2400F
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 17:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0813A3A3B1F
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484D21E9B15;
	Fri, 31 Jan 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9nPy+0Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E381E492D;
	Fri, 31 Jan 2025 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738339736; cv=none; b=hmFq8AFMdoVEZ0SH/lZ00T3HcRrQ+3nbmJm0DnWI52JkggE4WnyBb3fWPzGJAIjy4e8G9cerpMmkbUdWUfjy5lfehfR4mTyMmHHP8J8lSE3/yXrydIN6WJ1+xaKWsPCBm8JE2+5cj0p4g5G37McksmUelZP3I6S7n9p89kImjJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738339736; c=relaxed/simple;
	bh=rMmrtkHlPCANPye5v5fzxIpfstL99rb3qOXIt4BzF5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqVPzB3qMSATRExHNtbDLcLiltur3UaiOyjYm8H/mjIadGncvL4k/mFhso9EyxJ4FBQhOD2UzuhB642NS8gHuZ8E/eyz34H35RC/SVUjhUS5obh6DtcPBdSrqNtIPr4V0zsWvZMF2VICyaliB9aYt4WBFKJGFdO+hLSmpLPCJMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9nPy+0Y; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4afdd15db60so621223137.1;
        Fri, 31 Jan 2025 08:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738339733; x=1738944533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCaFx1tau/uvLCClkf2wwSaMLTwgcjUvUC6CkU3RdXs=;
        b=F9nPy+0Ym+RGYGkiyjvT/bdaAKX85PPnjjpCaHdQmLMCz2g3iTgeexVtYsgv2agf3L
         R8jlo7XTGrWs6qXDqhcV2GZs1P+3pPUXNpPFyKhn+XwVteC66RsoCzqsFGE91l5VQUtv
         /IJ1+9e3VVqlnGY0PUSjRah8FRuAQ23rGoXAKbeGUofFqN+vtmBBbRLGcF+eXsfQ/In/
         VDFot20GumtPXaBi8tmc616njI/8gPqMsJ/DEUZJudODrSWOqfjTFd4u2ChS0iMeoagg
         lyy3XYLLkhtbxyaQfXrnJ5c0syNkYERiJRqKDG+4PIMF9rzmE451UxBeVS7jSgiu3Jz7
         S5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738339733; x=1738944533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCaFx1tau/uvLCClkf2wwSaMLTwgcjUvUC6CkU3RdXs=;
        b=T7RGM2jmLo9chIssoeCzG5cg/2mEqRoX9OePxVY3UD4V3KNlH/qM5btn6ShQge3R2/
         Y4GE4XNcALX2b4BLNP8SMtTxXYpIYoepW4d66eXPK66+L/b/efpdtQGg5ZmjFsIg2d9K
         4TL61EoFWZhfG3cqY9Xkmq6YTsJIxaH2bv3OyzZ68bduvIoz8vM8yp+AT1rqF6S58jQa
         MatsTkBuqWVCfm7YLsR3LgQsT5h+2pnHjrFVYzTbNJ+R/nh7y0CXiGOsPHWlTgijROq0
         113akCnOD796DIDI0hu7lO6qaEztpvlRylPATKLC4a+le6l18soNF6YlaoIcQuwScFYd
         XPZg==
X-Forwarded-Encrypted: i=1; AJvYcCVGO5uxyXeYAdmIy3OGil3S+v3RUZI0sU/14tlJ1qXJakGIx1PzOvaC1jZYS0NMSEZ8D6AT7nDNsjAh@vger.kernel.org, AJvYcCWHHqo5xUCC1aM1RqmFqpBjX78IhDoP7t8cNFbUS99bycMMT+AxVhHtMIW9AnJKHuJ8qsxrvULHnHKG@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7CjJTS+OZ9yvfmwc1riXOCW6xAD3B/23Emmw0Ph+56W5ehMt
	FIOY+33AE26E8DO7Dg+OfQ51WmyJSt2pvnimSLu/rXxh8DD/G2ry9UMrMnvgHmf2X5jgjnVV5Ml
	XQrYXmLOWnGVhWTY2Jmt5FPrHd6g=
X-Gm-Gg: ASbGncuZ3cmOBdELCOby+dC3FjPspRP0mYthOAJuJK9kLwd1BfWJk5ow+uFSdvLR/al
	VZeCiuwYNebslTwXj299868F9PfhbA4NnzUooI8skt5bOt5IybKvj6lE6GvwwLt8OsK1kq3IxUQ
	==
X-Google-Smtp-Source: AGHT+IHYtHN7NQoh6hNtrAdwoAYa7qI0MoWaBUwelkEk8UBLOskbrKXzZjF4j5miCwRUI07KmI2jpZGXVvhHioJuiQw=
X-Received: by 2002:a05:6122:1990:b0:51c:aa1a:2b5b with SMTP id
 71dfb90a1353d-51e9e3fdc44mr10795837e0c.4.1738339733279; Fri, 31 Jan 2025
 08:08:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120130119.671119-1-svarbanov@suse.de> <20250120130119.671119-8-svarbanov@suse.de>
In-Reply-To: <20250120130119.671119-8-svarbanov@suse.de>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Fri, 31 Jan 2025 11:08:40 -0500
X-Gm-Features: AWEUYZlRDqLoEwfW8ZjsMYge0gy5rqvEFzsQwIrPsTXZFKyo6tYXuM7WIrcpHfc
Message-ID: <CANCKTBt2J0c54jLO9C0coEExLUGtjCioj2SQTAuQkKctgLH79g@mail.gmail.com>
Subject: Re: [PATCH v5 -next 07/11] PCI: brcmstb: Adjust PHY PLL setup to use
 a 54MHz input refclk
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andrea della Porta <andrea.porta@suse.com>, 
	Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 8:01=E2=80=AFAM Stanimir Varbanov <svarbanov@suse.d=
e> wrote:
>
> The default input reference clock for the PHY PLL is 100Mhz, except for
> some devices where it is 54Mhz like bcm2712C1 and bcm2712D0.
>
> To implement this adjustments introduce a new .post_setup op in
> pcie_cfg_data and call it at the end of brcm_pcie_setup function.
>
> The bcm2712 .post_setup callback implements the required MDIO writes that
> switch the PLL refclk and also change PHY PM clock period.
>
> Without this RPi5 PCIex1 is unable to enumerate endpoint devices on
> the expansion connector.
>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> v4 -> v5:
>  - Updated a comment (Jim).
>
>  drivers/pci/controller/pcie-brcmstb.c | 44 +++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index 50607df34a66..03396a9d97be 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -55,6 +55,10 @@
>  #define PCIE_RC_DL_MDIO_WR_DATA                                0x1104
>  #define PCIE_RC_DL_MDIO_RD_DATA                                0x1108
>
> +#define PCIE_RC_PL_PHY_CTL_15                          0x184c
> +#define  PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK         0x400000
> +#define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK      0xff
> +
>  #define PCIE_MISC_MISC_CTRL                            0x4008
>  #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK    0x80
>  #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK    0x400
> @@ -251,6 +255,7 @@ struct pcie_cfg_data {
>         u8 num_inbound_wins;
>         int (*perst_set)(struct brcm_pcie *pcie, u32 val);
>         int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> +       int (*post_setup)(struct brcm_pcie *pcie);
>  };
>
>  struct subdev_regulators {
> @@ -826,6 +831,38 @@ static int brcm_pcie_perst_set_generic(struct brcm_p=
cie *pcie, u32 val)
>         return 0;
>  }
>
> +static int brcm_pcie_post_setup_bcm2712(struct brcm_pcie *pcie)
> +{
> +       const u16 data[] =3D { 0x50b9, 0xbda1, 0x0094, 0x97b4, 0x5030, 0x=
5030, 0x0007 };
> +       const u8 regs[] =3D { 0x16, 0x17, 0x18, 0x19, 0x1b, 0x1c, 0x1e };
> +       int ret, i;
> +       u32 tmp;
> +
> +       /* Allow a 54MHz (xosc) refclk source */
> +       ret =3D brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, SET_ADDR_OFF=
SET, 0x1600);
> +       if (ret < 0)
> +               return ret;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(regs); i++) {
> +               ret =3D brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, regs=
[i], data[i]);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       usleep_range(100, 200);
> +
> +       /*
> +        * Set L1SS sub-state timers to avoid lengthy state transitions,
> +        * PM clock period is 18.52ns (1/54MHz, round down).
> +        */
> +       tmp =3D readl(pcie->base + PCIE_RC_PL_PHY_CTL_15);
> +       tmp &=3D ~PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK;
> +       tmp |=3D 0x12;
> +       writel(tmp, pcie->base + PCIE_RC_PL_PHY_CTL_15);
> +
> +       return 0;
> +}
> +
>  static void add_inbound_win(struct inbound_win *b, u8 *count, u64 size,
>                             u64 cpu_addr, u64 pci_offset)
>  {
> @@ -1189,6 +1226,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>                 PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_=
MASK);
>         writel(tmp, base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
>
> +       if (pcie->cfg->post_setup) {
> +               ret =3D pcie->cfg->post_setup(pcie);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
>         return 0;
>  }
>
> @@ -1715,6 +1758,7 @@ static const struct pcie_cfg_data bcm2712_cfg =3D {
>         .soc_base       =3D BCM7712,
>         .perst_set      =3D brcm_pcie_perst_set_7278,
>         .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
> +       .post_setup     =3D brcm_pcie_post_setup_bcm2712,
>         .quirks         =3D CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN,
>         .num_inbound_wins =3D 10,
>  };
> --
> 2.47.0
>
Hi Stan,
Any reason you didn't make this a quirk like the other commit?
Reviewed-by: Jim Quinlan <james.quinlan@broadcom.com>

