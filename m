Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BB62EEFC3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 10:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbhAHJiw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 04:38:52 -0500
Received: from halon.esss.lu.se ([194.47.240.54]:53271 "EHLO halon.esss.lu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbhAHJiv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 04:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=imlWSeBZfYpyP/LwblIYXTQ4VqCJvuAOVY2xqv8c8bg=;
        b=uYBx0bZ+7uIFVtds2GhniYwPnjEAOWGuO8cTs3BEZnucVdmY1RT0zTYWXuvgpO5AzuxBFD/r3mMRy
         fZj7ikhmSW8BIfuymu70qFpov41qwv3kH+ZJiy8LNoF6h1pGyeyuwMhys+RE6fCxo/FrYcxmOz/mHJ
         X7nM05Yi3a+P2ezoqlVewiTTRstyNa4fSXDzFsRjryRTCJsKDctzcuBj5RXmSnxHVsjH9XQfPCS0lu
         aHAusaG4xSNY8Djl3STQslL4QB1exea3xX9g0EoEw0CI9gMwTMYcIK+N86up1ZNXl2gCUJEiA/BbHO
         vJxLXM9JMJ++PI9czxAKXcQCMV0a83g==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon.esss.lu.se (Halon) with ESMTPS
        id 365a4b35-5195-11eb-93c8-005056a66d10;
        Fri, 08 Jan 2021 10:38:06 +0100 (CET)
Received: from [192.168.0.9] (194.47.241.248) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 8 Jan 2021
 10:38:08 +0100
Subject: Re: [PATCHv2 0/5] aer handling fixups
To:     Keith Busch <kbusch@kernel.org>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20210104230300.1277180-1-kbusch@kernel.org>
 <bcc440b0-0ab9-c25f-e7d5-f7ce65db5019@ess.eu>
 <4242a9a9-c881-0af4-1cab-396931fee420@ess.eu>
 <20210105183302.GA1278205@dhcp-10-100-145-180.wdc.com>
 <B31F8CA9-D62B-4488-B4C1-EB31E9117203@intel.com>
 <20210107214236.GA1284006@dhcp-10-100-145-180.wdc.com>
From:   Hinko Kocevar <hinko.kocevar@ess.eu>
Message-ID: <70f2288d-2d1e-df82-d107-e977e1f50dca@ess.eu>
Date:   Fri, 8 Jan 2021 10:38:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210107214236.GA1284006@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [194.47.241.248]
X-ClientProxiedBy: it-exch16-4.esss.lu.se (10.0.42.134) To
 it-exch16-4.esss.lu.se (10.0.42.134)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/7/21 10:42 PM, Keith Busch wrote:
> On Tue, Jan 05, 2021 at 11:07:23PM +0000, Kelley, Sean V wrote:
>>> On Jan 5, 2021, at 10:33 AM, Keith Busch <kbusch@kernel.org> wrote:
>>> On Tue, Jan 05, 2021 at 04:06:53PM +0100, Hinko Kocevar wrote:
>>>> On 1/5/21 3:21 PM, Hinko Kocevar wrote:
>>>>> On 1/5/21 12:02 AM, Keith Busch wrote:
>>>>>> Changes from v1:
>>>>>>
>>>>>>     Added received Acks
>>>>>>
>>>>>>     Split the kernel print identifying the port type being reset.
>>>>>>
>>>>>>     Added a patch for the portdrv to ensure the slot_reset happens without
>>>>>>     relying on a downstream device driver..
>>>>>>
>>>>>> Keith Busch (5):
>>>>>>     PCI/ERR: Clear status of the reporting device
>>>>>>     PCI/AER: Actually get the root port
>>>>>>     PCI/ERR: Retain status from error notification
>>>>>>     PCI/AER: Specify the type of port that was reset
>>>>>>     PCI/portdrv: Report reset for frozen channel
>>>>
>>>> I removed the patch 5/5 from this patch series, and after testing again, it
>>>> makes my setup recover from the injected error; same as observed with v1
>>>> series.
>>>
>>> Thanks for the notice. Unfortunately that seems even more confusing to
>>> me right now. That patch shouldn't do anything to the devices or the
>>> driver's state; it just ensures a recovery path that was supposed to
>>> happen anyway. The stack trace says restoring the config space completed
>>> partially before getting stuck at the virtual channel capability, at
>>> which point it appears to be in an infinite loop. I'll try to look into
>>> it. The emulated devices I test with don't have the VC cap but I might
>>> have real devices that do.
>>
>> I’m not seeing the error either with V2 when testing with are-inject using RCECs and an associated RCiEP.
> 
> Thank you, yes, I'm also not seeing a problem either on my end. The
> sighting is still concerning though, so I'll keep looking. I may have to
> request Hinko to try a debug patch to help narrow down where things have
> gone wrong if that's okay.
> 

Sure. I'm willing to help out and debug this on my side as well. Let me 
know what you need me to do!
