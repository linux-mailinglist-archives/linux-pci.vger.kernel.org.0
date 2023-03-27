Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE756CA1A6
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 12:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjC0Kt7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 06:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0Kt6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 06:49:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E36FE;
        Mon, 27 Mar 2023 03:49:57 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PlV0w4BMfzrVZw;
        Mon, 27 Mar 2023 18:48:48 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 18:49:54 +0800
CC:     <yangyicong@hisilicon.com>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 0/4] Improve PTT filter interface and some fixes
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <jonathan.cameron@huawei.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20230315094316.26772-1-yangyicong@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <d496ee4f-641a-a726-ab3f-62b587422b61@huawei.com>
Date:   Mon, 27 Mar 2023 18:49:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230315094316.26772-1-yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A gentle ping...

Thanks.

On 2023/3/15 17:43, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> This series tends to improve the PTT's filter interface in 2 aspects (Patch 2&3):
> - Support dynamically filter updating to response to hotplug
>   Previous the supported filter list is settled down once the driver probed and
>   it maybe out-of-date if hotplug events happen later. User need to reload the
>   driver to update list. Patch 1/2 enable the driver to update the list by
>   registering a PCI bus notifier and the filter list will always be the latest.
> - Export the available filters through sysfs
>   Previous user needs to calculate the filters and filter value using device's
>   BDF number, which requires the user to know the hardware well. Patch 3/3 tends
>   to export the available filter information through sysfs attributes, the filter
>   value will be gotten by reading the file. This will be more user friendly.
> 
> Also includes a fix and an improve. Patch 1 tends to only export the online CPUs
> supported by the PTT, this will make perf work properly when there's offline CPUs
> within the node PTT locates. Patch 4 tends to set proper PMU capability to avoid
> collecting unnecessary data to save the storage.
> 
> Yicong Yang (4):
>   hwtracing: hisi_ptt: Make cpumask only present online CPUs
>   hwtracing: hisi_ptt: Add support for dynamically updating the filter
>     list
>   hwtracing: hisi_ptt: Export available filters through sysfs
>   hwtracing: hisi_ptt: Advertise PERF_PMU_CAP_NO_EXCLUDE for PTT PMU
> 
>  .../ABI/testing/sysfs-devices-hisi_ptt        |  50 +++
>  Documentation/trace/hisi-ptt.rst              |  12 +-
>  drivers/hwtracing/ptt/hisi_ptt.c              | 396 +++++++++++++++++-
>  drivers/hwtracing/ptt/hisi_ptt.h              |  51 +++
>  4 files changed, 498 insertions(+), 11 deletions(-)
> 
