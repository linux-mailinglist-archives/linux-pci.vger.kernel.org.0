Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1EB3AA36D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 20:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFPSqQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 14:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232003AbhFPSqP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 14:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623869048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BFWFjPS5d2LcTVJqwPfBWasVP+1kEMmnR6L/wnzxkXE=;
        b=DCh3JufI94gHj9hL7q5EZbt4ihAyFilDhNmOmmMusytGoRnhyWIr4qbpjlPsqoQlLQZ21N
        tF7qZoWLwHd29/5mzfWgFgY0Yhy2S2vCA2V5aJfd8RY20Hw7BH4cQSSdDjhTMYz/LDhiNh
        AZyFJ0gP7JHCKFc6f/f0w1xfSyhR18g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-uAqvTvthPBygq3qaOxHBiw-1; Wed, 16 Jun 2021 14:43:15 -0400
X-MC-Unique: uAqvTvthPBygq3qaOxHBiw-1
Received: by mail-ej1-f72.google.com with SMTP id l6-20020a1709062a86b029046ec0ceaf5cso1326116eje.8
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 11:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BFWFjPS5d2LcTVJqwPfBWasVP+1kEMmnR6L/wnzxkXE=;
        b=sn8le/k4s0zbR+9gUSDTRgnY7wP4MOgYj2dHgWLGpPTOIXeGY6lniCFbTUj9q2lHo/
         83QnYHywDuswGok49OLnORtyINMD/4x/rdyyO8tvJ+7SJLczG7uhvuizAWmB1L7hd5e6
         jVifbruOUuwfPLa395UfIV631Op2y0UiR7BEIqRb/adUtEc0KNLWdYByfejP24gWtzeF
         1hI1EJIoRlc2oqRTfOZuksHM56IqyKUg/LanNRyEJ7Sa3xa/XG1a6oqF2hQnDES/lLGs
         EKl11Z4M1lVkVUcZ71JHf9iWl82IU4sjSJgDNjO2fYTQ9ngwM382bFV9GnmVjlF0QAlB
         tTNA==
X-Gm-Message-State: AOAM530KjIcx47WWe6Y9wgeE9oK/sAHRia/+U+CkXrjV+JDTzmtVyAYX
        L+pEXts/APRoXsiz0dnRwrGNZF+7MDO2tBwnPOHvQrKyJwDOAkJRXwnLFuO8WHwbWHRmYRrw9Mo
        FpjhYV3YJT6cpdwPIxZ/5XaPMbb24hCPuR7kh1n8wAC9To8MV3G3YJCBtYmExOMhyiz+fr9HV
X-Received: by 2002:a17:907:7201:: with SMTP id dr1mr944625ejc.19.1623868993741;
        Wed, 16 Jun 2021 11:43:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKdn5kUSwDiISvQZ6ew6zMbAn+Q7gbTD6L0DYvB+3Ja3fr0BcTK5sPRn9jlNFUp5Yhb7EYjg==
X-Received: by 2002:a17:907:7201:: with SMTP id dr1mr944603ejc.19.1623868993492;
        Wed, 16 Jun 2021 11:43:13 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bd3sm2439036edb.34.2021.06.16.11.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 11:43:13 -0700 (PDT)
Subject: Re: [RFC 1/1] PCI/ACPI: Make acpi_pci_root_validate_resources()
 reject IOMEM resources which start at address 0
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
References: <20210615202322.GA2910413@bjorn-Precision-5520>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8065c303-fc11-93f2-64a5-39048b7501fd@redhat.com>
Date:   Wed, 16 Jun 2021 20:43:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210615202322.GA2910413@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/15/21 10:23 PM, Bjorn Helgaas wrote:
> On Tue, Jun 15, 2021 at 12:25:55PM +0200, Hans de Goede wrote:
>> On some Lenovo laptops the base-addrsss of some PCI devices is left
>> at 0 at boot:
>>
>> [    0.283145] pci 0000:00:15.0: [8086:34e8] type 00 class 0x0c8000
>> [    0.283217] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
>> [    0.285117] pci 0000:00:15.1: [8086:34e9] type 00 class 0x0c8000
>> [    0.285189] pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> 
> s/base-addrsss/base-address/
> Timestamps aren't relevant here and can be trimmed.

Ack.

> It's not really an error if BIOS leaves a PCI BAR unprogrammed.
> 
>> There is a _CRS method for these devices, which simply returns the
>> configured 0 address. This is causing the PCI core to not assign
>> memory to these PCI devices and is causing these errors:
>>
>> [    0.655335] pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>> [    0.655337] pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
>> [    0.655339] pci 0000:00:15.1: BAR 0: no space for [mem size 0x00001000 64bit]
>> [    0.655340] pci 0000:00:15.1: BAR 0: failed to assign [mem size 0x00001000 64bit]
> 
> I'm confused.  Did you say there's a _CRS method for these *PCI*
> devices (0000:00:15.0, 0000:00:15.1)?

That is what I intended to say, but TBH I don't fully grasp the
problem at hand yet and I have not checked this in an actual acpidump.

