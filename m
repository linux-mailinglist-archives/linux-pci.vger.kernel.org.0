Return-Path: <linux-pci+bounces-34668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 627C1B3471C
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 18:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD597AD27F
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D883304BB4;
	Mon, 25 Aug 2025 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQ7VlgxH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3B304993;
	Mon, 25 Aug 2025 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138322; cv=none; b=J+6iIoluPx0kaQg27SySwSxzD+OmuT7gz8RSBynwra8FNX4NzB+wu1ns5WlV+ESt/9MJ5h/pOa8DFGxAULLulDHNZPsHdO6ga0AVQ3gRxRw2ETXy/L1VE+T/ZzRdY09Y540c+Jw0uvr6tzhpn8EM/i7XZ8eB07TFWaEu2ep8/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138322; c=relaxed/simple;
	bh=lRmwIXXuuVxuUeGAauGH9Bx39v/B949+O0RVAstjSuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMxKl5oZpUpkLdBI+imibDLkTqYEdlPYriEMfv9HL0W7tOY9nfhuLxMwWd2iqM5WS6g/cva11UrPAmX7BTmzDvAgG4TTjiYthpKBo3Q1lbe0NCPa5ZpfXtJL4QcFm8DVQ+TFUv8+rk4ZYEAeua6c+6+5PjouHfle9eAn+DLi5Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ7VlgxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F2DC4CEED;
	Mon, 25 Aug 2025 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756138321;
	bh=lRmwIXXuuVxuUeGAauGH9Bx39v/B949+O0RVAstjSuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cQ7VlgxHju8BEVWwXx8S5s9QO0VAGvXQFLrv/Uk7vG//TkWLtQ958x6s8s27sBA9K
	 ZcC+Vqlxi7SLRsijcAT4VR40IpnOE02lPJoJxRdH4JLlfsembYa20HUZxxM4Ykvuhd
	 gR9Ewz0C17+TNmcjSvn8rsyUEZ3eHGOfihpu+yQUtN2eQgqTq4UevTo4hW53DjKucR
	 RcfXKEtkDNMjSmnffIYVrTmNpy0yJ+On9axRFVmIFarvx0PpkxtcTqBkLOK2JQ/CFW
	 UV/FEDmGacDp6s4U8xtBgsmf+FYq4bHcugm4JlhafhGE0dBr3Z/OCxvHsJZPXPRon0
	 vH/QeTkJt0PjQ==
Date: Mon, 25 Aug 2025 09:11:58 -0700
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
Subject: Re: [PATCH v3 15/20] net: stmmac: dwmac-rk: switch to
 FIELD_PREP_WM16 macro
Message-ID: <20250825091158.07893b12@kernel.org>
In-Reply-To: <20250825-byeword-update-v3-15-947b841cdb29@collabora.com>
References: <20250825-byeword-update-v3-0-947b841cdb29@collabora.com>
	<20250825-byeword-update-v3-15-947b841cdb29@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 10:28:35 +0200 Nicolas Frattaroli wrote:
> The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
> drivers that use constant masks.
> 
> Like many other Rockchip drivers, dwmac-rk has its own HIWORD_UPDATE
> macro. Its semantics allow us to redefine it as a wrapper to the shared
> hw_bitfield.h FIELD_PREP_WM16 macros though.
> 
> Replace the implementation of this driver's very own HIWORD_UPDATE macro
> with an instance of FIELD_PREP_WM16 from hw_bitfield.h. This keeps the
> diff easily reviewable, while giving us more compile-time error
> checking.
> 
> The related GRF_BIT macro is left alone for now; any attempt to rework
> the code to not use its own solution here would likely end up harder to
> review and less pretty for the time being.

Acked-by: Jakub Kicinski <kuba@kernel.org>

