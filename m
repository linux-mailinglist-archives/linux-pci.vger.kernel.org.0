Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C02178D25
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 10:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbgCDJJC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 04:09:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50516 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgCDJJB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2020 04:09:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so1062281wmb.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2020 01:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DBiLuchSYsWU2vWx/7D490b3VfxpGRDznuzxfsozSFs=;
        b=udlGUinWasUmaeqVwxcE8N96Ngb7lLP2z7EDQTndP8W0C0oUt1ilKLYYqqkk60+mSj
         CcLM79Ju69+CiAK/+bAC5z1EGFutKzbZ0npEr8XI9JglnZaNR/2nMQtucJ00cxbjehC9
         t3ssqseoemtrwIpKG3vjdDQiIjdNcJMUZNKQClGpBhAN3cof5TQktWTmt4oNtkuOw4dX
         +lwN1ZdfANjubg/rwn7ztf0uMGXlsMF48Gl77bY80w0m6Jgo8SIOWT96b1Urxq0ic8Zn
         J7iuRvOG5WfsPQL23ypSHQIKB/5wyUT8R4+TkgHR3NZgXsDkiwwRcqVQs0Qmal+UW5Og
         tpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DBiLuchSYsWU2vWx/7D490b3VfxpGRDznuzxfsozSFs=;
        b=d7Nrb3xWDHZnivClwuGUyByYPYNwNzgqxQF+7T5P25sF7lORQVwcN0AqVExbFieIqa
         mvydtzFbCLsTnSyAfmSyCqa2WpLQKPu1alkjQ9GUMLwuCA4rsJNCJpy1wQq4AFffZy+v
         1KNVAxSBwsjlKsIbgWLYwE6u8zH/r/fB44QAEgo8c8F/eKH+gsPptA7X/0j0dV6MBIPf
         qcfNHeWYX+hQUhbQt3GJKBnI1OrKF4E5wAXu83c+g2SSFoWeO2mymY9baaoLylyE7eBS
         IKUCL1quTyrWnkUk8SEsChZ9vQ9YBOa7Y/bY5u17Ou2h7A185xoYY1QTjP96DOhKe5gj
         XJPA==
X-Gm-Message-State: ANhLgQ0loHPOYxi4vVNK3bncTBKNS9CYqgCBknme0zh7LWim7ULX+W84
        mJXefvGDW36j2jo3EclHBtH5qKRtOkXzyw==
X-Google-Smtp-Source: ADFU+vuH/TuMnhMGzZx0bflsqNJmYp5iK8kISHsR1q0Fr2rth64snFp4QQa2J2zJhI5WRln/AmbuNQ==
X-Received: by 2002:a1c:6156:: with SMTP id v83mr2618913wmb.122.1583312937279;
        Wed, 04 Mar 2020 01:08:57 -0800 (PST)
Received: from [10.1.3.173] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q12sm40483436wrg.71.2020.03.04.01.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 01:08:56 -0800 (PST)
Subject: Re: [PATCH v6 5/7] phy: amlogic: Add Amlogic AXG MIPI/PCIE analog PHY
 Driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Remi Pommarel <repk@triplefau.lt>, kishon@ti.com
