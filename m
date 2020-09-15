Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2418D26AB3B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 19:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgIORzG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 13:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgIORri (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 13:47:38 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6FCC061788
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2020 10:47:23 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f18so2359952pfa.10
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2020 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nwJVxs4AhvR850mPpzw5ipsgAbxQnq1d/rmaYAl+dk=;
        b=qx3k4Xsg5dfG5CEpHCWh2yi0ztzQ4v7m6k8DwsIRGyk9azmRgbZRY/sTCTZKsFNKVB
         gOT52hnSjvn2jIm8b97BGKt4PgByJv+G/hwKN5i/dWRYQJv0ziqyyUBPYTCsT5B2RI7W
         Qn74Ud8bpJzpoLB4E36lgnyV2KY0rz+kq0erZmokhukzPSa/LoPKCcM/EExudZdQzhxr
         Pv0+UXAeGuUDx/TLVofYPewPivxTQ6evXRpckvI4vAovMIJPPnoOoaimb/fe1JzVWtdO
         xU1osI0UHtJUWry5B2FNVxQiOnAFoTIpMrJaWi3JOL+S/QPbvmG7fgA0A3jXrVXk4uJe
         tWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nwJVxs4AhvR850mPpzw5ipsgAbxQnq1d/rmaYAl+dk=;
        b=CnTAWVbK+Whi5rxqc24yvpUC/0KF5flEOtqTDvjX3LqkeAonSEp9u1+7EnYtGnQTJX
         24nQHo9fDIznOh9vT22mwxg+SyS2AkFEgM9RN3hLUz+Xs3/mmA9t6xtBOnJTCHHKOvhf
         Al7aYnkxl0rwX3nr34VqB8BNHn4hKWOGeN0R3npVqcAPvPb/R/eyB4frqt52SRaqV5CK
         7dKsKnU23b0SwyfPhtKNAf2nfmCVuepDoI1b6fNmFAu5j4dzYRrdjotPBlhhF0fHfPLI
         mhhbiBtKSbnYUMiSOsxtkwzAPe1s78WoDYTu2jfD5OigxhiLGyLeUmL3CI4wEYcsx/BP
         SKoA==
X-Gm-Message-State: AOAM532oSGllBfH4CLicqeifbqyrj3LPKqGyEsBAYrna3PTNL9WQ1rnb
        DQZsbzCfdkYv/WYxRGc8Jha11Q==
X-Google-Smtp-Source: ABdhPJzafFs+Iqs67BDPGw3wZRzhPySjgS4lLgyIvN5eUFJjap1d7Q9JRWPURbtdewqIOAxGmMo3+Q==
X-Received: by 2002:a63:4284:: with SMTP id p126mr15756283pga.104.1600192042339;
        Tue, 15 Sep 2020 10:47:22 -0700 (PDT)
Received: from [10.212.12.128] (fmdmzpr04-ext.fm.intel.com. [192.55.55.39])
        by smtp.gmail.com with ESMTPSA id k29sm11736554pgf.21.2020.09.15.10.47.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:47:21 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, sathyanarayanan.kuppuswamy@linux.intel.com,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] PCI/RCEC: Add pcie_walk_rcec() to walk
 associated RCiEPs
Date:   Tue, 15 Sep 2020 10:47:17 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <659D9465-3A2D-472B-B6B3-EB6C5EB05ED5@intel.com>
In-Reply-To: <5BC1F7E6-64B8-4564-97A3-49C914CA926D@intel.com>
References: <20200912005013.GA912147@bjorn-Precision-5520>
 <7B04CA9A-7332-4001-963B-E56642044F5D@intel.com>
 <5BC1F7E6-64B8-4564-97A3-49C914CA926D@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15 Sep 2020, at 9:09, Sean V Kelley wrote:

