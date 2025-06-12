Return-Path: <linux-pci+bounces-29608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA8DAD7C08
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 22:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E056A1887052
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 20:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D182D6611;
	Thu, 12 Jun 2025 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csQgwIeS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F212036FA;
	Thu, 12 Jun 2025 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759045; cv=none; b=FWz9l54sQwE4daOTdHUsZWueSyjSkNJMZ/3NwBWTl/0UbDu5zis/EjuXt88Ca1OrqJu32u4ani5gN8e3L3OM3uMWlHGuRoXVEvkTNhU/HJjhCGZoGFYor6C/Oex1q36pb/YtFqoLmg4WoXJ/rWEoSWuMiyVq59FmSqx8kaFIPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759045; c=relaxed/simple;
	bh=+YxhKp8pbLzEr9fypYT/DVhapjMVFFU4pxYzJ32Tuf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hc/kSzDfM91rDQ0SJedULB/UCwkjlXPvdyCl1KZgTg1deXvzfH+35R1mnxmu3y+euh6U+cmL/sRGh0GIems0Z2MS+Ip7ydUrDQ6oNbq/7qTrme19M/ppz0CYe99NrDn67VEAowHGIFgySEubtBxscHn6nv3Os0Srb8xEQP+1ptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csQgwIeS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-879d2e419b9so1410578a12.2;
        Thu, 12 Jun 2025 13:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749759040; x=1750363840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ACQzSKiLB081J7RKsan9TDO2EOdfGESNIDhEKLy5me8=;
        b=csQgwIeS8lux0ymDzBSc4rrAlnzd14PfePEdI9tkxvsqE7T4KC1qYq2SZqCI1m5GG5
         k+QWxHllIUOa4K1MzKK4TSiqsNEjJOfrWfwh0JQjg02eFgu/tFPYnGTsZUqo9072j0jk
         DKBlDwTg5Z1ehdy1xIM3+MN9yH+P/5x3Ua5milpx05RzrZkBSCAr9WGcvb+hF9rQm2UL
         vBwTix+p0DKc8uwjZAYIX63iCpZA5h5KWxMujZxnygdv2I8DSn+bx31aLF4LkQA+EvPB
         hidVr238MmjzhNxVEVbf74mMF0E75g6IwPzMSdNRHTPNtQDo04ck0IE6D0WvPW5OhpL6
         H07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749759040; x=1750363840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACQzSKiLB081J7RKsan9TDO2EOdfGESNIDhEKLy5me8=;
        b=B2TQLwh3ebEl2ljSruWymS2FH9PpSnVb42mtuaSNN4F1Ed31aoKibpIuYlMglUgAin
         njOvEWj943VZyydZxXgNRzFn25skl17thd+Z4BnuTMe3nQzSepLDvr6AdW4kIroJWiyF
         /32+Q2nSVR1BREYQtZ7kjvv9e/KglinqRI9xwA47y4dGkslAdzffxZ5FGCQ9hml2FSQV
         yZCXbAkecgE8H3ZXP8011i74LGJD22tlBhkg0sdFKQ0Xb9bzaWc/EaZMOnl6uZlmXOGF
         SSA/qd0c2vviHc8w9vzDckJby5JILFXShjFmq0DRQI/N8K9gBIThhhdMNfDl0vXgtwa0
         XVcA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Mwp7PB+2LWzT+srQJVDpqgTclkrnYaYLEmevJWsbjyF4gpOI2rMR6n41h75HzPQmUs4JIHZl@vger.kernel.org, AJvYcCUeou45KmIbAtjzrsH3KI4oc9VyxgnCdyUTesE5nLS6l5PgboJ8q+wJTyvQ8K0pIwaWhLEnp6MuFZs=@vger.kernel.org, AJvYcCUw+N0ejK6su/66zkkLBlUk5m5GZRkC3CR2E+v/dEJnl7iZhiecmlSb7Gu+hikjCm9Zel6NFa2B6PHG@vger.kernel.org, AJvYcCVSyEfFUZUUG4cuqDVu72nFng4uWOHaa3ZOkxmWne9vsvUGk3jll3amtH7ff9qUFjoBgRJ1HW7hJEzT8Bo=@vger.kernel.org, AJvYcCVmtagSTa+4ezWP6V3SQ8iC0cQfckNBtKxf/vA/jJSDXDZLsH5vUWQjPSmpI0NVy6Ns9WM93kzkWthHS5Hq@vger.kernel.org, AJvYcCWyBqp2sJ6sQKDVZC/4kgAK/MZ8Jz+zA87CAyA/mUfI9MVT5gW24ClbVrpjveXG88QgBOKZp6xegVw=@vger.kernel.org, AJvYcCXfaD2pg6gPZoKxXJcNRUF0XOy0IfF7SVR/T4XBexSRE2to0ZPtiPCbjkodvPNZelqFzxMsTSxYXY1vZdU=@vger.kernel.org, AJvYcCXmNKTaNEMd6Fw4mpLjBJ6WGJD57qnyAVUy86oTe3ZQszFyr698+GLx0CqMBDvd2FNVi2gFERuj+RZa@vger.kernel.org
