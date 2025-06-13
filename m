Return-Path: <linux-pci+bounces-29669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 374C2AD8890
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 11:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303B51898A3B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 09:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FF62C159E;
	Fri, 13 Jun 2025 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Nczp9fFB"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F632C158B;
	Fri, 13 Jun 2025 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808570; cv=none; b=tgslY6MMkmeOKd5RECzP5wkps7MBHhEjZN8ZdyF+AXWt9T+qB0n5bOoSfRCrh1WDlTTkZMIYw6cKzT2sJscBX2z8j8HxJ9TP4gjs+SWCMSIU0XBiEUjZctGFl+xG5cjshOVt5PH4pJ6EYDCogDr0BvA88yJ9mSOWe8MM8yEoktE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808570; c=relaxed/simple;
	bh=pI16jTrezXMC5DsfOlc64Ygns89mip62edXF7MVZQ64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dn+priNNURDyj+2Ez7Ll3bx0QBr535G16WU3WENd6dEXbp7Y9CLF3XkfyG0zhvMBzdajfzYRJLBdRzpvRLwUXzOItEOzmSHUcI/RWc2mYZbk0amo3maOn5eU2zhzmGXjqWCRLcObBUvm0+prcErUWBTDNHQXyp8sMzYo2N9zLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Nczp9fFB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749808566;
	bh=pI16jTrezXMC5DsfOlc64Ygns89mip62edXF7MVZQ64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nczp9fFBALuW2yjQHoHHjf8rHOR18K9YS7zGeKXkc8HCMbmYMct7gIzMlS3bSBMIP
	 VEenlQsjCaMLc60IuyRw8dIqewqii4OeKClmg8cPsLWQj+ZfT/ZkHcgcdTL19VBRhy
	 X4XzUd8L8pp9M19Gtz84Iu+VGM6VtLL4DbF+46aplsLX2p0dqXI1JpQpbMypTkwH65
	 jS3Alw/7WB4vpLUpDuqzgst99SmN0WtDK331u10vg8q7XdTV6J+t5/76pilokUxjK4
	 TIN5YC78yJy5CCFVtMESd/4i2KWdaLXFEm7dx3TajvBHpjtniSN9Cf7WkREabKVavL
	 BD8w5uoOCaqHw==
Received: from [192.168.1.90] (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B12E317E0EC0;
	Fri, 13 Jun 2025 11:56:04 +0200 (CEST)
Message-ID: <740bde7c-c2e5-462f-91f5-5dc2a298aa85@collabora.com>
Date: Fri, 13 Jun 2025 12:55:58 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] drm/rockchip: vop2: switch to HWORD_UPDATE macro
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
 <20250612-byeword-update-v1-8-f4afb8f6313f@collabora.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20250612-byeword-update-v1-8-f4afb8f6313f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Nicolas,

On 6/12/25 9:56 PM, Nicolas Frattaroli wrote:
> The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
> drivers that use constant masks.
> 
> Remove VOP2's HIWORD_UPDATE macro from the vop2 header file, and replace
> all instances in rockchip_vop2_reg.c (the only user of this particular
> HIWORD_UPDATE definition) with equivalent HWORD_UPDATE instances. This
> gives us better error checking.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
This LGTM and I also confirm it works as expected on my Radxa boards:
ROCK 3A (RK3568) and ROCK 5B (RK3588).  Hence,

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

