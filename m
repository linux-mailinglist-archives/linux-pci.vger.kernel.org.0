Return-Path: <linux-pci+bounces-30235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 441BCAE1499
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 09:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81DA5A136F
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 07:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD1322687B;
	Fri, 20 Jun 2025 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aw8vMIFr"
X-Original-To: linux-pci@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F77D2253E0;
	Fri, 20 Jun 2025 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750403405; cv=none; b=Y3TsYnZXwGMHupMPQGsitXHzgJaHqqbo+Go3hbsdAfXOjtm0vkenY+lEiJOcu/7slWWI7h3858PFfNM8fgB05KHYXfpBPQsdP8K1zpRdDCrJsruf2k3qNmQaA8Xt58Rk4zIXCT2qiV84Vg453mlCtiz7q82WDsbLjqdC1VDMXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750403405; c=relaxed/simple;
	bh=VJVc/Bqimb/04dTPJhdiePqGlWXQYi6s6TXswEG790U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oH3wYroRFJLoyYi9A748EBqHBpHCwNa3MY9iHjYSWY/cQX5Pn58zRtjBg123kAtyUNyjdGi1q1ckdW27tBp0LyYC/PpmncCbWpuGNyBB3hJdpDF3U9Bv8tfKhslElccYEeSvyKihHfgf+60r7E+i1iv3PkOU8w+Izvdn5ABhN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aw8vMIFr; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750403401;
	bh=VJVc/Bqimb/04dTPJhdiePqGlWXQYi6s6TXswEG790U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aw8vMIFr+cXE2mO/q8Oyu1dt9tnCq1lFaxSAROzAWBthwSXvbUQkKB1U6L6uCSkLL
	 2+acxXCyNDkhpz0/pbbOIZSy1x4qwTS3WjNq1nqRpnfLjTjFo0L1DCpeNywuHWsQNP
	 /xmQNCIlx4wV06dP6nDW2tuKvxvIBMeL/eGduIs1nknST7JZlIbBB3mMSOWU/HGi7u
	 y2y/qZTIOwZgrg6zSoXs3t0MtVzQOeK7/MmIoI9aK6W0XyouS7MCZ00VA2dRKTZQoU
	 ypcf0Lm4d/vLU3gBemeyjhzLtybrXugWPxjIDkxa8T+/Qx3H+QvBYSdQjl4eD/aXfG
	 wY/kl+cgKfeMA==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 40186640A0;
	Fri, 20 Jun 2025 15:09:58 +0800 (AWST)
Message-ID: <10d493cb37748aeb1f4c97856929845727c4c3bc.camel@codeconstruct.com.au>
Subject: Re: [PATCH 6/7] pinctrl: aspeed-g6: Add PCIe RC PERST pin group
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jacky Chou <jacky_chou@aspeedtech.com>, bhelgaas@google.com, 
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org,  krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 vkoul@kernel.org,  kishon@kernel.org, linus.walleij@linaro.org,
 p.zabel@pengutronix.de,  linux-aspeed@lists.ozlabs.org,
 linux-pci@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org,  openbmc@lists.ozlabs.org,
 linux-gpio@vger.kernel.org
Cc: elbadrym@google.com, romlem@google.com, anhphan@google.com,
 wak@google.com,  yuxiaozhang@google.com, BMC-SW@aspeedtech.com
Date: Fri, 20 Jun 2025 16:39:57 +0930
In-Reply-To: <20250613033001.3153637-7-jacky_chou@aspeedtech.com>
References: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
	 <20250613033001.3153637-7-jacky_chou@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-13 at 11:30 +0800, Jacky Chou wrote:
> The PCIe RC PERST uses SSPRST# as PERST#=C2=A0 and enable this pin
> to output.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
> =C2=A0drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 12 +++++++++++-
> =C2=A01 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl=
/aspeed/pinctrl-aspeed-g6.c
> index 5a7cd0a88687..c751703acdb9 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> @@ -17,6 +17,7 @@
> =C2=A0#include "../pinctrl-utils.h"
> =C2=A0#include "pinctrl-aspeed.h"
> =C2=A0
> +#define SCU040=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x04=
0 /* Reset Control Set 1=C2=A0 */
> =C2=A0#define SCU400=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x400 /* Multi-function Pin Control #1=C2=A0 */
> =C2=A0#define SCU404=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x404 /* Multi-function Pin Control #2=C2=A0 */
> =C2=A0#define SCU40C=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x40C /* Multi-function Pin Control #3=C2=A0 */
> @@ -52,7 +53,7 @@
> =C2=A0#define SCU6D0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x6D0 /* Multi-function Pin Control #29 */
> =C2=A0#define SCUC20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00xC20 /* PCIE configuration Setting Control */
> =C2=A0
> -#define ASPEED_G6_NR_PINS 256
> +#define ASPEED_G6_NR_PINS 258
> =C2=A0
> =C2=A0#define M24 0
> =C2=A0SIG_EXPR_LIST_DECL_SESG(M24, MDC3, MDIO3, SIG_DESC_SET(SCU410, 0));
> @@ -1636,6 +1637,12 @@ FUNC_DECL_1(USB11BHID, USBB);
> =C2=A0FUNC_DECL_1(USB2BD, USBB);
> =C2=A0FUNC_DECL_1(USB2BH, USBB);
> =C2=A0
> +#define D7 257
> +SIG_EXPR_LIST_DECL_SESG(D7, RCRST, PCIERC1, SIG_DESC_SET(SCU040, 19),

The documentation for SCU040[19] says it will assert the reset. I
expect that's not what's desired.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SIG_DESC_=
SET(SCU500, 24));

SCU500[24] seems okay.

> +PIN_DECL_(D7, SIG_EXPR_LIST_PTR(D7, RCRST));
> +FUNC_GROUP_DECL(PCIERC1, D7);

It only makes sense to describe pins with multiple functions. The other
function this pin has is the reset line for the secondary service
processor. Can we describe that too?

Andrew

