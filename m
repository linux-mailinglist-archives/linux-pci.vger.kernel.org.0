Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C28423FCB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 16:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhJFOIl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 10:08:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3938 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhJFOIk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Oct 2021 10:08:40 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HPbl84kNTz67vYw;
        Wed,  6 Oct 2021 22:03:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 6 Oct 2021 16:06:46 +0200
Received: from localhost (10.52.120.239) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 6 Oct 2021
 15:06:46 +0100
Date:   Wed, 6 Oct 2021 15:06:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Qi Liu <liuqi115@huawei.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: Re: [PATCH v10 2/2] drivers/perf: hisi: Add driver for HiSilicon
 PCIe PMU
Message-ID: <20211006150628.00007cbf@Huawei.com>
In-Reply-To: <20210915074524.18040-3-liuqi115@huawei.com>
References: <20210915074524.18040-1-liuqi115@huawei.com>
        <20210915074524.18040-3-liuqi115@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.239]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 15 Sep 2021 15:45:24 +0800
Qi Liu <liuqi115@huawei.com> wrote:

> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
> to sample bandwidth, latency, buffer occupation etc.
> 
> Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
> registered as a PMU in /sys/bus/event_source/devices, so users can
> select target PMU, and use filter to do further sets.
> 
> Filtering options contains:
> event     - select the event.
> port      - select target Root Ports. Information of Root Ports are
>             shown under sysfs.
> bdf       - select requester_id of target EP device.
> trig_len  - set trigger condition for starting event statistics.
> trig_mode - set trigger mode. 0 means starting to statistic when bigger
>             than trigger condition, and 1 means smaller.
> thr_len   - set threshold for statistics.
> thr_mode  - set threshold mode. 0 means count when bigger than threshold,
>             and 1 means smaller.
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
Hi Qi,

One trivial thing I just noticed below that can be easily fixed up by a follow up
patch if that makes sense.

Thanks,

Jonathan

> +/*
> + * Events with the "dl" suffix in their names count performance in DL layer,
> + * otherswise, events count performance in TL layer.

This comment looks to be out of date..

> + */
> +static struct attribute *hisi_pcie_pmu_events_attr[] = {
> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mwr_latency, 0x0010),
> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mwr_cnt, 0x10010),
> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_latency, 0x0210),
> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_cnt, 0x10210),
> +	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_latency, 0x0011),
> +	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_cnt, 0x10011),
> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_flux, 0x1005),
> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_time, 0x11005),
> +	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_flux, 0x2004),
> +	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_time, 0x12004),
> +	NULL
> +};
