Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E94CD178EC5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 11:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbgCDKrN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 05:47:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50415 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgCDKrN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2020 05:47:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so1477179wmb.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2020 02:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=usL+Yedbyam7qNCON9a3/+NPKdnFTu+cqc21gDVgrKs=;
        b=eeG3WkrjTyzKiiKU2sQtKMYjIdn1KotbnEaeZ7ONQS1JPhWw1IvVd0mlryokCDuPFo
         PwYkW4adkrNzIaeMSZWUH0YKUpI9qM+J66yWygEf+QDL648AfpfCVdBHQyOiEsrRuZnn
         JLWEHLS/1tL2SJyjGffT5CjqCIH8cvOzxSt2GkwbjKg6kBdzuu+D1zhGiyTJ3uCs1VJW
         c2I+R5tibr6z47wmWA3qE7bP0BYCrGFlKnvduY2rawaRFWplEPE6q/4+zJhaxaWARlNR
         eZXdbDGlPm7HwvRFVm6wP62Gw9IlVVg3O61uP4QcMfwc3+r4uxj4U19iWixVKZncciQx
         TRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=usL+Yedbyam7qNCON9a3/+NPKdnFTu+cqc21gDVgrKs=;
        b=Nk6350M1mCs8FePBQfq2M1Vrap/p9eMrXhEilhXZmlxLtQoadmWftNWMKPnfDGnG/e
         n6jQM399KkL+EoSBj5sPVXUoJOI8U5C2Z+nga2lJEFfg5kjmhGGjZq3GB8QDXk8rzMbw
         n1Q12V5l+EUc+7tXs0ehPuwvim9RFflaNpIEL6+NTimLBONki6QoVl11LqK8klT4e1t3
         DMS5qmkokD8tF7JBHCvFiKRsbhmA/fuoTWb+nDdBKdAOLbKhqsYqPQzm7u4AWukOKBUV
         9k8AVhjC1NH6SiQG6Bc4MmNVmSFxXpAL5advVzdow+6ag1+5Geqe+cRClfTbkBVOSLJH
         TZgQ==
X-Gm-Message-State: ANhLgQ1ozjNCXSr9vlNhoJyNBkUxDP+4B7h9w+OtwSH6G+mOMZSoVbv9
        4/J2QfYbcCooMrkHNe3bsSFZ5cFOqKEtig==
X-Google-Smtp-Source: ADFU+vvBb/UydPx2ggP7TXTIEHSmDxaUXMPe+vyW3yYQxe0pCq02ROn414SZNbwy5PWNq8yMyS/WDw==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr3234405wmj.152.1583318828563;
        Wed, 04 Mar 2020 02:47:08 -0800 (PST)
