Return-Path: <linux-pci+bounces-25826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F66A88004
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 14:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BE41893F4E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D662BD586;
	Mon, 14 Apr 2025 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Adt+S7Q5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A529C34F;
	Mon, 14 Apr 2025 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632596; cv=none; b=cHxe2IWBYvciOO81NoB/HqYV6WAAYMu6pFZ1FYgoc3ItGTofvC20hK94JXGWWZOHBHNtn904+1N7dArNmrWsv+Uau5eMz68cH6XB/OXZGusG0a7nU57KbUdpJpxJP3NhycW5861Nso0XVrAD0t6YnCAMZjK/EBzKePvb+IH5EyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632596; c=relaxed/simple;
	bh=3wFAQ0bfmajHT5gHApNJl6KfzdiirBoLJLZBwl7ntrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aEgFeHmd1P5QgI2vkbP8kHE5EpGEp1wK5CAyf4PFx20zwurdo0jf96aeVRnEjN1ONG55YHZIZiZ43Jj4nndOjCxCPm6jJhCbKCRbSVBvKJn19Ne9Cjj+LuTK8kQ/to7FxS4+XeK5Xp0+KfaalMLe5JuZW7NSRz6PUVqQ8z7XkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Adt+S7Q5; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744632571; x=1745237371; i=wahrenst@gmx.net;
	bh=Xp75qIMm57nPPVP8J/rsf6yDNuT8ofPVgHhiAuNSxeI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Adt+S7Q58ZFbuxAVqbEHCpygKTx6tn4q8QFotlb4nz9t3K9hHxvdOH/1pAT7pDKq
	 7K00hQI/NjI8dhXowu96FesxpdRIAkVhl1AETvGYXKo7gqF3fv+Fwx4ND4ER/RD2y
	 ELkGEIzv+5pCMk6VBKZbfg3Ix86aTtbSsWt/fENeELl+/i3HHem1d++0CE5u+KUhl
	 NgqMqn4ICiQFQn6id9mrXwC7AMh+1c8O1Qe7YgMaeNSLE1uILdOvMmsERdUwLF/Jl
	 +xl7Pcjbxqrt6LNfi0ot6A0mu+Wp3iTkvLGpZVMmJDlJOOShnLQsJH+YlHLKBL9pf
	 Ly//gAj0bMnUHv2S/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXyP-1tWtt73HQ7-00Jmb6; Mon, 14
 Apr 2025 14:09:30 +0200
Message-ID: <23ac3d05-5fb7-4cd8-bb87-cf1f3eab521d@gmx.net>
Date: Mon, 14 Apr 2025 14:09:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/13] clk: rp1: Add support for clocks provided by RP1
To: Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij
 <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, kernel-list@raspberrypi.com
