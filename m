Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814731F4E03
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 08:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgFJGSL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 02:18:11 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42201 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbgFJGSL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jun 2020 02:18:11 -0400
Received: from [192.168.178.35] (unknown [88.130.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 04AE620646DCF;
        Wed, 10 Jun 2020 08:18:08 +0200 (CEST)
Subject: Re: close() on some Intel CNP-LP PCI devices takes up to 2.7 s
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        it+linux-pci@molgen.mpg.de, amd-gfx@lists.freedesktop.org
References: <b0781d0e-2894-100d-a4da-e56c225eb2a6@molgen.mpg.de>
 <20200609154416.GU247495@lahna.fi.intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <3854150d-f193-d34e-557e-41090e4f39b5@molgen.mpg.de>
Date:   Wed, 10 Jun 2020 08:18:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609154416.GU247495@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Mika,


Am 09.06.20 um 17:44 schrieb Mika Westerberg:
> On Tue, Jun 09, 2020 at 05:39:21PM +0200, Paul Menzel wrote:

>> On the Intel Cannon Point-LP laptop Dell Precision 3540 with a dedicated AMD
>> graphics card (both graphics devices can be used) with Debian Sid/unstable
>> with Linux 5.6.14, running lspci takes quite some time, and the screen even
>> flickers a short moment before the result is displayed.
>>
>> Tracing lspci with strace, shows that the close() function of the three
>> devices takes from
>>
>> •   00:1d.0 PCI bridge: Intel Corporation Cannon Point-LP PCI Express Root
>> Port #9
>>
>> •   04:00.0 System peripheral: Intel Corporation JHL6340 Thunderbolt 3 NHI
>> (C step) [Alpine Ridge 2C 2016] (rev 02)
>>
>> •   3b:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Lexa
>> XT [Radeon PRO WX 3100]
>>
>> takes from 270 ms to 2.5 s.
>>
>>> 11:43:21.714391 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:04:00.0/config", O_RDONLY) = 3
>>> 11:43:21.714448 pread64(3, "\206\200\331\25\6\4\20\0\2\0\200\10 \0\0\0\0\0\0\352\0\0\4\352\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0(\20\272\10\0\0\0\0\
>>> 200\0\0\0\0\0\0\0\377\1\0\0", 64, 0) = 64
>>> 11:43:24.487818 close(3)                = 0
>>
>>> 11:43:24.489508 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:1d.0/config", O_RDONLY) = 3
>>> 11:43:24.489598 pread64(3, "\206\200\260\235\7\4\20\0\360\0\4\6\20\0\201\0\0\0\0\0\0\0\0\0\0;;\00000\0  \354 \354\1\300\21\320\0\0\0\0\0\0\0\0\0\0\0\0
>>> @\0\0\0\0\0\0\0\377\1\22\0", 64, 0) = 64
>>> 11:43:24.966661 close(3)                = 0
>>
>>> 11:43:24.988544 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:3b:00.0/config", O_RDONLY) = 3
>>> 11:43:24.988584 pread64(3, "\2\20\205i\7\4\20\0\0\0\200\3\20\0\0\0\f\0\0\300\0\0\0\0\f\0\0\320\0\0\0\0\0010\0\0\0\0 \354\0\0\0\0(\20\272\10\0\0$\354H\0\0\0\0\0\0\0\377\1\0\0", 64, 0) = 64
>>> 11:43:25.252745 close(3)
>>
>> Unfortunately, I forgot to collect the tree output, but hopefully the
>> attached Linux messages and strace of lspci output will be enough for the
>> start.
>>
>> Please tell me, if you want me to create a bug report in the Linux bug
>> tracker.
> 
> Can you try this commit?
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/pm&id=ec411e02b7a2e785a4ed9ed283207cd14f48699d
> 
> It should be in the mainline already as well.
> 
> Note we still need to obey the delays required by the PCIe spec so 100ms
> after the link is trained but this one should at least get it down from
> 1100ms.

Thank you for replying so quickly. Hopefully, I’ll be able to test the 
commit tomorrow.

One question though. The commit talks about resuming from suspend. I 
understand that training happens there.

In my case the system is already running. So I wonder, why link(?) 
training would still happening.


Kind regards,

Paul
