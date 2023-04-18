Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C53C6E6FED
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 01:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjDRXbM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 19:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDRXbL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 19:31:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0891472A9;
        Tue, 18 Apr 2023 16:31:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 496101424;
        Tue, 18 Apr 2023 16:31:50 -0700 (PDT)
Received: from [10.57.82.12] (unknown [10.57.82.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 584A03F587;
        Tue, 18 Apr 2023 16:31:04 -0700 (PDT)
Message-ID: <b1d9509c-8e8c-b05b-cbaf-576a7b2f99e7@arm.com>
Date:   Wed, 19 Apr 2023 00:30:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/3] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-GB
To:     Shuai Xue <xueshuai@linux.alibaba.com>, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
 <20230417061729.84422-3-xueshuai@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230417061729.84422-3-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-04-17 07:17, Shuai Xue wrote:
> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> Core controller IP which provides statistics feature. The PMU is not a PCIe
> Root Complex integrated End Point(RCiEP) device but only register counters
> provided by each PCIe Root Port.
> 
> To facilitate collection of statistics the controller provides the
> following two features for each Root Port:
> 
> - Time Based Analysis (RX/TX data throughput and time spent in each
>    low-power LTSSM state)
> - Event counters (Error and Non-Error for lanes)
> 
> Note, only one counter for each type and does not overflow interrupt.
> 
> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
> named based the BDF of Root Port. For example,
> 
>      30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
> 
> the PMU device name for this Root Port is dwc_rootport_3018.
> 
> Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
> 
>      $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
> 
> average RX bandwidth can be calculated like this:
> 
>      PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>   drivers/perf/Kconfig        |   7 +
>   drivers/perf/Makefile       |   1 +
>   drivers/perf/dwc_pcie_pmu.c | 855 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 863 insertions(+)
>   create mode 100644 drivers/perf/dwc_pcie_pmu.c
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 66c259000a44..57bce3880cba 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -199,6 +199,13 @@ config MARVELL_CN10K_DDR_PMU
>   	  Enable perf support for Marvell DDR Performance monitoring
>   	  event on CN10K platform.
>   
> +config DWC_PCIE_PMU
> +	tristate "Enable Synopsys DesignWare PCIe PMU Support"
> +	depends on ARM64 || (COMPILE_TEST && 64BIT)

Is there anything here that really depends on 64BIT? Nothing obvious 
stands out.

> +	help
> +	  Enable perf support for Synopsys DesignWare PCIe PMU Performance
> +	  monitoring event on Yitian 710 platform.
> +
>   source "drivers/perf/arm_cspmu/Kconfig"
>   
>   source "drivers/perf/amlogic/Kconfig"
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 13e45da61100..3f233e96524e 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -21,5 +21,6 @@ obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
>   obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
>   obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
>   obj-$(CONFIG_ALIBABA_UNCORE_DRW_PMU) += alibaba_uncore_drw_pmu.o
> +obj-$(CONFIG_DWC_PCIE_PMU) += dwc_pcie_pmu.o
>   obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
>   obj-$(CONFIG_MESON_DDR_PMU) += amlogic/
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> new file mode 100644
> index 000000000000..b7691cfe0df4
> --- /dev/null
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -0,0 +1,855 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synopsys DesignWare PCIe PMU driver
> + *
> + * Copyright (C) 2021-2023 Alibaba Inc.
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/smp.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#define PCI_VENDOR_ID_ALIBABA 0x1ded

Shouldn't that belong in linux/pci_ids.h?

> +
> +#define ATTRI_NAME_MAX_SIZE			32
> +#define DWC_PCIE_VSEC_RAS_DES_ID		0x02
> +
> +#define DWC_PCIE_EVENT_CNT_CTL			0x8
> +#define DWC_PCIE_CNT_EVENT_SEL			GENMASK(27, 16)
> +#define DWC_PCIE_CNT_LANE_SEL			GENMASK(11, 8)
> +#define DWC_PCIE_CNT_STATUS			BIT(7)
> +#define DWC_PCIE_CNT_ENABLE			GENMASK(4, 2)
> +#define DWC_PCIE_PER_EVENT_OFF			FIELD_PREP(DWC_PCIE_CNT_ENABLE, 0x1)
> +#define DWC_PCIE_PER_EVENT_ON			FIELD_PREP(DWC_PCIE_CNT_ENABLE, 0x3)

Those two don't look right... :/

> +#define DWC_PCIE_EVENT_CLEAR			GENMASK(1, 0)
> +#define DWC_PCIE_EVENT_PER_CLEAR		0x1
> +
> +#define DWC_PCIE_EVENT_CNT_DATA			0xC
> +
> +#define DWC_PCIE_TIME_BASED_ANAL_CTL		0x10
> +#define DWC_PCIE_TIME_BASED_REPORT_SEL		GENMASK(31, 24)
> +#define DWC_PCIE_TIME_BASED_DURATION_SEL	GENMASK(15, 8)
> +#define DWC_PCIE_DURATION_MANUAL_CTL		0x0
> +#define DWC_PCIE_DURATION_1MS			0x1
> +#define DWC_PCIE_DURATION_10MS			0x2
> +#define DWC_PCIE_DURATION_100MS			0x3
> +#define DWC_PCIE_DURATION_1S			0x4
> +#define DWC_PCIE_DURATION_2S			0x5
> +#define DWC_PCIE_DURATION_4S			0x6
> +#define DWC_PCIE_DURATION_4US			0xff
> +#define DWC_PCIE_TIME_BASED_TIMER_START 	BIT(0)
> +#define DWC_PCIE_TIME_BASED_CNT_ENABLE		0x1
> +
> +#define DWC_PCIE_TIME_BASED_ANAL_DATA_REG_LOW	0x14
> +#define DWC_PCIE_TIME_BASED_ANAL_DATA_REG_HIGH	0x18
> +
> +/* Event attributes */
> +#define DWC_PCIE_CONFIG_EVENTID			GENMASK(15, 0)
> +#define DWC_PCIE_CONFIG_TYPE			GENMASK(19, 16)
> +#define DWC_PCIE_CONFIG_LANE			GENMASK(27, 20)
> +
> +#define DWC_PCIE_EVENT_ID(event)	FIELD_GET(DWC_PCIE_CONFIG_EVENTID, (event)->attr.config)
> +#define DWC_PCIE_EVENT_TYPE(event)	FIELD_GET(DWC_PCIE_CONFIG_TYPE, (event)->attr.config)
> +#define DWC_PCIE_EVENT_LANE(event)	FIELD_GET(DWC_PCIE_CONFIG_LANE, (event)->attr.config)
> +
> +enum dwc_pcie_event_type {
> +	DWC_PCIE_TYPE_INVALID,
> +	DWC_PCIE_TIME_BASE_EVENT,
> +	DWC_PCIE_LANE_EVENT,
> +};
> +
> +struct dwc_event_counters {
> +	const char name[32];
> +	u32 event_id;
> +};
> +
> +struct dwc_pcie_pmu {
> +	struct hlist_node node;

This isn't used anywhere (but it should be).

> +	unsigned int on_cpu;
> +	struct pmu pmu;
> +	struct device *dev;
> +};
> +
> +struct dwc_pcie_rp_info {
> +	u32 bdf;
> +	u32 ras_des;
> +	u32 num_lanes;
> +
> +	struct list_head rp_node;
> +	struct pci_dev *pdev;
> +	struct dwc_pcie_pmu pcie_pmu;
> +	bool pmu_is_register;
> +	struct perf_event *event;
> +
> +	struct dwc_pcie_event_attr *lane_event_attrs;
> +	struct attribute **pcie_pmu_event_attrs;
> +	struct attribute_group pcie_pmu_event_attrs_group;
> +	const struct attribute_group *pcie_pmu_attr_groups[4];
> +};

Is there any particular reason for the seemingly arbitrary split between 
dwc_pcie_pmu and dwc_pcie_rp_info? It doesn't appear obvious from the 
design of the code; if anything it mostly just seems to make things a 
bit more busy than they need to be.

> +
> +struct dwc_pcie_pmu_priv {
> +	struct device *dev;
> +	u32 pcie_ctrl_num;
> +	struct list_head rp_infos;
> +};
> +
> +#define to_dwc_pcie_pmu(p) (container_of(p, struct dwc_pcie_pmu, pmu))
> +
> +static struct platform_device *dwc_pcie_pmu_dev;
> +static ssize_t cpumask_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(dev_get_drvdata(dev));
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pcie_pmu->on_cpu));
> +}
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static struct attribute *dwc_pcie_pmu_cpumask_attrs[] = {
> +	&dev_attr_cpumask.attr,
> +	NULL
> +};
> +
> +static struct attribute_group pcie_pmu_cpumask_attrs_group = {
> +	.attrs = dwc_pcie_pmu_cpumask_attrs,
> +};
> +
> +struct dwc_pcie_format_attr {
> +	struct device_attribute attr;
> +	u64 field;
> +	int config;
> +};
> +
> +static ssize_t dwc_pcie_pmu_format_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct dwc_pcie_format_attr *fmt = container_of(attr, typeof(*fmt), attr);
> +	int lo = __ffs(fmt->field), hi = __fls(fmt->field);
> +
> +	if (lo == hi)
> +		return snprintf(buf, PAGE_SIZE, "config:%d\n", lo);
> +
> +	if (!fmt->config)
> +		return snprintf(buf, PAGE_SIZE, "config:%d-%d\n", lo, hi);
> +
> +	return snprintf(buf, PAGE_SIZE, "config%d:%d-%d\n", fmt->config, lo,
> +			hi);

