Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771FF3C6CDA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbhGMJJM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 05:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhGMJJM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 05:09:12 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D8EC0613DD;
        Tue, 13 Jul 2021 02:06:21 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so21797862oti.2;
        Tue, 13 Jul 2021 02:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9Au+qoSVHB4VwxC9iKkQR94HxlbBA0K+/1PBJPfppOc=;
        b=sRYMdsr/MH/y7malyvLoVgJEWfqHdp6Vrj/XQeg2SbBGiWG8qXZ7/aHTDbXBzCS7n4
         sv+elgQ/zCdr/MpVmtarAZT1UOwVihpuZ08f30ygdhm0DqshFFO3htSpvtPSt+5PX5Up
         fH0MBOXHKozqDZQlEXNqYmhkOhyK40NX5EndXwR0cIJZx1T4NIwTEpPKzY+EzCLdsCDe
         iAztvUSOQiWWnfwrPIW5gcgYRte7G+oIJuOfunmyLiLUaxPtnFR9tXVSECjDQzUYrPJU
         jnZhBNuIfORTaHmHTuqHNE5ayOt5U9qDAQrFuia3fLSFbWpVtIMvk/igf0IPoBHURvFI
         zo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Au+qoSVHB4VwxC9iKkQR94HxlbBA0K+/1PBJPfppOc=;
        b=QOsg7kS/5gkIKaBLftb3uIS9v5VyoJTp3BD6D2C0i3+Yx5yhyjHTzn80LXP4hPQeAm
         8m7muyIAKUCTm1SY5uJzsdapLjaoHEmpVn5wQ/liN1s7cFMys2a7KxFy+OLUnB5CYdON
         TOX1rcrg31THqSzLdgsy1MeZcdhZDFPVa6F4Q7E5cNSzU5FM9NOQl8MQvI/2djOht4ds
         9FCq3r95jZluOqaMZ/wHd/MFI0/pmQQmfmlIJZzw1D4Zta53r4kSGLXNDyfsetyamPOu
         LGVcckx15d0vIBLDX0mCcWqULIVt9wSxpruwx4Ht+PamHiyA3FTnMRMnN2TdIhdQBEmw
         ww9Q==
X-Gm-Message-State: AOAM531hz/bb7KSURgtBhSzJ3X0zNn0EGLq+RV4FKAV8DA5LwVIznnYq
        ke+LDKF9gKJRiuSxI3/WDYFFlnK8osU=
X-Google-Smtp-Source: ABdhPJz1t4eOhXNJJ4vGWL3ObMrQD7iWG8+jMxQzCTu4k0COQhMyuFHS8d2cHpreBEldaM1wgou/QA==
X-Received: by 2002:a9d:1d7:: with SMTP id e81mr2707555ote.171.1626167180499;
        Tue, 13 Jul 2021 02:06:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x30sm3762921ote.44.2021.07.13.02.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 02:06:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/1] PCI: Coalesce host bridge contiguous apertures
 without sorting
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
 <f18e36f7-cb18-1a4a-e7e8-4fbb253581ae@roeck-us.net>
 <CAAd53p50502g1_7Db4xzUXrzcofmtBDO=+-HLqfs+J7NvVhB+A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <346ae622-de15-b81d-c129-24c9e77b59d4@roeck-us.net>
Date:   Tue, 13 Jul 2021 02:06:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAAd53p50502g1_7Db4xzUXrzcofmtBDO=+-HLqfs+J7NvVhB+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/13/21 1:49 AM, Kai-Heng Feng wrote:
> On Tue, Jul 13, 2021 at 4:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 7/13/21 12:57 AM, Kai-Heng Feng wrote:
>>> Commit 65db04053efe ("PCI: Coalesce host bridge contiguous apertures")
>>> sorts the resources by address so the resources can be swapped.
>>>
>>> Before:
>>> PCI host bridge to bus 0002:00
>>> pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
>>> pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
>>> pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
>>>
>>> And after:
>>> PCI host bridge to bus 0002:00
>>> pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
>>> pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
>>> pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
>>>
>>> However, the sorted resources make NVMe stops working on QEMU ppc:sam460ex.
>>>
>>> Resources in the original issue are already in ascending order:
>>> pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
>>> pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]
>>>
>>> So remove the sorting part to resolve the issue.
>>>
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Fixes: 65db04053efe ("PCI: Coalesce host bridge contiguous apertures")
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>
>> I think the original commit message would make more sense here. This patch
>> doesn't fix 65db04053efe, it replaces it. The commit message now misses
>> the point, and the patch coalesces continuous apertures without explaining
>> the reason.
> 
> Because the message is already in the git log so I didn't think that's
> necessary.

Hmm, not my decision to make, but the original commit got reverted.
The commit log associated with this patch should still reflect what
the patch does.

Guenter

> Will send another one with the original message along with this one.
> 
> Kai-Heng
> 
>>
>> Guenter
>>
>>> ---
>>>    drivers/pci/probe.c | 31 +++++++++++++++++++++++++++----
>>>    1 file changed, 27 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 79177ac37880..5de157600466 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -877,11 +877,11 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
>>>    static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>>>    {
>>>        struct device *parent = bridge->dev.parent;
>>> -     struct resource_entry *window, *n;
>>> +     struct resource_entry *window, *next, *n;
>>>        struct pci_bus *bus, *b;
>>> -     resource_size_t offset;
>>> +     resource_size_t offset, next_offset;
>>>        LIST_HEAD(resources);
>>> -     struct resource *res;
>>> +     struct resource *res, *next_res;
>>>        char addr[64], *fmt;
>>>        const char *name;
>>>        int err;
>>> @@ -961,11 +961,34 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>>>        if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
>>>                dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
>>>
>>> +     /* Coalesce contiguous windows */
>>> +     resource_list_for_each_entry_safe(window, n, &resources) {
>>> +             if (list_is_last(&window->node, &resources))
>>> +                     break;
>>> +
>>> +             next = list_next_entry(window, node);
>>> +             offset = window->offset;
>>> +             res = window->res;
>>> +             next_offset = next->offset;
>>> +             next_res = next->res;
>>> +
>>> +             if (res->flags != next_res->flags || offset != next_offset)
>>> +                     continue;
>>> +
>>> +             if (res->end + 1 == next_res->start) {
>>> +                     next_res->start = res->start;
>>> +                     res->flags = res->start = res->end = 0;
>>> +             }
>>> +     }
>>> +
>>>        /* Add initial resources to the bus */
>>>        resource_list_for_each_entry_safe(window, n, &resources) {
>>> -             list_move_tail(&window->node, &bridge->windows);
>>>                offset = window->offset;
>>>                res = window->res;
>>> +             if (!res->end)
>>> +                     continue;
>>> +
>>> +             list_move_tail(&window->node, &bridge->windows);
>>>
>>>                if (res->flags & IORESOURCE_BUS)
>>>                        pci_bus_insert_busn_res(bus, bus->number, res->end);
>>>
>>

