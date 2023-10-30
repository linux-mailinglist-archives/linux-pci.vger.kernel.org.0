Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D547DB34D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 07:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjJ3Gai (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 02:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjJ3GaV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 02:30:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D859C5;
        Sun, 29 Oct 2023 23:29:58 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U4cDTi017459;
        Mon, 30 Oct 2023 06:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=e9KvG323j2fmGOp4bosSzage62Y0TObtFpeonjUJno0=;
 b=X7RBUz9ZUIEXZbrEQzrK/FC/Cotr+hEjAJuiaOVh5Iy5r1RGU4ShghRPnJW5Iqjnso6q
 wrjPfnoINj8fQC9/8Vd45FCDJA1QKN+wS0/e2JNKH+69CNoRnQSeK4Mp82GRRonO08w7
 e+mttl001uVOuTCNRPXScnIxxT2HqCoBQEA+0sALb0onyVdQanUCqcSVgWBRhpXXU7R8
 FZSDJREwPEwFOvejbZY6IwqpUuf0cFvIhdj8CBcDjsJjrQU+BtcS0TVfNZxos6f+akMw
 ucMjsXDLPF5Z9BIhUDmRE3J6jALYzjy82KMv0XZRsu5lgdH343PvX2WCh5IHyRhA7rmN Xg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0u2qjwkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 06:28:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39U6Sd7h026412
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 06:28:39 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 29 Oct
 2023 23:28:33 -0700
Message-ID: <8af04f14-87ae-87aa-7187-55d5450b6d74@quicinc.com>
Date:   Mon, 30 Oct 2023 11:58:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v9 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        <chengyou@linux.alibaba.com>, <kaishen@linux.alibaba.com>,
        <helgaas@kernel.org>, <yangyicong@huawei.com>, <will@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <baolin.wang@linux.alibaba.com>,
        <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <rdunlap@infradead.org>,
        <mark.rutland@arm.com>, <zhuo.song@linux.alibaba.com>,
        <renyu.zj@linux.alibaba.com>
References: <20231020134230.53342-1-xueshuai@linux.alibaba.com>
 <20231020134230.53342-4-xueshuai@linux.alibaba.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20231020134230.53342-4-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Nb1mNQ2JZdPW0VWIYVNRwRtE_1HcjkRh
X-Proofpoint-GUID: Nb1mNQ2JZdPW0VWIYVNRwRtE_1HcjkRh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_04,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300046
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/20/2023 7:12 PM, Shuai Xue wrote:
> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> Core controller IP which provides statistics feature. The PMU is a PCIe
> configuration space register block provided by each PCIe Root Port in a
> Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
> injection, and Statistics).
>
> To facilitate collection of statistics the controller provides the
> following two features for each Root Port:
>
> - one 64-bit counter for Time Based Analysis (RX/TX data throughput and
>    time spent in each low-power LTSSM state) and
> - one 32-bit counter for Event Counting (error and non-error events for
>    a specified lane)
>
> Note: There is no interrupt for counter overflow.
>
> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
> named based the BDF of Root Port. For example,
>
>      30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>
> the PMU device name for this Root Port is dwc_rootport_3018.
>
> Example usage of counting PCIe RX TLP data payload (Units of bytes)::
>
>      $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>
> average RX bandwidth can be calculated like this:
>
>      PCIe TX Bandwidth = Rx_PCIe_TLP_Data_Payload / Measure_Time_Window
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>   drivers/perf/Kconfig        |   7 +
>   drivers/perf/Makefile       |   1 +
>   drivers/perf/dwc_pcie_pmu.c | 770 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 778 insertions(+)
>   create mode 100644 drivers/perf/dwc_pcie_pmu.c
>
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 273d67ecf6d2..ec6e0d9194a1 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -217,6 +217,13 @@ config MARVELL_CN10K_DDR_PMU
>   	  Enable perf support for Marvell DDR Performance monitoring
>   	  event on CN10K platform.
>   
> +config DWC_PCIE_PMU
> +	tristate "Synopsys DesignWare PCIe PMU"
> +	depends on PCI
> +	help
> +	  Enable perf support for Synopsys DesignWare PCIe PMU Performance
> +	  monitoring event on platform including the Alibaba Yitian 710.
> +
>   source "drivers/perf/arm_cspmu/Kconfig"
>   
>   source "drivers/perf/amlogic/Kconfig"
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 16b3ec4db916..a06338e3401c 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
>   obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
>   obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
>   obj-$(CONFIG_ALIBABA_UNCORE_DRW_PMU) += alibaba_uncore_drw_pmu.o
> +obj-$(CONFIG_DWC_PCIE_PMU) += dwc_pcie_pmu.o
>   obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
>   obj-$(CONFIG_MESON_DDR_PMU) += amlogic/
>   obj-$(CONFIG_CXL_PMU) += cxl_pmu.o
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> new file mode 100644
> index 000000000000..ddb06d763b0c
> --- /dev/null
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -0,0 +1,770 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synopsys DesignWare PCIe PMU driver
> + *
> + * Copyright (C) 2021-2023 Alibaba Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/perf_event.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/smp.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#define DWC_PCIE_VSEC_RAS_DES_ID		0x02
> +#define DWC_PCIE_EVENT_CNT_CTL			0x8
> +
> +/*
> + * Event Counter Data Select includes two parts:
> + * - 27-24: Group number(4-bit: 0..0x7)
> + * - 23-16: Event number(8-bit: 0..0x13) within the Group
> + *
> + * Put them together as in TRM.
> + */
> +#define DWC_PCIE_CNT_EVENT_SEL			GENMASK(27, 16)
> +#define DWC_PCIE_CNT_LANE_SEL			GENMASK(11, 8)
> +#define DWC_PCIE_CNT_STATUS			BIT(7)
> +#define DWC_PCIE_CNT_ENABLE			GENMASK(4, 2)
> +#define DWC_PCIE_PER_EVENT_OFF			0x1
> +#define DWC_PCIE_PER_EVENT_ON			0x3
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
> +#define DWC_PCIE_DURATION_4US			0xFF
> +#define DWC_PCIE_TIME_BASED_TIMER_START		BIT(0)
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
> +	DWC_PCIE_TIME_BASE_EVENT,
> +	DWC_PCIE_LANE_EVENT,
> +	DWC_PCIE_EVENT_TYPE_MAX,
> +};
> +
> +#define DWC_PCIE_LANE_EVENT_MAX_PERIOD		GENMASK_ULL(31, 0)
> +#define DWC_PCIE_TIME_BASED_EVENT_MAX_PERIOD	GENMASK_ULL(63, 0)
> +
> +struct dwc_pcie_pmu {
> +	struct pmu		pmu;
> +	struct pci_dev		*pdev;		/* Root Port device */
> +	u16			ras_des_offset;
> +	u32			nr_lanes;
> +
> +	struct list_head	pmu_node;
> +	struct hlist_node	cpuhp_node;
> +	struct perf_event	*event[DWC_PCIE_EVENT_TYPE_MAX];
> +	int			on_cpu;
> +	bool			registered;
> +};
> +
> +#define to_dwc_pcie_pmu(p) (container_of(p, struct dwc_pcie_pmu, pmu))
> +
> +static struct platform_device *dwc_pcie_pmu_dev;
> +static int dwc_pcie_pmu_hp_state;
> +static struct list_head dwc_pcie_pmu_head = LIST_HEAD_INIT(dwc_pcie_pmu_head);
> +
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
> +static struct attribute_group dwc_pcie_cpumask_attr_group = {
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
> +	return sysfs_emit(buf, "config:%d-%d\n", lo, hi);
> +}
> +
> +#define _dwc_pcie_format_attr(_name, _cfg, _fld)			    \
> +	(&((struct dwc_pcie_format_attr[]) {{				    \
> +		.attr = __ATTR(_name, 0444, dwc_pcie_pmu_format_show, NULL),\
> +		.config = _cfg,						    \
> +		.field = _fld,						    \
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
> +static struct attribute_group dwc_pcie_format_attrs_group = {
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
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct dwc_pcie_event_attr *eattr;
> +
> +	eattr = container_of(attr, typeof(*eattr), attr);
> +
> +	if (eattr->type == DWC_PCIE_LANE_EVENT)
> +		return sysfs_emit(buf, "eventid=0x%x,type=0x%x,lane=?\n",
> +				  eattr->eventid, eattr->type);
> +	else if (eattr->type == DWC_PCIE_TIME_BASE_EVENT)
> +		return sysfs_emit(buf, "eventid=0x%x,type=0x%x\n",
> +				  eattr->eventid, eattr->type);
> +
> +	return 0;
> +}
> +
> +#define DWC_PCIE_EVENT_ATTR(_name, _type, _eventid, _lane)		\
> +	(&((struct dwc_pcie_event_attr[]) {{				\
> +		.attr = __ATTR(_name, 0444, dwc_pcie_event_show, NULL),	\
> +		.type = _type,						\
> +		.eventid = _eventid,					\
> +		.lane = _lane,						\
> +	}})[0].attr.attr)
> +
> +#define DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(_name, _eventid)		\
> +	DWC_PCIE_EVENT_ATTR(_name, DWC_PCIE_TIME_BASE_EVENT, _eventid, 0)
> +#define DWC_PCIE_PMU_LANE_EVENT_ATTR(_name, _eventid)			\
> +	DWC_PCIE_EVENT_ATTR(_name, DWC_PCIE_LANE_EVENT, _eventid, 0)
> +
> +static struct attribute *dwc_pcie_pmu_time_event_attrs[] = {
> +	/* Group #0 */
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(one_cycle, 0x00),
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(TX_L0S, 0x01),
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(RX_L0S, 0x02),
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L0, 0x03),
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1, 0x04),
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1_1, 0x05),
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1_2, 0x06),
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(CFG_RCVRY, 0x07),
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(TX_RX_L0S, 0x08),
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1_AUX, 0x09),
> +
> +	/* Group #1 */
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Tx_PCIe_TLP_Data_Payload, 0x20),
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Rx_PCIe_TLP_Data_Payload, 0x21),
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Tx_CCIX_TLP_Data_Payload, 0x22),
> +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Rx_CCIX_TLP_Data_Payload, 0x23),
> +
> +	/*
> +	 * Leave it to the user to specify the lane ID to avoid generating
> +	 * a list of hundreds of events.
> +	 */
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_ack_dllp, 0x600),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_update_fc_dllp, 0x601),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_ack_dllp, 0x602),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_update_fc_dllp, 0x603),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_nulified_tlp, 0x604),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_nulified_tlp, 0x605),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_duplicate_tl, 0x606),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_memory_write, 0x700),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_memory_read, 0x701),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_configuration_write, 0x702),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_configuration_read, 0x703),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_io_write, 0x704),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_io_read, 0x705),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_completion_without_data, 0x706),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_completion_with_data, 0x707),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_message_tlp, 0x708),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_atomic, 0x709),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_tlp_with_prefix, 0x70A),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_memory_write, 0x70B),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_memory_read, 0x70C),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_io_write, 0x70F),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_io_read, 0x710),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_completion_without_data, 0x711),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_completion_with_data, 0x712),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_message_tlp, 0x713),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_atomic, 0x714),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_tlp_with_prefix, 0x715),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_ccix_tlp, 0x716),
> +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_ccix_tlp, 0x717),
> +	NULL
> +};
> +
> +static const struct attribute_group dwc_pcie_event_attrs_group = {
> +	.name = "events",
> +	.attrs = dwc_pcie_pmu_time_event_attrs,
> +};
> +
> +static const struct attribute_group *dwc_pcie_attr_groups[] = {
> +	&dwc_pcie_event_attrs_group,
> +	&dwc_pcie_format_attrs_group,
> +	&dwc_pcie_cpumask_attr_group,
> +	NULL
> +};
> +
> +static void dwc_pcie_pmu_lane_event_enable(struct dwc_pcie_pmu *pcie_pmu,
> +					   bool enable)
> +{
> +	struct pci_dev *pdev = pcie_pmu->pdev;
> +	u16 ras_des_offset = pcie_pmu->ras_des_offset;
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL, &val);
> +
> +	/* Clear DWC_PCIE_CNT_ENABLE field first */
> +	val &= ~DWC_PCIE_CNT_ENABLE;
> +	if (enable)
> +		val |= FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_ON);
> +	else
> +		val |= FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_OFF);
> +
> +	pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL, val);
> +}
> +
> +static void dwc_pcie_pmu_time_based_event_enable(struct dwc_pcie_pmu *pcie_pmu,
> +					  bool enable)
> +{
> +	struct pci_dev *pdev = pcie_pmu->pdev;
> +	u16 ras_des_offset = pcie_pmu->ras_des_offset;
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_CTL,
> +			      &val);
> +
> +	if (enable)
> +		val |= DWC_PCIE_TIME_BASED_CNT_ENABLE;
> +	else
> +		val &= ~DWC_PCIE_TIME_BASED_CNT_ENABLE;
> +
> +	pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_CTL,
> +			       val);
> +}
> +
> +static u64 dwc_pcie_pmu_read_lane_event_counter(struct perf_event *event)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> +	struct pci_dev *pdev = pcie_pmu->pdev;
> +	u16 ras_des_offset = pcie_pmu->ras_des_offset;
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_DATA, &val);
> +
> +	return val;
> +}
> +
> +static u64 dwc_pcie_pmu_read_time_based_counter(struct perf_event *event)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> +	struct pci_dev *pdev = pcie_pmu->pdev;
> +	int event_id = DWC_PCIE_EVENT_ID(event);
> +	u16 ras_des_offset = pcie_pmu->ras_des_offset;
> +	u32 lo, hi, ss;
> +
> +	/*
> +	 * The 64-bit value of the data counter is spread across two
> +	 * registers that are not synchronized. In order to read them
> +	 * atomically, ensure that the high 32 bits match before and after
> +	 * reading the low 32 bits.
> +	 */
> +	pci_read_config_dword(pdev, ras_des_offset +
> +		DWC_PCIE_TIME_BASED_ANAL_DATA_REG_HIGH, &hi);
> +	do {
> +		/* snapshot the high 32 bits */
> +		ss = hi;
> +
> +		pci_read_config_dword(
> +			pdev, ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_DATA_REG_LOW,
> +			&lo);
> +		pci_read_config_dword(
> +			pdev, ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_DATA_REG_HIGH,
> +			&hi);
> +	} while (hi != ss);
> +
> +	/*
> +	 * The Group#1 event measures the amount of data processed in 16-byte
> +	 * units. Simplify the end-user interface by multiplying the counter
> +	 * at the point of read.
> +	 */
> +	if (event_id >= 0x20 && event_id <= 0x23)
> +		return (((u64)hi << 32) | lo) << 4;
> +	else
> +		return (((u64)hi << 32) | lo);
> +}
> +
> +static void dwc_pcie_pmu_event_update(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
> +	u64 delta, prev, now;
> +
> +	do {
> +		prev = local64_read(&hwc->prev_count);
> +
> +		if (type == DWC_PCIE_LANE_EVENT)
> +			now = dwc_pcie_pmu_read_lane_event_counter(event);
> +		else if (type == DWC_PCIE_TIME_BASE_EVENT)
> +			now = dwc_pcie_pmu_read_time_based_counter(event);
> +
> +	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
> +
> +	if (type == DWC_PCIE_LANE_EVENT)
> +		delta = (now - prev) & DWC_PCIE_LANE_EVENT_MAX_PERIOD;
> +	else if (type == DWC_PCIE_TIME_BASE_EVENT)
> +		delta = (now - prev) & DWC_PCIE_TIME_BASED_EVENT_MAX_PERIOD;
> +
> +	local64_add(delta, &event->count);
> +}
> +
> +static int dwc_pcie_pmu_event_init(struct perf_event *event)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
> +	struct perf_event *sibling;
> +	u32 lane;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/* We don't support sampling */
> +	if (is_sampling_event(event))
> +		return -EINVAL;
> +
> +	/* We cannot support task bound events */
> +	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK)
> +		return -EINVAL;
> +
> +	if (event->group_leader != event &&
> +	    !is_software_event(event->group_leader))
> +		return -EINVAL;
> +
> +	for_each_sibling_event(sibling, event->group_leader) {
> +		if (sibling->pmu != event->pmu && !is_software_event(sibling))
> +			return -EINVAL;
> +	}
> +
> +	if (type == DWC_PCIE_LANE_EVENT) {
> +		lane = DWC_PCIE_EVENT_LANE(event);
> +		if (lane < 0 || lane >= pcie_pmu->nr_lanes)
> +			return -EINVAL;
> +	}
> +
> +	event->cpu = pcie_pmu->on_cpu;
> +
> +	return 0;
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
> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
> +
> +	hwc->state = 0;
> +	dwc_pcie_pmu_set_period(hwc);
> +
> +	if (type == DWC_PCIE_LANE_EVENT)
> +		dwc_pcie_pmu_lane_event_enable(pcie_pmu, true);
> +	else if (type == DWC_PCIE_TIME_BASE_EVENT)
> +		dwc_pcie_pmu_time_based_event_enable(pcie_pmu, true);
> +}
> +
> +static void dwc_pcie_pmu_event_stop(struct perf_event *event, int flags)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (event->hw.state & PERF_HES_STOPPED)
> +		return;
> +
> +	if (type == DWC_PCIE_LANE_EVENT)
> +		dwc_pcie_pmu_lane_event_enable(pcie_pmu, false);
> +	else if (type == DWC_PCIE_TIME_BASE_EVENT)
> +		dwc_pcie_pmu_time_based_event_enable(pcie_pmu, false);
> +
> +	dwc_pcie_pmu_event_update(event);
> +	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +}
> +
> +static int dwc_pcie_pmu_event_add(struct perf_event *event, int flags)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> +	struct pci_dev *pdev = pcie_pmu->pdev;
> +	struct hw_perf_event *hwc = &event->hw;
> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
> +	int event_id = DWC_PCIE_EVENT_ID(event);
> +	int lane = DWC_PCIE_EVENT_LANE(event);
> +	u16 ras_des_offset = pcie_pmu->ras_des_offset;
> +	u32 ctrl;
> +
> +	/* one counter for each type and it is in use */
> +	if (pcie_pmu->event[type])
> +		return -ENOSPC;
> +
> +	pcie_pmu->event[type] = event;
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	if (type == DWC_PCIE_LANE_EVENT) {
> +		/* EVENT_COUNTER_DATA_REG needs clear manually */
> +		ctrl = FIELD_PREP(DWC_PCIE_CNT_EVENT_SEL, event_id) |
> +			FIELD_PREP(DWC_PCIE_CNT_LANE_SEL, lane) |
> +			FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_OFF) |
> +			FIELD_PREP(DWC_PCIE_EVENT_CLEAR, DWC_PCIE_EVENT_PER_CLEAR);
> +		pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
> +				       ctrl);
> +	} else if (type == DWC_PCIE_TIME_BASE_EVENT) {
> +		/*
> +		 * TIME_BASED_ANAL_DATA_REG is a 64 bit register, we can safely
> +		 * use it with any manually controlled duration. And it is
> +		 * cleared when next measurement starts.
> +		 */
> +		ctrl = FIELD_PREP(DWC_PCIE_TIME_BASED_REPORT_SEL, event_id) |
> +			FIELD_PREP(DWC_PCIE_TIME_BASED_DURATION_SEL,
> +				   DWC_PCIE_DURATION_MANUAL_CTL) |
> +			DWC_PCIE_TIME_BASED_CNT_ENABLE;
> +		pci_write_config_dword(
> +			pdev, ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_CTL, ctrl);
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
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
> +
> +	dwc_pcie_pmu_event_stop(event, flags | PERF_EF_UPDATE);
> +	perf_event_update_userpage(event);
> +	pcie_pmu->event[type] = NULL;
> +}
> +
> +static void dwc_pcie_pmu_remove_cpuhp_instance(void *hotplug_node)
> +{
> +	cpuhp_state_remove_instance_nocalls(dwc_pcie_pmu_hp_state, hotplug_node);
> +}
> +
> +/*
> + * Find the PMU of a PCI device.
> + * @pdev: The PCI device.
> + */
> +static struct dwc_pcie_pmu *dwc_pcie_find_dev_pmu(struct pci_dev *pdev)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu;
> +
> +	list_for_each_entry(pcie_pmu, &dwc_pcie_pmu_head, pmu_node)
> +		if (pcie_pmu->pdev == pdev)
> +			return pcie_pmu;
> +
> +	return NULL;
> +}
> +
> +static void dwc_pcie_pmu_unregister_pmu(void *data)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu = data;
> +
> +	if (!pcie_pmu->registered)
> +		return;
> +
> +	pcie_pmu->registered = false;
> +	list_del(&pcie_pmu->pmu_node);
> +	perf_pmu_unregister(&pcie_pmu->pmu);
> +}
> +
> +static int dwc_pcie_pmu_notifier(struct notifier_block *nb,
> +				     unsigned long action, void *data)
> +{
> +	struct device *dev = data;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct dwc_pcie_pmu *pcie_pmu;
> +
> +	/* Unregister the PMU when the device is going to be deleted. */
> +	if (action != BUS_NOTIFY_DEL_DEVICE)
> +		return NOTIFY_DONE;
> +
> +	pcie_pmu = dwc_pcie_find_dev_pmu(pdev);
> +	if (!pcie_pmu)
> +		return NOTIFY_DONE;
> +
> +	dwc_pcie_pmu_unregister_pmu(pcie_pmu);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block dwc_pcie_pmu_nb = {
> +	.notifier_call = dwc_pcie_pmu_notifier,
> +};
> +
> +static void dwc_pcie_pmu_unregister_nb(void *data)
> +{
> +	bus_unregister_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
> +}
> +
> +static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
> +{
> +	struct pci_dev *pdev = NULL;
> +	struct dwc_pcie_pmu *pcie_pmu;
> +	bool notify = false;
> +	char *name;
> +	u32 bdf;
> +	int ret;
> +
> +	/* Match the rootport with VSEC_RAS_DES_ID, and register a PMU for it */
> +	for_each_pci_dev(pdev) {
> +		u16 vsec;
> +		u32 val;
> +
> +		if (!(pci_is_pcie(pdev) &&
> +		      pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
> +			continue;
> +
> +		vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
> +						DWC_PCIE_VSEC_RAS_DES_ID);

We are searching for ALIBABA vendor only  for this capability.

Can we have a list of vendor ID's and we can check for all those vendors 
for this capability so that it will be easy to add new vendors in the list

something like this

struct vendor_ids {

int vendor_id;

};

struct vendor_ids dwc_ids[] = {

     {.vendor_id =PCI_VENDOR_ID_ALIBABA },

      {.vendor_id = XXX},

};

	for_each_pci_dev(pdev) {
		u16 vsec;
		u32 val;

		if (!(pci_is_pcie(pdev) &&
		      pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
			continue;
		for (int i = 0; i < num of elements of dwc_ids < i++) {
			---

		}
		
		---
	}

Thanks & Regards,
Krishna Chaitanya.

> +		if (!vsec)
> +			continue;
> +
> +		pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +		if (PCI_VNDR_HEADER_REV(val) != 0x04)
> +			continue;
> +		pci_dbg(pdev,
> +			"Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
> +
> +		bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
> +		name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x",
> +				      bdf);
> +		if (!name) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		/* All checks passed, go go go */
> +		pcie_pmu = devm_kzalloc(&plat_dev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
> +		if (!pcie_pmu) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		pcie_pmu->pdev = pdev;
> +		pcie_pmu->ras_des_offset = vsec;
> +		pcie_pmu->nr_lanes = pcie_get_width_cap(pdev);
> +		pcie_pmu->on_cpu = -1;
> +		pcie_pmu->pmu = (struct pmu){
> +			.module		= THIS_MODULE,
> +			.attr_groups	= dwc_pcie_attr_groups,
> +			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +			.task_ctx_nr	= perf_invalid_context,
> +			.event_init	= dwc_pcie_pmu_event_init,
> +			.add		= dwc_pcie_pmu_event_add,
> +			.del		= dwc_pcie_pmu_event_del,
> +			.start		= dwc_pcie_pmu_event_start,
> +			.stop		= dwc_pcie_pmu_event_stop,
> +			.read		= dwc_pcie_pmu_event_update,
> +		};
> +
> +		/* Add this instance to the list used by the offline callback */
> +		ret = cpuhp_state_add_instance(dwc_pcie_pmu_hp_state,
> +					       &pcie_pmu->cpuhp_node);
> +		if (ret) {
> +			pci_err(pdev,
> +				"Error %d registering hotplug @%x\n", ret, bdf);
> +			goto out;
> +		}
> +
> +		/* Unwind when platform driver removes */
> +		ret = devm_add_action_or_reset(
> +			&plat_dev->dev, dwc_pcie_pmu_remove_cpuhp_instance,
> +			&pcie_pmu->cpuhp_node);
> +		if (ret)
> +			goto out;
> +
> +		ret = perf_pmu_register(&pcie_pmu->pmu, name, -1);
> +		if (ret) {
> +			pci_err(pdev,
> +				"Error %d registering PMU @%x\n", ret, bdf);
> +			goto out;
> +		}
> +
> +		/* Cache PMU to handle pci device hotplug */
> +		list_add(&pcie_pmu->pmu_node, &dwc_pcie_pmu_head);
> +		pcie_pmu->registered = true;
> +		notify = true;
> +
> +		ret = devm_add_action_or_reset(
> +			&plat_dev->dev, dwc_pcie_pmu_unregister_pmu, pcie_pmu);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (notify && !bus_register_notifier(&pci_bus_type, &dwc_pcie_pmu_nb))
> +		return devm_add_action_or_reset(
> +			&plat_dev->dev, dwc_pcie_pmu_unregister_nb, NULL);
> +
> +	return 0;
> +
> +out:
> +	pci_dev_put(pdev);
> +
> +	return ret;
> +}
> +
> +static int dwc_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu;
> +
> +	pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
> +	if (pcie_pmu->on_cpu == -1)
> +		pcie_pmu->on_cpu = cpumask_local_spread(
> +			0, dev_to_node(&pcie_pmu->pdev->dev));
> +
> +	return 0;
> +}
> +
> +static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu;
> +	struct pci_dev *pdev;
> +	int node;
> +	cpumask_t mask;
> +	unsigned int target;
> +
> +	pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
> +	/* Nothing to do if this CPU doesn't own the PMU */
> +	if (cpu != pcie_pmu->on_cpu)
> +		return 0;
> +
> +	pcie_pmu->on_cpu = -1;
> +	pdev = pcie_pmu->pdev;
> +	node = dev_to_node(&pdev->dev);
> +	if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
> +	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
> +		target = cpumask_any(&mask);
> +	else
> +		target = cpumask_any_but(cpu_online_mask, cpu);
> +
> +	if (target >= nr_cpu_ids) {
> +		pci_err(pdev, "There is no CPU to set\n");
> +		return 0;
> +	}
> +
> +	/* This PMU does NOT support interrupt, just migrate context. */
> +	perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
> +	pcie_pmu->on_cpu = target;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver dwc_pcie_pmu_driver = {
> +	.probe = dwc_pcie_pmu_probe,
> +	.driver = {.name = "dwc_pcie_pmu",},
> +};
> +
> +static int __init dwc_pcie_pmu_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +				      "perf/dwc_pcie_pmu:online",
> +				      dwc_pcie_pmu_online_cpu,
> +				      dwc_pcie_pmu_offline_cpu);
> +	if (ret < 0)
> +		return ret;
> +
> +	dwc_pcie_pmu_hp_state = ret;
> +
> +	ret = platform_driver_register(&dwc_pcie_pmu_driver);
> +	if (ret)
> +		goto platform_driver_register_err;
> +
> +	dwc_pcie_pmu_dev = platform_device_register_simple(
> +				"dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
> +	if (IS_ERR(dwc_pcie_pmu_dev)) {
> +		ret = PTR_ERR(dwc_pcie_pmu_dev);
> +		goto platform_device_register_error;
> +	}
> +
> +	return 0;
> +
> +platform_device_register_error:
> +	platform_driver_unregister(&dwc_pcie_pmu_driver);
> +platform_driver_register_err:
> +	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
> +
> +	return ret;
> +}
> +
> +static void __exit dwc_pcie_pmu_exit(void)
> +{
> +	platform_device_unregister(dwc_pcie_pmu_dev);
> +	platform_driver_unregister(&dwc_pcie_pmu_driver);
> +	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
> +}
> +
> +module_init(dwc_pcie_pmu_init);
> +module_exit(dwc_pcie_pmu_exit);
> +
> +MODULE_DESCRIPTION("PMU driver for DesignWare Cores PCI Express Controller");
> +MODULE_AUTHOR("Shuai Xue <xueshuai@linux.alibaba.com>");
> +MODULE_LICENSE("GPL v2");
