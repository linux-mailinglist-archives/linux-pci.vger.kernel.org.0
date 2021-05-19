Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCACB388D20
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 13:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbhESLnR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 07:43:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3030 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbhESLnR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 07:43:17 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FlW8d3jmGzQnjG;
        Wed, 19 May 2021 19:38:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 19:41:54 +0800
Received: from [10.47.87.246] (10.47.87.246) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 19 May
 2021 12:41:52 +0100
Subject: Re: [PATCH v4 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     Qi Liu <liuqi115@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
References: <1621417741-5229-1-git-send-email-liuqi115@huawei.com>
 <1621417741-5229-3-git-send-email-liuqi115@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4c0f623b-fd0f-e13d-452a-7d72719ecaf8@huawei.com>
Date:   Wed, 19 May 2021 12:40:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1621417741-5229-3-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.246]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/05/2021 10:49, Qi Liu wrote:
> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
> to sample bandwidth, latency, buffer occupation etc.
> 
> Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
> registered as a PMU in /sys/bus/event_source/devices, so users can
> select target PMU, and use filter to do further sets.
> 
> Filtering options contains:
> event        - select the event.
> subevent     - select the subevent.
> port         - select target Root Ports. Information of Root Ports
>                 are shown under sysfs.
> bdf          - select requester_id of target EP device.
> trig_len     - set trigger condition for starting event statistics.
> trigger_mode - set trigger mode. 0 means starting to statistic when
>                 bigger than trigger condition, and 1 means smaller.
> thr_len      - set threshold for statistics.
> thr_mode     - set threshold mode. 0 means count when bigger than
>                 threshold, and 1 means smaller.
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Qi Liu <liuqi115@huawei.com>

JFYI, In light of this following series:
https://lore.kernel.org/linux-arm-kernel/87v97fccq9.ffs@nanos.tec.linutronix.de/

At some stage the irq_set_affinity_hint() calls need to be fixed up here 
as well.

Thanks,
John
