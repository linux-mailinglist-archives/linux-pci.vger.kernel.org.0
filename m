Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537223A466D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 18:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFKQZv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 12:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhFKQZu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jun 2021 12:25:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38F9F60FE5;
        Fri, 11 Jun 2021 16:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623428632;
        bh=SGjTQQhL8OdK/29mwLlWVCm7plKf5S7XfT162AbkTUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+ByfgkkxROUlXsjGNX0x76TldQ9y9EAK+0Jakdczi1AxfwknmQEz9Yyk3WE7qZNm
         wymVCxZM+5lGa8WpBGBAbsQfS7MCP5jqhIelCdbVAGe/n1S82Y7CCTEq4hXkNP/vTp
         wjNq+rBMhk7w4bERcBr7V93h2BH1pcscVU/LjBt3ClcKF/KqFhJfm3w+cqItDKnyQ/
         Ct1lAxKu6e/XhXJHjPFUPE5gUEjf8l9t9o4sprg+4CUo9V1GbYPq2Ti/Oq8MXFXNca
         7VsLZ3EszWWi672mYmRe1YVzm8+G9bdugzdGm6LU8JesLYbC6LiQzgKoDYhA8R2Oka
         Oh/JuzsshPagw==
Date:   Fri, 11 Jun 2021 17:23:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     mark.rutland@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH v6 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
Message-ID: <20210611162347.GA16284@willie-the-truck>
References: <1622467951-32114-1-git-send-email-liuqi115@huawei.com>
 <1622467951-32114-3-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622467951-32114-3-git-send-email-liuqi115@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 31, 2021 at 09:32:31PM +0800, Qi Liu wrote:
> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
> to sample bandwidth, latency, buffer occupation etc.
> 
> Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
> registered as a PMU in /sys/bus/event_source/devices, so users can
> select target PMU, and use filter to do further sets.
> 
> Filtering options contains:
> event        - select the event.
> subevent     - select the subevent.
> port         - select target Root Ports. Information of Root Ports
>                are shown under sysfs.
> bdf          - select requester_id of target EP device.
> trig_len     - set trigger condition for starting event statistics.
> trigger_mode - set trigger mode. 0 means starting to statistic when
>                bigger than trigger condition, and 1 means smaller.
> thr_len      - set threshold for statistics.
> thr_mode     - set threshold mode. 0 means count when bigger than
>                threshold, and 1 means smaller.
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>  MAINTAINERS                                |    6 +
>  drivers/perf/Kconfig                       |    2 +
>  drivers/perf/Makefile                      |    1 +
>  drivers/perf/pci/Kconfig                   |   16 +
>  drivers/perf/pci/Makefile                  |    2 +
>  drivers/perf/pci/hisilicon/Makefile        |    3 +
>  drivers/perf/pci/hisilicon/hisi_pcie_pmu.c | 1019 ++++++++++++++++++++++++++++

Can we keep this under drivers/perf/hisilicon/ please? I don't see the
need to create a 'pci' directory here.

