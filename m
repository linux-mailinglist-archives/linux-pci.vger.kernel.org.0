Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8514C2A4082
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 10:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgKCJo3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 04:44:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6694 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgKCJo3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 04:44:29 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQPxy1xWNz15QSh;
        Tue,  3 Nov 2020 17:44:22 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 17:44:22 +0800
Subject: Re: [PATCH v4 0/6] resource: introduce union(), intersection() API
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
References: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com>
 <1183267b-3e90-ab71-b1f6-7760ad0ca57c@huawei.com>
 <CAHp75VcEhdmU6NW8Dn-r7Aipden7vYda72nP3_LW09+jTFxOBg@mail.gmail.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <2c616805-6c35-8790-2e13-c18f0953edee@huawei.com>
Date:   Tue, 3 Nov 2020 17:44:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcEhdmU6NW8Dn-r7Aipden7vYda72nP3_LW09+jTFxOBg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/11/3 16:31, Andy Shevchenko wrote:
> On Tue, Nov 3, 2020 at 2:46 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>>
>> On 2020/11/3 5:00, Andy Shevchenko wrote:
>>> Some users may want to use resource library to manage their own resources,
>>> besides existing users that open code union() and intersection()
>>> implementations.
>>>
>>> Provide a generic API for wider use.
>>>
>>> Changelog v4:
>>> - added Rb tag (Rafael)
>>> - Cc'ed to LKML and Greg (Rafael)
>>>
>>> Changelog v3:
>>> - rebased on top of v5.10-rc1
>>> - dropped upstreamed dependencies
>>> - added Rb tag to the last patch (Mika)
>>>
>>> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: linux-pci@vger.kernel.org
>>>
>>> Andy Shevchenko (6):
>>>     resource: Simplify region_intersects() by reducing conditionals
>>>     resource: Group resource_overlaps() with other inline helpers
>>>     resource: Introduce resource_union() for overlapping resources
>>>     resource: Introduce resource_intersection() for overlapping resources
>>>     PCI/ACPI: Replace open coded variant of resource_union()
>>>     ACPI: watchdog: Replace open coded variant of resource_union()
>>>
>>>    drivers/acpi/acpi_watchdog.c |  6 +-----
>>>    drivers/acpi/pci_root.c      |  4 +---
>>>    include/linux/ioport.h       | 34 +++++++++++++++++++++++++++-------
>>>    kernel/resource.c            | 10 +++++-----
>>>    4 files changed, 34 insertions(+), 20 deletions(-)
>>
>> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> 
> Thanks. Is it for the entire series?

Yes.

By the way, I tested this patch set on a ARM64 machine booting
with ACPI against 5.10-rc2, and no regressions with PCI, so feel
free to add my Tested-by tag for patch [1,2,3,5/6].

Thanks
Hanjun