Received: from [10.1.3.173] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f23sm3577508wmb.1.2020.03.04.02.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 02:47:07 -0800 (PST)
Subject: Re: [PATCH v6 6/7] phy: amlogic: Add Amlogic AXG PCIE PHY Driver
To:     Remi Pommarel <repk@triplefau.lt>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
References: <20200123232943.10229-1-repk@triplefau.lt>
 <20200123232943.10229-7-repk@triplefau.lt>
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
Message-ID: <91457cca-4ba2-02f5-d8b7-2b926427e2c4@baylibre.com>
Date:   Wed, 4 Mar 2020 11:47:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123232943.10229-7-repk@triplefau.lt>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/01/2020 00:29, Remi Pommarel wrote:
> This adds support for the PCI PHY found in the Amlogic AXG SoC Family.
> This will allow to mutualize code in pci-meson.c between AXG and G12A
> SoC.
> 
> This PHY also uses and chains an analog PHY, which on AXG platform
> is needed to have reliable PCIe communication.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/phy/amlogic/Kconfig              |  11 ++
>  drivers/phy/amlogic/Makefile             |   1 +
>  drivers/phy/amlogic/phy-meson-axg-pcie.c | 192 +++++++++++++++++++++++
>  3 files changed, 204 insertions(+)
>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c
> 
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index 8c9cf2403591..71801e30d601 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -60,6 +60,17 @@ config PHY_MESON_G12A_USB3_PCIE
>  	  in Meson G12A SoCs.
>  	  If unsure, say N.
>  
> +config PHY_MESON_AXG_PCIE
> +	tristate "Meson AXG PCIE PHY driver"
> +	default ARCH_MESON
> +	depends on OF && (ARCH_MESON || COMPILE_TEST)
> +	select GENERIC_PHY
> +	select REGMAP_MMIO
> +	help
> +	  Enable this to support the Meson MIPI + PCIE PHY found
> +	  in Meson AXG SoCs.
> +	  If unsure, say N.
> +
>  config PHY_MESON_AXG_MIPI_PCIE_ANALOG
>  	tristate "Meson AXG MIPI + PCIE analog PHY driver"
>  	default ARCH_MESON
> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
> index 0aecf92d796a..e2baa133f7af 100644
> --- a/drivers/phy/amlogic/Makefile
> +++ b/drivers/phy/amlogic/Makefile
> @@ -4,4 +4,5 @@ obj-$(CONFIG_PHY_MESON_GXL_USB2)		+= phy-meson-gxl-usb2.o
>  obj-$(CONFIG_PHY_MESON_G12A_USB2)		+= phy-meson-g12a-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB3)		+= phy-meson-gxl-usb3.o
>  obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)		+= phy-meson-g12a-usb3-pcie.o
> +obj-$(CONFIG_PHY_MESON_AXG_PCIE)		+= phy-meson-axg-pcie.o
>  obj-$(CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG)	+= phy-meson-axg-mipi-pcie-analog.o
> diff --git a/drivers/phy/amlogic/phy-meson-axg-pcie.c b/drivers/phy/amlogic/phy-meson-axg-pcie.c
> new file mode 100644
> index 000000000000..377ed0dcd0d9
> --- /dev/null
> +++ b/drivers/phy/amlogic/phy-meson-axg-pcie.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Amlogic AXG PCIE PHY driver
> + *
> + * Copyright (C) 2020 Remi Pommarel <repk@triplefau.lt>
> + */
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/platform_device.h>
> +#include <linux/bitfield.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +#define MESON_PCIE_REG0 0x00
> +#define		MESON_PCIE_COMMON_CLK	BIT(4)
> +#define		MESON_PCIE_PORT_SEL	GENMASK(3, 2)
> +#define		MESON_PCIE_CLK		BIT(1)
> +#define		MESON_PCIE_POWERDOWN	BIT(0)
> +
> +#define MESON_PCIE_TWO_X1		FIELD_PREP(MESON_PCIE_PORT_SEL, 0x3)
> +#define MESON_PCIE_COMMON_REF_CLK	FIELD_PREP(MESON_PCIE_COMMON_CLK, 0x1)
> +#define MESON_PCIE_PHY_INIT		(MESON_PCIE_TWO_X1 |		\
> +					 MESON_PCIE_COMMON_REF_CLK)
> +#define MESON_PCIE_RESET_DELAY		500
> +
> +struct phy_axg_pcie_priv {
> +	struct phy *phy;
> +	struct phy *analog;
> +	struct regmap *regmap;
> +	struct reset_control *reset;
> +};
> +
> +static const struct regmap_config phy_axg_pcie_regmap_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = MESON_PCIE_REG0,
> +};
> +
> +static int phy_axg_pcie_power_on(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = phy_power_on(priv->analog);
> +	if (ret != 0)
> +		return ret;
> +
> +	regmap_update_bits(priv->regmap, MESON_PCIE_REG0,
> +			   MESON_PCIE_POWERDOWN, 0);
> +	return 0;
> +}
> +
> +static int phy_axg_pcie_power_off(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = phy_power_off(priv->analog);
> +	if (ret != 0)
> +		return ret;
> +
> +	regmap_update_bits(priv->regmap, MESON_PCIE_REG0,
> +			   MESON_PCIE_POWERDOWN, 1);
> +	return 0;
> +}
> +
> +static int phy_axg_pcie_init(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = phy_init(priv->analog);
> +	if (ret != 0)
> +		return ret;
> +
> +	regmap_write(priv->regmap, MESON_PCIE_REG0, MESON_PCIE_PHY_INIT);
> +	return reset_control_reset(priv->reset);
> +}
> +
> +static int phy_axg_pcie_exit(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = phy_exit(priv->analog);
> +	if (ret != 0)
> +		return ret;
> +
> +	return reset_control_reset(priv->reset);
> +}
> +
> +static int phy_axg_pcie_reset(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +	int ret = 0;
> +
> +	ret = phy_reset(priv->analog);
> +	if (ret != 0)
> +		goto out;
> +
> +	ret = reset_control_assert(priv->reset);
> +	if (ret != 0)
> +		goto out;
> +	udelay(MESON_PCIE_RESET_DELAY);
> +
> +	ret = reset_control_deassert(priv->reset);
> +	if (ret != 0)
> +		goto out;
> +	udelay(MESON_PCIE_RESET_DELAY);
> +
> +out:
> +	return ret;
> +}
> +
> +static const struct phy_ops phy_axg_pcie_ops = {
> +	.init = phy_axg_pcie_init,
> +	.exit = phy_axg_pcie_exit,
> +	.power_on = phy_axg_pcie_power_on,
> +	.power_off = phy_axg_pcie_power_off,
> +	.reset = phy_axg_pcie_reset,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int phy_axg_pcie_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *pphy;
> +	struct device *dev = &pdev->dev;
> +	struct phy_axg_pcie_priv *priv;
> +	struct device_node *np = dev->of_node;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret;
> +
> +	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->phy = devm_phy_create(dev, np, &phy_axg_pcie_ops);
> +	if (IS_ERR(priv->phy)) {
> +		ret = PTR_ERR(priv->phy);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to create PHY\n");
> +		return ret;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	priv->regmap = devm_regmap_init_mmio(dev, base,
> +					     &phy_axg_pcie_regmap_conf);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	priv->reset = devm_reset_control_array_get(dev, false, false);
> +	if (IS_ERR(priv->reset))
> +		return PTR_ERR(priv->reset);
> +
> +	priv->analog = devm_phy_get(dev, "analog");
> +	if (IS_ERR(priv->analog))
> +		return PTR_ERR(priv->analog);
> +
> +	phy_set_drvdata(priv->phy, priv);
> +	dev_set_drvdata(dev, priv);
> +	pphy = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(pphy);
> +}
> +
> +static const struct of_device_id phy_axg_pcie_of_match[] = {
> +	{
> +		.compatible = "amlogic,axg-pcie-phy",
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, phy_axg_pcie_of_match);
> +
> +static struct platform_driver phy_axg_pcie_driver = {
> +	.probe = phy_axg_pcie_probe,
> +	.driver = {
> +		.name = "phy-axg-pcie",
> +		.of_match_table = phy_axg_pcie_of_match,
> +	},
> +};
> +module_platform_driver(phy_axg_pcie_driver);
> +
> +MODULE_AUTHOR("Remi Pommarel <repk@triplefau.lt>");
> +MODULE_DESCRIPTION("Amlogic AXG PCIE PHY driver");
> +MODULE_LICENSE("GPL v2");
> 

The changes since v5 are done (make analog phy mandatory), ok for me then.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

