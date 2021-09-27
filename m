Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A9B4196D2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 16:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhI0O67 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 10:58:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51170 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbhI0O66 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 10:58:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18REv3ri037398;
        Mon, 27 Sep 2021 09:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632754623;
        bh=85wKnDLHOP6vN4zQHKWCixUAQvtCNNTpYoXEXg6jUCs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tAhGFMYwsWHCwNenVlNn+laE8xDH9G9yqA6xGctl7LMyLRS3wXjoYP5ccibU8Sf03
         g6cMXWZAqCO5GHAqnviC8xIwYW/94M8ipoxB6XMOBu281tijiwD2+WllZQdxd79tSM
         CRwQjaW//1fE40cwAd6vXY5IqPpAP00EW2iEd980=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18REv3VD041768
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Sep 2021 09:57:03 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 27
 Sep 2021 09:57:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 27 Sep 2021 09:57:02 -0500
Received: from [10.250.233.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18REv0fb024168;
        Mon, 27 Sep 2021 09:57:00 -0500
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
 <4c6d6b57-d868-eccb-7cfb-66008af530bb@ti.com> <87r1dat6v9.wl-maz@kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <589e1bf2-3955-5249-7c0e-04c9c7b07e3f@ti.com>
Date:   Mon, 27 Sep 2021 20:26:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87r1dat6v9.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 27/09/21 8:15 pm, Marc Zyngier wrote:
> On Wed, 22 Sep 2021 02:26:09 +0100,
> Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>>>>>> -void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>>>>>> -		  void *userdata)
>>>>>> +void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>>>>>> +		    void *userdata, u32 rid, u32 mask)
>>>>>>  {
>>>>>>  	struct pci_dev *dev;
>>>>>>  	struct pci_bus *bus;
>>>>>> @@ -399,13 +401,16 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>>>>>>  		} else
>>>>>>  			next = dev->bus_list.next;
>>>>>>  
>>>>>> +		if (mask != 0xffff && ((pci_dev_id(dev) & mask) != rid))
>>>>>
>>>>> Why the check for the mask? I also wonder whether the mask should apply
>>>>> to the rid as well:
>>>>
>>>> If the mask is set for all 16bits, then there is not going to be two PCIe
>>>> devices which gets the same ITS device ID right? So no need for calculating
>>>> total number of vectors?
>>>
>>> Are we really arguing about the cost of a compare+branch vs some
>>> readability? Or is there an actual correctness issue here?
>>
>> It is for correctness. So existing pci_walk_bus() doesn't invoke cb based on
>> rid. So when we convert to __pci_walk_bus(), existing callers of pci_walk_bus()
>> might not invoke cb for some devices without the check.
>>>
>>>>>
>>>>> 		if ((pci_dev_id(dev) & mask) != (rid & mask))
>>>
>>> Because I think the above expression is a lot more readable (and
>>> likely more correct) than what you are suggesting.
>>
>> That would result in existing pci_walk_bus() behave differently from what was
>> before this patch no?
>>
>> I'm having something like this below
>> 	+#define pci_walk_bus(top, cb, userdata) \
>> 	+	 __pci_walk_bus((top), (cb), (userdata), 0x0, 0xffff)
>>
>> So if we add only "if ((pci_dev_id(dev) & mask) != (rid & mask))",
>> the callback will not be invoked for any devices (other than one
>> with rid = 0)
> 
> But that *is* the bug, isn't it? If you want to parse all the devices,
> a mask of 0 is what you need. The mask defines the bits that you want
> to match against the RID you passed as a parameter. If you don't want
> to check any bit, don't pass any!

Indeed! Thanks for explaining.

Regards,
Kishon
