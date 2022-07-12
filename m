Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C15C571E6F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 17:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiGLPKI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 11:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiGLPJl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 11:09:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CF9C84CD
        for <linux-pci@vger.kernel.org>; Tue, 12 Jul 2022 08:03:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eq6so10484432edb.6
        for <linux-pci@vger.kernel.org>; Tue, 12 Jul 2022 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDPLw2CbVZaDo90y78ZrmTMoMsL1dbAoIyq4iZ3QLaQ=;
        b=FiMvDWaVxtWeQZSnjHcv8TpobwCSd16qkxExux5EJFHid+NP2AZecH6+9Njbi8tftt
         Le02cSLfAh7FDtnY7S8oQKIofstWMtXlu0eqQnFq6eH0t5Grvg4UxQ8yqDUnkC9d+SaM
         QKHjc5tQXyQoymLLRl2plvcppSc/TS4Z6laIl8mOcVQw72TRYE4okUaP1/W1tuZ3MV7P
         +QRLmR6YUxcYHWV7jKd8eLs74QR9r/TB3tV6w4GEHjM07f8P5f8PhHcg/FKryFvb2xGU
         6FTJqIQuv4BaRmf314YXpFmTLpcwxdVwhNJ+Av3p9YRZsa3OtFBqZUB6OzbxFsyBfc1L
         RCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDPLw2CbVZaDo90y78ZrmTMoMsL1dbAoIyq4iZ3QLaQ=;
        b=iDCyyi18s/ZRbm51VMI+avMuDabIcbjUI8oTX92vduJV2gB91PWdLXVwh1pgZlRcWJ
         As9QyhSnCCbDYYeOG7MRvHrpo2MtellBcQ/CDWbvWXbRYH1SxBZfOcYV3ihJngZ1BEzl
         oFfOojBqMCERTa/Et8mcNfbyonU6mDaviGhG+7+6mTjHL1kZ4gNM18WbokTOziI/+hwa
         l0TIiKY3AGVl/aE3T5u1WNkAuRn69USWk49FgvA44omE/eNmjmRqw2/eO0+jc5//cXP3
         5PwdzjTwVGzbTnve+HyhHskvoi2PUxANuQsaU53TVojndL+7AUBq11ouRHcfx0Dy+CI7
         kV7A==
X-Gm-Message-State: AJIora96AIx8L2cL6b6gwsh0TTVIphxH0l5B1869uzVsz5m0nIFaouSr
        onSsf2SEN81rlULh14v6rQPASsRcDXXYyBBTaeIe+A==
X-Google-Smtp-Source: AGRyM1sQ6a3UF0OjQq1pjj4JvllJzEy59o8mAN3Hz+12m9ylyQfskPBfyoOlEs8MKR84teFB3F51TwIdUescqfxv4so=
X-Received: by 2002:a05:6402:3214:b0:43a:b36f:a0b4 with SMTP id
 g20-20020a056402321400b0043ab36fa0b4mr28655679eda.122.1657638189876; Tue, 12
 Jul 2022 08:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <20220606115555.41103-8-yangyicong@hisilicon.com> <20220706175751.GA2546265@p14s>
 <75afb15e-9fc2-d14a-c72d-dc33589cfc0e@huawei.com> <20220707162015.GA2609651@p14s>
 <0569c6e2-48b2-9d9e-a8cc-971e41d78365@huawei.com>
In-Reply-To: <0569c6e2-48b2-9d9e-a8cc-971e41d78365@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 12 Jul 2022 09:02:57 -0600
Message-ID: <CANLsYkx+NxOfrcBfpkor7ZgTTD35Kiy_qMP4AikKQNRzn5wvzg@mail.gmail.com>
Subject: Re: [PATCH v9 7/8] docs: trace: Add HiSilicon PTT device driver documentation
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     yangyicong@hisilicon.com, gregkh@linuxfoundation.org,
        alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        james.clark@arm.com, will@kernel.org, robin.murphy@arm.com,
        acme@kernel.org, jonathan.cameron@huawei.com,
        john.garry@huawei.com, helgaas@kernel.org,
        lorenzo.pieralisi@arm.com, suzuki.poulose@arm.com,
        mark.rutland@arm.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
        prime.zeng@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com, corbet@lwn.net,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 12 Jul 2022 at 06:38, Yicong Yang <yangyicong@huawei.com> wrote:
>
> On 2022/7/8 0:20, Mathieu Poirier wrote:
> > On Thu, Jul 07, 2022 at 07:43:21PM +0800, Yicong Yang wrote:
> >> On 2022/7/7 1:57, Mathieu Poirier wrote:
> >>> Hi,
> >>>
> >>> I have started looking at this set.
> >>
> >> Thanks!
> >>
> >>>
> >>> On Mon, Jun 06, 2022 at 07:55:54PM +0800, Yicong Yang wrote:
> >>>> Document the introduction and usage of HiSilicon PTT device driver.
> >>>>
> >>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>> ---
> >>>>  Documentation/trace/hisi-ptt.rst | 307 +++++++++++++++++++++++++++++++
> >>>>  Documentation/trace/index.rst    |   1 +
> >>>
> >>> The "get_maintainer" script clearly indicates that Jonathan Corbet maintains the
> >>> Documentation directory and yet he is not CC'ed on this patch, nor is the
> >>> linux-doc mainling list.  As such, it would not be possible to merge this
> >>> patchset.
> >>>
> >>
> >> sorry for missing. +cc'ed.
> >>
> >>>>  2 files changed, 308 insertions(+)
> >>>>  create mode 100644 Documentation/trace/hisi-ptt.rst
> >>>>
> >>>> diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
> >>>> new file mode 100644
> >>>> index 000000000000..0a3112244d40
> >>>> --- /dev/null
> >>>> +++ b/Documentation/trace/hisi-ptt.rst
> >>>> @@ -0,0 +1,307 @@
> >>>> +.. SPDX-License-Identifier: GPL-2.0
> >>>> +
> >>>> +======================================
> >>>> +HiSilicon PCIe Tune and Trace device
> >>>> +======================================
> >>>> +
> >>>> +Introduction
> >>>> +============
> >>>> +
> >>>> +HiSilicon PCIe tune and trace device (PTT) is a PCIe Root Complex
> >>>> +integrated Endpoint (RCiEP) device, providing the capability
> >>>> +to dynamically monitor and tune the PCIe link's events (tune),
> >>>> +and trace the TLP headers (trace). The two functions are independent,
> >>>> +but is recommended to use them together to analyze and enhance the
> >>>> +PCIe link's performance.
> >>>> +
> >>>> +On Kunpeng 930 SoC, the PCIe Root Complex is composed of several
> >>>> +PCIe cores. Each PCIe core includes several Root Ports and a PTT
> >>>> +RCiEP, like below. The PTT device is capable of tuning and
> >>>> +tracing the links of the PCIe core.
> >>>> +::
> >>>> +
> >>>> +          +--------------Core 0-------+
> >>>> +          |       |       [   PTT   ] |
> >>>> +          |       |       [Root Port]---[Endpoint]
> >>>> +          |       |       [Root Port]---[Endpoint]
> >>>> +          |       |       [Root Port]---[Endpoint]
> >>>> +    Root Complex  |------Core 1-------+
> >>>> +          |       |       [   PTT   ] |
> >>>> +          |       |       [Root Port]---[ Switch ]---[Endpoint]
> >>>> +          |       |       [Root Port]---[Endpoint] `-[Endpoint]
> >>>> +          |       |       [Root Port]---[Endpoint]
> >>>> +          +---------------------------+
> >>>> +
> >>>> +The PTT device driver registers one PMU device for each PTT device.
> >>>> +The name of each PTT device is composed of 'hisi_ptt' prefix with
> >>>> +the id of the SICL and the Core where it locates. The Kunpeng 930
> >>>> +SoC encapsulates multiple CPU dies (SCCL, Super CPU Cluster) and
> >>>> +IO dies (SICL, Super I/O Cluster), where there's one PCIe Root
> >>>> +Complex for each SICL.
> >>>> +::
> >>>> +
> >>>> +    /sys/devices/hisi_ptt<sicl_id>_<core_id>
> >>>
> >>> All entries added to sysfs should have corresponding documentation.  See [1] and
> >>> [2] for details and [3] for an example.
> >>>
> >>> [1]. https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/README
> >>> [2]. https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing
> >>> [3]. https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> >>>
> >>
> >> ok. I'll add a patch for ABI description. Thanks for the reference.
> >>
> >>>> +
> >>>> +Tune
> >>>> +====
> >>>> +
> >>>> +PTT tune is designed for monitoring and adjusting PCIe link parameters (events).
> >>>> +Currently we support events in 4 classes. The scope of the events
> >>>> +covers the PCIe core to which the PTT device belongs.
> >>>> +
> >>>> +Each event is presented as a file under $(PTT PMU dir)/tune, and
> >>>> +a simple open/read/write/close cycle will be used to tune the event.
> >>>> +::
> >>>> +
> >>>> +    $ cd /sys/devices/hisi_ptt<sicl_id>_<core_id>/tune
> >>>> +    $ ls
> >>>> +    qos_tx_cpl    qos_tx_np    qos_tx_p
> >>>> +    tx_path_rx_req_alloc_buf_level
> >>>> +    tx_path_tx_req_alloc_buf_level
> >>>
> >>> These look overly long... How about watermark_rx and watermark_tx?
> >>>
> >>
> >> These are gotten from the hardware manual and abbreviated. These events are highly connected
> >> to the hardware desgin so I think it's better to keep consistence. The watermark_{rx, tx} will
> >> become ambigious when we add more events for Rx path or other Tx path events.
> >>
> >> The event code is composed of two parts. First part (tx_path) describes which path it belongs to
> >> and second part describes the function ({rx,tx}_req_alloc_buf_level). We called the link path
> >> between CPU and PCIe RC as Rx path and the path between PCIe RC to the PCIe link as Tx path.
> >> So we need to have tx_path prefix for the Tx path and {rx, tx}_req_alloc_buf_level for the
> >> requested watermark of {inbound, outbound} buffer allocation. Indeed we have other Tx path
> >> buffer events which are not exported in this series.
> >>
> >
> > I will not be maintaining nor using this driver so the choice is entirely yours.
> > That being said the end result is the same - those names are, in my opinion, too
> > long.
> >
> >>
> >>>> +    $ cat qos_tx_dp
> >>>> +    1
> >>>> +    $ echo 2 > qos_tx_dp
> >>>> +    $ cat qos_tx_dp
> >>>> +    2
> >>>> +
> >>>> +Current value (numerical value) of the event can be simply read
> >>>> +from the file, and the desired value written to the file to tune.
> >>>> +
> >>>> +1. Tx path QoS control
> >>>> +------------------------
> >>>> +
> >>>> +The following files are provided to tune the QoS of the tx path of
> >>>> +the PCIe core.
> >>>> +
> >>>> +- qos_tx_cpl: weight of Tx completion TLPs
> >>>> +- qos_tx_np: weight of Tx non-posted TLPs
> >>>> +- qos_tx_p: weight of Tx posted TLPs
> >>>> +
> >>>> +The weight influences the proportion of certain packets on the PCIe link.
> >>>> +For example, for the storage scenario, increase the proportion
> >>>> +of the completion packets on the link to enhance the performance as
> >>>> +more completions are consumed.
> >>>> +
> >>>> +The available tune data of these events is [0, 1, 2].
> >>>> +Writing a negative value will return an error, and out of range
> >>>> +values will be converted to 2. Note that the event value just
> >>>> +indicates a probable level, but is not precise.
> >>>> +
> >>>> +2. Tx path buffer control
> >>>> +-------------------------
> >>>> +
> >>>> +Following files are provided to tune the buffer of tx path of the PCIe core.
> >>>> +
> >>>> +- tx_path_rx_req_alloc_buf_level: watermark of Rx requested
> >>>> +- tx_path_tx_req_alloc_buf_level: watermark of Tx requested
> >>>> +
> >>>> +These events influence the watermark of the buffer allocated for each
> >>>> +type. Rx means the inbound while Tx means outbound. The packets will
> >>>> +be stored in the buffer first and then transmitted either when the
> >>>> +watermark reached or when timed out. For a busy direction, you should
> >>>> +increase the related buffer watermark to avoid frequently posting and
> >>>> +thus enhance the performance. In most cases just keep the default value.
> >>>> +
> >>>> +The available tune data of above events is [0, 1, 2].
> >>>> +Writing a negative value will return an error, and out of range
> >>>> +values will be converted to 2. Note that the event value just
> >>>> +indicates a probable level, but is not precise.
> >>>
> >>> This is useful documentation but it also should be found in the ABI
> >>> documentation referred to above.
> >>>
> >>>> +
> >>>> +Trace
> >>>> +=====
> >>>> +
> >>>> +PTT trace is designed for dumping the TLP headers to the memory, which
> >>>> +can be used to analyze the transactions and usage condition of the PCIe
> >>>> +Link. You can choose to filter the traced headers by either requester ID,
> >>>> +or those downstream of a set of Root Ports on the same core of the PTT
> >>>> +device. It's also supported to trace the headers of certain type and of
> >>>> +certain direction.
> >>>> +
> >>>> +You can use the perf command `perf record` to set the parameters, start
> >>>> +trace and get the data. It's also supported to decode the trace
> >>>> +data with `perf report`. The control parameters for trace is inputted
> >>>> +as event code for each events, which will be further illustrated later.
> >>>> +An example usage is like
> >>>> +::
> >>>> +
> >>>> +    $ perf record -e hisi_ptt0_2/filter=0x80001,type=1,direction=1,
> >>>> +      format=1/ -- sleep 5
> >>>> +
> >>>> +This will trace the TLP headers downstream root port 0000:00:10.1 (event
> >>>> +code for event 'filter' is 0x80001) with type of posted TLP requests,
> >>>> +direction of inbound and traced data format of 8DW.
> >>>> +
> >>>> +1. filter
> >>>> +---------
> >>>> +
> >>>> +The TLP headers to trace can be filtered by the Root Ports or the requester
> >>>> +ID of the endpoints, which are located on the same core of the PTT device.
> >>>> +You can set the filter by specifying the `filter` parameter which is required
> >>>> +to start the trace. The parameter value is 20 bit. The supported filters and
> >>>> +related values are outputted through `available_root_port_filters` and
> >>>> +`available_requester_filters` sysfs attributes for Root Ports and Requesters
> >>>> +respectively.
> >>>> +::
> >>>> +
> >>>> +    $ cat available_root_port_filters
> >>>> +    0000:00:10.0  0x80001
> >>>> +    0000:00:11.0  0x80004
> >>>> +    $ cat available_requester_filters
> >>>> +    0000:01:00.0  0x00100
> >>>> +    0000:01:00.1  0x00101
> >>>
> >>> If I remember correctly, one of the rule for sysfs is one line per entry.
> >>>
> >>
> >> Since one PTT devices may support several Root Ports and Endpoints on its core, I find no better
> >> way to make this information convenient and easy to use for the users to collect. So maybe this
> >> canbe an exception and there seems to have some limited examples like
> >> /sys/devices/system/node/node<N>/{meminfo, vmstat, meminfo}.
> >
> > You can either find a better solution or argue the matter with Greg.  I suggest
> > to introduce new directories, i.e "root_port_filters" and "requested_filters"
> > and under those have entries like "port0", "port1" and so on.
> >
>
> Thanks for the suggestion and it does make sense to me. But I've tried it and met some problems.
> I intended to create two attribute groups for each kind of filter and create attribute for each
> available filter. like:
>
> $ ls root_port_filters    # each filter exists as an sysfs attribute
> 0000:00:10.0 0000:00:11.0
> $ cat root_port_filters/0000:00:10.0    # read the attribute get the filter value
> 0x80001
>
> In pratice we may have no filter for certain types, for example no endpoint found on this PCIe
> core then we'll have no filter attributes under requester_filters directory. Or if endpoint
> devices are hot removed or manually removed through sysfs by the user, the filter attributes
> will be created/destroyed dynamically (will support following this series, an implementation
> will be like in [1]) which may make the directory empty. But sysfs won't allow to have an
> empty attribute group, restricted in [2].
>

My comment was not meant to provide a solution but to highlight
alternative options.  There are a lot of sysfs examples in the kernel
for you to look at.

> [1] https://lore.kernel.org/lkml/20220407125841.3678-4-yangyicong@hisilicon.com/
> [2] https://github.com/torvalds/linux/blob/5cf3bb0d3a2d0de94f3f551f0e4211068818aabf/fs/sysfs/group.c#L121
>
> >>
> >>>> +
> >>>> +Note that multiple Root Ports can be specified at one time, but only
> >>>> +one Endpoint function can be specified in one trace. Specifying both
> >>>> +Root Port and function at the same time is not supported.
> >>>> +
> >>>> +If no filter is available, reading the related filter sysfs attribute
> >>>> +will get an empty string.
> >>>> +::
> >>>> +
> >>>> +    $ cat available_root_port_filters
> >>>> +
> >>>> +    $ cat available_requester_filters
> >>>
> >>> Those too look overly long, and where to find them is not documented.  As such
> >>> users have to guest that it must be somewhere under
> >>> /sys/devices/hisi_ptt<sicl_id>_<core_id>/.
> >>>
> >>
> >> Since Root Port and Requester are PCIe terminologies so it's better to have them
> >> embedded to make it clear. Maybe 'available' can be removed.
> >>
> >> Will have all these sysfs attributes documented.
> >>
> >>> More comments tomorrow.
> >>>
> >>
> >> Thanks,
> >> Yicong
> > .
> >
