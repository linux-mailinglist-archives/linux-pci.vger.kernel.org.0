Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47663269254
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 18:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgINQ7B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgINQ4C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 12:56:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD51AC061797
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2020 09:55:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z17so266278pgc.4
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2020 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ea+ZW1A7YbcpqTkgliK0jWyiobb/VnbwaIbkYZAOVbM=;
        b=R8Y6wmPEsRZE6C8fYNWPVfUGXlnEM5IgMX/oMGHWJKShpepxLh9fgKfli5w6RfYOUz
         1ZIRVx/SxYlYZLpzUXUXEdSx0LDuBt54xgTHGW6hzgyOLHFZ9t4osoGJNrQ+tURR3KdJ
         9ANhxR9uYXBM1a0ZItLsuiQLHVpP6sj/9mrN5z0nEPt1lOEheEhCbzP6Pw/KICt3Wbjm
         L5EBuwKMdP5q8Zn5SPMuVODu+ahaKLyyIFxUCffa5USdvIF15oLHSkn8rEMxtmWKhxGq
         9QkmjwD8CuapJZON+ePTOZdsYxKWcaxBq8ZV7wl7v1gKnsDWlZt9LCLyZOgZbZr4Oasz
         PkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ea+ZW1A7YbcpqTkgliK0jWyiobb/VnbwaIbkYZAOVbM=;
        b=WJtVU3Mx4ZQYSgJDNaV3k8EUV1S02mpR+XJYV9AVqICgws1kLiQ82l245jHb2O/uie
         XmFhlkW3pyCumb6ggbwxC8KLrOdgIlq47C68hYIJkQQuEjbHO1DpsR6RbncAd712jW0O
         hNhepIGPjTNyTCsSqgN3yHgVdoLw0qWTbmlcXbLsdRZ3dlNx6CtFU7/6j0LTvk1f+IRg
         6t0yQ8Mhi/Ub9faU5/4jkmZ9p69r189E48Od0d+aEWQkWf4cRV+te97DEf/ctMuWqUfp
         sCAM5ozka9DGuPLBxS8ATfC1TY3FwdgwM6FZYbR0Odu29+wmJCGThTXxM+dkm0uan7bw
         nUpw==
X-Gm-Message-State: AOAM532T44LgyTZhf3TQyYFZxZ7tRV3W93KUmEOyo9Jrj71Fq0+R9CVD
        aqr0yuNgG4U+wSi006YsHaDYtA==
X-Google-Smtp-Source: ABdhPJx0m7t2eJqGYfDjTWx6SvRiWkjiGbVrjHbBvoLoGdBIQzvBgdYp+8ibbu9B1IKADnZE5jvJxw==
X-Received: by 2002:a63:160d:: with SMTP id w13mr11214420pgl.97.1600102555984;
        Mon, 14 Sep 2020 09:55:55 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id a138sm11191748pfd.19.2020.09.14.09.55.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2020 09:55:55 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, sathyanarayanan.kuppuswamy@linux.intel.com,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] PCI/RCEC: Add pcie_walk_rcec() to walk
 associated RCiEPs
Date:   Mon, 14 Sep 2020 09:55:53 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <7B04CA9A-7332-4001-963B-E56642044F5D@intel.com>
In-Reply-To: <20200912005013.GA912147@bjorn-Precision-5520>
References: <20200912005013.GA912147@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11 Sep 2020, at 17:50, Bjorn Helgaas wrote:

