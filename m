Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8A2393F0E
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 10:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhE1I7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 04:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235325AbhE1I7l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 May 2021 04:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622192286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+WiQc46VNYZyiaojk5h9JxqplWT0OeXUCmh+32Qpg80=;
        b=PkiezJ65gKThqItW0miX2G3cHe1bi307Sl5gvkUN0OR+fpJyv29KTreEhqEeqimPlS28yO
        l2X3mMZUKos3Snl5P/RttUf3Mh9i+GckCJ4F+wl4BWZFo3dpkM5O/UliEq+l7kpRAWKloK
        WhTNEEwqtSWBU+/0nIgYotyTARGVEaI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-Wgw_J7VSP8u9qXT9wYjK8w-1; Fri, 28 May 2021 04:58:04 -0400
X-MC-Unique: Wgw_J7VSP8u9qXT9wYjK8w-1
Received: by mail-wr1-f72.google.com with SMTP id f16-20020a5d50d00000b0290114238aa727so781146wrt.5
        for <linux-pci@vger.kernel.org>; Fri, 28 May 2021 01:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+WiQc46VNYZyiaojk5h9JxqplWT0OeXUCmh+32Qpg80=;
        b=dIxidlIbLyyxCTXzKGYKfpzSrsvs6geX6NxcsuC1KMeAHrRxF2hXIkscQOcxq20iyy
         pjasJBUHl/BdM2XA0bRecgrU1F6j2/C8+7ydNdXnaF42PVlbFz/GZam1eFQnbw7DD/e/
         +2gYF1lvXrdxA3bVocYAKSfJOlpkD0xaJifx1hywDrRaedmU0UPUgBkmxRxO4jafjY2h
         8YEG92N3OMyr56ANwKcBUMfdZ2mZFWEt9LIKAHgP1Oc88b30k/biC9DW5TcXDKXlh9Q5
         InHzPhH8K5LubtBwVl7rqtJGq6xl5sIm06nlW1wQm9shuP/wlFTLeqRd/zgG5QCybuUF
         P/AQ==
X-Gm-Message-State: AOAM532O+GorKW2gx/9kcSIm8oWdVGaEB1YCLUCoxGMtwkE6+lRjmO7X
        fmJjPR9OJo9ETDA6Gw4yxJ5sFNkGoQaTILxcYSheyfVcZVBOdO7uWZQFLA472+vcwHLblM1rFue
        0vPdPBBTdwwUkZl3zQIJN
X-Received: by 2002:a1c:9a89:: with SMTP id c131mr7583530wme.49.1622192283320;
        Fri, 28 May 2021 01:58:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9HSY/9ONSw0TXXli1OG4zWrRmNhz/PPNY2OWx7WiHUrnvujFLUoqSJrrWaY8vs4kjp++xtA==
X-Received: by 2002:a1c:9a89:: with SMTP id c131mr7583507wme.49.1622192283052;
        Fri, 28 May 2021 01:58:03 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6870.dip0.t-ipconnect.de. [91.12.104.112])
        by smtp.gmail.com with ESMTPSA id u14sm13405368wmc.41.2021.05.28.01.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 01:58:02 -0700 (PDT)
