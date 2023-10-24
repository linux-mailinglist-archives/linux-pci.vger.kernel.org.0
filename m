Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD527D4A05
	for <lists+linux-pci@lfdr.de>; Tue, 24 Oct 2023 10:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjJXI2G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 04:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjJXI2F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 04:28:05 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F52109;
        Tue, 24 Oct 2023 01:27:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Vupgxj8_1698136074;
Received: from 30.240.113.74(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vupgxj8_1698136074)
          by smtp.aliyun-inc.com;
          Tue, 24 Oct 2023 16:27:56 +0800
Message-ID: <d002d75a-0e81-424d-9639-30d70fd346dd@linux.alibaba.com>
Date:   Tue, 24 Oct 2023 16:27:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, Ian Rogers <irogers@google.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com,
        baolin.wang@linux.alibaba.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
References: <20231020134230.53342-1-xueshuai@linux.alibaba.com>
 <20231020134230.53342-4-xueshuai@linux.alibaba.com>
 <20231023123202.GA3515@willie-the-truck>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20231023123202.GA3515@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URI_DOTEDU,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi, Will,

On 2023/10/23 20:32, Will Deacon wrote:
> On Fri, Oct 20, 2023 at 09:42:29PM +0800, Shuai Xue wrote:
>> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
>> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
>> Core controller IP which provides statistics feature. The PMU is a PCIe
>> configuration space register block provided by each PCIe Root Port in a
>> Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
>> injection, and Statistics).
> 
> Thanks for this. It all looks pretty well written to me, especially the
> documentation (thanks again!).


Thank you :)

> 
> I just have a few comments inline...
> 
>> To facilitate collection of statistics the controller provides the
>> following two features for each Root Port:
>>
>> - one 64-bit counter for Time Based Analysis (RX/TX data throughput and
>>   time spent in each low-power LTSSM state) and
>> - one 32-bit counter for Event Counting (error and non-error events for
>>   a specified lane)
>>
>> Note: There is no interrupt for counter overflow.
>>
>> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
>> named based the BDF of Root Port. For example,
>>
>>     30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>>
>> the PMU device name for this Root Port is dwc_rootport_3018.
> 
> Why not print this in b:d.f formatting then? For example,
> 
> 	dwc_rootport_30:03.0
> 
> Does that confuse perf?

I am afraid, yes. The perf tool can not parse "b:d.f" format,


    Reading a token: Next token is token PE_VALUE (1.18: )
    Error: popping token ':' (1.17: )
    Stack now 0 1 9 52
    Error: popping token PE_NAME (1.0: )
    Stack now 0 1 9
    Error: popping token PE_EVENT_NAME (1.0: )
    Stack now 0 1
    Error: popping token PE_START_EVENTS (1.1: )
    Stack now 0
    Cleanup: discarding lookahead token PE_VALUE (1.18: )
    Stack now 0
    event syntax error: '..otport_0000:30:03.0/Rx_PCIe_TLP_Data_Payload/'
                                      \___ parser error
    Run 'perf list' for a list of valid events

":" may not be legal. I am not familiar with perf parser, +@Ian for help.


> 
> Also, should the segment/domain be factored in as well, in case we get
> multiple instances of the IP and a resulting name collision?

Each instance has different BDF, so IMHO, it will not result name collision.

    #ls /sys/bus/event_source/devices/ | grep dwc
    dwc_rootport_0
    dwc_rootport_10
    dwc_rootport_1000
    dwc_rootport_18
    dwc_rootport_3000
    dwc_rootport_3008
    dwc_rootport_3010
    dwc_rootport_3018
    dwc_rootport_8
    dwc_rootport_8000
    dwc_rootport_9800
    dwc_rootport_9808
    dwc_rootport_9810
    dwc_rootport_9818
    dwc_rootport_b000

I used to use `dwc_rootport_300300` in v1, the subfix is kind of "b:d.f"
format created by:

	+#define DWC_PCIE_CREATE_BDF(seg, bus, dev, func)	\
	+	(((seg) << 24) | (((bus) & 0xFF) << 16) | (((dev) & 0xFF) << 8) | (func))

