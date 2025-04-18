Return-Path: <linux-pci+bounces-26250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124AFA93EB7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 22:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429AF3B858E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 20:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ED7215076;
	Fri, 18 Apr 2025 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN5czEvz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31521FF1B4;
	Fri, 18 Apr 2025 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745007394; cv=none; b=jwDJKi95TsyL9iiV5AMefW+Sb9SMMuTrVqy5xudqkm5uhgQSlSCSrSlC/yLJKdW3dYRT7NApqGefMFYqHytObqPpF1PW51o36Jt9SUli0FHhYFaFzOUw7uc3uiAbnrE9s0ZnfFoHiozmRe/vw7s+bEcVo6VmyrE/YDCb6x+S/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745007394; c=relaxed/simple;
	bh=rTpRCTfwm2MVRWi3nbqYCX4drV1V+d6UmwAmYWFRARg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SCK8oPNgjXMAYL0RaBpgRxd40yv9Mj1DQ5b+6RDxI9GKIWfkWyUjgSHNa5Jdb4o/kxY0rlcZAil1N3HWryy1FKAtuIyR36/zQ5qdZM10CRMPVIcvsY/32uskJ33lMnJ+QfM3bHhmiDSlclK6CFd9SY1paIMMpPvzxkyjEf2eCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN5czEvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBDDC4CEE2;
	Fri, 18 Apr 2025 20:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745007393;
	bh=rTpRCTfwm2MVRWi3nbqYCX4drV1V+d6UmwAmYWFRARg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZN5czEvztDOLVQkdZAD8MIpfP19duWqWikexTZ7ebu+TlyRo5nW5BZNK5q3psPJZr
	 sX1WIXPbzlXUJqLBEkIQ951lJE0SiWYsnMMB9zS2DoxT5RFOMXMRR313EYxKuvRy4v
	 FXe0a7mQrNsj4yHGi2H4OpIohg5fFXuvlGPKXe/NUpxaidzOWZYuNrU28I0s/5+0G5
	 ofTNGT3tRndvF5vcI6/Lcbpb8/6pm/gE3yu0mhZnW2jzEUtomwECk6fxMD/hqCynOF
	 cBfHHAhxHV2KkDYtKCY6GWJB1nMgwo5em2s57bDXOvFzM0kIWB2IsQLnbcJIQF1cO2
	 cPGNFjcRkszaQ==
Date: Fri, 18 Apr 2025 15:16:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
	amitk@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
	Dmitry Baryshkov <lumag@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5 8/9] PCI: pwrctrl: Add power control driver for tc9563
Message-ID: <20250418201631.GA82526@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412-qps615_v4_1-v5-8-5b6a06132fec@oss.qualcomm.com>

On Sat, Apr 12, 2025 at 07:19:57AM +0530, Krishna Chaitanya Chundru wrote:
> TC9563 is a PCIe switch which has one upstream and three downstream
> ports. To one of the downstream ports ethernet MAC is connected as endpoint
> device. Other two downstream ports are supposed to connect to external
> device. One Host can connect to TC9563 by upstream port. TC9563 switch
> needs to be configured after powering on and before PCIe link was up.

This is described as a generic driver for TC9563, but the ethernet MAC
stuff built into doesn't sound generic.  Maybe this could be clarified
here and in the Kconfig help text.

> +#define TC9563_GPIO_CONFIG		0x801208
> +#define TC9563_RESET_GPIO		0x801210

I guess these are i2c register addresses?

> +#define TC9563_BUS_CONTROL		0x801014

Unused.

> +#define TC9563_PORT_L0S_DELAY		0x82496c
> +#define TC9563_PORT_L1_DELAY		0x824970

I guess these correspond to "L0s Exit Latency" and "L1 Exit Latency"
in the PCIe spec?  Can we name them to suggest that?  Where do the
values come from?

> +#define TC9563_EMBEDDED_ETH_DELAY	0x8200d8
> +#define TC9563_ETH_L1_DELAY_MASK	GENMASK(27, 18)
> +#define TC9563_ETH_L1_DELAY_VALUE(x)	FIELD_PREP(TC9563_ETH_L1_DELAY_MASK, x)
> +#define TC9563_ETH_L0S_DELAY_MASK	GENMASK(17, 13)
> +#define TC9563_ETH_L0S_DELAY_VALUE(x)	FIELD_PREP(TC9563_ETH_L0S_DELAY_MASK, x)

