Return-Path: <linux-pci+bounces-29607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E3AD7B7E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 21:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADDC3A36EB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 19:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72412D4B4B;
	Thu, 12 Jun 2025 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMsZzzLb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28071B3957;
	Thu, 12 Jun 2025 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757934; cv=none; b=s01SWd9PWHBHayeSjywJI1oYRCCkl+pw8o5yoUTwSVq/hH7anKEdZ5yjJikrHbH4YqAukMFh74LPx/wh8MIwsDcxBXmuYxDroRtX6JtLBcKtTCLQ9hdV1wXoBMwrKeitde3RDhFZQiPTEeQvestBy4bcsLP+xJzVgkf8f5Mw/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757934; c=relaxed/simple;
	bh=O7zV3Lco1nwdNarkpE/eZX7hpR2BG22WPgnzvO4uYgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXS2qFUeC8581sbONh7yz7/xBz5nwHDASGXn5wgbhLkw/bwwuDXB8m71zdrrVTq96xgz2zjZpDzVG+u/cNgh1EeXVXiugoXZtg9ouwRAu6Pp3qtoiyPp8F7GemB89cTVHIWLY9gyciFn/l9kiJEN3owbu3HQxGv2OmshkSaonuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMsZzzLb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73972a54919so1347874b3a.3;
        Thu, 12 Jun 2025 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749757932; x=1750362732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z7xi4YJKAUkKxYZRl9SSrq8Evyr8Lkvoed++01daD1s=;
        b=IMsZzzLbUcRS1rUUo93w0tCF7ltXOSEmxKEOGMt7Frbu/sc4IaR87c9/wsxaHJS2Hu
         AUWPe+ZEggNerQueej09h59BKRFyr28X/ODFettSFrnymcQxxoRFT4KvETPJuU44ioTv
         1aXB4dpgh4Sg19SRZeveq850q0C+Zqu1QHvinjzeLHPusgL3CKl49lN6EITcgqtzm74I
         IWNI7ZTs0fHut1OBZMRzZUoIvL7vV1ZLYKsScq/5ki+9abmRW72/AfLFdSAvalEhUOXH
         OK3NgiESjOwapgb8JEDCzwRNYuxPjUAwCdqAt7mRmIOeuo2l8bN4aeyooPkSzUhv6KS/
         +tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749757932; x=1750362732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7xi4YJKAUkKxYZRl9SSrq8Evyr8Lkvoed++01daD1s=;
        b=DIGsM4JI8iB0/T3K2Y+8GXgoLCjTkMyea5QaLvqkS8+pmLwA+tJW++1A4pzORqMnIK
         PmAN9mFu8V8DOfc/dSNe9Q6BVvPCUybxNlgGjcMyWxNpIrTFcAjAf1Jt/ABBA5MnPvoB
         i2UseGTmcge2JI8VKWBHT9Kh0pyuT4fWDCS1qqaoP2gu027pSdK+4BT1bDtgoq+GgTBh
         v98qCWGOH3nmzjL+gnHeWHkIU7hlOAoGBH2KtzpH9UBUxqCsS33zDl00mgWL7YB5UXzG
         oH3K7RZ5sR/CSz22F6W7izXb415MYqqmJq9bXlzVFq3BOjkY9fYH4C4Di8qytkY427A3
         N7xg==
X-Forwarded-Encrypted: i=1; AJvYcCUrDpfXUXyUGCV+iiSsr31kTYq5jiQsOn6frCGaASgWZeatvU6pQBF1tBbB70cVrL3j/skqUBfqZu4=@vger.kernel.org, AJvYcCV/NURKTbNAOJSIra/UOgCYFfaGops8Ud3pJnOFSTi4iDei4z5W0tChH/oXeEeNkzAVTBE1+2Ce+VuBb+g=@vger.kernel.org, AJvYcCV0gS7wiMKoeA1CgFs8KDqZysskjlVvRsbi3BDxfPWBq8+KePocd69dW2YF7J1R64yJ13SB6ZTfKiRtQY0O@vger.kernel.org, AJvYcCVPB3KNgFz9BATtXFJzzump+KQDu5f85oyBTZbZv5H12X6Izp3tpL2Xe87EFFdKIKyg8A6Bna297lKnKPQ=@vger.kernel.org, AJvYcCWcT26dytFnI2a+6s5ol+y75aPqi20PkIScLkUfpnH+VdTVVqAEzpoimCqTam582C30atb22xTjwas=@vger.kernel.org, AJvYcCXEObjcnqTlltyisGWFerfHOTpqBkSf4e97CNKaHKagiwtR7L6uI9Pki2O84hjWNwIaFcgQgh8SuAs0@vger.kernel.org, AJvYcCXkKqT0Fnnux0N1XHXgGb/38hDgsevdSFhqq/vAO2LmUeS1nNyXjJJ4CHrmug7bjKjvNArOvYo+@vger.kernel.org, AJvYcCXoeV3Lwa3uGgn9LEzRCKugt4R9DtntwmhTZeNg2ces+aC4weZ9KEHPZFYyZsOSet9Wlpl6qTE0VyeK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy2PQ1zgTkW+fJJa9pLG8+F1PV0zBA5PXPhsTrSSe3e6XsFo31
	kF8ZO5PzFqR68oO9GD8G8tJWmBreHqwBDzM8v/OiDTQaEJAupWs4g7pk
