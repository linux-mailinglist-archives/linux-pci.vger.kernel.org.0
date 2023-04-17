Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7AF6E3D2A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 03:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDQBQS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Apr 2023 21:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDQBQS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Apr 2023 21:16:18 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E6E2713;
        Sun, 16 Apr 2023 18:16:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VgBUyno_1681694170;
Received: from 30.97.56.45(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VgBUyno_1681694170)
          by smtp.aliyun-inc.com;
          Mon, 17 Apr 2023 09:16:11 +0800
Message-ID: <ca46be9a-77f2-80ee-62e8-a3ce3eb02097@linux.alibaba.com>
Date:   Mon, 17 Apr 2023 09:16:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v2 2/3] drivers/perf: add DesignWare PCIe PMU driver
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org, Jonathan.Cameron@huawei.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        robin.murphy@arm.com, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
 <20230410031702.68355-3-xueshuai@linux.alibaba.com>
 <713d8162-dd3c-483c-b984-7707ef8aaa36@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <713d8162-dd3c-483c-b984-7707ef8aaa36@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/4/11 AM11:17, Baolin Wang wrote:
> 
> 
> On 4/10/2023 11:17 AM, Shuai Xue wrote:
>> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
>> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
>> Core controller IP which provides statistics feature. The PMU is not a PCIe
>> Root Complex integrated End Point(RCiEP) device but only register counters
>> provided by each PCIe Root Port.
>>
>> To facilitate collection of statistics the controller provides the
>> following two features for each Root Port:
>>
>> - Time Based Analysis (RX/TX data throughput and time spent in each
>>    low-power LTSSM state)
>> - Event counters (Error and Non-Error for lanes)
>>
>> Note, only one counter for each type and does not overflow interrupt.
>>
>> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
>> named based the BDF of Root Port. For example,
>>
>>      30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>>
>> the PMU device name for this Root Port is dwc_rootport_3018.
>>
>> Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
>>
>>      $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>>
>> average RX bandwidth can be calculated like this:
>>
>>      PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   drivers/perf/Kconfig        |   7 +
>>   drivers/perf/Makefile       |   1 +
>>   drivers/perf/dwc_pcie_pmu.c | 877 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 885 insertions(+)
>>   create mode 100644 drivers/perf/dwc_pcie_pmu.c
>>
>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>> index 66c259000a44..57bce3880cba 100644
>> --- a/drivers/perf/Kconfig
>> +++ b/drivers/perf/Kconfig
>> @@ -199,6 +199,13 @@ config MARVELL_CN10K_DDR_PMU
>>         Enable perf support for Marvell DDR Performance monitoring
>>         event on CN10K platform.
>>   +config DWC_PCIE_PMU
>> +    tristate "Enable Synopsys DesignWare PCIe PMU Support"
>> +    depends on ARM64 || (COMPILE_TEST && 64BIT)
>> +    help
>> +      Enable perf support for Synopsys DesignWare PCIe PMU Performance
>> +      monitoring event on Yitian 710 platform.
>> +
>>   source "drivers/perf/arm_cspmu/Kconfig"
>>     source "drivers/perf/amlogic/Kconfig"
>> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
>> index 13e45da61100..3f233e96524e 100644
>> --- a/drivers/perf/Makefile
>> +++ b/drivers/perf/Makefile
>> @@ -21,5 +21,6 @@ obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
>>   obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
>>   obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
>>   obj-$(CONFIG_ALIBABA_UNCORE_DRW_PMU) += alibaba_uncore_drw_pmu.o
>> +obj-$(CONFIG_DWC_PCIE_PMU) += dwc_pcie_pmu.o
>>   obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
>>   obj-$(CONFIG_MESON_DDR_PMU) += amlogic/
>> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
>> new file mode 100644
>> index 000000000000..c8c09f120d4e
>> --- /dev/null
>> +++ b/drivers/perf/dwc_pcie_pmu.c
>> @@ -0,0 +1,877 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Synopsys DesignWare PCIe PMU driver
>> + *
>> + * Copyright (C) 2021, 2022 Alibaba Inc.
>> + */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/device.h>
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/perf_event.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/smp.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/types.h>
>> +#define PCI_VENDOR_ID_ALIBABA 0x1ded
>> +
>> +#define ATTRI_NAME_MAX_SIZE            32
>> +#define DWC_PCIE_VSEC_RAS_DES_ID        0x02
>> +
>> +#define DWC_PCIE_EVENT_CNT_CTL            0x8
>> +#define DWC_PCIE_CNT_EVENT_SEL            GENMASK(27, 16)
>> +#define DWC_PCIE_CNT_LANE_SEL            GENMASK(11, 8)
>> +#define DWC_PCIE_CNT_STATUS            BIT(7)
>> +#define DWC_PCIE_CNT_ENABLE            GENMASK(4, 2)
>> +#define DWC_PCIE_PER_EVENT_OFF            FIELD_PREP(DWC_PCIE_CNT_ENABLE, 0x1)
>> +#define DWC_PCIE_PER_EVENT_ON            FIELD_PREP(DWC_PCIE_CNT_ENABLE, 0x3)
>> +#define DWC_PCIE_EVENT_CLEAR            GENMASK(1, 0)
>> +#define DWC_PCIE_EVENT_PER_CLEAR        0x1
>> +
>> +#define DWC_PCIE_EVENT_CNT_DATA            0xC
>> +
>> +#define DWC_PCIE_TIME_BASED_ANAL_CTL        0x10
>> +#define DWC_PCIE_TIME_BASED_REPORT_SEL        GENMASK(31, 24)
>> +#define DWC_PCIE_TIME_BASED_DURATION_SEL    GENMASK(15, 8)
>> +#define DWC_PCIE_DURATION_MANUAL_CTL        0x0
>> +#define DWC_PCIE_DURATION_1MS            0x1
>> +#define DWC_PCIE_DURATION_10MS            0x2
>> +#define DWC_PCIE_DURATION_100MS            0x3
>> +#define DWC_PCIE_DURATION_1S            0x4
>> +#define DWC_PCIE_DURATION_2S            0x5
>> +#define DWC_PCIE_DURATION_4S            0x6
>> +#define DWC_PCIE_DURATION_4US            0xff
>> +#define DWC_PCIE_TIME_BASED_CNT_ENABLE        0x1
>> +
>> +#define DWC_PCIE_TIME_BASED_ANAL_DATA_REG_LOW    0x14
>> +#define DWC_PCIE_TIME_BASED_ANAL_DATA_REG_HIGH    0x18
>> +
>> +/* Event attributes */
>> +#define DWC_PCIE_CONFIG_EVENTID            GENMASK(15, 0)
>> +#define DWC_PCIE_CONFIG_TYPE            GENMASK(19, 16)
>> +#define DWC_PCIE_CONFIG_LANE            GENMASK(27, 20)
>> +
>> +#define DWC_PCIE_EVENT_ID(event)    FIELD_GET(DWC_PCIE_CONFIG_EVENTID, (event)->attr.config)
>> +#define DWC_PCIE_EVENT_TYPE(event)    FIELD_GET(DWC_PCIE_CONFIG_TYPE, (event)->attr.config)
>> +#define DWC_PCIE_EVENT_LANE(event)    FIELD_GET(DWC_PCIE_CONFIG_LANE, (event)->attr.config)
>> +
>> +#define DWC_PCIE_PMU_HAS_REGISTER        1
>> +
>> +enum dwc_pcie_event_type {
>> +    DWC_PCIE_TYPE_INVALID,
>> +    DWC_PCIE_TIME_BASE_EVENT,
>> +    DWC_PCIE_LANE_EVENT,
>> +};
>> +
>> +struct dwc_event_counters {
>> +    const char name[32];
>> +    u32 event_id;
>> +};
>> +
>> +struct dwc_pcie_pmu {
>> +    struct hlist_node node;
>> +    unsigned int on_cpu;
>> +    struct pmu pmu;
>> +    struct device *dev;
>> +};
>> +
>> +struct dwc_pcie_rp_info {
>> +    u32 bdf;
>> +    u32 ras_des;
>> +    u32 num_lanes;
>> +
>> +    struct list_head rp_node;
>> +    struct pci_dev *pdev;
>> +    struct dwc_pcie_pmu pcie_pmu;
>> +    u8 pmu_is_register;
>> +    struct perf_event *event;
>> +
>> +    struct dwc_pcie_event_attr *lane_event_attrs;
>> +    struct attribute **pcie_pmu_event_attrs;
>> +    struct attribute_group pcie_pmu_event_attrs_group;
>> +    const struct attribute_group *pcie_pmu_attr_groups[4];
>> +};
>> +
>> +struct dwc_pcie_pmu_priv {
>> +    struct device *dev;
>> +    u32 pcie_ctrl_num;
>> +    struct list_head rp_infos;
>> +};
>> +
>> +#define to_dwc_pcie_pmu(p) (container_of(p, struct dwc_pcie_pmu, pmu))
>> +
>> +static struct platform_device *dwc_pcie_pmu_dev;
>> +static char *event_attr_name = "events";
> 
> Since only one place uses the 'event_attr_name' variable, just using the "events" string in the code seems more readable.
> 