> +#define TC9563_PWRCTL_MAX_SUPPLY	6
> +
> +struct tc9563_pwrctrl_ctx {
> +	struct regulator_bulk_data supplies[TC9563_PWRCTL_MAX_SUPPLY];
> +	struct tc9563_pwrctrl_cfg cfg[TC9563_MAX];
> +	struct gpio_desc *reset_gpio;
> +	struct i2c_adapter *adapter;
> +	struct i2c_client *client;
> +	struct pci_pwrctrl pwrctrl;
> +};

> +static int tc9563_pwrctrl_i2c_write(struct i2c_client *client,
> +				    u32 reg_addr, u32 reg_val)
> +{
> +	struct i2c_msg msg;
> +	u8 msg_buf[7];
> +	int ret;
> +
> +	msg.addr = client->addr;
> +	msg.len = 7;
> +	msg.flags = 0;
> +
> +	/* Big Endian for reg addr */
> +	put_unaligned_be24(reg_addr, &msg_buf[0]);

Of the 1000+ calls to i2c_transfer(), I only see about 25 uses of
put_unaligned_be*() beforehand.  Are most of the other 975 calls
broken?  Or maybe they are only used on platforms of known endianness
so they don't need it?  Just a question; I have no idea how i2c works.

> +	/* Little Endian for reg val */
> +	put_unaligned_le32(reg_val, &msg_buf[3]);
> +
> +	msg.buf = msg_buf;
> +	ret = i2c_transfer(client->adapter, &msg, 1);
> +	return ret == 1 ? 0 : ret;
> +}

> +	ret = of_property_read_u8_array(node, "nfts", cfg->nfts, 2);
> +	if (ret && ret != -EINVAL)
> +		return ret;

Asked elsewhere whether "nfts" is supposed to match the DT "n-fts"
property.

> +static int tc9563_pwrctrl_bring_up(struct tc9563_pwrctrl_ctx *ctx)
> +{
> +	struct tc9563_pwrctrl_cfg *cfg;
> +	int ret, i;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	if (ret < 0)
> +		return dev_err_probe(ctx->pwrctrl.dev, ret, "cannot enable regulators\n");
> +
> +	gpiod_set_value(ctx->reset_gpio, 0);
> +
> +	 /* wait for the internal osc frequency to stablise */

s/stablise/stabilize/ (or "stabilise" if you prefer)

> +	usleep_range(10000, 10500);

Where do these values come from?  Can we add a spec citation?

> +		ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(ctx, i, false, cfg->l0s_delay);
> +		if (ret) {
> +			dev_err(ctx->pwrctrl.dev, "Setting L0s entry delay failed\n");

Since these are *entry* delays, maybe they're not related to the "Exit
Latencies" from the PCIe spec.  But if they *are* related, can we use
the same terms here?

> +		ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(ctx, i, true, cfg->l1_delay);
> +		if (ret) {
> +			dev_err(ctx->pwrctrl.dev, "Setting L1 entry delay failed\n");

> +		ret = tc9563_pwrctrl_set_tx_amplitude(ctx, i, cfg->tx_amp);
> +		if (ret) {
> +			dev_err(ctx->pwrctrl.dev, "Setting Tx amplitube failed\n");

s/amplitube/amplitude/

> +			goto power_off;
> +		}
> +
> +		ret = tc9563_pwrctrl_set_nfts(ctx, i, cfg->nfts);
> +		if (ret) {
> +			dev_err(ctx->pwrctrl.dev, "Setting nfts failed\n");

s/nfts/N_FTS/ to match spec usage.

> +static int tc9563_pwrctrl_probe(struct platform_device *pdev)
> +{

> ...
> +	ctx->supplies[0].supply = "vddc";
> +	ctx->supplies[1].supply = "vdd18";
> +	ctx->supplies[2].supply = "vdd09";
> +	ctx->supplies[3].supply = "vddio1";
> +	ctx->supplies[4].supply = "vddio2";
> +	ctx->supplies[5].supply = "vddio18";

Seems like this could be made into a const static array, maybe next to
TC9563_PWRCTL_MAX_SUPPLY?

> +	for_each_child_of_node_scoped(pdev->dev.of_node, child) {
> +		ret = tc9563_pwrctrl_parse_device_dt(ctx, child, port++);
> +		if (ret)
> +			break;
> +		/* Embedded ethernet device are under DSP3 */
> +		if (port == TC9563_DSP3)

Is this ethernet thing integrated into the TC9563?  Seems like the
sort of topology thing that would normally be described via DT.

> +			for_each_child_of_node_scoped(child, child1) {
> +				ret = tc9563_pwrctrl_parse_device_dt(ctx, child1, port++);
> +				if (ret)
> +					break;
> +			}
> +	}

Bjorn

