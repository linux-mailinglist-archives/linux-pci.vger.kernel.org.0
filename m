Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C1F5E7C26
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 15:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiIWNpf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 09:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiIWNpd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 09:45:33 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136B79E0FD;
        Fri, 23 Sep 2022 06:45:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VQX7UDK_1663940723;
Received: from 30.240.121.51(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VQX7UDK_1663940723)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 21:45:25 +0800
Message-ID: <d4edc6f4-e56f-4a19-3c34-b65d4903bfc0@linux.alibaba.com>
Date:   Fri, 23 Sep 2022 21:45:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v1 2/3] drivers/perf: add DesignWare PCIe PMU driver
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
 <20220917121036.14864-3-xueshuai@linux.alibaba.com>
 <20220922165820.000017b6@huawei.com>
Content-Language: en-US
In-Reply-To: <20220922165820.000017b6@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

在 2022/9/22 PM11:58, Jonathan Cameron 写道:
> On Sat, 17 Sep 2022 20:10:35 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
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
>>   low-power LTSSM state)
>> - Event counters (Error and Non-Error for lanes)
>>
>> Note, only one counter for each type.
>>
>> This driver add PMU devices for each PCIe Root Port. And the PMU device is
>> named based the BDF of Root Port. For example,
>>
>>     10:00.0 PCI bridge: Device 1ded:8000 (rev 01)
>>
>> the PMU device name for this Root Port is pcie_bdf_100000.
>>
>> Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
>>
>>     $# perf stat -a -e pcie_bdf_200/Rx_PCIe_TLP_Data_Payload/
>>
>> average RX bandwidth can be calculated like this:
>>
>>     PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> +CC linux-pci list and Bjorn.
> 
> Question in here which I've been meaning to address for other reasons
> around how to register 'extra features' on pci ports.
> 
> This particular PMU is in config space in a Vendor Specific Extended
> Capability.
> 
> I've focused on that aspect for this review rather than the perf parts.
> We'll need to figure that story out first as doing this from a bus walk
> makes triggered of a platform driver is not the way I'd expect to see
> this work.

Thank you for your valuable comments. Please see my reply inline.

Best Regards,
Shuai

>> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
>> new file mode 100644
>> index 000000000000..81e534be13fa
>> --- /dev/null
>> +++ b/drivers/perf/dwc_pcie_pmu.c
>> @@ -0,0 +1,976 @@
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
>> +
>> +#define DRV_NAME				"dwc_pcie_pmu"
>> +#define DEV_NAME				"dwc_pcie_pmu"
> Put these strings where they are used.  That's where people will look for them...

Got it. Will use strings directly in next version.

> 
>> +#define RP_NUM_MAX				32 /* 2die * 4RC * 4Ctrol */
> 
> This driver is 'almost' generic. So if you an avoid defines based on a particular
> platform that's definitely good!

Good idea. How about defining RP_NUM_MAX as 64? As fars as I know,
some platfrom use 2 sockets, 2 die per socket.
Then 2 sockets * 2 dies * 4 Root Complex * 4 root port.

> 
>> +#define ATTRI_NAME_MAX_SIZE			32
>> +
>> +#define DWC_PCIE_VSEC_ID			0x02
>> +#define DWC_PCIE_VSEC_REV			0x04
> 
> I wouldn't define the REV like this. Put the number inline so we
> can clearly see this is revision 4.  VSEC_ID won't change so a
> define for that is fine.

I see. I will use 0x04 instead REV macro in next version.

>> +
>> +#define DWC_PCIE_LINK_CAPABILITIES_REG		0xC
> This is PCIE spec defined.  Put these in a common header.

Good catch, I will fix in next version.

>> +#define DWC_PCIE_LANE_SHIFT			4
>> +#define DWC_PCIE_LANE_MASK			GENMASK(9, 4)
>> +
>> +#define DWC_PCIE_EVENT_CNT_CTRL			0x8
>> +#define DWC_PCIE__CNT_EVENT_SELECT_SHIFT	16
> 
> Why double __?  If point is , then
> naming works better
> DWC_PCIE_EVENT_CNT_CTRL_REG
> DWC_PCIE_EVENT_CNT_CTRL_EV_SELECT_MSK etc

Yes, I point to use double `__` to indicate it is a field of register,
as CMN and CCN drivers do. I also considered naming with REG explicitly,
but the macro is so long that I often have to wrap code into multilines.
Any way, it's fine to rename if you still suggest to do so.

