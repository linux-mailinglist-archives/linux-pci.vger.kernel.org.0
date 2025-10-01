Return-Path: <linux-pci+bounces-37337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FECBAFE42
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 11:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C3316B001
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4AA2D9EE0;
	Wed,  1 Oct 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcqErpp7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9C278150;
	Wed,  1 Oct 2025 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311537; cv=none; b=sR0CYKFEEcqn/DKsuTHV3VijZ5FMwgCOjdHH96bcfKPQHNfrjEvRF60Gmu6HEb3TM6P/tC5XYtB1gxImAe1nIlaEOVC5sAhDHEQryQt/wyI67KXkggtAlnZJ1auoElaTHOj4kbGUTk4sKhfRjPgdVewQZqRC7MDGKFTvjL1pdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311537; c=relaxed/simple;
	bh=H6syAT5lGzrU3swJYL8VgnwKi0EYbeSgtN9L4OFu5Z8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y+9gR5iaVmoU9Qtxgex5TQuygtuRkYfhL+ltQUqO9pIKniSGicpKn/8F76NelS3o0QpmCtyoCvTpxwSNZ/xo5Eg/iPT5TzWkeBQN8oiyrefQaJegfRIwOG/usHmwZIfSZPZ5cqAQdmWD7WTcKhtLNTbL/5yg5U2Xhr6k5lhPMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcqErpp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3EDC4CEF4;
	Wed,  1 Oct 2025 09:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759311536;
	bh=H6syAT5lGzrU3swJYL8VgnwKi0EYbeSgtN9L4OFu5Z8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=fcqErpp7qrjU9McG/p/HpxRq8Hc/eEK9ROwv483siLY2lhXUhIJ4c10tRVmSipFCy
	 H1cUoUwY6REYQYV8WZwfdmDRlOhGGnduKJbFWz93kohU/Guq8JtYyLLoPuRM9+k2Hv
	 GQvQyN+JNnqYbtW7JVcEer1SJyOhrb3ztKSs1aeFSwZHA8vy7a8Obil+4o19c8sqTi
	 LPaIAjUoYTPSJX1vmEMzX+6OQPM0sPKz6KzJsQMYGs4GR0oonRwRzzlehm64B6DYX3
	 FSXty0SlySmG4Um4P4euAUBoFTJ3AHrhBhxWcvfu7azQZtRldOU8fu+H9v3hTxPnN4
	 UPsnsd24Vl83w==
Message-ID: <50676923-1daf-4c15-a289-a791242664f4@kernel.org>
Date: Wed, 1 Oct 2025 11:38:45 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v3 04/20] media: synopsys: hdmirx: replace macros with
 bitfield variants
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
References: <20250825-byeword-update-v3-0-947b841cdb29@collabora.com>
 <20250825-byeword-update-v3-4-947b841cdb29@collabora.com>
Content-Language: en-US, nl
In-Reply-To: <20250825-byeword-update-v3-4-947b841cdb29@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/08/2025 10:28, Nicolas Frattaroli wrote:
> The era of hand-rolled HIWORD_UPDATE macros is over, at least for those
> drivers that use constant masks.
> 
> Replace the UPDATE macro with bitfield.h's FIELD_PREP, to give us
> additional error checking.
> 
> Also, replace the HIWORD_UPDATE macro at the same time with the new
> FIELD_PREP_WM16 macro in hw_bitfield.h, which also gives us additional
> error checking.
> 
> The UPDATE/HIWORD_UPDATE macros are left as wrappers around the
> replacement macros, in order to not rock the boat too much, and keep the
> changes easy to review.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

> ---
>  drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h
> index 220ab99ca61152b36b0a08b398ddefdb985709a5..b26668a98aafd1682b8342cc11f84666a13f07a3 100644
> --- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h
> +++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.h
> @@ -8,10 +8,12 @@
>  #ifndef DW_HDMIRX_H
>  #define DW_HDMIRX_H
>  
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/hw_bitfield.h>
>  
> -#define UPDATE(x, h, l)		(((x) << (l)) & GENMASK((h), (l)))
> -#define HIWORD_UPDATE(v, h, l)	(((v) << (l)) | (GENMASK((h), (l)) << 16))
> +#define UPDATE(x, h, l)		(FIELD_PREP(GENMASK((h), (l)), (x)))
> +#define HIWORD_UPDATE(v, h, l)	(FIELD_PREP_WM16(GENMASK((h), (l)), (v)))
>  
>  /* SYS_GRF */
>  #define SYS_GRF_SOC_CON1			0x0304
> 