A lot of this is unnecessary - you don't have any single-bit config 
fields, and you aren't using config1 or config2, so it's kind of 
confusing to have all the code and data for handling them.

Also, please use sysfs_emit() instead of all the assorted sprintf() and 
snprintf() calls.

> +}
> +
> +#define _dwc_pcie_format_attr(_name, _cfg, _fld)				\
> +	(&((struct dwc_pcie_format_attr[]) {{				\
> +		.attr = __ATTR(_name, 0444, dwc_pcie_pmu_format_show, NULL),	\
> +		.config = _cfg,						\
> +		.field = _fld,						\
> +	}})[0].attr.attr)
> +
> +#define dwc_pcie_format_attr(_name, _fld)	_dwc_pcie_format_attr(_name, 0, _fld)
> +
> +static struct attribute *dwc_pcie_format_attrs[] = {
> +	dwc_pcie_format_attr(type, DWC_PCIE_CONFIG_TYPE),
> +	dwc_pcie_format_attr(eventid, DWC_PCIE_CONFIG_EVENTID),
> +	dwc_pcie_format_attr(lane, DWC_PCIE_CONFIG_LANE),
> +	NULL,
> +};
> +
> +static struct attribute_group pcie_pmu_format_attrs_group = {
> +	.name = "format",
> +	.attrs = dwc_pcie_format_attrs,
> +};
> +
> +struct dwc_pcie_event_attr {
> +	struct device_attribute attr;
> +	enum dwc_pcie_event_type type;
> +	u16 eventid;
> +	u8 lane;
> +};
> +
> +static ssize_t dwc_pcie_event_show(struct device *dev,
> +				struct device_attribute *attr, char *page)
> +{
> +	struct dwc_pcie_event_attr *eattr;
> +
> +	eattr = container_of(attr, typeof(*eattr), attr);
> +
> +	if (eattr->type == DWC_PCIE_LANE_EVENT)
> +		return sprintf(page, "eventid=0x%lx, type=0x%lx, lane=0x%lx\n",

Convention seems to be that these strings do not have spaces in them, so 
there's a small chance that it may confuse some userspace tools.

> +			       (unsigned long)eattr->eventid,
> +			       (unsigned long)eattr->type,
> +			       (unsigned long)eattr->lane);

Hmm, why use %lx and then have to cast everything, rather than just %x?

> +
> +	return sprintf(page, "eventid=0x%lx, type=0x%lx",
> +		       (unsigned long)eattr->eventid,
> +		       (unsigned long)eattr->type);
> +}
> +
> +#define DWC_PCIE_EVENT_ATTR(_name, _type, _eventid, _lane)		\
> +	(&((struct dwc_pcie_event_attr[]) {{				\
> +		.attr = __ATTR(_name, 0444, dwc_pcie_event_show, NULL),	\
> +		.type = _type,						\
> +		.eventid = _eventid,					\
> +		.lane = _lane,					\
> +	}})[0].attr.attr)
> +
> +#define DWC_PCIE_PMU_BASE_TIME_ATTR(_name, _eventid)			\
> +	DWC_PCIE_EVENT_ATTR(_name, DWC_PCIE_TIME_BASE_EVENT, _eventid, 0)
> +
> +static struct attribute *dwc_pcie_pmu_time_event_attrs[] = {
> +	/* Group #0 */
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(one_cycle, 0x00),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(TX_L0S, 0x01),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(RX_L0S, 0x02),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(L0, 0x03),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(L1, 0x04),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(L1_1, 0x05),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(L1_2, 0x06),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(CFG_RCVRY, 0x07),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(TX_RX_L0S, 0x08),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(L1_AUX, 0x09),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(ONE_cycle, 0x10),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(TX_L0S_, 0x11),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(RX_L0S_, 0x12),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(L0_, 0x13),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(L1_, 0x17),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(CFG_RCVRY_, 0x17),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(TX_RX_L0S_, 0x18),
> +	/* Group #1 */
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(Tx_PCIe_TLP_Data_Payload, 0x20),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(Rx_PCIe_TLP_Data_Payload, 0x21),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(Tx_CCIX_TLP_Data_Payload, 0x22),
> +	DWC_PCIE_PMU_BASE_TIME_ATTR(Rx_CCIX_TLP_Data_Payload, 0x23),
> +	NULL
> +};
> +
> +static inline umode_t pcie_pmu_event_attr_is_visible(struct kobject *kobj,
> +						     struct attribute *attr,
> +						     int unuse)
> +{
> +	return attr->mode;

There is no point implementing an optional callback which only 
replicates the default behaviour of not having the callback.

Whether to simply remove it, or instead implement more meaningful 
behaviour here to save complexity elsewhere, is something I'll come back 
to later...

> +}
> +
> +static inline bool pci_dev_is_rootport(struct pci_dev *pdev)
> +{
> +	return (pci_is_pcie(pdev) &&
> +		pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT);
> +}
> +
> +static int dwc_pcie_ras_des_discover(struct dwc_pcie_pmu_priv *priv)
> +{
> +	int index = 0;
> +	struct pci_dev *pdev = NULL;
> +	struct dwc_pcie_rp_info *rp_info;
> +
> +	INIT_LIST_HEAD(&priv->rp_infos);
> +
> +	/* Match the rootport with VSEC_RAS_DES_ID */
> +	for_each_pci_dev(pdev) {

Does the PCI layer not offer a more robust mechanism for this? (PCI 
fixups come to mind, but I don't actually know whether that would be a 
viable approach or not.) As things stand, it seems like you've got a 
potential ordering problem if this is built-in and runs before PCI 
devices have been fully discovered.

> +		u16 vsec;
> +		u32 val;
> +
> +		if (!pci_dev_is_rootport(pdev))
> +			continue;
> +
> +		rp_info = devm_kzalloc(&pdev->dev, sizeof(*rp_info), GFP_KERNEL);
> +		if (!rp_info)
> +			return -ENOMEM;

This leaks a refcount on the device.

> +
> +		rp_info->bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);

Do you really need to store this? It could just as well be a local 
variable in the one scope where it's used later.

> +		rp_info->pdev = pdev;
> +
> +		vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
> +						DWC_PCIE_VSEC_RAS_DES_ID);
> +		if (!vsec)
> +			continue;
> +
> +		pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +		if (PCI_VNDR_HEADER_REV(val) != 0x04 ||
> +		    PCI_VNDR_HEADER_LEN(val) != 0x100)
> +			continue;
> +		pci_dbg(pdev,
> +			"Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
> +

Could you not finish all the checks before allocating rp_info? I'm 
guessing you probably don't expect to find a mix of root ports where 
only some have this capability, but if that ever did happen it would be 
nicer not to leave a bunch of wasted memory hanging around for the 
lifetime of the driver.

> +		rp_info->ras_des = vsec;
> +		rp_info->num_lanes = pcie_get_width_cap(pdev);
> +
> +		list_add(&rp_info->rp_node, &priv->rp_infos);
> +		index++;
> +	}
> +
> +	if (!index)
> +		return -ENODEV;
> +
> +	priv->pcie_ctrl_num = index;

