Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A5F3B5E0B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 14:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhF1Mfk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 08:35:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232598AbhF1Mfk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 08:35:40 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SC9uV9029345;
        Mon, 28 Jun 2021 08:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=b08bEri/RLgUoHUb4t4zLTmyCvaQ4iSW4lR5gEQwKEU=;
 b=iM+Odehh+55FfYq6EtclbNuWgXhkS+ovL2mdeMLydHD8KB0jXtvWYcOs3aUYw+TXWzoJ
 dFCVyHIDenoVCwZRJJBd8+jNtKhLeI8/C3P+hl56Oz/+Y66BIFtkhj42HIuqIihNrNec
 rvsVfuKTBYc5uI6Jdqd3sF3p8Rs5OYqfiiGfzhPm7bD3S29/v92YvpNWTqGw+w/P8e7y
 C+fSaT/F/KHG0XyyFSae1h58EJLSqkF0bKQh7em3TOuY+ZczUu15wyOtN7DOToIQafmZ
 aGnCjcWBQZsIk2EvMl7qBpMRJJ0+z4qo/IigoJy7MPuAshC9e/Mnetvmev/Gsj+KjVO0 bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fcmwb3cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 08:31:57 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15SCBD3S038128;
        Mon, 28 Jun 2021 08:31:55 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fcmwb3c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 08:31:55 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SCVCO3002971;
        Mon, 28 Jun 2021 12:31:53 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 39duvb7139-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 12:31:52 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SCUmcG17957210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 12:30:48 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67FE5112C8E;
        Mon, 28 Jun 2021 12:03:12 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73789112C39;
        Mon, 28 Jun 2021 12:03:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.42.117])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 12:03:09 +0000 (GMT)
