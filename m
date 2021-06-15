Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCFA3A79A8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 10:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhFOI7S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 04:59:18 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4784 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhFOI7R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 04:59:17 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G42BM0sBNzXfwW;
        Tue, 15 Jun 2021 16:52:11 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 16:57:11 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 16:57:10 +0800
Subject: Re: [PATCH v6 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     Will Deacon <will@kernel.org>
CC:     <mark.rutland@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
References: <1622467951-32114-1-git-send-email-liuqi115@huawei.com>
 <1622467951-32114-3-git-send-email-liuqi115@huawei.com>
 <20210611162347.GA16284@willie-the-truck>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <a299d053-b45f-e941-7a2e-c853079b8cdd@huawei.com>
Date:   Tue, 15 Jun 2021 16:57:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210611162347.GA16284@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Will,
Thanks for your reviewing.

On 2021/6/12 0:23, Will Deacon wrote:
> On Mon, May 31, 2021 at 09:32:31PM +0800, Qi Liu wrote:
>> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
>> to sample bandwidth, latency, buffer occupation etc.
>>
>> Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
>> registered as a PMU in /sys/bus/event_source/devices, so users can
>> select target PMU, and use filter to do further sets.
>>
>> Filtering options contains:
>> event        - select the event.
>> subevent     - select the subevent.
>> port         - select target Root Ports. Information of Root Ports
>>                 are shown under sysfs.
>> bdf          - select requester_id of target EP device.
>> trig_len     - set trigger condition for starting event statistics.
>> trigger_mode - set trigger mode. 0 means starting to statistic when
>>                 bigger than trigger condition, and 1 means smaller.
>> thr_len      - set threshold for statistics.
>> thr_mode     - set threshold mode. 0 means count when bigger than
>>                 threshold, and 1 means smaller.
>>
>> Reviewed-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   MAINTAINERS                                |    6 +
>>   drivers/perf/Kconfig                       |    2 +
>>   drivers/perf/Makefile                      |    1 +
>>   drivers/perf/pci/Kconfig                   |   16 +
>>   drivers/perf/pci/Makefile                  |    2 +
>>   drivers/perf/pci/hisilicon/Makefile        |    3 +
>>   drivers/perf/pci/hisilicon/hisi_pcie_pmu.c | 1019 ++++++++++++++++++++++++++++
> 
> Can we keep this under drivers/perf/hisilicon/ please? I don't see the
> need to create a 'pci' directory here.
>
So how about drivers/perf/hisilicon/pci? as hisi_pcie_pmu.c do not use 
hisi_uncore_pmu framework.
thanks
>>   include/linux/cpuhotplug.h                 |    1 +
>>   8 files changed, 1050 insertions(+)
>>   create mode 100644 drivers/perf/pci/Kconfig
>>   create mode 100644 drivers/perf/pci/Makefile
>>   create mode 100644 drivers/perf/pci/hisilicon/Makefile
>>   create mode 100644 drivers/perf/pci/hisilicon/hisi_pcie_pmu.c
>>

[...]
>> +
>> +#define HISI_PCIE_PMU_ATTR(_name, _func, _config)			\
>> +	(&((struct dev_ext_attribute[]) {				\
>> +		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }   \
>> +	})[0].attr.attr)
> 
> If you rebase onto my patch queue, then you can use PMU_EVENT_ATTR_ID to
> define this.
> 
ok, will fix this, thanks.
>> +#define HISI_PCIE_PMU_FORMAT_ATTR(_name, _format)			\
>> +	HISI_PCIE_PMU_ATTR(_name, hisi_pcie_format_sysfs_show, (void *)_format)
>> +#define HISI_PCIE_PMU_EVENT_ATTR(_name, _event)			\
>> +	HISI_PCIE_PMU_ATTR(_name, hisi_pcie_event_sysfs_show, (void *)_event)
>> +
>> +static ssize_t hisi_pcie_cpumask_show(struct device *dev,
>> +				      struct device_attribute *attr, char *buf)
>> +{
>> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
>> +
>> +	return sysfs_emit(buf, "%d\n", pcie_pmu->on_cpu);
>> +}
> 
> This isn't a cpumask.
> 
got it, I'll use cpumask_of(pcie_pmu->on_cpu) next time, thanks.

>> +
>> +static ssize_t hisi_pcie_identifier_show(struct device *dev,
>> +					 struct device_attribute *attr,
>> +					 char *buf)
>> +{
>> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
>> +
>> +	return sysfs_emit(buf, "0x%x\n", pcie_pmu->identifier);
>> +}
>> +
>> +static ssize_t hisi_pcie_bus_show(struct device *dev,
>> +				  struct device_attribute *attr, char *buf)
>> +{
>> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
>> +
>> +	return sysfs_emit(buf, "0x%02x\n", PCI_BUS_NUM(pcie_pmu->bdf_min));
>> +}
>> +
>> +static void hisi_pcie_parse_reg_value(struct hisi_pcie_pmu *pcie_pmu,
>> +				      u32 reg_off, u16 *arg0, u16 *arg1)
>> +{
>> +	u32 val = readl(pcie_pmu->base + reg_off);
>> +
>> +	*arg0 = val & 0xffff;
>> +	*arg1 = (val & 0xffff0000) >> 16;
>> +}
> 
> Define a new type for the pair of values and return that directly?
> 
Sorry, I'm not sure about how to fix this, do you mean add a union like 
this?
union reg_val {
	struct {
		u16 arg0;
		u16 arg1;
	}
	u32 val;
}

