Return-Path: <linux-pci+bounces-29604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EBDAD7B51
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 21:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF08E17149C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 19:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF3B2D540E;
	Thu, 12 Jun 2025 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw5CTAM+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3C2D4B4B;
	Thu, 12 Jun 2025 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757506; cv=none; b=q6LYO1J7mLrwBAr5WTU5WdGwLyP/ahddtk1Q1A6EzRj7eKNziy6qxutuzh9k85/ENQjH/9howtCE0E3s+NsRZV3CrU1fXMt3nVWh/tc+oxGFurAXZYbm9cEDHwZF2hRc2ndIHrvAeQCpccqcgktLBwMmtECvh2PPqCLdOl6GyHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757506; c=relaxed/simple;
	bh=z7IjcxE0YEacFXgAh4xDDX9VpxqkPXW2KpAMNhWrpgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOfkD6WzR+gftMIOcZ9WW2t2QcureOrCR0A1/msWB4U4fpTB9Yln5fAWCNCdcwUsrqYoMwFYEUXTqe726UXgMjvagLDdftWLs9JTesNdlivrNxqlAZeGz1V8wEFyo+U/k2OFQvDDwEXRcMv+P0eWaBMC9URpA/DBSVVXXNu+xQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw5CTAM+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso1339072b3a.2;
        Thu, 12 Jun 2025 12:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749757504; x=1750362304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3L1BRXMYQOPZXwWB+HufjRJxBYhvQ+eeWRIbfY6WI0=;
        b=fw5CTAM+SD6Ff4boxtNj1XYbmp6B5yjfkKnpIU9YPqLPsYdb+HXQgCY38FzsXnnpGK
         dR85EEsW0itWEwsDzVT2BYzL0c14XadYl5fzF1hKQS3L/oQ7ZGd8jEsDoBIugPW5axpc
         q8w3UCMqbqgtSsqUtDb0UtZkY3DPybAbXts/MFNudtIGY61kol0V33jy1LY5Y/N7PKkk
         9MUoVTEXr0lq0d3ivNk0S+cD3OxRt30hvyUYiYNuLTX3PCZCgpHbhxIt3JluKt2mO2Y3
         /5E8juDiOYjG5MNj9LopAk2n8xIbdjtzf/YR0uOm2aN9lQ+i9b618tYN36EbEnzQzKkT
         Ux0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749757504; x=1750362304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3L1BRXMYQOPZXwWB+HufjRJxBYhvQ+eeWRIbfY6WI0=;
        b=RbdtUnf7N+Y3Lc9Sy7u+lNrqEkKznXnWgkZOgKqaJybZj/Z65NQALhnLK8QN4wq29Z
         dMVEifUyEAppDbC9pX4kfac9lemIuWTK6Qjzg4HHWejqBiGNx+rakRcbqIEAg8k/GHMA
         wjC1jGbJoVBgzs6xy2aQsXJmuSJ1Xr85muA+e9Hy5/cOPO1e/wylkwF5q2DxOZ1NPLu6
         532paJd03wrh85Lzym50r5+GjFfss8plDojIKz3rRtC2hGcp7WEkxI60HSpkv9/pKdC7
         Z1gHR25aIKjE/ZNxteSvdxvxKzx0IVLTvMBRddTTwOjjE2fM/ltkrHpE/m+DvQYtl3jz
         NE6g==
X-Forwarded-Encrypted: i=1; AJvYcCUS4Gj5o1bMD7T0bGh7bWeVf3T41FZ/R/ER8/dq57a6UnOFvABmLJNXxM7+CtY9EgmI6cB2Ol0Lz48=@vger.kernel.org, AJvYcCV/vgZ/57r23DYZXx7ch7BF6eAURotFjA1mljsXwYK1b2yKn3B3QIt9oZpnBtJS8sn/l7/8uoT5EDszdn0=@vger.kernel.org, AJvYcCVZj7jGGwB3+R1SCohuzoCMBv+5+Xrtm51+S7m7Rv3OZ/Ndf5LRg+rBSgXG0SJtAj7nw6Ni+9eapW3t@vger.kernel.org, AJvYcCVuKbxahCLnWNGFgNDvrz/kC8AZsHqo6DN1TYcEvY8UwpTVp28hYFXpbYBQte/CET/u0wzjAok2@vger.kernel.org, AJvYcCWBXH8HugcgvsaRcI19ogmyAwnrqCM1PMb2CdsSpUjGJmOUYlB2F9wCfmS11na48njW6Nz5YjSHBb1d@vger.kernel.org, AJvYcCWXHi7V3Ih3Rn1fFhJMxM2CdOi5M6+dhhwUnF4l/7jtfZIACttlVgw1XT4LhiwZA+dE5K3rkicwmuEMgSfz@vger.kernel.org, AJvYcCWvPtPNS/EtKZqVWN93zPp1aViKgfWUQZ8+oz16lwvoWhHe0FhcDCwOS0jrNTY0Ivezn/2GelOjTGo=@vger.kernel.org, AJvYcCXLO3xy4tx4zei5ZjATr9t3h1zCbmlDczvhWXdYOGlQRbGB5pICt5cR1WIVSQZg4C+aw3X9fFo02tUTrVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUqtrUSI9q+GhmD1k+eC4+xPTOtK4htSQyJBq1MFQFJ6VdPqtG
	NF2eCu43Xme6seqH6Wr+QMfFmFoc4yfzP939xRKA0+gOOdjsIA7kE8eB