Subject: Re: [PATCH v7 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     Qi Liu <liuqi115@huawei.com>, will@kernel.org,
        mark.rutland@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhangshaokun@hisilicon.com
References: <1624532384-43002-1-git-send-email-liuqi115@huawei.com>
 <1624532384-43002-3-git-send-email-liuqi115@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <88c32b01-ba6c-0b8a-c9eb-3cdf54a2d659@linux.ibm.com>
Date:   Mon, 28 Jun 2021 17:33:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <1624532384-43002-3-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VxPupJRDYRboSSoHLJ4cv4-XG4KV-xYE
X-Proofpoint-GUID: mXhR27PpAmVo3vwh6W3IFw6dLpHXe8rH
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_09:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 clxscore=1011 phishscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106280085
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/24/21 4:29 PM, Qi Liu wrote:
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
>  MAINTAINERS                            |   2 +
>  drivers/perf/hisilicon/Kconfig         |   9 +
>  drivers/perf/hisilicon/Makefile        |   2 +
>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 967 +++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h             |   1 +
>  5 files changed, 981 insertions(+)
>  create mode 100644 drivers/perf/hisilicon/hisi_pcie_pmu.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 81e1ede..8639c1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8228,8 +8228,10 @@ F:	Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
>  
>  HISILICON PMU DRIVER
>  M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
> +M:	Qi Liu <liuqi115@huawei.com>
>  S:	Supported
>  W:	http://www.hisilicon.com
> +F:	Documentation/admin-guide/perf/hisi-pcie-pmu.rst
>  F:	Documentation/admin-guide/perf/hisi-pmu.rst
>  F:	drivers/perf/hisilicon
>  
> diff --git a/drivers/perf/hisilicon/Kconfig b/drivers/perf/hisilicon/Kconfig
> index c5d1b701..5546218 100644
> --- a/drivers/perf/hisilicon/Kconfig
> +++ b/drivers/perf/hisilicon/Kconfig
> @@ -5,3 +5,12 @@ config HISI_PMU
>  	  help
>  	  Support for HiSilicon SoC L3 Cache performance monitor, Hydra Home
>  	  Agent performance monitor and DDR Controller performance monitor.
> +
> +config HISI_PCIE_PMU
> +	tristate "HiSilicon PCIE PERF PMU"
> +	depends on PCI && ARM64
> +	help
> +	  Provide support for HiSilicon PCIe performance monitoring unit (PMU)
> +	  RCiEP devices.
> +	  Adds the PCIe PMU into perf events system for monitoring latency,
> +	  bandwidth etc.
> diff --git a/drivers/perf/hisilicon/Makefile b/drivers/perf/hisilicon/Makefile
> index 7643c9f..506ed39 100644
> --- a/drivers/perf/hisilicon/Makefile
> +++ b/drivers/perf/hisilicon/Makefile
> @@ -2,3 +2,5 @@
>  obj-$(CONFIG_HISI_PMU) += hisi_uncore_pmu.o hisi_uncore_l3c_pmu.o \
>  			  hisi_uncore_hha_pmu.o hisi_uncore_ddrc_pmu.o hisi_uncore_sllc_pmu.o \
>  			  hisi_uncore_pa_pmu.o
> +
> +obj-$(CONFIG_HISI_PCIE_PMU) += hisi_pcie_pmu.o
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> new file mode 100644
> index 0000000..50994e5
> --- /dev/null
> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> @@ -0,0 +1,967 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * This driver adds support for PCIe PMU RCiEP device. Related
> + * perf events are bandwidth, bandwidth utilization, latency
> + * etc.
> + *
> + * Copyright (C) 2021 HiSilicon Limited
> + * Author: Qi Liu <liuqi115@huawei.com>
> + */
> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>
> +#include <linux/bug.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/cpumask.h>

Hi Qi liu,
   I think we can skip adding headerfile cpumask.h and cpuhotplug.h here, as it
get included via perf_event.h

> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/perf_event.h>
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
> +#define HISI_PCIE_MAX_PERIOD		(GENMASK_ULL(63, 0))
> +#define HISI_PCIE_DEFAULT_VALUE		BIT_ULL(63)
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
> +struct hisi_pcie_reg_pair {
> +	u16 lo;
> +	u16 hi;
> +};
> +
> +#define to_pcie_pmu(p)  (container_of((p), struct hisi_pcie_pmu, pmu))
> +#define GET_PCI_DEVFN(bdf)  ((bdf) & 0xff)
> +#define EXT_COUNTER_IS_USED(idx)		((idx) & GENMASK(15, 8))
> +
> +#define HISI_PCIE_PMU_FILTER_ATTR(_name, _config, _hi, _lo)		  \
> +	static u64 hisi_pcie_get_##_name(struct perf_event *event)	  \
> +	{								  \
> +		return FIELD_GET(GENMASK(_hi, _lo), event->attr._config); \
> +	}								  \
> +
> +HISI_PCIE_PMU_FILTER_ATTR(event, config, 15, 0);
> +HISI_PCIE_PMU_FILTER_ATTR(subevent, config, 23, 16);
> +HISI_PCIE_PMU_FILTER_ATTR(thr_len, config1, 3, 0);
> +HISI_PCIE_PMU_FILTER_ATTR(thr_mode, config1, 4, 4);
> +HISI_PCIE_PMU_FILTER_ATTR(trig_len, config1, 8, 5);
> +HISI_PCIE_PMU_FILTER_ATTR(trig_mode, config1, 9, 9);
> +HISI_PCIE_PMU_FILTER_ATTR(port, config2, 15, 0);
> +HISI_PCIE_PMU_FILTER_ATTR(bdf, config2, 31, 16);
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
> +	struct perf_pmu_events_attr *pmu_attr =
> +		container_of(attr, struct perf_pmu_events_attr, attr);
> +
> +	return sysfs_emit(buf, "config=0x%llx\n", pmu_attr->id);
> +}
> +
> +#define HISI_PCIE_PMU_FORMAT_ATTR(_name, _format)                              \
> +	(&((struct dev_ext_attribute[]){                                       \
> +		{ .attr = __ATTR(_name, 0444, hisi_pcie_format_sysfs_show,     \
> +				 NULL),                                        \
> +		  .var = (void *)_format }                                     \
> +	})[0].attr.attr)
> +
> +#define HISI_PCIE_PMU_EVENT_ATTR(_name, _id)			\
> +	PMU_EVENT_ATTR_ID(_name, hisi_pcie_event_sysfs_show, _id)
> +
> +static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pcie_pmu->on_cpu));
> +}
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static ssize_t identifier_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "%#x\n", pcie_pmu->identifier);
> +}
> +static DEVICE_ATTR_RO(identifier);
> +
> +static ssize_t bus_show(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "%#04x\n", PCI_BUS_NUM(pcie_pmu->bdf_min));
> +}
> +static DEVICE_ATTR_RO(bus);
> +
> +static struct hisi_pcie_reg_pair
> +hisi_pcie_parse_reg_value(struct hisi_pcie_pmu *pcie_pmu, u32 reg_off)
> +{
> +	u32 val = readl_relaxed(pcie_pmu->base + reg_off);
> +	struct hisi_pcie_reg_pair regs = {
> +		.lo = val,
> +		.hi = val >> 16,
> +	};
> +
> +	return regs;
> +}
> +
> +/*
> + * Hardware counter and ext_counter work together for bandwidth, latency,
> + * bus utilization and buffer occupancy events. For example, for latency
> + * events(idx = 0x10), counter counts total delay cycles and ext_counter
> + * counts PCIe packets number.
> + *
> + * As we don't want PMU driver to process these two data, "delay cycles"
> + * can be treated as an event(id = 0x10), "packets number" as another event
> + * (id = 0x10 << 8), and driver could export these data separately. So in
> + * this function, the "real" event idx is get to set HISI_PCIE_EVENT_CTRL.
> + */
> +static u32 hisi_pcie_pmu_get_real_idx(struct perf_event *event)
> +{
> +	u32 event_idx = hisi_pcie_get_event(event);
> +
> +	if (!EXT_COUNTER_IS_USED(event_idx))
> +		return event_idx;
> +
> +	return FIELD_GET(GENMASK(15, 8), event_idx);
> +}
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
> +	return readl_relaxed(pcie_pmu->base + offset);
> +}
> +
> +static void hisi_pcie_pmu_writel(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
> +				 u32 idx, u32 val)
> +{
> +	u32 offset = hisi_pcie_pmu_get_offset(reg_offset, idx);
> +
> +	writel_relaxed(val, pcie_pmu->base + offset);
> +}
> +
> +static u64 hisi_pcie_pmu_readq(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
> +			       u32 idx)
> +{
> +	u32 offset = hisi_pcie_pmu_get_offset(reg_offset, idx);
> +
> +	return readq_relaxed(pcie_pmu->base + offset);
> +}
> +
> +static void hisi_pcie_pmu_writeq(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
> +				 u32 idx, u64 val)
> +{
> +	u32 offset = hisi_pcie_pmu_get_offset(reg_offset, idx);
> +
> +	writeq_relaxed(val, pcie_pmu->base + offset);
> +}
> +
> +static void hisi_pcie_pmu_config_filter(struct perf_event *event)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	u32 event_idx = hisi_pcie_pmu_get_real_idx(event);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 reg = HISI_PCIE_DEFAULT_SET;
> +	u64 port, trig_len, thr_len;
> +	u32 idx = hwc->idx;
> +
> +	/* Config HISI_PCIE_EVENT_CTRL according to event and subevent. */
> +	reg |= FIELD_PREP(HISI_PCIE_EVENT_M, event_idx) |
> +	       FIELD_PREP(HISI_PCIE_SUBEVENT_M, hisi_pcie_get_subevent(event));
> +
> +	/* Config HISI_PCIE_EVENT_CTRL according to ROOT PORT or EP device. */
> +	port = hisi_pcie_get_port(event);
> +	if (port)
> +		reg |= FIELD_PREP(HISI_PCIE_TARGET_M, port);
> +	else
> +		reg |= HISI_PCIE_TARGET_EN |
> +		       FIELD_PREP(HISI_PCIE_TARGET_M, hisi_pcie_get_bdf(event));
> +
> +	/* Config HISI_PCIE_EVENT_CTRL according to trigger condition. */
> +	trig_len = hisi_pcie_get_trig_len(event);
> +	if (trig_len) {
> +		reg |= FIELD_PREP(HISI_PCIE_TRIG_M, trig_len);
> +		reg |= FIELD_PREP(HISI_PCIE_TRIG_MODE_M,
> +				  hisi_pcie_get_trig_mode(event));
> +		reg |= HISI_PCIE_TRIG_EN;
> +	}
> +
> +	/* Config HISI_PCIE_EVENT_CTRL according to threshold condition. */
> +	thr_len = hisi_pcie_get_thr_len(event);
> +	if (thr_len) {
> +		reg |= FIELD_PREP(HISI_PCIE_THR_M, thr_len);
> +		reg |= FIELD_PREP(HISI_PCIE_THR_MODE_M,
> +		       hisi_pcie_get_thr_mode(event));
> +		reg |= HISI_PCIE_THR_EN;
> +	}
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
> +					     u32 bdf)
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
> +	u32 event_idx = hisi_pcie_pmu_get_real_idx(event);
> +	u32 subev_idx = hisi_pcie_get_subevent(event);
> +	u32 requester_id = hisi_pcie_get_bdf(event);
> +
> +	if (subev_idx > HISI_PCIE_SUBEVENT_MAX ||
> +	    event_idx > HISI_PCIE_EVENT_MAX)
> +		return false;
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
> +static u64 hisi_pcie_pmu_read_counter(struct perf_event *event)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	u32 event_idx = hisi_pcie_get_event(event);
> +	u32 idx = event->hw.idx;
> +
> +	if (EXT_COUNTER_IS_USED(event_idx))
> +		return hisi_pcie_pmu_readq(pcie_pmu, HISI_PCIE_EXT_CNT, idx);
> +
> +	return hisi_pcie_pmu_readq(pcie_pmu, HISI_PCIE_CNT, idx);
> +}
> +
> +static void hisi_pcie_pmu_write_counter(struct perf_event *event, u64 val)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	u32 event_idx = hisi_pcie_get_event(event);
> +	u32 idx = event->hw.idx;
> +
> +	if (EXT_COUNTER_IS_USED(event_idx))
> +		hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EXT_CNT, idx, val);
> +	else
> +		hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_CNT, idx, val);
> +}
> +
> +static int hisi_pcie_pmu_get_event_idx(struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	int idx;
> +
> +	for (idx = 0; idx < HISI_PCIE_MAX_COUNTERS; idx++) {
> +		if (!pcie_pmu->hw_events[idx])
> +			return idx;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void hisi_pcie_pmu_event_update(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 new_cnt, prev_cnt, delta;
> +
> +	do {
> +		prev_cnt = local64_read(&hwc->prev_count);
> +		new_cnt = hisi_pcie_pmu_read_counter(event);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev_cnt,
> +				 new_cnt) != prev_cnt);
> +
> +	delta = (new_cnt - prev_cnt) & HISI_PCIE_MAX_PERIOD;
> +	local64_add(delta, &event->count);
> +}
> +
> +static void hisi_pcie_pmu_read(struct perf_event *event)
> +{
> +	hisi_pcie_pmu_event_update(event);
> +}
> +
> +static void hisi_pcie_pmu_set_period(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	local64_set(&hwc->prev_count, HISI_PCIE_DEFAULT_VALUE);
> +	hisi_pcie_pmu_write_counter(event, HISI_PCIE_DEFAULT_VALUE);
> +}
> +
> +static void hisi_pcie_pmu_enable_counter(struct hisi_pcie_pmu *pcie_pmu,
> +					 struct hw_perf_event *hwc)
> +{
> +	u32 idx = hwc->idx;
> +	u64 val;
> +
> +	val = hisi_pcie_pmu_readq(pcie_pmu, HISI_PCIE_EVENT_CTRL, idx);
> +	val |= HISI_PCIE_EVENT_EN;
> +	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, idx, val);
> +}
> +
> +static void hisi_pcie_pmu_disable_counter(struct hisi_pcie_pmu *pcie_pmu,
> +					  struct hw_perf_event *hwc)
> +{
> +	u32 idx = hwc->idx;
> +	u64 val;
> +
> +	val = hisi_pcie_pmu_readq(pcie_pmu, HISI_PCIE_EVENT_CTRL, idx);
> +	val &= ~HISI_PCIE_EVENT_EN;
> +	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, idx, val);
> +}
> +
> +static void hisi_pcie_pmu_enable_int(struct hisi_pcie_pmu *pcie_pmu,
> +				     struct hw_perf_event *hwc)
> +{
> +	u32 idx = hwc->idx;
> +
> +	hisi_pcie_pmu_writel(pcie_pmu, HISI_PCIE_INT_MASK, idx, 0);
> +}
> +
> +static void hisi_pcie_pmu_disable_int(struct hisi_pcie_pmu *pcie_pmu,
> +				      struct hw_perf_event *hwc)
> +{
> +	u32 idx = hwc->idx;
> +
> +	hisi_pcie_pmu_writel(pcie_pmu, HISI_PCIE_INT_MASK, idx, 1);
> +}
> +
> +static void hisi_pcie_pmu_reset_counter(struct hisi_pcie_pmu *pcie_pmu,
> +					struct hw_perf_event *hwc)
> +{
> +	u32 idx = hwc->idx;
> +
> +	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, idx,
> +			     HISI_PCIE_RESET_CNT);
> +	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, idx,
> +			     HISI_PCIE_DEFAULT_SET);
> +}
> +
> +static void hisi_pcie_pmu_start(struct perf_event *event, int flags)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 prev_cnt;
> +
> +	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
> +		return;
> +
> +	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
> +	hwc->state = 0;
> +
> +	hisi_pcie_pmu_config_filter(event);
> +	hisi_pcie_pmu_enable_counter(pcie_pmu, hwc);
> +	hisi_pcie_pmu_enable_int(pcie_pmu, hwc);
> +	hisi_pcie_pmu_set_period(event);
> +
> +	if (flags & PERF_EF_RELOAD) {
> +		prev_cnt = local64_read(&hwc->prev_count);
> +		hisi_pcie_pmu_write_counter(event, prev_cnt);
> +	}
> +
> +	perf_event_update_userpage(event);
> +}
> +
> +static void hisi_pcie_pmu_stop(struct perf_event *event, int flags)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	hisi_pcie_pmu_event_update(event);
> +	hisi_pcie_pmu_disable_int(pcie_pmu, hwc);
> +	hisi_pcie_pmu_disable_counter(pcie_pmu, hwc);
> +	hisi_pcie_pmu_clear_filter(event);
> +	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
> +	hwc->state |= PERF_HES_STOPPED;
> +
> +	if (hwc->state & PERF_HES_UPTODATE)
> +		return;
> +
> +	hwc->state |= PERF_HES_UPTODATE;
> +}
> +
> +static int hisi_pcie_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +	idx = hisi_pcie_pmu_get_event_idx(pcie_pmu);
> +	if (idx < 0)
> +		return idx;
> +
> +	hwc->idx = idx;
> +	pcie_pmu->hw_events[idx] = event;
> +
> +	/* Reset Counter to avoid interference caused by previous statistic. */
> +	hisi_pcie_pmu_reset_counter(pcie_pmu, hwc);
> +
> +	if (flags & PERF_EF_START)
> +		hisi_pcie_pmu_start(event, PERF_EF_RELOAD);
> +
> +	return 0;
> +}
> +
> +static void hisi_pcie_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	hisi_pcie_pmu_stop(event, PERF_EF_UPDATE);
> +	pcie_pmu->hw_events[hwc->idx] = NULL;
> +	perf_event_update_userpage(event);
> +}
> +
> +static void hisi_pcie_pmu_enable(struct pmu *pmu)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(pmu);
> +	int num;
> +
> +	for (num = 0; num < HISI_PCIE_MAX_COUNTERS; num++) {
> +		if (pcie_pmu->hw_events[num])
> +			break;
> +	}
> +
> +	if (num == HISI_PCIE_MAX_COUNTERS)
> +		return;
> +
> +	writel(HISI_PCIE_GLOBAL_EN, pcie_pmu->base + HISI_PCIE_GLOBAL_CTRL);
> +}
> +
> +static void hisi_pcie_pmu_disable(struct pmu *pmu)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(pmu);
> +
> +	writel(HISI_PCIE_GLOBAL_NONE, pcie_pmu->base + HISI_PCIE_GLOBAL_CTRL);
> +}
> +
> +static irqreturn_t hisi_pcie_pmu_irq(int irq, void *data)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = data;
> +	irqreturn_t ret = IRQ_NONE;
> +	struct perf_event *event;
> +	u32 overflown;
> +	int idx;
> +
> +	for (idx = 0; idx < HISI_PCIE_MAX_COUNTERS; idx++) {
> +		overflown = hisi_pcie_pmu_readl(pcie_pmu, HISI_PCIE_INT_STAT,
> +						idx);
> +		if (!overflown)
> +			continue;
> +
> +		/* Clear status of interrupt. */
> +		hisi_pcie_pmu_writel(pcie_pmu, HISI_PCIE_INT_STAT, idx, 1);
> +		event = pcie_pmu->hw_events[idx];
> +		if (!event)
> +			continue;
> +
> +		hisi_pcie_pmu_event_update(event);
> +		hisi_pcie_pmu_set_period(event);
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	return ret;
> +}
> +
> +static int hisi_pcie_pmu_irq_register(struct pci_dev *pdev,
> +				      struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	int irq, ret;
> +
> +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
> +	if (ret < 0) {
> +		pci_err(pdev, "Failed to enable MSI vectors: %d!\n", ret);
> +		return ret;
> +	}
> +
> +	irq = pci_irq_vector(pdev, 0);
> +	ret = request_irq(irq, hisi_pcie_pmu_irq,
> +			  IRQF_NOBALANCING | IRQF_NO_THREAD, "hisi_pcie_pmu",
> +			  pcie_pmu);
> +	if (ret) {
> +		pci_err(pdev, "Failed to register IRQ: %d!\n", ret);
> +		pci_free_irq_vectors(pdev);
> +		return ret;
> +	}
> +
> +	pcie_pmu->irq = irq;
> +
> +	return 0;
> +}
> +
> +static void hisi_pcie_pmu_irq_unregister(struct pci_dev *pdev,
> +					 struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	free_irq(pcie_pmu->irq, pcie_pmu);
> +	pci_free_irq_vectors(pdev);
> +}
> +
> +static int hisi_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node,
> +					 struct hisi_pcie_pmu, node);
> +
> +	if (pcie_pmu->on_cpu == -1) {
> +		pcie_pmu->on_cpu = cpu;
> +		WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(cpu)));
> +	}
> +
> +	return 0;
> +}
> +
> +static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node,
> +					 struct hisi_pcie_pmu, node);
> +	unsigned int target;
> +
> +	/* Nothing to do if this CPU doesn't own the PMU */
> +	if (pcie_pmu->on_cpu != cpu)
> +		return 0;
> +
> +	/* Choose a new CPU from all online cpus. */
> +	target = cpumask_first(cpu_online_mask);
> +	if (target >= nr_cpu_ids) {
> +		pci_err(pcie_pmu->pdev, "There is no CPU to set!\n");
> +		return 0;
> +	}
> +

