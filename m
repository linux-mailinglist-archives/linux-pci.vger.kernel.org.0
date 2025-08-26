Return-Path: <linux-pci+bounces-34790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A5B373FE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 22:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A563C1B246B2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 20:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D0F21FF5C;
	Tue, 26 Aug 2025 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Ki9wPHON"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BB218A6AD;
	Tue, 26 Aug 2025 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241137; cv=pass; b=gHOAH6WtgouPSbt8cZu9l+PJaWB6GvGx3U0dqKLh3Ksdnf9Cx3TWuGngzYjSAT7irKagudPipTSJWualQpIxopXRK3sTa2H7M+d7nlhkfB8i2QgpB2QtCaX0vgoaAdEeBYnM7634rIIaenV1Fx+cXKjNxosjovJIQCjYk12x8dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241137; c=relaxed/simple;
	bh=KJjS8I6gJSijIC7JO2aXSuBJftstDuSC97VuLN7ULDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xle5+TQ0wY8fLKfrnBqd4lnoaNdbk5+9aBBc4UhwIB5haPZPyme+9xLxriVrEsEpShEdcHwjc/1CJZozbwR2DNCK1M28c42vZtdbP6TDQRIEvjbrxZir5KCthGC1tLyaijXTHzi3SjXE5qk+FrRhI/I/rlLRnXxhjkj+56SHxI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Ki9wPHON; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756241053; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j2yVxPbvVmnkEx3m/dN6e1AnUw4nYDLYLrQh9jouqxO5BJjiiCr793G8HSPBwBdIjatD9NagViFauNjRfSXiN5OkOvRkuqJsv3BkMAKRRezf9KhkZ9qHONfzjNiYdn92suhyL8w0t2CahFZ6j03Kzk/PHMsJrm8p8efMx+NlI/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756241053; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h44Qfi5J3Y304gTJmb6TLXLe4gIhtF4d/gBhlL0gNV4=; 
	b=N2xtWkuh45RuU2Vs8YqwfZJBv6pw4MgqWCT3y3wTsVdIc4i07F27CpHJTe6r0RHrYKECjA2mdKudHQ73mnL9z6hLRcvSqq2844PABhn+1mHxPbT5bMHwssg/rwWgr6mQ/zKgi0MKUL5PN5Wc1C2feJz+9yYB4bE83Epayd99uKE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756241053;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=h44Qfi5J3Y304gTJmb6TLXLe4gIhtF4d/gBhlL0gNV4=;
	b=Ki9wPHONx+Kgfg+EjzLJhd6LwqGwWdyDua6+Z+EDmJEbzyVUdyErOswt5JJ7uGnV
	yBZm/csgF+b9XzuM3ZCk9g4oG2mnCIHV2SY/tvJsxQ81i+wvrbET0R14VjHnkb41YXS
	mDPO7PRK+qiv+NHwXJGh2VBPtPHhrJ7sOczkb5CI=
Received: by mx.zohomail.com with SMTPS id 1756241051276539.1866484786493;
	Tue, 26 Aug 2025 13:44:11 -0700 (PDT)
Message-ID: <676d88d1-c15a-4648-a4c5-c668e40b12f0@collabora.com>
Date: Tue, 26 Aug 2025 23:43:57 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250825-byeword-update-v3-4-947b841cdb29@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/25/25 11:28, Nicolas Frattaroli wrote:
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

Nit: the extra parens around FIELD_PREP may be omitted

Acked-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

