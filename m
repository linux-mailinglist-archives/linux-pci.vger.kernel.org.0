Return-Path: <linux-pci+bounces-9329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DFB918DF5
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 20:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149F61F247A6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 18:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0518190478;
	Wed, 26 Jun 2024 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zEHtUAuT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD2F18FDDA
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425404; cv=none; b=iMiMytZvq5JBGxG2wGXxwpKgW7wWdjD+XRnVaQxFmYly3SYjc6QypvjTdGyMCASAsFFX34HT8vkPufQf3/iPJY8ZkdIcSQe+QNwX3nCUXD9VATGKu1e7EYuG/RJDQv72uCw+Q9bHBM8DKfu3e1UL5B0+NpEPJM4lpQ2bSMeKrxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425404; c=relaxed/simple;
	bh=aqO6tXWPkXxHxARXl5niFMQ2chl6eKAK0DerFv+cqdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWd04NYjzYg43/6m5/cgp6wuwwJoH13WMmRtkFg/3L0mzdaLhIEnUpk7IUn/3Nf1Hl8K0NXuwtSP+jB6iS1nLhHvIUf7Y9VvHF8Nt08ZSbgxQoHyd13A4qUfqwFInKfu+KY73UghKQ7bI3eiF2dZrorOch4HnIUO2rKU/zw7H64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zEHtUAuT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5295eb47b48so8440918e87.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719425400; x=1720030200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MwI8HnQqswBve0leqtIjtCZs436AspF9fXJZ9wnULGU=;
        b=zEHtUAuTiMVmLWWG1Ltgj6IPR/518lNQYsdxuoTqZkZchbCPPhtjOvYPeexUqAjNwX
         0rSbVkbQBlYbS1tgz9f7nCFFnzQLA7GZ3+SaUqGUWp0uoxALzGFoDZO1gxRny0Zi8udM
         ctVpdjVS619hAnBDIWpJzE19gTfhgxuUJx14/uhes5pwgh2a9TtygiXV6kIwDANy0g2u
         Fn8iUDafrzMWG3fu/oQTg5B6q/b8RUQX9YbiyEMIsvaLdUqW02vB3n5oDjOChaXV1tHa
         JReV8CegdrJGk61mre6AEhTRHEmCpOdlSEkHwUYmJulaPwTWt9L6oBWxAT4/aNIxf40t
         vHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719425400; x=1720030200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwI8HnQqswBve0leqtIjtCZs436AspF9fXJZ9wnULGU=;
        b=PAreuy1M9yWjHF3syofxzigqrP3RoB/BoJ8AaqnE3cfTzXCkwvXuRsfQO3Y+esEHqj
         I0/gB8Ai8kM3Y0BZS6d4mxkmWNvAoqZfCFPPZh5K9aE0CrNuxhvaCew8PxbUUhFdK6o5
         myD6F3a+T3LfdTLX7XJ4OGi1KXYH9pno9HpQLiivsjutNzc6xPGO8BMT8zJXK7Mj3m5R
         LpjNMkkWsZO12jp6fo75GUghqyVuoXp0PZlZXfawIia7RC6I+rFKi8agOfGczBR4Togi
         hfsC0v36TVSykmnWTC+yKxl9ktbhfCM5cggFJhfCt/l8U/L9w0HFBFmtn6QSDsuh05ad
         rfcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHR+1B/8dnrS2oHgV/DljmmHiy+8s0J7NpF4+BIy/knYSsErUwtsuTaM2BqRx1FjKu6jPU9PiQ2k8oZPeLU4/2OP/xOeY+7vxl
X-Gm-Message-State: AOJu0YzywWPGnLiRy5GJZtuwSkicNCFTSNtTiV97a6i6BqTuN9AWlqaS
	F8lMDYOxcPQfvcn9qtDfSmpxXxN99R8gpRdPEouGTpyN0D6C8+XO2xoQBiIw4NM=
X-Google-Smtp-Source: AGHT+IEZDqNuQJkmwPnz58eiHwca1g4EbD8OnZL+sIoH+FY/q/yFSu/vJlZDBIym3wK/LWJvekp50g==
X-Received: by 2002:ac2:4903:0:b0:52c:8df9:2e6f with SMTP id 2adb3069b0e04-52ce0641630mr8997602e87.42.1719425399187;
        Wed, 26 Jun 2024 11:09:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd6432b35sm1637378e87.215.2024.06.26.11.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 11:09:58 -0700 (PDT)