> 
>> +#define DWC_PCIE__CNT_EVENT_SELECT_MASK		GENMASK(27, 16)
>> +#define DWC_PCIE__CNT_LANE_SELECT_SHIFT		8
>> +#define DWC_PCIE__CNT_LANE_SELECT_MASK		GENMASK(11, 8)
>> +#define DWC_PCIE__CNT_STATUS_SHIFT		7
>> +#define DWC_PCIE__CNT_STATUS_MASK		BIT(7)
>> +#define DWC_PCIE__CNT_ENABLE_SHIFT		2
> 
> With FIELD_PREP() / FIELD_GET() you should never need to define the shifts.
> They will be extracted from the masks as needed.
> 
>> +#define DWC_PCIE__CNT_ENABLE_MASK		GENMASK(4, 2)
>> +#define DWC_PCIE_PER_EVENT_OFF			(0x1 << DWC_PCIE__CNT_ENABLE_SHIFT)
> FIELD_PREP() / FIELD_GET() combined with defines for the values.
> 
> #define DWC_PCIE_CNT_ENABLE_MASK ...

Got it, I will use FIELD_PREP() / FIELD_GET() to remove SHIFT micros
and improve code readability.

> 
>> +#define DWC_PCIE_PER_EVENT_ON			(0x3 << DWC_PCIE__CNT_ENABLE_SHIFT)
>> +#define DWC_PCIE_EVENT_CLEAR_MASK		GENMASK(1, 0)
>> +
>> +#define DWC_PCIE_EVENT_CNT_DATA			0xC
>> +
>> +#define DWC_PCIE_TIME_BASED_ANALYSIS_CTRL	0x10
>> +#define DWC_PCIE__TIME_BASED_REPORT_SELECT_SHIFT	24
>> +#define DWC_PCIE__TIME_BASED_REPORT_SELECT_MASK	GENMASK(31, 24)
>> +#define DWC_PCIE__TIME_BASED_DURATION_SHIFT	8
>> +#define DWC_PCIE__TIME_BASED_DURATION_SELECT	GENMASK(15, 8)
>> +#define DWC_PCIE_DURATION_MANUAL_CTRL		0x0
>> +#define DWC_PCIE_DURATION_1MS			0x1
>> +#define DWC_PCIE_DURATION_10MS			0x2
>> +#define DWC_PCIE_DURATION_100MS			0x3
>> +#define DWC_PCIE_DURATION_1S			0x4
>> +#define DWC_PCIE_DURATION_2S			0x5
>> +#define DWC_PCIE_DURATION_4S			0x6
>> +#define DWC_PCIE_DURATION_4US			0xff
>> +#define DWC_PCIE__TIME_BASED_COUNTER_ENABLE	1
>> +
>> +#define DWC_PCIE_TIME_BASED_ANALYSIS_DATA_REG_LOW	0x14
>> +#define DWC_PCIE_TIME_BASED_ANALYSIS_DATA_REG_HIGH	0x18
>> +
>> +/* Event attributes */
>> +#define DWC_PCIE_CONFIG_EVENTID			GENMASK(15, 0)
>> +#define DWC_PCIE_CONFIG_TYPE			GENMASK(19, 16)
>> +#define DWC_PCIE_CONFIG_LANE			GENMASK(27, 20)
>> +
>> +#define DWC_PCIE_EVENT_ID(event)	FIELD_GET(DWC_PCIE_CONFIG_EVENTID, (event)->attr.config)
>> +#define DWC_PCIE_EVENT_TYPE(event)	FIELD_GET(DWC_PCIE_CONFIG_TYPE, (event)->attr.config)
>> +#define DWC_PCIE_EVENT_LANE(event)	FIELD_GET(DWC_PCIE_CONFIG_LANE, (event)->attr.config)
>> +
>> +#define DWC_PCIE_PMU_HAS_REGISTER		1
>> +
>> +enum dwc_pcie_event_type {
>> +	DWC_PCIE_TYPE_INVALID,
>> +	DWC_PCIE_TIME_BASE_EVENT,
>> +	DWC_PCIE_LANE_EVENT,
>> +};
>> +
>> +struct dwc_event_counters {
>> +	const char name[32];
>> +	u32 event_id;
>> +};
>> +
>> +struct dwc_pcie_pmu {
>> +	struct hlist_node node;
>> +	unsigned int on_cpu;
>> +	struct pmu pmu;
>> +	struct device *dev;
>> +};
>> +
>> +struct dwc_pcie_info_table {
>> +	u32 bdf;
>> +	u32 cap_pos;
>> +	u32 num_lanes;
>> +	struct pci_dev *pdev;
>> +	struct dwc_pcie_pmu pcie_pmu;
>> +	u8 pmu_is_register;
>> +	struct perf_event *event;
>> +
>> +	struct dwc_pcie_event_attr *lane_event_attrs;
>> +	struct attribute **pcie_pmu_event_attrs;
>> +	struct attribute_group pcie_pmu_event_attrs_group;
>> +	const struct attribute_group *pcie_pmu_attr_groups[4];
>> +};
>> +
>> +struct dwc_pcie_pmu_priv {
>> +	struct device *dev;
>> +	u32 pcie_ctrl_num;
>> +	struct dwc_pcie_info_table *pcie_table;
>> +};
>> +
>> +#define DWC_PCIE_CREATE_BDF(seg, bus, dev, func)	\
>> +	(((seg) << 24) | (((bus) & 0xFF) << 16) | (((dev) & 0xFF) << 8) | (func))
> 
> Superficially this looks pretty standard.  Why is is DWC specific?

