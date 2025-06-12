Return-Path: <linux-pci+bounces-29620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C31AD7E24
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 00:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D883B338C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 22:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA22422331E;
	Thu, 12 Jun 2025 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyPMHD+j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D921B9C5;
	Thu, 12 Jun 2025 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749765694; cv=none; b=PkyA9yUAvv78t20Fn39+nL+RIWXdkm8yMnPv3lfVkL2n8gFwIyu9zbVlnI4n3m5wiAdqtVmcgpD6b/J9hHBXlpshvLQVh4QlkWEYQ67LOpxor+zPq2mShzxBiM8ni4ffTN8SJiPvD1HG30dGB1Iz3OnwCFYcmwzKt20XOlk+KLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749765694; c=relaxed/simple;
	bh=4c23EVlBRbC0Sh2HVGAeTrWF8ckuRzyb3wIApq3EJ0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJcJU4jgCcMGplb8mOjiAq2nK7+ULIL42fWp+Ob/Q7Rwr4yF+l2XqiSG7GpQJ1W6EzzZwfvVALf2OsaOL3BE5KdCSWSQ19W8V+hMlUpe3ak0mvPss7q3lXpcsGBnbfMkfQh1QTGBSCAmWgBoM/UCp/mu49LSj/ofJshpvD4NamQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyPMHD+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E14DC4CEEA;
	Thu, 12 Jun 2025 22:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749765693;
	bh=4c23EVlBRbC0Sh2HVGAeTrWF8ckuRzyb3wIApq3EJ0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pyPMHD+jhG+UTqABmIsWKlZaWpYwYT8yRbeTaj6af6mv0CScs81OZC14hEgpOQpqo
	 RxUjx7u0c04zWdOWA3HP8r3YCxfTUGgt7/6IXy+olWrZBlDDPCnHfJ2v85tlNdrCRD
	 UXqXIBSfdaqN7b2Zw9ekGq/d+2TWFahI8NypgSV/iEUgbik9cuIv4+7KQ4X2/YGiui
	 ToRHQcO0nLaHP41ty5z3+YlPdDtFsHUjqfXoXCbBt0r8dFq6GTqY/uU3iMpROb1OVO
	 RPp4P9+AYRiUOFuciFsilpSUhTCO/Q80c3PWR/d5rsYLxFbYNnCdfYj4zHkbScfKyp
	 +9szYBH1OtjOA==
Date: Thu, 12 Jun 2025 15:01:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Rasmus Villemoes
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
Message-ID: <20250612150130.36b01844@kernel.org>
In-Reply-To: <aEs0PVkwFN9uRgU0@yury>
References: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>
	<20250612-byeword-update-v1-1-f4afb8f6313f@collabora.com>
	<20250612124415.3399e26b@kernel.org>
	<22744779.EfDdHjke4D@workhorse>
	<aEs0PVkwFN9uRgU0@yury>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 16:10:37 -0400 Yury Norov wrote:
> I don't think that that having HWORD_UPDATE() in bitfield.h is a wrong
> thing. Jakub, if you do, we can just create a new header for it.

Yes, I'd prefer to contain it. This looks very much like a CSR tooling
convention of Rockchip's ASIC developers. IOW this is really about how
CSRs are access for a specific vendor, not a generic bitfield operator.

