Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2060D4EA73
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 16:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFUOTv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 10:19:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfFUOTv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 10:19:51 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B337788BF42820C49AE1;
        Fri, 21 Jun 2019 22:19:45 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Jun 2019
 22:19:37 +0800
Subject: Re: [PATCH 2/5] lib: logic_pio: Add logic_pio_unregister_range()
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
 <1561026716-140537-3-git-send-email-john.garry@huawei.com>
 <20190621134955.GD82584@google.com>
CC:     <xuwei5@huawei.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <joe@perches.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <baa629ab-f8c9-7c6e-8402-77fe41a47e07@huawei.com>
Date:   Fri, 21 Jun 2019 15:19:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190621134955.GD82584@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/2019 14:49, Bjorn Helgaas wrote:
>> --- a/lib/logic_pio.c
>> > +++ b/lib/logic_pio.c
>> > @@ -56,7 +56,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>> >  			/* for MMIO ranges we need to check for overlap */
>> >  			if (start >= range->hw_start + range->size ||
>> >  			    end < range->hw_start) {
>> > -				mmio_sz += range->size;
>> > +				mmio_sz = range->io_start + range->size;

Hi Bjorn,

> Should this be renamed to something like "mmio_end"?  Computing a
> "size" as "start + size" looks wrong at first glance.  The code overall
> probably makes sense, but maybe breaking this out as a separate "avoid
> overlaps" patch that renames "mmio_sz" might make it clearer.

I agree with the renaming to "mmio_end". I can split it out into another 
patch also.

Thanks,
John

>
>> >  			} else {
>> >  				ret = -EFAULT;
>> >  				goto end_register;


