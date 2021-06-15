Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD513A7AB8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 11:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhFOJhh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 05:37:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231420AbhFOJh3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 05:37:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0AFF613F1;
        Tue, 15 Jun 2021 09:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623749725;
        bh=nCrTW//rNCKdhdaFE0n1nbbVk5eZvKM0DYD4gpwBD5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H67ZVbAhA/1IlJVK5/Nlo36qA+vVnFTTW3PIjBgNepp5FpCkwnb0LHVUW5BXYvtQN
         AWvrao8TSRHd0PMLO6E6AOH5qZP2eRAFEFk03X++/8hxZabxVqwcgqknIBEo5tme3A
         F9mYGl4aTCt6cCgMG6Jh1k+aEOUPk0wTlxROEcVPQzQAn/vn19GqBaQGKBRYuqfPGR
         uST0fsjQWBjI/JDo87G5yNJzBIQeE6eJx4+1a7wUqmGxxZdXqOFdd879WCJaTrwTE6
         f05f6QdySXxM4DWfYbsNvuWQZhbXhdgbi9UbczHhqrJCg5iy6ob8sDD/m0rteOu891
         Q5fVu3wjecizg==
Date:   Tue, 15 Jun 2021 10:35:20 +0100
From:   Will Deacon <will@kernel.org>
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     mark.rutland@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH v6 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
Message-ID: <20210615093519.GB19878@willie-the-truck>
References: <1622467951-32114-1-git-send-email-liuqi115@huawei.com>
 <1622467951-32114-3-git-send-email-liuqi115@huawei.com>
 <20210611162347.GA16284@willie-the-truck>
 <a299d053-b45f-e941-7a2e-c853079b8cdd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a299d053-b45f-e941-7a2e-c853079b8cdd@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 15, 2021 at 04:57:09PM +0800, liuqi (BA) wrote:
> On 2021/6/12 0:23, Will Deacon wrote:
> > On Mon, May 31, 2021 at 09:32:31PM +0800, Qi Liu wrote:
> > > PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
> > > to sample bandwidth, latency, buffer occupation etc.
> > > 
> > > Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
> > > registered as a PMU in /sys/bus/event_source/devices, so users can
> > > select target PMU, and use filter to do further sets.
> > > 
> > > Filtering options contains:
> > > event        - select the event.
> > > subevent     - select the subevent.
> > > port         - select target Root Ports. Information of Root Ports
> > >                 are shown under sysfs.
> > > bdf          - select requester_id of target EP device.
> > > trig_len     - set trigger condition for starting event statistics.
> > > trigger_mode - set trigger mode. 0 means starting to statistic when
> > >                 bigger than trigger condition, and 1 means smaller.
> > > thr_len      - set threshold for statistics.
> > > thr_mode     - set threshold mode. 0 means count when bigger than
> > >                 threshold, and 1 means smaller.
> > > 
> > > Reviewed-by: John Garry <john.garry@huawei.com>
> > > Signed-off-by: Qi Liu <liuqi115@huawei.com>
> > > ---
> > >   MAINTAINERS                                |    6 +
> > >   drivers/perf/Kconfig                       |    2 +
> > >   drivers/perf/Makefile                      |    1 +
> > >   drivers/perf/pci/Kconfig                   |   16 +
> > >   drivers/perf/pci/Makefile                  |    2 +
> > >   drivers/perf/pci/hisilicon/Makefile        |    3 +
> > >   drivers/perf/pci/hisilicon/hisi_pcie_pmu.c | 1019 ++++++++++++++++++++++++++++
> > 
> > Can we keep this under drivers/perf/hisilicon/ please? I don't see the
> > need to create a 'pci' directory here.
> > 
> So how about drivers/perf/hisilicon/pci? as hisi_pcie_pmu.c do not use
> hisi_uncore_pmu framework.

That's up to you. As long as it's _somewhere_ under drivers/perf/hisilicon/,
then I'm not too fussed.

> > > +static void hisi_pcie_parse_reg_value(struct hisi_pcie_pmu *pcie_pmu,
> > > +				      u32 reg_off, u16 *arg0, u16 *arg1)
> > > +{
> > > +	u32 val = readl(pcie_pmu->base + reg_off);
> > > +
> > > +	*arg0 = val & 0xffff;
> > > +	*arg1 = (val & 0xffff0000) >> 16;
> > > +}
> > 
> > Define a new type for the pair of values and return that directly?
> > 
> Sorry, I'm not sure about how to fix this, do you mean add a union like
> this?
> union reg_val {
> 	struct {
> 		u16 arg0;
> 		u16 arg1;
> 	}
> 	u32 val;
> }

I was just thinking along the lines of:

struct hisi_pcie_reg_pair {
	u16 lo;
	u16 hi;
};

static struct hisi_pcie_reg_pair
hisi_pcie_parse_reg_value(struct hisi_pcie_pmu *pcie_pmum u32 reg_off)
{
	u32 val = readl_relaxed(pcie_pmu->base + reg_off);
	struct hisi_pcie_reg_pair regs = {
		.lo = val,
		.hi = val >> 16,
	};

	return regs;
}

Does that work?

> > > +/*
> > > + * The bandwidth, latency, bus utilization and buffer occupancy features are
> > > + * calculated from data in HISI_PCIE_CNT and extended data in HISI_PCIE_EXT_CNT.
> > > + * Other features are obtained only by HISI_PCIE_CNT.
> > > + * So data and data_ext are processed in this function to get performanace
> > > + * value like, bandwidth, latency, etc.
> > > + */
> > > +static u64 hisi_pcie_pmu_get_performance(struct perf_event *event, u64 data,
> > > +					 u64 data_ext)
> > > +{
> > > +#define CONVERT_DW_TO_BYTE(x)	(sizeof(u32) * (x))
> > 
> > I don't know what a "DW" is, but this macro adds nothing...
> 
> DW means double words, and 1DW = 4Bytes, value in hardware counter means DW
> so I wanna change it into Byte.
> So how about using 4*data here and adding code comment to explain it.

Just remove the macro and replace it's single user with sizeof(u32) * x

> > > +	/* Process data to set unit of latency as "us". */
> > > +	if (is_latency_event(idx))
> > > +		return div64_u64(data * us_per_cycle, data_ext);
> > > +
> > > +	if (is_bus_util_event(idx))
> > > +		return div64_u64(data * us_per_cycle, data_ext);
> > > +
> > > +	if (is_buf_util_event(idx))
> > > +		return div64_u64(data, data_ext * us_per_cycle);
> > 
> > Why do we need to do all this division in the kernel? Can't we just expose
> > the underlying values and let userspace figure out what it wants to do with
> > the numbers?
> > 
> Our PMU hardware support 8 sets of counters to count bandwidth, latency and
> utilization events.
> 
> For example, when users set latency event, common counter will count delay
> cycles, and extern counter count number of PCIe packets automaticly. And we
> do not have a event number for counting number of PCIe packets.
> 
> So this division cannot move to userspace tool.

Why can't you expose the packet counter as an extra event to userspace?

Will
