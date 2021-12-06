Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74D046960E
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 13:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243518AbhLFM7i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 07:59:38 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28276 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243496AbhLFM7e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 07:59:34 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J73MC6l8kzbjKq;
        Mon,  6 Dec 2021 20:55:51 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 20:56:02 +0800
CC:     <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
        <helgaas@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <lorenzo.pieralisi@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>,
        <daniel.thompson@linaro.org>, <john.garry@huawei.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v2 1/6] iommu: Export iommu_{get,put}_resv_regions()
To:     Joerg Roedel <joro@8bytes.org>
References: <20211116090625.53702-1-yangyicong@hisilicon.com>
 <20211116090625.53702-2-yangyicong@hisilicon.com>
 <Ya36ZSG1LFjhGGfO@8bytes.org>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <0a15d8f3-5c86-2e44-6cd3-bbd853835f26@hisilicon.com>
Date:   Mon, 6 Dec 2021 20:56:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <Ya36ZSG1LFjhGGfO@8bytes.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/12/6 19:56, Joerg Roedel wrote:
> On Tue, Nov 16, 2021 at 05:06:20PM +0800, Yicong Yang wrote:
>> Export iommu_{get,put}_resv_regions() to the modules so that the driver
>> can retrieve and use the reserved regions of the device.
> 
> Why should any driver bother? These functions are only used by the iommu
> core to call into iommu drivers to get information about needed direct
> mappings. Why drivers need this information belongs into this commit
> message.
> 

Our driver makes use of RMR[1], so we need these APIs to retrieve the reserved
memory region in the driver. The device will store the traced data to
the rmr memory and the drivers needs to know the memory address for reading
the data. Due to some hardware limitation, the device can only use direct
mapping for DMA so we need RMR when the iommu is presented and the policy
of the iommu domain is not passthrough.

[1] https://lore.kernel.org/linux-acpi/20210805080724.480-1-shameerali.kolothum.thodi@huawei.com/

Thanks,
Yicong