You never use this.

> +
> +	return 0;
> +}
> +
> +static void dwc_pcie_pmu_set_event_id(struct pci_dev *pdev, u16 ras_des,
> +				     int event_id)
> +{
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, &val);
> +
> +	val |= FIELD_PREP(DWC_PCIE_CNT_EVENT_SEL, event_id);
> +
> +	pci_write_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, val);
> +}
> +
> +static void dwc_pcie_pmu_write_event_lane(struct pci_dev *pdev, u16 ras_des,
> +					 int lane, int event_id)
> +{
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, &val);
> +
> +	val |= FIELD_PREP(DWC_PCIE_CNT_EVENT_SEL, lane);
> +
> +	pci_write_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, val);
> +}

What's the purpose of these two functions doing the exact same thing, 
but one having an extra unused argument?

> +
> +static void dwc_pcie_pmu_event_enable(struct pci_dev *pdev, u16 ras_des,
> +				     u32 enable)

Pass Boolean arguments as bool.

> +{
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, &val);
> +
> +	if (enable)
> +		val |= FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_ON);
> +	else
> +		val |= FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_OFF);

This looks suspicious - even if the values were defined correctly, the 
read-modify-write implies that a transition from enabled to disabled 
would result in ON | OFF == ON, which doesn't appear to make much sense.

