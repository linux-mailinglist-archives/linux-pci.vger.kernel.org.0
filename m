Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D9516F5EB
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 04:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgBZDFZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 22:05:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57092 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727880AbgBZDFZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Feb 2020 22:05:25 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 782DE46488E95C5DEB79;
        Wed, 26 Feb 2020 11:05:22 +0800 (CST)
Received: from [127.0.0.1] (10.67.101.242) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 11:05:19 +0800
Subject: Re: [PATCH v4 03/26] iommu: Add a page fault handler
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-4-jean-philippe@linaro.org>
 <cb8b5a85-7f1a-8eb7-85bd-db2f553f066d@huawei.com>
 <20200225092519.GC375953@myrica>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
        <mark.rutland@arm.com>, <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        <catalin.marinas@arm.com>, <robin.murphy@arm.com>,
        <robh+dt@kernel.org>, <zhangfei.gao@linaro.org>, <will@kernel.org>,
        <christian.koenig@amd.com>, <tj@kernel.org>
From:   Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <0c2b29ad-d09a-89db-8540-5909751b1972@huawei.com>
Date:   Wed, 26 Feb 2020 11:05:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200225092519.GC375953@myrica>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.242]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
On 2020/2/25 17:25, Jean-Philippe Brucker wrote:
> Hi Zaibo,
>
> On Tue, Feb 25, 2020 at 11:30:05AM +0800, Xu Zaibo wrote:
>>> +struct iopf_queue *
>>> +iopf_queue_alloc(const char *name, iopf_queue_flush_t flush, void *cookie)
>>> +{
>>> +	struct iopf_queue *queue;
>>> +
>>> +	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
>>> +	if (!queue)
>>> +		return NULL;
>>> +
>>> +	/*
>>> +	 * The WQ is unordered because the low-level handler enqueues faults by
>>> +	 * group. PRI requests within a group have to be ordered, but once
>>> +	 * that's dealt with, the high-level function can handle groups out of
>>> +	 * order.
>>> +	 */
>>> +	queue->wq = alloc_workqueue("iopf_queue/%s", WQ_UNBOUND, 0, name);
>> Should this workqueue use 'WQ_HIGHPRI | WQ_UNBOUND' or some flags like this
>> to decrease the unexpected
>> latency of I/O PageFault here? Or maybe, workqueue will show an uncontrolled
>> latency, even in a busy system.
> I'll investigate the effect of these flags. So far I've only run on
> completely idle systems but it would be interesting to add some
> workqueue-heavy load in my tests.
>
I'm not sure, just my concern. Hopefully, Tejun Heo can give us some 
hints. :)

+cc  Tejun Heo <tj@kernel.org>

Cheers,
Zaibo

.
> .
>


