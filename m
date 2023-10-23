Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218617D283D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 04:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjJWCFo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Oct 2023 22:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJWCFo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Oct 2023 22:05:44 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C8E107;
        Sun, 22 Oct 2023 19:05:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vud2pUO_1698026734;
Received: from 30.97.48.63(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vud2pUO_1698026734)
          by smtp.aliyun-inc.com;
          Mon, 23 Oct 2023 10:05:36 +0800
Message-ID: <539dade7-c349-33c3-cb9e-8a795de28041@linux.alibaba.com>
Date:   Mon, 23 Oct 2023 10:05:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v9 3/4] drivers/perf: add DesignWare PCIe PMU driver
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com, chengyou@linux.alibaba.com,
        kaishen@linux.alibaba.com, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, robin.murphy@arm.com
References: <20231020134230.53342-1-xueshuai@linux.alibaba.com>
 <20231020134230.53342-4-xueshuai@linux.alibaba.com>
 <8c6a480e-41d2-43f7-952e-4f4e691e700f@linux.alibaba.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <8c6a480e-41d2-43f7-952e-4f4e691e700f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/22/2023 3:47 PM, Shuai Xue wrote:
> Hi, Baolin,
> 
> I droped your Revivewed-by tag due to that I made significant changes to this
> patch previously, please explicty give me Revivewed-by tag again if you are
> happy with the changes.

Yes, I am happy with this version (just some nits as below), and thanks 
for the review from other guys. Please feel free to add:

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> On 2023/10/20 21:42, Shuai Xue wrote:
>> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
>> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
>> Core controller IP which provides statistics feature. The PMU is a PCIe
>> configuration space register block provided by each PCIe Root Port in a
>> Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
>> injection, and Statistics).
>>
>> To facilitate collection of statistics the controller provides the
>> following two features for each Root Port:
>>
>> - one 64-bit counter for Time Based Analysis (RX/TX data throughput and
>>    time spent in each low-power LTSSM state) and
>> - one 32-bit counter for Event Counting (error and non-error events for
>>    a specified lane)
>>
>> Note: There is no interrupt for counter overflow.
>>
>> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
>> named based the BDF of Root Port. For example,
>>
>>      30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>>
>> the PMU device name for this Root Port is dwc_rootport_3018.
>>
>> Example usage of counting PCIe RX TLP data payload (Units of bytes)::
>>
>>      $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>>
>> average RX bandwidth can be calculated like this:
>>
>>      PCIe TX Bandwidth = Rx_PCIe_TLP_Data_Payload / Measure_Time_Window
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---

[snip]

>> +static u64 dwc_pcie_pmu_read_time_based_counter(struct perf_event *event)
>> +{
>> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>> +	struct pci_dev *pdev = pcie_pmu->pdev;
>> +	int event_id = DWC_PCIE_EVENT_ID(event);
>> +	u16 ras_des_offset = pcie_pmu->ras_des_offset;
>> +	u32 lo, hi, ss;
>> +
>> +	/*
>> +	 * The 64-bit value of the data counter is spread across two
>> +	 * registers that are not synchronized. In order to read them
>> +	 * atomically, ensure that the high 32 bits match before and after
>> +	 * reading the low 32 bits.
>> +	 */
>> +	pci_read_config_dword(pdev, ras_des_offset +
>> +		DWC_PCIE_TIME_BASED_ANAL_DATA_REG_HIGH, &hi);
>> +	do {
>> +		/* snapshot the high 32 bits */
>> +		ss = hi;
>> +
>> +		pci_read_config_dword(
>> +			pdev, ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_DATA_REG_LOW,
>> +			&lo);
>> +		pci_read_config_dword(
>> +			pdev, ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_DATA_REG_HIGH,
>> +			&hi);
>> +	} while (hi != ss);
>> +
>> +	/*
>> +	 * The Group#1 event measures the amount of data processed in 16-byte
>> +	 * units. Simplify the end-user interface by multiplying the counter
>> +	 * at the point of read.
>> +	 */
>> +	if (event_id >= 0x20 && event_id <= 0x23)
>> +		return (((u64)hi << 32) | lo) << 4;
>> +	else

You can drop the 'else'.

>> +		return (((u64)hi << 32) | lo);
>> +}
>> +
>> +static void dwc_pcie_pmu_event_update(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
>> +	u64 delta, prev, now;
>> +
>> +	do {
>> +		prev = local64_read(&hwc->prev_count);
>> +
>> +		if (type == DWC_PCIE_LANE_EVENT)
>> +			now = dwc_pcie_pmu_read_lane_event_counter(event);
>> +		else if (type == DWC_PCIE_TIME_BASE_EVENT)
>> +			now = dwc_pcie_pmu_read_time_based_counter(event);
>> +
>> +	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
>> +
>> +	if (type == DWC_PCIE_LANE_EVENT)
>> +		delta = (now - prev) & DWC_PCIE_LANE_EVENT_MAX_PERIOD;
>> +	else if (type == DWC_PCIE_TIME_BASE_EVENT)
>> +		delta = (now - prev) & DWC_PCIE_TIME_BASED_EVENT_MAX_PERIOD;
>> +
>> +	local64_add(delta, &event->count);
>> +}
>> +
>> +static int dwc_pcie_pmu_event_init(struct perf_event *event)
>> +{
>> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
>> +	struct perf_event *sibling;
>> +	u32 lane;
>> +
>> +	if (event->attr.type != event->pmu->type)
>> +		return -ENOENT;
>> +
>> +	/* We don't support sampling */
>> +	if (is_sampling_event(event))
>> +		return -EINVAL;
>> +
>> +	/* We cannot support task bound events */
>> +	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK)
>> +		return -EINVAL;
>> +
>> +	if (event->group_leader != event &&
>> +	    !is_software_event(event->group_leader))
>> +		return -EINVAL;
>> +
>> +	for_each_sibling_event(sibling, event->group_leader) {
>> +		if (sibling->pmu != event->pmu && !is_software_event(sibling))
>> +			return -EINVAL;
>> +	}
>> +
>> +	if (type == DWC_PCIE_LANE_EVENT) {
>> +		lane = DWC_PCIE_EVENT_LANE(event);
>> +		if (lane < 0 || lane >= pcie_pmu->nr_lanes)
>> +			return -EINVAL;
>> +	}
>> +
>> +	event->cpu = pcie_pmu->on_cpu;
>> +
>> +	return 0;
>> +}
>> +
>> +static void dwc_pcie_pmu_set_period(struct hw_perf_event *hwc)
>> +{
>> +	local64_set(&hwc->prev_count, 0);
>> +}

Only dwc_pcie_pmu_event_start() will call this small function, why just 
remove this function and move local64_set() into dwc_pcie_pmu_event_start()?

>> +
>> +static void dwc_pcie_pmu_event_start(struct perf_event *event, int flags)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
>> +
>> +	hwc->state = 0;
>> +	dwc_pcie_pmu_set_period(hwc);
>> +
>> +	if (type == DWC_PCIE_LANE_EVENT)
>> +		dwc_pcie_pmu_lane_event_enable(pcie_pmu, true);
>> +	else if (type == DWC_PCIE_TIME_BASE_EVENT)
>> +		dwc_pcie_pmu_time_based_event_enable(pcie_pmu, true);
>> +}
>> +
