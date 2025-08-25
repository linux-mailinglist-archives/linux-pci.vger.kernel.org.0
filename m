Return-Path: <linux-pci+bounces-34667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85891B346E6
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 18:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880D42A494A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F14C302745;
	Mon, 25 Aug 2025 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbdBBock"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1933019D9;
	Mon, 25 Aug 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138305; cv=none; b=nrEDRNN/SupWSrmlOD/eSP8DDeVp4Q1eK0r3oT+CdLzP5Jw00Yug9Cee7ddH4gaVqGDG3/z0FGevvYxeaElpv1MnZYFrRLzUfIL1iDoIVh0hfIXx/fYWMS4IxUpLs9V0kgT4RJBhQhGguzDLxQhvvX/tGuEMFDMIvIkbJdvSFm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138305; c=relaxed/simple;
	bh=aNQomJuptJF2BKrENvq9UPqvAr9yynnLcyovKghIDS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXOCfdmLJz2w7j5UIV0mgL6YvIaNXSEH9wsJWQ4JuET7hwqW7cU6Nne8FhVjlQLid+cj/9P/aYr+W+2lDO/Gk0quDTht7xpS2DUDxk8da9GLWOYIxb3uzYMXaVCEgcDXxx/K/XlL1fmySBHT/apwf9MBp2okiHwgFqKtM7oXkZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbdBBock; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7597DC4CEED;
	Mon, 25 Aug 2025 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756138305;
	bh=aNQomJuptJF2BKrENvq9UPqvAr9yynnLcyovKghIDS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qbdBBockwrqRSRbw1MmR0KGBgFfM9D+8u941MSUikW6NAWC90PRGbB0i6q8xVc7EB
	 ITtR7PKuJRYXp473MCFXNHbrMeu1xzcPS8rvekbCjxur0Cgas0asZxh/sg5bPCJ4Yt
	 ohpHqVkmF+hyu51Nre17dv6f2mgh2HiI8NuD9Xb3cR84DWnrVzbPaGSQrRHxnl1U6y
	 2IyWulIJ6dZe/CXBxBaGj/+CWPuG78wYZ8PvwEfbFooB8+zBx4OPjXJ2w0JgYdY3gf
	 xrAbQ/hJOPOYzKDzm6FFiiBBES+bP9TnqmD5pPqEw1PnWcfr1jdJhfYICS0XGjSeg3
	 AmjAHniT18djA==
Date: Mon, 25 Aug 2025 09:11:42 -0700
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
Subject: Re: [PATCH v3 01/20] bitmap: introduce hardware-specific bitfield
 operations
Message-ID: <20250825091142.3735f1fe@kernel.org>
In-Reply-To: <20250825-byeword-update-v3-1-947b841cdb29@collabora.com>
References: <20250825-byeword-update-v3-0-947b841cdb29@collabora.com>
	<20250825-byeword-update-v3-1-947b841cdb29@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 10:28:21 +0200 Nicolas Frattaroli wrote:
> Hardware of various vendors, but very notably Rockchip, often uses
> 32-bit registers where the upper 16-bit half of the register is a
> write-enable mask for the lower half.

Acked-by: Jakub Kicinski <kuba@kernel.org>

