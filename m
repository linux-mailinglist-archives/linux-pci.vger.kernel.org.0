Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60397050D2
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 16:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjEPOcs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 10:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjEPOcr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 10:32:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF3E7EDC;
        Tue, 16 May 2023 07:32:37 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QLJYz1BG0z67Y3j;
        Tue, 16 May 2023 22:30:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 16 May
 2023 15:32:34 +0100
Date:   Tue, 16 May 2023 15:32:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     <helgaas@kernel.org>, <yangyicong@huawei.com>, <will@kernel.org>,
        <baolin.wang@linux.alibaba.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <rdunlap@infradead.org>, <robin.murphy@arm.com>,
        <mark.rutland@arm.com>, <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v3 1/3] docs: perf: Add description for Synopsys
 DesignWare PCIe PMU driver
Message-ID: <20230516153233.000032f3@Huawei.com>
In-Reply-To: <20230417061729.84422-2-xueshuai@linux.alibaba.com>
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
        <20230417061729.84422-2-xueshuai@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 17 Apr 2023 14:17:27 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> Alibaba's T-Head Yitan 710 SoC is built on Synopsys' widely deployed and
> silicon-proven DesignWare Core PCIe controller which implements PMU for

Keep to most relevant facts in description only.  Something like:

Alibaba's T-Head Yitan 710 SoC includes Synopsys' DesignWare Core PCIe controller
which implements ...

Or ask for advertising fees from Synopsys :)


> performance and functional debugging to facilitate system maintenance.
> Document it to provide guidance on how to use it.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  .../admin-guide/perf/dwc_pcie_pmu.rst         | 61 +++++++++++++++++++
>  Documentation/admin-guide/perf/index.rst      |  1 +
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> 
> diff --git a/Documentation/admin-guide/perf/dwc_pcie_pmu.rst b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> new file mode 100644
> index 000000000000..0672e959ebe4
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> @@ -0,0 +1,61 @@
> +======================================================================
> +Synopsys DesignWare Cores (DWC) PCIe Performance Monitoring Unit (PMU)
> +======================================================================
> +
> +DesignWare Cores (DWC) PCIe PMU
> +===============================
> +
> +To facilitate collection of statistics, Synopsys DesignWare Cores PCIe
> +controller provides the following two features:
> +
> +- Time Based Analysis (RX/TX data throughput and time spent in each
> +  low-power LTSSM state)
> +- Lane Event counters (Error and Non-Error for lanes)
> +
> +The PMU is not a PCIe Root Complex integrated End Point (RCiEP) device but
> +only register counters provided by each PCIe Root Port.
> +
> +Time Based Analysis
> +-------------------
> +
> +Using this feature you can obtain information regarding RX/TX data
> +throughput and time spent in each low-power LTSSM state by the controller.
> +
> +The counters are 64-bit width and measure data in two categories,
> +
> +- percentage of time does the controller stay in LTSSM state in a
> +  configurable duration. The measurement range of each Event in Group#0.
> +- amount of data processed (Units of 16 bytes). The measurement range of
> +  each Event in Group#1.
> +
> +Lane Event counters
> +-------------------
> +
> +Using this feature you can obtain Error and Non-Error information in
> +specific lane by the controller.
> +
> +The counters are 32-bit width and the measured event is select by:
> +
> +- Group i
> +- Event j within the Group i
> +- and Lane k
> +
> +Some of the event counters only exist for specific configurations.
> +
> +DesignWare Cores (DWC) PCIe PMU Driver
> +=======================================
> +
> +This driver add PMU devices for each PCIe Root Port. And the PMU device is
> +named based the BDF of Root Port. For example,
> +
> +    30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
> +
> +the PMU device name for this Root Port is dwc_rootport_3018.
I'd suggest renaming to a scheme lie
dwc_rootport_30:03.0 
to save people remembering how to break up the BDF parts.
 
> +
> +Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
> +
> +    $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
> +
> +average RX bandwidth can be calculated like this:
> +
> +    PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window

Could consider an example of the other type of event, the error counters
you mention.

Otherwise, looks good to me.

Jonathan

> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 9de64a40adab..11a80cd28a2e 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -19,5 +19,6 @@ Performance monitor support
>     arm_dsu_pmu
>     thunderx2-pmu
>     alibaba_pmu
> +   dwc_pcie_pmu
>     nvidia-pmu
>     meson-ddr-pmu

