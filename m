Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E38457E343
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 16:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiGVOxB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 10:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVOxB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 10:53:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA31495C19;
        Fri, 22 Jul 2022 07:52:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l14-20020a17090a72ce00b001f20ed3c55dso4407233pjk.5;
        Fri, 22 Jul 2022 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=F5pg0LbnnBhqo02ZMeSKP+64/YyJqkHoijLfrU8hIdc=;
        b=jzGoM0C8bt5l8uX73/tIH2jHTzhrRbkVTYEzM2G7KVO4DFu7+EzQeM8m+TUgf4qMbV
         aCVNxox+CTOcEeyFbBtt2PKiuyg6caTz3Nu4VS9uU8ZIduAZ7YYyK7FiMNyf+eRKBJgx
         1r/CUTuG9bXcywTPAxVyzdYmbLHMywpMa2ZQDZvZNNsu4PM1nuJesPu7pYWNudcQjQFw
         eucDcUEEoRQCEnUMz2SNPQjqNbh6O4fdogcHi1NQFGCJMc1lsoihOCu9KdqgsxX1s3b3
         Hf9rq38ay7cLgQT4mvlXjQq3S6gRwz/cI5UhSfS9epaa8L83FaDb2QOiP1pxKRBk9LDf
         IfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F5pg0LbnnBhqo02ZMeSKP+64/YyJqkHoijLfrU8hIdc=;
        b=v/G56IIWjiZwOcB0IKu21G8wDyrlPCvYzpHPl7vD18sUsQ+zWrK/dxKWXF6S1aw/Oj
         zgqjvlJaV7s9r/2M33haPVwIYW4F271i6ceW2VRBzusoZ2mEEo7NcR2bMXlEk+fn/Ie1
         f2P49DLcjJjhRuLNhPAkH+RcVODgCwAd+eiYvalufOFOEMGbeG+nbORZRzpMo+XTBafF
         69vhuh8JqN85rfF6puIiix72Jto3HSDA8PdutFX2+8YqU8DB3JUDiqZK+sR6hwxr6aK1
         352/K//T7bvv+z6Af8hKPTED5rb7ksw+DNXjW5oQLECHo94/7TwQ6cMtsJ9C5HppY579
         n29w==
X-Gm-Message-State: AJIora8TktuqvkwdqXFlefOEd/vuRJULMT6Vlveo44ygTYkNPKWiEbQY
        GNyqi/e/F3nkT4ySosczkFc=
X-Google-Smtp-Source: AGRyM1tzfZxXVm+tPwV/My+3Hv9nt4PJYkppKD7BD6cfTdvQd36juwxmdYzWgREtlVUkOLJIxYZz4A==
X-Received: by 2002:a17:90b:33d2:b0:1f0:3a40:982d with SMTP id lk18-20020a17090b33d200b001f03a40982dmr39957pjb.60.1658501579069;
        Fri, 22 Jul 2022 07:52:59 -0700 (PDT)
Received: from [0.0.0.0] (60-249-2-240.hinet-ip.hinet.net. [60.249.2.240])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7985a000000b0051bada81bc7sm1778607pfq.161.2022.07.22.07.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 07:52:58 -0700 (PDT)
Message-ID: <7adf0c72-521d-f117-5b5f-f8ce0ada44bd@gmail.com>
Date:   Fri, 22 Jul 2022 22:52:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v11 0/8] Add support for HiSilicon PCIe Tune and Trace
 device
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        alexander.shishkin@linux.intel.com
Cc:     gregkh@linuxfoundation.org, leo.yan@linaro.org,
        james.clark@arm.com, will@kernel.org, robin.murphy@arm.com,
        acme@kernel.org, peterz@infradead.org, corbet@lwn.net,
        mark.rutland@arm.com, jonathan.cameron@huawei.com,
        john.garry@huawei.com, helgaas@kernel.org,
        lorenzo.pieralisi@arm.com, suzuki.poulose@arm.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-doc@vger.kernel.org, prime.zeng@huawei.com,
        liuqi115@huawei.com, zhangshaokun@hisilicon.com,
        linuxarm@huawei.com, yangyicong@hisilicon.com, bagasdotme@gmail.com
References: <20220721130116.43366-1-yangyicong@huawei.com>
 <CANLsYkwMsmnj4CaqGigmBa4snn75iGkvE6tUDgHiMNsP3003zA@mail.gmail.com>
From:   Yicong Yang <yangyccccc@gmail.com>
In-Reply-To: <CANLsYkwMsmnj4CaqGigmBa4snn75iGkvE6tUDgHiMNsP3003zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