References: <cover.1742418429.git.andrea.porta@suse.com>
 <370137263691f4fc14928e4b378b27f75bfd0826.1742418429.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <370137263691f4fc14928e4b378b27f75bfd0826.1742418429.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jVwfn61L1l623hq7JXUK39FgY+Ke6mJ2vq3rv9zPlizsfdYXY7A
 2eFM7o4p/xMmoEYRWw3X5rZ9EwLs3HX0RNGwjh32MBVmJ5tPIWKJD3TZOSZ5mQ9ScVCGxhS
 vZxFeauGQHcerGX4V2kn7p5gOHGCNFF+iuDo1OHP9HHq1BHKzBHpm8KosKpBNLrmbKyMqZa
 ufvid/6nBIWqMTvIQqIYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tB7vyzX7o7A=;RW1rgnOFo0RixCKF/d2mYwqmzGx
 gSFo/UeVvOCf8bVNC1Pj3NvNg4zJkY2004QcR9y+HC+L9+2uD13HLgztYw34Eqy/JQFtZnJSh
 tsP1fuZth67d3KlO5JOyvYsSToFt2mGGZCPx/jhttn2z6otSqiviaOL0CjzN2I1vpxQpaib+e
 HpTPgSz2QuMBb11T2VbJtGnA7hl9YwHqfL9VpD0cRn+E7HiSXxn/kg0AfwgOES61fERkhXxXX
 N8CqWE4HHFISvUiC964Z8hB+AE5Gn3LwmQ4c2+FJeIOG6CPRjzlMjIWj10Ucncaj91yFH/p2y
 CsjdMjb2SwMOP3LzZVzujsM2AaoFmLkGd0TMGhP2oRkMxMos/Vzg6/9kH5aFAPojtRI3weHgZ
 mBKwKjhhpWuxjbBKH8Kw/TtEI+hArfK25tHFEmHM/xLZtODPYIEDRxCP0Ajz//YOHVbn2zXZV
 GkcQzwL0Nr1DmTIC6TMM1I8FE2PRerSZS3/OIJxTUtjWq6kWunHUzak5KymWS5qLSHPp/joxD
 V1s7ZzdV53RFNVC4eEJxNeVyPUdoL02WLzuMAYcJ4rEoxOO6LCSM1eqiNGKy+vB56rQQt8p0+
 YaIhNK4URPD4bPcQzCZuGVzUKItTkxWZo+uqd6ZFNBjmrwWhQzh8g5eYZmGuUZVkq2wggYGUp
 kdpPgEKHa58d8XSwi9ZK3Rz4NKk9Gqq4YHaKljiEgFF856gzEvLaAT28quohPIz3Qk8s7elrs
 721i8oM45qWxYxeoe8nXLalgEUfdajTRc2lsI6vZDKNPzmI2tm0W5iXXznsPLnuyzuFHlAmh/
 Nq1uEtn80MHmaXPa9jluhzG2TJvd9UH6RRX4iDWvRQPkeIVuDX9pxZ1D4rY0eNUO2r4BkmTo3
 VIFvwwPS6WNJUnXOJsS225ihQIxBao3xVA8pzL9pFpKdmA56O0RiAdfLGRThRxbeptsHFq3ag
 sQXdvxBQWfpeUjlT0xYEn7EDFjlsCBSeyzGSvrrbGnjPvaeqaHGMsmr+Bh4gUtlHfy5FihEbq
 Ydud5f8o1RCCbMtl1JFKrbfb/KPKF0IOLCbySmGELYixS75meuWv+UzBksXhIWSZJJxPwk+AK
 S/KvqBqKiUBQWMkbBy6R9Yl+Bi9LjmWwnQhnJajIp1ksZU+I+q6CKi2FwRJuHr1BcZ5/OcY6n
 Xg0mmgKkb7028ajltzj5lHq3xoa6vy58CfZyxMRSj5q46oQNCmFdJbc5ijAv0Laiheg01kcuB
 PgKlduTSecrLH5OQpUT+C98gY7zi0EeHf8S2hE2wnL1RwP4ddWOHoeomzOF8EzyxeLSXwA5C+
 B2x/genRqFN6zZMzhsFkcVtBuozi3z6AI2DP92pkRH1wbAZpWxEoxf1b8xYZnVQ4og66l02y/
 rhyKF2O/8nZYHtPRC2ORjtO1vRVK9m/Dbdo5E3aM25e3tya4bp/Gk1PgQuDefWuNp2Ym2Bos9
 1dHlIJr5UGJta6dClhb240M3P0aNwZQRADOsrn9mmblCnJoFT

Hi Andrea,