You are right, it is not DWC specific.

I found a similar definition in arch/ia64/pci/pci.c .

	#define PCI_SAL_ADDRESS(seg, bus, devfn, reg)		\
	(((u64) seg << 24) | (bus << 16) | (devfn << 8) | (reg))

Should we move it into a common header first?

> 
>> +#define to_pcie_pmu(p) (container_of(p, struct dwc_pcie_pmu, pmu))
> 
> Prefix that name.  I'm hopeful we'll have a PCI SIG defined PMU one
> day and when we do that macro belongs to that!
> to_dwc_pcie_pmu() is possibly fine.

I entirely agree that a standard definition is preferred.
Will use to_dwc_pcie_pmu instead in next version.

> 
>> +
>> +static struct platform_device *dwc_pcie_pmu_dev;
>> +static char *event_attr_name = "events";
>> +
> 
> 
> ...
> 
>> +
>> +static int dwc_pcie_find_ras_des_cap_position(struct pci_dev *pdev, int *pos)
>> +{
>> +	u32 header;
>> +	int vsec = 0;
>> +
>> +	while ((vsec = pci_find_next_ext_capability(pdev, vsec,
>> +						    PCI_EXT_CAP_ID_VNDR))) {
> 
> This probably belongs in the PCI core in a similar fashion to the DVSEC
> helper.
> 
>> +		pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &header);
>> +		/* Is the device part of a DesignWare Cores PCIe Controller ? */
> 
> Good question... This code doesn't check that.  VSEC ID is matched only with
> the Vendor ID of the devices - unlike DVSEC where this would all be nice
> and local.

I think a similar fashion is

	u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)

As you see, I don't want to limit this driver to a specific vendor, like
Alibaba (0x1ded), because this driver is generic to all DesignWare Cores PCIe
Controller. Therefore, dwc_pcie_find_ras_des_cap_position does not check vendor
like pci_find_vsec_capability.

Do you mean to use DVSEC instead? I try to read out DVSEC with lspci:

    # lspci -vvv
    b0:00.0 PCI bridge: Alibaba (China) Co., Ltd. M1 Root Port (rev 01) (prog-if 00 [Normal decode])
    [...snip...]
        Capabilities: [374 v1] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
        Capabilities: [474 v1] Vendor Specific Information: ID=0001 Rev=1 Len=038 <?>
        Capabilities: [4ac v1] Data Link Feature <?>
        Capabilities: [4b8 v1] Designated Vendor-Specific: Vendor=0001 ID=0000 Rev=1 Len=64 <?>
        Capabilities: [4fc v1] Vendor Specific Information: ID=0005 Rev=1 Len=018 <?>

How can we tell it's a DesignWare Cores PCIe Controller?