> On Fri, Sep 11, 2020 at 04:16:03PM -0700, Sean V Kelley wrote:
>> On 4 Sep 2020, at 19:23, Bjorn Helgaas wrote:
>>> On Fri, Sep 04, 2020 at 10:18:30PM +0000, Kelley, Sean V wrote:
>>>> Hi Bjorn,
>>>>
>>>> Quick question below...
>>>>
>>>> On Wed, 2020-09-02 at 14:55 -0700, Sean V Kelley wrote:
>>>>> Hi Bjorn,
>>>>>
>>>>> On Wed, 2020-09-02 at 14:00 -0500, Bjorn Helgaas wrote:
>>>>>> On Wed, Aug 12, 2020 at 09:46:53AM -0700, Sean V Kelley wrote:
>>>>>>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>>>>>
>>>>>>> When an RCEC device signals error(s) to a CPU core, the CPU core
>>>>>>> needs to walk all the RCiEPs associated with that RCEC to check
>>>>>>> errors. So add the function pcie_walk_rcec() to walk all RCiEPs
>>>>>>> associated with the RCEC device.
>>>>>>>
>>>>>>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>>>>>>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>>>>>>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>>> ---
>>>>>>>  drivers/pci/pci.h       |  4 +++
>>>>>>>  drivers/pci/pcie/rcec.c | 76
>>>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>>>>  2 files changed, 80 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>>>> index bd25e6047b54..8bd7528d6977 100644
>>>>>>> --- a/drivers/pci/pci.h
>>>>>>> +++ b/drivers/pci/pci.h
>>>>>>> @@ -473,9 +473,13 @@ static inline void pci_dpc_init(struct
>>>>>>> pci_dev
>>>>>>> *pdev) {}
>>>>>>>  #ifdef CONFIG_PCIEPORTBUS
>>>>>>>  void pci_rcec_init(struct pci_dev *dev);
>>>>>>>  void pci_rcec_exit(struct pci_dev *dev);
>>>>>>> +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct
>>>>>>> pci_dev
>>>>>>> *, void *),
>>>>>>> +		    void *userdata);
>>>>>>>  #else
>>>>>>>  static inline void pci_rcec_init(struct pci_dev *dev) {}
>>>>>>>  static inline void pci_rcec_exit(struct pci_dev *dev) {}
>>>>>>> +static inline void pcie_walk_rcec(struct pci_dev *rcec, int
>>>>>>> (*cb)(struct pci_dev *, void *),
>>>>>>> +				  void *userdata) {}
>>>>>>>  #endif
>>>>>>>
>>>>>>>  #ifdef CONFIG_PCI_ATS
>>>>>>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
>>>>>>> index 519ae086ff41..405f92fcdf7f 100644
>>>>>>> --- a/drivers/pci/pcie/rcec.c
>>>>>>> +++ b/drivers/pci/pcie/rcec.c
>>>>>>> @@ -17,6 +17,82 @@
>>>>>>>
>>>>>>>  #include "../pci.h"
>>>>>>>
>>>>>>> +static int pcie_walk_rciep_devfn(struct pci_bus *bus, int
>>>>>>> (*cb)(struct pci_dev *, void *),
>>>>>>> +				 void *userdata, const unsigned long
>>>>>>> bitmap)
>>>>>>> +{
>>>>>>> +	unsigned int devn, fn;
>>>>>>> +	struct pci_dev *dev;
>>>>>>> +	int retval;
>>>>>>> +
>>>>>>> +	for_each_set_bit(devn, &bitmap, 32) {
>>>>>>> +		for (fn = 0; fn < 8; fn++) {
>>>>>>> +			dev = pci_get_slot(bus, PCI_DEVFN(devn, fn));
>>>>>>
>>>>>> Wow, this is a lot of churning to call pci_get_slot() 256 times 
>>>>>> per
>>>>>> bus for the "associated bus numbers" case where we pass a bitmap 
>>>>>> of
>>>>>> 0xffffffff.  They didn't really make it easy for software when 
>>>>>> they
>>>>>> added the next/last bus number thing.
>>>>>>
>>>>>> Just thinking out loud here.  What if we could set dev->rcec 
>>>>>> during
>>>>>> enumeration, and then use that to build pcie_walk_rcec()?
>>>>>
>>>>> I think follow what you are doing.
>>>>>
>>>>> As we enumerate an RCEC, use the time to discover RCiEPs and
>>>>> associate
>>>>> each RCiEP's dev->rcec. Although BIOS already set the bitmap for
>>>>> this
>>>>> specific RCEC, it's more efficient to simply discover the devices
>>>>> through the bus walk and verify each one found against the bitmap.
>>>>>
>>>>> Further, while we can be certain that an RCiEP found with a 
>>>>> matching
>>>>> device no. in a bitmap for an associated RCEC is correct, we 
>>>>> cannot
>>>>> be
>>>>> certain that any RCiEP found on another bus range is correct 
>>>>> unless
>>>>> we
>>>>> verify the bus is within that next/last bus range.
>>>>>
>>>>> Finally, that's where find_rcec() callback for rcec_assoc_rciep()
>>>>> does
>>>>> double duty by also checking on the "on-a-separate-bus" case
>>>>> captured
>>>>> potentially by find_rcec() during an RCiEP's bus walk.
>>>>>
>>>>>
>>>>>>   bool rcec_assoc_rciep(rcec, rciep)
>>>>>>   {
>>>>>>     if (rcec->bus == rciep->bus)
>>>>>>       return (rcec->bitmap contains rciep->devfn);
>>>>>>
>>>>>>     return (rcec->next/last contains rciep->bus);
>>>>>>   }
>>>>>>
>>>>>>   link_rcec(dev, data)
>>>>>>   {
>>>>>>     struct pci_dev *rcec = data;
>>>>>>
>>>>>>     if ((dev is RCiEP) && rcec_assoc_rciep(rcec, dev))
>>>>>>       dev->rcec = rcec;
>>>>>>   }
>>>>>>
>>>>>>   find_rcec(dev, data)
>>>>>>   {
>>>>>>     struct pci_dev *rciep = data;
>>>>>>
>>>>>>     if ((dev is RCEC) && rcec_assoc_rciep(dev, rciep))
>>>>>>       rciep->rcec = dev;
>>>>>>   }
>>>>>>
>>>>>>   pci_setup_device
>>>>>>     ...
>>>>
>>>> I just noticed your use of pci_setup_device(). Are you suggesting
>>>> moving the call to pci_rcec_init() out of pci_init_capabilities() 
>>>> and
>>>> move it into pci_setup_device()?  If so, would pci_rcec_exit() 
>>>> still
>>>> remain in pci_release_capabilities()?
>>>>
>>>> I'm just wondering if it could just remain in
>>>> pci_init_capabilities().
>>>
>>> Yeah, I didn't mean in pci_setup_device() specifically, just 
>>> somewhere
>>> in the callchain of pci_setup_device().  But you're right, it 
>>> probably
>>> would make more sense in pci_init_capabilities(), so I *should* have
>>> said pci_scan_single_device() to be a little less specific.
>>
>> I’ve done some experimenting with this approach, and I think there 
>> may be a
>> problem of just walking the busses during enumeration
>> pci_init_capabilities(). One problem is where one has an RCEC on a 
>> root bus:
>> 6a(00.4) and an RCiEP on another root bus: 6b(00.0).  They will never 
>> find
>> each other in this approach through a normal pci_bus_walk() call 
>> using their
>> respective root_bus.
>>
>>>  +-[0000:6b]-+-00.0
>>>  |           +-00.1
>>>  |           +-00.2
>>>  |           \-00.3
>>>  +-[0000:6a]-+-00.0
>>>  |           +-00.1
>>>  |           +-00.2
>>>  |           \-00.4
>
> Wow, is that even allowed?
>
> There's no bridge from 0000:6a to 0000:6b, so we will not scan 0000:6b
> unless we find a host bridge with _CRS where 6b is the first bus
> number below the bridge.  I think that means this would have to be
> described in ACPI as two separate root bridges:
>
>   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 6a])
>   ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 6b])

