Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4E1848A4
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 14:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgCMN7o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 09:59:44 -0400
Received: from foss.arm.com ([217.140.110.172]:55748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgCMN7o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Mar 2020 09:59:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B429730E;
        Fri, 13 Mar 2020 06:59:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 975403F67D;
        Fri, 13 Mar 2020 06:59:42 -0700 (PDT)
Date:   Fri, 13 Mar 2020 13:59:40 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Qi Liu <liuqi115@huawei.com>, will@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] perf:Add driver for HiSilicon PCIe PMU
Message-ID: <20200313135940.GK42546@lakrids.cambridge.arm.com>
References: <1584014816-1908-1-git-send-email-liuqi115@huawei.com>
 <49a04327-b58b-3103-f992-97e8838c41df@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49a04327-b58b-3103-f992-97e8838c41df@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 13, 2020 at 01:23:53PM +0000, Robin Murphy wrote:
> On 2020-03-12 12:06 pm, Qi Liu wrote:
> > From: Qi liu <liuqi115@huawei.com>

[...]

> > +#define HISI_PCIE_EVENT_SHIFT_M			GENMASK(15, 0)
> > +#define HISI_PCIE_SUBEVENT_SHIFT_M		GENMASK(31, 16)
> > +#define HISI_PCIE_SUBEVENT_SHIFT_S		16
> > +#define HISI_PCIE_PORT_SHIFT_M			GENMASK(7, 0)
> > +#define HISI_PCIE_FUNC_SHIFT_M			GENMASK(15, 8)
> > +#define HISI_PCIE_FUNC_SHIFT_S			8
> 
> So "SHIFT_S" means "shift" and "SHIFT_M" actually means "mask"? That's
> unnecessarily confusing. Furthermore it might be helpful if there was a more
> obvious distinction between hardware register fields and config fields.

Also, If you use the FIELD_GET() and FIELD_PREP() helpers, you only need
to define the mask. See <linux/bitfield.h>.

> > +int hisi_pcie_pmu_event_init(struct perf_event *event)
> > +{
> > +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> > +	struct hw_perf_event *hwc = &event->hw;
> > +	u32 subevent_id, event_id, func_id, port_id;
> > +
> > +	if (event->attr.type != event->pmu->type)
> > +		return -ENOENT;
> > +
> > +	/*
> > +	 * We do not support sampling as the counters are all shared by all
> > +	 * CPU cores in a CPU die(SCCL). Also we do not support attach to a
> 
> Do the PCIe counters have anything to do with CPU clusters at all?
> 
> > +	 * task(per-process mode)
> > +	 */
> > +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> > +		return -EOPNOTSUPP;
> > +
> > +	/*
> > +	 * The uncore counters not specific to any CPU, so cannot
> > +	 * support per-task
> > +	 */
> > +	if (event->cpu < 0)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Validate if the events in group does not exceed the
> > +	 * available counters in hardware.
> > +	 */
> > +	if (!hisi_validate_event_group(event))
> > +		return -EINVAL;
> > +
> > +	event_id = event->attr.config && HISI_PCIE_EVENT_SHIFT_M;
> 
> Really? Are you sure you've tested this properly?

If you had:

#define HISI_PCI_EVENT_ID	GENMASK(15, 0)
#define HISI_PCI_SUBEVENT_ID	GENMASK(31, 16)

... here you could do:

	event_id = FIELD_GET(HISI_PCI_EVENT_ID, event->attr.config);

> 
> > +	subevent_id = (event->attr.config && HISI_PCIE_SUBEVENT_SHIFT_M)
> > +		       >> HISI_PCIE_SUBEVENT_SHIFT_S;

... and:

	subevent_id = FIELD_GET(HISI_PCI_SUBEVENT_ID, event->attr.config);

... and so on for other fields.

Thanks,
Mark.
