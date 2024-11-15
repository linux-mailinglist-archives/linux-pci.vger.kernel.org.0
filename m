Return-Path: <linux-pci+bounces-16873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E831E9CDE34
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 13:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79BA28129B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 12:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B63F1BAED6;
	Fri, 15 Nov 2024 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvBw/SPx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7010F1B85F6
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731673552; cv=none; b=IkljVdzaYQZV01ASCWt72muq2AFLAtUH/K8xDIjXOihOZCGO51MY6AKOx7NoOSEiT/GVeo6of8VXnP42LzDxRD6GAqkRqEDAIbUDMBAReYt6tZ0ys3l6CF+O6B3pU/TsiHBFolQWB9AQx6VF+C4WchYauugBC0iBIjimgEw3ctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731673552; c=relaxed/simple;
	bh=lIJ/3E49ECCRY/5Ravabl3ejOOnuTLKZf1mm56g4roM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prfLZEH1Vk/dvLx80bEjwGdMMPjSXZLIOs5UmngoW4jrllHjvzocZ+CMGq+opZZuF4AsJb/U0U7YQvFGOhpk8O3y0qdxXMnkhCYbluZmcI9Cr4SPFkm6fFc1NlJW78g46x9Sdwfn6sE8Yzrkelg3NsvaFPjNUbbeVQ51+kB8GMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jvBw/SPx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ea08667b23so1379954a91.2
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 04:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731673550; x=1732278350; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CEWQbLPz0G8f0UPh7thhjQWlTKXTRi0zZUX8xbTR0Vs=;
        b=jvBw/SPxZE6K49TiH7vuBkaH9mucu+CgYwMNAKdYTOAGoGp+Nv1tKD5EnOuLkQknWk
         Ly72c86Z702pIkLBtdCxt1t8C+CiTbP3hx43768q7dk1uQXca7MBaxLcgmXp8zrX03cP
         ekT4s/JmzBlfD/7JEdhbgBghnSFiXgoCXiFfDthaYkvC6kkp8xT5fSsQRQd0w4OE8ll5
         8xgpIzvDKBb2GdBrJzijAFPpFCOFHScjrR+8XjuLhB+iNEClGAajlldt8htaVr4D5Jfh
         ROAZIO3KfGZ9ELObiZffU5645/xQy561BlPVKVcHD+QhuuzvIlsjcrh+jRq2t1Qb4YJQ
         529g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731673550; x=1732278350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEWQbLPz0G8f0UPh7thhjQWlTKXTRi0zZUX8xbTR0Vs=;
        b=Lpcnjg2gNuCuMUfAeSoON5q24OsV+u+QCf2wC93Ammg/C+gJ4bFihUjSOagM8iw2zc
         SoHPkR8dr+eRJ0n8KX+32WdWLcc7RULa5K6AlbukniH7e6duERDjgaiyp8MsnJjuQn7a
         iuLKjmRW9q8RQjX9JEzxBhp7isc6f0uURj55gG6niCA+Cxqj8PtViPTsjA8vMxJmHJh9
         ZwwwqyT+tklnz5nwu+1WAJ7yepkJ/Jghtqjn2eSs/ghYiaLtytZ36mL2P9dB9h6qeOpj
         e7L3i2S/E58it9jEiIH7QsYxsyL8gMOYK2CQZBptMJrnySqINGocxEpnOutQ+fsNSzXQ
         X5MA==
X-Forwarded-Encrypted: i=1; AJvYcCX0Td740dFe3UsSOVR6J+upQmWSPdWLT8EWNeJsfi7E/o7jMDM2/gMyLRLSElOrlHhPq9xAi5A1SE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1fsPEq8nG5N5/Veas+/VoOnXxmmSBDTip+2q9P4SjjICIlR7i
	00qaFgIB8YM2aKJc5deJ96lr6IqScBss4ETne2q6Ca6BgJSwUgkf8MpBnipfNA==
X-Google-Smtp-Source: AGHT+IH7BvXsWxX9oWXtG753qt07vyMmSgbdYhlT0zdlYkcuidltUonudpcoYJ/0EDkCxsS1zU2q+Q==
X-Received: by 2002:a17:90b:4c03:b0:2e2:da81:40c3 with SMTP id 98e67ed59e1d1-2ea154cd474mr2729975a91.1.1731673549660;
        Fri, 15 Nov 2024 04:25:49 -0800 (PST)
