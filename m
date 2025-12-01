Return-Path: <linux-pci+bounces-42407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A68FCC99168
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 21:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EF814E2034
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 20:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0C525EFBB;
	Mon,  1 Dec 2025 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flM4qaUt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EF0223DEF;
	Mon,  1 Dec 2025 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622358; cv=none; b=XbEmO0B/Rq7DqbZi6dleeLnDeCqyo/0FyFPox3DzGjhDzXkMQvbnt9vyRc8e51AxyJuExHIrKxMLzLQD9Mj1Q7fljjP5PGDKoq0jAPQeypCBRxnraybvC1CtEJ66wzePc0D/VJFBtwlJvIJs99Bq6AlzwGfeDCkfjcO1ozhyCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622358; c=relaxed/simple;
	bh=NfUf5GelDLoSxFZm9Aq5VnHYa1989YAat0QJXEF+m1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=L2VYal13jXi2JWuVceVqLGON0i8dztAM9YKmqNVcwDp4mNjil01jiW2CD9Ca1A7eAnDIdW/OuquOooWvbQm+rW38UNkUwNC9XqUZyCsn0w6dkTI/q2VoG8z+rrlwvbieuUPBb40EZ+bbSyNN7EilStF/IYRys2WSHKjhKgu/rRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flM4qaUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CEDC4CEF1;
	Mon,  1 Dec 2025 20:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764622357;
	bh=NfUf5GelDLoSxFZm9Aq5VnHYa1989YAat0QJXEF+m1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=flM4qaUtRnVkA245t9hWpzI2WtWTW69oK283WqPcLVlPcVRBC8VVXtARaL1n1BBYa
	 3s40COrlLhU6Nm61pQBCxfJGKVp0KrtKP7H3Iboto596cplV0whgs+D1f74O1m6cEh
	 x435DaCiChed1BgzkqsQBSanWcecFfio5HAbEQGpt0lF9r4wuHdd1sTi4qgrRytT6E
	 7KZv+M64NSKvLqktC0vj13JaGJtUaxNkTSJSiPI33XmnenZfGBp3227bmicDm/TUkr
	 ZGc7wyChoCp3+sB6qW2KPkQJHzp/t8c0a/I4HDsMvrQsU4DSE8GQ88zrhwoVeUGF07
	 usGTycGmGlGYQ==
Date: Mon, 1 Dec 2025 14:52:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of GPIO
 APIs to enable the 3V3 power supply of PCIe slots
Message-ID: <20251201205236.GA3023515@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125075604.69370-2-hal.feng@starfivetech.com>

[+cc Kevin, pcie-starfive.c maintainer; will need his ack]

Subject line is excessively long.

On Tue, Nov 25, 2025 at 03:55:59PM +0800, Hal Feng wrote:
> The "enable-gpio" property is not documented in the dt-bindings and
> using GPIO APIs is not a standard method to enable or disable PCIe
> slot power, so use regulator APIs to replace them.

I can't tell from this whether existing DTs will continue to work
after this change.  It looks like previously we looked for an
"enable-gpios" or "enable-gpio" property and now we'll look for a
"vpcie3v3-supply" regulator property.

I don't see "enable-gpios" or "enable-gpio" mentioned in any of the DT
patches in this series, so maybe that property was never actually used
before, and the code for pcie->power_gpio was actually dead?

Please add something here about how we know this won't break any
existing setups using DTs that are already in the field.

> Tested-by: Matthias Brugger <mbrugger@suse.com>
> Fixes: 39b91eb40c6a ("PCI: starfive: Add JH7110 PCIe controller")

Based on the cover letter, it looks like the point of this is to add
support for a new device, which I don't think really qualifies as a
"fix".

> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  drivers/pci/controller/plda/pcie-starfive.c | 25 ++++++++++++---------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
> index 3caf53c6c082..298036c3e7f9 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -55,7 +55,7 @@ struct starfive_jh7110_pcie {
>  	struct reset_control *resets;
>  	struct clk_bulk_data *clks;
>  	struct regmap *reg_syscon;
> -	struct gpio_desc *power_gpio;
> +	struct regulator *vpcie3v3;
>  	struct gpio_desc *reset_gpio;
>  	struct phy *phy;
>  
> @@ -153,11 +153,13 @@ static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie,
>  		return dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
>  				     "failed to get perst-gpio\n");
>  
> -	pcie->power_gpio = devm_gpiod_get_optional(dev, "enable",
> -						   GPIOD_OUT_LOW);
> -	if (IS_ERR(pcie->power_gpio))
> -		return dev_err_probe(dev, PTR_ERR(pcie->power_gpio),
> -				     "failed to get power-gpio\n");
> +	pcie->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
> +	if (IS_ERR(pcie->vpcie3v3)) {
> +		if (PTR_ERR(pcie->vpcie3v3) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(pcie->vpcie3v3),
> +					     "failed to get vpcie3v3 regulator\n");
> +		pcie->vpcie3v3 = NULL;
> +	}
>  
>  	return 0;
>  }
> @@ -270,8 +272,8 @@ static void starfive_pcie_host_deinit(struct plda_pcie_rp *plda)
>  		container_of(plda, struct starfive_jh7110_pcie, plda);
>  
>  	starfive_pcie_clk_rst_deinit(pcie);
> -	if (pcie->power_gpio)
> -		gpiod_set_value_cansleep(pcie->power_gpio, 0);
> +	if (pcie->vpcie3v3)
> +		regulator_disable(pcie->vpcie3v3);
>  	starfive_pcie_disable_phy(pcie);
>  }
>  
> @@ -304,8 +306,11 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
>  	if (ret)
>  		return ret;
>  
> -	if (pcie->power_gpio)
> -		gpiod_set_value_cansleep(pcie->power_gpio, 1);
> +	if (pcie->vpcie3v3) {
> +		ret = regulator_enable(pcie->vpcie3v3);
> +		if (ret)
> +			dev_err_probe(dev, ret, "failed to enable vpcie3v3 regulator\n");
> +	}
>  
>  	if (pcie->reset_gpio)
>  		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> -- 
> 2.43.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