> +
> +	pci_write_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, val);
> +}
> +
> +static void dwc_pcie_pmu_base_time_enable(struct pci_dev *pdev, u16 ras_des,
> +					 u32 enable)

bool again.

> +{
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_CTL,
> +			      &val);
> +
> +	if (enable)
> +		val |= DWC_PCIE_TIME_BASED_CNT_ENABLE;
> +	else
> +		val &= ~DWC_PCIE_TIME_BASED_CNT_ENABLE;
> +
> +	pci_write_config_dword(pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_CTL,
> +			       val);
> +}
> +
> +static void dwc_pcie_pmu_read_event_counter(struct pci_dev *pdev, u16 ras_des,
> +					    u64 *counter)
> +{
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_DATA, &val);
> +	*counter = val;

Why not just return a u64 by value?

> +}
> +
> +/* The results are cleared when next measurement starts. */
> +static void dwc_pcie_pmu_read_base_time_counter(struct pci_dev *pdev,
> +						u16 ras_des, u64 *counter)
> +{
> +	u32 val;
> +
> +	pci_read_config_dword(
> +		pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_DATA_REG_HIGH,
> +		&val);
> +	*counter = val;
> +	*counter <<= 32;
> +
> +	pci_read_config_dword(
> +		pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_DATA_REG_LOW,
> +		&val);
> +
> +	*counter += val;

Ditto.

> +}
> +
> +static void dwc_pcie_pmu_clear_event_counter(struct pci_dev *pdev, u16 ras_des)
> +{
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, &val);
> +
> +	val |= FIELD_PREP(DWC_PCIE_EVENT_CLEAR, DWC_PCIE_EVENT_PER_CLEAR);

OK, does this EVENT_CNT_CTL register just have some really weird 
behaviour where the fields we touch are self-clearing but other bits 
still have to be preserved when written?

> +
> +	pci_write_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, val);
> +}
> +
> +static void dwc_pcie_pmu_base_time_add_prepare(struct pci_dev *pdev,
> +					       u16 ras_des, u32 event_id)
> +{
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_CTL,
> +			      &val);
> +
> +	val |= FIELD_PREP(DWC_PCIE_TIME_BASED_REPORT_SEL, event_id);

Ditto for this one, in fact.