>  include/linux/cpuhotplug.h                 |    1 +
>  8 files changed, 1050 insertions(+)
>  create mode 100644 drivers/perf/pci/Kconfig
>  create mode 100644 drivers/perf/pci/Makefile
>  create mode 100644 drivers/perf/pci/hisilicon/Makefile
>  create mode 100644 drivers/perf/pci/hisilicon/hisi_pcie_pmu.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 81e1ede..dd5c62d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8233,6 +8233,12 @@ W:	http://www.hisilicon.com
>  F:	Documentation/admin-guide/perf/hisi-pmu.rst
>  F:	drivers/perf/hisilicon
>  
> +HISILICON PCIE PMU DRIVER
> +M:	Qi Liu <liuqi115@huawei.com>
> +S:	Maintained
> +F:	Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> +F:	drivers/perf/pci/hisilicon/hisi_pcie_pmu.c
> +
>  HISILICON QM AND ZIP Controller DRIVER
>  M:	Zhou Wang <wangzhou1@hisilicon.com>
>  L:	linux-crypto@vger.kernel.org
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 77522e5..ddd82fa 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -139,4 +139,6 @@ config ARM_DMC620_PMU
>  
>  source "drivers/perf/hisilicon/Kconfig"
>  
> +source "drivers/perf/pci/Kconfig"
> +
>  endmenu
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 5260b11..1208c08 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
>  obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>  obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
>  obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
> +obj-y += pci/
> diff --git a/drivers/perf/pci/Kconfig b/drivers/perf/pci/Kconfig
> new file mode 100644
> index 0000000..36b430f
> --- /dev/null
> +++ b/drivers/perf/pci/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# PCIe Performance Monitor Drivers
> +#
> +menu "PCIe Performance Monitor"
> +
> +config HISI_PCIE_PMU
> +	tristate "HiSilicon PCIE PERF PMU"
> +	depends on PCI && (ARM64 || COMPILE_TEST)
> +	help
> +	  Provide support for HiSilicon PCIe performance monitoring unit (PMU)
> +	  RCiEP devices.
> +	  Adds the PCIe PMU into perf events system for monitoring latency,
> +	  bandwidth etc.
> +
> +endmenu
> diff --git a/drivers/perf/pci/Makefile b/drivers/perf/pci/Makefile
> new file mode 100644
> index 0000000..a56b1a9
> --- /dev/null
> +++ b/drivers/perf/pci/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-y += hisilicon/
> diff --git a/drivers/perf/pci/hisilicon/Makefile b/drivers/perf/pci/hisilicon/Makefile
> new file mode 100644
> index 0000000..65b0bd7
> --- /dev/null
> +++ b/drivers/perf/pci/hisilicon/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_HISI_PCIE_PMU) += hisi_pcie_pmu.o
> diff --git a/drivers/perf/pci/hisilicon/hisi_pcie_pmu.c b/drivers/perf/pci/hisilicon/hisi_pcie_pmu.c
> new file mode 100644
> index 0000000..ed411dd
> --- /dev/null
> +++ b/drivers/perf/pci/hisilicon/hisi_pcie_pmu.c
> @@ -0,0 +1,1019 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * This driver adds support for PCIe PMU RCiEP device. Related
> + * perf events are bandwidth, bandwidth utilization, latency
> + * etc.
> + *
> + * Copyright (C) 2021 HiSilicon Limited
> + * Author: Qi Liu<liuqi115@huawei.com>
> + */
> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>
> +#include <linux/bug.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io-64-nonatomic-hi-lo.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/perf_event.h>
> +
> +#include <asm/div64.h>
> +
> +/* Define registers */
> +#define HISI_PCIE_GLOBAL_CTRL		0x00
> +#define HISI_PCIE_EVENT_CTRL		0x010
> +#define HISI_PCIE_CNT			0x090
> +#define HISI_PCIE_EXT_CNT		0x110
> +#define HISI_PCIE_INT_STAT		0x150
> +#define HISI_PCIE_INT_MASK		0x154
> +#define HISI_PCIE_REG_BDF		0xfe0
> +#define HISI_PCIE_REG_VERSION		0xfe4
> +#define HISI_PCIE_REG_INFO		0xfe8
> +#define HISI_PCIE_REG_FREQ		0xfec
> +
> +/* Define PCIE CTRL CMD */
> +#define HISI_PCIE_GLOBAL_EN		0x01
> +#define HISI_PCIE_GLOBAL_NONE		0
> +#define HISI_PCIE_EVENT_EN		BIT_ULL(20)
> +#define HISI_PCIE_RESET_CNT		BIT_ULL(22)
> +#define HISI_PCIE_DEFAULT_SET		BIT_ULL(34)
> +#define HISI_PCIE_THR_EN		BIT_ULL(26)
> +#define HISI_PCIE_TARGET_EN		BIT_ULL(32)
> +#define HISI_PCIE_TRIG_EN		BIT_ULL(52)
> +
> +/* Define offsets in event ctrl regesiter */
> +#define HISI_PCIE_EVENT_M		GENMASK_ULL(7, 0)
> +#define HISI_PCIE_SUBEVENT_M		GENMASK_ULL(15, 8)
> +#define HISI_PCIE_THR_MODE_M		GENMASK_ULL(27, 27)
> +#define HISI_PCIE_THR_M			GENMASK_ULL(31, 28)
> +#define HISI_PCIE_TARGET_M		GENMASK_ULL(52, 36)
> +#define HISI_PCIE_TRIG_MODE_M		GENMASK_ULL(53, 53)
> +#define HISI_PCIE_TRIG_M		GENMASK_ULL(59, 56)
> +
> +#define HISI_PCIE_MAX_COUNTERS		8
> +#define HISI_PCIE_REG_STEP		8
> +#define HISI_PCIE_EVENT_MAX		0xa2
> +#define HISI_PCIE_SUBEVENT_MAX		0x20
> +#define HISI_PCIE_THR_MAX_VAL		10
> +#define HISI_PCIE_TRIG_MAX_VAL		10
> +#define HISI_PCIE_COUNTER_BITS		64
> +#define HISI_PCIE_MAX_PERIOD		BIT_ULL(63)
> +
> +struct hisi_pcie_pmu {
> +	struct perf_event *hw_events[HISI_PCIE_MAX_COUNTERS];
> +	struct hlist_node node;
> +	struct pci_dev *pdev;
> +	struct pmu pmu;
> +	void __iomem *base;
> +	int irq;
> +	u32 identifier;
> +	/* Minimum and maximum bdf of root ports monitored by PMU */
> +	u16 bdf_min;
> +	u16 bdf_max;
> +	int on_cpu;
> +};
> +
> +#define to_pcie_pmu(p)  (container_of((p), struct hisi_pcie_pmu, pmu))
> +#define GET_PCI_DEVFN(bdf)  ((bdf) & 0xff)
> +
> +#define HISI_PCIE_PMU_FILTER_ATTR(_name, _config, _hi, _lo)		  \
> +	static u64 hisi_pcie_get_##_name(struct perf_event *event)	  \
> +	{								  \
> +		return FIELD_GET(GENMASK(_hi, _lo), event->attr._config); \
> +	}								  \
> +
> +HISI_PCIE_PMU_FILTER_ATTR(event, config, 7, 0);
> +HISI_PCIE_PMU_FILTER_ATTR(subevent, config, 15, 8);
> +HISI_PCIE_PMU_FILTER_ATTR(thr_len, config1, 3, 0);
> +HISI_PCIE_PMU_FILTER_ATTR(thr_mode, config1, 4, 4);
> +HISI_PCIE_PMU_FILTER_ATTR(trig_len, config1, 8, 5);
> +HISI_PCIE_PMU_FILTER_ATTR(trig_mode, config1, 9, 9);
> +HISI_PCIE_PMU_FILTER_ATTR(port, config2, 15, 0);
> +HISI_PCIE_PMU_FILTER_ATTR(bdf, config2, 31, 16);
> +
> +#define HISI_PCIE_BUILD_EVENTS(name)					\
> +	static bool is_##name##_event(u32 idx)				\
> +	{								\
> +		return (idx >= name##_events_list[0] &&			\
> +			idx <= name##_events_list[1]) ||		\
> +			idx == name##_events_list[2];			\
> +	}								\
> +
> +/*
> + * The first element of event list is minimum index of TL-layer events
> + * and the second element is maximum index. The third element is index
> + * of a DL-layer event.
> + */
> +static const u32 bw_events_list[] = {0x04, 0x08, 0x84};
> +static const u32 latency_events_list[] = {0x10, 0x15, 0x85};
> +static const u32 bus_util_events_list[] = {0x20, 0x24, 0x09};
> +static const u32 buf_util_events_list[] = {0x28, 0x2a, 0x33};
> +
> +HISI_PCIE_BUILD_EVENTS(bw);
> +HISI_PCIE_BUILD_EVENTS(latency);
> +HISI_PCIE_BUILD_EVENTS(bus_util);
> +HISI_PCIE_BUILD_EVENTS(buf_util);
> +
> +static ssize_t hisi_pcie_format_sysfs_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> +
> +	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
> +}
> +
> +static ssize_t hisi_pcie_event_sysfs_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> +
> +	return sysfs_emit(buf, "config=0x%lx\n", (unsigned long)eattr->var);
> +}
> +
> +#define HISI_PCIE_PMU_ATTR(_name, _func, _config)			\
> +	(&((struct dev_ext_attribute[]) {				\
> +		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }   \
> +	})[0].attr.attr)