Cc:     Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
References: <20200123232943.10229-1-repk@triplefau.lt>
 <20200123232943.10229-6-repk@triplefau.lt>
 <20200303171921.GB9641@e121166-lin.cambridge.arm.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwU0EVid/pAEQAND7AFhr
 5faf/EhDP9FSgYd/zgmb7JOpFPje3uw7jz9wFb28Cf0Y3CcncdElYoBNbRlesKvjQRL8mozV
 9RN+IUMHdUx1akR/A4BPXNdL7StfzKWOCxZHVS+rIQ/fE3Qz/jRmT6t2ZkpplLxVBpdu95qJ
 YwSZjuwFXdC+A7MHtQXYi3UfCgKiflj4+/ITcKC6EF32KrmIRqamQwiRsDcUUKlAUjkCLcHL
 CQvNsDdm2cxdHxC32AVm3Je8VCsH7/qEPMQ+cEZk47HOR3+Ihfn1LEG5LfwsyWE8/JxsU2a1
 q44LQM2lcK/0AKAL20XDd7ERH/FCBKkNVzi+svYJpyvCZCnWT0TRb72mT+XxLWNwfHTeGALE
 +1As4jIS72IglvbtONxc2OIid3tR5rX3k2V0iud0P7Hnz/JTdfvSpVj55ZurOl2XAXUpGbq5
 XRk5CESFuLQV8oqCxgWAEgFyEapI4GwJsvfl/2Er8kLoucYO1Id4mz6N33+omPhaoXfHyLSy
 dxD+CzNJqN2GdavGtobdvv/2V0wukqj86iKF8toLG2/Fia3DxMaGUxqI7GMOuiGZjXPt/et/
 qeOySghdQ7Sdpu6fWc8CJXV2mOV6DrSzc6ZVB4SmvdoruBHWWOR6YnMz01ShFE49pPucyU1h
 Av4jC62El3pdCrDOnWNFMYbbon3vABEBAAHCwn4EGAECAAkFAlYnf6QCGwICKQkQFpq3saTP
 +K7BXSAEGQECAAYFAlYnf6QACgkQd9zb2sjISdGToxAAkOjSfGxp0ulgHboUAtmxaU3viucV
 e2Hl1BVDtKSKmbIVZmEUvx9D06IijFaEzqtKD34LXD6fjl4HIyDZvwfeaZCbJbO10j3k7FJE
 QrBtpdVqkJxme/nYlGOVzcOiKIepNkwvnHVnuVDVPcXyj2wqtsU7VZDDX41z3X4xTQwY3SO1
 9nRO+f+i4RmtJcITgregMa2PcB0LvrjJlWroI+KAKCzoTHzSTpCXMJ1U/dEqyc87bFBdc+DI
 k8mWkPxsccdbs4t+hH0NoE3Kal9xtAl56RCtO/KgBLAQ5M8oToJVatxAjO1SnRYVN1EaAwrR
 xkHdd97qw6nbg9BMcAoa2NMc0/9MeiaQfbgW6b0reIz/haHhXZ6oYSCl15Knkr4t1o3I2Bqr
 Mw623gdiTzotgtId8VfLB2Vsatj35OqIn5lVbi2ua6I0gkI6S7xJhqeyrfhDNgzTHdQVHB9/
 7jnM0ERXNy1Ket6aDWZWCvM59dTyu37g3VvYzGis8XzrX1oLBU/tTXqo1IFqqIAmvh7lI0Se
 gCrXz7UanxCwUbQBFjzGn6pooEHJYRLuVGLdBuoApl/I4dLqCZij2AGa4CFzrn9W0cwm3HCO
 lR43gFyz0dSkMwNUd195FrvfAz7Bjmmi19DnORKnQmlvGe/9xEEfr5zjey1N9+mt3//geDP6
 clwKBkq0JggA+RTEAELzkgPYKJ3NutoStUAKZGiLOFMpHY6KpItbbHjF2ZKIU1whaRYkHpB2
 uLQXOzZ0d7x60PUdhqG3VmFnzXSztA4vsnDKk7x2xw0pMSTKhMafpxaPQJf494/jGnwBHyi3
 h3QGG1RjfhQ/OMTX/HKtAUB2ct3Q8/jBfF0hS5GzT6dYtj0Ci7+8LUsB2VoayhNXMnaBfh+Q
 pAhaFfRZWTjUFIV4MpDdFDame7PB50s73gF/pfQbjw5Wxtes/0FnqydfId95s+eej+17ldGp
 lMv1ok7K0H/WJSdr7UwDAHEYU++p4RRTJP6DHWXcByVlpNQ4SSAiivmWiwOt490+Ac7ATQRN
 WQbPAQgAvIoM384ZRFocFXPCOBir5m2J+96R2tI2XxMgMfyDXGJwFilBNs+fpttJlt2995A8
 0JwPj8SFdm6FBcxygmxBBCc7i/BVQuY8aC0Z/w9Vzt3Eo561r6pSHr5JGHe8hwBQUcNPd/9l
 2ynP57YTSE9XaGJK8gIuTXWo7pzIkTXfN40Wh5jeCCspj4jNsWiYhljjIbrEj300g8RUT2U0
 FcEoiV7AjJWWQ5pi8lZJX6nmB0lc69Jw03V6mblgeZ/1oTZmOepkagwy2zLDXxihf0GowUif
 GphBDeP8elWBNK+ajl5rmpAMNRoKxpN/xR4NzBg62AjyIvigdywa1RehSTfccQARAQABwsBf
 BBgBAgAJBQJNWQbPAhsMAAoJEBaat7Gkz/iuteIH+wZuRDqK0ysAh+czshtG6JJlLW6eXJJR
 Vi7dIPpgFic2LcbkSlvB8E25Pcfz/+tW+04Urg4PxxFiTFdFCZO+prfd4Mge7/OvUcwoSub7
 ZIPo8726ZF5/xXzajahoIu9/hZ4iywWPAHRvprXaim5E/vKjcTeBMJIqZtS4u/UK3EpAX59R
 XVxVpM8zJPbk535ELUr6I5HQXnihQm8l6rt9TNuf8p2WEDxc8bPAZHLjNyw9a/CdeB97m2Tr
 zR8QplXA5kogS4kLe/7/JmlDMO8Zgm9vKLHSUeesLOrjdZ59EcjldNNBszRZQgEhwaarfz46
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <af715acf-9ea4-8a82-92d3-578d09aec760@baylibre.com>
Date:   Wed, 4 Mar 2020 10:08:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303171921.GB9641@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,