Otherwise, the RCEC Associated Endpoint Extended Capabilities would have 
to have explicitly mentioned a bridge?

>
> I *guess* maybe it's allowed by the PCIe spec to have an RCEC and
> associated RCiEPs on separate root buses?  It seems awfully strange
> and not in character for PCIe, but I guess I can't point to language
> that prohibits it.

Yes, it should be possible.

>
>> While having a lot of slot calls per bus is unfortunate, unless I’m 
>> mistaken
>> you would have to walk every peer root_bus with your RCiEP in this 
>> example
>> until you hit on the right RCEC, unless of course you have a bitmap
>> associated RCEC on dev->bus.
>
> I really despise pci_find_bus(), pci_get_slot(), and related
> functions, but maybe they can't be avoided.
>
> I briefly hoped we could forget about connecting them at
> enumeration-time and just build a list of RCECs in the host bridge.
> Then when we handle an event for an RCiEP, we could search the list to
> find the right RCEC (and potentially cache it then).  But I don't
> think that would work either, because in the example above, they will
> be under different host bridges.  I guess we could maybe have a global
> (or maybe per-domain) list of RCECs.

Right, we could just have a list and only need to search the list when 
we need to handle an event.

>
>> Conversely, if you are enumerating the above RCEC at 6a(00.4) and you
>> attempt to link_rcec() through calls to pci_walk_bus(), the walk will 
>> still
>> be limited to 6a and below; never encountering 6b(00.0).  So you 
>> would then
>> need an additional walk for each of the associated bus ranges, 
>> excluding the
>> same bus as the RCEC.
>>
>> pci_init_capabilities()
>> …
>> pci_init_rcec() // Cached
>>
>> if (RCEC)
>>  Walk the dev->bus for bitmap associated RCiEP
>>  Walk all associated bus ranges for RCiEP
>>
>> else if (RCiEP)
>>  Walk the dev->bus for bitmap associated RCEC
>>  Walk all peer root_bus for RCEC, confirm if own dev->bus falls 
>> within
>> discovered RCEC associated ranges
>>
>> The other problem here is temporal. I’m wondering if we may be 
>> trying to
>> find associated devices at the pci_init_capabilities() stage prior to 
>> them
>> being fully enumerated, i.e., RCEC has not been cached but we are 
>> searching
>> with a future associated RCiEP.  So one could encounter a race 
>> condition
>> where one is checking on an RCiEP whose associated RCEC has not been
>> enumerated yet.
>
> Maybe I'm misunderstanding this problem, but I think my idea would
> handle this: If we find the RCEC first, we cache its info and do
> nothing else.  When we subsequently discover an RCiEP, we walk the
> tree, find the RCEC, and connect them.
>
> If we find an RCiEP first, we do nothing.  When we subsequently
> discover an RCEC, we walk the tree, find any associated RCiEPs, and
> connect them.