Date: Wed, 26 Jun 2024 21:09:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com, 
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 7/7] pci: pwrctl: Add power control driver for qps615
Message-ID: <dnntqmjqamnifaziahlu6njlsfhjl3dpprjogrdgtqthdpoigk@wmtojmnsuvsv>
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
 <20240626-qps615-v1-7-2ade7bd91e02@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-qps615-v1-7-2ade7bd91e02@quicinc.com>

On Wed, Jun 26, 2024 at 06:07:55PM GMT, Krishna chaitanya chundru wrote:
> QPS615 switch needs to configured after powering on and before
> PCIe link was up.
> 
> As the PCIe controller driver already enables the PCIe link training
> at the host side, stop the link training.
> Otherwise the moment we turn on the switch it will participate in
> the link training and link may come before switch is configured through
> i2c.
> 
> The switch can be configured different ways like changing de-emphasis
> settings of the switch, disabling unused ports etc and these settings
> can vary from board to board, for that reason the sequence is taken
> from the firmware file which contains the address of the slave, to address
> and data to be written to the switch. The driver reads the firmware file
> and parses them to apply those configurations to the switch.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/pwrctl/Kconfig             |   7 +
>  drivers/pci/pwrctl/Makefile            |   1 +
>  drivers/pci/pwrctl/pci-pwrctl-qps615.c | 278 +++++++++++++++++++++++++++++++++
>  3 files changed, 286 insertions(+)
> 
> diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
> index f1b824955d4b..a419b250006d 100644
> --- a/drivers/pci/pwrctl/Kconfig
> +++ b/drivers/pci/pwrctl/Kconfig
> @@ -14,4 +14,11 @@ config PCI_PWRCTL_PWRSEQ
>  	  Enable support for the PCI power control driver for device
>  	  drivers using the Power Sequencing subsystem.
>  
> +config PCI_PWRCTL_QPS615
> +	tristate "PCI Power Control driver for QPS615"
> +	select PCI_PWRCTL
> +	help
> +	  Enable support for the PCI power control driver for QPS615 and
> +	  configures it.
> +
>  endmenu
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
> index 000000000000..1f2caf5d7da2
> --- /dev/null
> +++ b/drivers/pci/pwrctl/pci-pwrctl-qps615.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/firmware.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pci-pwrctl.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include "../pci.h"
> +
> +struct qcom_qps615_pwrctl_i2c_setting {
> +	u32 slv_addr;
> +	u32 reg_addr;
> +	u32 val;
> +};
> +
> +struct qcom_qps615_pwrctl_ctx {
> +	struct i2c_adapter *adapter;
> +	struct pci_pwrctl pwrctl;
> +	struct device_link *link;
> +	struct regulator *vdd;
> +};
> +
> +/* write 32-bit value to 24 bit register */
> +static int qps615_switch_i2c_write(struct qcom_qps615_pwrctl_ctx *ctx, u32 slv_addr, u32 reg_addr,
> +				   u32 reg_val)
> +{
> +	struct i2c_msg msg;
> +	u8 msg_buf[7];
> +	int ret;
> +
> +	msg.addr = slv_addr;
> +	msg.len = 7;
> +	msg.flags = 0;
> +
> +	/* Big Endian for reg addr */
> +	msg_buf[0] = (u8)(reg_addr >> 16);
> +	msg_buf[1] = (u8)(reg_addr >> 8);
> +	msg_buf[2] = (u8)reg_addr;
> +
> +	/* Little Endian for reg val */
> +	msg_buf[3] = (u8)(reg_val);
> +	msg_buf[4] = (u8)(reg_val >> 8);
> +	msg_buf[5] = (u8)(reg_val >> 16);
> +	msg_buf[6] = (u8)(reg_val >> 24);
> +
> +	msg.buf = msg_buf;
> +	ret = i2c_transfer(ctx->adapter, &msg, 1);
> +	return ret == 1 ? 0 : ret;
> +}
> +
> +/* read 32 bit value from 24 bit reg addr */
> +static int qps615_switch_i2c_read(struct qcom_qps615_pwrctl_ctx *ctx, u32 slv_addr, u32 reg_addr,
> +				  u32 *reg_val)
> +{
> +	u8 wr_data[3], rd_data[4] = {0};
> +	struct i2c_msg msg[2];
> +	int ret;
> +
> +	msg[0].addr = slv_addr;
> +	msg[0].len = 3;
> +	msg[0].flags = 0;
> +
> +	/* Big Endian for reg addr */
> +	wr_data[0] = (u8)(reg_addr >> 16);
> +	wr_data[1] = (u8)(reg_addr >> 8);
> +	wr_data[2] = (u8)reg_addr;
> +
> +	msg[0].buf = wr_data;
> +
> +	msg[1].addr = slv_addr;
> +	msg[1].len = 4;
> +	msg[1].flags = I2C_M_RD;
> +
> +	msg[1].buf = rd_data;
> +
> +	ret = i2c_transfer(ctx->adapter, &msg[0], 2);
> +	if (ret != 2)
> +		return ret;
> +
> +	*reg_val = (rd_data[3] << 24) | (rd_data[2] << 16) | (rd_data[1] << 8) | rd_data[0];
> +
> +	return 0;
> +}
> +
> +static int qcom_qps615_pwrctl_init(struct qcom_qps615_pwrctl_ctx *ctx)
> +{
> +	struct device *dev = ctx->pwrctl.dev;
> +	struct qcom_qps615_pwrctl_i2c_setting *set;
> +	const struct firmware *fw;
> +	const u8 *pos, *eof;
> +	int ret;
> +	u32 val;
> +
> +	ret = request_firmware(&fw, "qcom/qps615.bin", dev);

Oh, what if any other board uses the same bridge? Do you expect that the
rootfs is device-specific?

> +	if (ret < 0) {
> +		dev_err(dev, "firmware loading failed with ret %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!fw) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	pos = fw->data;
> +	eof = fw->data + fw->size;
> +
> +	while (pos < (fw->data + fw->size)) {
> +		set = (struct qcom_qps615_pwrctl_i2c_setting *)pos;
> +
> +		ret = qps615_switch_i2c_write(ctx, set->slv_addr, set->reg_addr, set->val);

No! This makes no way for anybody to understand what is going on. Please
write a proper driver, that defines registers and writes sensible data
to those registers. Having a driver that writes data from the
configuration file to the random registers is a no-go.

> +		if (ret) {
> +			dev_err(dev,
> +				"I2c write failed for slv addr:%x at addr%x with val %x ret %d\n",
> +				set->slv_addr, set->reg_addr, set->val, ret);
> +			goto err;
> +		}
> +
> +		ret = qps615_switch_i2c_read(ctx,  set->slv_addr, set->reg_addr, &val);
> +		if (ret) {
> +			dev_err(dev, "I2c read failed for slv addr:%x at addr%x ret %d\n",
> +				set->slv_addr, set->reg_addr, ret);
> +			goto err;
> +		}
> +
> +		if (set->val != val) {
> +			dev_err(dev,
> +				"I2c read's mismatch for slv:%x at addr%x exp%d got%d\n",
> +				set->slv_addr, set->reg_addr, set->val, val);
> +			goto err;
> +		}
> +		pos += sizeof(struct qcom_qps615_pwrctl_i2c_setting);
> +	}
> +
> +err:
> +	release_firmware(fw);
> +
> +	return ret;
> +}
> +
> +static int qcom_qps615_power_on(struct qcom_qps615_pwrctl_ctx *ctx)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(ctx->vdd);
> +	if (ret) {
> +		dev_err(ctx->pwrctl.dev, "cannot enable vdda regulator\n");
> +		return ret;
> +	}
> +
> +	ret = qcom_qps615_pwrctl_init(ctx);
> +	if (ret)
> +		regulator_disable(ctx->vdd);
> +
> +	return ret;
> +}
> +
> +static int qcom_qps615_power_off(struct qcom_qps615_pwrctl_ctx *ctx)
> +{
> +	return regulator_disable(ctx->vdd);
> +}
> +
> +static int qcom_qps615_pwrctl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = pdev->dev.of_node;
> +	struct qcom_qps615_pwrctl_ctx *ctx;
> +	struct device_node *adapter_node;
> +	struct pci_host_bridge *bridge;
> +	struct i2c_adapter *adapter;
> +	struct pci_bus *bus;
> +
> +	bus = pci_find_bus(of_get_pci_domain_nr(dev->parent->of_node), 0);
> +	if (!bus)
> +		return -ENODEV;
> +
> +	bridge = pci_find_host_bridge(bus);
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	adapter_node = of_parse_phandle(node, "switch-i2c-cntrl", 0);
> +	if (adapter_node) {
> +		adapter = of_get_i2c_adapter_by_node(adapter_node);

Somebody didn't read the comment before of_get_i2c_adapter_by_node().

> +		__free(adapter_node);
> +		if (!adapter)
> +			return dev_err_probe(dev, -EPROBE_DEFER,
> +					     "failed to parse switch-i2c-cntrl\n");
> +	}
> +
> +	ctx->pwrctl.dev = dev;
> +	ctx->adapter = adapter;
> +	ctx->vdd = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(ctx->vdd))
> +		return dev_err_probe(dev, PTR_ERR(ctx->vdd),
> +				     "failed to get vdd regulator\n");
> +
> +	ctx->link = device_link_add(&bridge->dev, dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> +
> +	platform_set_drvdata(pdev, ctx);
> +
> +	bridge->ops->stop_link(bus);
> +	qcom_qps615_power_on(ctx);
> +	bridge->ops->start_link(bus);
> +
> +	return devm_pci_pwrctl_device_set_ready(dev, &ctx->pwrctl);
> +}