X-Gm-Gg: ASbGncsRMYIKirtwq9Pj7ktNfilvtiXr4VvYLStsPX8N+u/CnEhkI8ARjN22Yz8upG+
	K8u7o0J3xGf22ye4m6B2T1RWQHU690/vvV3Gw9Biuw5ezOqiryFb+F8PWb3gs87zKGXyXxilslF
	NDtlR08bZTiAY/Y9UFQVpDt+XDuDAuXKZv6pLQptcP+04I0iDyN8Oi/TiSOoaXQ2D42KtN2K+FT
	NeltBEU2xZUzaFRCwkoc3YFNa5ZRcC4LxJ/LCwMZ2YfuIkGjIwoV84rj0A2XdwWqzuYqz/A/fLC
	kJLSsWQZg7cqmcUErEIQrOeJPXidryN3iRQbhP8chXjfMPJj/ZAhuThZ6mE8JA==
X-Google-Smtp-Source: AGHT+IEU8m2F+5mxJ4HQROetGJB4LGA8zrpWrZ/HojR3rTDhNg8kjwUPP475HlXQvhwtX4Onlx73lw==
X-Received: by 2002:a05:6a00:b87:b0:736:450c:fa54 with SMTP id d2e1a72fcca58-7488f6c9155mr687345b3a.6.1749757932319;
        Thu, 12 Jun 2025 12:52:12 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffeca70sm123370b3a.21.2025.06.12.12.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 12:52:11 -0700 (PDT)
Date: Thu, 12 Jun 2025 15:52:09 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
Subject: Re: [PATCH 16/20] PCI: rockchip: switch to HWORD_UPDATE* macros
Message-ID: <aEsv6X5JSQkpmwvP@yury>
References: <20250612-byeword-update-v1-16-f4afb8f6313f@collabora.com>
 <20250612193728.GA924118@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612193728.GA924118@bhelgaas>

On Thu, Jun 12, 2025 at 02:37:28PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 12, 2025 at 08:56:18PM +0200, Nicolas Frattaroli wrote:
> > The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
> > drivers that use constant masks.
> > 
> > The Rockchip PCI driver, like many other Rockchip drivers, has its very
> > own definition of HIWORD_UPDATE.
> > 
> > Remove it, and replace its usage with either HWORD_UPDATE, or two new
> > header local macros for setting/clearing a bit with the high mask, which
> > use HWORD_UPDATE_CONST internally. In the process, ENCODE_LANES needed
> > to be adjusted, as HWORD_UPDATE* shifts the value for us.
> > 
> > That this is equivalent was verified by first making all HWORD_UPDATE
> > instances HWORD_UPDATE_CONST, then doing a static_assert() comparing it
> > to the old macro (and for those with parameters, static_asserting for
> > the full range of possible values with the old encode macro).
> > 
> > What we get out of this is compile time error checking to make sure the
> > value actually fits in the mask, and that the mask fits in the register,
> > and also generally less icky code that writes shifted values when it
> > actually just meant to set and clear a handful of bits.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> Looks good to me.  I assume you want to merge these via a non-PCI tree
> since this depends on patch 01/20.  PCI subject convention would
> capitalize "Switch":

Hi,

I'd like to take patch #1 and the explicitly acked following patches in
my bitmap-for-next.Those who would prefer to move the material in their
per-driver branches (like net, as mentioned by Andrew Lunn) can wait
till the end of next merge window, and then apply the patches cleanly.

Thanks,
Yury

