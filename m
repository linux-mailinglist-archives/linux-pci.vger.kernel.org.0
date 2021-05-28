Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56EB394613
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 18:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhE1Qxb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 12:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236794AbhE1Qxa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 May 2021 12:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622220714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCpZDLzGfuvpzK9WauKlTe9JpEyhJUtHOj4EKePAcT8=;
        b=fZeAHGfagx2aWKDdolk2ZncZwcHwQ+fxnObAZQI+H8cLxN1/JlVfngKe4iXyHpJTYbhO/C
        BioPdT++PgGeP9l8KSzkVwCKkgUWI6hy3Tp6POwJMuCHun7kwAocplMe5HIj+R3zxQ16ti
        b8OVBa5wlf/lqTJ2yPVPL0UNyE4mPQw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-nX9ox8xmPjuigwW9jo4TLg-1; Fri, 28 May 2021 12:51:52 -0400
X-MC-Unique: nX9ox8xmPjuigwW9jo4TLg-1
Received: by mail-ed1-f71.google.com with SMTP id s10-20020aa7d78a0000b029038fa8d5e1e1so2409218edq.10
        for <linux-pci@vger.kernel.org>; Fri, 28 May 2021 09:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hCpZDLzGfuvpzK9WauKlTe9JpEyhJUtHOj4EKePAcT8=;
        b=fIsA+6n6Rr41gJhVEAZZld3eCIWFFH6U2B/PPanRIAF5dKdwSbEb6LxJo1A3+cxm98
         xgBZc0Q9TJtFOznLrgONRRVp8KSn62tOvmiIYibSYNFh7a+4Lvjw2TRbBWkj0UjH5ZXU
         7kPl3yvT3uCozk33HfZynrnxn/ihGcAjBMBuJLU4+LRC+ZWBATeIGtxIPiw1q7SkidRr
         2cfBAd+o6tpIQAA5Oz0yAA9TOqEizbAAAwcSY+CVfPIsTczWC2d/JrHjcCS7OO7iV8sx
         qRRSnZjnVe/KoIqvw40IQyJi8Gj/OZ2Cs3I89fnUaULrSDwgt8f0HdCJVvaRJPjLbOql
         wGSw==
X-Gm-Message-State: AOAM5308Dyrifo7v/F9r11CAV9Hrw+0Rid4k4iG5eYEdr6nCC7VUcwXm
        B6uFpoV0hjMNfq+S36+06ks8AeS6WSj2qsLvc7iPEjT0a7ZBWLe4Qtz0PsF0COun6fuBpH/wR2m
        dwPN6ReNGtCXi0y9jEN5E
X-Received: by 2002:a05:6402:22f1:: with SMTP id dn17mr10807141edb.286.1622220711650;
        Fri, 28 May 2021 09:51:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyq5SQF7umO2y05aiV0Je3yHNv8BRSDCCoe3Aa0Z344MrU4znNVekOImJM82sObFVcWUvBgKw==
X-Received: by 2002:a05:6402:22f1:: with SMTP id dn17mr10807115edb.286.1622220711360;
        Fri, 28 May 2021 09:51:51 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6870.dip0.t-ipconnect.de. [91.12.104.112])
        by smtp.gmail.com with ESMTPSA id bu1sm2598573ejb.116.2021.05.28.09.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 09:51:50 -0700 (PDT)
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
References: <159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210527205845.GA1421476@bjorn-Precision-5520>
 <CAPcyv4j-ygPddjuZqq8PMvsN-E8rJQszc+WuUu1MBXVXiQZddg@mail.gmail.com>
 <7eaf4c10-292e-18d7-e8ce-3a6b72122381@redhat.com>
 <CAPcyv4hjyMuvy3fNy8gdqWT6VSJA+U70x__q=Q89cLeJnHkj4Q@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4] /dev/mem: Revoke mappings when a driver claims the
 region
