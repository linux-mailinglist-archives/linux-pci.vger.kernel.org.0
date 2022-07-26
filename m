Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C11581225
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 13:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiGZLhI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 07:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238919AbiGZLhD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 07:37:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C9232EDE;
        Tue, 26 Jul 2022 04:36:40 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LsZYM4qlvz1M8JV;
        Tue, 26 Jul 2022 19:33:43 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 19:36:34 +0800
CC:     <yangyicong@hisilicon.com>, <alexander.shishkin@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <leo.yan@linaro.org>,
        <james.clark@arm.com>, <will@kernel.org>, <robin.murphy@arm.com>,
        <acme@kernel.org>, <peterz@infradead.org>, <corbet@lwn.net>,
        <mark.rutland@arm.com>, <jonathan.cameron@huawei.com>,
        <john.garry@huawei.com>, <helgaas@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <suzuki.poulose@arm.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
        Yicong Yang <yangyccccc@gmail.com>,
        <linux-doc@vger.kernel.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <bagasdotme@gmail.com>
Subject: Re: [PATCH v11 0/8] Add support for HiSilicon PCIe Tune and Trace
 device
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20220721130116.43366-1-yangyicong@huawei.com>
 <CANLsYkwMsmnj4CaqGigmBa4snn75iGkvE6tUDgHiMNsP3003zA@mail.gmail.com>
 <7adf0c72-521d-f117-5b5f-f8ce0ada44bd@gmail.com>
 <CANLsYkwkUXU6NO1f48dDSDWAf9=bdzTyrPvcf1YuhiKzWFtu+g@mail.gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <c007e24c-b879-db0b-8f31-a034b76af16d@huawei.com>
