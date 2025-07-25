Return-Path: <linux-pci+bounces-32907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F4BB1159B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 03:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17DF580D14
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 01:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BAF19D06B;
	Fri, 25 Jul 2025 01:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eib7mR13"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D131199EAD;
	Fri, 25 Jul 2025 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406052; cv=none; b=t0wFlsRjVBUfaCE8hAjePHzSic5qk1X6tU+HoxqzWq7lJMAWC3n5mt6zA+fKLrhY3LdR6W+lPUUAWWlAeCFwrTnmMUbFmGOBItpDmK6jJotu+HL7o7NrkCH9n/y3RVI+Y8DNoIt8iB0EqrIJqU69UHnnGzgFC2t48JzIFxChfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406052; c=relaxed/simple;
	bh=QCfq7NK2qUEbOfaVUsUfHClTgphOJ5SqPV/8zEcK5wk=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=SQZpYRqYLeoj22O5azJjKtz0dSQYlUoXktNp35gGemHaBzQ8j6LY6TL0OKt5goHUAWXH1Zyk+Q2LQrnwqsR5eNcMlFKB/W4H6rnhEYjKC6seYqNWY+YLJGTOJA5QPyRPWdUV2eR3SRoiLL0JlbENoor+2g7SLx1tnsRZBQySS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eib7mR13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E852C4CEED;
	Fri, 25 Jul 2025 01:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753406051;
	bh=QCfq7NK2qUEbOfaVUsUfHClTgphOJ5SqPV/8zEcK5wk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=eib7mR13CXAqUYOGvZuBnzmXTI28/D0YWPjLXhdoeP2ORv2J/Bg0cre+NJXHgkvlK
	 JyS6JBrn3yGS57nKM5UJ14FmIckuuILLLwq3pvt1YoDAqLfk5LmjIQCkPIytUlTNpJ
	 cLqu+6QxYzG4zkvPS35ormr/S06tETerOT4NCnCpKMKGLmhpCxgtGoze/ZZkjk3W4R
	 XYJ6vldLFjCDoLxMoZwR5Q274cnYfR/X6eeqcgq8Pt/Zj4QwzHxBIZi6usZGcL3or7
	 h1xE6oTKpeNi3bW0aycHqsQ0vymIyGUOoQjyr1OzMlr8nt92advrsBmVyZRhIuEhEi
	 RsgTts79mDXWw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250623-byeword-update-v2-19-cf1fc08a2e1f@collabora.com>
References: <20250623-byeword-update-v2-0-cf1fc08a2e1f@collabora.com> <20250623-byeword-update-v2-19-cf1fc08a2e1f@collabora.com>
Subject: Re: [PATCH v2 19/20] clk: sp7021: switch to FIELD_PREP_WM16 macro
From: Stephen Boyd <sboyd@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org, linux-sound@vger.kernel.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, llvm@lists.linux.dev, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Andy Yan <andy.yan@rock-chips.com>, Bill Wendling <morbo@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Chanwoo Choi <cw00.choi@samsung.com>, David Airlie <airlied@gmail.com>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, Jakub Kicinski <kuba@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Justin Stitt <justinstitt@google.com>, Kishon Vijay Abraham I <kishon@kernel.org>, Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Manivannan Sadhasivam <mani@kernel.org>, Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Maxime Ripard <mripard@k
 ernel.org>, Michael Turquette <mturquette@baylibre.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Paolo Abeni <pabeni@redhat.com>, Qin Jian <qinjian@cqplus1.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Rob Herring <robh@kernel.org>, Sandy Huang <hjc@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, Shreeya Patel <shreeya.patel@collabora.com>, Simona Vetter <simona@ffwll.ch>, Takashi Iwai <tiwai@suse.com>, Thomas Zimmermann <tzimmermann@suse.de>, Ulf Hansson <ulf.hansson@linaro.org>, Vinod Koul <vkoul@kernel.org>, Yury Norov <yury.norov@gmail.com>
Date: Thu, 24 Jul 2025 18:14:10 -0700
Message-ID: <175340605069.3513.18204498860033427106@lazor>
User-Agent: alot/0.11

Quoting Nicolas Frattaroli (2025-06-23 09:05:47)
> The sp7021 clock driver has its own shifted high word mask macro,
> similar to the ones many Rockchip drivers have.
>=20
> Remove it, and replace instances of it with hw_bitfield.h's
> FIELD_PREP_WM16 macro, which does the same thing except in a common
> macro that also does compile-time error checking.
>=20
> This was compile-tested with 32-bit ARM with Clang, no runtime tests
> were performed as I lack the hardware. However, I verified that fix
> commit 5c667d5a5a3e ("clk: sp7021: Adjust width of _m in HWM_FIELD_PREP()=
")
> is not regressed. No warning is produced.

Does it generate the same code before and after?