>> +		if (PCI_VNDR_HEADER_ID(header) == DWC_PCIE_VSEC_ID &&
>> +		    PCI_VNDR_HEADER_REV(header) == DWC_PCIE_VSEC_REV) {
>> +			*pos = vsec;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return -ENODEV;
>> +}
>> +
>> +static int dwc_pcie_pmu_discover(struct dwc_pcie_pmu_priv *priv)
>> +{
>> +	int val, where, index = 0;
>> +	struct pci_dev *pdev = NULL;
>> +	struct dwc_pcie_info_table *pcie_info;
>> +
>> +	priv->pcie_table =
>> +	    devm_kcalloc(priv->dev, RP_NUM_MAX, sizeof(*pcie_info), GFP_KERNEL);
>> +	if (!priv->pcie_table)
>> +		return -EINVAL;
>> +
>> +	pcie_info = priv->pcie_table;
>> +	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL &&
>> +	       index < RP_NUM_MAX) {
> 
> This having a driver than then walks the pci topology to find root ports and add
> extra stuff to them is not a clean solution.
> 
> The probing should be driven from the existing PCI driver topology.
> There are a bunch of new features we need to add to ports in the near future
> anyway - this would just be another one.
> Same problem exists for CXL CPMU perf devices - so far we only support those
> on end points, partly because we need a clean way to probe them on pci ports.
> 
> Whatever we come up with there will apply here as well.

I see your point. Any link to reference?

> 
>> +		if (!pci_dev_is_rootport(pdev))
>> +			continue;
>> +
>> +		pcie_info[index].bdf = dwc_pcie_get_bdf(pdev);
>> +		pcie_info[index].pdev = pdev;
> Probably want a sanity check this has a vendor ID appropriate the VSEC you are about
> to look for.

If I check the vendor ID here or in dwc_pcie_find_ras_des_cap_position, this driver
will only work for Alibaba as I mentioned before.

> 
>> +
>> +		if (dwc_pcie_find_ras_des_cap_position(pdev, &where))
>> +			continue;
>> +
>> +		pcie_info[index].cap_pos = where;
>> +
>> +		pci_read_config_dword(pdev,
>> +				pdev->pcie_cap + DWC_PCIE_LINK_CAPABILITIES_REG,
>> +				&val);
>> +		pcie_info[index].num_lanes =
>> +			(val & DWC_PCIE_LANE_MASK) >> DWC_PCIE_LANE_SHIFT;
> 
> FIELD_GET()

Will fix in next version.

> 
>> +		index++;
>> +	}
>> +
>> +	if (!index)
>> +		return -ENODEV;
>> +
>> +	priv->pcie_ctrl_num = index;
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int dwc_pcie_pmu_read_dword(struct dwc_pcie_info_table *pcie_info,
>> +					  u32 reg, u32 *val)
>> +{
>> +	return pci_read_config_dword(pcie_info->pdev, pcie_info->cap_pos + reg,
>> +				     val);
>> +}
>> +
>> +static inline int dwc_pcie_pmu_write_dword(struct dwc_pcie_info_table
>> +					   *pcie_info, u32 reg, u32 val)
>> +{
>> +	return pci_write_config_dword(pcie_info->pdev, pcie_info->cap_pos + reg,
>> +				      val);
>> +}
> 
> These two wrappers don't add a lot so I would drop them.

I see, I will use pci_{write/read}_config_dword directly.