> +
> +	/*
> +	 * TIME_BASED_ANAL_DATA_REG is a 64 bit register, we can safely
> +	 * use it with any manually controlled duration.
> +	 */
> +	val |= FIELD_PREP(DWC_PCIE_TIME_BASED_DURATION_SEL,
> +			  DWC_PCIE_DURATION_MANUAL_CTL);
> +
> +	pci_write_config_dword(pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_CTL,
> +			       val);
> +}
> +
> +static struct dwc_pcie_rp_info *pmu_to_pcie_info(struct pmu *pmu)
> +{
> +	struct dwc_pcie_rp_info *rp_info;
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(pmu);
> +
> +	rp_info = container_of(pcie_pmu, struct dwc_pcie_rp_info, pcie_pmu);
> +
> +	return rp_info;
> +}
> +
> +static void dwc_pcie_pmu_event_update(struct perf_event *event)
> +{
> +	u64 counter;
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> +	struct dwc_pcie_rp_info *rp_info = pmu_to_pcie_info(event->pmu);
> +	struct pci_dev *pdev = rp_info->pdev;
> +	u16 ras_des = rp_info->ras_des;
> +	struct hw_perf_event *hwc = &event->hw;
> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
> +	u64 delta, prev, now;

That's an awful lot of boilerplate - straight away, pcie_pmu is 
redundant since &pdev->dev would give you the same thing, but then you 
don't actually need that anyway, so it would be even cleaner to pass 
rp_info directly to the read_*_counter helpers for them to dereference 
pdev and ras_des for themselves. Same thing in the start, stop and add 
callbacks below.

> +
> +	do {
> +		prev = local64_read(&hwc->prev_count);
> +
> +		if (type == DWC_PCIE_LANE_EVENT)
> +			dwc_pcie_pmu_read_event_counter(pdev, ras_des, &counter);
> +		else if (type == DWC_PCIE_TIME_BASE_EVENT)
> +			dwc_pcie_pmu_read_base_time_counter(pdev, ras_des,
> +							    &counter);
> +		else
> +			dev_err(pcie_pmu->dev, "invalid event type: 0x%x\n", type);

If that could ever happen, you've got a bug in your event_init or 
event_add, or something has corrupted memory in a way you cannot 
possibly attempt to reason about. In fact, pretending to handle such a 
theoretical bug here is its own *real* bug, since if that path is taken 
then it leads to consuming an uninitialised variable below.

> +
> +		now = counter;

Get rid of the redundant "counter" variable. It's really not helpful.

> +	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
> +
> +	delta = now - prev;
> +
> +	local64_add(delta, &event->count);
> +}
> +
> +static int dwc_pcie_pmu_event_init(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> +	struct perf_event *sibling;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (hwc->sample_period) {

This confused me - it might work, but please use is_sampling_event() to 
be consistent with everything else.

> +		dev_err(pcie_pmu->dev, "Sampling not supported\n");

dev_dbg() at best, but TBH I'd just remove it. I know this has been 
debated a lot, but FWIW I'm firmly in the "giving users the capability 
to use to use perf events should not give them the implicit capability 
to flood the kernel log and fill up journald's disk quota" camp.

> +		return -EOPNOTSUPP;

Use EINVAL. It's not that you simply don't support sampling, it's that 
there is fundamentally no meaningful context in a PCIe lane to sample 
from, so it is not a valid event at all.

> +	}
> +
> +	if (event->cpu < 0) {
> +		dev_err(pcie_pmu->dev, "Per-task mode not supported\n");
> +		return -EOPNOTSUPP;

Same comments as above.

> +	}
> +
> +	event->cpu = pcie_pmu->on_cpu;

It would seem neater not to start modifying the event until after you've 
finished validating it.

> +
> +	if (event->group_leader != event &&
> +	    !is_software_event(event->group_leader))
> +		return -EINVAL;
> +
> +	for_each_sibling_event(sibling, event->group_leader) {
> +		if (sibling != event && !is_software_event(sibling))

An event cannot possibly be its own sibling.

> +			return -EINVAL;
> +	}
> +
> +	hwc->idx = -1;

You never use this.

> +
> +	return 0;

This would be the point to check that the event's config actually makes 
sense and is supported by this PMU.

> +}
> +
> +static void dwc_pcie_pmu_set_period(struct hw_perf_event *hwc)
> +{
> +	local64_set(&hwc->prev_count, 0);
> +}
> +
> +static void dwc_pcie_pmu_event_start(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> +	struct dwc_pcie_rp_info *rp_info = pmu_to_pcie_info(event->pmu);
> +	struct pci_dev *pdev = rp_info->pdev;
> +	u16 ras_des = rp_info->ras_des;
> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
> +
> +	hwc->state = 0;
> +	dwc_pcie_pmu_set_period(hwc);
> +
> +	if (type == DWC_PCIE_LANE_EVENT)
> +		dwc_pcie_pmu_event_enable(pdev, ras_des, 1);
> +	else if (type == DWC_PCIE_TIME_BASE_EVENT)
> +		dwc_pcie_pmu_base_time_enable(pdev, ras_des, 1);
> +	else
> +		dev_err(pcie_pmu->dev, "invalid event type: 0x%x\n", type);

Again, that should be impossible if you validated it correctly in 
event_init.

> +}
> +
> +static void dwc_pcie_pmu_event_stop(struct perf_event *event, int flags)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> +	struct dwc_pcie_rp_info *rp_info = pmu_to_pcie_info(event->pmu);
> +	struct pci_dev *pdev = rp_info->pdev;
> +	u16 ras_des = rp_info->ras_des;
> +
> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
> +
> +	if (event->hw.state & PERF_HES_STOPPED)
> +		return;
> +
> +	if (type == DWC_PCIE_LANE_EVENT)
> +		dwc_pcie_pmu_event_enable(pdev, ras_des, 0);
> +	else if (type == DWC_PCIE_TIME_BASE_EVENT)
> +		dwc_pcie_pmu_base_time_enable(pdev, ras_des, 0);
> +	else
> +		dev_err(pcie_pmu->dev, "invalid event type: 0x%x\n", type);

Ditto.

> +
> +	dwc_pcie_pmu_event_update(event);
> +}
> +
> +static int dwc_pcie_pmu_event_add(struct perf_event *event, int flags)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> +	struct dwc_pcie_rp_info *rp_info = pmu_to_pcie_info(event->pmu);
> +	struct pci_dev *pdev = rp_info->pdev;
> +	u16 ras_des = rp_info->ras_des;
> +	struct hw_perf_event *hwc = &event->hw;
> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
> +	int event_id = DWC_PCIE_EVENT_ID(event);
> +	int lane = DWC_PCIE_EVENT_LANE(event);
> +
> +	/* Only one counter and it is in use */
> +	if (rp_info->event)
> +		return -ENOSPC;

