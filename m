Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E053B9311
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 16:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhGAOYJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 10:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232631AbhGAOYJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 10:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625149298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13M5znKwnS5g2Fel1znFN7kUHnfTuQOHwWom49wI1/g=;
        b=L1slZ2w6Ulko5alr89V4gSGW2jW0OFPogdtlRxn7IlI9C7HiiPq8GaHle/UdgG8VcG4K5d
        hFj1lyx/DUw0k8gRA0w/6mbHRMkYh0glABIqr8XOS88UCT5m2heYYGKqBfg+CBTvaj6TcT
        qXM8zZ+IugXLcgQmoGbz6/6+w3NqSH8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-LQIyzDMjMgmNgxD5X2Wumg-1; Thu, 01 Jul 2021 10:21:37 -0400
X-MC-Unique: LQIyzDMjMgmNgxD5X2Wumg-1
Received: by mail-ej1-f70.google.com with SMTP id hy7-20020a1709068a67b02904cdf8737a75so1335706ejc.9
        for <linux-pci@vger.kernel.org>; Thu, 01 Jul 2021 07:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=13M5znKwnS5g2Fel1znFN7kUHnfTuQOHwWom49wI1/g=;
        b=kib5xRPIMGxqLGNgN5a9v0L1r6YChTYiURQ7JgTnUQDMNXbfowdjgsFXFIV0exgpkL
         t3KWyYS1lg2MTlnXjVCddZyDVR1NQvGtdELzVop8CKabRBTP1jTDs9i8ZluCOEe7yWEG
         uApmKo4Kv8SPzxWKpMDsImxzU+I2zCMKtNpO+70BzrQ30nzn9v2VzIO79Qu+yfQrSuZ3
         pKidRBU+VCdKv52RUs9pTceoK8LbidgGPyeXtbL0Rvi3BgB2mR3zBXJVfA5faajMAZvj
         tb7d/VRXsKn8L/djoQh1uav3pKXEpz+jZ5CQfmhlzFTJACl8k1NX1qJxPIiYdIHYEXH+
         bzYg==
X-Gm-Message-State: AOAM531opUrJCuMu+5QSJJfXh7w5XWc4TijlVSX6r1dfl40p7cB2GLhN
        iVK2/u6DBKX702fKPD6gW/CYa7R2XKIxx5UWBoe7derdhuEaiMQwJnesVD9/SOVB+AdqjRMaCqH
        x/S+JMQvtyICDouGtlETJt4cd7WcFNBIFzk3RTCqBkBqO+YcPn+QS74oHVKeLy5dX3nbOyDJi
X-Received: by 2002:a05:6402:1cbc:: with SMTP id cz28mr110079edb.246.1625149295083;
        Thu, 01 Jul 2021 07:21:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7dLarjT0bfQTD4f7rxLy7+dFZkI0h5zX/veMLVVsjWmpJAThiPG3fNgI+sEdUvmSzQveSEA==
X-Received: by 2002:a05:6402:1cbc:: with SMTP id cz28mr110043edb.246.1625149294838;
        Thu, 01 Jul 2021 07:21:34 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ay17sm4522602ejb.80.2021.07.01.07.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 07:21:34 -0700 (PDT)
Subject: Re: [RFC 1/1] PCI/ACPI: Make acpi_pci_root_validate_resources()
 reject IOMEM resources which start at address 0
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
References: <20210616225705.GA3014869@bjorn-Precision-5520>
 <c55ee3ef-f15e-d043-4cdf-35c1026089ec@redhat.com>
Message-ID: <7d80f639-0768-850b-5313-3bdedf0a5579@redhat.com>
Date:   Thu, 1 Jul 2021 16:21:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c55ee3ef-f15e-d043-4cdf-35c1026089ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 6/21/21 1:49 PM, Hans de Goede wrote:

<snip>

>> But maybe we aren't smart enough when trying to allocate space.
>> Places like __pci_bus_size_bridges() and __pci_assign_resource() are
>> full of assumptions about what PCI BARs can go where, depending on
>> 64bit-ness, prefetchability, etc.
>>
>> Maybe instrumenting those allocation paths would give some insight.
>> Possibly we should go ahead and merge some permanent pci_dbg() stuff
>> there too.
> 
> I agree that this seems to be the most likely issue. I've build
> a Fedora kernel pkg with some extra debugging added for the reporter
> to be test.  Since I'm reliant on a debug cycle where I provide
> a kernel and then the reporter comes back with a new debug,
> and then rince-repeat it might be a while before I get back to you
> on this.  Hopefully when I do get back I will have figured out
> what the problem is.
> 
> (and in case it was not clear yet the RFC patch which started this
> discussion clearly is bogus and can be considered dropped).

Ok, I believe I've figured out what the root cause of things
failing is here.

I've added a couple of pr_info-s to kernel/resource.c __find_resource()
like this:

                pr_info("__find_resource() trying 0x%llx - 0x%llx\n", tmp.start, tmp.end);
                if (tmp.end < tmp.start)
                        goto next;

                resource_clip(&tmp, constraint->min, constraint->max);
                arch_remove_reservations(&tmp);
                pr_info("__find_resource() after clip + arch-reserv 0x%llx - 0x%llx\n", tmp.start, tmp.end);

And the following (relevant) messages get logged by these 2 pr_info-s
when trying to allocate a resource for the unassigned IOMEM BAR
of the I2C controller on the troublesome laptops:

[    1.262423] resource: allocate_resource root [mem 0x65400000-0xbfffffff window] new [mem size 0x00001000 64bit] size 0x1000 min 0x65400000 max 0xbfffffff align 0x1000
[    1.262426] resource: __find_resource() trying 0x65400000 - 0x6fffffff
[    1.262428] resource: __find_resource() after clip + arch-reserv 0xd0000000 - 0x6fffffff
...
[    1.262543] resource: __find_resource() trying 0x8122d000 - 0x8122efff
[    1.262544] resource: __find_resource() after clip + arch-reserv 0xd0000000 - 0x8122efff
etc.

Notice that the regions start at 0xd0000000 rather then their original start
address after these 2 calls:

                resource_clip(&tmp, constraint->min, constraint->max);
                arch_remove_reservations(&tmp);

I believe that this is caused by the arch_remove_reservations call,
which applies e820 reservations and the e820 table has the following:

[    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved

So the e820 table is basically reserving the entire main PCI bus iomem
window, which runs from 0x65400000-0xbfffffff :

[    0.609979] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.609983] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.609986] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.609988] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
[    0.609991] pci_bus 0000:00: root bus resource [bus 00-fe]

One way of fixing this would be to check CRS provided PCI root bridge windows
vs e820 reservations and remove (carve out) the PCI root bridge iomem windows
from any e820 reservations. Probably with some warning about the firmware
being buggy.   I'm not sure if this won't cause issues else where though.

So before I spend time on trying to code something like this, any other
ideas / suggestions how to fix this ?

Regards,

Hans

