Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B39528C3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 11:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfFYJ5r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 05:57:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33031 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfFYJ5r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 05:57:47 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id ED49D12DE61E0138AA32;
        Tue, 25 Jun 2019 10:57:45 +0100 (IST)
Received: from [127.0.0.1] (10.202.227.157) by LHREML713-CAH.china.huawei.com
 (10.201.108.36) with Microsoft SMTP Server id 14.3.408.0; Tue, 25 Jun 2019
 10:57:37 +0100
Subject: Re: [PATCH v2 0/6] Fixes for HiSilicon LPC driver and logical PIO
 code
To:     John Garry <john.garry@huawei.com>, <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <rjw@rjwysocki.net>
References: <1561386908-31884-1-git-send-email-john.garry@huawei.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <162ae8fa-46a1-6962-27ad-672415e5cf53@hisilicon.com>
Date:   Tue, 25 Jun 2019 10:57:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1561386908-31884-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.157]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi John,

On 6/24/2019 3:35 PM, John Garry wrote:
> As reported in [1], the hisi-lpc driver has certain issues in handling
> logical PIO regions, specifically unregistering regions.
> 
> This series add a method to unregister a logical PIO region, and fixes up
> the driver to use them.
> 
> RCU usage in logical PIO code looks to always have been broken, so that
> is fixed also. This is not a major fix as the list which RCU protects
> would be rarely modified.
> 
> There is another patch to simplify logical PIO registration, made possible
> by the fixes.
> 
> At this point, there are still separate ongoing discussions about how to
> stop the logical PIO and PCI host bridge code leaking ranges, as in [2].
> 
> Hopefully this series can go through the arm soc tree and the maintainers
> have no issue with that. I'm talking specifically about the logical PIO
> code, which went through PCI tree on only previous upstreaming.

Thanks!
Series applied to the hisilicon fix tree.
But I am not sure it is proper for me to apply and send the pull request
for this patch set.
I will give it a try.

Best Regards,
Wei

> 
> Cc. linux-pci@vger.kernel.org
> 
> [1] https://lore.kernel.org/lkml/1560770148-57960-1-git-send-email-john.garry@huawei.com/
> [2] https://lore.kernel.org/lkml/4b24fd36-e716-7c5e-31cc-13da727802e7@huawei.com/
> 
> Changes since v1:
> - Add more reasoning in RCU fix patch
> - Create separate patch to change LOGIC_PIO_CPU_MMIO registration to
>   accomodate unregistration
> 
> John Garry (6):
>   lib: logic_pio: Fix RCU usage
>   lib: logic_pio: Avoid possible overlap for unregistering regions
>   lib: logic_pio: Add logic_pio_unregister_range()
>   bus: hisi_lpc: Unregister logical PIO range to avoid potential
>     use-after-free
>   bus: hisi_lpc: Add .remove method to avoid driver unbind crash
>   lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at
>     registration
> 
>  drivers/bus/hisi_lpc.c    | 43 +++++++++++++++++---
>  include/linux/logic_pio.h |  1 +
>  lib/logic_pio.c           | 86 +++++++++++++++++++++++++++------------
>  3 files changed, 99 insertions(+), 31 deletions(-)
> 

