Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED7F705C67
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 03:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjEQB1w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 21:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEQB1w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 21:27:52 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E02D1BD3;
        Tue, 16 May 2023 18:27:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0ViqTTPH_1684286865;
Received: from 30.240.113.228(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0ViqTTPH_1684286865)
          by smtp.aliyun-inc.com;
          Wed, 17 May 2023 09:27:46 +0800
Message-ID: <5fceacaa-7bc4-53d3-2bb5-68a8bea9462a@linux.alibaba.com>
Date:   Wed, 17 May 2023 09:27:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/3] docs: perf: Add description for Synopsys
 DesignWare PCIe PMU driver
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        robin.murphy@arm.com, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
 <20230417061729.84422-2-xueshuai@linux.alibaba.com>
 <20230516153233.000032f3@Huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230516153233.000032f3@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/5/16 22:32, Jonathan Cameron wrote:
> On Mon, 17 Apr 2023 14:17:27 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> Alibaba's T-Head Yitan 710 SoC is built on Synopsys' widely deployed and
>> silicon-proven DesignWare Core PCIe controller which implements PMU for
> 
> Keep to most relevant facts in description only.  Something like:
> 
> Alibaba's T-Head Yitan 710 SoC includes Synopsys' DesignWare Core PCIe controller
> which implements ...
> 
> Or ask for advertising fees from Synopsys :)

Haha, I will keep it more simple facts.

> 
> 
>> performance and functional debugging to facilitate system maintenance.
>> Document it to provide guidance on how to use it.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>  .../admin-guide/perf/dwc_pcie_pmu.rst         | 61 +++++++++++++++++++
>>  Documentation/admin-guide/perf/index.rst      |  1 +
>>  2 files changed, 62 insertions(+)
>>  create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
>>
>> diff --git a/Documentation/admin-guide/perf/dwc_pcie_pmu.rst b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
>> new file mode 100644
>> index 000000000000..0672e959ebe4
>> --- /dev/null
>> +++ b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
>> @@ -0,0 +1,61 @@
>> +======================================================================
>> +Synopsys DesignWare Cores (DWC) PCIe Performance Monitoring Unit (PMU)
>> +======================================================================
>> +
>> +DesignWare Cores (DWC) PCIe PMU
>> +===============================
>> +
>> +To facilitate collection of statistics, Synopsys DesignWare Cores PCIe
>> +controller provides the following two features:
>> +
>> +- Time Based Analysis (RX/TX data throughput and time spent in each
>> +  low-power LTSSM state)
>> +- Lane Event counters (Error and Non-Error for lanes)
>> +
>> +The PMU is not a PCIe Root Complex integrated End Point (RCiEP) device but
>> +only register counters provided by each PCIe Root Port.
>> +
>> +Time Based Analysis
>> +-------------------
>> +
>> +Using this feature you can obtain information regarding RX/TX data
>> +throughput and time spent in each low-power LTSSM state by the controller.
>> +
>> +The counters are 64-bit width and measure data in two categories,
>> +
>> +- percentage of time does the controller stay in LTSSM state in a
>> +  configurable duration. The measurement range of each Event in Group#0.
>> +- amount of data processed (Units of 16 bytes). The measurement range of
>> +  each Event in Group#1.
>> +
>> +Lane Event counters
>> +-------------------
>> +
>> +Using this feature you can obtain Error and Non-Error information in
>> +specific lane by the controller.
>> +
>> +The counters are 32-bit width and the measured event is select by:
>> +
>> +- Group i
>> +- Event j within the Group i
>> +- and Lane k
>> +
>> +Some of the event counters only exist for specific configurations.
>> +
>> +DesignWare Cores (DWC) PCIe PMU Driver
>> +=======================================
>> +
>> +This driver add PMU devices for each PCIe Root Port. And the PMU device is
>> +named based the BDF of Root Port. For example,
>> +
>> +    30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>> +
>> +the PMU device name for this Root Port is dwc_rootport_3018.
> I'd suggest renaming to a scheme lie
> dwc_rootport_30:03.0 
> to save people remembering how to break up the BDF parts.
>  
>> +
>> +Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
>> +
>> +    $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>> +
>> +average RX bandwidth can be calculated like this:
>> +
>> +    PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
> 
> Could consider an example of the other type of event, the error counters
> you mention.

Sure, I will add an example to show how to use it.

> 
> Otherwise, looks good to me.
> 
> Jonathan

Thank you.

Best Regards.
Shuai


> 
>> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
>> index 9de64a40adab..11a80cd28a2e 100644
>> --- a/Documentation/admin-guide/perf/index.rst
>> +++ b/Documentation/admin-guide/perf/index.rst
>> @@ -19,5 +19,6 @@ Performance monitor support
>>     arm_dsu_pmu
>>     thunderx2-pmu
>>     alibaba_pmu
>> +   dwc_pcie_pmu
>>     nvidia-pmu
>>     meson-ddr-pmu