Date:   Tue, 26 Jul 2022 19:36:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkwkUXU6NO1f48dDSDWAf9=bdzTyrPvcf1YuhiKzWFtu+g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/7/25 22:32, Mathieu Poirier wrote:
> On Fri, 22 Jul 2022 at 08:53, Yicong Yang <yangyccccc@gmail.com> wrote:
>>
>> 在 7/21/2022 11:43 PM, Mathieu Poirier 写道:
>>> On Thu, 21 Jul 2022 at 07:03, <yangyicong@huawei.com> wrote:
>>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>>
>>>> HiSilicon PCIe tune and trace device (PTT) is a PCIe Root Complex
>>>> integrated Endpoint (RCiEP) device, providing the capability
>>>> to dynamically monitor and tune the PCIe traffic (tune),
>>>> and trace the TLP headers (trace).
>>>>
>>>> PTT tune is designed for monitoring and adjusting PCIe link parameters.
>>>> We provide several parameters of the PCIe link. Through the driver,
>>>> user can adjust the value of certain parameter to affect the PCIe link
>>>> for the purpose of enhancing the performance in certian situation.
>>>>
>>>> PTT trace is designed for dumping the TLP headers to the memory, which
>>>> can be used to analyze the transactions and usage condition of the PCIe
>>>> Link. Users can choose filters to trace headers, by either requester
>>>> ID, or those downstream of a set of Root Ports on the same core of the
>>>> PTT device. It's also supported to trace the headers of certain type and
>>>> of certain direction.
>>>>
>>>> The driver registers a PMU device for each PTT device. The trace can
>>>> be used through `perf record` and the traced headers can be decoded
>>>> by `perf report`. The perf command support for the device is also
>>>> added in this patchset. The tune can be used through the sysfs
>>>> attributes of related PMU device. See the documentation for the
>>>> detailed usage.
>>>>
>>>> Change since v10:
>>>> - Use title case in the documentation
>>>> - Add RB from Bagas, thanks.
>>>> Link: https://lore.kernel.org/lkml/20220714092710.53486-1-yangyicong@hisilicon.com/
>>>>
>>>> Change since v9:
>>>> - Add sysfs ABI description documentation
>>>> - Remove the controversial available_{root_port, requester}_filters sysfs file
>>>> - Shorten 2 tune sysfs attributes name and add some comments
>>>> - Move hisi_ptt_process_auxtrace_info() to Patch 6.
>>>> - Add RB from Leo and Ack-by from Mathieu, thanks!
>>> You can add my Ack-by to patch 03 as well.  See below for another comment.
>>
>> Thanks!
>>
>>>> Link: https://lore.kernel.org/lkml/20220606115555.41103-1-yangyicong@hisilicon.com/
>>>>
>>>> Change since v8:
>>>> - Cleanups and one minor fix from Jonathan and John, thanks
>>>> Link: https://lore.kernel.org/lkml/20220516125223.32012-1-yangyicong@hisilicon.com/
>>>>
>>>> Change since v7:
>>>> - Configure the DMA in probe rather than in runtime. Also use devres to manage
>>>>   PMU device as we have no order problem now
>>>> - Refactor the config validation function per John and Leo
>>>> - Use a spinlock hisi_ptt::pmu_lock instead of mutex to serialize the perf process
>>>>   in pmu::start as it's in atomic context
>>>> - Only commit the traced data when stop, per Leo and James
>>>> - Drop the filter dynamically updating patch from this series to simply the review
>>>>   of the driver. That patch will be send separately.
>>>> - add a cpumask sysfs attribute and handle the cpu hotplug events, follow the
>>>>   uncore PMU convention
>>>> - Other cleanups and fixes, both in driver and perf tool
>>>> Link: https://lore.kernel.org/lkml/20220407125841.3678-1-yangyicong@hisilicon.com/
>>>>
>>>> Change since v6:
>>>> - Fix W=1 errors reported by lkp test, thanks
>>>>
>>>> Change since v5:
>>>> - Squash the PMU patch into PATCH 2 suggested by John
>>>> - refine the commit message of PATCH 1 and some comments
>>>> Link: https://lore.kernel.org/lkml/20220308084930.5142-1-yangyicong@hisilicon.com/
>>>>
>>>> Change since v4:
>>>> Address the comments from Jonathan, John and Ma Ca, thanks.
>>>> - Use devm* also for allocating the DMA buffers
>>>> - Remove the IRQ handler stub in Patch 2
>>>> - Make functions waiting for hardware state return boolean
>>>> - Manual remove the PMU device as it should be removed first
>>>> - Modifier the orders in probe and removal to make them matched well
>>>> - Make available {directions,type,format} array const and non-global
>>>> - Using the right filter list in filters show and well protect the
>>>>   list with mutex
>>>> - Record the trace status with a boolean @started rather than enum
>>>> - Optimize the process of finding the PTT devices of the perf-tool
>>>> Link: https://lore.kernel.org/linux-pci/20220221084307.33712-1-yangyicong@hisilicon.com/
>>>>
>>>> Change since v3:
>>>> Address the comments from Jonathan and John, thanks.
>>>> - drop members in the common struct which can be get on the fly
>>>> - reduce buffer struct and organize the buffers with array instead of list
>>>> - reduce the DMA reset wait time to avoid long time busy loop
>>>> - split the available_filters sysfs attribute into two files, for root port
>>>>   and requester respectively. Update the documentation accordingly
>>>> - make IOMMU mapping check earlier in probe to avoid race condition. Also
>>>>   make IOMMU quirk patch prior to driver in the series
>>>> - Cleanups and typos fixes from John and Jonathan
>>>> Link: https://lore.kernel.org/linux-pci/20220124131118.17887-1-yangyicong@hisilicon.com/
>>>>
>>>> Change since v2:
>>>> - address the comments from Mathieu, thanks.
>>>>   - rename the directory to ptt to match the function of the device
>>>>   - spinoff the declarations to a separate header
>>>>   - split the trace function to several patches
>>>>   - some other comments.
>>>> - make default smmu domain type of PTT device to identity
>>>>   Drop the RMR as it's not recommended and use an iommu_def_domain_type
>>>>   quirk to passthrough the device DMA as suggested by Robin.
>>>> Link: https://lore.kernel.org/linux-pci/20211116090625.53702-1-yangyicong@hisilicon.com/
>>>>
>>>> Change since v1:
>>>> - switch the user interface of trace to perf from debugfs
>>>> - switch the user interface of tune to sysfs from debugfs
>>>> - add perf tool support to start trace and decode the trace data
>>>> - address the comments of documentation from Bjorn
>>>> - add RMR[1] support of the device as trace works in RMR mode or
>>>>   direct DMA mode. RMR support is achieved by common APIs rather
>>>>   than the APIs implemented in [1].
>>>> Link: https://lore.kernel.org/lkml/1618654631-42454-1-git-send-email-yangyicong@hisilicon.com/
>>>> [1] https://lore.kernel.org/linux-acpi/20210805080724.480-1-shameerali.kolothum.thodi@huawei.com/
>>>>
>>>> Qi Liu (3):
>>>>   perf tool: arm: Refactor event list iteration in
>>>>     auxtrace_record__init()
>>>>   perf tool: Add support for HiSilicon PCIe Tune and Trace device driver
>>>>   perf tool: Add support for parsing HiSilicon PCIe Trace packet
>>>>
>>>> Yicong Yang (5):
>>>>   iommu/arm-smmu-v3: Make default domain type of HiSilicon PTT device to
>>>>     identity
>>>>   hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe
>>>>     Tune and Trace device
>>>>   hwtracing: hisi_ptt: Add tune function support for HiSilicon PCIe Tune
>>>>     and Trace device
>>>>   docs: trace: Add HiSilicon PTT device driver documentation
>>>>   MAINTAINERS: Add maintainer for HiSilicon PTT driver
>>>>
>>>>  .../ABI/testing/sysfs-devices-hisi_ptt        |   61 +
>>>>  Documentation/trace/hisi-ptt.rst              |  298 +++++
>>>>  Documentation/trace/index.rst                 |    1 +
>>>>  MAINTAINERS                                   |    8 +
>>>>  drivers/Makefile                              |    1 +
>>>>  drivers/hwtracing/Kconfig                     |    2 +
>>>>  drivers/hwtracing/ptt/Kconfig                 |   12 +
>>>>  drivers/hwtracing/ptt/Makefile                |    2 +
>>>>  drivers/hwtracing/ptt/hisi_ptt.c              | 1032 +++++++++++++++++
>>>>  drivers/hwtracing/ptt/hisi_ptt.h              |  200 ++++
>>>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   21 +
>>> Everything above needs to go in one patchset and everything below in
>>> another one.  The first patchset will need to be merged before the
>>> second one.  Someone already commented on that.
>>
>> ok. I put them together to provide an overall view of this and thought maintainers can take
>> them separately. Will spilt the driver part and perf tool patches.
>>
>> I still don't know who will finally take the driver part. It should be Alexander from maintainer
>> list but I got no response yet for a long time. Any hint for this?
> 
> It will either be Peter, Greg or myself.  We'll see when we get there.

Thanks a lot for the information! Since it's going to be the merge window soon, I'll continue this on
the next cycle.

Regards.
