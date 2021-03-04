Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A940932D5A0
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 15:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhCDOog (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Mar 2021 09:44:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232450AbhCDOoQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Mar 2021 09:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614868971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WtE6rQGgBStCxiYKH1KCeU5bCMvRZhVHeezm1zYPWL4=;
        b=NRNE5o5O3kLS1FxTAfEkIoEAmmESitlA8t3rkig469WE9d5Mdis0Ms46l5QtHA0MzOIayX
        7oxx8E3U7oTu983aviGGYdWjhJMVeIIuvBqhMNzQiE9KISqVhjNzDsjfn4ihL1XCdmwCeK
        uFmXsy450Oav9yWGUi42sgqtqc7tgp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-NX1wg6mjM5So2T6usmvUug-1; Thu, 04 Mar 2021 09:42:46 -0500
X-MC-Unique: NX1wg6mjM5So2T6usmvUug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4827983DD28;
        Thu,  4 Mar 2021 14:42:45 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9037B5DA2D;
        Thu,  4 Mar 2021 14:42:44 +0000 (UTC)
Subject: Re: [PATCH] pci-driver: Add driver load messages
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>, bhelgaas@google.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, mstowe@redhat.com
References: <20210218190603.GA993998@bjorn-Precision-5520>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <4a584957-24d5-54c8-07f8-36fd7d2e9fce@redhat.com>
Date:   Thu, 4 Mar 2021 09:42:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210218190603.GA993998@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/18/21 2:06 PM, Bjorn Helgaas wrote:
> On Thu, Feb 18, 2021 at 01:36:35PM -0500, Prarit Bhargava wrote:
>> On 1/26/21 10:12 AM, Bjorn Helgaas wrote:
>>> On Tue, Jan 26, 2021 at 09:05:23AM -0500, Prarit Bhargava wrote:
>>>> On 1/26/21 8:53 AM, Leon Romanovsky wrote:
>>>>> On Tue, Jan 26, 2021 at 08:42:12AM -0500, Prarit Bhargava wrote:
>>>>>> On 1/26/21 8:14 AM, Leon Romanovsky wrote:
>>>>>>> On Tue, Jan 26, 2021 at 07:54:46AM -0500, Prarit Bhargava wrote:
>>>>>>>>   Leon Romanovsky <leon@kernel.org> wrote:
>>>>>>>>> On Mon, Jan 25, 2021 at 02:41:38PM -0500, Prarit Bhargava wrote:
>>>>>>>>>> There are two situations where driver load messages are helpful.
>>>>>>>>>>
>>>>>>>>>> 1) Some drivers silently load on devices and debugging driver or system
>>>>>>>>>> failures in these cases is difficult.  While some drivers (networking
>>>>>>>>>> for example) may not completely initialize when the PCI driver probe() function
>>>>>>>>>> has returned, it is still useful to have some idea of driver completion.
>>>>>>>>>
>>>>>>>>> Sorry, probably it is me, but I don't understand this use case.
>>>>>>>>> Are you adding global to whole kernel command line boot argument to debug
>>>>>>>>> what and when?
>>>>>>>>>
>>>>>>>>> During boot:
>>>>>>>>> If device success, you will see it in /sys/bus/pci/[drivers|devices]/*.
>>>>>>>>> If device fails, you should get an error from that device (fix the
>>>>>>>>> device to return an error), or something immediately won't work and
>>>>>>>>> you won't see it in sysfs.
>>>>>>>>
>>>>>>>> What if there is a panic during boot?  There's no way to get to sysfs.
>>>>>>>> That's the case where this is helpful.
>>>>>>>
>>>>>>> How? If you have kernel panic, it means you have much more worse problem
>>>>>>> than not-supported device. If kernel panic was caused by the driver, you
>>>>>>> will see call trace related to it. If kernel panic was caused by
>>>>>>> something else, supported/not supported won't help here.
>>>>>>
>>>>>> I still have no idea *WHICH* device it was that the panic occurred on.
>>>>>
>>>>> The kernel panic is printed from the driver. There is one driver loaded
>>>>> for all same PCI devices which are probed without relation to their
>>>>> number.>
>>>>> If you have host with ten same cards, you will see one driver and this
>>>>> is where the problem and not in supported/not-supported device.
>>>>
>>>> That's true, but you can also have different cards loading the same driver.
>>>> See, for example, any PCI_IDs list in a driver.
>>>>
>>>> For example,
>>>>
>>>> 10:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3008 [Fury] (rev 02)
>>>> 20:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3108 [Invader] (rev 02)
>>>>
>>>> Both load the megaraid driver and have different profiles within the
>>>> driver.  I have no idea which one actually panicked until removing
>>>> one card.
>>>>
>>>> It's MUCH worse when debugging new hardware and getting a panic
>>>> from, for example, the uncore code which binds to a PCI mapped
>>>> device.  One device might work and the next one doesn't.  And
>>>> then you can multiply that by seeing *many* panics at once and
>>>> trying to determine if the problem was on one specific socket,
>>>> die, or core.
>>>
>>> Would a dev_panic() interface that identified the device and
>>> driver help with this?
>>
>> ^^ the more I look at this problem, the more a dev_panic() that
>> would output a device specific message at panic time is what I
>> really need.

Bjorn,

I went down this road a bit and had a realization.  The issue isn't with
printing something at panic time, but the *data* that is output.  Each PCI
device is associated with a struct device.  That device struct's name is output
for dev_dbg(), etc., commands.  The PCI subsystem sets the device struct name at
drivers/pci/probe.c: 1799

	        dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
                     dev->bus->number, PCI_SLOT(dev->devfn),
                     PCI_FUNC(dev->devfn));

My problem really is that the above information is insufficient when I (or a
user) need to debug a system.  The complexities of debugging multiple broken
driver loads would be much easier if I didn't have to constantly add this output
manually :).

Would you be okay with adding a *debug* parameter to expand the device name to
include the vendor & device ID pair?  FWIW, I'm somewhat against
yet-another-kernel-option but that's really the information I need.  I could
then add dev_dbg() statements in the local_pci_probe() function.

Thoughts?

P.



