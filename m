Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC277D369E
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 14:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjJWMcO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 08:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjJWMcN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 08:32:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ED2FF;
        Mon, 23 Oct 2023 05:32:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1237CC433C8;
        Mon, 23 Oct 2023 12:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698064328;
        bh=6NEAkV0IcSKN8i9kBMX4UmyGzjmhetRR7ZkXs+aGibI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1SvC3Xqsatm9vUTADu31euROvOiIgdcu3nL2tDFf6RtUa4MZta/IBM44XEkz9Lse
         AobN6aLdUezccMGihEvqek7It7oh+/zczr4SYl9w48GgGaLuTl/4oC5UDeYRDzdfig
         +rYiz873shJ3WkIZmNw7jmWSaz0WxrWR0SXrYAzviSBA1b4I3tEhETfheQ99upMI3n
         LiOfYra+LCaQNE3EFYQe2q5A1MNT5Lu2HlmviA9JAweyD+xjbIjYexfm3yykdn4kVo
         NgOKvSKlI91OEEPWvKL7Qen92Y1lDSW6iVsEUvAyMejKkG1iHgC1eCErdlRApkyqOZ
         GvWP4mhf35ZMA==
Date:   Mon, 23 Oct 2023 13:32:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v9 3/4] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20231023123202.GA3515@willie-the-truck>
References: <20231020134230.53342-1-xueshuai@linux.alibaba.com>
 <20231020134230.53342-4-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020134230.53342-4-xueshuai@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 20, 2023 at 09:42:29PM +0800, Shuai Xue wrote:
> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> Core controller IP which provides statistics feature. The PMU is a PCIe
> configuration space register block provided by each PCIe Root Port in a
> Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
> injection, and Statistics).

Thanks for this. It all looks pretty well written to me, especially the
documentation (thanks again!).

I just have a few comments inline...

> To facilitate collection of statistics the controller provides the
> following two features for each Root Port:
> 
> - one 64-bit counter for Time Based Analysis (RX/TX data throughput and
>   time spent in each low-power LTSSM state) and
> - one 32-bit counter for Event Counting (error and non-error events for
>   a specified lane)
> 
> Note: There is no interrupt for counter overflow.
> 
> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
> named based the BDF of Root Port. For example,
> 
>     30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
> 
> the PMU device name for this Root Port is dwc_rootport_3018.

Why not print this in b:d.f formatting then? For example,

	dwc_rootport_30:03.0

Does that confuse perf?

Also, should the segment/domain be factored in as well, in case we get
multiple instances of the IP and a resulting name collision?

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

There are a bunch of helpers in linux/perf_event.h for handling some of
this sysfs stuff. For example, have a look at PMU_FORMAT_ATTR() and
friends to see if they work for you (some of the other PMU drivers under
drivers/perf/ use these).

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

I think you could implement both of these _enable() functions as simple
wrappers around something like pci_clear_and_set_dword() -- maybe that
could move into a header out of aspm.c?

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

I think it would be a good idea to bound this loop based on either number of
retries or a timeout. If the hardware wedges for whatever reason, we're
going to get stuck in here.

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

nit, but I think it would be clearer to do:

	ret = ((u64)hi << 32) | lo;

	/* ... */
	if (event_id >= 0x20 && event_id <= 0x23)
		ret <<= 4;

	return ret;

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

Similarly here, I think it would be clearer to construct a 'u64 max_period'
variable and then just unconditionally mask against that. In general, you
have quite a lot of 'if (type == LANE) ... else if (type == TIME) ...'
code in this driver. I think that's probably fine as long as we have two
event types, but if this extends in the future then it's probably worth
looking at having separate 'ops' structures for the event types and
dispatching to them directly.

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

I'm a bit worried about this -- isn't the type basically funneled in
directly from userspace? If so, it's not safe to use it as index like
this. It's probably better to sanitise the input early in
dwc_pcie_pmu_event_init(), so that we know we have either a lane or a
time event everywhere else.

If you haven't tried it, there's a decent fuzzing tool for perf, so it's
probably worth taking that for a spin (it might need educating about your
driver):

https://web.eece.maine.edu/~vweaver/projects/perf_events/fuzzer/

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

Maybe move these into separate lane/time helpers rather than clutter this
function with the field definitions?

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

Do you not need any locking here? The cpu hotplug callbacks are still live
and I'm not seeing how you prevent them from picking up the PMU from the
list right before you unregister it.

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

Hmm, why do you need the PCI bus notifier on BUS_NOTIFY_DEL_DEVICE if you
register this action callback? I'm struggling to get my head around how the
following interact:

  - Driver loading/unloading
  - CPU hotplug events
  - PCI device add/del events

as well as the lifetime of the platform device relative to the PCI device.

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

I'm a bit confused as to why you're having to create a platform device
for a PCI device -- is this because the main designware driver has already
bound to it? A comment here explaining why you need to do this would be
very helpful. In particular, is there any dependency on another driver
to make sure that e.g. config space accesses work properly? If so, we
probably need to enforce module load ordering or something like that.

Will