Out of curiosity, is this a technical limitation, or just a case of 
keeping the initial driver simple? The registers seem to imply that lane 
events and time events are pretty much independent of each other, so 
maybe it might be possible for one of each to coexist.

> +
> +	rp_info->event = event;
> +
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	if (type == DWC_PCIE_LANE_EVENT) {
> +		dwc_pcie_pmu_event_enable(pdev, ras_des, 0);
> +		dwc_pcie_pmu_write_event_lane(pdev, ras_des, lane, event_id);
> +		dwc_pcie_pmu_set_event_id(pdev, ras_des, event_id);
> +		dwc_pcie_pmu_clear_event_counter(pdev, ras_des);

Eww, the helpers were already confusing enough, but is it necessary to 
do *four* back-to-back RMW operations on the same register? Can you 
really not just write the whole thing in one go?

> +	} else if (type == DWC_PCIE_TIME_BASE_EVENT) {
> +		dwc_pcie_pmu_base_time_enable(pdev, ras_des, 0);
> +		dwc_pcie_pmu_base_time_add_prepare(pdev, ras_des, event_id);
> +	} else {
> +		dev_err(pcie_pmu->dev, "invalid event type: 0x%x\n", type);
> +		return -EINVAL;
> +	}
> +
> +	if (flags & PERF_EF_START)
> +		dwc_pcie_pmu_event_start(event, PERF_EF_RELOAD);
> +
> +	perf_event_update_userpage(event);
> +
> +	return 0;
> +}
> +
> +static void dwc_pcie_pmu_event_del(struct perf_event *event, int flags)
> +{
> +	struct dwc_pcie_rp_info *rp_info = pmu_to_pcie_info(event->pmu);
> +
> +	dwc_pcie_pmu_event_stop(event, flags | PERF_EF_UPDATE);
> +	perf_event_update_userpage(event);
> +	rp_info->event = NULL;
> +}
> +
> +static void dwc_pcie_pmu_event_read(struct perf_event *event)
> +{
> +	dwc_pcie_pmu_event_update(event);
> +}

What use is a function wrapper that does nothing but call a function 
with an identical signature? Whatever would call this can just call 
dwc_pcie_pmu_event_update() directly.