Incase target >= nr_cpu_ids, pcie_pmu->on_cpu will still point to
cpu which is offlining. We should also update pcie_pmu->on_cpu to -1 incase
we didn't get valid cpu number?

> +	perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
> +	/* Use this CPU for event counting */
> +	pcie_pmu->on_cpu = target;
> +	WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(target)));
> +
> +	return 0;
> +}
> +
> +/*
> + * Events with the "dl" suffix in their names count performance in DL layer,
> + * otherswise, events count performance in TL layer.
> + */
> +static struct attribute *hisi_pcie_pmu_events_attr[] = {
> +	HISI_PCIE_PMU_EVENT_ATTR(bw_rx_mwr, 0x010004),
> +	HISI_PCIE_PMU_EVENT_ATTR(bw_rx_mrd, 0x100005),
> +	HISI_PCIE_PMU_EVENT_ATTR(bw_tx_mwr, 0x010005),
> +	HISI_PCIE_PMU_EVENT_ATTR(bw_tx_mrd, 0x200004),
> +	HISI_PCIE_PMU_EVENT_ATTR(lat_rx_mwr, 0x000010),
> +	HISI_PCIE_PMU_EVENT_ATTR(lat_rx_mrd, 0x020010),
> +	HISI_PCIE_PMU_EVENT_ATTR(lat_tx_mrd, 0x000011),
> +	HISI_PCIE_PMU_EVENT_ATTR(bw_rx_dl, 0x010084),
> +	HISI_PCIE_PMU_EVENT_ATTR(bw_tx_dl, 0x030084),
> +	NULL
> +};
> +
> +static struct attribute_group hisi_pcie_pmu_events_group = {
> +	.name = "events",
> +	.attrs = hisi_pcie_pmu_events_attr,
> +};
> +
> +static struct attribute *hisi_pcie_pmu_format_attr[] = {
> +	HISI_PCIE_PMU_FORMAT_ATTR(event, "config:0-15"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(subevent, "config:16-23"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(thr_len, "config1:0-3"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(thr_mode, "config1:4"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(trig_len, "config1:5-8"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(trig_mode, "config1:9"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(port, "config2:0-15"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(bdf, "config2:16-31"),
> +	NULL
> +};

Just for my understanding, why we are not using config bits 24-63

> +
> +static const struct attribute_group hisi_pcie_pmu_format_group = {
> +	.name = "format",
> +	.attrs = hisi_pcie_pmu_format_attr,
> +};
> +
> +static struct attribute *hisi_pcie_pmu_bus_attrs[] = {
> +	&dev_attr_bus.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group hisi_pcie_pmu_bus_attr_group = {
> +	.attrs = hisi_pcie_pmu_bus_attrs,
> +};
> +
> +static struct attribute *hisi_pcie_pmu_cpumask_attrs[] = {
> +	&dev_attr_cpumask.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group hisi_pcie_pmu_cpumask_attr_group = {
> +	.attrs = hisi_pcie_pmu_cpumask_attrs,
> +};
> +
> +static struct attribute *hisi_pcie_pmu_identifier_attrs[] = {
> +	&dev_attr_identifier.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group hisi_pcie_pmu_identifier_attr_group = {
> +	.attrs = hisi_pcie_pmu_identifier_attrs,
> +};
> +
> +static const struct attribute_group *hisi_pcie_pmu_attr_groups[] = {
> +	&hisi_pcie_pmu_events_group,
> +	&hisi_pcie_pmu_format_group,
> +	&hisi_pcie_pmu_bus_attr_group,
> +	&hisi_pcie_pmu_cpumask_attr_group,
> +	&hisi_pcie_pmu_identifier_attr_group,
> +	NULL
> +};
> +
> +static int hisi_pcie_alloc_pmu(struct pci_dev *pdev,
> +			       struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	struct hisi_pcie_reg_pair regs;
> +	u16 sicl_id, device_id;
> +	char *name;
> +
> +	regs = hisi_pcie_parse_reg_value(pcie_pmu, HISI_PCIE_REG_BDF);
> +	pcie_pmu->bdf_min = regs.lo;
> +	pcie_pmu->bdf_max = regs.hi;
> +
> +	regs = hisi_pcie_parse_reg_value(pcie_pmu, HISI_PCIE_REG_INFO);
> +	sicl_id = regs.hi;
> +	device_id = regs.lo;
> +
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +			      "hisi_pcie%u_%u", sicl_id, device_id);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	pcie_pmu->pdev = pdev;
> +	pcie_pmu->on_cpu = -1;
> +	pcie_pmu->identifier = readl(pcie_pmu->base + HISI_PCIE_REG_VERSION);
> +	pcie_pmu->pmu = (struct pmu) {
> +		.name		= name,
> +		.module		= THIS_MODULE,
> +		.event_init	= hisi_pcie_pmu_event_init,
> +		.pmu_enable	= hisi_pcie_pmu_enable,
> +		.pmu_disable	= hisi_pcie_pmu_disable,
> +		.add		= hisi_pcie_pmu_add,
> +		.del		= hisi_pcie_pmu_del,
> +		.start		= hisi_pcie_pmu_start,
> +		.stop		= hisi_pcie_pmu_stop,
> +		.read		= hisi_pcie_pmu_read,
> +		.task_ctx_nr	= perf_invalid_context,
> +		.attr_groups	= hisi_pcie_pmu_attr_groups,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +	};
> +
> +	return 0;
> +}
> +
> +static int hisi_pcie_init_pmu(struct pci_dev *pdev,
> +			      struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	int ret;
> +
> +	pcie_pmu->base = pci_ioremap_bar(pdev, 2);
> +	if (!pcie_pmu->base) {
> +		pci_err(pdev, "Ioremap failed for pcie_pmu resource.\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = hisi_pcie_alloc_pmu(pdev, pcie_pmu);
> +	if (ret)
> +		return ret;
> +
> +	ret = hisi_pcie_pmu_irq_register(pdev, pcie_pmu);
> +	if (ret)
> +		goto err_set_pmu_fail;
> +
> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
> +				       &pcie_pmu->node);
> +	if (ret) {
> +		pci_err(pdev, "Failed to register hotplug: %d.\n", ret);
> +		goto err_irq_unregister;
> +	}
> +
> +	ret = perf_pmu_register(&pcie_pmu->pmu, pcie_pmu->pmu.name, -1);
> +	if (ret) {
> +		pci_err(pdev, "Failed to register PCIe PMU: %d.\n", ret);
> +		goto err_hotplug_unregister;
> +	}
> +
> +	return ret;
> +
> +err_hotplug_unregister:
> +	cpuhp_state_remove_instance_nocalls(
> +		CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE, &pcie_pmu->node);
> +
> +err_irq_unregister:
> +	hisi_pcie_pmu_irq_unregister(pdev, pcie_pmu);
> +
> +err_set_pmu_fail:
> +	iounmap(pcie_pmu->base);
> +
> +	return ret;
> +}
> +
> +static void hisi_pcie_uninit_pmu(struct pci_dev *pdev)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = pci_get_drvdata(pdev);
> +
> +	perf_pmu_unregister(&pcie_pmu->pmu);
> +	cpuhp_state_remove_instance_nocalls(
> +		CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE, &pcie_pmu->node);
> +	hisi_pcie_pmu_irq_unregister(pdev, pcie_pmu);
> +	iounmap(pcie_pmu->base);
> +}
> +
> +static int hisi_pcie_init_dev(struct pci_dev *pdev)
> +{
> +	int ret;
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret) {
> +		pci_err(pdev, "Failed to enable PCI device: %d.\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pci_request_mem_regions(pdev, "hisi_pcie_pmu");
> +	if (ret < 0) {
> +		pci_err(pdev, "Failed to request PCI mem regions: %d.\n", ret);
> +		pci_disable_device(pdev);
> +		return ret;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	return 0;
> +}
> +
> +static void hisi_pcie_uninit_dev(struct pci_dev *pdev)
> +{
> +	pci_clear_master(pdev);
> +	pci_release_mem_regions(pdev);
> +	pci_disable_device(pdev);
> +}
> +
> +static int hisi_pcie_pmu_probe(struct pci_dev *pdev,
> +			       const struct pci_device_id *id)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu;
> +	int ret;
> +
> +	pcie_pmu = devm_kzalloc(&pdev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
> +	if (!pcie_pmu)
> +		return -ENOMEM;
> +
> +	ret = hisi_pcie_init_dev(pdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = hisi_pcie_init_pmu(pdev, pcie_pmu);
> +	if (ret)
> +		hisi_pcie_uninit_dev(pdev);
> +
> +	pci_set_drvdata(pdev, pcie_pmu);
> +
> +	return ret;
> +}
> +
> +static void hisi_pcie_pmu_remove(struct pci_dev *pdev)
> +{
> +	hisi_pcie_uninit_pmu(pdev);
> +	hisi_pcie_uninit_dev(pdev);
> +	pci_set_drvdata(pdev, NULL);
> +}
> +
> +static const struct pci_device_id hisi_pcie_pmu_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, 0xa12d) },
> +	{ 0, }
> +};
> +MODULE_DEVICE_TABLE(pci, hisi_pcie_pmu_ids);
> +
> +static struct pci_driver hisi_pcie_pmu_driver = {
> +	.name = "hisi_pcie_pmu",
> +	.id_table = hisi_pcie_pmu_ids,
> +	.probe = hisi_pcie_pmu_probe,
> +	.remove = hisi_pcie_pmu_remove,
> +};
> +
> +static int __init hisi_pcie_module_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
> +				      "AP_PERF_ARM_HISI_PCIE_PMU_ONLINE",
> +				      hisi_pcie_pmu_online_cpu,
> +				      hisi_pcie_pmu_offline_cpu);
> +	if (ret) {
> +		pr_err("Failed to setup PCIe PMU hotplug, ret = %d.\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pci_register_driver(&hisi_pcie_pmu_driver);
> +	if (ret)
> +		cpuhp_remove_multi_state(
> +				CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE);
> +
> +	return ret;
> +}
> +module_init(hisi_pcie_module_init);
> +
> +static void __exit hisi_pcie_module_exit(void)
> +{
> +	pci_unregister_driver(&hisi_pcie_pmu_driver);
> +	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE);
> +}
> +module_exit(hisi_pcie_module_exit);
> +
> +MODULE_DESCRIPTION("HiSilicon PCIe PMU driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 4a62b39..a9776a2 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -180,6 +180,7 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
>  	CPUHP_AP_PERF_ARM_HISI_PA_ONLINE,
>  	CPUHP_AP_PERF_ARM_HISI_SLLC_ONLINE,
> +	CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
>  	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
>  	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
>  	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
> 