I'd suggest turning this into a driver which uses components to bind the
PCIe power control part and the i2c clinet device. Then you can write
the i2c client addresses as ussual.

> +
> +static const struct of_device_id qcom_qps615_pwrctl_of_match[] = {
> +	{
> +		.compatible = "pci1179,0623",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qcom_qps615_pwrctl_of_match);
> +
> +static int pci_pwrctl_suspend_noirq(struct device *dev)
> +{
> +	struct pci_bus *bus = pci_find_bus(of_get_pci_domain_nr(dev->parent->of_node), 0);
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> +	struct qcom_qps615_pwrctl_ctx *ctx = dev_get_drvdata(dev);
> +
> +	bridge->ops->stop_link(bus);
> +	qcom_qps615_power_off(ctx);
> +
> +	return 0;
> +}
> +
> +static int pci_pwrctl_resume_noirq(struct device *dev)
> +{
> +	struct pci_bus *bus = pci_find_bus(of_get_pci_domain_nr(dev->parent->of_node), 0);
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> +	struct qcom_qps615_pwrctl_ctx *ctx = dev_get_drvdata(dev);
> +
> +	qcom_qps615_power_on(ctx);
> +	bridge->ops->start_link(bus);
> +
> +	return 0;
> +}
> +
> +static void qcom_qps615_pwrctl_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct qcom_qps615_pwrctl_ctx *ctx = dev_get_drvdata(dev);
> +
> +	device_link_del(ctx->link);
> +	pci_pwrctl_suspend_noirq(dev);
> +}
> +
> +static const struct dev_pm_ops pci_pwrctl_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(pci_pwrctl_suspend_noirq, pci_pwrctl_resume_noirq)
> +};
> +
> +static struct platform_driver qcom_qps615_pwrctl_driver = {
> +	.driver = {
> +		.name = "pwrctl-qps615",
> +		.of_match_table = qcom_qps615_pwrctl_of_match,
> +		.pm = &pci_pwrctl_pm_ops,
> +	},
> +	.probe = qcom_qps615_pwrctl_probe,
> +	.remove_new = qcom_qps615_pwrctl_remove,
> +};
> +module_platform_driver(qcom_qps615_pwrctl_driver);
> +
> +MODULE_AUTHOR("Krishna chaitanya chundru <quic_krichai@quicinc.com>");
> +MODULE_DESCRIPTION("Qualcomm QPS615 power control driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.42.0
> 

-- 
With best wishes
Dmitry