> 
>> +
>> +static int dwc_pcie_pmu_set_event_id(struct dwc_pcie_info_table *pcie_info,
>> +				     int event_id)
>> +{
>> +	int ret;
>> +	u32 val;
>> +
>> +	ret = dwc_pcie_pmu_read_dword(pcie_info, DWC_PCIE_EVENT_CNT_CTRL, &val);
>> +	if (ret) {
>> +		pci_err(pcie_info->pdev, "PCIe read fail\n");
>> +		return ret;
>> +	}
>> +
>> +	val &= ~DWC_PCIE__CNT_ENABLE_MASK;
>> +	val &= ~DWC_PCIE__CNT_EVENT_SELECT_MASK;
>> +	val |= event_id << DWC_PCIE__CNT_EVENT_SELECT_SHIFT;
> 
> FIELD_PREP()

Will fix in next version.


>> +
>> +	ret = dwc_pcie_pmu_write_dword(pcie_info, DWC_PCIE_EVENT_CNT_CTRL, val);
>> +	if (ret)
>> +		pci_err(pcie_info->pdev, "PCIe write fail\n");
>> +
>> +	return ret;
>> +}
> 
> ...
> 
>> +
>> +static int dwc_pcie_pmu_read_base_time_counter(struct dwc_pcie_info_table
>> +					       *pcie_info, u64 *counter)
>> +{
>> +	u32 ret, val;
>> +
>> +	ret = dwc_pcie_pmu_read_dword(pcie_info,
>> +				      DWC_PCIE_TIME_BASED_ANALYSIS_DATA_REG_HIGH,
>> +				      &val);
>> +	if (ret) {
>> +		pci_err(pcie_info->pdev, "PCIe read fail\n");
>> +		return ret;
>> +	}
>> +
>> +	*counter = val;
>> +	*counter <<= 32;
> 
> This looks like you could get ripping between the upper and lower dwords.
> What prevents that? Perhaps a comment to say why that's not a problem?

The Time-based Analysis Data which contains the measurement results of
RX/TX data throughput and time spent in each low-power LTSSM state is 64 bit.
The data is provided by two 32 bit registers so I rip them together. I will
add a comment here in next verison.

> 
>> +
>> +	ret = dwc_pcie_pmu_read_dword(pcie_info,
>> +				      DWC_PCIE_TIME_BASED_ANALYSIS_DATA_REG_LOW,
>> +				      &val);
>> +	if (ret) {
>> +		pci_err(pcie_info->pdev, "PCIe read fail\n");
>> +		return ret;
>> +	}
>> +
>> +	*counter += val;
>> +
>> +	return ret;
>> +}
> ...
> 
> 
>> +static int __dwc_pcie_pmu_probe(struct dwc_pcie_pmu_priv *priv,
>> +				struct dwc_pcie_info_table *pcie_info)
>> +{
>> +	int ret;
>> +	char *name;
>> +	struct dwc_pcie_pmu *pcie_pmu;
>> +	struct device *dev;
>> +
>> +	if (!pcie_info || !pcie_info->pdev) {
>> +		pci_err(pcie_info->pdev, "Input parameter is invalid\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	pcie_pmu = &pcie_info->pcie_pmu;
>> +	dev = &pcie_info->pdev->dev;
>> +
>> +	ret = dwc_pcie_pmu_attr_init(priv, pcie_info);
>> +	if (ret) {
>> +		pci_err(pcie_info->pdev, "PMU attr init fail ret=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	pcie_pmu->dev = dev;
>> +	pcie_pmu->pmu = (struct pmu) {
>> +		.module		= THIS_MODULE,
>> +		.task_ctx_nr	= perf_invalid_context,
>> +		.pmu_enable	= NULL,
>> +		.pmu_disable	= NULL,
>> +		.event_init	= dwc_pcie_pmu_event_init,
>> +		.add		= dwc_pcie_pmu_event_add,
>> +		.del		= dwc_pcie_pmu_event_del,
>> +		.start		= dwc_pcie_pmu_event_start,
>> +		.stop		= dwc_pcie_pmu_event_stop,
>> +		.read		= dwc_pcie_pmu_event_read,
>> +		.attr_groups	= pcie_info->pcie_pmu_attr_groups,
>> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>> +	};
>> +
>> +	name = devm_kasprintf(priv->dev, GFP_KERNEL, "pcie_bdf_%x",
>> +			      pcie_info->bdf);
>> +	if (!name)
>> +		return -ENOMEM;
>> +
>> +	/* Pick one CPU to be the preferred one to use */
>> +	pcie_pmu->on_cpu = raw_smp_processor_id();
> Above there are references to multiple dies.  Maybe at least make sure you
> are on a near by die? (I'm guessing at topology!)

Good idea, will fix in next version.

>> +
>> +	ret = perf_pmu_register(&pcie_pmu->pmu, name, -1);
>> +	if (ret) {
>> +		pci_err(pcie_info->pdev, "Error %d registering PMU @%x\n", ret,
>> +				 pcie_info->bdf);
>> +		return ret;
>> +	}
>> +
>> +	pcie_info->pmu_is_register = DWC_PCIE_PMU_HAS_REGISTER;
> 
> As below. I think you can drop this state info.

Please see my confusion bellow.

> 
>> +
>> +	return ret;
>> +}
>> +
>> +static int dwc_pcie_pmu_remove(struct platform_device *pdev)
>> +{
>> +	struct dwc_pcie_pmu_priv *priv = platform_get_drvdata(pdev);
>> +	int index;
>> +	struct dwc_pcie_pmu *pcie_pmu;
>> +
>> +	for (index = 0; index < priv->pcie_ctrl_num; index++)
>> +		if (priv->pcie_table[index].pmu_is_register) {
>> +			pcie_pmu = &priv->pcie_table[index].pcie_pmu;
>> +			perf_pmu_unregister(&pcie_pmu->pmu);
>> +		}
>> +	return 0;
>> +}
>> +
>> +static int dwc_pcie_pmu_probe(struct platform_device *pdev)
>> +{
>> +	int ret = 0;
> 
> Initialized in all paths where it is used. Compiler should be able to tell
> that so I doubt you need this to be set to 0 here.

Agree, will leave it as uninitialized.

> 
>> +	int pcie_index;
>> +	struct dwc_pcie_pmu_priv *priv;
>> +
>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +	priv->dev = &pdev->dev;
>> +	platform_set_drvdata(pdev, priv);
>> +
>> +	/* If PMU is not support on current platform, keep slient */
>> +	if (dwc_pcie_pmu_discover(priv))
>> +		return 0;
>> +
>> +	for (pcie_index = 0; pcie_index < priv->pcie_ctrl_num; pcie_index++) {
>> +		struct pci_dev *rp = priv->pcie_table[pcie_index].pdev;
>> +
>> +		ret = __dwc_pcie_pmu_probe(priv, &priv->pcie_table[pcie_index]);
>> +		if (ret) {
>> +			dev_err(&rp->dev, "PCIe PMU probe fail\n");
>> +			goto pmu_unregister;
>> +		}
>> +	}
>> +	dev_info(&pdev->dev, "PCIe PMUs registered\n");
> 
> Noise in the logs.  There are lots of ways to know if we reached this point
> so this adds no value.

Got it, will drop this out in next version.

> 
>> +
>> +	return 0;
>> +
>> +pmu_unregister:
>> +	dwc_pcie_pmu_remove(pdev);
> 
> I'd much rather see the unwind here directly so we can clearly see that it undoes
> the result of errors in this function.  That removes the need to use the
> is_registered flag in the remove() function simplifying that flow as well.

Do you mean that if perf_pmu_register fails, then jump to pmu_unregister lable directly?
How can we tell which PMU diveice fails to reigister?

>> +
>> +	return ret;
>> +}
>> +
>> +static struct platform_driver dwc_pcie_pmu_driver = {
>> +	.probe = dwc_pcie_pmu_probe,
>> +	.remove = dwc_pcie_pmu_remove,
>> +	.driver = {.name = DRV_NAME,},
> More common to format as
> 	.driver = {
> 		.name = "dwc_pcie_pmu",
> 	},
> };
> Note use of string here.  Using a define just forces people to
> look for this in the wrong place.

I see, will use string here in next version.

> 
>> +};
>> +
>> +static int __init dwc_pcie_pmu_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = platform_driver_register(&dwc_pcie_pmu_driver);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	dwc_pcie_pmu_dev =
>> +	    platform_device_register_simple(DEV_NAME, -1, NULL, 0);
> 
> I'd normally expect to see the device created as a result of firmware
> description (ACPI DSDT / or Device tree)
> It is unusual to create a 'real' device directly in the driver
> init - that's normally reserved for various fake / software devices.

I see your concerns. You mentioned that

   > The probing should be driven from the existing PCI driver topology.

Should we add a fake device in firmware or drive from PCI driver topology?

Thank you.

Best Regards,
Shuai

>> +	if (IS_ERR(dwc_pcie_pmu_dev)) {
>> +		platform_driver_unregister(&dwc_pcie_pmu_driver);
>> +		return PTR_ERR(dwc_pcie_pmu_dev);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit dwc_pcie_pmu_exit(void)
>> +{
>> +	platform_device_unregister(dwc_pcie_pmu_dev);
>> +	platform_driver_unregister(&dwc_pcie_pmu_driver);
>> +}
>> +
>> +module_init(dwc_pcie_pmu_init);
>> +module_exit(dwc_pcie_pmu_exit);
>> +
>> +MODULE_DESCRIPTION("PMU driver for DesignWare Cores PCI Express Controller");
>> +MODULE_AUTHOR("xueshuai@linux.alibaba.com");
>> +MODULE_AUTHOR("yinxuan_cw@linux.alibaba.com");
>> +MODULE_LICENSE("GPL v2");
