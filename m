Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191D42F1577
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jan 2021 14:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbhAKNk1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 08:40:27 -0500
Received: from halon.esss.lu.se ([194.47.240.54]:30734 "EHLO halon.esss.lu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733179AbhAKNkG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Jan 2021 08:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:references:cc:to:from:subject:from;
        bh=dZjFSWABh8F8X29IfKkOx6bQaNKM+BOPgw/EPqQPjqo=;
        b=G/lFPb6BH9iEE9TIDZ6s7N2wzEMrk2Uy9pKlUH8qb0rx8SuEJMTCw7FrDaWgMjPJ8zsb3ILZyi2jU
         8THirirWdEhc1V7ES8fb7hoJB3SSnDkJbNLte5gBkYJqmBGoUtSAv9ma00qvQubcM6ikHNYtv8BNWm
         rWwifgC5eZVmRWsmXn6X/k37uDvU6NYBKlyd6MZsXSIbO5C/azoa7ZskTzsbCkT6d2hvVA12Og5mMT
         LSAHGaCH2BxBfOku1t/rS+sP7AgzYaZYJpLWLO4t3cjalIryizwvQpVu+y+NgcukvIzXokeIwcUJ4J
         nhWYa35t8tLwSg2nmnnhP01DVW3VB6w==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon.esss.lu.se (Halon) with ESMTPS
        id 67aee7ca-5412-11eb-93c8-005056a66d10;
        Mon, 11 Jan 2021 14:39:19 +0100 (CET)
Received: from [192.168.0.6] (194.47.241.248) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 11 Jan
 2021 14:39:20 +0100
Subject: Re: [PATCHv2 0/5] aer handling fixups
From:   Hinko Kocevar <hinko.kocevar@ess.eu>
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
 <70f2288d-2d1e-df82-d107-e977e1f50dca@ess.eu>
Message-ID: <c3117c51-144f-ae59-ad68-bdc5532d12cb@ess.eu>
Date:   Mon, 11 Jan 2021 14:39:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <70f2288d-2d1e-df82-d107-e977e1f50dca@ess.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [194.47.241.248]
X-ClientProxiedBy: it-exch16-3.esss.lu.se (10.0.42.133) To
 it-exch16-4.esss.lu.se (10.0.42.134)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/8/21 10:38 AM, Hinko Kocevar wrote:
> 
> 
> On 1/7/21 10:42 PM, Keith Busch wrote:
>> On Tue, Jan 05, 2021 at 11:07:23PM +0000, Kelley, Sean V wrote:
>>>> On Jan 5, 2021, at 10:33 AM, Keith Busch <kbusch@kernel.org> wrote:
>>>> On Tue, Jan 05, 2021 at 04:06:53PM +0100, Hinko Kocevar wrote:
>>>>> On 1/5/21 3:21 PM, Hinko Kocevar wrote:
>>>>>> On 1/5/21 12:02 AM, Keith Busch wrote:
>>>>>>> Changes from v1:
>>>>>>>
>>>>>>>     Added received Acks
>>>>>>>
>>>>>>>     Split the kernel print identifying the port type being reset.
>>>>>>>
>>>>>>>     Added a patch for the portdrv to ensure the slot_reset 
>>>>>>> happens without
>>>>>>>     relying on a downstream device driver..
>>>>>>>
>>>>>>> Keith Busch (5):
>>>>>>>     PCI/ERR: Clear status of the reporting device
>>>>>>>     PCI/AER: Actually get the root port
>>>>>>>     PCI/ERR: Retain status from error notification
>>>>>>>     PCI/AER: Specify the type of port that was reset
>>>>>>>     PCI/portdrv: Report reset for frozen channel
>>>>>
>>>>> I removed the patch 5/5 from this patch series, and after testing 
>>>>> again, it
>>>>> makes my setup recover from the injected error; same as observed 
>>>>> with v1
>>>>> series.
>>>>
>>>> Thanks for the notice. Unfortunately that seems even more confusing to
>>>> me right now. That patch shouldn't do anything to the devices or the
>>>> driver's state; it just ensures a recovery path that was supposed to
>>>> happen anyway. The stack trace says restoring the config space 
>>>> completed
>>>> partially before getting stuck at the virtual channel capability, at
>>>> which point it appears to be in an infinite loop. I'll try to look into
>>>> it. The emulated devices I test with don't have the VC cap but I might
>>>> have real devices that do.
>>>
>>> I’m not seeing the error either with V2 when testing with are-inject 
>>> using RCECs and an associated RCiEP.
>>
>> Thank you, yes, I'm also not seeing a problem either on my end. The
>> sighting is still concerning though, so I'll keep looking. I may have to
>> request Hinko to try a debug patch to help narrow down where things have
>> gone wrong if that's okay.
>>
> 
> Sure. I'm willing to help out and debug this on my side as well. Let me 
> know what you need me to do!

Testing this patch a bit more (without the 5/5) resulted in the same CPU 
lockup:

watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [irq/122-aerdrv:128]

as I initially reported with the 5/5 of this patch included.

It seems more infrequent, though. For example, after reboot this is not 
observed and the recovery process is successful, whereas when 5/5 is 
also used every recovery resulted in CPU lockup.