>   PCI: rockchip: Switch to HWORD_UPDATE* macros
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> > ---
> >  drivers/pci/controller/pcie-rockchip.h | 35 +++++++++++++++++-----------------
> >  1 file changed, 18 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> > index 5864a20323f21a004bfee4ac6d3a1328c4ab4d8a..5f2e45f062d94cd75983f7ad0c5b708e5b4cfb6f 100644
> > --- a/drivers/pci/controller/pcie-rockchip.h
> > +++ b/drivers/pci/controller/pcie-rockchip.h
> > @@ -11,6 +11,7 @@
> >  #ifndef _PCIE_ROCKCHIP_H
> >  #define _PCIE_ROCKCHIP_H
> >  
> > +#include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/kernel.h>
> >  #include <linux/pci.h>
> > @@ -21,10 +22,10 @@
> >   * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
> >   * bits.  This allows atomic updates of the register without locking.
> >   */
> > -#define HIWORD_UPDATE(mask, val)	(((mask) << 16) | (val))
> > -#define HIWORD_UPDATE_BIT(val)		HIWORD_UPDATE(val, val)
> > +#define HWORD_SET_BIT(val)		(HWORD_UPDATE_CONST((val), 1))
> > +#define HWORD_CLR_BIT(val)		(HWORD_UPDATE_CONST((val), 0))
> >  
> > -#define ENCODE_LANES(x)			((((x) >> 1) & 3) << 4)
> > +#define ENCODE_LANES(x)			((((x) >> 1) & 3))
> >  #define MAX_LANE_NUM			4
> >  #define MAX_REGION_LIMIT		32
> >  #define MIN_EP_APERTURE			28
> > @@ -32,21 +33,21 @@
> >  
> >  #define PCIE_CLIENT_BASE		0x0
> >  #define PCIE_CLIENT_CONFIG		(PCIE_CLIENT_BASE + 0x00)
> > -#define   PCIE_CLIENT_CONF_ENABLE	  HIWORD_UPDATE_BIT(0x0001)
> > -#define   PCIE_CLIENT_CONF_DISABLE       HIWORD_UPDATE(0x0001, 0)
> > -#define   PCIE_CLIENT_LINK_TRAIN_ENABLE	  HIWORD_UPDATE_BIT(0x0002)
> > -#define   PCIE_CLIENT_LINK_TRAIN_DISABLE  HIWORD_UPDATE(0x0002, 0)
> > -#define   PCIE_CLIENT_ARI_ENABLE	  HIWORD_UPDATE_BIT(0x0008)
> > -#define   PCIE_CLIENT_CONF_LANE_NUM(x)	  HIWORD_UPDATE(0x0030, ENCODE_LANES(x))
> > -#define   PCIE_CLIENT_MODE_RC		  HIWORD_UPDATE_BIT(0x0040)
> > -#define   PCIE_CLIENT_MODE_EP            HIWORD_UPDATE(0x0040, 0)
> > -#define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
> > -#define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
> > +#define   PCIE_CLIENT_CONF_ENABLE		HWORD_SET_BIT(0x0001)
> > +#define   PCIE_CLIENT_CONF_DISABLE		HWORD_CLR_BIT(0x0001)
> > +#define   PCIE_CLIENT_LINK_TRAIN_ENABLE		HWORD_SET_BIT(0x0002)
> > +#define   PCIE_CLIENT_LINK_TRAIN_DISABLE	HWORD_CLR_BIT(0x0002)
> > +#define   PCIE_CLIENT_ARI_ENABLE		HWORD_SET_BIT(0x0008)
> > +#define   PCIE_CLIENT_CONF_LANE_NUM(x)		HWORD_UPDATE(0x0030, ENCODE_LANES(x))
> > +#define   PCIE_CLIENT_MODE_RC			HWORD_SET_BIT(0x0040)
> > +#define   PCIE_CLIENT_MODE_EP			HWORD_CLR_BIT(0x0040)
> > +#define   PCIE_CLIENT_GEN_SEL_1			HWORD_CLR_BIT(0x0080)
> > +#define   PCIE_CLIENT_GEN_SEL_2			HWORD_SET_BIT(0x0080)
> >  #define PCIE_CLIENT_LEGACY_INT_CTRL	(PCIE_CLIENT_BASE + 0x0c)
> > -#define   PCIE_CLIENT_INT_IN_ASSERT		HIWORD_UPDATE_BIT(0x0002)
> > -#define   PCIE_CLIENT_INT_IN_DEASSERT		HIWORD_UPDATE(0x0002, 0)
> > -#define   PCIE_CLIENT_INT_PEND_ST_PEND		HIWORD_UPDATE_BIT(0x0001)
> > -#define   PCIE_CLIENT_INT_PEND_ST_NORMAL	HIWORD_UPDATE(0x0001, 0)
> > +#define   PCIE_CLIENT_INT_IN_ASSERT		HWORD_SET_BIT(0x0002)
> > +#define   PCIE_CLIENT_INT_IN_DEASSERT		HWORD_CLR_BIT(0x0002)
> > +#define   PCIE_CLIENT_INT_PEND_ST_PEND		HWORD_SET_BIT(0x0001)
> > +#define   PCIE_CLIENT_INT_PEND_ST_NORMAL	HWORD_CLR_BIT(0x0001)
> >  #define PCIE_CLIENT_SIDE_BAND_STATUS	(PCIE_CLIENT_BASE + 0x20)
> >  #define   PCIE_CLIENT_PHY_ST			BIT(12)
> >  #define PCIE_CLIENT_DEBUG_OUT_0		(PCIE_CLIENT_BASE + 0x3c)
> > 
> > -- 
> > 2.49.0
> > 