在 7/21/2022 11:43 PM, Mathieu Poirier 写道:
> On Thu, 21 Jul 2022 at 07:03, <yangyicong@huawei.com> wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> HiSilicon PCIe tune and trace device (PTT) is a PCIe Root Complex
>> integrated Endpoint (RCiEP) device, providing the capability
>> to dynamically monitor and tune the PCIe traffic (tune),
>> and trace the TLP headers (trace).
>>
>> PTT tune is designed for monitoring and adjusting PCIe link parameters.
>> We provide several parameters of the PCIe link. Through the driver,
>> user can adjust the value of certain parameter to affect the PCIe link
>> for the purpose of enhancing the performance in certian situation.
>>
>> PTT trace is designed for dumping the TLP headers to the memory, which
>> can be used to analyze the transactions and usage condition of the PCIe
>> Link. Users can choose filters to trace headers, by either requester
>> ID, or those downstream of a set of Root Ports on the same core of the
>> PTT device. It's also supported to trace the headers of certain type and
>> of certain direction.
>>
>> The driver registers a PMU device for each PTT device. The trace can
>> be used through `perf record` and the traced headers can be decoded
>> by `perf report`. The perf command support for the device is also
>> added in this patchset. The tune can be used through the sysfs
>> attributes of related PMU device. See the documentation for the
>> detailed usage.
>>
>> Change since v10:
>> - Use title case in the documentation
>> - Add RB from Bagas, thanks.
>> Link: https://lore.kernel.org/lkml/20220714092710.53486-1-yangyicong@hisilicon.com/
>>
>> Change since v9:
>> - Add sysfs ABI description documentation
>> - Remove the controversial available_{root_port, requester}_filters sysfs file
>> - Shorten 2 tune sysfs attributes name and add some comments
>> - Move hisi_ptt_process_auxtrace_info() to Patch 6.
>> - Add RB from Leo and Ack-by from Mathieu, thanks!
> You can add my Ack-by to patch 03 as well.  See below for another comment.

Thanks!

