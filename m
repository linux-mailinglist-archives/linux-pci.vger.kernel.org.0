Return-Path: <linux-pci+bounces-17701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0AD9E476B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C39D5B3880A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 21:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B918FC84;
	Wed,  4 Dec 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqejnV9n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337A18B499;
	Wed,  4 Dec 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733347158; cv=none; b=FHvKTubsxZiVLRquZpKOSH7BvHRkCsS0awjji2MUY2JkRUkpMdf+3eHU/u92VZp4HP0Zr7YNpK+/rRl75mU7BarPcpj5SbTqxl+rJmwIfyw33eBXDBVI+ey/fjLeGEiUSHo/En1nwOikpXK+b7GsorsVDHjBv+Yvqq5pT9sTJwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733347158; c=relaxed/simple;
	bh=y8BsGXjqxVRpKujAE+Zpsf0iQlQlKLvP+XXznm8jwaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S6aQerTVbwLObQFQ+V4xwwam0gI9N4Jqqyjz5ExZ5QqdjxFNlh9utv4wB48cB2X0HKggiI/PBsfV16X4hFaGc8ywyQEYJoXNKO1VY5TcK9BWEU/aQ4MkXjAq3Lp7QzlUixJ3x8mu1mpCsRMdraoPu1lOYPGSp7dz8MbMBgDFqjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqejnV9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06E1C4CECD;
	Wed,  4 Dec 2024 21:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733347158;
	bh=y8BsGXjqxVRpKujAE+Zpsf0iQlQlKLvP+XXznm8jwaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SqejnV9nO/eEBpnkIh0HQaoFDQrCg91rAVSBDR3gARg6fGA4MLW3Q8AkQk3pjIPZk
	 RBe1u2hilOegnqrmZLZFSQB2RT18mUZ8mA1LyvX28ym4q5rhnd5ypx9mg6P72OwATg
	 0XJsiSbQfAgavVZYffDc4lGrZQVw6AP2v5sTwEBO9v3593CwMFckdTuSSrAW62oZoo
	 BcItGZ0QvZrBH14AtIUBKw7/P8K8tJNoVHIkMSukoTOac4HVYEfksf+AyzVi6v6cFS
	 Xt4/6mgqPP4/C5zhXNUSbHVI4ls46+tqKCQhc1t5hoFQLyCCEeONRhQq7pSMySPT9V
	 Y6IExXdGBQUpg==
Date: Wed, 4 Dec 2024 15:19:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] PCI: pwrctl: Add power control driver for qps615
Message-ID: <20241204211916.GA3009300@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-qps615_pwr-v3-6-29a1e98aa2b0@quicinc.com>

On Tue, Nov 12, 2024 at 08:31:38PM +0530, Krishna chaitanya chundru wrote:
> QPS615 is the PCIe switch which has one upstream and three downstream
> ports. To one of the downstream ports ethernet MAC is connected as endpoint
> device. Other two downstream ports are supposed to connect to external
> device. One Host can connect to QPS615 by upstream port. QPS615 switch
> needs to be configured after powering on and before PCIe link was up.

s/is the/is a/

> The PCIe controller driver already enables link training at the host side
> even before qps615 driver probe happens, due to this when driver enables
> power to the switch it participates in the link training and PCIe link
> may come up before configuring the switch through i2c. To prevent the
> host from participating in link training, disable link training on the
> host side to ensure the link does not come up before the switch is
> configured via I2C.
> 
> Based up on dt property and type of the port, qps615 is configured
> through i2c.

> +config PCI_PWRCTL_QPS615
> +	tristate "PCI Power Control driver for QPS615"
> +	select PCI_PWRCTL
> +	help
> +	  Say Y here to enable the pwrctl driver for Qualcomm
> +	  QPS615 PCIe switch which enables and configures it
> +	  through i2c.

Does this work if build as a module?  I guess maybe the QPS615 doesn't
even get powered on without this, so it would be configured and then
powered on after module-load time?

s/pwrctl/pwrctrl/ (also in filename, code, variables, etc below)

Will need to be rebased to account for the pwrctl -> pwrctrl rename in
v6.13-rc1.

> +static int qps615_pwrctl_power_on(struct qps615_pwrctl_ctx *ctx)
> +{
> +	struct qps615_pwrctl_cfg *cfg;
> +	int ret, i;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	if (ret < 0)
> +		return dev_err_probe(ctx->pwrctl.dev, ret, "cannot enable regulators\n");
> +
> +	gpiod_set_value(ctx->reset_gpio, 0);
> +
> +	 /* wait for the internal osc frequency to stablise */

s/stablise/stabilise/

> +	usleep_range(10000, 10500);
> +
> +	ret = qps615_pwrctl_assert_deassert_reset(ctx, false);
> +	if (ret)
> +		goto out;
> +
> +	if (ctx->cfg[QPS615_USP].axi_freq_125) {
> +		ret = qps615_pwrctl_i2c_write(ctx->client, QPS615_BUS_CONTROL, BIT(16));
> +		if (ret)
> +			dev_err(ctx->pwrctl.dev, "Setting AXI clk freq failed %d\n", ret);
> +	}
> +
> +	for (i = 0; i < QPS615_MAX; i++) {
> +		cfg = &ctx->cfg[i];
> +		if (cfg->disable_port) {
> +			ret = qps615_pwrctl_disable_port(ctx, i);
> +			if (ret) {
> +				dev_err(ctx->pwrctl.dev, "Disabling port failed\n");
> +				goto out;
> +			}
> +		}

A helper function could remove a level of indentation for the body of
this loop.

> +static int qps615_pwrctl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	enum qps615_pwrctl_ports port;
> +	struct qps615_pwrctl_ctx *ctx;
> +	int ret, addr;
> +
> +	bridge = pci_find_host_bridge(to_pci_dev(dev->parent)->bus);

Move to where "bridge" is used.

> +	platform_set_drvdata(pdev, ctx);

Can this be moved to the point where we know we won't return an error?

Bjorn