Subject: Re: [PATCH v4] /dev/mem: Revoke mappings when a driver claims the
 region
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7eaf4c10-292e-18d7-e8ce-3a6b72122381@redhat.com>
Date:   Fri, 28 May 2021 10:58:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4j-ygPddjuZqq8PMvsN-E8rJQszc+WuUu1MBXVXiQZddg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27.05.21 23:30, Dan Williams wrote:
> On Thu, May 27, 2021 at 1:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> [+cc Daniel, Krzysztof, Jason, Christoph, linux-pci]
>>
>> On Thu, May 21, 2020 at 02:06:17PM -0700, Dan Williams wrote:
>>> Close the hole of holding a mapping over kernel driver takeover event of
>>> a given address range.
>>>
>>> Commit 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
>>> introduced CONFIG_IO_STRICT_DEVMEM with the goal of protecting the
>>> kernel against scenarios where a /dev/mem user tramples memory that a
>>> kernel driver owns. However, this protection only prevents *new* read(),
>>> write() and mmap() requests. Established mappings prior to the driver
>>> calling request_mem_region() are left alone.
>>>
>>> Especially with persistent memory, and the core kernel metadata that is
>>> stored there, there are plentiful scenarios for a /dev/mem user to
>>> violate the expectations of the driver and cause amplified damage.
>>>
>>> Teach request_mem_region() to find and shoot down active /dev/mem
>>> mappings that it believes it has successfully claimed for the exclusive
>>> use of the driver. Effectively a driver call to request_mem_region()
>>> becomes a hole-punch on the /dev/mem device.
>>
>> This idea of hole-punching /dev/mem has since been extended to PCI
>> BARs via [1].
>>
>> Correct me if I'm wrong: I think this means that if a user process has
>> mmapped a PCI BAR via sysfs, and a kernel driver subsequently requests
>> that region via pci_request_region() or similar, we punch holes in the
>> the user process mmap.  The driver might be happy, but my guess is the
>> user starts seeing segmentation violations for no obvious reason and
>> is not happy.
>>
>> Apart from the user process issue, the implementation of [1] is
>> problematic for PCI because the mmappable sysfs attributes now depend
>> on iomem_init_inode(), an fs_initcall, which means they can't be
>> static attributes, which ultimately leads to races in creating them.
> 
> See the comments in iomem_get_mapping(), and revoke_iomem():
> 
>          /*
>           * Check that the initialization has completed. Losing the race
>           * is ok because it means drivers are claiming resources before
>           * the fs_initcall level of init and prevent iomem_get_mapping users
>           * from establishing mappings.
>           */
> 
> ...the observation being that it is ok for the revocation inode to
> come on later in the boot process because userspace won't be able to
> use the fs yet. So any missed calls to revoke_iomem() would fall back
> to userspace just seeing the resource busy in the first instance. I.e.
> through the normal devmem_is_allowed() exclusion.
> 
>>
>> So I'm raising the question of whether this hole-punch is the right
>> strategy.
>>
>>    - Prior to revoke_iomem(), __request_region() was very
>>      self-contained and really only depended on the resource tree.  Now
>>      it depends on a lot of higher-level MM machinery to shoot down
>>      mappings of other tasks.  This adds quite a bit of complexity and
>>      some new ordering constraints.
>>
>>    - Punching holes in the address space of an existing process seems
>>      unfriendly.  Maybe the driver's __request_region() should fail
>>      instead, since the driver should be prepared to handle failure
>>      there anyway.
> 
> It's prepared to handle failure, but in this case it is dealing with a
> root user of 2 minds.
> 
>>
>>    - [2] suggests that the hole punch protects drivers from /dev/mem
>>      writers, especially with persistent memory.  I'm not really
>>      convinced.  The hole punch does nothing to prevent a user process
>>      from mmapping and corrupting something before the driver loads.
> 
> The motivation for this was a case that was swapping between /dev/mem
> access and /dev/pmem0 access and they forgot to stop using /dev/mem
> when they switched to /dev/pmem0. If root wants to use /dev/mem it can
> use it, if root wants to stop the driver from loading it can set
> mopdrobe policy or manually unbind, and if root asks the kernel to
> load the driver while it is actively using /dev/mem something has to
> give. Given root has other options to stop a driver the decision to
> revoke userspace access when root messes up and causes a collision
> seems prudent to me.
> 

Is there a real use case for mapping pmem via /dev/mem or could we just 
prohibit the access to these areas completely?

What's the use case for "swapping between /dev/mem access and /dev/pmem0 
access" ?

-- 
Thanks,

David / dhildenb

