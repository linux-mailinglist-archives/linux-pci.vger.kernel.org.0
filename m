Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206303A3FC0
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 12:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhFKKGi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 06:06:38 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5506 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFKKGh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jun 2021 06:06:37 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G1bwT6sRkzZfyh;
        Fri, 11 Jun 2021 18:01:45 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 18:04:31 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 18:04:30 +0800
Subject: Re: [PATCH v6 0/2] drivers/perf: hisi: Add support for PCIe PMU
To:     Linuxarm <linuxarm@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhangshaokun@hisilicon.com>
References: <1622467951-32114-1-git-send-email-liuqi115@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <9a65847f-7467-f9c4-158a-93aca21ee203@huawei.com>
Date:   Fri, 11 Jun 2021 18:04:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1622467951-32114-1-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Will,

Gentle ping..
any comments for this ?

On 2021/5/31 21:32, Qi Liu wrote:
> This patchset adds support for HiSilicon PCIe Performance Monitoring
> Unit(PMU). It is a PCIe Root Complex integrated End Point(RCiEP) device
> added on Hip09. Each PCIe Core has a PMU RCiEP to monitor multi root
> ports and all Endpoints downstream these root ports.
> 
> HiSilicon PCIe PMU is supported to collect performance data of PCIe bus,
> such as: bandwidth, latency etc.
> 
> This patchset is based on 5.13-rc3.
> 
> Changes since v5:
> - Fix some errors when build under ARCH=xtensa.
> - Link: https://lore.kernel.org/linux-arm-kernel/1621946795-14046-1-git-send-email-liuqi115@huawei.com/
> 
> Changes since v4:
> - Replace irq_set_affinity_hint() with irq_set_affinity().
> - Link: https://lore.kernel.org/linux-arm-kernel/1621417741-5229-1-git-send-email-liuqi115@huawei.com/
> 
> Changes since v3:
> - Fix some warnings when build under 32bits architecture.
> - Address the comments from John.
> - Link: https://lore.kernel.org/linux-arm-kernel/1618490885-44612-1-git-send-email-liuqi115@huawei.com/
> 
> Changes since v2:
> - Address the comments from John.
> - Link: https://lore.kernel.org/linux-arm-kernel/1617959157-22956-1-git-send-email-liuqi115@huawei.com/
> 
> Changes since v1:
> - Drop the internal Reviewed-by tag.
> - Fix some build warnings when W=1.
> - Link: https://lore.kernel.org/linux-arm-kernel/1617788943-52722-1-git-send-email-liuqi115@huawei.com/
> 
> Qi Liu (2):
>    docs: perf: Add description for HiSilicon PCIe PMU driver
>    drivers/perf: hisi: Add driver for HiSilicon PCIe PMU
> 
>   Documentation/admin-guide/perf/hisi-pcie-pmu.rst |  104 +++
>   MAINTAINERS                                      |    6 +
>   drivers/perf/Kconfig                             |    2 +
>   drivers/perf/Makefile                            |    1 +
>   drivers/perf/pci/Kconfig                         |   16 +
>   drivers/perf/pci/Makefile                        |    2 +
>   drivers/perf/pci/hisilicon/Makefile              |    3 +
>   drivers/perf/pci/hisilicon/hisi_pcie_pmu.c       | 1019 ++++++++++++++++++++++
>   include/linux/cpuhotplug.h                       |    1 +
>   9 files changed, 1154 insertions(+)
>   create mode 100644 Documentation/admin-guide/perf/hisi-pcie-pmu.rst
>   create mode 100644 drivers/perf/pci/Kconfig
>   create mode 100644 drivers/perf/pci/Makefile
>   create mode 100644 drivers/perf/pci/hisilicon/Makefile
>   create mode 100644 drivers/perf/pci/hisilicon/hisi_pcie_pmu.c
> 

