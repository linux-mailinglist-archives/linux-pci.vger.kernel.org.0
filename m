Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBEA1849F0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 15:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCMOvW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 10:51:22 -0400
Received: from foss.arm.com ([217.140.110.172]:56596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgCMOvW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Mar 2020 10:51:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9BC331B;
        Fri, 13 Mar 2020 07:51:21 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D75D3F67D;
        Fri, 13 Mar 2020 07:51:20 -0700 (PDT)
Subject: Re: [PATCH RFC] perf:Add driver for HiSilicon PCIe PMU
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Qi Liu <liuqi115@huawei.com>, will@kernel.org,
        mark.rutland@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1584014816-1908-1-git-send-email-liuqi115@huawei.com>
 <49a04327-b58b-3103-f992-97e8838c41df@arm.com>
 <20200313141416.00002e89@Huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <314f612d-d6e2-3855-44f1-d6cab756aac9@arm.com>
Date:   Fri, 13 Mar 2020 14:50:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313141416.00002e89@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-03-13 2:14 pm, Jonathan Cameron wrote:
> On Fri, 13 Mar 2020 13:23:53 +0000
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> On 2020-03-12 12:06 pm, Qi Liu wrote:
>>> From: Qi liu <liuqi115@huawei.com>
>>>
>>> PCIe PMU Root Complex Integrate End Point(IEP) device is
>>> supported to sample bandwidth, latency, buffer occupation,
>>> bandwidth utilization etc.
>>> Each PMU IEP device monitors multiple root ports, and each
>>> IEP is registered as a pmu in /sys/bus/event_source/devices,
>>> so users can select the target IEP, and use filter to select
>>> root port, function and event.
>>> Filtering options are:
>>> event:    - select the event.
>>> subevent: - select the subevent.
>>> port:     - select target root port.
>>> func:     - select target EP device under the port.
>>>
>>> Example: hisi_pcie_00_14_00/event=0x08,subevent=0x04,   \
>>> port=0x05,func=0x00/ -I 1000
>>>
>>> PMU IEP device is described by its bus, device and function,
>>> target root port is 0x05 and target EP under it is function
>>> 0x00. Subevent 0x04 of event 0x08 is sampled.
>>>
>>> Note that in this RFC:
>>> 1. PCIe PMU IEP hardware is still in development.
>>> 2. Perf common event list is undetermined, and name of these
>>> events still need to be discussed.
>>> 3. port filter could only select one port each time.
>>> 4. There are two possible schemes of pmu registration, one is
>>> register each root port as a pmu, it is easier for users to
>>> select target port. The other one is register each IEP as pmu,
>>> for counters are per IEP, not per root port, the second scheme
>>> describes hardware PMC much more reasonable, but need to add
>>> "port" filter option to select port. We use the second one in
>>> this RFC.
>>>
> 
> Whilst it's great to have detailed feedback, just to make it clear...
> 
> This is an RFC for the reasons above.  They include that the hardware
> is still in development - i.e. we can't test it because they've not finished
> implementation yet.

That's OK - TBH I'd be more sympathetic if I wasn't still in the middle 
of developing a massively more complicated PMU driver for hardware that 
*does* exist, but that I only have sporadic access to one trivial 
configuration of :)

> The intention of posting so early is to get some feedback on the general
> approach and the specific points in 2,3 and 4 above.

It's probably hard to comment on point 2 until it's nailed down what 
actual events exist and what the values represent.

For point 3, there's a relatively intuitive way to support the case 
where all counters are affected by a single global filter - essentially, 
the first scheduled event 'claims' the global filter settings, then any 
further events have to have the same settings to be allowed in - we 
implement this in arm_smmuv3_pmu.c, for one example.

> The key fiddly point with this is that it is a shared PMU across a set
> of PCIe Root Ports (there are several of these devices on each SoC in
> the system covering a set of ports each).
> That makes for a somewhat fiddly interface, hence the RFC.
The general rule of thumb I've been told is that the granularity of "a 
PMU" usually wants to be the granularity at which you can start/stop 
multiple counters atomically (consider when you want to accurately 
measure a metric which requires relative values of two or more events). 
In that context, the structure implemented here looks like the right choice.

Robin.

> 
> Thanks to everyone who has reviewed though as definitely some stuff for liuqi to
> fix!
> 
> Jonathan
> 
> 
