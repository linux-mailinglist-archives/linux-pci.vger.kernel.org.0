Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E355EB2CA
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 23:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiIZVFW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 17:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiIZVFT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 17:05:19 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D123D5F83
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 14:05:16 -0700 (PDT)
Message-ID: <883588c2-0b02-49fb-0074-7c2a47ad4476@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664226314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nrf3mPw7zBN5qGOq+z6gbepqux75dxPH81yUPJxSMRU=;
        b=v5U0pyaXlMZz+mvd3TTKfSja5c31Dp8T+OScD/dXJmuniwlZCGpwiIWJ0KF5jN/2LfushV
        aLYmZtn+svUWdL6SoJ17F86OFhV4W9/4iOFQxyN5WDYfdtn6vnsFLqQGhosAvxRT2ExlX/
        TD9DGHAPM3r75QhFbJ/yoTIZESRQotE=
Date:   Mon, 26 Sep 2022 15:05:03 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v3] PCI: pciehp: Add quirk to handle spurious DLLSC on a
 x4x4 SSD
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        James Puthukattukaran <james.puthukattukaran@oracle.com>
References: <20210830155628.130054-1-jonathan.derrick@linux.dev>
 <20210912084547.GA26678@wunner.de>
 <91950e7a-68e9-9d35-ff0b-a2109de7a853@intel.com>
 <20210914144621.GA30031@wunner.de>
 <3f7773e0-1c20-f96f-097f-f545a905151d@intel.com>
 <446a21e2-aea2-773f-ca88-b6676b54b292@linux.dev>
 <20220924073208.GA26243@wunner.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220924073208.GA26243@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/24/2022 1:32 AM, Lukas Wunner wrote:
> On Fri, Jul 08, 2022 at 10:35:15AM -0600, Jonathan Derrick wrote:
>> On 9/20/2021 11:18 AM, Jon Derrick wrote:
>>> On 9/14/21 9:46 AM, Lukas Wunner wrote:
>>>> On Mon, Sep 13, 2021 at 04:07:22PM -0500, Jon Derrick wrote:
>>>>> On 9/12/21 3:45 AM, Lukas Wunner wrote:
>>>>>> On Mon, Aug 30, 2021 at 09:56:28AM -0600, Jon Derrick wrote:
>>>>>>> When an Intel P5608 SSD is bifurcated into x4x4 mode, and the upstream
>>>>>>> ports both support hotplugging on each respective x4 device, a slot
>>>>>>> management system for the SSD requires both x4 slots to have power
>>>>>>> removed via sysfs (echo 0 > slot/N/power), from the OS before it can
>>>>>>> safely turn-off physical power for the whole x8 device. The implications
>>>>>>> are that slot status will display powered off and link inactive statuses
>>>>>>> for the x4 devices where the devices are actually powered until both
>>>>>>> ports have powered off.
>>>>>>
>>>>>> Just to get a better understanding, does the P5608 have an internal
>>>>>> PCIe switch with hotplug capability on the Downstream Ports or
>>>>>> does it plug into two separate PCIe slots?  I recall previous patches
>>>>>> mentioned a CEM interposer?  (An lspci listing might be helpful.)
>>>>>
>>>>> It looks like 2 NVMe endpoints plugged into two different root ports, ex,
>>>>> 80:00.0 Root port to [81-86]
>>>>> 80:01.0 Root port to [87-8b]
>>>>> 81:00.0 NVMe
>>>>> 87:00.0 NVMe
>>>>>
>>>>> The x8 is bifurcated to x4x4. Physically they share the same slot
>>>>> power/clock/reset but are logically separate per root port.
>>>>
>>>> So are these two P5608 drives attached to a single Root Port with an
>>>> interposer in-between?
>>>>
>>>> I assume the Root Port needs to know that it's bifurcated and has to
>>>> appear as two slots on the bus.  Is this configured with a BIOS setting?
>>>>
>>>> If these assumptions are true, the quirk isn't really specific to
>>>> the P5608 but should rather apply to the bifurcation-capable Root Port
>>>> and the quirk should set the flag if the Root Port is indeed configured
>>>> for bifurcation.
>>> It's a function of the slot + card combination, but we can't distinguish this
>>> slot's special power handling behavior from the vanilla behavior. It's modified
>>> to handle power on the logically bifurcated, singular physical device.
>>
>> Hi Bjorn, Lukas,
>>
>> I need to resubmit this.
>>
>> Besides the 'pdev->shared_pcc_and_link_slot = false', addition mentioned
>> above, is there anything else that should be changed or any reason this
>> wouldn't be accepted?
> 
> Another report has cropped up of spurious DLLSC events:
> https://bugzilla.kernel.org/show_bug.cgi?id=216511
> 
> That other case differs from yours in that a spurious DLLSC event
> is seen on plugging *in* a card, whereas in your case the event
> seems to occur on *removing* a card.  In both cases, the spurious
> event is seen on the hotplug port's sibling.
> 
> I'm starting to think that we should probably disable DLLSC events
> entirely if they're known to be unreliable.  The hotplug port
> solely relies on PDC events then.  Otherwise we'd have to clutter
> the event handling with all sorts of special cases.  The code would
> become fairly difficult to follow.
I'm not sure we can do that either. Think of a non-logical interposer.
PDC will be static but DLLSC may be the only hotplug status received.


> 
> I've attached an experimental patch to the bug report which disables
> DLLSC events on a hotplug port if a P5608 SSD is plugged into it:
> https://bugzilla.kernel.org/attachment.cgi?id=301845
> 
> Would this approach work for you?
It looks correct to me


> 
> One other question:  What if the SSD is not bifurcated (i.e. x8
> instead of x4x4), don't we need avoid applying the quirk in that case?
> Your patch doesn't seem to do that.  Can we recognize somehow whether
> the card is bifurcated or not?  Is it sufficient to just look at the
> Maximum Link Width in the Link Capabilities Register?  Does the SSD
> report x4 there if it's bifurcate
Good question. Unique to the subsystem device id?

> 
> Thanks,
> 
> Lukas
