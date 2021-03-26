Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721C8349E4A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 01:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhCZA7F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 20:59:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14904 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCZA6i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 20:58:38 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F63TG0hWkzkfrd;
        Fri, 26 Mar 2021 08:56:50 +0800 (CST)
Received: from [10.174.177.160] (10.174.177.160) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 08:58:25 +0800
Subject: Re: [PATCH 2/4] PCI/AER: Correct function names in the header
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, <ruscur@russell.cc>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210325075144.180030-1-wangxiongfeng2@huawei.com>
 <20210325075144.180030-3-wangxiongfeng2@huawei.com>
 <CAJZ5v0hgsuv8NwuhtK4CrdjPT_VMz1Dp4bDeYtEQs3qeJN_Uhg@mail.gmail.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <39a66394-cd74-ebff-7447-cb9fa51d8db4@huawei.com>
Date:   Fri, 26 Mar 2021 08:58:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hgsuv8NwuhtK4CrdjPT_VMz1Dp4bDeYtEQs3qeJN_Uhg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.160]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael,

On 2021/3/26 1:30, Rafael J. Wysocki wrote:
> On Thu, Mar 25, 2021 at 8:50 AM Xiongfeng Wang
> <wangxiongfeng2@huawei.com> wrote:
>>
>> Fixes the following W=1 kernel build warning(s):
>>
>>  drivers/pci/pcie/aer.c:138: warning: expecting prototype for enable_ercr_checking(). Prototype was for enable_ecrc_checking() instead
>>  drivers/pci/pcie/aer.c:162: warning: expecting prototype for disable_ercr_checking(). Prototype was for disable_ecrc_checking() instead
>>  drivers/pci/pcie/aer.c:1450: warning: expecting prototype for aer_service_init(). Prototype was for pcie_aer_init() instead
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> 
> The subject is somewhat inaccurate, because you're fixing function
> names in kerneldoc comments.
> 
> If you say "a header", people may think that this is about a header file.

Thanks a lot ! I will change it in the next version.

Thanks,
Xiongfeng

> 
>> ---
>>  drivers/pci/pcie/aer.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index ba22388342d1..ec943cee5ecc 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -129,7 +129,7 @@ static const char * const ecrc_policy_str[] = {
>>  };
>>
>>  /**
>> - * enable_ercr_checking - enable PCIe ECRC checking for a device
>> + * enable_ecrc_checking - enable PCIe ECRC checking for a device
>>   * @dev: the PCI device
>>   *
>>   * Returns 0 on success, or negative on failure.
>> @@ -153,7 +153,7 @@ static int enable_ecrc_checking(struct pci_dev *dev)
>>  }
>>
>>  /**
>> - * disable_ercr_checking - disables PCIe ECRC checking for a device
>> + * disable_ecrc_checking - disables PCIe ECRC checking for a device
>>   * @dev: the PCI device
>>   *
>>   * Returns 0 on success, or negative on failure.
>> @@ -1442,7 +1442,7 @@ static struct pcie_port_service_driver aerdriver = {
>>  };
>>
>>  /**
>> - * aer_service_init - register AER root service driver
>> + * pcie_aer_init - register AER root service driver
>>   *
>>   * Invoked when AER root service driver is loaded.
>>   */
>> --
>> 2.20.1
>>
> .
> 