> 
> - `dwc` indicates the PMU is for Synopsys DesignWare Cores PCIe controller IP
> - `rootport` indicates the PMU is for a root port device
> - `100000` indicates the device address

But Robin and Jonathan suggested to use the standard bdf address. Are you
ask me to change back? I would like to check back :)

> 
>> +struct dwc_pcie_format_attr {
>> +	struct device_attribute attr;
>> +	u64 field;
>> +	int config;
>> +};
>> +
>> +static ssize_t dwc_pcie_pmu_format_show(struct device *dev,
>> +					struct device_attribute *attr,
>> +					char *buf)
>> +{
>> +	struct dwc_pcie_format_attr *fmt = container_of(attr, typeof(*fmt), attr);
>> +	int lo = __ffs(fmt->field), hi = __fls(fmt->field);
>> +
>> +	return sysfs_emit(buf, "config:%d-%d\n", lo, hi);
>> +}
>> +
>> +#define _dwc_pcie_format_attr(_name, _cfg, _fld)			    \
>> +	(&((struct dwc_pcie_format_attr[]) {{				    \
>> +		.attr = __ATTR(_name, 0444, dwc_pcie_pmu_format_show, NULL),\
>> +		.config = _cfg,						    \
>> +		.field = _fld,						    \
>> +	}})[0].attr.attr)
>> +
>> +#define dwc_pcie_format_attr(_name, _fld)	_dwc_pcie_format_attr(_name, 0, _fld)
>> +
>> +static struct attribute *dwc_pcie_format_attrs[] = {
>> +	dwc_pcie_format_attr(type, DWC_PCIE_CONFIG_TYPE),
>> +	dwc_pcie_format_attr(eventid, DWC_PCIE_CONFIG_EVENTID),
>> +	dwc_pcie_format_attr(lane, DWC_PCIE_CONFIG_LANE),
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group dwc_pcie_format_attrs_group = {
>> +	.name = "format",
>> +	.attrs = dwc_pcie_format_attrs,
>> +};
>> +
>> +struct dwc_pcie_event_attr {
>> +	struct device_attribute attr;
>> +	enum dwc_pcie_event_type type;
>> +	u16 eventid;
>> +	u8 lane;
>> +};
> 
> There are a bunch of helpers in linux/perf_event.h for handling some of
> this sysfs stuff. For example, have a look at PMU_FORMAT_ATTR() and
> friends to see if they work for you (some of the other PMU drivers under
> drivers/perf/ use these).

I will PMU_FORMAT_ATTR to simplify format sysfs stuff, thank you.

perf_pmu_events_attr is quite simple and only one `id` filed, I have to
extend a `type` filed to distinguish two types (DWC_PCIE_LANE_EVENT,
DWC_PCIE_TIME_BASE_EVENT) of DWC PMU, so I will not use PMU_EVENT_ATTR().

> 
>> +static void dwc_pcie_pmu_lane_event_enable(struct dwc_pcie_pmu *pcie_pmu,
>> +					   bool enable)
>> +{
>> +	struct pci_dev *pdev = pcie_pmu->pdev;
>> +	u16 ras_des_offset = pcie_pmu->ras_des_offset;
>> +	u32 val;
>> +
>> +	pci_read_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL, &val);
>> +
>> +	/* Clear DWC_PCIE_CNT_ENABLE field first */
>> +	val &= ~DWC_PCIE_CNT_ENABLE;
>> +	if (enable)
>> +		val |= FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_ON);
>> +	else
>> +		val |= FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_OFF);
>> +
>> +	pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL, val);
>> +}
>> +
>> +static void dwc_pcie_pmu_time_based_event_enable(struct dwc_pcie_pmu *pcie_pmu,
>> +					  bool enable)
>> +{
>> +	struct pci_dev *pdev = pcie_pmu->pdev;
>> +	u16 ras_des_offset = pcie_pmu->ras_des_offset;
>> +	u32 val;
>> +
>> +	pci_read_config_dword(pdev, ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_CTL,
>> +			      &val);
>> +
>> +	if (enable)
>> +		val |= DWC_PCIE_TIME_BASED_CNT_ENABLE;
>> +	else
>> +		val &= ~DWC_PCIE_TIME_BASED_CNT_ENABLE;
>> +
>> +	pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_CTL,
>> +			       val);
>> +}
> 
> I think you could implement both of these _enable() functions as simple
> wrappers around something like pci_clear_and_set_dword() -- maybe that
> could move into a header out of aspm.c?

