Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3692388D29
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 13:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352188AbhESLq2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 07:46:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3423 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbhESLq2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 07:46:28 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FlWF80HVkzCsYX;
        Wed, 19 May 2021 19:42:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 19:45:05 +0800
Received: from [10.47.87.246] (10.47.87.246) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 19 May
 2021 12:45:03 +0100
Subject: Re: [PATCH v4 1/2] docs: perf: Add description for HiSilicon PCIe PMU
 driver
To:     Qi Liu <liuqi115@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
References: <1621417741-5229-1-git-send-email-liuqi115@huawei.com>
 <1621417741-5229-2-git-send-email-liuqi115@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b6988fa7-a1e6-90c2-1c76-7795a0bc4c0a@huawei.com>
Date:   Wed, 19 May 2021 12:44:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1621417741-5229-2-git-send-email-liuqi115@huawei.com>
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
> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported on
> HiSilicon HIP09 platform. Document it to provide guidance on how to
> use it.
> 
> Signed-off-by: Qi Liu<liuqi115@huawei.com>

Reviewed-by: John Garry <john.garry@huawei.com>

JFYI, perf tool iostat support is in 5.13-rc1, so we can look to add 
support for this HW as well in future.

My impression is that we should use metricgroups.

Thanks,
John