[...]

>> +static void hisi_pcie_pmu_writeq(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
>> +				 u32 idx, u64 val)
>> +{
>> +	u32 offset = hisi_pcie_pmu_get_offset(reg_offset, idx);
>> +
>> +	writeq(val, pcie_pmu->base + offset);
>> +}
> 
> I'm guessing most (all?) of these IO access can be _relaxed() ?
> 

ok, will change this.
>> +
>> +static void hisi_pcie_pmu_config_filter(struct perf_event *event)
>> +{
>> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	u64 reg = HISI_PCIE_DEFAULT_SET;
>> +	u64 port, trig_len, thr_len;
>> +	u32 idx = hwc->idx;
>> +
>> +	/* Config HISI_PCIE_EVENT_CTRL according to event and subevent. */
>> +	reg |= FIELD_PREP(HISI_PCIE_EVENT_M, hisi_pcie_get_event(event)) |
>> +	       FIELD_PREP(HISI_PCIE_SUBEVENT_M, hisi_pcie_get_subevent(event));
>> +
>> +	/* Config HISI_PCIE_EVENT_CTRL according to ROOT PORT or EP device. */
>> +	port = hisi_pcie_get_port(event);
>> +	if (port)
>> +		reg |= FIELD_PREP(HISI_PCIE_TARGET_M, port);
>> +	else
>> +		reg |= HISI_PCIE_TARGET_EN |
>> +		       FIELD_PREP(HISI_PCIE_TARGET_M, hisi_pcie_get_bdf(event));
> 
> Please use braces for multi-line conditional expressions (same elsewhere).
> 
It is single-line here, this line is more than 80 words so wrap here.
>> +
>> +	/* Config HISI_PCIE_EVENT_CTRL according to trigger condition. */
>> +	trig_len = hisi_pcie_get_trig_len(event);
>> +	if (trig_len)
>> +		reg |= FIELD_PREP(HISI_PCIE_TRIG_M, trig_len) |
>> +		       FIELD_PREP(HISI_PCIE_TRIG_MODE_M,
>> +		       hisi_pcie_get_trig_mode(event)) | HISI_PCIE_TRIG_EN;
> 
> The formatting is very weird here.
> 
will fix this.
>> +
>> +	/* Config HISI_PCIE_EVENT_CTRL according to threshold condition. */
>> +	thr_len = hisi_pcie_get_thr_len(event);
>> +	if (thr_len)
>> +		reg |= FIELD_PREP(HISI_PCIE_THR_M, thr_len) |
>> +		       FIELD_PREP(HISI_PCIE_THR_MODE_M,
>> +		       hisi_pcie_get_thr_mode(event)) | HISI_PCIE_THR_EN;
> 
> and here.
> 

will fix this, thanks.
[...]

>> +
>> +/*
>> + * The bandwidth, latency, bus utilization and buffer occupancy features are
>> + * calculated from data in HISI_PCIE_CNT and extended data in HISI_PCIE_EXT_CNT.
>> + * Other features are obtained only by HISI_PCIE_CNT.
>> + * So data and data_ext are processed in this function to get performanace
>> + * value like, bandwidth, latency, etc.
>> + */
>> +static u64 hisi_pcie_pmu_get_performance(struct perf_event *event, u64 data,
>> +					 u64 data_ext)
>> +{
>> +#define CONVERT_DW_TO_BYTE(x)	(sizeof(u32) * (x))
> 
> I don't know what a "DW" is, but this macro adds nothing...

DW means double words, and 1DW = 4Bytes, value in hardware counter means 
DW so I wanna change it into Byte.
So how about using 4*data here and adding code comment to explain it.

> 
>> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>> +	u64 us_per_cycle = readl(pcie_pmu->base + HISI_PCIE_REG_FREQ);
>> +	u32 idx = hisi_pcie_get_event(event);
>> +
>> +	if (!data_ext)
>> +		return 0;
>> +
>> +	/* Process data to set unit of bandwidth as "Byte/ms". */
>> +	if (is_bw_event(idx)) {
>> +
>> +		if (!div64_u64(data_ext, 1000))
>> +			return 0;
>> +
>> +		return div64_u64(CONVERT_DW_TO_BYTE(data),
> 
> ... especially as this is the only use of it.
> 
> 
>> +				 div64_u64(data_ext, 1000));
>> +	}
>> +
>> +	/* Process data to set unit of latency as "us". */
>> +	if (is_latency_event(idx))
>> +		return div64_u64(data * us_per_cycle, data_ext);
>> +
>> +	if (is_bus_util_event(idx))
>> +		return div64_u64(data * us_per_cycle, data_ext);
>> +
>> +	if (is_buf_util_event(idx))
>> +		return div64_u64(data, data_ext * us_per_cycle);
> 
> Why do we need to do all this division in the kernel? Can't we just expose
> the underlying values and let userspace figure out what it wants to do with
> the numbers?
> 
> Will
> 
Our PMU hardware support 8 sets of counters to count bandwidth, latency 
and utilization events.

For example, when users set latency event, common counter will count 
delay cycles, and extern counter count number of PCIe packets 
automaticly. And we do not have a event number for counting number of 
PCIe packets.

So this division cannot move to userspace tool.

Thanks,
Qi
> .
> 