> +
> +static struct dwc_event_counters event_array[] = {
> +	{"tx_ack_dllp", 0x600},
> +	{"tx_update_fc_dllp", 0x601},
> +	{"rx_ack_dllp", 0x602},
> +	{"rx_update_fc_dllp", 0x603},
> +	{"rx_nulified_tlp", 0x604},
> +	{"tx_nulified_tlp", 0x605},
> +	{"rx_duplicate_tlp", 0x606},
> +	{"tx_memory_write", 0x700},
> +	{"tx_memory_read", 0x701},
> +	{"tx_configuration_write", 0x702},
> +	{"tx_configuration_read", 0x703},
> +	{"tx_io_write", 0x704},
> +	{"tx_io_read", 0x705},
> +	{"tx_completion_without_data", 0x706},
> +	{"tx_completion_with_data", 0x707},
> +	{"tx_message_tlp", 0x708},
> +	{"tx_atomic", 0x709},
> +	{"tx_tlp_with_prefix", 0x70A},
> +	{"rx_memory_write", 0x70B},
> +	{"rx_memory_read", 0x70C},
> +	{"rx_io_write", 0x70F},
> +	{"rx_io_read", 0x710},
> +	{"rx_completion_without_data", 0x711},
> +	{"rx_completion_with_data", 0x712},
> +	{"rx_message_tlp", 0x713},
> +	{"rx_atomic", 0x714},
> +	{"rx_tlp_with_prefix", 0x715},
> +	{"tx_ccix_tlp", 0x716},
> +	{"rx_ccix_tlp", 0x717},
> +};
> +
> +static int dwc_pcie_pmu_attr_init(struct dwc_pcie_pmu_priv *priv,
> +				  struct dwc_pcie_rp_info *rp_info)
> +{
> +	int i, j;
> +	char lane[8];
> +	const char tmp[64];
> +	int events_per_lane;
> +	int num_lane_events;
> +	int time_base_count;
> +	int num_attrs, attr_idx;
> +	struct dwc_pcie_event_attr *lane_attrs;
> +	struct attribute **pmu_attrs;
> +
> +	memset((void *)tmp, 0, sizeof(tmp));
> +	memset((void *)lane, 0, sizeof(lane));
> +	time_base_count = ARRAY_SIZE(dwc_pcie_pmu_time_event_attrs);
> +	events_per_lane = ARRAY_SIZE(event_array);
> +	num_lane_events = rp_info->num_lanes * events_per_lane;
> +	num_attrs = time_base_count + num_lane_events;
> +
> +	rp_info->lane_event_attrs =
> +		devm_kcalloc(priv->dev, num_lane_events,
> +				sizeof(struct dwc_pcie_event_attr),
> +				GFP_KERNEL);
> +	if (!rp_info->lane_event_attrs)
> +		return -ENOMEM;
> +	lane_attrs = rp_info->lane_event_attrs;
> +	rp_info->pcie_pmu_event_attrs =
> +		devm_kcalloc(priv->dev, num_attrs, sizeof(struct attribute *),
> +			 GFP_KERNEL);
> +	if (!rp_info->pcie_pmu_event_attrs)
> +		return -ENOMEM;
> +	pmu_attrs = rp_info->pcie_pmu_event_attrs;
> +
> +	for (i = 0; i < num_lane_events; i++) {
> +		lane_attrs[i].attr.attr.name =
> +		    devm_kzalloc(priv->dev, sizeof(char)
> +				 * ATTRI_NAME_MAX_SIZE, GFP_KERNEL);
> +		if (!lane_attrs[i].attr.attr.name)
> +			return -ENOMEM;
> +	}
> +
> +	attr_idx = 0;
> +	for (i = 0; i < rp_info->num_lanes; i++) {
> +		sprintf(lane, "_lane%d", i);
> +
> +		for (j = 0; j < events_per_lane; j++) {
> +			int pos = i * events_per_lane + j;
> +
> +			strcat((char *)tmp, event_array[j].name);
> +			strcat((char *)tmp, lane);
> +			memcpy((void *)lane_attrs[pos].attr.attr.name,
> +			       (void *)tmp,
> +			       sizeof(tmp));
> +
> +			lane_attrs[pos].attr.attr.mode =
> +			    VERIFY_OCTAL_PERMISSIONS(0444);
> +			lane_attrs[pos].attr.show = dwc_pcie_event_show;
> +			lane_attrs[pos].attr.store = NULL;
> +			lane_attrs[pos].type = DWC_PCIE_LANE_EVENT;
> +			lane_attrs[pos].eventid = event_array[j].event_id;
> +			lane_attrs[pos].lane = i;
> +			pmu_attrs[attr_idx++] = &lane_attrs[pos].attr.attr;
> +
> +			memset((void *)tmp, 0, sizeof(tmp));
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(dwc_pcie_pmu_time_event_attrs); i++)
> +		pmu_attrs[attr_idx++] = dwc_pcie_pmu_time_event_attrs[i];
> +
> +	rp_info->pcie_pmu_event_attrs[attr_idx++] = NULL;
> +
> +	rp_info->pcie_pmu_event_attrs_group.name = "events";
> +	rp_info->pcie_pmu_event_attrs_group.is_visible =
> +	    pcie_pmu_event_attr_is_visible;
> +	rp_info->pcie_pmu_event_attrs_group.attrs =
> +	    rp_info->pcie_pmu_event_attrs;
> +
> +	rp_info->pcie_pmu_attr_groups[0] =
> +	    &rp_info->pcie_pmu_event_attrs_group;
> +	rp_info->pcie_pmu_attr_groups[1] = &pcie_pmu_format_attrs_group;
> +	rp_info->pcie_pmu_attr_groups[2] = &pcie_pmu_cpumask_attrs_group;
> +	rp_info->pcie_pmu_attr_groups[3] = NULL;
> +
> +	return 0;

That took a while to make sense of... dynamically generating event attrs 
is a bit horrible, especially if it means you waste a bunch of memory 
duplicating the same stuff over and over again for every PMU instance.

You can achieve the same effect far more neatly by statically defining 
all possible events, then using the .is_visible callback to hide any 
which are not supported by the given PMU instance.

However, I'm not sure it's really worth even doing that (especially if 
I've counted right and it means 464 events for a maximum of 16 lanes). 
It doesn't seem like the difference in typing "tx_io_read_lane0" vs. 
"tx_io_read,lane=0" will have a significant impact on user experience. 
Conversely, I happen to know that some users actively dislike the 
experience of "perf list" spewing out hundreds of events that swamp out 
the ones they're looking for. If this is the SoC which also has arm-cmn 
then it's already more than bad enough (sorry!) - describing 29 distinct 
events as just 29 events will be a lot more popular and manageable. If 
you like you can output "lane=?" in the event string to make it even 
more obvious - perf tool will then require the user to provide a lane 
value instead of defaulting to 0 if it isn't specified.

> +}
> +
> +static int __dwc_pcie_pmu_probe(struct dwc_pcie_pmu_priv *priv,
> +				struct dwc_pcie_rp_info *rp_info)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu;
> +	struct device *dev;
> +	char *name;
> +	int ret;
> +
> +	pcie_pmu = &rp_info->pcie_pmu;
> +	dev = &rp_info->pdev->dev;
> +
> +	ret = dwc_pcie_pmu_attr_init(priv, rp_info);
> +	if (ret) {
> +		pci_err(rp_info->pdev, "PMU attr init fail ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	pcie_pmu->dev = dev;
> +	pcie_pmu->pmu = (struct pmu) {
> +		.module		= THIS_MODULE,
> +		.task_ctx_nr	= perf_invalid_context,
> +		.pmu_enable	= NULL,
> +		.pmu_disable	= NULL,

If I counted right there are still 28 other fields being 
default-initialised to 0 or NULL here, what's special about these two? ;)

> +		.event_init	= dwc_pcie_pmu_event_init,
> +		.add		= dwc_pcie_pmu_event_add,
> +		.del		= dwc_pcie_pmu_event_del,
> +		.start		= dwc_pcie_pmu_event_start,
> +		.stop		= dwc_pcie_pmu_event_stop,
> +		.read		= dwc_pcie_pmu_event_read,
> +		.attr_groups	= rp_info->pcie_pmu_attr_groups,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +	};
> +
> +	name = devm_kasprintf(priv->dev, GFP_KERNEL, "dwc_rootport_%x",
> +			      rp_info->bdf);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Pick one CPU to be the preferred one on local NUMA node.
> +	 *
> +	 * Note, this PMU does NOT support interrupt, set on_cpu to indicate it
> +	 * is a uncore PMU device.
> +	 */
> +	pcie_pmu->on_cpu = cpumask_local_spread(0, dev_to_node(pcie_pmu->dev));

You need to cope with the possibility of that CPU going offline.

> +	ret = perf_pmu_register(&pcie_pmu->pmu, name, -1);
> +	if (ret) {
> +		pci_err(rp_info->pdev, "Error %d registering PMU @%x\n", ret,
> +				 rp_info->bdf);
> +		return ret;
> +	}
> +
> +	rp_info->pmu_is_register = true;
> +
> +	return 0;
> +}
> +
> +static int dwc_pcie_pmu_remove(struct platform_device *pdev)
> +{
> +	struct dwc_pcie_pmu_priv *priv = platform_get_drvdata(pdev);
> +	struct dwc_pcie_pmu *pcie_pmu;
> +	struct dwc_pcie_rp_info *rp_info;
> +
> +	list_for_each_entry(rp_info, &priv->rp_infos, rp_node) {
> +		if (rp_info->pmu_is_register) {
> +			pcie_pmu = &rp_info->pcie_pmu;
> +			perf_pmu_unregister(&pcie_pmu->pmu);
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int dwc_pcie_pmu_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct dwc_pcie_pmu_priv *priv;
> +	struct dwc_pcie_rp_info *rp_info;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, priv);
> +
> +	/* If RAS_DES PMU is not supported on current platform, keep silent */
> +	ret = dwc_pcie_ras_des_discover(priv);
> +	if (ret)
> +		return ret;
> +
> +	list_for_each_entry(rp_info, &priv->rp_infos, rp_node) {
> +		struct pci_dev *rp = rp_info->pdev;
> +
> +		ret = __dwc_pcie_pmu_probe(priv, rp_info);

If the PMUs are independent of each other, why not just probe them 
directly during the PCIe capability walk? That way you could easily 
ensure that the list only ever contains successfully-registered PMUs by 
construction, and make cleanup even simpler.

> +		if (ret) {
> +			dev_err(&rp->dev, "PCIe PMU probe fail\n");
> +			goto pmu_unregister;
> +		}
> +	}
> +
> +	return 0;
> +
> +pmu_unregister:
> +	dwc_pcie_pmu_remove(pdev);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver dwc_pcie_pmu_driver = {
> +	.probe = dwc_pcie_pmu_probe,
> +	.remove = dwc_pcie_pmu_remove,
> +	.driver = {.name = "dwc_pcie_pmu",},
> +};
> +
> +static int __init dwc_pcie_pmu_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&dwc_pcie_pmu_driver);
> +
> +	if (ret)
> +		return ret;
> +
> +	dwc_pcie_pmu_dev = platform_device_register_simple(
> +				"dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
> +	if (IS_ERR(dwc_pcie_pmu_dev)) {
> +		platform_driver_unregister(&dwc_pcie_pmu_driver);
> +		return PTR_ERR(dwc_pcie_pmu_dev);
> +	}

Why go through all this bother of inventing a device and registering a 
driver just to take a long round-trip through the driver core to call 
dwc_pcie_pmu_probe()? Why not just do the work of dwc_pcie_pmu_probe() 
right here? Sure, you'd also need to manually clean up a couple of 
allocations on failure or exit instead of using devres, but that's still 
considerably less hassle than invoking the whole driver model just to 
disguise a list_head and a couple of function calls.

Thanks,
Robin.

> +
> +	return 0;
> +}
> +
> +static void __exit dwc_pcie_pmu_exit(void)
> +{
> +	platform_device_unregister(dwc_pcie_pmu_dev);
> +	platform_driver_unregister(&dwc_pcie_pmu_driver);
> +}
> +
> +module_init(dwc_pcie_pmu_init);
> +module_exit(dwc_pcie_pmu_exit);
> +
> +MODULE_DESCRIPTION("PMU driver for DesignWare Cores PCI Express Controller");
> +MODULE_AUTHOR("Shuai xue <xueshuai@linux.alibaba.com>");
> +MODULE_AUTHOR("Wen Cheng <yinxuan_cw@linux.alibaba.com>");
> +MODULE_LICENSE("GPL v2");
