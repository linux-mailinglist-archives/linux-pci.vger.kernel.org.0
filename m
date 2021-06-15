Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAB43A7D47
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 13:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFOLfq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 07:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229972AbhFOLfc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 07:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623756807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FAcb4KjqFQI8l7kbbpPnjTi2rrJNKjXNyocVvJeot7I=;
        b=iHYxxDxRgaEp9X8+NyQyWQiw0TIW/nSEMG1HQPwteasDm3YI+2meW4BHTYU09Z7OD+j4Tg
        5vHURrjdtECCSfN2aiqJmLWaqx2CQqpCFfupzb994qNaqZrF7DA7N9vRrKM7h19jpyo0pY
        07ae33nCTQ+v9Tm22vaR0yGZyUBe0V8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-ahtAAZlOPbOMgivBhXwG4A-1; Tue, 15 Jun 2021 07:33:26 -0400
X-MC-Unique: ahtAAZlOPbOMgivBhXwG4A-1
Received: by mail-ed1-f71.google.com with SMTP id x8-20020aa7d3880000b029038fe468f5f4so21884897edq.10
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 04:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FAcb4KjqFQI8l7kbbpPnjTi2rrJNKjXNyocVvJeot7I=;
        b=Ku14SSbPWT8Gh+GvZo0mhDxZC6UL7TUeMfETQUlMCVDPgLlDgnNcH3kiQVzywgga0T
         i7CJFHHl9v63lBsbcuP8vVgPfxlH6ACpeYGKGPGUNcOFmctbdDoL8gs8IEalCiJ+xVUx
         iBNRUUXlAYt/LUDxv75Dn2FGCpm9bQfwVuedUF2VF9CGiPARR8IiN5E2Dk7QjU6fbSj0
         ZqGmiNVbdpuARePTuJiRDhvxKc9xwjUP7oucV5LUfaYDCnlFawI6D0E2oZGsxfrWlQcu
         3R/auag/XR8GeEiCA+7BiBFzEDc0N2kKFEr1QXyIU7Ug1JDEdYqQzRbgYStsdJ7THRW2
         izEg==
X-Gm-Message-State: AOAM533v04pMMzYogUM9D14YeaXzszVNltfymihWNHF0lROC3ydXDCu2
        WEJqreMbzlAmt9NW4pOpJ2E+Rb06KTho+xCZe/CMw8XG2hiHYHOOvP/rJgGbcW0eN8aB7kjRz+9
        Op4Xd/cuvfnAAYb6nfdM3eOZk2mQyjTgP19r0TlSwdthdbhfq1yiFoOe0+3GFyXmDnVx1U+2S
X-Received: by 2002:a17:907:c0d:: with SMTP id ga13mr20793653ejc.325.1623756804904;
        Tue, 15 Jun 2021 04:33:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNwON+E0zTGVfBa1cc8stK3EYHJ78L98E6Nyt9UTLrmiHRvWgPFzKBisR7LhFY4QaHRhs5ZQ==
X-Received: by 2002:a17:907:c0d:: with SMTP id ga13mr20793608ejc.325.1623756804395;
        Tue, 15 Jun 2021 04:33:24 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h2sm12051436edr.50.2021.06.15.04.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 04:33:23 -0700 (PDT)
Subject: Re: [RFC 1/1] PCI/ACPI: Make acpi_pci_root_validate_resources()
 reject IOMEM resources which start at address 0
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <20210615102555.6035-1-hdegoede@redhat.com>
 <20210615102555.6035-2-hdegoede@redhat.com>
 <CAJZ5v0hJ0-U7-rMApDF72xVO2PQEdbzWtVkrOQVp4xnxGHoyuA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fb26ac42-d047-5a01-1d16-0b5ea3e2eefc@redhat.com>
Date:   Tue, 15 Jun 2021 13:33:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hJ0-U7-rMApDF72xVO2PQEdbzWtVkrOQVp4xnxGHoyuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/15/21 12:59 PM, Rafael J. Wysocki wrote:
> On Tue, Jun 15, 2021 at 12:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> On some Lenovo laptops the base-addrsss of some PCI devices is left
>> at 0 at boot:
>>
>> [    0.283145] pci 0000:00:15.0: [8086:34e8] type 00 class 0x0c8000
>> [    0.283217] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
>> [    0.285117] pci 0000:00:15.1: [8086:34e9] type 00 class 0x0c8000
>> [    0.285189] pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
>>
>> There is a _CRS method for these devices, which simply returns the
>> configured 0 address. This is causing the PCI core to not assign
>> memory to these PCI devices and is causing these errors:
>>
>> [    0.655335] pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>> [    0.655337] pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
>> [    0.655339] pci 0000:00:15.1: BAR 0: no space for [mem size 0x00001000 64bit]
>> [    0.655340] pci 0000:00:15.1: BAR 0: failed to assign [mem size 0x00001000 64bit]
>>
>> This happens specifically for the designware I2C PCI devices on these
>> laptops, causing I2C-HID attached touchpads/touchscreens to not work.
>>
>> Booting with nocrs on these devices results in the kernel itself
>> assigning memory to these devices, fixing things:
>>
>> [    0.355716] pci 0000:00:15.0: BAR 0: assigned [mem 0x29c000000-0x29c000fff 64bit]
>> [    0.355783] pci 0000:00:15.1: BAR 0: assigned [mem 0x29c001000-0x29c001fff 64bit]
>>
>> At least the following models are known to be affected by this (but there
>> might be more):
>>
>> Lenovo IdeaPad 3 15IIL05 81WE
>> Lenovo IdeaPad 5 14IIL05 81YH
>>
>> Add an extra check for the base-address being 0 to
>> acpi_pci_root_validate_resources() and reject IOMEM resources where this
>> is the case, to fix this issue.
>>
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>> BugLink: https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1878279
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Note we could instead add the known to be affected models to the
>> pci_crs_quirks table in arch/x86/pci/acpi.c, but it is likely that more
>> systems are affected and a more generic fix seems better in general.
> 
> Also, a memory resource starting at 0 is not usable in Linux anyway
> AFAICS, at least on x86.

Right, but I was wondering about other arches. Maybe wrap the new check in
"#if IS_ENABLED(CONFIG_X86)" ?

Regards,

Hans



> 
>> ---
>>  drivers/acpi/pci_root.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index dcd593766a64..6cd2ca551005 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -686,6 +686,13 @@ static void acpi_pci_root_validate_resources(struct device *dev,
>>                 if (!(res1->flags & type))
>>                         goto next;
>>
>> +               if ((type & IORESOURCE_MEM) && res1->start == 0) {
>> +                       dev_info(dev, "host bridge window %pR (ignored, start address not set)\n",
>> +                                res1);
> 
> Makes sense to me (small nit: I wouldn't break the like above).
> 
>> +                       free = true;
>> +                       goto next;
>> +               }
>> +
>>                 /* Exclude non-addressable range or non-addressable portion */
>>                 end = min(res1->end, root->end);
>>                 if (end <= res1->start) {
>> --
> 

