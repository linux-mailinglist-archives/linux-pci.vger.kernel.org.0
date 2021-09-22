Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CBD413EF5
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 03:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhIVB2B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 21:28:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37632 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhIVB2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 21:28:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18M1QELt117977;
        Tue, 21 Sep 2021 20:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632273974;
        bh=/FOZxTvTqWhnvJg7vtSaRyToCaRqGzH5F9PQnDTzVPs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Wv28Mx82yvWkuPCUXABJX64Crctr5jsjPLUrk1aYrYfvQegl0c4syY2f+gJE9W5DW
         bs8mQNAJweTwZflJvHKXR+8Adu9jQ3IlR77LTyT0ihtbfpyUMLb/9gL0f1mgNzvCcp
         uieirrDaaNPylWXTa1Klwl5LTbKNlZ2U/MJpGla0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18M1QEc5114507
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Sep 2021 20:26:14 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Sep 2021 20:26:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Sep 2021 20:26:13 -0500
Received: from [10.250.233.80] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18M1QAbP074771;
        Tue, 21 Sep 2021 20:26:11 -0500
Subject: Re: [PATCH 1/3] PCI: Add support in pci_walk_bus() to invoke callback
 matching RID
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <lokeshvutla@ti.com>
References: <20210920064133.14115-1-kishon@ti.com>
 <20210920064133.14115-2-kishon@ti.com> <8735pzwrq0.wl-maz@kernel.org>
 <49b2ba0c-c69d-266c-5db6-549fab031ffd@ti.com> <87mto7unw1.wl-maz@kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4c6d6b57-d868-eccb-7cfb-66008af530bb@ti.com>
Date:   Wed, 22 Sep 2021 06:56:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87mto7unw1.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 20/09/21 11:31 pm, Marc Zyngier wrote:
> On Mon, 20 Sep 2021 15:28:52 +0100,
> Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Marc,
>>
>> On 20/09/21 2:26 pm, Marc Zyngier wrote:
>>> On Mon, 20 Sep 2021 07:41:31 +0100,
>>> Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>>
>>>> Add two arguments to pci_walk_bus() [requestorID and mask], and add
>>>> support in pci_walk_bus() to invoke the *callback* only for devices
>>>> whose RequestorID after applying *mask* matches with *requestorID*
>>>> passed as argument.
>>>>
>>>> This is done in preparation for calculating the total number of
>>>> interrupt vectors that has to be supported by a specific GIC ITS device ID,
>>>> specifically when "msi-map-mask" is populated in device tree.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  drivers/pci/bus.c   | 13 +++++++++----
>>>>  include/linux/pci.h |  7 +++++--
>>>>  2 files changed, 14 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>>>> index 3cef835b375f..e381e639ceaa 100644
>>>> --- a/drivers/pci/bus.c
>>>> +++ b/drivers/pci/bus.c
>>>> @@ -358,10 +358,12 @@ void pci_bus_add_devices(const struct pci_bus *bus)
>>>>  }
>>>>  EXPORT_SYMBOL(pci_bus_add_devices);
>>>>  
>>>> -/** pci_walk_bus - walk devices on/under bus, calling callback.
>>>> +/** __pci_walk_bus - walk devices on/under bus matching requestor ID, calling callback.
>>>>   *  @top      bus whose devices should be walked
>>>>   *  @cb       callback to be called for each device found
>>>>   *  @userdata arbitrary pointer to be passed to callback.
>>>> + *  @rid      Requestor ID that has to be matched for the callback to be invoked
>>>> + *  @mask     Mask that has to be applied to pci_dev_id(), before compating it with @rid
>>>>   *
>>>>   *  Walk the given bus, including any bridged devices
>>>>   *  on buses under this bus.  Call the provided callback
>>>> @@ -371,8 +373,8 @@ EXPORT_SYMBOL(pci_bus_add_devices);
>>>>   *  other than 0, we break out.
>>>>   *
>>>>   */
>>>> -void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>>>> -		  void *userdata)
>>>> +void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>>>> +		    void *userdata, u32 rid, u32 mask)
>>>>  {
>>>>  	struct pci_dev *dev;
>>>>  	struct pci_bus *bus;
>>>> @@ -399,13 +401,16 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>>>>  		} else
>>>>  			next = dev->bus_list.next;
>>>>  
>>>> +		if (mask != 0xffff && ((pci_dev_id(dev) & mask) != rid))
>>>
>>> Why the check for the mask? I also wonder whether the mask should apply
>>> to the rid as well:
>>
>> If the mask is set for all 16bits, then there is not going to be two PCIe
>> devices which gets the same ITS device ID right? So no need for calculating
>> total number of vectors?
> 
> Are we really arguing about the cost of a compare+branch vs some
> readability? Or is there an actual correctness issue here?

It is for correctness. So existing pci_walk_bus() doesn't invoke cb based on
rid. So when we convert to __pci_walk_bus(), existing callers of pci_walk_bus()
might not invoke cb for some devices without the check.
> 
>>>
>>> 		if ((pci_dev_id(dev) & mask) != (rid & mask))
> 
> Because I think the above expression is a lot more readable (and
> likely more correct) than what you are suggesting.

That would result in existing pci_walk_bus() behave differently from what was
before this patch no?

I'm having something like this below
	+#define pci_walk_bus(top, cb, userdata) \
	+	 __pci_walk_bus((top), (cb), (userdata), 0x0, 0xffff)

So if we add only "if ((pci_dev_id(dev) & mask) != (rid & mask))", the callback
will not be invoked for any devices (other than one with rid = 0)

> 
>>>
>>>> +			continue;
>>>> +
>>>>  		retval = cb(dev, userdata);
>>>>  		if (retval)
>>>>  			break;
>>>>  	}
>>>>  	up_read(&pci_bus_sem);
>>>>  }
>>>> -EXPORT_SYMBOL_GPL(pci_walk_bus);
>>>> +EXPORT_SYMBOL_GPL(__pci_walk_bus);
>>>>  
>>>>  struct pci_bus *pci_bus_get(struct pci_bus *bus)
>>>>  {
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index cd8aa6fce204..8500fec56e50 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -1473,14 +1473,17 @@ const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
>>>>  int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
>>>>  		    int pass);
>>>>  
>>>> -void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>>>> -		  void *userdata);
>>>> +void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>>>> +		    void *userdata, u32 rid, u32 mask);
>>>>  int pci_cfg_space_size(struct pci_dev *dev);
>>>>  unsigned char pci_bus_max_busnr(struct pci_bus *bus);
>>>>  void pci_setup_bridge(struct pci_bus *bus);
>>>>  resource_size_t pcibios_window_alignment(struct pci_bus *bus,
>>>>  					 unsigned long type);
>>>>  
>>>> +#define pci_walk_bus(top, cb, userdata) \
>>>> +	 __pci_walk_bus((top), (cb), (userdata), 0x0, 0xffff)
>>>
>>> Please keep this close to the helper it replaces. I also really
>>> dislike the use of this raw 0xffff. Don't we already have a named
>>> constant that represents the mask for a RID?
>>
>> I didn't find one on quick look but let me check.
> 
> Worse case, you could create your own.

sure.

Thanks,
Kishon