If you rebase onto my patch queue, then you can use PMU_EVENT_ATTR_ID to
define this.

> +#define HISI_PCIE_PMU_FORMAT_ATTR(_name, _format)			\
> +	HISI_PCIE_PMU_ATTR(_name, hisi_pcie_format_sysfs_show, (void *)_format)
> +#define HISI_PCIE_PMU_EVENT_ATTR(_name, _event)			\
> +	HISI_PCIE_PMU_ATTR(_name, hisi_pcie_event_sysfs_show, (void *)_event)
> +
> +static ssize_t hisi_pcie_cpumask_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "%d\n", pcie_pmu->on_cpu);
> +}

This isn't a cpumask.

> +
> +static ssize_t hisi_pcie_identifier_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "0x%x\n", pcie_pmu->identifier);
> +}
> +
> +static ssize_t hisi_pcie_bus_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "0x%02x\n", PCI_BUS_NUM(pcie_pmu->bdf_min));
> +}
> +
> +static void hisi_pcie_parse_reg_value(struct hisi_pcie_pmu *pcie_pmu,
> +				      u32 reg_off, u16 *arg0, u16 *arg1)
> +{
> +	u32 val = readl(pcie_pmu->base + reg_off);
> +
> +	*arg0 = val & 0xffff;
> +	*arg1 = (val & 0xffff0000) >> 16;
> +}

