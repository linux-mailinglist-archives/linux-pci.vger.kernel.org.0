Return-Path: <linux-pci+bounces-17289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CE69D8C64
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 19:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C7D2822F9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DC81B85CA;
	Mon, 25 Nov 2024 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="UbvvzZVu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDEF1B415F;
	Mon, 25 Nov 2024 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732560400; cv=none; b=cNLTBCCuUkrjMNk7drOFKy+PgtQRzPnossz3090WDWXNpVL/xxNxg4iwrvdcqxDeIvLo6qENjgTjWqR/PvqKv0sGWb2NSNkpc5ylkLUp3yJdVfg3M+Dg9rh6vltZ2lI8Jh4iwHyl0NiGs65MQlSdeQkanx/WIBXemrspl4cWuWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732560400; c=relaxed/simple;
	bh=TtCTNFPcZR1bxUiEExyk0yCLrSQrn/3Cwwf3KVjbDlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lb6E9Gw1RsZXKEhNs4FKOCD3cM4hr1xRFtLOyoZLEoLQXzWcouDtKD/lURfs2uuVIrsRGrlTFCwCJG/E3cIGne4Z72vlq/C+sGnynKNEEiDIfdj4H4Px5M3BhpKyMdR10VWuiOrLlgp8SE67+o5otWV1rqcypm7j+oN1qxBOiUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=UbvvzZVu; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1732560372; x=1733165172; i=wahrenst@gmx.net;
	bh=emLMo1HXRsgcAfvEKOdWs2P0cK3UlzUQkPf6wBXgm10=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UbvvzZVuPhUnZZ0ypsubMf5GycjB/MfzmOzYT9ifDG6BGk4ZJbJFQFHV8s+rEUsV
	 WS4loA48l08T6kZktUQOSB4VgFMp4eL4NAso/Nzq5L87QtyUyV6BrfE7hMASZF/5H
	 BhkA+I+XZhJgNp6hkOt1ontjIiKg/Bmss+UOJMSdXePrCju9YO3CVJ5ZufjhUXQTd
	 gU9yNhm5Lb4WUB1SaUWqdW3le/B5C0LpHTuBN9kEzBfsLmg09mRvoHwKCrymvMXqh
	 odUeh71KSybRhii8wsDDHvAaDWntc6yIUa4HxU0SYXmks3OG6mAKL8d8ezGodrhRt
	 /R5O8QYESgcL6H6CHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.251.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Vu-1szdNq0QvO-00KkV2; Mon, 25
 Nov 2024 19:46:12 +0100
Message-ID: <0c6fa2cc-3a7e-4db2-bbad-7c19a876937e@gmx.net>
Date: Mon, 25 Nov 2024 19:46:10 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] pinctrl: rp1: Implement RaspberryPi RP1 gpio
 support
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
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <1257f76168ae03dba027bd33e6fca31b8df29c35.1732444746.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <1257f76168ae03dba027bd33e6fca31b8df29c35.1732444746.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BPxstd5PG9ii50gxD3QFzCia8ZtZfz1FrMC9GEaSmohukVFc8pM
 4pPyBwPOV1gpyguV4e7aOdGci0vuMRPoCFFJC2WjtJ5SAOdZLn3B1ru/Y0lJ9+yTQylu76E
 cNd94z5KkcKxxBU8JWjbgVMQDNVmNZ/pvxmKODJa+97tmp8HqcWWqqg2Vbr4gJcqwonmHx3
 Wus5KRt3hTWH9+DKCYRgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TfkttF/NobQ=;RJQ4AN65XloMCZXRYId0Lyvr73F
 STq7YLJ96O9szCp1wZFJ6wAEVftm4lorvf5J29jJywz0XoJlQd3vu+DpEXsdfv5L8U3Jcau5m
 y7+81SXU61H3xi+IKKSzVx3VR5CZpAwv4vm6Dawqnb5l+XutNhhkCLj3DMIRISaSJmsfaM0hs
 OkX7zCbA3ftjGQ1yExO/PCnfKNNHdaWj1X7W/nV6P4kSGKyxM6ISrifJ5CNFo+veLzHbX3WMy
 iq3ggFg/+IDdXJhPC79ycPS06lAuznETUlU8hCUGGkxnTzQWAIaA91vr94Cp7N68oUA07isWf
 lWnJY0+feGQsID6+dItAG2Z/05faSirflzo/mVclsdThy//3g7iHqCS1mSiDYVNwZEOMn9w0G
 raiXOkVBT6V1wFa2KqydLYrn6v3Cv35EIlRp/pfLRISJd18rTWyNbmUabckxAygEXN9SDm7Qh
 9iE05MqyBT0v6IBZXKKIwvGVRVPLJXjGDF5OJmhy7xq9aZ5LrbMkHimJB0WraFbUwYpClZBdx
 KPT3bMzcwFFRXIBDnNMjJHbnjcrDx/s1Kzs7F89BIV/29MnTL908vmRnFtXMMaGGHK4nL2UcL
 Bs0HihL+qt3qPQREKCVVz2BFn9+U3Ti2zBYePgOhFHBlYJ5XqNLLB0x5SiR/L46PoYYT55W4B
 8SFVAJAzPvaUUWscxr6fFGrSVe49kuoeEtSUM2NOTrQZZ/ZwUiWKBL0tyuifHv5dp8TYfNNUp
 SrdVq5yiLr7/C7KDqGYyTgHeHXRqFzidU7szXanNfFNnsPeFDMpFHstFzxZbR/9go/tXgNB4m
 yU4iu1GFK0sYJifORjsDW992/kjvcNR27Hd3rxi+zsJm/CawqVzn0/0cJQ7L4dYtz8YrD08tK
 3QPwR8eTcEaMfbCVTuGXAaEWtjzyBbRLLGhD/ecm0jYZx6wAy55022I/J