>> Link: https://lore.kernel.org/lkml/20220606115555.41103-1-yangyicong@hisilicon.com/
>>
>> Change since v8:
>> - Cleanups and one minor fix from Jonathan and John, thanks
>> Link: https://lore.kernel.org/lkml/20220516125223.32012-1-yangyicong@hisilicon.com/
>>
>> Change since v7:
>> - Configure the DMA in probe rather than in runtime. Also use devres to manage
>>   PMU device as we have no order problem now
>> - Refactor the config validation function per John and Leo
>> - Use a spinlock hisi_ptt::pmu_lock instead of mutex to serialize the perf process
>>   in pmu::start as it's in atomic context
>> - Only commit the traced data when stop, per Leo and James
>> - Drop the filter dynamically updating patch from this series to simply the review
>>   of the driver. That patch will be send separately.
>> - add a cpumask sysfs attribute and handle the cpu hotplug events, follow the
>>   uncore PMU convention
>> - Other cleanups and fixes, both in driver and perf tool
>> Link: https://lore.kernel.org/lkml/20220407125841.3678-1-yangyicong@hisilicon.com/
>>
>> Change since v6:
>> - Fix W=1 errors reported by lkp test, thanks
>>
>> Change since v5:
>> - Squash the PMU patch into PATCH 2 suggested by John
>> - refine the commit message of PATCH 1 and some comments
>> Link: https://lore.kernel.org/lkml/20220308084930.5142-1-yangyicong@hisilicon.com/
>>
>> Change since v4:
>> Address the comments from Jonathan, John and Ma Ca, thanks.
>> - Use devm* also for allocating the DMA buffers
>> - Remove the IRQ handler stub in Patch 2
>> - Make functions waiting for hardware state return boolean
>> - Manual remove the PMU device as it should be removed first
>> - Modifier the orders in probe and removal to make them matched well
>> - Make available {directions,type,format} array const and non-global
>> - Using the right filter list in filters show and well protect the
>>   list with mutex
>> - Record the trace status with a boolean @started rather than enum
>> - Optimize the process of finding the PTT devices of the perf-tool
>> Link: https://lore.kernel.org/linux-pci/20220221084307.33712-1-yangyicong@hisilicon.com/
>>
>> Change since v3:
>> Address the comments from Jonathan and John, thanks.
>> - drop members in the common struct which can be get on the fly
>> - reduce buffer struct and organize the buffers with array instead of list
>> - reduce the DMA reset wait time to avoid long time busy loop
>> - split the available_filters sysfs attribute into two files, for root port
>>   and requester respectively. Update the documentation accordingly
>> - make IOMMU mapping check earlier in probe to avoid race condition. Also
>>   make IOMMU quirk patch prior to driver in the series
>> - Cleanups and typos fixes from John and Jonathan
>> Link: https://lore.kernel.org/linux-pci/20220124131118.17887-1-yangyicong@hisilicon.com/
>>
>> Change since v2:
>> - address the comments from Mathieu, thanks.
>>   - rename the directory to ptt to match the function of the device
>>   - spinoff the declarations to a separate header
>>   - split the trace function to several patches
>>   - some other comments.
>> - make default smmu domain type of PTT device to identity
>>   Drop the RMR as it's not recommended and use an iommu_def_domain_type
>>   quirk to passthrough the device DMA as suggested by Robin.
>> Link: https://lore.kernel.org/linux-pci/20211116090625.53702-1-yangyicong@hisilicon.com/
>>
>> Change since v1:
>> - switch the user interface of trace to perf from debugfs
>> - switch the user interface of tune to sysfs from debugfs
>> - add perf tool support to start trace and decode the trace data
>> - address the comments of documentation from Bjorn
>> - add RMR[1] support of the device as trace works in RMR mode or
>>   direct DMA mode. RMR support is achieved by common APIs rather
>>   than the APIs implemented in [1].
>> Link: https://lore.kernel.org/lkml/1618654631-42454-1-git-send-email-yangyicong@hisilicon.com/
>> [1] https://lore.kernel.org/linux-acpi/20210805080724.480-1-shameerali.kolothum.thodi@huawei.com/
>>
>> Qi Liu (3):
>>   perf tool: arm: Refactor event list iteration in
>>     auxtrace_record__init()
>>   perf tool: Add support for HiSilicon PCIe Tune and Trace device driver
>>   perf tool: Add support for parsing HiSilicon PCIe Trace packet
>>
>> Yicong Yang (5):
>>   iommu/arm-smmu-v3: Make default domain type of HiSilicon PTT device to
>>     identity
>>   hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe
>>     Tune and Trace device
>>   hwtracing: hisi_ptt: Add tune function support for HiSilicon PCIe Tune
>>     and Trace device
>>   docs: trace: Add HiSilicon PTT device driver documentation
>>   MAINTAINERS: Add maintainer for HiSilicon PTT driver
>>
>>  .../ABI/testing/sysfs-devices-hisi_ptt        |   61 +
>>  Documentation/trace/hisi-ptt.rst              |  298 +++++
>>  Documentation/trace/index.rst                 |    1 +
>>  MAINTAINERS                                   |    8 +
>>  drivers/Makefile                              |    1 +
>>  drivers/hwtracing/Kconfig                     |    2 +
>>  drivers/hwtracing/ptt/Kconfig                 |   12 +
>>  drivers/hwtracing/ptt/Makefile                |    2 +
>>  drivers/hwtracing/ptt/hisi_ptt.c              | 1032 +++++++++++++++++
>>  drivers/hwtracing/ptt/hisi_ptt.h              |  200 ++++
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   21 +
> Everything above needs to go in one patchset and everything below in
> another one.  The first patchset will need to be merged before the
> second one.  Someone already commented on that.

ok. I put them together to provide an overall view of this and thought maintainers can take
them separately. Will spilt the driver part and perf tool patches.

I still don't know who will finally take the driver part. It should be Alexander from maintainer
list but I got no response yet for a long time. Any hint for this?

Thanks.

>>  tools/perf/arch/arm/util/auxtrace.c           |  116 +-
>>  tools/perf/arch/arm/util/pmu.c                |    3 +
>>  tools/perf/arch/arm64/util/Build              |    2 +-
>>  tools/perf/arch/arm64/util/hisi-ptt.c         |  188 +++
>>  tools/perf/util/Build                         |    2 +
>>  tools/perf/util/auxtrace.c                    |    4 +
>>  tools/perf/util/auxtrace.h                    |    1 +
>>  tools/perf/util/hisi-ptt-decoder/Build        |    1 +
>>  .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   |  164 +++
>>  .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |   31 +
>>  tools/perf/util/hisi-ptt.c                    |  192 +++
>>  tools/perf/util/hisi-ptt.h                    |   19 +
>>  23 files changed, 2341 insertions(+), 20 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-devices-hisi_ptt
>>  create mode 100644 Documentation/trace/hisi-ptt.rst
>>  create mode 100644 drivers/hwtracing/ptt/Kconfig
>>  create mode 100644 drivers/hwtracing/ptt/Makefile
>>  create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
>>  create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
>>  create mode 100644 tools/perf/arch/arm64/util/hisi-ptt.c
>>  create mode 100644 tools/perf/util/hisi-ptt-decoder/Build
>>  create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
>>  create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
>>  create mode 100644 tools/perf/util/hisi-ptt.c
>>  create mode 100644 tools/perf/util/hisi-ptt.h
>>
>> --
>> 2.24.0
>>