Agreed, I will add a separate patch to move pci_clear_and_set_dword() out
of aspm.c and then use it to simplify these two _enable() functions.

> 
>> +static u64 dwc_pcie_pmu_read_lane_event_counter(struct perf_event *event)
>> +{
>> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>> +	struct pci_dev *pdev = pcie_pmu->pdev;
>> +	u16 ras_des_offset = pcie_pmu->ras_des_offset;
>> +	u32 val;
>> +
>> +	pci_read_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_DATA, &val);
>> +
>> +	return val;
>> +}
>> +
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
> 
> I think it would be a good idea to bound this loop based on either number of
> retries or a timeout. If the hardware wedges for whatever reason, we're
> going to get stuck in here.

I looked all drivers in kernel which use similar trick, but did not find
example implementation.

Do we really need it?

> 
>> +
>> +	/*
>> +	 * The Group#1 event measures the amount of data processed in 16-byte
>> +	 * units. Simplify the end-user interface by multiplying the counter
>> +	 * at the point of read.
>> +	 */
>> +	if (event_id >= 0x20 && event_id <= 0x23)
>> +		return (((u64)hi << 32) | lo) << 4;
>> +	else
>> +		return (((u64)hi << 32) | lo);
> 
> nit, but I think it would be clearer to do:
> 
> 	ret = ((u64)hi << 32) | lo;
> 
> 	/* ... */
> 	if (event_id >= 0x20 && event_id <= 0x23)
> 		ret <<= 4;
> 
> 	return ret;
> 

Quite beautiful, will fix it.

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
> 
> Similarly here, I think it would be clearer to construct a 'u64 max_period'
> variable and then just unconditionally mask against that. 

Will fix it.

> In general, you
> have quite a lot of 'if (type == LANE) ... else if (type == TIME) ...'
> code in this driver. I think that's probably fine as long as we have two
> event types, but if this extends in the future then it's probably worth
> looking at having separate 'ops' structures for the event types and
> dispatching to them directly.

Agreed, will dispatch separately if more types are added in the future.

