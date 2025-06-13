Return-Path: <linux-pci+bounces-29672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CF4AD8929
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0514189EAA0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 10:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C41A2D239D;
	Fri, 13 Jun 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hPYQPpsa"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95C92D2382;
	Fri, 13 Jun 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809736; cv=none; b=NR00+fm32/N12qoD4XCO9Neq2GxyfIeCl1jZNoLyLZo0jCDjW/MMseDzwcV+JSS8k1XmNmH08wW/CdZfcLU0Q9IQ1l6zK+qBbl5ixBmuUQAVB6So8HfAB1B2iI0KBDYkSXKtj28UXpuL4OVN4eVTGCjsbfOzRgSo+66UJ5HQ7tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809736; c=relaxed/simple;
	bh=CZqYmHg36RMSs1ABWyY6d1Bd8dHgzQog9KqyX+oH+Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0fzXDBTbSbvWb6aJqdaGIHtHWiBOT4Lkt7HEfBZg1qcJXwau5daPy3eYPvflP2V02GECQNi+FML2RTG59O7klCbOJJYzGKcT2UK2dQuHDZpV6JRPNrzx1V9oW5L8Tflf4e0fK026h99fdtPuExGJZ7MpPKzkaI1zR4lY4sCaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hPYQPpsa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749809732;
	bh=CZqYmHg36RMSs1ABWyY6d1Bd8dHgzQog9KqyX+oH+Lk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hPYQPpsaE6puBxDXojLRDR1BTHvBiTT4DxSG2fp1VqTMJGRFbuJJG9mBWuT6S8Bhr
	 GH0D+YbNoCyVr+h96i86944sAcuSmZLne4zxBO3F4kCdhNHKR+erVRWSOdpRz5lkDJ
	 wY3NGcTphnUWlnonyAZlr/MmsZ1ZUm7B3a21XR6MEdqCyWPtw1eDSKQfxHqeiXE/r/
	 hvmq1iQxB0FK7FYlrQJP97uQsqXPN0+n5N4IzzY0wwQPO40YQ1uuhdQnWhVLglsS+l
	 +qENCeLTD07E8uz/NptSuuyh6+6BgDSlhteAfq4VUg8WXqdhlx+FW5AizQL6LAj3BC
	 E0C8nbLHeNTdw==
Received: from [192.168.1.90] (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A22C17E00AC;
	Fri, 13 Jun 2025 12:15:30 +0200 (CEST)
Message-ID: <c8e3081f-cd0c-48c0-8934-bd81fd681943@collabora.com>
Date: Fri, 13 Jun 2025 13:15:15 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] drm/rockchip: dw_hdmi: switch to HWORD_UPDATE*
 macros
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Sandy Huang
 <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Qin Jian <qinjian@cqplus1.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, llvm@lists.linux.dev
References: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>
 <20250612-byeword-update-v1-13-f4afb8f6313f@collabora.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20250612-byeword-update-v1-13-f4afb8f6313f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Nicolas,

On 6/12/25 9:56 PM, Nicolas Frattaroli wrote:
> The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
> drivers that use constant masks.
> 
> Remove this driver's very own HIWORD_UPDATE macro, and replace all
> instances of it with equivalent instantiations of HWORD_UPDATE or
> HWORD_UPDATE_CONST, depending on whether it's in an initializer.
> 
> This gives us better error checking, and a centrally agreed upon
> signature for this macro, to ease in code comprehension.
> 
> Because HWORD_UPDATE/HWORD_UPDATE_CONST shifts the value to the mask
> (like FIELD_PREP et al do), a lot of macro instantiations get easier to
> read.
> 
> This was tested on an RK3568 ODROID M1, as well as an RK3399 ROCKPro64.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

This again LGTM and I could verify the RK3568 related bits on my Radxa
ROCK 3A board.

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Cheers,
Cristian