> On 14 Sep 2020, at 9:55, Sean V Kelley wrote:
>
>> On 11 Sep 2020, at 17:50, Bjorn Helgaas wrote:
>>
>>> On Fri, Sep 11, 2020 at 04:16:03PM -0700, Sean V Kelley wrote:
>>>> On 4 Sep 2020, at 19:23, Bjorn Helgaas wrote:
>>>>> On Fri, Sep 04, 2020 at 10:18:30PM +0000, Kelley, Sean V wrote:
>>>>>> Hi Bjorn,
>>>>>>
>>>>>> Quick question below...
>>>>>>
>>>>>> On Wed, 2020-09-02 at 14:55 -0700, Sean V Kelley wrote:
>>>>>>> Hi Bjorn,
>>>>>>>
>>>>>>> On Wed, 2020-09-02 at 14:00 -0500, Bjorn Helgaas wrote:
>>>>>>>> On Wed, Aug 12, 2020 at 09:46:53AM -0700, Sean V Kelley wrote:
>>>>>>>>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>>>>>>>
>>>>>>>>> When an RCEC device signals error(s) to a CPU core, the CPU 
>>>>>>>>> core
>>>>>>>>> needs to walk all the RCiEPs associated with that RCEC to 
>>>>>>>>> check
>>>>>>>>> errors. So add the function pcie_walk_rcec() to walk all 
>>>>>>>>> RCiEPs
>>>>>>>>> associated with the RCEC device.
>>>>>>>>>
>>>>>>>>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>>>>>>>>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>>>>>>>>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>>>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>>>>> ---
>>>>>>>>>  drivers/pci/pci.h       |  4 +++
>>>>>>>>>  drivers/pci/pcie/rcec.c | 76
>>>>>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>  2 files changed, 80 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>>>>>> index bd25e6047b54..8bd7528d6977 100644
>>>>>>>>> --- a/drivers/pci/pci.h
>>>>>>>>> +++ b/drivers/pci/pci.h
>>>>>>>>> @@ -473,9 +473,13 @@ static inline void pci_dpc_init(struct
>>>>>>>>> pci_dev
>>>>>>>>> *pdev) {}
>>>>>>>>>  #ifdef CONFIG_PCIEPORTBUS
>>>>>>>>>  void pci_rcec_init(struct pci_dev *dev);
>>>>>>>>>  void pci_rcec_exit(struct pci_dev *dev);
>>>>>>>>> +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct
>>>>>>>>> pci_dev
>>>>>>>>> *, void *),
>>>>>>>>> +		    void *userdata);
>>>>>>>>>  #else
>>>>>>>>>  static inline void pci_rcec_init(struct pci_dev *dev) {}
>>>>>>>>>  static inline void pci_rcec_exit(struct pci_dev *dev) {}
>>>>>>>>> +static inline void pcie_walk_rcec(struct pci_dev *rcec, int
>>>>>>>>> (*cb)(struct pci_dev *, void *),
>>>>>>>>> +				  void *userdata) {}
>>>>>>>>>  #endif
>>>>>>>>>
>>>>>>>>>  #ifdef CONFIG_PCI_ATS
>>>>>>>>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
>>>>>>>>> index 519ae086ff41..405f92fcdf7f 100644
>>>>>>>>> --- a/drivers/pci/pcie/rcec.c
>>>>>>>>> +++ b/drivers/pci/pcie/rcec.c
>>>>>>>>> @@ -17,6 +17,82 @@
>>>>>>>>>
>>>>>>>>>  #include "../pci.h"
>>>>>>>>>
>>>>>>>>> +static int pcie_walk_rciep_devfn(struct pci_bus *bus, int
>>>>>>>>> (*cb)(struct pci_dev *, void *),
>>>>>>>>> +				 void *userdata, const unsigned long
>>>>>>>>> bitmap)
>>>>>>>>> +{
>>>>>>>>> +	unsigned int devn, fn;
>>>>>>>>> +	struct pci_dev *dev;
>>>>>>>>> +	int retval;
>>>>>>>>> +
>>>>>>>>> +	for_each_set_bit(devn, &bitmap, 32) {
>>>>>>>>> +		for (fn = 0; fn < 8; fn++) {
>>>>>>>>> +			dev = pci_get_slot(bus, PCI_DEVFN(devn, fn));
>>>>>>>>
>>>>>>>> Wow, this is a lot of churning to call pci_get_slot() 256 times 
>>>>>>>> per
>>>>>>>> bus for the "associated bus numbers" case where we pass a 
>>>>>>>> bitmap of
>>>>>>>> 0xffffffff.  They didn't really make it easy for software when 
>>>>>>>> they
>>>>>>>> added the next/last bus number thing.
>>>>>>>>
>>>>>>>> Just thinking out loud here.  What if we could set dev->rcec 
>>>>>>>> during
>>>>>>>> enumeration, and then use that to build pcie_walk_rcec()?
>>>>>>>
>>>>>>> I think follow what you are doing.
>>>>>>>
>>>>>>> As we enumerate an RCEC, use the time to discover RCiEPs and
>>>>>>> associate
>>>>>>> each RCiEP's dev->rcec. Although BIOS already set the bitmap for
>>>>>>> this
>>>>>>> specific RCEC, it's more efficient to simply discover the 
>>>>>>> devices
>>>>>>> through the bus walk and verify each one found against the 
>>>>>>> bitmap.
>>>>>>>
>>>>>>> Further, while we can be certain that an RCiEP found with a 
>>>>>>> matching
>>>>>>> device no. in a bitmap for an associated RCEC is correct, we 
>>>>>>> cannot
>>>>>>> be
>>>>>>> certain that any RCiEP found on another bus range is correct 
>>>>>>> unless
>>>>>>> we
>>>>>>> verify the bus is within that next/last bus range.
>>>>>>>
>>>>>>> Finally, that's where find_rcec() callback for 
>>>>>>> rcec_assoc_rciep()
>>>>>>> does
>>>>>>> double duty by also checking on the "on-a-separate-bus" case
>>>>>>> captured
>>>>>>> potentially by find_rcec() during an RCiEP's bus walk.
>>>>>>>
>>>>>>>
>>>>>>>>   bool rcec_assoc_rciep(rcec, rciep)
>>>>>>>>   {
>>>>>>>>     if (rcec->bus == rciep->bus)
>>>>>>>>       return (rcec->bitmap contains rciep->devfn);
>>>>>>>>
>>>>>>>>     return (rcec->next/last contains rciep->bus);
>>>>>>>>   }
>>>>>>>>
>>>>>>>>   link_rcec(dev, data)
>>>>>>>>   {
>>>>>>>>     struct pci_dev *rcec = data;
>>>>>>>>
>>>>>>>>     if ((dev is RCiEP) && rcec_assoc_rciep(rcec, dev))
>>>>>>>>       dev->rcec = rcec;
>>>>>>>>   }
>>>>>>>>
>>>>>>>>   find_rcec(dev, data)
>>>>>>>>   {
>>>>>>>>     struct pci_dev *rciep = data;
>>>>>>>>
>>>>>>>>     if ((dev is RCEC) && rcec_assoc_rciep(dev, rciep))
>>>>>>>>       rciep->rcec = dev;
>>>>>>>>   }
>>>>>>>>
>>>>>>>>   pci_setup_device
>>>>>>>>     ...
>>>>>>
>>>>>> I just noticed your use of pci_setup_device(). Are you suggesting
>>>>>> moving the call to pci_rcec_init() out of pci_init_capabilities() 
>>>>>> and
>>>>>> move it into pci_setup_device()?  If so, would pci_rcec_exit() 
>>>>>> still
>>>>>> remain in pci_release_capabilities()?
>>>>>>
>>>>>> I'm just wondering if it could just remain in
>>>>>> pci_init_capabilities().
>>>>>
>>>>> Yeah, I didn't mean in pci_setup_device() specifically, just 
>>>>> somewhere
>>>>> in the callchain of pci_setup_device().  But you're right, it 
>>>>> probably
>>>>> would make more sense in pci_init_capabilities(), so I *should* 
>>>>> have
>>>>> said pci_scan_single_device() to be a little less specific.
>>>>
>>>> I’ve done some experimenting with this approach, and I think 
>>>> there may be a
>>>> problem of just walking the busses during enumeration
>>>> pci_init_capabilities(). One problem is where one has an RCEC on a 
>>>> root bus:
>>>> 6a(00.4) and an RCiEP on another root bus: 6b(00.0).  They will 
>>>> never find
>>>> each other in this approach through a normal pci_bus_walk() call 
>>>> using their
>>>> respective root_bus.
>>>>
>>>>>  +-[0000:6b]-+-00.0
>>>>>  |           +-00.1
>>>>>  |           +-00.2
>>>>>  |           \-00.3
>>>>>  +-[0000:6a]-+-00.0
>>>>>  |           +-00.1
>>>>>  |           +-00.2
>>>>>  |           \-00.4
>>>
>>> Wow, is that even allowed?
>>>
>>> There's no bridge from 0000:6a to 0000:6b, so we will not scan 
>>> 0000:6b
>>> unless we find a host bridge with _CRS where 6b is the first bus
>>> number below the bridge.  I think that means this would have to be
>>> described in ACPI as two separate root bridges:
>>>
>>>   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 6a])
>>>   ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 6b])
>>
>> Otherwise, the RCEC Associated Endpoint Extended Capabilities would 
>> have to have explicitly mentioned a bridge?
>>
>>>
>>> I *guess* maybe it's allowed by the PCIe spec to have an RCEC and
>>> associated RCiEPs on separate root buses?  It seems awfully strange
>>> and not in character for PCIe, but I guess I can't point to language
>>> that prohibits it.
>>
>> Yes, it should be possible.
>>
>>>
>>>> While having a lot of slot calls per bus is unfortunate, unless 
>>>> I’m mistaken
>>>> you would have to walk every peer root_bus with your RCiEP in this 
>>>> example
>>>> until you hit on the right RCEC, unless of course you have a bitmap
>>>> associated RCEC on dev->bus.
>>>
>>> I really despise pci_find_bus(), pci_get_slot(), and related
>>> functions, but maybe they can't be avoided.
>>>
>>> I briefly hoped we could forget about connecting them at
>>> enumeration-time and just build a list of RCECs in the host bridge.
>>> Then when we handle an event for an RCiEP, we could search the list 
>>> to
>>> find the right RCEC (and potentially cache it then).  But I don't
>>> think that would work either, because in the example above, they 
>>> will
>>> be under different host bridges.  I guess we could maybe have a 
>>> global
>>> (or maybe per-domain) list of RCECs.
>>
>> Right, we could just have a list and only need to search the list 
>> when we need to handle an event.
>>
>>>
>>>> Conversely, if you are enumerating the above RCEC at 6a(00.4) and 
>>>> you
>>>> attempt to link_rcec() through calls to pci_walk_bus(), the walk 
>>>> will still
>>>> be limited to 6a and below; never encountering 6b(00.0).  So you 
>>>> would then
>>>> need an additional walk for each of the associated bus ranges, 
>>>> excluding the
>>>> same bus as the RCEC.
>>>>
>>>> pci_init_capabilities()
>>>> …
>>>> pci_init_rcec() // Cached
>>>>
>>>> if (RCEC)
>>>>  Walk the dev->bus for bitmap associated RCiEP
>>>>  Walk all associated bus ranges for RCiEP
>>>>
>>>> else if (RCiEP)
>>>>  Walk the dev->bus for bitmap associated RCEC
>>>>  Walk all peer root_bus for RCEC, confirm if own dev->bus falls 
>>>> within
>>>> discovered RCEC associated ranges
>>>>
>>>> The other problem here is temporal. I’m wondering if we may be 
>>>> trying to
>>>> find associated devices at the pci_init_capabilities() stage prior 
>>>> to them
>>>> being fully enumerated, i.e., RCEC has not been cached but we are 
>>>> searching
>>>> with a future associated RCiEP.  So one could encounter a race 
>>>> condition
>>>> where one is checking on an RCiEP whose associated RCEC has not 
>>>> been
>>>> enumerated yet.
>>>
>>> Maybe I'm misunderstanding this problem, but I think my idea would
>>> handle this: If we find the RCEC first, we cache its info and do
>>> nothing else.  When we subsequently discover an RCiEP, we walk the
>>> tree, find the RCEC, and connect them.
>>>
>>> If we find an RCiEP first, we do nothing.  When we subsequently
>>> discover an RCEC, we walk the tree, find any associated RCiEPs, and
>>> connect them.
>>
>>
>> Your approach makes sense. In retrospect, I don’t think there can 
>> be a race condition here because of the fallback from one RCEC to the 
>> other when they enumerate. You have two chances of finding the 
>> relationship.
>>
>>>
>>> The discovery can happen in different orders based on the
>>> bus/device/function numbers, but it's not really a race because
>>> enumeration is single-threaded.  But if we're talking about two
>>> separate host bridges (PNP0A03 devices), we *should* allow them to 
>>> be
>>> enumerated in parallel, even though we don't do that today.
>>>
>>> I think this RCEC association design is really kind of problematic.
>>>
>>> We don't really *need* the association until some RCiEP event (PME,
>>> error, etc) occurs, so it's reasonable to defer making the RCEC
>>> connection until then.  But it seems like things should be designed 
>>> so
>>> we're guaranteed to enumerate the RCEC before the RCiEPs.  
>>> Otherwise,
>>> we don't really know when we can enable RCiEP events.  If we 
>>> discover
>>> an RCiEP first, enable error reporting, and an error occurs before 
>>> we
>>> find the RCEC, we're in a bit of a pickle.
>>
>> So we could have a global list (RCiEP or RCEC) in which we wait to 
>> identify the associations only when we need to respond to events. Or 
>> in your original suggestion we could walk the RCEC bus ranges in 
>> addition to its root_bus.
>>
>> i.e., We bus walk an enumerating RCEC with link_rcec() callback for 
>> not only the root_bus but each bus number in the associated ranges if 
>> the extended cap exists.
>>
>> RCiEPs will simply continue to invoke their callback via find_rcec() 
>> and only check on their own bus for the encountered RCEC’s 
>> associated bitmap case.
>
> Walking the bus with an RCEC as it is probed in the portdrv_pci.c can 
> be done with both its own bus (bitmap) and with supported associated 
> bus ranges.  In that walk I’m able to find all the associated 
> endpoints via both bitmap on own bus and the bus ranges. No 
> pci_get_slot() is needed as per your original suggestion.
>
> The suggsted approach to the rcec_helper() seems to imply that we 
> either walk it again or have cached all the associated RCiEP.  When we 
> do the walk above, we are merely, finding the RCiEPs and linking them 
> to the RCEC’s structure. There is no caching done of a list of 
> RCiEPs per RCEC.
>
> i.e., in aer.c : set_downstream_devices_error_reporting() wants to 
> enable each associated RCiEP via pcie_walk_rcec().
>
> Looking into changes to the pice_walk_rcec()
>
> Sean


Okay, got it working doing the bus walk with helpers for both linking 
(enumeration case) and call backs (other such calls that need to act on 
associated RCiEPs as in above aer.c example). I’ll do more testing and 
queue up V4 for review.

Thanks,

Sean



>
>>
>>
>> Sean
>>
>>>
>>>> So let’s say one throws out RCiEP entirely and just relies upon 
>>>> RCEC to find
>>>> the associations because one knows that an encountered RCEC (in
>>>> pci_init_capabilities()) has already been cached. In that case you 
>>>> end up
>>>> with the original implementation being done with this patch 
>>>> series…
>>>>
>>>> if (RCEC)
>>>>  Walk the dev->bus for bitmap associated RCiEP
>>>>  Walk all associated bus ranges for RCiEP
>>>>
>>>> Perhaps I’ve muddled some things here but it doesn’t look like 
>>>> the twain
>>>> will meet unless I cover multiple peer root_bus and even then you 
>>>> may have
>>>> an issue because the devices don’t yet fully exist from the 
>>>> perspective of
>>>> the OS.
>>>>
>>>> Thanks,
>>>>
>>>> Sean
