Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA607CD1BF
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 03:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjJRBUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 21:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJRBUA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 21:20:00 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F56B6;
        Tue, 17 Oct 2023 18:19:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VuOwKVH_1697591993;
Received: from 30.240.113.74(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VuOwKVH_1697591993)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 09:19:55 +0800
Message-ID: <af03c8cf-2254-46f6-9b7e-790b255c8a1b@linux.alibaba.com>
Date:   Wed, 18 Oct 2023 09:19:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v8 1/4] docs: perf: Add description for Synopsys
 DesignWare PCIe PMU driver
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        baolin.wang@linux.alibaba.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
References: <20231017013235.27831-1-xueshuai@linux.alibaba.com>
 <20231017013235.27831-2-xueshuai@linux.alibaba.com>
 <20231017101624.00003231@Huawei.com>
Content-Language: en-US
In-Reply-To: <20231017101624.00003231@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/17 17:16, Jonathan Cameron wrote:
> On Tue, 17 Oct 2023 09:32:32 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> Alibaba's T-Head Yitan 710 SoC includes Synopsys' DesignWare Core PCIe
>> controller which implements which implements PMU for performance and
>> functional debugging to facilitate system maintenance.
>>
>> Document it to provide guidance on how to use it.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> A few minor things inline and one question that I'd like a comment on
> for my understanding at least! (why not multiply the counter by 16 and
> make the maths simpler?)
> 
> With those tidied up,
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Thank you for providing prompt feedback and valuable comments to me.
(please also see my replies inline)

Best Regards,
Shuai

> 
> 
>> ---
>>  .../admin-guide/perf/dwc_pcie_pmu.rst         | 94 +++++++++++++++++++
>>  Documentation/admin-guide/perf/index.rst      |  1 +
>>  2 files changed, 95 insertions(+)
>>  create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
>>
>> diff --git a/Documentation/admin-guide/perf/dwc_pcie_pmu.rst b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
>> new file mode 100644
>> index 000000000000..eac1b6f36450
>> --- /dev/null
>> +++ b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
>> @@ -0,0 +1,94 @@
>> +======================================================================
>> +Synopsys DesignWare Cores (DWC) PCIe Performance Monitoring Unit (PMU)
>> +======================================================================
>> +
>> +DesignWare Cores (DWC) PCIe PMU
>> +===============================
>> +
>> +The PMU is a PCIe configuration space register block provided by each PCIe Root
>> +Port in a Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
>> +injection, and Statistics).
>> +
>> +As the name indicates, the RAS DES capability supports system level
>> +debugging, AER error injection, and collection of statistics. To facilitate
>> +collection of statistics, Synopsys DesignWare Cores PCIe controller
>> +provides the following two features:
>> +
>> +- one 64-bit counter for Time Based Analysis (RX/TX data throughput and
>> +  time spent in each low-power LTSSM state) and
>> +- one 32-bit counter for Event Counting (error and non-error events for
>> +  a specified lane)
>> +
>> +Note: There is no interrupt for counter overflow.
>> +
>> +Time Based Analysis
>> +-------------------
>> +
>> +Using this feature you can obtain information regarding RX/TX data
>> +throughput and time spent in each low-power LTSSM state by the controller.
>> +The PMU measures data in two categories:
>> +
>> +- Group#0: Percentage of time the controller stays in LTSSM states.
>> +- Group#1: Amount of data processed (Units of 16 bytes).
>> +
>> +Lane Event counters
>> +-------------------
>> +
>> +Using this feature you can obtain Error and Non-Error information in
>> +specific lane by the controller. The PMU event is select by:
>> +
>> +- Group i
>> +- Event j within the Group i
>> +- and Lane k
> The and here is a little confusing. I'd rework as
> The PMU event is selected by all of:
> - Group i
> - Event j within the Group i
> - Lane k

Will rework it in next version.

> 
>> +
>> +Some of the event only exist for specific configurations.
> 
> events

Sorry for typo, will fix it.

> 
>> +
>> +DesignWare Cores (DWC) PCIe PMU Driver
>> +=======================================
>> +
>> +This driver adds PMU devices for each PCIe Root Port named based on the BDF of
>> +the Root Port. For example,
>> +
>> +    30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>> +
>> +the PMU device name for this Root Port is dwc_rootport_3018.
>> +
>> +The DWC PCIe PMU driver registers a perf PMU driver, which provides
>> +description of available events and configuration options in sysfs, see
>> +/sys/bus/event_source/devices/dwc_rootport_{bdf}.
>> +
>> +The "format" directory describes format of the config fields of the
>> +perf_event_attr structure. The "events" directory provides configuration
>> +templates for all documented events.  For example,
>> +"Rx_PCIe_TLP_Data_Payload" is an equivalent of "eventid=0x22,type=0x1".
>> +
>> +The "perf list" command shall list the available events from sysfs, e.g.::
>> +
>> +    $# perf list | grep dwc_rootport
>> +    <...>
>> +    dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/        [Kernel PMU event]
>> +    <...>
>> +    dwc_rootport_3018/rx_memory_read,lane=?/               [Kernel PMU event]
>> +
>> +Time Based Analysis Event Usage
>> +-------------------------------
>> +
>> +Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
>> +
>> +    $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>> +
>> +The average RX/TX bandwidth can be calculated using the following formula:
>> +
>> +    PCIe RX Bandwidth = PCIE_RX_DATA * 16B / Measure_Time_Window
>> +    PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
> 
> Silly question (sorry I didn't raise it earlier) but can we make the interface
> more intuitive by just multiplying the counter value at point of read by 16?

Really a good suggestion, and it is very convenient for end perf users.
But the unit of 16 is only applied to group#1 as described in Time Based Analysis
section.

So I prefer to left the unit part to end users.