> 
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
>> +static void dwc_pcie_pmu_event_stop(struct perf_event *event, int flags)
>> +{
>> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
>> +	struct hw_perf_event *hwc = &event->hw;
>> +
>> +	if (event->hw.state & PERF_HES_STOPPED)
>> +		return;
>> +
>> +	if (type == DWC_PCIE_LANE_EVENT)
>> +		dwc_pcie_pmu_lane_event_enable(pcie_pmu, false);
>> +	else if (type == DWC_PCIE_TIME_BASE_EVENT)
>> +		dwc_pcie_pmu_time_based_event_enable(pcie_pmu, false);
>> +
>> +	dwc_pcie_pmu_event_update(event);
>> +	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
>> +}
>> +
>> +static int dwc_pcie_pmu_event_add(struct perf_event *event, int flags)
>> +{
>> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>> +	struct pci_dev *pdev = pcie_pmu->pdev;
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
>> +	int event_id = DWC_PCIE_EVENT_ID(event);
>> +	int lane = DWC_PCIE_EVENT_LANE(event);
>> +	u16 ras_des_offset = pcie_pmu->ras_des_offset;
>> +	u32 ctrl;
>> +
>> +	/* one counter for each type and it is in use */
>> +	if (pcie_pmu->event[type])
>> +		return -ENOSPC;
> 
> I'm a bit worried about this -- isn't the type basically funneled in
> directly from userspace? If so, it's not safe to use it as index like
> this. It's probably better to sanitise the input early in
> dwc_pcie_pmu_event_init(), so that we know we have either a lane or a
> time event everywhere else.

Good catch, I will sanitise it in dwc_pcie_pmu_event_init().

> 
> If you haven't tried it, there's a decent fuzzing tool for perf, so it's
> probably worth taking that for a spin (it might need educating about your
> driver):
> 
> https://web.eece.maine.edu/~vweaver/projects/perf_events/fuzzer/

Sorry, I haven't. I will spin before a new version sended.

> 
>> +	if (type == DWC_PCIE_LANE_EVENT) {
>> +		/* EVENT_COUNTER_DATA_REG needs clear manually */
>> +		ctrl = FIELD_PREP(DWC_PCIE_CNT_EVENT_SEL, event_id) |
>> +			FIELD_PREP(DWC_PCIE_CNT_LANE_SEL, lane) |
>> +			FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_OFF) |
>> +			FIELD_PREP(DWC_PCIE_EVENT_CLEAR, DWC_PCIE_EVENT_PER_CLEAR);
>> +		pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
>> +				       ctrl);
>> +	} else if (type == DWC_PCIE_TIME_BASE_EVENT) {
>> +		/*
>> +		 * TIME_BASED_ANAL_DATA_REG is a 64 bit register, we can safely
>> +		 * use it with any manually controlled duration. And it is
>> +		 * cleared when next measurement starts.
>> +		 */
>> +		ctrl = FIELD_PREP(DWC_PCIE_TIME_BASED_REPORT_SEL, event_id) |
>> +			FIELD_PREP(DWC_PCIE_TIME_BASED_DURATION_SEL,
>> +				   DWC_PCIE_DURATION_MANUAL_CTL) |
>> +			DWC_PCIE_TIME_BASED_CNT_ENABLE;
>> +		pci_write_config_dword(
>> +			pdev, ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_CTL, ctrl);
> 
> Maybe move these into separate lane/time helpers rather than clutter this
> function with the field definitions?

Aha, I used to. Robin complained that the helpers were already confusing enough
so warp out control register configuration from sub-function to .add().

> 
>> +static void dwc_pcie_pmu_event_del(struct perf_event *event, int flags)
>> +{
>> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
>> +
>> +	dwc_pcie_pmu_event_stop(event, flags | PERF_EF_UPDATE);
>> +	perf_event_update_userpage(event);
>> +	pcie_pmu->event[type] = NULL;
>> +}
>> +
>> +static void dwc_pcie_pmu_remove_cpuhp_instance(void *hotplug_node)
>> +{
>> +	cpuhp_state_remove_instance_nocalls(dwc_pcie_pmu_hp_state, hotplug_node);
>> +}
>> +
>> +/*
>> + * Find the PMU of a PCI device.
>> + * @pdev: The PCI device.
>> + */
>> +static struct dwc_pcie_pmu *dwc_pcie_find_dev_pmu(struct pci_dev *pdev)
>> +{
>> +	struct dwc_pcie_pmu *pcie_pmu;
>> +
>> +	list_for_each_entry(pcie_pmu, &dwc_pcie_pmu_head, pmu_node)
>> +		if (pcie_pmu->pdev == pdev)
>> +			return pcie_pmu;
>> +
>> +	return NULL;
>> +}
>> +
>> +static void dwc_pcie_pmu_unregister_pmu(void *data)
>> +{
>> +	struct dwc_pcie_pmu *pcie_pmu = data;
>> +
>> +	if (!pcie_pmu->registered)
>> +		return;
>> +
>> +	pcie_pmu->registered = false;
>> +	list_del(&pcie_pmu->pmu_node);
>> +	perf_pmu_unregister(&pcie_pmu->pmu);
> 
> Do you not need any locking here? The cpu hotplug callbacks are still live
> and I'm not seeing how you prevent them from picking up the PMU from the
> list right before you unregister it.

The hotplug callball also try to pick up the PMU to unregister, but if
the PMU is already unregistered here, pcie_pmu->registered will be set as
false, so the PMU will not unregistered again.

So, I think pcie_pmu->registered is some kind of lock? Please correct me if
I missed anything else.

> 
>> +}
>> +
>> +static int dwc_pcie_pmu_notifier(struct notifier_block *nb,
>> +				     unsigned long action, void *data)
>> +{
>> +	struct device *dev = data;
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct dwc_pcie_pmu *pcie_pmu;
>> +
>> +	/* Unregister the PMU when the device is going to be deleted. */
>> +	if (action != BUS_NOTIFY_DEL_DEVICE)
>> +		return NOTIFY_DONE;
>> +
>> +	pcie_pmu = dwc_pcie_find_dev_pmu(pdev);
>> +	if (!pcie_pmu)
>> +		return NOTIFY_DONE;
>> +
>> +	dwc_pcie_pmu_unregister_pmu(pcie_pmu);
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block dwc_pcie_pmu_nb = {
>> +	.notifier_call = dwc_pcie_pmu_notifier,
>> +};
>> +
>> +static void dwc_pcie_pmu_unregister_nb(void *data)
>> +{
>> +	bus_unregister_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
>> +}
>> +
>> +static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>> +{
>> +	struct pci_dev *pdev = NULL;
>> +	struct dwc_pcie_pmu *pcie_pmu;
>> +	bool notify = false;
>> +	char *name;
>> +	u32 bdf;
>> +	int ret;
>> +
>> +	/* Match the rootport with VSEC_RAS_DES_ID, and register a PMU for it */
>> +	for_each_pci_dev(pdev) {
>> +		u16 vsec;
>> +		u32 val;
>> +
>> +		if (!(pci_is_pcie(pdev) &&
>> +		      pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
>> +			continue;
>> +
>> +		vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
>> +						DWC_PCIE_VSEC_RAS_DES_ID);
>> +		if (!vsec)
>> +			continue;
>> +
>> +		pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
>> +		if (PCI_VNDR_HEADER_REV(val) != 0x04)
>> +			continue;
>> +		pci_dbg(pdev,
>> +			"Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
>> +
>> +		bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
>> +		name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x",
>> +				      bdf);
>> +		if (!name) {
>> +			ret = -ENOMEM;
>> +			goto out;
>> +		}
>> +
>> +		/* All checks passed, go go go */
>> +		pcie_pmu = devm_kzalloc(&plat_dev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
>> +		if (!pcie_pmu) {
>> +			ret = -ENOMEM;
>> +			goto out;
>> +		}
>> +
>> +		pcie_pmu->pdev = pdev;
>> +		pcie_pmu->ras_des_offset = vsec;
>> +		pcie_pmu->nr_lanes = pcie_get_width_cap(pdev);
>> +		pcie_pmu->on_cpu = -1;
>> +		pcie_pmu->pmu = (struct pmu){
>> +			.module		= THIS_MODULE,
>> +			.attr_groups	= dwc_pcie_attr_groups,
>> +			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>> +			.task_ctx_nr	= perf_invalid_context,
>> +			.event_init	= dwc_pcie_pmu_event_init,
>> +			.add		= dwc_pcie_pmu_event_add,
>> +			.del		= dwc_pcie_pmu_event_del,
>> +			.start		= dwc_pcie_pmu_event_start,
>> +			.stop		= dwc_pcie_pmu_event_stop,
>> +			.read		= dwc_pcie_pmu_event_update,
>> +		};
>> +
>> +		/* Add this instance to the list used by the offline callback */
>> +		ret = cpuhp_state_add_instance(dwc_pcie_pmu_hp_state,
>> +					       &pcie_pmu->cpuhp_node);
>> +		if (ret) {
>> +			pci_err(pdev,
>> +				"Error %d registering hotplug @%x\n", ret, bdf);
>> +			goto out;
>> +		}
>> +
>> +		/* Unwind when platform driver removes */
>> +		ret = devm_add_action_or_reset(
>> +			&plat_dev->dev, dwc_pcie_pmu_remove_cpuhp_instance,
>> +			&pcie_pmu->cpuhp_node);
>> +		if (ret)
>> +			goto out;
>> +
>> +		ret = perf_pmu_register(&pcie_pmu->pmu, name, -1);
>> +		if (ret) {
>> +			pci_err(pdev,
>> +				"Error %d registering PMU @%x\n", ret, bdf);
>> +			goto out;
>> +		}
>> +
>> +		/* Cache PMU to handle pci device hotplug */
>> +		list_add(&pcie_pmu->pmu_node, &dwc_pcie_pmu_head);
>> +		pcie_pmu->registered = true;
>> +		notify = true;
>> +
>> +		ret = devm_add_action_or_reset(
>> +			&plat_dev->dev, dwc_pcie_pmu_unregister_pmu, pcie_pmu);
>> +		if (ret)
>> +			goto out;
> 
> Hmm, why do you need the PCI bus notifier on BUS_NOTIFY_DEL_DEVICE if you
> register this action callback? I'm struggling to get my head around how the
> following interact:
> 
>   - Driver loading/unloading
>   - CPU hotplug events
>   - PCI device add/del events
> 
> as well as the lifetime of the platform device relative to the PCI device.

Yes, they are a bit complex.

The event triggers of the above three parts of PMU, CPU and PCI device are
quite independent,

 - Driver loading/unloading: the lifetime of platform device
	insmod/rmmod module of this driver
 - CPU hotplug events:
	echo 0 > /sys/devices/system/cpu/cpu0/online
	echo 1 > /sys/devices/system/cpu/cpu0/online
 - PCI device add/del events (a.k.a PCI hotplug events), e.g
	echo 1 > /sys/bus/pci/devices/0000\:30\:02.0/remove
	echo 1 > /sys/bus/pci/rescan

The lifecycles of PMU, CPU, and PCI devices have mutual influence on each other.

1. The CPU hotplug just as other PMUs in drivers/perf, let's talk about it
   first.

   The PMU context is binded to a CPU picked from the same NUMA node of PCI
   device, so if the picked CPU is offlined at runtime, we need to migate
   the context to another local online CPU in the same NUMA node.

2. The Driver loading/unloading is independent, for exmaple, rmmod module
   if not built in or unbinds the driver. Then all PMUs of PCI device will
   be unregistered as expected, and the PCI device is not affected.

3. The PMU holds the PCI device to which it belongs, so that it can access
   the PCI DES capability. If the PCI device is unplugged at runtime, the
   PMU should also be unregistered.  It's the basic idea suggested by
   @Yicong, just as x86 does in uncore_bus_notify().
	


> 
>> +	}
>> +
>> +	if (notify && !bus_register_notifier(&pci_bus_type, &dwc_pcie_pmu_nb))
>> +		return devm_add_action_or_reset(
>> +			&plat_dev->dev, dwc_pcie_pmu_unregister_nb, NULL);
>> +
>> +	return 0;
>> +
>> +out:
>> +	pci_dev_put(pdev);
>> +
>> +	return ret;
>> +}
>> +
>> +static int dwc_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
>> +{
>> +	struct dwc_pcie_pmu *pcie_pmu;
>> +
>> +	pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
>> +	if (pcie_pmu->on_cpu == -1)
>> +		pcie_pmu->on_cpu = cpumask_local_spread(
>> +			0, dev_to_node(&pcie_pmu->pdev->dev));
>> +
>> +	return 0;
>> +}
>> +
>> +static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
>> +{
>> +	struct dwc_pcie_pmu *pcie_pmu;
>> +	struct pci_dev *pdev;
>> +	int node;
>> +	cpumask_t mask;
>> +	unsigned int target;
>> +
>> +	pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
>> +	/* Nothing to do if this CPU doesn't own the PMU */
>> +	if (cpu != pcie_pmu->on_cpu)
>> +		return 0;
>> +
>> +	pcie_pmu->on_cpu = -1;
>> +	pdev = pcie_pmu->pdev;
>> +	node = dev_to_node(&pdev->dev);
>> +	if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
>> +	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
>> +		target = cpumask_any(&mask);
>> +	else
>> +		target = cpumask_any_but(cpu_online_mask, cpu);
>> +
>> +	if (target >= nr_cpu_ids) {
>> +		pci_err(pdev, "There is no CPU to set\n");
>> +		return 0;
>> +	}
>> +
>> +	/* This PMU does NOT support interrupt, just migrate context. */
>> +	perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
>> +	pcie_pmu->on_cpu = target;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver dwc_pcie_pmu_driver = {
>> +	.probe = dwc_pcie_pmu_probe,
>> +	.driver = {.name = "dwc_pcie_pmu",},
>> +};
>> +
>> +static int __init dwc_pcie_pmu_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
>> +				      "perf/dwc_pcie_pmu:online",
>> +				      dwc_pcie_pmu_online_cpu,
>> +				      dwc_pcie_pmu_offline_cpu);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	dwc_pcie_pmu_hp_state = ret;
>> +
>> +	ret = platform_driver_register(&dwc_pcie_pmu_driver);
>> +	if (ret)
>> +		goto platform_driver_register_err;
>> +
>> +	dwc_pcie_pmu_dev = platform_device_register_simple(
>> +				"dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
>> +	if (IS_ERR(dwc_pcie_pmu_dev)) {
>> +		ret = PTR_ERR(dwc_pcie_pmu_dev);
>> +		goto platform_device_register_error;
>> +	}
> 
> I'm a bit confused as to why you're having to create a platform device
> for a PCI device -- is this because the main designware driver has already
> bound to it? A comment here explaining why you need to do this would be
> very helpful. 

The problem here is that we need to do that fundamental redesign of the
way the PCI ports drivers work so that the PCIe VSEC/DVSEC capability, e.g
RAS_DES PMU here could probe and remove, hotplug and unhotplug more gracefully.
I think we have discussed the current limitation in the previous version[1].

>> Given that we have a appropriate way to tear down the PMUs via devm_add_action_or_reset(),
>> I am going to remove the redundant probe/remove framework via platform_driver_{un}register().
>> for_each probe process in __dwc_pcie_pmu_probe() will be move into dwc_pcie_pmu_init().
>> Is it a better way?
>
> I think I'd prefer to see a standard driver creation / probe flow even if you could in theory
avoid it. [2]

I discussed with @Jonathan about the probe flow. Jonathan prefers the standard driver
creation/probe flow. What's your opinion?

If you are happy with the current implementation flow, I will just add a comment.


> In particular, is there any dependency on another driver
> to make sure that e.g. config space accesses work properly? If so, we
> probably need to enforce module load ordering or something like that.

Of course, at least it depends on
	- pci_driver_init called by postcore_initcall, early order 2
	- acpi_pci_init called by arch_initcall, early order 3

so I think module_init called by device_initcall, early order 6 is ok?


Thank you for valuable comments,
Best Regards,
Shuai

[1] https://lore.kernel.org/lkml/634f4762-cf2e-4535-f369-4032d65093f0@linux.alibaba.com/t/#ma82c49a12d579c2e497b321f46f3f56789be5d2c
[2] https://lore.kernel.org/lkml/634f4762-cf2e-4535-f369-4032d65093f0@linux.alibaba.com/t/#m595e169995b1d61a2737e67925468929cf0dba6a
[3] https://lore.kernel.org/lkml/20230522035428.69441-5-xueshuai@linux.alibaba.com/T/#m8f5aec1cb50b42825739a5977629c8ea98710a6e
