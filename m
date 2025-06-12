Return-Path: <linux-pci+bounces-29603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AEDAD7B49
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 21:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E273B29A8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 19:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440BB2D4B57;
	Thu, 12 Jun 2025 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV//cMaW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C829B8D0;
	Thu, 12 Jun 2025 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757460; cv=none; b=uBSxBqJ1/A6B+G2e8TDBpmVoXL5YA4Rb00eeMWVJg1XhAvmjWV5Zf2+nGi1ZhcVqF8kxIt50o3z2sLJySzrbsVCB9LZTtuOVmcY1f9TeEzYbaGcBgE0F+pdjOupHn5yJivtJqoS7nSO9E1fN3u86qmOXta0A7EIajqxkGbJ9FBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757460; c=relaxed/simple;
	bh=WRHnEZE/VavbEbIByL9Ab4jgxIptcm5CTwjQkexAzn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHqZeHuRwGWgGvTutqpkN48bFkyPRevLtn54uo2vv9f7yKJfuBCyOngQGg8+7iv53vsjK9mBedRlTpZvQE4A+Rb0ujCZFDnV5AGBTxrzKAKFUv5rdJnGgmOTl5mSQwoh4G5FnPDIoMSMfVP3ydUKeJ7JNRGdlbJATbesmnvdY6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV//cMaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC383C4CEEA;
	Thu, 12 Jun 2025 19:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749757459;
	bh=WRHnEZE/VavbEbIByL9Ab4jgxIptcm5CTwjQkexAzn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TV//cMaWvCwRdwpfczgwfekYTq4KpVrIcg5pbXUbx2lym+SxZm9g8pySw6t1uZg+7
	 NpdGkBhZz71C/WAv56FOexy3K+ZXwre3cLw88imhzrGxamgghkbXdxsBhA9nk0aeT0
	 MTHlEEt/eKxkiFp29H+KB99+NQXh2ZFc+cVORjPQy+2joq1MRPguBQY9Q7ekUNsTsS
	 aM8WJhaly2F8i1GFUgUf1yz/CaEAzEOeVTjsH1X75uThWjvNm1ioH3Jt0ZAP/Tcyni
	 ulToNy5Bgy0sxqczU9uV4K0qC2uDT4BDggr2pFZ4uTwcIF5ZUdJ52VPmIbZYW2//FG
	 NK7HkgKxhZSwQ==
Date: Thu, 12 Jun 2025 12:44:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Shreeya
 Patel <shreeya.patel@collabora.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Sandy Huang <hjc@rock-chips.com>, Andy Yan
 <andy.yan@rock-chips.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>, Kishon
 Vijay Abraham I <kishon@kernel.org>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Shawn Lin
 <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Qin
 Jian <qinjian@cqplus1.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 01/20] bitfield: introduce HWORD_UPDATE bitfield macros
Message-ID: <20250612124415.3399e26b@kernel.org>
In-Reply-To: <20250612-byeword-update-v1-1-f4afb8f6313f@collabora.com>
References: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>
	<20250612-byeword-update-v1-1-f4afb8f6313f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 20:56:03 +0200 Nicolas Frattaroli wrote:
> Hardware of various vendors, but very notably Rockchip, often uses
> 32-bit registers where the upper 16-bit half of the register is a
> write-enable mask for the lower half.

Please limit the spread of this weirdness to a rockchip or "hiword"
specific header. To a normal reader of bitfield.h these macros will
be equally confusing and useless.