X-Gm-Message-State: AOJu0YyNi7yRmE4U28f7cvFCUDtfivW9ZASHG9FVtk42V4jDw4u6HrS4
	6jbxqlZcTadPhVkrnJKgu8PlJLK0c1Zf04tmwvDu3wkkJnOlumYw880h
X-Gm-Gg: ASbGnctl0rozPdhjcZyHYybB55FSprwy5e3GBtrfuo5s6KnuPlgfQhKKl5FWtTh7FHQ
	KwKIxnkHYQPqd4rGmgW1i/GOefXkPYcjfpQOSnSuDM3SGRtifVdpZbjOyrhbbUy1ogPciyvvq6h
	S8ZlXGaEMj373OzCXbkjOXkUCaFLOnVOmUG1bDy3vp1SrEpexu3o6rQ0jYefrm1Qb1KY0+8daf0
	7rYHXaYxRIsahNruMra875PgC8uYLzWZYQAEGgNB2ZXTSAR9qK+t3v+cegvtIsoqVOZVyTRB5v7
	sbUB5EIZNUy/L+P9QUNNyKT5TF6HX+2gENGP82m9mWaFBooJehKY4DKEjxmPoA==
X-Google-Smtp-Source: AGHT+IG8TocKyZo9LiHYpgmcLhk97cCKpOT9D/IFBCoE4AePraGyNKa1PzBXNuqHoDVO+xHoWj80Yg==
X-Received: by 2002:a05:6a21:8dc4:b0:1f5:6c94:2cd7 with SMTP id adf61e73a8af0-21fad11efd4mr288514637.42.1749759040324;
        Thu, 12 Jun 2025 13:10:40 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1691d7fsm150701a12.69.2025.06.12.13.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:10:39 -0700 (PDT)
Date: Thu, 12 Jun 2025 16:10:37 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
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
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
Subject: Re: [PATCH 01/20] bitfield: introduce HWORD_UPDATE bitfield macros
Message-ID: <aEs0PVkwFN9uRgU0@yury>
References: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>
 <20250612-byeword-update-v1-1-f4afb8f6313f@collabora.com>
 <20250612124415.3399e26b@kernel.org>
 <22744779.EfDdHjke4D@workhorse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22744779.EfDdHjke4D@workhorse>

On Thu, Jun 12, 2025 at 09:50:12PM +0200, Nicolas Frattaroli wrote:
> On Thursday, 12 June 2025 21:44:15 Central European Summer Time Jakub Kicinski wrote:
> > On Thu, 12 Jun 2025 20:56:03 +0200 Nicolas Frattaroli wrote:
> > > Hardware of various vendors, but very notably Rockchip, often uses
> > > 32-bit registers where the upper 16-bit half of the register is a
> > > write-enable mask for the lower half.
> > 
> > Please limit the spread of this weirdness to a rockchip or "hiword"
> > specific header. To a normal reader of bitfield.h these macros will
> > be equally confusing and useless.
> > 
> 
> That is how this change started out, and then a different maintainer told
> me that this is a commonly used thing (see: the sunplus patch), and
> Rockchip just happens to have a lot of these with consistent naming.

That other maintainer was me, and the macro is indeed not used by rockchip
weirdness solely:

$ git grep HIWORD | grep -v rockchip | wc -l
326

I don't think that that having HWORD_UPDATE() in bitfield.h is a wrong
thing. Jakub, if you do, we can just create a new header for it.

Thanks,
Yury