Received: from thinkpad ([117.193.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea02481b30sm2769144a91.7.2024.11.15.04.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 04:25:49 -0800 (PST)
Date: Fri, 15 Nov 2024 17:55:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
Message-ID: <20241115122539.yltkwukg5zuhwit4@thinkpad>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-6-29a1e98aa2b0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112-qps615_pwr-v3-6-29a1e98aa2b0@quicinc.com>

On Tue, Nov 12, 2024 at 08:31:38PM +0530, Krishna chaitanya chundru wrote:
> QPS615 is the PCIe switch which has one upstream and three downstream
> ports. To one of the downstream ports ethernet MAC is connected as endpoint
> device. Other two downstream ports are supposed to connect to external
> device. One Host can connect to QPS615 by upstream port. QPS615 switch
> needs to be configured after powering on and before PCIe link was up.
> 
> The PCIe controller driver already enables link training at the host side
> even before qps615 driver probe happens, due to this when driver enables
> power to the switch it participates in the link training and PCIe link
> may come up before configuring the switch through i2c. To prevent the

State the reason why the i2c config needs to be done before link up.

> host from participating in link training, disable link training on the
> host side to ensure the link does not come up before the switch is
> configured via I2C.
> 
> Based up on dt property and type of the port, qps615 is configured
> through i2c.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/pwrctl/Kconfig             |   8 +
>  drivers/pci/pwrctl/Makefile            |   1 +
>  drivers/pci/pwrctl/pci-pwrctl-qps615.c | 630 +++++++++++++++++++++++++++++++++
>  3 files changed, 639 insertions(+)
> 
> diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
> index 54589bb2403b..fe945d176b8b 100644
> --- a/drivers/pci/pwrctl/Kconfig
> +++ b/drivers/pci/pwrctl/Kconfig
> @@ -10,3 +10,11 @@ config PCI_PWRCTL_PWRSEQ
>  	tristate
>  	select POWER_SEQUENCING
>  	select PCI_PWRCTL
> +
> +config PCI_PWRCTL_QPS615
> +	tristate "PCI Power Control driver for QPS615"

QPS615 PCIe switch

> +	select PCI_PWRCTL
> +	help
> +	  Say Y here to enable the pwrctl driver for Qualcomm
> +	  QPS615 PCIe switch which enables and configures it
> +	  through i2c.
> diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
> index d308aae4800c..ac563a70c023 100644
> --- a/drivers/pci/pwrctl/Makefile
> +++ b/drivers/pci/pwrctl/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctl-core.o
>  pci-pwrctl-core-y			:= core.o
>  
>  obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+= pci-pwrctl-pwrseq.o
> +obj-$(CONFIG_PCI_PWRCTL_QPS615)		+= pci-pwrctl-qps615.o
> diff --git a/drivers/pci/pwrctl/pci-pwrctl-qps615.c b/drivers/pci/pwrctl/pci-pwrctl-qps615.c
> new file mode 100644
> index 000000000000..c338e35c9083
> --- /dev/null
> +++ b/drivers/pci/pwrctl/pci-pwrctl-qps615.c
> @@ -0,0 +1,630 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <linux/pci-pwrctl.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +
> +#include "../pci.h"
> +
> +#define QPS615_GPIO_CONFIG		0x801208
> +#define QPS615_RESET_GPIO		0x801210
> +
> +#define QPS615_BUS_CONTROL		0x801014
> +
> +#define QPS615_PORT_L0S_DELAY		0x82496c
> +#define QPS615_PORT_L1_DELAY		0x824970
> +
> +#define QPS615_EMBEDDED_ETH_DELAY	0x8200d8
> +#define QPS615_ETH_L1_DELAY_MASK	GENMASK(27, 18)
> +#define QPS615_ETH_L1_DELAY_VALUE(x)	FIELD_PREP(QPS615_ETH_L1_DELAY_MASK, x)
> +#define QPS615_ETH_L0S_DELAY_MASK	GENMASK(17, 13)
> +#define QPS615_ETH_L0S_DELAY_VALUE(x)	FIELD_PREP(QPS615_ETH_L0S_DELAY_MASK, x)
> +
> +#define QPS615_NFTS_2_5_GT		0x824978
> +#define QPS615_NFTS_5_GT		0x82497c
> +
> +#define QPS615_PORT_LANE_ACCESS_ENABLE	0x828000
> +
> +#define QPS615_PHY_RATE_CHANGE_OVERRIDE	0x828040
> +#define QPS615_PHY_RATE_CHANGE		0x828050
> +
> +#define QPS615_TX_MARGIN		0x828234
> +
> +#define QPS615_DFE_ENABLE		0x828a04
> +#define QPS615_DFE_EQ0_MODE		0x828a08
> +#define QPS615_DFE_EQ1_MODE		0x828a0c
> +#define QPS615_DFE_EQ2_MODE		0x828a14
> +#define QPS615_DFE_PD_MASK		0x828254
> +
> +#define QPS615_PORT_SELECT		0x82c02c
> +#define QPS615_PORT_ACCESS_ENABLE	0x82c030
> +
> +#define QPS615_POWER_CONTROL		0x82b09c
> +#define QPS615_POWER_CONTROL_OVREN	0x82b2c8
> +
> +#define QPS615_FREQ_125_MHZ		125000000
> +#define QPS615_FREQ_250_MHZ		250000000
> +
> +#define QPS615_GPIO_MASK		0xfffffff3
> +
> +struct qps615_pwrctl_reg_setting {
> +	unsigned int offset;
> +	unsigned int val;
> +};
> +
> +enum qps615_pwrctl_ports {
> +	QPS615_USP,
> +	QPS615_DSP1,
> +	QPS615_DSP2,
> +	QPS615_DSP3,
> +	QPS615_ETHERNET,
> +	QPS615_MAX
> +};
> +
> +struct qps615_pwrctl_cfg {
> +	u32 l0s_delay;
> +	u32 l1_delay;
> +	u32 tx_amp;
> +	u32 nfts;
> +	bool disable_dfe;
> +	bool disable_port;
> +	bool axi_freq_125;
> +};
> +
> +#define QPS615_PWRCTL_MAX_SUPPLY	6
> +
> +struct qps615_pwrctl_ctx {
> +	struct regulator_bulk_data supplies[QPS615_PWRCTL_MAX_SUPPLY];
> +	struct qps615_pwrctl_cfg cfg[QPS615_MAX];
> +	struct gpio_desc *reset_gpio;
> +	struct i2c_adapter *adapter;
> +	struct i2c_client *client;
> +	struct pci_pwrctl pwrctl;
> +};
> +
> +/*
> + * downstream port power off sequence, hardcoding the address
> + * as we don't know register names for these register offsets.
> + */
> +static const struct qps615_pwrctl_reg_setting common_pwroff_seq[] = {
> +	{0x82900c, 0x1},
> +	{0x829010, 0x1},
> +	{0x829018, 0x0},
> +	{0x829020, 0x1},
> +	{0x82902c, 0x1},
> +	{0x829030, 0x1},
> +	{0x82903c, 0x1},
> +	{0x829058, 0x0},
> +	{0x82905c, 0x1},
> +	{0x829060, 0x1},
> +	{0x8290cc, 0x1},
> +	{0x8290d0, 0x1},
> +	{0x8290d8, 0x1},
> +	{0x8290e0, 0x1},
> +	{0x8290e8, 0x1},
> +	{0x8290ec, 0x1},
> +	{0x8290f4, 0x1},
> +	{0x82910c, 0x1},
> +	{0x829110, 0x1},
> +	{0x829114, 0x1},
> +};
> +
> +static const struct qps615_pwrctl_reg_setting dsp1_pwroff_seq[] = {
> +	{QPS615_PORT_ACCESS_ENABLE, 0x2},
> +	{QPS615_PORT_LANE_ACCESS_ENABLE, 0x3},
> +	{QPS615_POWER_CONTROL, 0x014f4804},
> +	{QPS615_POWER_CONTROL_OVREN, 0x1},
> +	{QPS615_PORT_ACCESS_ENABLE, 0x4},
> +};
> +
> +static const struct qps615_pwrctl_reg_setting dsp2_pwroff_seq[] = {
> +	{QPS615_PORT_ACCESS_ENABLE, 0x8},
> +	{QPS615_PORT_LANE_ACCESS_ENABLE, 0x1},
> +	{QPS615_POWER_CONTROL, 0x014f4804},
> +	{QPS615_POWER_CONTROL_OVREN, 0x1},
> +	{QPS615_PORT_ACCESS_ENABLE, 0x8},
> +};
> +
> +/*
> + * Since all transfers are initiated by the probe, no locks are necessary,
> + * ensuring there are no concurrent calls.

'ensuring there are no concurrent calls' is not quite right here.

> + */
> +static int qps615_pwrctl_i2c_write(struct i2c_client *client,
> +				   u32 reg_addr, u32 reg_val)
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
> +
> +	/* Little Endian for reg val */
> +	put_unaligned_le32(reg_val, &msg_buf[3]);
> +
> +	msg.buf = msg_buf;
> +	ret = i2c_transfer(client->adapter, &msg, 1);
> +	return ret == 1 ? 0 : ret;
> +}
> +
> +static int qps615_pwrctl_i2c_read(struct i2c_client *client,
> +				  u32 reg_addr, u32 *reg_val)
> +{
> +	struct i2c_msg msg[2];
> +	u8 wr_data[3];
> +	u32 rd_data;
> +	int ret;
> +
> +	msg[0].addr = client->addr;
> +	msg[0].len = 3;
> +	msg[0].flags = 0;
> +
> +	/* Big Endian for reg addr */
> +	put_unaligned_be24(reg_addr, &wr_data[0]);
> +
> +	msg[0].buf = wr_data;
> +
> +	msg[1].addr = client->addr;
> +	msg[1].len = 4;
> +	msg[1].flags = I2C_M_RD;
> +
> +	msg[1].buf = (u8 *)&rd_data;
> +
> +	ret = i2c_transfer(client->adapter, &msg[0], 2);
> +	if (ret == 2) {
> +		*reg_val = get_unaligned_le32(&rd_data);
> +		return 0;
> +	}
> +
> +	/* If only one message successfully completed, return -ENODEV */

EIO?

> +	return ret == 1 ? -ENODEV : ret;
> +}
> +

[...]

> +static int qps615_pwrctl_set_nfts(struct qps615_pwrctl_ctx *ctx,
> +				  enum qps615_pwrctl_ports port, u32 nfts)
> +{
> +	int ret;
> +	struct qps615_pwrctl_reg_setting nfts_seq[] = {
> +		{QPS615_NFTS_2_5_GT, nfts},
> +		{QPS615_NFTS_5_GT, nfts},
> +	};

Reverse Xmas order.

> +
> +	ret =  qps615_pwrctl_i2c_write(ctx->client, QPS615_PORT_SELECT, BIT(port));
> +	if (ret)
> +		return ret;
> +
> +	return qps615_pwrctl_i2c_bulk_write(ctx->client, nfts_seq, ARRAY_SIZE(nfts_seq));
> +}
> +
> +static int qps615_pwrctl_assert_deassert_reset(struct qps615_pwrctl_ctx *ctx, bool deassert)
> +{
> +	int ret, val;
> +
> +	ret = qps615_pwrctl_i2c_write(ctx->client, QPS615_GPIO_CONFIG, QPS615_GPIO_MASK);
> +	if (ret)
> +		return ret;
> +
> +	val = deassert ? 0xc : 0;
> +
> +	return qps615_pwrctl_i2c_write(ctx->client, QPS615_RESET_GPIO, val);
> +}
> +
> +static int qps615_pwrctl_parse_device_dt(struct qps615_pwrctl_ctx *ctx, struct device_node *node,
> +					 enum qps615_pwrctl_ports port)
> +{
> +	struct qps615_pwrctl_cfg *cfg;
> +	u32 axi_freq = 0;
> +	int ret;
> +
> +	cfg = &ctx->cfg[port];
> +

It'd be better to add a comment here about disabling ports.

> +	if (!of_device_is_available(node)) {
> +		cfg->disable_port = true;
> +		return 0;
> +	};
> +
> +	ret = of_property_read_u32(node, "qcom,axi-clk-freq-hz", &axi_freq);
> +	if (ret && ret != -EINVAL)
> +		return ret;
> +	else if (axi_freq && (axi_freq != QPS615_FREQ_125_MHZ || axi_freq != QPS615_FREQ_250_MHZ))
> +		return -EINVAL;

Add a dev_err() to print the reason.

> +	else if (axi_freq == QPS615_FREQ_125_MHZ)
> +		cfg->axi_freq_125 = true;
> +
> +	ret = of_property_read_u32(node, "qcom,l0s-entry-delay-ns", &cfg->l0s_delay);
> +	if (ret && ret != -EINVAL)
> +		return ret;
> +
> +	ret = of_property_read_u32(node, "qcom,l1-entry-delay-ns", &cfg->l1_delay);
> +	if (ret && ret != -EINVAL)
> +		return ret;
> +
> +	ret = of_property_read_u32(node, "qcom,tx-amplitude-millivolt", &cfg->tx_amp);
> +	if (ret && ret != -EINVAL)
> +		return ret;
> +
> +	ret = of_property_read_u32(node, "qcom,nfts", &cfg->nfts);
> +	if (ret && ret != -EINVAL)
> +		return ret;
> +
> +	cfg->disable_dfe = of_property_read_bool(node, "qcom,no-dfe-support");
> +
> +	return 0;
> +}
> +
> +static void qps615_pwrctl_power_off(struct qps615_pwrctl_ctx *ctx)
> +{
> +	gpiod_set_value(ctx->reset_gpio, 1);
> +
> +	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +}
> +
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
> +	usleep_range(10000, 10500);
> +
> +	ret = qps615_pwrctl_assert_deassert_reset(ctx, false);
> +	if (ret)
> +		goto out;

goto power_off;

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
> +
> +		if (cfg->l0s_delay) {
> +			ret = qps615_pwrctl_set_l0s_l1_entry_delay(ctx, i, false, cfg->l0s_delay);
> +			if (ret) {
> +				dev_err(ctx->pwrctl.dev, "Setting L0s entry delay failed\n");
> +				goto out;
> +			}
> +		}
> +
> +		if (cfg->l1_delay) {
> +			ret = qps615_pwrctl_set_l0s_l1_entry_delay(ctx, i, true, cfg->l1_delay);
> +			if (ret) {
> +				dev_err(ctx->pwrctl.dev, "Setting L1 entry delay failed\n");
> +				goto out;
> +			}
> +		}
> +
> +		if (cfg->tx_amp) {
> +			ret = qps615_pwrctl_set_tx_amplitude(ctx, i, cfg->tx_amp);
> +			if (ret) {
> +				dev_err(ctx->pwrctl.dev, "Setting Tx amplitube failed\n");
> +				goto out;
> +			}
> +		}
> +
> +		if (cfg->nfts) {
> +			ret = qps615_pwrctl_set_nfts(ctx, i, cfg->nfts);
> +			if (ret) {
> +				dev_err(ctx->pwrctl.dev, "Setting nfts failed\n");
> +				goto out;
> +			}
> +		}
> +
> +		if (cfg->disable_dfe) {
> +			ret = qps615_pwrctl_disable_dfe(ctx, i);
> +			if (ret) {
> +				dev_err(ctx->pwrctl.dev, "Disabling DFE failed\n");
> +				goto out;
> +			}
> +		}
> +	}
> +
> +	ret = qps615_pwrctl_assert_deassert_reset(ctx, true);
> +	if (!ret)
> +		return 0;
> +
> +out:
> +	qps615_pwrctl_power_off(ctx);
> +	return ret;
> +}
> +
> +static int qps615_pwrctl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	enum qps615_pwrctl_ports port;
> +	struct qps615_pwrctl_ctx *ctx;
> +	int ret, addr;
> +
> +	bridge = pci_find_host_bridge(to_pci_dev(dev->parent)->bus);