Your approach makes sense. In retrospect, I don’t think there can be a 
race condition here because of the fallback from one RCEC to the other 
when they enumerate. You have two chances of finding the relationship.

>
> The discovery can happen in different orders based on the
> bus/device/function numbers, but it's not really a race because
> enumeration is single-threaded.  But if we're talking about two
> separate host bridges (PNP0A03 devices), we *should* allow them to be
> enumerated in parallel, even though we don't do that today.
>
> I think this RCEC association design is really kind of problematic.
>
> We don't really *need* the association until some RCiEP event (PME,
> error, etc) occurs, so it's reasonable to defer making the RCEC
> connection until then.  But it seems like things should be designed so
> we're guaranteed to enumerate the RCEC before the RCiEPs.  Otherwise,
> we don't really know when we can enable RCiEP events.  If we discover
> an RCiEP first, enable error reporting, and an error occurs before we
> find the RCEC, we're in a bit of a pickle.

So we could have a global list (RCiEP or RCEC) in which we wait to 
identify the associations only when we need to respond to events. Or in 
your original suggestion we could walk the RCEC bus ranges in addition 
to its root_bus.

i.e., We bus walk an enumerating RCEC with link_rcec() callback for not 
only the root_bus but each bus number in the associated ranges if the 
extended cap exists.

RCiEPs will simply continue to invoke their callback via find_rcec() and 
only check on their own bus for the encountered RCEC’s associated 
bitmap case.


Sean

>
>> So let’s say one throws out RCiEP entirely and just relies upon 
>> RCEC to find
>> the associations because one knows that an encountered RCEC (in
>> pci_init_capabilities()) has already been cached. In that case you 
>> end up
>> with the original implementation being done with this patch series…
>>
>> if (RCEC)
>>  Walk the dev->bus for bitmap associated RCiEP
>>  Walk all associated bus ranges for RCiEP
>>
>> Perhaps I’ve muddled some things here but it doesn’t look like 
>> the twain
>> will meet unless I cover multiple peer root_bus and even then you may 
>> have
>> an issue because the devices don’t yet fully exist from the 
>> perspective of
>> the OS.
>>
>> Thanks,
>>
>> Sean
