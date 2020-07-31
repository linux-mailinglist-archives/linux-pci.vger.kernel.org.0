Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AE6234726
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 15:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgGaNsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 09:48:05 -0400
Received: from foss.arm.com ([217.140.110.172]:59484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgGaNsF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jul 2020 09:48:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15F5A31B;
        Fri, 31 Jul 2020 06:48:04 -0700 (PDT)
Received: from [192.168.0.57] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE1C23F66E;
        Fri, 31 Jul 2020 06:48:01 -0700 (PDT)
Subject: Re: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        Linuxarm <linuxarm@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
References: <20200722103952.1009-1-shiju.jose@huawei.com>
 <20200722103952.1009-2-shiju.jose@huawei.com>
 <20200722110146.GW3703480@smile.fi.intel.com>
 <eb8336f0357f447baf5c37309d320f57@huawei.com>
 <20200722125038.GZ3703480@smile.fi.intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <185f69dd-bfec-20ce-01d6-76947f553e45@arm.com>
Date:   Fri, 31 Jul 2020 14:47:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722125038.GZ3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shiju,

On 22/07/2020 13:50, Andy Shevchenko wrote:
> On Wed, Jul 22, 2020 at 12:34:23PM +0000, Shiju Jose wrote:

>>>> Co-developed-by: James Morse <james.morse@arm.com>
>>>
>>> Co-developed-by: is going _in conjunction with_ SoB tag which is missing
>>> here.
>> This tag was added as per instruction from Rafael.
>> I was told that I cannot add SoB tag for others unless specifically given.
>> Probably I will leave it with Rafael/James to help on this SoB tag
>> as Rafael was ok to merge this patch.
> 
> I think it's a misunderstanding somewhere. According to [1]:
> "Since Co-developed-by: denotes authorship, every Co-developed-by: must be
> immediately followed by a Signed-off-by: of the associated co-author."
> 
> It means either both or none.
> 
> [1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Sorry for this mess! My intention was to summarise my suggestion in the form of a patch,
I wasn't expecting you to pick it up. (and I didn't post it because there was ongoing
discussion on the second part)

I'll repost this with the Co-Developed-by stuff. You'll need to re-post it with the
series, you'll need to move your Signed-Off-By to be last when you do that.


Thanks,

James