Define a new type for the pair of values and return that directly?

> +
> +static u32 hisi_pcie_pmu_get_offset(u32 offset, u32 idx)
> +{
> +	return offset + HISI_PCIE_REG_STEP * idx;
> +}
> +
> +static u32 hisi_pcie_pmu_readl(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
> +			       u32 idx)
> +{
> +	u32 offset = hisi_pcie_pmu_get_offset(reg_offset, idx);
> +
> +	return readl(pcie_pmu->base + offset);
> +}
> +
> +static void hisi_pcie_pmu_writel(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
> +				 u32 idx, u32 val)
> +{
> +	u32 offset = hisi_pcie_pmu_get_offset(reg_offset, idx);
> +
> +	writel(val, pcie_pmu->base + offset);
> +}
> +
> +static u64 hisi_pcie_pmu_readq(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
> +			       u32 idx)
> +{
> +	u32 offset = hisi_pcie_pmu_get_offset(reg_offset, idx);
> +
> +	return readq(pcie_pmu->base + offset);
> +}
> +
> +static void hisi_pcie_pmu_writeq(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
> +				 u32 idx, u64 val)
> +{
> +	u32 offset = hisi_pcie_pmu_get_offset(reg_offset, idx);
> +
> +	writeq(val, pcie_pmu->base + offset);
> +}

I'm guessing most (all?) of these IO access can be _relaxed() ?

> +
> +static void hisi_pcie_pmu_config_filter(struct perf_event *event)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 reg = HISI_PCIE_DEFAULT_SET;
> +	u64 port, trig_len, thr_len;
> +	u32 idx = hwc->idx;
> +
> +	/* Config HISI_PCIE_EVENT_CTRL according to event and subevent. */
> +	reg |= FIELD_PREP(HISI_PCIE_EVENT_M, hisi_pcie_get_event(event)) |
> +	       FIELD_PREP(HISI_PCIE_SUBEVENT_M, hisi_pcie_get_subevent(event));
> +
> +	/* Config HISI_PCIE_EVENT_CTRL according to ROOT PORT or EP device. */
> +	port = hisi_pcie_get_port(event);
> +	if (port)
> +		reg |= FIELD_PREP(HISI_PCIE_TARGET_M, port);
> +	else
> +		reg |= HISI_PCIE_TARGET_EN |
> +		       FIELD_PREP(HISI_PCIE_TARGET_M, hisi_pcie_get_bdf(event));

Please use braces for multi-line conditional expressions (same elsewhere).

> +
> +	/* Config HISI_PCIE_EVENT_CTRL according to trigger condition. */
> +	trig_len = hisi_pcie_get_trig_len(event);
> +	if (trig_len)
> +		reg |= FIELD_PREP(HISI_PCIE_TRIG_M, trig_len) |
> +		       FIELD_PREP(HISI_PCIE_TRIG_MODE_M,
> +		       hisi_pcie_get_trig_mode(event)) | HISI_PCIE_TRIG_EN;

The formatting is very weird here.

> +
> +	/* Config HISI_PCIE_EVENT_CTRL according to threshold condition. */
> +	thr_len = hisi_pcie_get_thr_len(event);
> +	if (thr_len)
> +		reg |= FIELD_PREP(HISI_PCIE_THR_M, thr_len) |
> +		       FIELD_PREP(HISI_PCIE_THR_MODE_M,
> +		       hisi_pcie_get_thr_mode(event)) | HISI_PCIE_THR_EN;

and here.

