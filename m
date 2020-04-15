Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A72F1AA379
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 15:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504632AbgDONKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 09:10:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2505981AbgDONKL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 09:10:11 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9B3CF165915F79B5C852;
        Wed, 15 Apr 2020 21:10:07 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.195) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Apr 2020
 21:09:57 +0800
Subject: Re: [PATCH] PCI: dwc: intel: make intel_pcie_cpu_addr() static
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     <lorenzo.pieralisi@arm.com>, <amurray@thegoodpenguin.co.uk>,
        <bhelgaas@google.com>, <p.zabel@pengutronix.de>,
        <gustavo.pimentel@synopsys.com>, <eswara.kota@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
References: <20200415084953.6533-1-yanaijie@huawei.com>
 <20200415100742.GR34613@smile.fi.intel.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <29bc09ef-6e81-9411-302c-50ee9314764b@huawei.com>
Date:   Wed, 15 Apr 2020 21:09:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200415100742.GR34613@smile.fi.intel.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.195]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ÔÚ 2020/4/15 18:07, Andy Shevchenko Ð´µÀ:
> On Wed, Apr 15, 2020 at 04:49:53PM +0800, Jason Yan wrote:
>> Fix the following sparse warning:
>>
>> drivers/pci/controller/dwc/pcie-intel-gw.c:456:5: warning: symbol
>> 'intel_pcie_cpu_addr' was not declared. Should it be static?
> 
> Please, learn how to use get_maintainers.pl to avoid spamming people.
> Hint:
> 	scripts/get_maintainer.pl --git --git-min-percent=67
> would give advantage, though it still requires a common sense to be applied.
> 

I'm so sorry to bother you with this. I will be more careful when I'm
sending patches.

Thanks,

Jason