I would need to see if someone attached an acpidump for one of the
affected devices to some bug and then I can check...

> I suspect you mean the *host bridge* has a _CRS method, since I think
> acpi_pci_root_validate_resources() is looking at contents of the host
> bridge _CRS.

You would expect that from the name, but when I was checking for the
handling of the pci=nocrs kernel-commandline option the only
place dealing with this which I could find are:

arch/x86/pci/common.c, which sets does "pci_probe |= PCI_ROOT_NO_CRS"
where pci_probe is a set of global flags

and:

arch/x86/pci/acpi.c, which sets a static bool pci_use_crs; at
the global level based on this, and the only place where
pci_use_crs is checked is here:

static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
{
        struct acpi_device *device = ci->bridge;
        int busnum = ci->root->secondary.start;
        struct resource_entry *entry, *tmp;
        int status;

        status = acpi_pci_probe_root_resources(ci);
        if (pci_use_crs) {
                resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
                        if (resource_is_pcicfg_ioport(entry->res))
                                resource_list_destroy_entry(entry);
                return status;
        }

And the patch which we are discussing here influences the
resource-list returned by acpi_pci_probe_root_resources(ci).

I was a bit surprised about this to, because as you say it looks like
this code is only about the root windows, but I could not find any
other code dealing with pci=nocrs and multiple users have confirmed
that using pci=nocrs helps.

So I ended up writing this patch; and then just asking users to
test and see what happens, but the patch might very well be
completely wrong, esp. since it indeed seems this only affects
root resources...

> On x86, it would likely be a BIOS defect is a host bridge _CRS had a
> memory window starting at 0, but you didn't show what _CRS contained.
> 
> The dmesg at https://bugzilla.redhat.com/show_bug.cgi?id=1871793 shows
> this, which looks totally normal and should be unaffected by the patch
> since there's no memory window starting at 0:
> 
>   pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>   pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>   pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>   pci_bus 0000:00: root bus resource [mem 0x6d400000-0xbfffffff window]
> 
> The ones at https://bugzilla.redhat.com/show_bug.cgi?id=1868899 and
> https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1878279
> are similar, so I can't quite connect the dots here.

I've 2 dmesgs from runs both with and without pci=nocrs, the one
with a clean kernel commandline (no special options) yields:

[    0.312333] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.312335] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.312336] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.312337] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
[    0.312338] pci_bus 0000:00: root bus resource [bus 00-fe]

Where as the one with pci=nocrs on the kernel commandline gives:

[    0.271766] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.271767] pci_bus 0000:00: root bus resource [mem 0x00000000-0x7fffffffff]
[    0.271768] pci_bus 0000:00: root bus resource [bus 00-fe]

Hmm, so assuming that you are right that pci=nocrs only influences
the root resources (and I believe you are), and given that the problem is
that we are getting these errors:

[    0.655335] pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
[    0.655337] pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
[    0.655339] pci 0000:00:15.1: BAR 0: no space for [mem size 0x00001000 64bit]
[    0.655340] pci 0000:00:15.1: BAR 0: failed to assign [mem size 0x00001000 64bit]
[    0.655342] pci 0000:00:1f.5: BAR 0: no space for [mem size 0x00001000]

Instead of getting this:

[    0.355716] pci 0000:00:15.0: BAR 0: assigned [mem 0x29c000000-0x29c000fff 64bit]
[    0.355783] pci 0000:00:15.1: BAR 0: assigned [mem 0x29c001000-0x29c001fff 64bit]

So now I believe that my initial theory for this is probably completely wrong; and
I wonder if the issue is that the _CRS returned root IOMEM window is big enough
to exactly hold the BIOS assigned mappings, but it does not have any free space
allowing the kernel to assign space for the 0000:00:15.0 and 0000:00:15.1
devices ?

Assuming that that theory is right, how could we work around this problem?
Or at least do a quick debug patch to confirm that indeed the window is "full" ?

>> This happens specifically for the designware I2C PCI devices on these
>> laptops, causing I2C-HID attached touchpads/touchscreens to not work.
>>
>> Booting with nocrs on these devices results in the kernel itself
>> assigning memory to these devices, fixing things:
> 
> "pci=nocrs" to help people repro this or try the same workaround
> elsewhere.

Not sure what you are trying to say here.

> 
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
> Definitely good to avoid pci_crs_quirks[] because throwing away _CRS
> completely leads us into uncharted waters, especially for multi-host
> bridge systems that support hotplug.

ack.

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
>>  		if (!(res1->flags & type))
>>  			goto next;
>>  
>> +		if ((type & IORESOURCE_MEM) && res1->start == 0) {
>> +			dev_info(dev, "host bridge window %pR (ignored, start address not set)\n",
>> +				 res1);
>> +			free = true;
>> +			goto next;
>> +		}
>> +
>>  		/* Exclude non-addressable range or non-addressable portion */
>>  		end = min(res1->end, root->end);
>>  		if (end <= res1->start) {
>> -- 
>> 2.31.1
>>
> 