X-Gm-Gg: ASbGncv9D3ZELCkaWcTgkP88SCI+L/fCTIWvfBqmsMnwYWwU0pEARRewcpS3O4tnkhh
	9FbVpOPa/bFx6XF8pXnpo3sFInroCfqR/dqM/oE3ulpc+yFjP5ar4HGHrr/v7WqrToH8AZiCSvk
	7gfKbOjwkK+Az0kV65jGUnkvFwbFnTrBK8vZNOkmWZdHXwmjn3hWDxwCH6MReL3uYSAmoSySe1y
	V6hrZwZo2Az9KRGUxHUv/EG2ix9esSvkPxEqnmf9ZXtqnMeldCsGitjOGXHBwMP9LZTMF2fwC5K
	0xoQeQYje4BWRbdrCZLCk3iEDrSXCc6a3dxxPU+F8iglPArCKDhZOXQjsbXpqg==
X-Google-Smtp-Source: AGHT+IH5SI3hUshSKHU0j6QBfj5JqczafiiFC8/0KUaseCcKbsSGpfUoReyErqftJzmx0fPZHAtJ2w==
X-Received: by 2002:aa7:88c2:0:b0:740:6f69:f52a with SMTP id d2e1a72fcca58-7488f485015mr691851b3a.0.1749757503807;
        Thu, 12 Jun 2025 12:45:03 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890082859sm109585b3a.104.2025.06.12.12.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 12:45:03 -0700 (PDT)
Date: Thu, 12 Jun 2025 15:45:00 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Qin Jian <qinjian@cqplus1.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
	linux-sound@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 00/20] BYEWORD_UPDATE: unifying (most) HIWORD_UPDATE
 macros
Message-ID: <aEsuPN-kuQ8cjR7H@yury>
References: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>

On Thu, Jun 12, 2025 at 08:56:02PM +0200, Nicolas Frattaroli wrote:
> This series was spawned by [1], where I was asked to move every instance
> of HIWORD_UPDATE et al that I could find to a common macro in the same
> series that I am introducing said common macro.

And it means, at least for patch #1:

Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
 