You can initialize it at the declaration itself.

> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "i2c-parent", 1, &addr);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read i2c-parent property\n");
> +
> +	ctx->adapter = of_find_i2c_adapter_by_node(of_parse_phandle(dev->of_node, "i2c-parent", 0));
> +	of_node_put(dev->of_node);
> +	if (!ctx->adapter)
> +		return dev_err_probe(dev, -EPROBE_DEFER, "Failed to find I2C adapter\n");
> +
> +	ctx->client = i2c_new_dummy_device(ctx->adapter, addr);
> +	if (IS_ERR(ctx->client)) {
> +		dev_err(dev, "Failed to create I2C client\n");
> +		i2c_put_adapter(ctx->adapter);
> +		return PTR_ERR(ctx->client);
> +	}
> +
> +	ctx->supplies[0].supply = "vddc";
> +	ctx->supplies[1].supply = "vdd18";
> +	ctx->supplies[2].supply = "vdd09";
> +	ctx->supplies[3].supply = "vddio1";
> +	ctx->supplies[4].supply = "vddio2";
> +	ctx->supplies[5].supply = "vddio18";
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	if (ret) {
> +		dev_err_probe(dev, ret,
> +			      "failed to get supply regulator\n");
> +		goto remove_i2c;
> +	}
> +
> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_ASIS);

Do not request GPIO with ASIS, always specify the polarity.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

