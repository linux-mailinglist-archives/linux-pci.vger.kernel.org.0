Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D7B31F5A3
	for <lists+linux-pci@lfdr.de>; Fri, 19 Feb 2021 09:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhBSIH5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Feb 2021 03:07:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60356 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBSIH4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Feb 2021 03:07:56 -0500
Received: from [222.129.38.131] (helo=[192.168.1.10])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <aaron.ma@canonical.com>)
        id 1lD0oi-0002Jz-VN; Fri, 19 Feb 2021 08:07:13 +0000
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>, peter.chen@nxp.com,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <20210204051850.64857-1-aaron.ma@canonical.com>
 <CAAd53p4euFiw7pfDnD2H8oMVeeTqQ_c+wOFDLM2xPccn5MewiA@mail.gmail.com>
 <cd4595e6-67da-885c-1a67-6dfd71425b8c@canonical.com>
 <CAAd53p4z1ydFi5pwOZJnsrBDPNVLKU0ygqa0+kdZdXWYocPLgQ@mail.gmail.com>
 <YCJJrVp2DvCzigCw@kroah.com>
 <00de6927-3fa6-a9a3-2d65-2b4d4e8f0012@linux.intel.com>
 <YCUoBP4GUrGL0J3J@kroah.com>
From:   Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH] xhci-pci: Set AMD Renoir USB controller to D3 when
 shutdown
Message-ID: <a93e3039-c910-4bf5-0e8a-ffdd74b983d0@canonical.com>
Date:   Fri, 19 Feb 2021 16:07:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCUoBP4GUrGL0J3J@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/11/21 8:50 PM, Greg Kroah-Hartman wrote:
> On Wed, Feb 10, 2021 at 03:13:30PM +0200, Mathias Nyman wrote:
>> On 9.2.2021 10.37, Greg Kroah-Hartman wrote:
>>> On Fri, Feb 05, 2021 at 02:50:15PM +0800, Kai-Heng Feng wrote:
>>>> On Fri, Feb 5, 2021 at 2:45 PM Aaron Ma <aaron.ma@canonical.com> wrote:
>>>>>
>>>>>
>>>>> On 2/5/21 12:27 PM, Kai-Heng Feng wrote:
>>>>>> Can you please test the following patch, which should address the root cause:
>>>>>> https://lore.kernel.org/linux-acpi/20201201213019.1558738-1-furquan@google.com/
>>>>>>
>>>>>> It also helps another AMD laptop on S5:
>>>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1912935
>>>>>>
>>>>>
>>>>> No, this patch doesn't help on ThinkPad AMD platform.
>>>>
>>>> Thanks for the confirmation!
>>>>
>>>> Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>
>>> Mathias, want me to take this in my tree now, or are you going to send
>>> me more patches for 5.12-rc1?
>>>
>>
>> Nothing more for 5.12-rc1 from me.
>>
>> Could this be a PCI quirk instead of xhci?
>> Maybe there is some PCI flag for this already, haven't checked yet.
>>
>> We want a specific PCI device to go to PCI D3cold at PCI shutdown...
> 
> There probably is.  Kay-Heng, can you look into doing that instead?
> 

There is no such PCI quirk, usually it calls driver to shutdown.

Regards,
Aaron

> thanks,
> 
> greg k-h
> 