Hi Andrea,

Am 24.11.24 um 11:51 schrieb Andrea della Porta:
> The RP1 is an MFD supporting a gpio controller and /pinmux/pinctrl.
> Add minimum support for the gpio only portion. The driver is in
> pinctrl folder since upcoming patches will add the pinmux/pinctrl
> support where the gpio part can be seen as an addition.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   MAINTAINERS                   |   1 +
>   drivers/pinctrl/Kconfig       |  11 +
>   drivers/pinctrl/Makefile      |   1 +
>   drivers/pinctrl/pinctrl-rp1.c | 789 ++++++++++++++++++++++++++++++++++
>   4 files changed, 802 insertions(+)
>   create mode 100644 drivers/pinctrl/pinctrl-rp1.c
...
> +
> +static int rp1_pinctrl_probe(struct platform_device *pdev)
> +{
> +	struct regmap *gpio_regmap, *rio_regmap, *pads_regmap;
> +	struct rp1_pinctrl *pc = &rp1_pinctrl_data;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct gpio_irq_chip *girq;
> +	int err, i;
> +
> +	pc->dev = dev;
> +	pc->gpio_chip = rp1_gpio_chip;
> +	pc->gpio_chip.parent = dev;
> +
> +	pc->gpio_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pc->gpio_base))
> +		return dev_err_probe(dev, PTR_ERR(pc->gpio_base), "could not get GPIO IO memory\n");
> +
> +	pc->rio_base = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(pc->rio_base))
> +		return dev_err_probe(dev, PTR_ERR(pc->rio_base), "could not get RIO IO memory\n");
> +
> +	pc->pads_base = devm_platform_ioremap_resource(pdev, 2);
> +	if (IS_ERR(pc->pads_base))
> +		return dev_err_probe(dev, PTR_ERR(pc->pads_base), "could not get PADS IO memory\n");
> +
> +	gpio_regmap = devm_regmap_init_mmio(dev, pc->gpio_base,
> +					    &rp1_pinctrl_regmap_cfg);
> +	if (IS_ERR(gpio_regmap))
> +		return dev_err_probe(dev, PTR_ERR(gpio_regmap), "could not init GPIO regmap\n");
> +
> +	rio_regmap = devm_regmap_init_mmio(dev, pc->rio_base,
> +					   &rp1_pinctrl_regmap_cfg);
> +	if (IS_ERR(rio_regmap))
> +		return dev_err_probe(dev, PTR_ERR(rio_regmap), "could not init RIO regmap\n");
> +
> +	pads_regmap = devm_regmap_init_mmio(dev, pc->pads_base,
> +					    &rp1_pinctrl_regmap_cfg);
> +	if (IS_ERR(pads_regmap))
> +		return dev_err_probe(dev, PTR_ERR(pads_regmap), "could not init PADS regmap\n");
> +
> +	for (i = 0; i < RP1_NUM_BANKS; i++) {
> +		const struct rp1_iobank_desc *bank = &rp1_iobanks[i];
> +		int j;
> +
> +		for (j = 0; j < bank->num_gpios; j++) {
> +			struct rp1_pin_info *pin =
> +				&pc->pins[bank->min_gpio + j];
> +			int reg_off;
> +
> +			pin->num = bank->min_gpio + j;
> +			pin->bank = i;
> +			pin->offset = j;
> +
> +			reg_off = bank->gpio_offset + pin->offset
> +				  * sizeof(u32) * 2;
Just a nit: the first * belongs in the line above

Except of this:

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

