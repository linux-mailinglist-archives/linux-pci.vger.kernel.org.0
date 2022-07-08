Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A42756C0DF
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 20:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbiGHQf1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 12:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbiGHQf0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 12:35:26 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E3615A3D
        for <linux-pci@vger.kernel.org>; Fri,  8 Jul 2022 09:35:25 -0700 (PDT)
Message-ID: <446a21e2-aea2-773f-ca88-b6676b54b292@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657298123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ToLKP5ls4H1HTdAz2L7HMvtccVzdbCvbRrQ0HnkcBoM=;
        b=YW95cIrG31EzLUymSr7gw0UsAyRnqP8UX4X3UkhYMQ9ha2DyDVjs9GNYpyPXsfqe/Iw7ep
        KIagSSiM9WTnP8RVPJa46TWu8MCm2jSoTlK0ahjJc6zbqNs2+cUPvqPCkco2pbD6QP8ZsF
        F5FU6zt+5rWkbC8t3RJPsH7ndbGU1ts=
Date:   Fri, 8 Jul 2022 10:35:15 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v3] PCI: pciehp: Add quirk to handle spurious DLLSC on a
 x4x4 SSD
Content-Language: en-US
To:     Jon Derrick <jonathan.derrick@intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        James Puthukattukaran <james.puthukattukaran@oracle.com>
References: <20210830155628.130054-1-jonathan.derrick@linux.dev>
 <20210912084547.GA26678@wunner.de>
 <91950e7a-68e9-9d35-ff0b-a2109de7a853@intel.com>
 <20210914144621.GA30031@wunner.de>
 <3f7773e0-1c20-f96f-097f-f545a905151d@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <3f7773e0-1c20-f96f-097f-f545a905151d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/20/2021 11:18 AM, Jon Derrick wrote:
> 
> 
> On 9/14/21 9:46 AM, Lukas Wunner wrote:
>> On Mon, Sep 13, 2021 at 04:07:22PM -0500, Jon Derrick wrote:
>>> On 9/12/21 3:45 AM, Lukas Wunner wrote:
>>>> On Mon, Aug 30, 2021 at 09:56:28AM -0600, Jon Derrick wrote:
>>>>> When an Intel P5608 SSD is bifurcated into x4x4 mode, and the upstream
>>>>> ports both support hotplugging on each respective x4 device, a slot
>>>>> management system for the SSD requires both x4 slots to have power
>>>>> removed via sysfs (echo 0 > slot/N/power), from the OS before it can
>>>>> safely turn-off physical power for the whole x8 device. The implications
>>>>> are that slot status will display powered off and link inactive statuses
>>>>> for the x4 devices where the devices are actually powered until both
>>>>> ports have powered off.
>>>>
>>>> Just to get a better understanding, does the P5608 have an internal
>>>> PCIe switch with hotplug capability on the Downstream Ports or
>>>> does it plug into two separate PCIe slots?  I recall previous patches
>>>> mentioned a CEM interposer?  (An lspci listing might be helpful.)
>>>
>>> It looks like 2 NVMe endpoints plugged into two different root ports, ex,
>>> 80:00.0 Root port to [81-86]
>>> 80:01.0 Root port to [87-8b]
>>> 81:00.0 NVMe
>>> 87:00.0 NVMe
>>>
>>> The x8 is bifurcated to x4x4. Physically they share the same slot
>>> power/clock/reset but are logically separate per root port.
>>
>> So are these two P5608 drives attached to a single Root Port with an
>> interposer in-between?
>>
>> I assume the Root Port needs to know that it's bifurcated and has to
>> appear as two slots on the bus.  Is this configured with a BIOS setting?
>>
>> If these assumptions are true, the quirk isn't really specific to
>> the P5608 but should rather apply to the bifurcation-capable Root Port
>> and the quirk should set the flag if the Root Port is indeed configured
>> for bifurcation.
> It's a function of the slot + card combination, but we can't distinguish this
> slot's special power handling behavior from the vanilla behavior. It's modified
> to handle power on the logically bifurcated, singular physical device.
> 
> 
>>
>>
>>>>> @@ -265,6 +266,12 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>>>>  		cancel_delayed_work(&ctrl->button_work);
>>>>>  		fallthrough;
>>>>>  	case OFF_STATE:
>>>>> +		if (pdev->shared_pcc_and_link_slot &&
>>>>> +		    (events & PCI_EXP_SLTSTA_DLLSC) && !link_active) {
>>>>> +			mutex_unlock(&ctrl->state_lock);
>>>>> +			break;
>>>>> +		}
>>>>> +
>>>>
>>>> I think you also need to add...
>>>>
>>>> 			pdev->shared_pcc_and_link_slot = false;
>>>>
>>>> ... here to reset the shared_pcc_and_link_slot attribute in case the
>>>> next card plugged into the slot doesn't have the quirk.
>>>>
>>>> (This can't be done in pciehp_unconfigure_device() because the attribute
>>>> is queried *after* the slot has been brought down.)
>>>
>>> Agreed. I'll find a good spot for it.
>>
>> Adding it in the if-clause above should work.  The if-clause is only
>> entered when the sibling card has had its power removed, and this
>> only happens once.  When power is reinstated via sysfs, the device
>> in the slot is reenumerated and pdev->shared_pcc_and_link_slot is
>> set to true again if there's a quirked device in the slot.
>>
>> Thanks,
>>
>> Lukas
>>
> 

Hi Bjorn, Lukas,

I need to resubmit this.

Besides the 'pdev->shared_pcc_and_link_slot = false', addition mentioned
above, is there anything else that should be changed or any reason this
wouldn't be accepted?
