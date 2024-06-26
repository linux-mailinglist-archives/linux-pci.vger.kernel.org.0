Return-Path: <linux-pci+bounces-9325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EC191880F
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 19:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDA128204B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA1418FC69;
	Wed, 26 Jun 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKNJQJnu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68D18FC88;
	Wed, 26 Jun 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421206; cv=none; b=FZ/gecC1Ym/J0yKnHR8KfssV1k+PbusmrzP7ylm08c4mpUIF4c5bNKExsuE4QCa3S40vZtgfPSEYNtFCqAmoWthu2Ns39URVlhK9Yr0F+gv9j5Xx0fX3Ps+1YmU3+ZsN/VdFUUZpJSiFKsjBIuouU8o/CRTQHOc2+A6wunaAEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421206; c=relaxed/simple;
	bh=WpTe0hf7gWnjfqu601hqQmon4MS7ajFFVfXpaQTOLaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQaHyAREV0FUY8h04skEw+0QIbzmlHLjUji8h3B/vgIjKFYxrXld2ROMHZcIq8RHXj0i5rML+UAe0cfu9QOlWBRcyoQOloaOKyoGVxoXGS4YCV9Yt2wO9pTMpcMcsILf1w8Gbj1VvkRGxZN/l+cFAF7lKGyqPcUoSrgdODas57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKNJQJnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E87C116B1;
	Wed, 26 Jun 2024 17:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719421206;
	bh=WpTe0hf7gWnjfqu601hqQmon4MS7ajFFVfXpaQTOLaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKNJQJnuEc/aozaleJ/0QALDiME6eyMX/myZCijaXjqk0C0rzDdVi3JCyFq8eBshw
	 LS6M2fvV5zN7edrFOHoR8XIlIyXgThPurqZyNDTAVb8ObitllO8xCFB3eMtDZdZJoG
	 ESgbDHIR9Y2JhlujFab8cnGMldhYl4U7UYaiwf/j7mp2vaDSdC+Z5bmRu7N6GdU3uE
	 PoYpjTZXo4aaR9ndLPEndM0nnnTNzTOubefY38GieFbTk4mGrInSfUJDunmxP7gaSp
	 YHlcCc7QKgBFDwc/NlMVudSZHhS9nnlwI05X1rHA5us8x9YQ+r9CdhnI+Jppoklabd
	 BKpcVC8HReg9Q==
Date: Wed, 26 Jun 2024 12:00:00 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com, quic_skananth@quicinc.com, 
	quic_nitegupt@quicinc.com, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 7/7] pci: pwrctl: Add power control driver for qps615
Message-ID: <tpvecyxzqmtj2hbbtp4aofsxz5seslcs5wewbw3f3obgmtgx45@dkvra4pcb2tx>
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

"before PCIe link is brought up"?

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

So the firmware file contains calibration data only? How big is this,
should/could it be provided in driver with calibration settings from
DeviceTree?

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

Prefer this to be named e.g. device_addr

Or perhaps use "addr", "offset", and "value"?

> +	u32 reg_addr;
> +	u32 val;
> +};

This struct is typecast straight from the byte array provided by
request_firmware(), it would be preferable to use endian-specific data
types to highlight this: i.e. presumably __le32 as written today.

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

addr, offset, val?

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

Without qps615 being a child device of the adapter, does the kernel have
adequate information to know that the geni I2C driver needs to be
resumed before the qps615 driver, such that __i2c_transfer() will not
bail as __i2c_check_suspended() reports that the bus is still suspended?

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

__le32 rd_data;

msg[1].addr = &rd_data;
msg[1].len = sizeof(rd_data);

*value = le32_to_cpu(rd_data);

Or do I get that backwards?

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

Is this the generic qps615 firmware, applicable to all implementations
thereof, or does it contain device-specific calibration or such?

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

In the case the firmware is truncated by 1 - 11 bytes this would read
outside the buffer. Also, I presume this was the intended use for the
now unused "eof" variable.

> +		set = (struct qcom_qps615_pwrctl_i2c_setting *)pos;

I'd suggest that you treat fw->data as an array of struct
qcom_qps615_pwrctl_i2c_setting elements.

> +
> +		ret = qps615_switch_i2c_write(ctx, set->slv_addr, set->reg_addr, set->val);

Is it possible to avoid getting the i2c device address from the
firmware? Does/can this change?

> +		if (ret) {
> +			dev_err(dev,
> +				"I2c write failed for slv addr:%x at addr%x with val %x ret %d\n",

Would be nice to clean this up a bit, there are no non-i2c accesses from
this device, and the words "slv", "with", "val" has low SNR. Also %x
does not communicate the base for many values, use %#x to get the 0x
prefix.

Perhaps:
	"failed to write %#x to #x on %#x\n", set->val, set->reg_addr, set->slv_addr

> +				set->slv_addr, set->reg_addr, set->val, ret);
> +			goto err;
> +		}
> +
> +		ret = qps615_switch_i2c_read(ctx,  set->slv_addr, set->reg_addr, &val);
> +		if (ret) {
> +			dev_err(dev, "I2c read failed for slv addr:%x at addr%x ret %d\n",

"readback failed at %#x on %#x\n"

> +				set->slv_addr, set->reg_addr, ret);
> +			goto err;
> +		}
> +
> +		if (set->val != val) {
> +			dev_err(dev,
> +				"I2c read's mismatch for slv:%x at addr%x exp%d got%d\n",

"readback verification failed at %#x on %#x (%#x != %#x)\n"


If there's only a single slv_addr value, then please omit that from all
three error cases.

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

Is it vdd or vdda?

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

You don't care for the return value, so replace it with void.

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

Per of_get_i2c_adapter_by_node() kernel-doc:

"The user must call i2c_put_adapter(adapter) once done with the i2c
adapter."

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
> +
> +static const struct of_device_id qcom_qps615_pwrctl_of_match[] = {
> +	{
> +		.compatible = "pci1179,0623",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qcom_qps615_pwrctl_of_match);

This would fit better down by qcom_qps615_pwrctl_driver, instead of
mixed in among the implementation.

> +
> +static int pci_pwrctl_suspend_noirq(struct device *dev)
> +{
> +	struct pci_bus *bus = pci_find_bus(of_get_pci_domain_nr(dev->parent->of_node), 0);
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);

How about caching the bus and bridge in ctx?

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

Perhaps worth checking this return value? Although I guess there's not
much to do if it's non-zero...

Regards,
Bjorn

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