Am 19.03.25 um 22:52 schrieb Andrea della Porta:
> RaspberryPi RP1 is an MFD providing, among other peripherals, several
> clock generators and PLLs that drives the sub-peripherals.
> Add the driver to support the clock providers.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   MAINTAINERS           |    5 +
>   drivers/clk/Kconfig   |    9 +
>   drivers/clk/Makefile  |    1 +
>   drivers/clk/clk-rp1.c | 1512 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 1527 insertions(+)
>   create mode 100644 drivers/clk/clk-rp1.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa065..75263700370d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19748,6 +19748,11 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
>   F:	drivers/media/platform/raspberrypi/rp1-cfe/
>
> +RASPBERRY PI RP1 PCI DRIVER
> +M:	Andrea della Porta <andrea.porta@suse.com>
> +S:	Maintained
> +F:	drivers/clk/clk-rp1.c
> +
>   RC-CORE / LIRC FRAMEWORK
>   M:	Sean Young <sean@mess.org>
>   L:	linux-media@vger.kernel.org
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 713573b6c86c..cff90de71409 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -88,6 +88,15 @@ config COMMON_CLK_RK808
>   	  These multi-function devices have two fixed-rate oscillators, clock=
ed at 32KHz each.
>   	  Clkout1 is always on, Clkout2 can off by control register.
>
> +config COMMON_CLK_RP1
> +	tristate "Raspberry Pi RP1-based clock support"
> +	depends on MISC_RP1 || COMPILE_TEST
> +	default MISC_RP1
> +	help
> +	  Enable common clock framework support for Raspberry Pi RP1.
> +	  This multi-function device has 3 main PLLs and several clock
> +	  generators to drive the internal sub-peripherals.
> +
>   config COMMON_CLK_HI655X
>   	tristate "Clock driver for Hi655x" if EXPERT
>   	depends on (MFD_HI655X_PMIC || COMPILE_TEST)
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index bf4bd45adc3a..ff3993ed7e09 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+=3D clk-plldig.o
>   obj-$(CONFIG_COMMON_CLK_PWM)		+=3D clk-pwm.o
>   obj-$(CONFIG_CLK_QORIQ)			+=3D clk-qoriq.o
>   obj-$(CONFIG_COMMON_CLK_RK808)		+=3D clk-rk808.o
> +obj-$(CONFIG_COMMON_CLK_RP1)            +=3D clk-rp1.o
>   obj-$(CONFIG_COMMON_CLK_HI655X)		+=3D clk-hi655x.o
>   obj-$(CONFIG_COMMON_CLK_S2MPS11)	+=3D clk-s2mps11.o
>   obj-$(CONFIG_COMMON_CLK_SCMI)           +=3D clk-scmi.o
> diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> new file mode 100644
> index 000000000000..72c74e344c1d
> --- /dev/null
> +++ b/drivers/clk/clk-rp1.c
> @@ -0,0 +1,1512 @@
> +// SPDX-License-Identifier: GPL-2.0
...
> +
> +static int rp1_pll_divider_set_rate(struct clk_hw *hw,
> +				    unsigned long rate,
> +				    unsigned long parent_rate)
> +{
> +	struct rp1_clk_desc *divider =3D container_of(hw, struct rp1_clk_desc,=
 div.hw);
> +	struct rp1_clockman *clockman =3D divider->clockman;
> +	const struct rp1_pll_data *data =3D divider->data;
> +	u32 div, sec;
> +
> +	div =3D DIV_ROUND_UP_ULL(parent_rate, rate);
> +	div =3D clamp(div, 8u, 19u);
> +
> +	spin_lock(&clockman->regs_lock);
> +	sec =3D clockman_read(clockman, data->ctrl_reg);
> +	sec &=3D ~PLL_SEC_DIV_MASK;
> +	sec |=3D FIELD_PREP(PLL_SEC_DIV_MASK, div);
> +
> +	/* Must keep the divider in reset to change the value. */
> +	sec |=3D PLL_SEC_RST;
> +	clockman_write(clockman, data->ctrl_reg, sec);
> +
> +	/* TODO: must sleep 10 pll vco cycles */
Is it possible to implement this with some kind of xsleep or xdelay?
> +	sec &=3D ~PLL_SEC_RST;
> +	clockman_write(clockman, data->ctrl_reg, sec);
> +	spin_unlock(&clockman->regs_lock);
> +
> +	return 0;
> +}
> +
>

