Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F0936F757
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhD3Isy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 04:48:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16174 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhD3Isx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 04:48:53 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FWmCB6y70zlWYk;
        Fri, 30 Apr 2021 16:44:54 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Fri, 30 Apr 2021
 16:47:55 +0800
Subject: Re: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, <linux-pci@vger.kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>
References: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
 <4177f0be-5859-9a71-da06-2e67641568d7@hisilicon.com>
 <20210428144041.GA27967@wunner.de>
 <c7932c4e-81b1-279d-48df-5d621efff757@hisilicon.com>
 <20210429194214.GA22639@wunner.de>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <98afb95c-2735-b1fd-3261-7d701b6a0801@hisilicon.com>
Date:   Fri, 30 Apr 2021 16:47:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210429194214.GA22639@wunner.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/4/30 3:42, Lukas Wunner wrote:
> On Thu, Apr 29, 2021 at 07:29:59PM +0800, Yicong Yang wrote:
>> On 2021/4/28 22:40, Lukas Wunner wrote:
>>> If DPC doesn't recover within 3 seconds, pciehp will consider the
>>> error unrecoverable and bring down the slot, no matter what.
>>>
>>> I can't tell you why DPC is unable to recover.  Does it help if you
>>> raise the timeout to, say, 5000 msec?
>>
>> I raise the timeout to 4s and it works well. I dump the remained jiffies in
>> the log and find sometimes the recovery will take a bit more than 3s:
> 
> Thanks for testing.  I'll respin the patch and raise the timeout
> to 4000 msec.
> 
> The 3000 msec were chosen arbitrarily.  I couldn't imagine that
> it would ever take longer than that.  The spec does not seem to
> mandate a time limit for DPC recovery.  But we do need a timeout
> because the DPC Trigger Status bit may never clear and then pciehp
> would wait indefinitely.  This can happen if dpc_wait_rp_inactive()
> fails or perhaps because the hardware is buggy.
> 

The DPC recovery process will not be blocked indefinitely. What about
wait until the DPC process is finished or until the dpc_reset_link()
is finished? We can try to up the link if the DPC recovery failed.

I noticed the hotplug interrupt arrives prior to the DPC and then the
wait begins. DPC will clear the Trigger Status in its irq thread.
So not all the time is elapsed by the hardware recovery, but also by
the software process. Considering it's in the irq thread, if we are
preempted and clear the status slower, then we may be timed out.

> I'll amend the patch to clarify that the timeout is just a reasonable
> heuristic and not a value provided by the spec.
> 
> Which hardware did you test this on?  Is this a HiSilicon platform
> or Intel?
HiSilicon's Kunpeng platform.

Thanks,
Yicong

> 
> Thanks!
> 
> Lukas
> 
> .
> 