> The first patch of the series introduces the two new macros in
> bitfield.h, called HWORD_UPDATE and HWORD_UPDATE_CONST. The latter can
> be used in initializers.
> 
> This macro definition checks that the mask fits, and that the value fits
> in the mask. Like FIELD_PREP, it also shifts the value up to the mask,
> so turning off a bit does not require using the mask as a value. Masks
> are also required to be contiguous, like with FIELD_PREP.
> 
> For each definition of such a macro, the driver(s) that used it were
> evaluated for three different treatments:
>  - full conversion to the new macro, for cases where replacing the
>    implementation of the old macro wouldn't have worked, or where the
>    conversion was trivial. These are the most complex patches in this
>    series, as they sometimes have to pull apart definitions of masks
>    and values due to the new semantics, which require a contiguous
>    mask and shift the value for us.
>  - replacing the implementation of the old macro with an instance of the
>    new macro, done where I felt it made the patch much easier to review
>    because I didn't want to drop a big diff on people.
>  - skipping conversion entirely, usually because the mask is
>    non-constant and it's not trivial to make it constant. Sometimes an
>    added complication is that said non-constant mask is either used in a
>    path where runtime overhead may not be desirable, or in an
>    initializer.
> 
> Left out of conversion:
>  - drivers/mmc/host/sdhci-of-arasan.c: mask is non-constant.
>  - drivers/phy/rockchip/phy-rockchip-inno-csidphy.c: mask is
>    non-constant likely by way of runtime pointer dereferencing, even if
>    struct and members are made const.
>  - drivers/clk/rockchip/clk.h: way too many clock drivers use non-const
>    masks in the context of an initializer.
> 
> I will not be addressing these 3 remaining users in this series, as
> implementing a runtime checked version on top of this and verifying that
> it doesn't cause undue overhead just for 3 stragglers is a bit outside
> the scope of wanting to get my RK3576 PWM series unblocked. Please have
> mercy.
> 
> In total, I count 19 different occurrences of such a macro fixed out of
> 22 I found. The vast majority of these patches have either undergone
> static testing to ensure the values end up the same during development,
> or have been verified to not break the device the driver is for at
> runtime. Only a handful are just compile-tested, and the individual
> patches remark which ones those are.
> 
> This took a lot of manual work as this wasn't really something that
> could be automated: code had to be refactored to ensure masks were
> contiguous, made sense to how the hardware actually works and to human
> readers, were constant, and that the code uses unshifted values.
> 
> https://lore.kernel.org/all/aD8hB-qJ4Qm6IFuS@yury/ [1]
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
> Nicolas Frattaroli (20):
>       bitfield: introduce HWORD_UPDATE bitfield macros
>       mmc: dw_mmc-rockchip: switch to HWORD_UPDATE macro
>       soc: rockchip: grf: switch to HWORD_UPDATE_CONST macro
>       media: synopsys: hdmirx: replace macros with bitfield variants
>       drm/rockchip: lvds: switch to HWORD_UPDATE macro
>       phy: rockchip-emmc: switch to HWORD_UPDATE macro
>       drm/rockchip: dsi: switch to HWORD_UPDATE* macros
>       drm/rockchip: vop2: switch to HWORD_UPDATE macro
>       phy: rockchip-samsung-dcphy: switch to HWORD_UPDATE macro
>       drm/rockchip: dw_hdmi_qp: switch to HWORD_UPDATE macro
>       drm/rockchip: inno-hdmi: switch to HWORD_UPDATE macro
>       phy: rockchip-usb: switch to HWORD_UPDATE macro
>       drm/rockchip: dw_hdmi: switch to HWORD_UPDATE* macros
>       ASoC: rockchip: i2s-tdm: switch to HWORD_UPDATE_CONST macro
>       net: stmmac: dwmac-rk: switch to HWORD_UPDATE macro
>       PCI: rockchip: switch to HWORD_UPDATE* macros
>       PCI: dw-rockchip: switch to HWORD_UPDATE macro
>       PM / devfreq: rockchip-dfi: switch to HWORD_UPDATE macro
>       clk: sp7021: switch to HWORD_UPDATE macro
>       phy: rockchip-pcie: switch to HWORD_UPDATE macro
> 
>  drivers/clk/clk-sp7021.c                           |  21 +--
>  drivers/devfreq/event/rockchip-dfi.c               |  26 ++--
>  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    | 142 ++++++++++-----------
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |  80 ++++++------
>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     |  68 +++++-----
>  drivers/gpu/drm/rockchip/inno_hdmi.c               |  11 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.h       |   1 -
>  drivers/gpu/drm/rockchip/rockchip_lvds.h           |  21 +--
>  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c       |  14 +-
>  .../media/platform/synopsys/hdmirx/snps_hdmirx.h   |   5 +-
>  drivers/mmc/host/dw_mmc-rockchip.c                 |   7 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |   3 +-
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c      |  39 +++---
>  drivers/pci/controller/pcie-rockchip.h             |  35 ++---
>  drivers/phy/rockchip/phy-rockchip-emmc.c           |   3 +-
>  drivers/phy/rockchip/phy-rockchip-pcie.c           |  72 +++--------
>  drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c  |  10 +-
>  drivers/phy/rockchip/phy-rockchip-usb.c            |  51 +++-----
>  drivers/soc/rockchip/grf.c                         |  35 +++--
>  include/linux/bitfield.h                           |  47 +++++++
>  sound/soc/rockchip/rockchip_i2s_tdm.h              |   4 +-
>  21 files changed, 342 insertions(+), 353 deletions(-)
> ---
> base-commit: d9946fe286439c2aeaa7953b8c316efe5b83d515
> change-id: 20250610-byeword-update-445c0eea771d
> 
> Best regards,
> -- 
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

