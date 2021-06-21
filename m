Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1936D3AE85F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 13:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhFULvX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 07:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229651AbhFULvW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jun 2021 07:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624276148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJPZla9Nfqr2RrZirGb/byjG6Y8QJsw5Ao0G4GXTI2E=;
        b=ApqpBHDGIh+y0KFtMD/D/DhdPTjs/6J25415eNOvjQuiUGeQ6/WU+0zMp5uDPa7fgWsQMe
        ykbPerl4zUdRqVOPeuz9WSPcrbK9vRq2096vJx8W1C+B2hAp+bwVpApWsLk5EANxJ9qQPZ
        Jiy3BO0g+aBLvyos5FrFKQI0JwaPD/0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475--tfhIhfJNAKRfP2sixCPrg-1; Mon, 21 Jun 2021 07:49:07 -0400
X-MC-Unique: -tfhIhfJNAKRfP2sixCPrg-1
Received: by mail-ed1-f70.google.com with SMTP id q7-20020aa7cc070000b029038f59dab1c5so7642020edt.23
        for <linux-pci@vger.kernel.org>; Mon, 21 Jun 2021 04:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uJPZla9Nfqr2RrZirGb/byjG6Y8QJsw5Ao0G4GXTI2E=;
        b=iIyA47xet5rLogGPSGtxFS3GqqNL/9pCwg8OlFAp4RC17DAlE9tKdYdb4pQ6+W+/k8
         u8JdUXeiSW7i8ncpW4IlVcM+2W7ebI6O3e9QMSX+knnDKeSrH78uGWk4Ap92kObygpUG
         E8EmVSembtE29UOWcoRVZbM+eeZTzF3aPCCuCsUpeHCGBfnBVzQnDh/72+04mLlFWOoG
         msSU5QziOEUa11z+RX8byyG8EeeLWDBdGGOiFX64tE7i2bqiK3LDZmi2V3xNggoIcNgt
         777JGsxH+iRFh8Kh+tjMkjslAD/u8KQZ/4OBnRkXx4VQ1IX6by0+FqpcKto/okHNZQb5
         mgFw==
X-Gm-Message-State: AOAM531AE0vKFjt33/73cyy0bp4jBA6jSMHNklSwz3EPbvqhQnJ4h1D9
        bJyZPF4NqQ7sDYrUMzCFiLsrlyTW9FcqRoNQp3q3Bmaf1sEWwdVqP57R0l0Qy3ieTmx78fcQomo
        7EolEHqfvM3AT7SwGp+emfzmHpE0wSE0o406KCAiThtmqU9Xg7aN8hLGMQOHcSJ8PQ71IXqPA
X-Received: by 2002:aa7:de90:: with SMTP id j16mr21000330edv.385.1624276146008;
        Mon, 21 Jun 2021 04:49:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2oxNb10dA/3EGJ7N10R8FdA+Q/jWD/5nymS0L7kJ/zwPGhPspch3I7fuK/8tT2Zrq1ATLWw==
X-Received: by 2002:aa7:de90:: with SMTP id j16mr21000303edv.385.1624276145791;
        Mon, 21 Jun 2021 04:49:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f4sm4736416ejj.49.2021.06.21.04.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 04:49:05 -0700 (PDT)
Subject: Re: [RFC 1/1] PCI/ACPI: Make acpi_pci_root_validate_resources()
 reject IOMEM resources which start at address 0
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
References: <20210616225705.GA3014869@bjorn-Precision-5520>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c55ee3ef-f15e-d043-4cdf-35c1026089ec@redhat.com>
Date:   Mon, 21 Jun 2021 13:49:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210616225705.GA3014869@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 6/17/21 12:57 AM, Bjorn Helgaas wrote:
> On Wed, Jun 16, 2021 at 08:43:12PM +0200, Hans de Goede wrote:
>> On 6/15/21 10:23 PM, Bjorn Helgaas wrote:
>>> On Tue, Jun 15, 2021 at 12:25:55PM +0200, Hans de Goede wrote:
> 
>> I've 2 dmesgs from runs both with and without pci=nocrs, the one
>> with a clean kernel commandline (no special options) yields:
>>
>> [    0.312333] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>> [    0.312335] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>> [    0.312336] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>> [    0.312337] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>> [    0.312338] pci_bus 0000:00: root bus resource [bus 00-fe]
>>
>> Where as the one with pci=nocrs on the kernel commandline gives:
>>
>> [    0.271766] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>> [    0.271767] pci_bus 0000:00: root bus resource [mem 0x00000000-0x7fffffffff]
>> [    0.271768] pci_bus 0000:00: root bus resource [bus 00-fe]
>>
>> Hmm, so assuming that you are right that pci=nocrs only influences
>> the root resources (and I believe you are), and given that the problem is
>> that we are getting these errors:
>>
>> [    0.655335] pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>> [    0.655337] pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
>> [    0.655339] pci 0000:00:15.1: BAR 0: no space for [mem size 0x00001000 64bit]
>> [    0.655340] pci 0000:00:15.1: BAR 0: failed to assign [mem size 0x00001000 64bit]
>> [    0.655342] pci 0000:00:1f.5: BAR 0: no space for [mem size 0x00001000]
>>
>> Instead of getting this:
>>
>> [    0.355716] pci 0000:00:15.0: BAR 0: assigned [mem 0x29c000000-0x29c000fff 64bit]
>> [    0.355783] pci 0000:00:15.1: BAR 0: assigned [mem 0x29c001000-0x29c001fff 64bit]
>>
>> So now I believe that my initial theory for this is probably completely wrong; and
>> I wonder if the issue is that the _CRS returned root IOMEM window is big enough
>> to exactly hold the BIOS assigned mappings, but it does not have any free space
>> allowing the kernel to assign space for the 0000:00:15.0 and 0000:00:15.1
>> devices ?
>>
>> Assuming that that theory is right, how could we work around this problem?
>> Or at least do a quick debug patch to confirm that indeed the window is "full" ?
> 
> I'd be pretty surprised if the host bridge window actually full --
> [mem 0x65400000-0xbfffffff] is a pretty big range and these devices
> only need 4K each.

Yeah, I just checked and the highest used IOMEM window ends at
0x811300ff leaving plenty of space after it for the 2 new windows.

> But maybe we aren't smart enough when trying to allocate space.
> Places like __pci_bus_size_bridges() and __pci_assign_resource() are
> full of assumptions about what PCI BARs can go where, depending on
> 64bit-ness, prefetchability, etc.
> 
> Maybe instrumenting those allocation paths would give some insight.
> Possibly we should go ahead and merge some permanent pci_dbg() stuff
> there too.

I agree that this seems to be the most likely issue. I've build
a Fedora kernel pkg with some extra debugging added for the reporter
to be test.  Since I'm reliant on a debug cycle where I provide
a kernel and then the reporter comes back with a new debug,
and then rince-repeat it might be a while before I get back to you
on this.  Hopefully when I do get back I will have figured out
what the problem is.

(and in case it was not clear yet the RFC patch which started this
discussion clearly is bogus and can be considered dropped).

> I do note that the working "pci=nocrs" case puts these devices above
> 4GB.  _CRS only told you about host bridge windows *below* 4GB, and
> Linux will never assign space that's outside the windows (except in
> the "pci=nocrs" case, of course).

That is not unexpected, pci_bus_alloc_resource() will first try the
pci_high region which starts at 0x100000000. But it is definitely
an interesting data point.

Regards,

Hans