Message-ID: <e6b36ad2-6a96-4309-fd27-17391bc0e43a@redhat.com>
Date:   Fri, 28 May 2021 18:51:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hjyMuvy3fNy8gdqWT6VSJA+U70x__q=Q89cLeJnHkj4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28.05.21 18:42, Dan Williams wrote:
> On Fri, May 28, 2021 at 1:58 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 27.05.21 23:30, Dan Williams wrote:
>>> On Thu, May 27, 2021 at 1:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>
>>>> [+cc Daniel, Krzysztof, Jason, Christoph, linux-pci]
>>>>
>>>> On Thu, May 21, 2020 at 02:06:17PM -0700, Dan Williams wrote:
>>>>> Close the hole of holding a mapping over kernel driver takeover event of
>>>>> a given address range.
>>>>>
>>>>> Commit 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
>>>>> introduced CONFIG_IO_STRICT_DEVMEM with the goal of protecting the
>>>>> kernel against scenarios where a /dev/mem user tramples memory that a
>>>>> kernel driver owns. However, this protection only prevents *new* read(),
>>>>> write() and mmap() requests. Established mappings prior to the driver
>>>>> calling request_mem_region() are left alone.
>>>>>
>>>>> Especially with persistent memory, and the core kernel metadata that is
>>>>> stored there, there are plentiful scenarios for a /dev/mem user to
>>>>> violate the expectations of the driver and cause amplified damage.
>>>>>
>>>>> Teach request_mem_region() to find and shoot down active /dev/mem
>>>>> mappings that it believes it has successfully claimed for the exclusive
>>>>> use of the driver. Effectively a driver call to request_mem_region()
>>>>> becomes a hole-punch on the /dev/mem device.
>>>>
>>>> This idea of hole-punching /dev/mem has since been extended to PCI
>>>> BARs via [1].
>>>>
>>>> Correct me if I'm wrong: I think this means that if a user process has
>>>> mmapped a PCI BAR via sysfs, and a kernel driver subsequently requests
>>>> that region via pci_request_region() or similar, we punch holes in the
>>>> the user process mmap.  The driver might be happy, but my guess is the
>>>> user starts seeing segmentation violations for no obvious reason and
>>>> is not happy.
>>>>
>>>> Apart from the user process issue, the implementation of [1] is
>>>> problematic for PCI because the mmappable sysfs attributes now depend
>>>> on iomem_init_inode(), an fs_initcall, which means they can't be
>>>> static attributes, which ultimately leads to races in creating them.
>>>
>>> See the comments in iomem_get_mapping(), and revoke_iomem():
>>>
>>>           /*
>>>            * Check that the initialization has completed. Losing the race
>>>            * is ok because it means drivers are claiming resources before
>>>            * the fs_initcall level of init and prevent iomem_get_mapping users
>>>            * from establishing mappings.
>>>            */
>>>
>>> ...the observation being that it is ok for the revocation inode to
>>> come on later in the boot process because userspace won't be able to
>>> use the fs yet. So any missed calls to revoke_iomem() would fall back
>>> to userspace just seeing the resource busy in the first instance. I.e.
>>> through the normal devmem_is_allowed() exclusion.
>>>
>>>>
>>>> So I'm raising the question of whether this hole-punch is the right
>>>> strategy.
>>>>
>>>>     - Prior to revoke_iomem(), __request_region() was very
>>>>       self-contained and really only depended on the resource tree.  Now
>>>>       it depends on a lot of higher-level MM machinery to shoot down
>>>>       mappings of other tasks.  This adds quite a bit of complexity and
>>>>       some new ordering constraints.
>>>>
>>>>     - Punching holes in the address space of an existing process seems
>>>>       unfriendly.  Maybe the driver's __request_region() should fail
>>>>       instead, since the driver should be prepared to handle failure
>>>>       there anyway.
>>>
>>> It's prepared to handle failure, but in this case it is dealing with a
>>> root user of 2 minds.
>>>
>>>>
>>>>     - [2] suggests that the hole punch protects drivers from /dev/mem
>>>>       writers, especially with persistent memory.  I'm not really
>>>>       convinced.  The hole punch does nothing to prevent a user process
>>>>       from mmapping and corrupting something before the driver loads.
>>>
>>> The motivation for this was a case that was swapping between /dev/mem
>>> access and /dev/pmem0 access and they forgot to stop using /dev/mem
>>> when they switched to /dev/pmem0. If root wants to use /dev/mem it can
>>> use it, if root wants to stop the driver from loading it can set
>>> mopdrobe policy or manually unbind, and if root asks the kernel to
>>> load the driver while it is actively using /dev/mem something has to
>>> give. Given root has other options to stop a driver the decision to
>>> revoke userspace access when root messes up and causes a collision
>>> seems prudent to me.
>>>
>>
>> Is there a real use case for mapping pmem via /dev/mem or could we just
>> prohibit the access to these areas completely?
> 
> The kernel offers conflicting access to iomem resources and a
> long-standing mechanism to enforce mutual exclusion
> (CONFIG_IO_STRICT_DEVMEM) between those interfaces. That mechanism was
> found to be incomplete for the case where a /dev/mem mapping is
> maintained after a kernel driver is attached, and incomplete for other
> mechanisms to map iomem like pci-sysfs. This was found with PMEM, but
> the issue is larger and applies to userspace drivers / debug in
> general.
> 
>> What's the use case for "swapping between /dev/mem access and /dev/pmem0
>> access" ?
> 
> "Who knows". I mean, I know in this case it was a platform validation
> test using /dev/mem for "reasons", but I am not sure that is relevant
> to the wider concern. If CONFIG_IO_STRICT_DEVMEM=n exclusion is
> enforced when drivers pass the IORESOURCE_EXCLUSIVE flag, if
> CONFIG_IO_STRICT_DEVMEM=y exclusion is enforced whenever the kernel
> marks a resource IORESOURCE_BUSY, and if kernel lockdown is enabled
> the driver state is moot as LOCKDOWN_DEV_MEM and LOCKDOWN_PCI_ACCESS
> policy is in effect.
> 

I was thinking about a mechanism to permanently disallow /dev/mem access 
to specific memory regions (BUSY or not) in any /dev/mem mode. In my 
case, it would apply to the whole virtio-mem provided memory region. 
Once the driver is loaded, it would disallow access to the whole region.

I thought about doing it via the kernel resource tree, extending the 
EXCLUSIVE flag to !BUSY SYSRAM regions. But a simplistic list managed in 
/dev/mem code would also be possible.

That's why I wondered if we could just disallow access to these physical 
PMEM memory regions right from the start similarly, such that we don't 
have to really care about revoking in case of PMEM anymore.

-- 
Thanks,

David / dhildenb

