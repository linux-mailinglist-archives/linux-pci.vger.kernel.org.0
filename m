Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275E23DF946
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 03:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhHDBdy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 21:33:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7777 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbhHDBdy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 21:33:54 -0400
Received: from dggeml757-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GfZ5B2QZ4zYkYR;
        Wed,  4 Aug 2021 09:33:34 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by dggeml757-chm.china.huawei.com
 (10.1.199.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 4 Aug
 2021 09:33:39 +0800
Subject: Re: [PATCH v5 0/3] PCI: Add a quirk to enable SVA for HiSilicon chip
To:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        <kenneth-lee-2012@foxmail.com>
References: <1626144876-11352-1-git-send-email-zhangfei.gao@linaro.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <8e821546-d8ee-7b61-c0b5-e9c13cf7e7cf@hisilicon.com>
Date:   Wed, 4 Aug 2021 09:33:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1626144876-11352-1-git-send-email-zhangfei.gao@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.87]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeml757-chm.china.huawei.com (10.1.199.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/7/13 10:54, Zhangfei Gao wrote:
> HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
> actually on the AMBA bus. These fake PCI devices have PASID capability
> though not supporting TLP.
> 
> Add a quirk to set pasid_no_tlp and dma-can-stall for these devices.
> 
> v5:
> no change, base on 5.14-rc1
> 
> v4: 
> Applied to Linux 5.13-rc2, and build successfully with only these three patches.
> 
> v3:
> https://lore.kernel.org/linux-pci/1615258837-12189-1-git-send-email-zhangfei.gao@linaro.org/
> Rebase to Linux 5.12-rc1
> Change commit msg adding:
> Property dma-can-stall depends on patchset
> https://lore.kernel.org/linux-iommu/20210302092644.2553014-1-jean-philippe@linaro.org/
> 
> By the way the patchset can directly applied on 5.12-rc1 and build successfully though
> without the dependent patchset.
> 
> v2:
> Add a new pci_dev bit: pasid_no_tlp, suggested by Bjorn 
> "Apparently these devices have a PASID capability.  I think you should
> add a new pci_dev bit that is specific to this idea of "PASID works
> without TLP prefixes" and then change pci_enable_pasid() to look at
> that bit as well as eetlp_prefix_path."
> https://lore.kernel.org/linux-pci/20210112170230.GA1838341@bjorn-Precision-5520/
> 
> Zhangfei Gao (3):
>   PCI: PASID can be enabled without TLP prefix
>   PCI: Add a quirk to set pasid_no_tlp for HiSilicon chips
>   PCI: Set dma-can-stall for HiSilicon chips
> 
>  drivers/pci/ats.c    |  2 +-
>  drivers/pci/quirks.c | 27 +++++++++++++++++++++++++++
>  include/linux/pci.h  |  1 +
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 

If there is no more comment, could we take this series in this loop?

Best,
Zhou