Ok, will fix in next version.

>> +
>> +static ssize_t cpumask_show(struct device *dev,
>> +                     struct device_attribute *attr,
>> +                     char *buf)
>> +{
>> +    struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(dev_get_drvdata(dev));
>> +
>> +    return cpumap_print_to_pagebuf(true, buf, cpumask_of(pcie_pmu->on_cpu));
>> +}
>> +static DEVICE_ATTR_RO(cpumask);
>> +
>> +#define DEVICE_ATTR_RO(_name) \
>> +    struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
> 
> There is already a general DEVICE_ATTR_RO macro in linux/device.h, please do not add duplicate and confusing macro definition.
> 
>> +#define __ATTR_RO(_name) {                        \
> 
> This also seems a more general macro definition, can you rename it as something like 'DWC_PMU_ATTR_RO' or other better name?
> 
>> +    .attr    = { .name = __stringify(_name), .mode = 0444 },        \
>> +    .show    = _name##_show,                        \
>> +}
>> +#define __ATTR(_name, _mode, _show, _store) {                \
> 
> ditto.

I was going to copy the macro definitions from linux/device.h and see more details,
sorry for forgetting to delete it.

> 
>> +    .attr = {.name = __stringify(_name),                \
>> +         .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },        \
>> +    .show    = _show,                        \
>> +    .store    = _store,                        \
>> +}
>> +
>> +static struct attribute *dwc_pcie_pmu_cpumask_attrs[] = {
>> +    &dev_attr_cpumask.attr,
>> +    NULL
>> +};
>> +
>> +static struct attribute_group pcie_pmu_cpumask_attrs_group = { > +    .attrs = dwc_pcie_pmu_cpumask_attrs,
>> +};
>> +
>> +struct dwc_pcie_format_attr {
>> +    struct device_attribute attr;
>> +    u64 field;
>> +    int config;
>> +};
>> +
>> +static ssize_t dwc_pcie_pmu_format_show(struct device *dev,
>> +                    struct device_attribute *attr,
>> +                    char *buf)
>> +{
>> +    struct dwc_pcie_format_attr *fmt = container_of(attr, typeof(*fmt), attr);
>> +    int lo = __ffs(fmt->field), hi = __fls(fmt->field);
>> +
>> +    if (lo == hi)
>> +        return snprintf(buf, PAGE_SIZE, "config:%d\n", lo);
>> +
>> +    if (!fmt->config)
>> +        return snprintf(buf, PAGE_SIZE, "config:%d-%d\n", lo, hi);
>> +
>> +    return snprintf(buf, PAGE_SIZE, "config%d:%d-%d\n", fmt->config, lo,
>> +            hi);
>> +}
>> +
>> +#define _dwc_pcie_format_attr(_name, _cfg, _fld)                \
>> +    (&((struct dwc_pcie_format_attr[]) {{                \
>> +        .attr = __ATTR(_name, 0444, dwc_pcie_pmu_format_show, NULL),    \
>> +        .config = _cfg,                        \
>> +        .field = _fld,                        \
>> +    }})[0].attr.attr)
>> +
>> +#define dwc_pcie_format_attr(_name, _fld)    _dwc_pcie_format_attr(_name, 0, _fld)
>> +
>> +static struct attribute *dwc_pcie_format_attrs[] = {
>> +    dwc_pcie_format_attr(type, DWC_PCIE_CONFIG_TYPE),
>> +    dwc_pcie_format_attr(eventid, DWC_PCIE_CONFIG_EVENTID),
>> +    dwc_pcie_format_attr(lane, DWC_PCIE_CONFIG_LANE),
>> +    NULL,
>> +};
>> +
>> +static struct attribute_group pcie_pmu_format_attrs_group = { > +    .name = "format",
>> +    .attrs = dwc_pcie_format_attrs,
>> +};
>> +
>> +struct dwc_pcie_event_attr {
>> +    struct device_attribute attr;
>> +    enum dwc_pcie_event_type type;
>> +    u16 eventid;
>> +    u8 lane;
>> +};
>> +
>> +ssize_t dwc_pcie_event_show(struct device *dev,
>> +                struct device_attribute *attr, char *page)
>> +{
>> +    struct dwc_pcie_event_attr *eattr;
>> +
>> +    eattr = container_of(attr, typeof(*eattr), attr);
>> +
>> +    if (eattr->type == DWC_PCIE_LANE_EVENT)
>> +        return sprintf(page, "eventid=0x%lx, type=0x%lx, lane=0x%lx\n",
>> +                   (unsigned long)eattr->eventid,
>> +                   (unsigned long)eattr->type,
>> +                   (unsigned long)eattr->lane);
>> +    else
> 
> 'else' is redundant.

Will remove it in next version.


>> +        return sprintf(page, "eventid=0x%lx, type=0x%lx",
>> +                   (unsigned long)eattr->eventid,
>> +                   (unsigned long)eattr->type);
>> +}
>> +
>> +#define DWC_PCIE_EVENT_ATTR(_name, _type, _eventid, _lane)        \
>> +    (&((struct dwc_pcie_event_attr[]) {{                \
>> +        .attr = __ATTR(_name, 0444, dwc_pcie_event_show, NULL),    \
>> +        .type = _type,                        \
>> +        .eventid = _eventid,                    \
>> +        .lane = _lane,                    \
>> +    }})[0].attr.attr)
>> +
>> +#define DWC_PCIE_PMU_BASE_TIME_ATTR(_name, _eventid)            \
>> +    DWC_PCIE_EVENT_ATTR(_name, DWC_PCIE_TIME_BASE_EVENT, _eventid, 0)
>> +
>> +static struct attribute *dwc_pcie_pmu_time_event_attrs[] = {
>> +    /* Group #0 */
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(one_cycle, 0x00),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(TX_L0S, 0x01),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(RX_L0S, 0x02),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(L0, 0x03),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(L1, 0x04),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(L1_1, 0x05),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(L1_2, 0x06),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(CFG_RCVRY, 0x07),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(TX_RX_L0S, 0x08),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(L1_AUX, 0x09),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(ONE_cycle, 0x10),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(TX_L0S_, 0x11),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(RX_L0S_, 0x12),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(L0_, 0x13),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(L1_, 0x17),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(CFG_RCVRY_, 0x17),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(TX_RX_L0S_, 0x18),
>> +    /* Group #1 */
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(Tx_PCIe_TLP_Data_Payload, 0x20),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(Rx_PCIe_TLP_Data_Payload, 0x21),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(Tx_CCIX_TLP_Data_Payload, 0x22),
>> +    DWC_PCIE_PMU_BASE_TIME_ATTR(Rx_CCIX_TLP_Data_Payload, 0x23),
>> +    NULL
>> +};
>> +
>> +static inline umode_t pcie_pmu_event_attr_is_visible(struct kobject *kobj,
>> +                             struct attribute *attr,
>> +                             int unuse)
>> +{
>> +    return attr->mode;
>> +}
>> +
>> +static inline bool pci_dev_is_rootport(struct pci_dev *pdev)
>> +{
>> +    return (pci_is_pcie(pdev) &&
>> +        pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT);
>> +}
>> +
>> +static int dwc_pcie_ras_des_discover(struct dwc_pcie_pmu_priv *priv)
>> +{
>> +    int index = 0;
>> +    struct pci_dev *pdev = NULL;
>> +    struct dwc_pcie_rp_info *rp_info;
>> +
>> +    INIT_LIST_HEAD(&priv->rp_infos);
>> +
>> +    /* Match the rootport with VSEC_RAS_DES_ID */
>> +    for_each_pci_dev(pdev) {
>> +        u16 vsec;
>> +        u32 val;
>> +
>> +        if (!pci_dev_is_rootport(pdev))
>> +            continue;
>> +
>> +        rp_info = devm_kzalloc(&pdev->dev, sizeof(*rp_info), GFP_KERNEL);
>> +        if (!rp_info)
>> +            return -ENOMEM;
>> +
>> +        rp_info->bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
>> +        rp_info->pdev = pdev;
>> +
>> +        vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
>> +                        DWC_PCIE_VSEC_RAS_DES_ID);
>> +        if (!vsec)
>> +            continue;
>> +
>> +        pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
>> +        if (PCI_VNDR_HEADER_REV(val) != 0x04 ||
>> +            PCI_VNDR_HEADER_LEN(val) != 0x100)
>> +            continue;
>> +        pci_dbg(pdev,
>> +            "Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
>> +
>> +        rp_info->ras_des = vsec;
>> +
>> +        pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &val);
> 
> The linkcap value is not used, then why need read it?

Yes, it is redundant. Will remove it in next version.

> 
>> +        rp_info->num_lanes = pcie_get_width_cap(pdev);
>> +
>> +        list_add(&rp_info->rp_node, &priv->rp_infos);
>> +        index++;
>> +    }
>> +
>> +    if (!index)
>> +        return -ENODEV;
>> +
>> +    priv->pcie_ctrl_num = index;
>> +
>> +    return 0;
>> +}
>> +
>> +static void dwc_pcie_pmu_set_event_id(struct pci_dev *pdev, u16 ras_des,
>> +                     int event_id)
>> +{
>> +    u32 val;
>> +
>> +    pci_read_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, &val);
>> +
>> +    val &= ~DWC_PCIE_CNT_ENABLE;
>> +    val |= FIELD_PREP(DWC_PCIE_CNT_EVENT_SEL, event_id);
>> +
>> +    pci_write_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, val);
>> +}
>> +
>> +static void dwc_pcie_pmu_write_event_lane(struct pci_dev *pdev, u16 ras_des,
>> +                     int lane, int event_id)
>> +{
>> +    u32 val;
>> +
>> +    pci_read_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, &val);
>> +
>> +    val &= ~DWC_PCIE_CNT_LANE_SEL;
>> +    val |= FIELD_PREP(DWC_PCIE_CNT_EVENT_SEL, lane);
>> +
>> +    pci_write_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, val);
>> +}
>> +
>> +static void dwc_pcie_pmu_event_enable(struct pci_dev *pdev, u16 ras_des,
>> +                     u32 enable)
>> +{
>> +    u32 val;
>> +
>> +    pci_read_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, &val);
>> +
>> +    val &= ~DWC_PCIE_CNT_ENABLE;
>> +
>> +    if (enable)
>> +        val |= DWC_PCIE_PER_EVENT_ON;
>> +    else
>> +        val |= DWC_PCIE_PER_EVENT_OFF;
>> +
>> +    pci_write_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, val);
>> +}
>> +
>> +static void dwc_pcie_pmu_base_time_enable(struct pci_dev *pdev, u16 ras_des,
>> +                     u32 enable)
>> +{
>> +    u32 val;
>> +
>> +    pci_read_config_dword(pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_CTL, &val);
>> +
>> +    if (enable)
>> +        val |= DWC_PCIE_TIME_BASED_CNT_ENABLE;
>> +    else
>> +        val &= ~DWC_PCIE_TIME_BASED_CNT_ENABLE;
>> +
>> +    pci_write_config_dword(pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_CTL, val);
>> +}
>> +
>> +static void dwc_pcie_pmu_read_event_counter(struct pci_dev *pdev, u16 ras_des,
>> +                        u64 *counter)
>> +{
>> +    u32 val;
>> +
>> +    pci_read_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_DATA, &val);
>> +    *counter = val;
>> +}
>> +
>> +/* The results are cleared when next measurement starts. */
>> +static void dwc_pcie_pmu_read_base_time_counter(struct pci_dev *pdev,
>> +                        u16 ras_des, u64 *counter)
>> +{
>> +    u32 val;
>> +
>> +    pci_read_config_dword(
>> +        pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_DATA_REG_HIGH,
>> +        &val);
>> +    *counter = val;
>> +    *counter <<= 32;
>> +
>> +    pci_read_config_dword(
>> +        pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_DATA_REG_LOW,
>> +        &val);
>> +
>> +    *counter += val;
>> +}
>> +
>> +static void dwc_pcie_pmu_clear_event_counter(struct pci_dev *pdev, u16 ras_des)
>> +{
>> +    u32 val;
>> +
>> +    pci_read_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, &val);
>> +
>> +    val |= FIELD_PREP(DWC_PCIE_EVENT_CLEAR, DWC_PCIE_EVENT_PER_CLEAR);
>> +
>> +    pci_write_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, val);
>> +}
>> +
>> +static void dwc_pcie_pmu_base_time_add_prepare(struct pci_dev *pdev,
>> +                           u16 ras_des, u32 event_id)
>> +{
>> +    u32 val;
>> +
>> +    pci_read_config_dword(pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_CTL,
>> +                  &val);
>> +
>> +    val &= ~DWC_PCIE_TIME_BASED_REPORT_SEL;
>> +    val |= FIELD_PREP(DWC_PCIE_TIME_BASED_REPORT_SEL, event_id);
>> +    val &= ~DWC_PCIE_TIME_BASED_DURATION_SEL;
>> +
>> +    /*
>> +     * TIME_BASED_ANAL_DATA_REG is a 64 bit register, we can safely
>> +     * use it with any manually controlled duration.
>> +     */
>> +    val &= ~(DWC_PCIE_TIME_BASED_DURATION_SEL);
> 
> Remove redundant '()'.

Will remove it.

> 
>> +    val |= DWC_PCIE_DURATION_MANUAL_CTL;
>> +
>> +    pci_write_config_dword(pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_CTL,
>> +                   val);
>> +}
>> +
>> +static struct dwc_pcie_rp_info *pmu_to_pcie_info(struct pmu *pmu)
>> +{
>> +    struct dwc_pcie_rp_info *rp_info;
>> +    struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(pmu);
>> +
>> +    rp_info = container_of(pcie_pmu, struct dwc_pcie_rp_info, pcie_pmu);
>> +
>> +    return rp_info;
>> +}
>> +
>> +static void dwc_pcie_pmu_event_update(struct perf_event *event)
>> +{
>> +    u64 counter;
>> +    struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>> +    struct dwc_pcie_rp_info *rp_info = pmu_to_pcie_info(event->pmu);
>> +    struct pci_dev *pdev = rp_info->pdev;
>> +    u16 ras_des = rp_info->ras_des;
>> +    struct hw_perf_event *hwc = &event->hw;
>> +    enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
>> +    u64 delta, prev, now;
>> +
>> +    do {
>> +        prev = local64_read(&hwc->prev_count);
>> +
>> +        if (type == DWC_PCIE_LANE_EVENT)
>> +            dwc_pcie_pmu_read_event_counter(pdev, ras_des, &counter);
>> +        else if (type == DWC_PCIE_TIME_BASE_EVENT)
>> +            dwc_pcie_pmu_read_base_time_counter(pdev, ras_des,
>> +                                &counter);
>> +        else
>> +            dev_err(pcie_pmu->dev, "invalid event type: 0x%x\n", type);
>> +
>> +        now = counter;
>> +    } while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
>> +
>> +    delta = now - prev;
> 
> This can be overflow? better to add a mask to avoid possible overflow.

I think it can not. This Root Complex supports up to PCIe Gen5 (32 GT/s)
and one root port support up to x16 lanes, with peek bandwidth 64 GB/s.
On Yitian 710, one root port is x4 lane with peak bandwidth 16 GB/s.
The counter is 64 bit width with 16 bytes unit.

	2^64*16/(64*10^9)/60/60/24/365 = 146 years

For x16 root port, it will not overflow within 146 yeasr and for yitian 710,
it will never overflow in my life too.

> 
>> +
>> +    local64_add(delta, &event->count);
>> +}
>> +
>> +static int dwc_pcie_pmu_event_init(struct perf_event *event)
>> +{
>> +    struct hw_perf_event *hwc = &event->hw;
>> +    struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>> +    struct perf_event *sibling;
>> +
>> +    if (event->attr.type != event->pmu->type)
>> +        return -ENOENT;
>> +
>> +    if (hwc->sample_period) {
>> +        dev_dbg(pcie_pmu->dev, "Sampling not supported\n");
> 
> should use dev_err() if treating it as an error.
> 
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    if (event->cpu < 0) {
>> +        dev_dbg(pcie_pmu->dev, "Per-task mode not supported\n");
> 
> ditto.

I will use dev_err() instead.

> 
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    event->cpu = pcie_pmu->on_cpu;
>> +
>> +    if (event->group_leader != event &&
>> +        !is_software_event(event->group_leader))
>> +        return -EINVAL;
>> +
>> +    for_each_sibling_event(sibling, event->group_leader) {
>> +        if (sibling != event && !is_software_event(sibling))
>> +            return -EINVAL;
>> +    }
>> +
>> +    hwc->idx = -1;
>> +
>> +    return 0;
>> +}
>> +
>> +static void dwc_pcie_pmu_set_period(struct hw_perf_event *hwc)
>> +{
>> +    local64_set(&hwc->prev_count, 0);
>> +}
>> +
>> +static void dwc_pcie_pmu_event_start(struct perf_event *event, int flags)
>> +{
>> +    struct hw_perf_event *hwc = &event->hw;
>> +    struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>> +    struct dwc_pcie_rp_info *rp_info = pmu_to_pcie_info(event->pmu);
>> +    struct pci_dev *pdev = rp_info->pdev;
>> +    u16 ras_des = rp_info->ras_des;
>> +    enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
>> +
>> +    hwc->state = 0;
>> +    dwc_pcie_pmu_set_period(hwc);
>> +
>> +    if (type == DWC_PCIE_LANE_EVENT)
>> +        dwc_pcie_pmu_event_enable(pdev, ras_des, 1);
>> +    else if (type == DWC_PCIE_TIME_BASE_EVENT)
>> +        dwc_pcie_pmu_base_time_enable(pdev, ras_des, 1);
>> +    else
>> +        dev_err(pcie_pmu->dev, "invalid event type: 0x%x\n", type);
>> +}
>> +
>> +static void dwc_pcie_pmu_event_stop(struct perf_event *event, int flags)
>> +{
>> +    struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>> +    struct dwc_pcie_rp_info *rp_info = pmu_to_pcie_info(event->pmu);
>> +    struct pci_dev *pdev = rp_info->pdev;
>> +    u16 ras_des = rp_info->ras_des;
>> +
>> +    enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
>> +
>> +    if (event->hw.state & PERF_HES_STOPPED)
>> +        return;
>> +
>> +    if (type == DWC_PCIE_LANE_EVENT)
>> +        dwc_pcie_pmu_event_enable(pdev, ras_des, 0);
>> +    else if (type == DWC_PCIE_TIME_BASE_EVENT)
>> +        dwc_pcie_pmu_base_time_enable(pdev, ras_des, 0);
>> +    else
>> +        dev_err(pcie_pmu->dev, "invalid event type: 0x%x\n", type);
>> +
>> +    dwc_pcie_pmu_event_update(event);
>> +}
>> +
>> +static int dwc_pcie_pmu_event_add(struct perf_event *event, int flags)
>> +{
>> +    struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>> +    struct dwc_pcie_rp_info *rp_info = pmu_to_pcie_info(event->pmu);
>> +    struct pci_dev *pdev = rp_info->pdev;
>> +    u16 ras_des = rp_info->ras_des;
>> +    struct hw_perf_event *hwc = &event->hw;
>> +    enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
>> +    int event_id = DWC_PCIE_EVENT_ID(event);
>> +    int lane = DWC_PCIE_EVENT_LANE(event);
>> +
>> +    /* Only one counter and it is in use */
>> +    if (rp_info->event)
>> +        return -ENOSPC;
>> +
>> +    rp_info->event = event;
>> +
>> +    hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
>> +
>> +    if (type == DWC_PCIE_LANE_EVENT) {
>> +        dwc_pcie_pmu_event_enable(pdev, ras_des, 0);
>> +        dwc_pcie_pmu_write_event_lane(pdev, ras_des, lane, event_id);
>> +        dwc_pcie_pmu_set_event_id(pdev, ras_des, event_id);
>> +        dwc_pcie_pmu_clear_event_counter(pdev, ras_des);
>> +    } else if (type == DWC_PCIE_TIME_BASE_EVENT) {
>> +        dwc_pcie_pmu_base_time_enable(pdev, ras_des, 0);
>> +        dwc_pcie_pmu_base_time_add_prepare(pdev, ras_des, event_id);
>> +    } else {
>> +        dev_err(pcie_pmu->dev, "invalid event type: 0x%x\n", type);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (flags & PERF_EF_START)
>> +        dwc_pcie_pmu_event_start(event, PERF_EF_RELOAD);
>> +
>> +    perf_event_update_userpage(event);
>> +
>> +    return 0;
>> +}
>> +
>> +static void dwc_pcie_pmu_event_del(struct perf_event *event, int flags)
>> +{
>> +    struct dwc_pcie_rp_info *rp_info = pmu_to_pcie_info(event->pmu);
>> +
>> +    dwc_pcie_pmu_event_stop(event, flags | PERF_EF_UPDATE);
>> +    perf_event_update_userpage(event);
>> +    rp_info->event = NULL;
>> +}
>> +
>> +static void dwc_pcie_pmu_event_read(struct perf_event *event)
>> +{
>> +    dwc_pcie_pmu_event_update(event);
>> +}
>> +
>> +static struct dwc_event_counters event_array[] = {
>> +    {"tx_ack_dllp", 0x600},
>> +    {"tx_update_fc_dllp", 0x601},
>> +    {"rx_ack_dllp", 0x602},
>> +    {"rx_update_fc_dllp", 0x603},
>> +    {"rx_nulified_tlp", 0x604},
>> +    {"tx_nulified_tlp", 0x605},
>> +    {"rx_duplicate_tlp", 0x606},
>> +    {"tx_memory_write", 0x700},
>> +    {"tx_memory_read", 0x701},
>> +    {"tx_configuration_write", 0x702},
>> +    {"tx_configuration_read", 0x703},
>> +    {"tx_io_write", 0x704},
>> +    {"tx_io_read", 0x705},
>> +    {"tx_completion_without_data", 0x706},
>> +    {"tx_completion_with_data", 0x707},
>> +    {"tx_message_tlp", 0x708},
>> +    {"tx_atomic", 0x709},
>> +    {"tx_tlp_with_prefix", 0x70A},
>> +    {"rx_memory_write", 0x70B},
>> +    {"rx_memory_read", 0x70C},
>> +    {"rx_io_write", 0x70F},
>> +    {"rx_io_read", 0x710},
>> +    {"rx_completion_without_data", 0x711},
>> +    {"rx_completion_with_data", 0x712},
>> +    {"rx_message_tlp", 0x713},
>> +    {"rx_atomic", 0x714},
>> +    {"rx_tlp_with_prefix", 0x715},
>> +    {"tx_ccix_tlp", 0x716},
>> +    {"rx_ccix_tlp", 0x717},
>> +};
>> +
>> +static int dwc_pcie_pmu_attr_init(struct dwc_pcie_pmu_priv *priv,
>> +                  struct dwc_pcie_rp_info *rp_info)
>> +{
>> +    int i, j;
>> +    char lane[8];
>> +    const char tmp[64];
>> +    int events_per_lane;
>> +    int num_lane_events;
>> +    int time_base_count;
>> +    int num_attrs, attr_idx;
>> +    struct dwc_pcie_event_attr *lane_attrs;
>> +    struct attribute **pmu_attrs;
>> +
>> +    memset((void *)tmp, 0, sizeof(tmp));
>> +    memset((void *)lane, 0, sizeof(lane));
>> +    time_base_count = ARRAY_SIZE(dwc_pcie_pmu_time_event_attrs);
>> +    events_per_lane = ARRAY_SIZE(event_array);
>> +    num_lane_events = rp_info->num_lanes * events_per_lane;
>> +    num_attrs = time_base_count + num_lane_events;
>> +
>> +    rp_info->lane_event_attrs =
>> +        devm_kcalloc(priv->dev, num_lane_events,
>> +                sizeof(struct dwc_pcie_event_attr),
>> +                GFP_KERNEL);
>> +    if (!rp_info->lane_event_attrs)
>> +        return -ENOMEM;
>> +    lane_attrs = rp_info->lane_event_attrs;
>> +    rp_info->pcie_pmu_event_attrs =
>> +        devm_kcalloc(priv->dev, num_attrs, sizeof(struct attribute *),
>> +             GFP_KERNEL);
>> +    if (!rp_info->pcie_pmu_event_attrs)
>> +        return -ENOMEM;
>> +    pmu_attrs = rp_info->pcie_pmu_event_attrs;
>> +
>> +    for (i = 0; i < num_lane_events; i++) {
>> +        lane_attrs[i].attr.attr.name =
>> +            devm_kzalloc(priv->dev, sizeof(char)
>> +                 * ATTRI_NAME_MAX_SIZE, GFP_KERNEL);
>> +        if (!lane_attrs[i].attr.attr.name)
>> +            return -ENOMEM;
>> +    }
>> +
>> +    attr_idx = 0;
>> +    for (i = 0; i < rp_info->num_lanes; i++) {
>> +        sprintf(lane, "_lane%d", i);
>> +
>> +        for (j = 0; j < events_per_lane; j++) {
>> +            int pos = i * events_per_lane + j;
>> +
>> +            strcat((char *)tmp, event_array[j].name);
>> +            strcat((char *)tmp, lane);
>> +            memcpy((void *)lane_attrs[pos].attr.attr.name,
>> +                   (void *)tmp,
>> +                   sizeof(tmp));
>> +
>> +            lane_attrs[pos].attr.attr.mode =
>> +                VERIFY_OCTAL_PERMISSIONS(0444);
>> +            lane_attrs[pos].attr.show = dwc_pcie_event_show;
>> +            lane_attrs[pos].attr.store = NULL;
>> +            lane_attrs[pos].type = DWC_PCIE_LANE_EVENT;
>> +            lane_attrs[pos].eventid = event_array[j].event_id;
>> +            lane_attrs[pos].lane = i;
>> +            pmu_attrs[attr_idx++] = &lane_attrs[pos].attr.attr;
>> +
>> +            memset((void *)tmp, 0, sizeof(tmp));
>> +        }
>> +    }
>> +
>> +    for (i = 0; i < ARRAY_SIZE(dwc_pcie_pmu_time_event_attrs); i++)
>> +        pmu_attrs[attr_idx++] = dwc_pcie_pmu_time_event_attrs[i];
>> +
>> +    rp_info->pcie_pmu_event_attrs[attr_idx++] = NULL;
>> +
>> +    rp_info->pcie_pmu_event_attrs_group.name = event_attr_name;
>> +    rp_info->pcie_pmu_event_attrs_group.is_visible =
>> +        pcie_pmu_event_attr_is_visible;
>> +    rp_info->pcie_pmu_event_attrs_group.attrs =
>> +        rp_info->pcie_pmu_event_attrs;
>> +
>> +    rp_info->pcie_pmu_attr_groups[0] =
>> +        &rp_info->pcie_pmu_event_attrs_group;
>> +    rp_info->pcie_pmu_attr_groups[1] = &pcie_pmu_format_attrs_group;
>> +    rp_info->pcie_pmu_attr_groups[2] = &pcie_pmu_cpumask_attrs_group;
>> +    rp_info->pcie_pmu_attr_groups[3] = NULL;
>> +
>> +    return 0;
>> +}
>> +
>> +static int __dwc_pcie_pmu_probe(struct dwc_pcie_pmu_priv *priv,
>> +                struct dwc_pcie_rp_info *rp_info)
>> +{
>> +    struct dwc_pcie_pmu *pcie_pmu;
>> +    struct device *dev;
>> +    char *name;
>> +    int ret;
>> +
>> +    pcie_pmu = &rp_info->pcie_pmu;
>> +    dev = &rp_info->pdev->dev;
>> +
>> +    ret = dwc_pcie_pmu_attr_init(priv, rp_info);
>> +    if (ret) {
>> +        pci_err(rp_info->pdev, "PMU attr init fail ret=%d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    pcie_pmu->dev = dev;
>> +    pcie_pmu->pmu = (struct pmu) {
>> +        .module        = THIS_MODULE,
>> +        .task_ctx_nr    = perf_invalid_context,
>> +        .pmu_enable    = NULL,
>> +        .pmu_disable    = NULL,
>> +        .event_init    = dwc_pcie_pmu_event_init,
>> +        .add        = dwc_pcie_pmu_event_add,
>> +        .del        = dwc_pcie_pmu_event_del,
>> +        .start        = dwc_pcie_pmu_event_start,
>> +        .stop        = dwc_pcie_pmu_event_stop,
>> +        .read        = dwc_pcie_pmu_event_read,
>> +        .attr_groups    = rp_info->pcie_pmu_attr_groups,
>> +        .capabilities    = PERF_PMU_CAP_NO_EXCLUDE,
>> +    };
>> +
>> +    name = devm_kasprintf(priv->dev, GFP_KERNEL, "dwc_rootport_%x",
>> +                  rp_info->bdf);
>> +    if (!name)
>> +        return -ENOMEM;
>> +
>> +    /*
>> +     * Pick one CPU to be the preferred one on local NUMA node.
>> +     *
>> +     * Note, this PMU does NOT support interrupt, set on_cpu to indicate it
>> +     * is a uncore PMU device.
>> +     */
>> +    pcie_pmu->on_cpu = cpumask_local_spread(0, dev_to_node(pcie_pmu->dev));
>> +    ret = perf_pmu_register(&pcie_pmu->pmu, name, -1);
>> +    if (ret) {
>> +        pci_err(rp_info->pdev, "Error %d registering PMU @%x\n", ret,
>> +                 rp_info->bdf);
>> +        return ret;
>> +    }
>> +
>> +    rp_info->pmu_is_register = DWC_PCIE_PMU_HAS_REGISTER;
> 
> Seems a boolean type, and no need define another macro.

Yes, will change to boolean.
> 
>> +
>> +    return ret;
> 
> return 0;
> 

Will fix it.

>> +}
>> +
>> +static int dwc_pcie_pmu_remove(struct platform_device *pdev)
>> +{
>> +    struct dwc_pcie_pmu_priv *priv = platform_get_drvdata(pdev);
>> +    struct dwc_pcie_pmu *pcie_pmu;
>> +    struct dwc_pcie_rp_info *rp_info;
>> +
>> +    list_for_each_entry(rp_info, &priv->rp_infos, rp_node) {
>> +        if (rp_info->pmu_is_register) {
>> +            pcie_pmu = &rp_info->pcie_pmu;
>> +            perf_pmu_unregister(&pcie_pmu->pmu);
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int dwc_pcie_pmu_probe(struct platform_device *pdev)
>> +{
>> +    int ret;
>> +    struct dwc_pcie_pmu_priv *priv;
>> +    struct dwc_pcie_rp_info *rp_info;
>> +
>> +    priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +    if (!priv)
>> +        return -ENOMEM;
>> +
>> +    priv->dev = &pdev->dev;
>> +    platform_set_drvdata(pdev, priv);
>> +
>> +    /* If RAS_DES PMU is not supported on current platform, keep silent */
>> +    ret = dwc_pcie_ras_des_discover(priv);
>> +    if (ret)
>> +        return ret;
>> +
>> +    list_for_each_entry(rp_info, &priv->rp_infos, rp_node) {
>> +        struct pci_dev *rp = rp_info->pdev;
>> +
>> +        ret = __dwc_pcie_pmu_probe(priv, rp_info);
>> +        if (ret) {
>> +            dev_err(&rp->dev, "PCIe PMU probe fail\n");
>> +            goto pmu_unregister;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +
>> +pmu_unregister:
>> +    dwc_pcie_pmu_remove(pdev);
>> +
>> +    return ret;
>> +}
>> +
>> +static struct platform_driver dwc_pcie_pmu_driver = {
>> +    .probe = dwc_pcie_pmu_probe,
>> +    .remove = dwc_pcie_pmu_remove,
>> +    .driver = {.name = "dwc_pcie_pmu",},
>> +};
>> +
>> +static int __init dwc_pcie_pmu_init(void)
>> +{
>> +    int ret;
>> +
>> +    ret = platform_driver_register(&dwc_pcie_pmu_driver);
>> +
>> +    if (ret)
>> +        return ret;
>> +
>> +    dwc_pcie_pmu_dev =
>> +        platform_device_register_simple("dwc_pcie_pmu", -1, NULL, 0);
> 
> You can use PLATFORM_DEVID_NONE macro instead of the magic number '-1'.
> 

Good catch, will use PLATFORM_DEVID_NONE.

>> +    if (IS_ERR(dwc_pcie_pmu_dev)) {
>> +        platform_driver_unregister(&dwc_pcie_pmu_driver);
>> +        return PTR_ERR(dwc_pcie_pmu_dev);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void __exit dwc_pcie_pmu_exit(void)
>> +{
>> +    platform_device_unregister(dwc_pcie_pmu_dev);
>> +    platform_driver_unregister(&dwc_pcie_pmu_driver);
>> +}
>> +
>> +module_init(dwc_pcie_pmu_init);
>> +module_exit(dwc_pcie_pmu_exit);
>> +
>> +MODULE_DESCRIPTION("PMU driver for DesignWare Cores PCI Express Controller");
>> +MODULE_AUTHOR("xueshuai@linux.alibaba.com");
> 
> Please correct the format for module author:
> MODULE_AUTHOR("Xue Shuai <xueshuai@linux.alibaba.com>");

Will fix it.

> 
>> +MODULE_AUTHOR("yinxuan_cw@linux.alibaba.com");
>> +MODULE_LICENSE("GPL v2");


Thank you for your comments :)

Best Regards,
Shuai
