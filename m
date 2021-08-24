Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9871D3F606E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbhHXOc1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 10:32:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237507AbhHXOc1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 10:32:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADCE161206;
        Tue, 24 Aug 2021 14:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629815503;
        bh=bMXxWdJ++UOk1cdyFyrdXhzKNE28DWjaOyjbGlm5oZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6nQxqPcrAa/bhgupvz6wzhg3WjP5uexcxcNnExiZn1s97EfGIb+u6ormYS4LFc1w
         L9AYGW//Tebs/AAi5+6/gVddHsuwo99eIHf7AbNYXLcUFRx8grtDWeWz+zKJ3+PBpY
         5XdAZfBJJdcHy6MZ/+zfn16ZQt769IO8wY7oEKcBitx4YU3Dx2dqucjIm3yTmr/bWr
         +7jKHAfNMFaraoIuWyg4dtj/w3LvndMOByfFgQDlWgAQhzKoEW8+fFhqWjgqls7t4W
         LePnrgJIqJ5VLayIw7SLidjZ5lww7JIj10s9UI+iE9bNuxTQgbz8zuYXV9m2wzC8sn
         Lq9QHJPj5ywwg==
Date:   Tue, 24 Aug 2021 15:31:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     mark.rutland@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH v9 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
Message-ID: <20210824143137.GA23146@willie-the-truck>
References: <20210818051246.29545-1-liuqi115@huawei.com>
 <20210818051246.29545-3-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818051246.29545-3-liuqi115@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Aug 18, 2021 at 01:12:46PM +0800, Qi Liu wrote:
> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
> to sample bandwidth, latency, buffer occupation etc.
> 
> Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
> registered as a PMU in /sys/bus/event_source/devices, so users can
> select target PMU, and use filter to do further sets.
> 
> Filtering options contains:
> event     - select the event.
> port      - select target Root Ports. Information of Root Ports are
>             shown under sysfs.
> bdf       - select requester_id of target EP device.
> trig_len  - set trigger condition for starting event statistics.
> trig_mode - set trigger mode. 0 means starting to statistic when bigger
>             than trigger condition, and 1 means smaller.
> thr_len   - set threshold for statistics.
> thr_mode  - set threshold mode. 0 means count when bigger than threshold,
>             and 1 means smaller.

I think this is getting there now, thanks for sticking with it. Just a
couple of comments below..

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

Given that this function doesn't look at the event numbers, doesn't this
over-provision the counter registers? For example, if I create a group
containing 4 of the same event, then we'll allocate four counters but only
use one. Similarly, if I create a group containing two events, one for the
normal counter and one for the extended counter, then we'll again allocate
two counters instead of one.

Have I misunderstood?

> +static int hisi_pcie_pmu_event_init(struct perf_event *event)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	event->cpu = pcie_pmu->on_cpu;
> +
> +	if (EXT_COUNTER_IS_USED(hisi_pcie_get_event(event)))
> +		hwc->event_base = HISI_PCIE_EXT_CNT;
> +	else
> +		hwc->event_base = HISI_PCIE_CNT;
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

Please remove this message, as it's triggerable from userspace.

Will
