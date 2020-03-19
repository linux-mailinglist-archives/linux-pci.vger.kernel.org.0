Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50A418AA55
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 02:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgCSBfD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 21:35:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12093 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbgCSBfC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 21:35:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F4303A32EB79CAF7C94;
        Thu, 19 Mar 2020 09:34:59 +0800 (CST)
Received: from [127.0.0.1] (10.65.95.32) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 19 Mar 2020
 09:34:50 +0800
Subject: Re: [PATCH RFC] perf:Add driver for HiSilicon PCIe PMU
To:     Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <1584014816-1908-1-git-send-email-liuqi115@huawei.com>
 <49a04327-b58b-3103-f992-97e8838c41df@arm.com>
 <20200313135940.GK42546@lakrids.cambridge.arm.com>
CC:     <will@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Qi Liu <liuqi115@huawei.com>
Message-ID: <8a154c7b-9698-a329-a63a-4d13680d5916@huawei.com>
Date:   Thu, 19 Mar 2020 09:34:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200313135940.GK42546@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.95.32]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for reviewing this patch, will fix these in v2 patch!

On 2020/3/13 21:59, Mark Rutland wrote:
> On Fri, Mar 13, 2020 at 01:23:53PM +0000, Robin Murphy wrote:
>> On 2020-03-12 12:06 pm, Qi Liu wrote:
>>> From: Qi liu <liuqi115@huawei.com>
> 
> [...]
> 
>>> +#define HISI_PCIE_EVENT_SHIFT_M			GENMASK(15, 0)
>>> +#define HISI_PCIE_SUBEVENT_SHIFT_M		GENMASK(31, 16)
>>> +#define HISI_PCIE_SUBEVENT_SHIFT_S		16
>>> +#define HISI_PCIE_PORT_SHIFT_M			GENMASK(7, 0)
>>> +#define HISI_PCIE_FUNC_SHIFT_M			GENMASK(15, 8)
>>> +#define HISI_PCIE_FUNC_SHIFT_S			8
>>
>> So "SHIFT_S" means "shift" and "SHIFT_M" actually means "mask"? That's
>> unnecessarily confusing. Furthermore it might be helpful if there was a more
>> obvious distinction between hardware register fields and config fields.
> 
> Also, If you use the FIELD_GET() and FIELD_PREP() helpers, you only need
> to define the mask. See <linux/bitfield.h>.
> 
>>> +int hisi_pcie_pmu_event_init(struct perf_event *event)
>>> +{
>>> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>>> +	struct hw_perf_event *hwc = &event->hw;
>>> +	u32 subevent_id, event_id, func_id, port_id;
>>> +
>>> +	if (event->attr.type != event->pmu->type)
>>> +		return -ENOENT;
>>> +
>>> +	/*
>>> +	 * We do not support sampling as the counters are all shared by all
>>> +	 * CPU cores in a CPU die(SCCL). Also we do not support attach to a
>>
>> Do the PCIe counters have anything to do with CPU clusters at all?
>>
>>> +	 * task(per-process mode)
>>> +	 */
>>> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	/*
>>> +	 * The uncore counters not specific to any CPU, so cannot
>>> +	 * support per-task
>>> +	 */
>>> +	if (event->cpu < 0)
>>> +		return -EINVAL;
>>> +
>>> +	/*
>>> +	 * Validate if the events in group does not exceed the
>>> +	 * available counters in hardware.
>>> +	 */
>>> +	if (!hisi_validate_event_group(event))
>>> +		return -EINVAL;
>>> +
>>> +	event_id = event->attr.config && HISI_PCIE_EVENT_SHIFT_M;
>>
>> Really? Are you sure you've tested this properly?
> 
> If you had:
> 
> #define HISI_PCI_EVENT_ID	GENMASK(15, 0)
> #define HISI_PCI_SUBEVENT_ID	GENMASK(31, 16)
> 
> ... here you could do:
> 
> 	event_id = FIELD_GET(HISI_PCI_EVENT_ID, event->attr.config);
> 
>>
>>> +	subevent_id = (event->attr.config && HISI_PCIE_SUBEVENT_SHIFT_M)
>>> +		       >> HISI_PCIE_SUBEVENT_SHIFT_S;
> 
> ... and:
> 
> 	subevent_id = FIELD_GET(HISI_PCI_SUBEVENT_ID, event->attr.config);
> 
> ... and so on for other fields.
> 
> Thanks,
> Mark.
> 
> .
> 