> +
> +	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, idx, reg);
> +}
> +
> +static void hisi_pcie_pmu_clear_filter(struct perf_event *event)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, hwc->idx,
> +			     HISI_PCIE_DEFAULT_SET);
> +}
> +
> +static bool hisi_pcie_pmu_valid_port(struct hisi_pcie_pmu *pcie_pmu, u16 rp_bdf)
> +{
> +	return rp_bdf >= pcie_pmu->bdf_min && rp_bdf <= pcie_pmu->bdf_max;
> +}
> +
> +static bool hisi_pcie_pmu_valid_requester_id(struct hisi_pcie_pmu *pcie_pmu,
> +					    u32 bdf)
> +{
> +	struct pci_dev *root_port, *pdev;
> +
> +	pdev = pci_get_domain_bus_and_slot(pci_domain_nr(pcie_pmu->pdev->bus),
> +					   PCI_BUS_NUM(bdf),
> +					   GET_PCI_DEVFN(bdf));
> +	if (!pdev)
> +		return false;
> +
> +	root_port = pcie_find_root_port(pdev);
> +	if (!root_port)
> +		return false;
> +
> +	pci_dev_put(pdev);
> +	return hisi_pcie_pmu_valid_port(pcie_pmu, pci_dev_id(root_port));
> +}
> +
> +static bool hisi_pcie_pmu_valid_filter(struct perf_event *event,
> +				       struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	u32 subev_idx = hisi_pcie_get_subevent(event);
> +	u32 event_idx = hisi_pcie_get_event(event);
> +	u32 requester_id = hisi_pcie_get_bdf(event);
> +
> +	if (subev_idx > HISI_PCIE_SUBEVENT_MAX ||
> +	    event_idx > HISI_PCIE_EVENT_MAX) {
> +		pci_err(pcie_pmu->pdev,
> +			"Max event index and max subevent index is: %d, %d.\n",
> +			HISI_PCIE_EVENT_MAX, HISI_PCIE_SUBEVENT_MAX);
> +		return false;
> +	}
> +
> +	if (hisi_pcie_get_thr_len(event) > HISI_PCIE_THR_MAX_VAL)
> +		return false;
> +
> +	if (hisi_pcie_get_trig_len(event) > HISI_PCIE_TRIG_MAX_VAL)
> +		return false;
> +
> +	if (requester_id) {
> +		if (!hisi_pcie_pmu_valid_requester_id(pcie_pmu, requester_id))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool hisi_pcie_pmu_validate_event_group(struct perf_event *event)
> +{
> +	struct perf_event *sibling, *leader = event->group_leader;
> +	int counters = 1;
> +
> +	if (!is_software_event(leader)) {
> +		if (leader->pmu != event->pmu)
> +			return false;
> +
> +		if (leader != event)
> +			counters++;
> +	}
> +
> +	for_each_sibling_event(sibling, event->group_leader) {
> +		if (is_software_event(sibling))
> +			continue;
> +
> +		if (sibling->pmu != event->pmu)
> +			return false;
> +
> +		counters++;
> +	}
> +
> +	return counters <= HISI_PCIE_MAX_COUNTERS;
> +}
> +
> +static int hisi_pcie_pmu_event_init(struct perf_event *event)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +
> +	event->cpu = pcie_pmu->on_cpu;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/* Sampling is not supported. */
> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> +		return -EOPNOTSUPP;
> +
> +	if (!hisi_pcie_pmu_valid_filter(event, pcie_pmu)) {
> +		pci_err(pcie_pmu->pdev, "Invalid filter!\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!hisi_pcie_pmu_validate_event_group(event))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/*
> + * The bandwidth, latency, bus utilization and buffer occupancy features are
> + * calculated from data in HISI_PCIE_CNT and extended data in HISI_PCIE_EXT_CNT.
> + * Other features are obtained only by HISI_PCIE_CNT.
> + * So data and data_ext are processed in this function to get performanace
> + * value like, bandwidth, latency, etc.
> + */
> +static u64 hisi_pcie_pmu_get_performance(struct perf_event *event, u64 data,
> +					 u64 data_ext)
> +{
> +#define CONVERT_DW_TO_BYTE(x)	(sizeof(u32) * (x))

I don't know what a "DW" is, but this macro adds nothing...

> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	u64 us_per_cycle = readl(pcie_pmu->base + HISI_PCIE_REG_FREQ);
> +	u32 idx = hisi_pcie_get_event(event);
> +
> +	if (!data_ext)
> +		return 0;
> +
> +	/* Process data to set unit of bandwidth as "Byte/ms". */
> +	if (is_bw_event(idx)) {
> +
> +		if (!div64_u64(data_ext, 1000))
> +			return 0;
> +
> +		return div64_u64(CONVERT_DW_TO_BYTE(data),

... especially as this is the only use of it.


> +				 div64_u64(data_ext, 1000));
> +	}
> +
> +	/* Process data to set unit of latency as "us". */
> +	if (is_latency_event(idx))
> +		return div64_u64(data * us_per_cycle, data_ext);
> +
> +	if (is_bus_util_event(idx))
> +		return div64_u64(data * us_per_cycle, data_ext);
> +
> +	if (is_buf_util_event(idx))
> +		return div64_u64(data, data_ext * us_per_cycle);

Why do we need to do all this division in the kernel? Can't we just expose
the underlying values and let userspace figure out what it wants to do with
the numbers?

Will