On 03/03/2020 18:19, Lorenzo Pieralisi wrote:
> On Fri, Jan 24, 2020 at 12:29:41AM +0100, Remi Pommarel wrote:
>> This adds support for the MIPI analog PHY which is also used for PCIE
>> found in the Amlogic AXG SoC Family.
>>
>> MIPI or PCIE selection is done by the #phy-cells, making the mode
>> static and exclusive.
>>
>> For now only PCIE fonctionality is supported.
>>
>> This PHY will be used to replace the mipi_enable clock gating logic
>> which was mistakenly added in the clock subsystem. This also activate
>> a non documented band gap bit in those registers that allows reliable
>> PCIE clock signal generation on AXG platforms.
>>
>> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
>> ---
>>  drivers/phy/amlogic/Kconfig                   |  11 +
>>  drivers/phy/amlogic/Makefile                  |  11 +-
>>  .../amlogic/phy-meson-axg-mipi-pcie-analog.c  | 188 ++++++++++++++++++
>>  3 files changed, 205 insertions(+), 5 deletions(-)
>>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> 
> Kishon, Neil,
> 
> can you please review/ack this patch and patch 6 ?

Sure, it was already acked by jerome, but it's also ok for me:

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
> 
> I would like to queue the series shortly, thanks.
> 
> Lorenzo
> 
>> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
>> index af774ac2b934..8c9cf2403591 100644
>> --- a/drivers/phy/amlogic/Kconfig
>> +++ b/drivers/phy/amlogic/Kconfig
>> @@ -59,3 +59,14 @@ config PHY_MESON_G12A_USB3_PCIE
>>  	  Enable this to support the Meson USB3 + PCIE Combo PHY found
>>  	  in Meson G12A SoCs.
>>  	  If unsure, say N.
>> +
>> +config PHY_MESON_AXG_MIPI_PCIE_ANALOG
>> +	tristate "Meson AXG MIPI + PCIE analog PHY driver"
>> +	default ARCH_MESON
>> +	depends on OF && (ARCH_MESON || COMPILE_TEST)
>> +	select GENERIC_PHY
>> +	select REGMAP_MMIO
>> +	help
>> +	  Enable this to support the Meson MIPI + PCIE analog PHY
>> +	  found in Meson AXG SoCs.
>> +	  If unsure, say N.
>> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
>> index 11d1c42ac2be..0aecf92d796a 100644
>> --- a/drivers/phy/amlogic/Makefile
>> +++ b/drivers/phy/amlogic/Makefile
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>> -obj-$(CONFIG_PHY_MESON8B_USB2)		+= phy-meson8b-usb2.o
>> -obj-$(CONFIG_PHY_MESON_GXL_USB2)	+= phy-meson-gxl-usb2.o
>> -obj-$(CONFIG_PHY_MESON_G12A_USB2)	+= phy-meson-g12a-usb2.o
>> -obj-$(CONFIG_PHY_MESON_GXL_USB3)	+= phy-meson-gxl-usb3.o
>> -obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)	+= phy-meson-g12a-usb3-pcie.o
>> +obj-$(CONFIG_PHY_MESON8B_USB2)			+= phy-meson8b-usb2.o
>> +obj-$(CONFIG_PHY_MESON_GXL_USB2)		+= phy-meson-gxl-usb2.o
>> +obj-$(CONFIG_PHY_MESON_G12A_USB2)		+= phy-meson-g12a-usb2.o
>> +obj-$(CONFIG_PHY_MESON_GXL_USB3)		+= phy-meson-gxl-usb3.o
>> +obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)		+= phy-meson-g12a-usb3-pcie.o
>> +obj-$(CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG)	+= phy-meson-axg-mipi-pcie-analog.o
>> diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
>> new file mode 100644
>> index 000000000000..1431cbf885e1
>> --- /dev/null
>> +++ b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
>> @@ -0,0 +1,188 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Amlogic AXG MIPI + PCIE analog PHY driver
>> + *
>> + * Copyright (C) 2019 Remi Pommarel <repk@triplefau.lt>
>> + */
>> +#include <linux/module.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/regmap.h>
>> +#include <linux/platform_device.h>
>> +#include <dt-bindings/phy/phy.h>
>> +
>> +#define HHI_MIPI_CNTL0 0x00
>> +#define		HHI_MIPI_CNTL0_COMMON_BLOCK	GENMASK(31, 28)
>> +#define		HHI_MIPI_CNTL0_ENABLE		BIT(29)
>> +#define		HHI_MIPI_CNTL0_BANDGAP		BIT(26)
>> +#define		HHI_MIPI_CNTL0_DECODE_TO_RTERM	GENMASK(15, 12)
>> +#define		HHI_MIPI_CNTL0_OUTPUT_EN	BIT(3)
>> +
>> +#define HHI_MIPI_CNTL1 0x01
>> +#define		HHI_MIPI_CNTL1_CH0_CML_PDR_EN	BIT(12)
>> +#define		HHI_MIPI_CNTL1_LP_ABILITY	GENMASK(5, 4)
>> +#define		HHI_MIPI_CNTL1_LP_RESISTER	BIT(3)
>> +#define		HHI_MIPI_CNTL1_INPUT_SETTING	BIT(2)
>> +#define		HHI_MIPI_CNTL1_INPUT_SEL	BIT(1)
>> +#define		HHI_MIPI_CNTL1_PRBS7_EN		BIT(0)
>> +
>> +#define HHI_MIPI_CNTL2 0x02
>> +#define		HHI_MIPI_CNTL2_CH_PU		GENMASK(31, 25)
>> +#define		HHI_MIPI_CNTL2_CH_CTL		GENMASK(24, 19)
>> +#define		HHI_MIPI_CNTL2_CH0_DIGDR_EN	BIT(18)
>> +#define		HHI_MIPI_CNTL2_CH_DIGDR_EN	BIT(17)
>> +#define		HHI_MIPI_CNTL2_LPULPS_EN	BIT(16)
>> +#define		HHI_MIPI_CNTL2_CH_EN(n)		BIT(15 - (n))
>> +#define		HHI_MIPI_CNTL2_CH0_LP_CTL	GENMASK(10, 1)
>> +
>> +struct phy_axg_mipi_pcie_analog_priv {
>> +	struct phy *phy;
>> +	unsigned int mode;
>> +	struct regmap *regmap;
>> +};
>> +
>> +static const struct regmap_config phy_axg_mipi_pcie_analog_regmap_conf = {
>> +	.reg_bits = 8,
>> +	.val_bits = 32,
>> +	.reg_stride = 4,
>> +	.max_register = HHI_MIPI_CNTL2,
>> +};
>> +
>> +static int phy_axg_mipi_pcie_analog_power_on(struct phy *phy)
>> +{
>> +	struct phy_axg_mipi_pcie_analog_priv *priv = phy_get_drvdata(phy);
>> +
>> +	/* MIPI not supported yet */
>> +	if (priv->mode != PHY_TYPE_PCIE)
>> +		return -EINVAL;
>> +
>> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
>> +			   HHI_MIPI_CNTL0_BANDGAP, HHI_MIPI_CNTL0_BANDGAP);
>> +
>> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
>> +			   HHI_MIPI_CNTL0_ENABLE, HHI_MIPI_CNTL0_ENABLE);
>> +	return 0;
>> +}
>> +
>> +static int phy_axg_mipi_pcie_analog_power_off(struct phy *phy)
>> +{
>> +	struct phy_axg_mipi_pcie_analog_priv *priv = phy_get_drvdata(phy);
>> +
>> +	/* MIPI not supported yet */
>> +	if (priv->mode != PHY_TYPE_PCIE)
>> +		return -EINVAL;
>> +
>> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
>> +			   HHI_MIPI_CNTL0_BANDGAP, 0);
>> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
>> +			   HHI_MIPI_CNTL0_ENABLE, 0);
>> +	return 0;
>> +}
>> +
>> +static int phy_axg_mipi_pcie_analog_init(struct phy *phy)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int phy_axg_mipi_pcie_analog_exit(struct phy *phy)
>> +{
>> +	return 0;
>> +}
>> +
>> +static const struct phy_ops phy_axg_mipi_pcie_analog_ops = {
>> +	.init = phy_axg_mipi_pcie_analog_init,
>> +	.exit = phy_axg_mipi_pcie_analog_exit,
>> +	.power_on = phy_axg_mipi_pcie_analog_power_on,
>> +	.power_off = phy_axg_mipi_pcie_analog_power_off,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> +static struct phy *phy_axg_mipi_pcie_analog_xlate(struct device *dev,
>> +						  struct of_phandle_args *args)
>> +{
>> +	struct phy_axg_mipi_pcie_analog_priv *priv = dev_get_drvdata(dev);
>> +	unsigned int mode;
>> +
>> +	if (args->args_count != 1) {
>> +		dev_err(dev, "invalid number of arguments\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	mode = args->args[0];
>> +
>> +	/* MIPI mode is not supported yet */
>> +	if (mode != PHY_TYPE_PCIE) {
>> +		dev_err(dev, "invalid phy mode select argument\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	priv->mode = mode;
>> +	return priv->phy;
>> +}
>> +
>> +static int phy_axg_mipi_pcie_analog_probe(struct platform_device *pdev)
>> +{
>> +	struct phy_provider *phy;
>> +	struct device *dev = &pdev->dev;
>> +	struct phy_axg_mipi_pcie_analog_priv *priv;
>> +	struct device_node *np = dev->of_node;
>> +	struct regmap *map;
>> +	struct resource *res;
>> +	void __iomem *base;
>> +	int ret;
>> +
>> +	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(base)) {
>> +		dev_err(dev, "failed to get regmap base\n");
>> +		return PTR_ERR(base);
>> +	}
>> +
>> +	map = devm_regmap_init_mmio(dev, base,
>> +				    &phy_axg_mipi_pcie_analog_regmap_conf);
>> +	if (IS_ERR(map)) {
>> +		dev_err(dev, "failed to get HHI regmap\n");
>> +		return PTR_ERR(map);
>> +	}
>> +	priv->regmap = map;
>> +
>> +	priv->phy = devm_phy_create(dev, np, &phy_axg_mipi_pcie_analog_ops);
>> +	if (IS_ERR(priv->phy)) {
>> +		ret = PTR_ERR(priv->phy);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to create PHY\n");
>> +		return ret;
>> +	}
>> +
>> +	phy_set_drvdata(priv->phy, priv);
>> +	dev_set_drvdata(dev, priv);
>> +
>> +	phy = devm_of_phy_provider_register(dev,
>> +					    phy_axg_mipi_pcie_analog_xlate);
>> +
>> +	return PTR_ERR_OR_ZERO(phy);
>> +}
>> +
>> +static const struct of_device_id phy_axg_mipi_pcie_analog_of_match[] = {
>> +	{
>> +		.compatible = "amlogic,axg-mipi-pcie-analog-phy",
>> +	},
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, phy_axg_mipi_pcie_analog_of_match);
>> +
>> +static struct platform_driver phy_axg_mipi_pcie_analog_driver = {
>> +	.probe = phy_axg_mipi_pcie_analog_probe,
>> +	.driver = {
>> +		.name = "phy-axg-mipi-pcie-analog",
>> +		.of_match_table = phy_axg_mipi_pcie_analog_of_match,
>> +	},
>> +};
>> +module_platform_driver(phy_axg_mipi_pcie_analog_driver);
>> +
>> +MODULE_AUTHOR("Remi Pommarel <repk@triplefau.lt>");
>> +MODULE_DESCRIPTION("Amlogic AXG MIPI + PCIE analog PHY driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.24.1
>>

