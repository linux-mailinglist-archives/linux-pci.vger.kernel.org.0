Return-Path: <linux-pci+bounces-29737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9261AD9088
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649CB188F331
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9761C84A1;
	Fri, 13 Jun 2025 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjgtPYEw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1102BAF4;
	Fri, 13 Jun 2025 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826759; cv=none; b=VcwG/aDCgFan1oIVRpYXXY02kcjBr92qQCs73pVLbJjG357lvpW/m2UJt+iL6YF1xAXp+00SK9EHogVCeo48V23G7lD+FgyktZaVPLz3mcPZLZ7fDqYBc56+fd+Tm6QhvlvoQqJ1q21T5nN2Fg6SXbTf8isN1e+h1YGvwNSTyC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826759; c=relaxed/simple;
	bh=Wi+mKmakmDEwMoqmItZexeO6A0PyjaxcjaKR+n0fu14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCoduWGT/TIvQgD/CLkc8DfAVtn50RO8EnTJNgpuSck5YQ2ibbxOGcqKDMSyIc1rtaUiQBgIyb3wCqhaq+8Ri6dasnoz2qlyt9kiLt7vJd4n9r5mSSxYLfgaDGZbBzAVRT/WsVExzBqYBzuRsZ85zwQ/yj5TD8Eq5GXqIJWxP2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjgtPYEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B5AC4CEE3;
	Fri, 13 Jun 2025 14:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749826758;
	bh=Wi+mKmakmDEwMoqmItZexeO6A0PyjaxcjaKR+n0fu14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jjgtPYEw+i0FlOE979WCYV8vcgpJYvTigzyODqm9N9rVd6tiEbmCZhta15yZ/LFTR
	 Tiew59WLUQlbwv+Tv0cb0bBSKpTQS4ui3rvnk1Zo/ic9w1Ncre7NZWLnTXKWYp9ZpC
	 nZ4pMbNAw213uGy+U23KSpNj8D9Zyg+/N8nHmk+2Sc5vcDOjwasOyp9bEFQ1bwF2oV
	 akxrQZmEEq3jmbATpowqgpBjP+0xuK+zfS++q4uBMcjIqYUEboLmRdEVetQDDrTE7l
	 OxBXQ3C5alTjHsSffqsPeu1Ni7G3j7gUgmCREAWl2K/drbRh0bOKnGlsK37Vm431fW
	 JdEoJas+Vh+0w==
Date: Fri, 13 Jun 2025 07:59:15 -0700
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
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-phy@lists.infradead.org, linux-sound@vger.kernel.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, llvm@lists.linux.dev, Tvrtko Ursulin
 <tursulin@igalia.com>
Subject: Re: [PATCH 01/20] bitfield: introduce HWORD_UPDATE bitfield macros
Message-ID: <20250613075915.302ba742@kernel.org>
In-Reply-To: <aEwZcM_leVvB0Cju@yury>
References: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>
	<20250612-byeword-update-v1-1-f4afb8f6313f@collabora.com>
	<5493fd6017de3f393f632125fad95945d1c4294c@intel.com>
	<3683577.irdbgypaU6@workhorse>
	<aEwZcM_leVvB0Cju@yury>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 08:28:40 -0400 Yury Norov wrote:
> > > And perhaps that (and more potential users) could persuade Jakub that
> > > this is not that weird after all?  
> > 
> > I will operate under the assumption that Jakub's opinion will not change
> > as he ignored the commit message that talks about multiple vendors,
> > ignored the cover letter that talks about multiple vendors, and ignored
> > my e-mail where I once again made it clear to him that it's multiple
> > vendors, and still claims it's a Rockchip specific convention.  
> 
> As far as I understood, he concerns not about number of drivers that
> opencode HIWORD_UPDATE(), but that this macro is not generic enough
> to live in bitfield.h. And it's a valid concern - I doubt it will
> be helpful somewhere in core and arch files.

Exactly.

