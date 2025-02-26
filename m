Return-Path: <linux-pci+bounces-22461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD30A46D2D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 22:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330B63A658E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 21:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D70258CEA;
	Wed, 26 Feb 2025 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="FcAHGQWH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1979D2586CD;
	Wed, 26 Feb 2025 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604407; cv=none; b=hvbQLKpZf5Qk8Rr8vcjTEN+3oZkM/9EiQ+N4Gl9WVYH5EqGjNe9P1LfCeRLXd+pUHQ81tegJy03upQ3bl8+Vag+u7qfJIIfj1yLXey3R0bkDdQxuadKE650McnfgfoQDN/VVsIynRsJb76IzEPeqpFoFL1xWZNWKxYXQeVyd+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604407; c=relaxed/simple;
	bh=E/dJ5Y8bdjQYw6GSaDq5ATC1vAkUsCnMT24XUYEUe58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+4rHq+3Gk8+OJsFvDgHot6aPCqW2K6gLe8YRJxAvsNJqvJDrHTPl/+QPsTIwD0JmC1SqjIiRpwBJIBEUQ+ojWwFGg7mSRxSACoVpagrV3LlTd8KMaVSUaLqOGww4AV5XC/PQ5vanzkNc76fZfWyDTci1b8WP1NvTt/FQwvwz1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=FcAHGQWH; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.36] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Z36dZ4mptz4LNC;
	Wed, 26 Feb 2025 16:13:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1740604403; bh=E/dJ5Y8bdjQYw6GSaDq5ATC1vAkUsCnMT24XUYEUe58=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FcAHGQWHKjqkf1gEBknZTkBriUmj4/KselbymUNOXdbCUMbFQpsUyIt1KAXSDRCiA
	 jRx6wWobWlxMQgrHammlMVBUD+67ka69vBG4yIUi0ivc4wLUmRU/3LE2tg9pZ4VTtS
	 dWGKXGGE1rCibfFCVUNRSYVSi6D/ZLmJxLkAjoGI=
Message-ID: <a984f2c9-43c9-4c27-b346-a8654901c7f2@panix.com>
Date: Wed, 26 Feb 2025 13:13:21 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Kenneth Crudup <kenny@panix.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, ilpo.jarvinen@linux.intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, Jian-Hong Pan <jhp@endlessos.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>, Lukas Wunner <lukas@wunner.de>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
References: <20250210210502.GA15655@bhelgaas>
 <21b72adf-aac6-49fa-af40-6db596c87432@panix.com>
 <20250211055722.GW3713119@black.fi.intel.com>
 <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
 <20250226084404.GM3713119@black.fi.intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20250226084404.GM3713119@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Trying to do a "control" test before I try out your bisected commit, and
Lukas' changes, but of course now I can't get it to fail (I'm on Linus'
master as of this morning (b5799106b4).

I'm using my portable USB4 dock (Plugable TBT4-HUB3C) this time (vs. my
CalDigit 4 dock) but the same ASMedia USB4-to-NVMe adapter as always; in
any case everything is PCIe so it shouldn't matter.

I don't normally use "tbauth" (I think that's all done for me via the
"boltctl" suite) but I grabbed and built the GIT and ran it anyway, for
good measure.

I'll keep you updated, I'll be at my CalDigit dock soon enough if I
can't get any failures this morning.

-K


On 2/26/25 00:44, Mika Westerberg wrote:
> Hi Kenneth,
> 
> On Fri, Feb 14, 2025 at 09:39:33AM -0800, Kenneth Crudup wrote:
>>
>> This is excellent news that you were able to reproduce it- I'd figured this
>> regression would have been caught already (as I do remember this working
>> before) and was worried it may have been specific to a particular piece of
>> hardware (or software setup) on my system.
>>
>> I'll see what I can dig up on my end, but as I'm not expert in these
>> subsystems I may not be able to diagnose anything until your return.
> 
> [Back now]
> 
> My git bisect ended up to this commit:
> 
>    9d573d19547b ("PCI: pciehp: Detect device replacement during system sleep")
> 
> Adding Lukas who is the expert.
> 
> My steps to reproduce on Intel Meteor Lake based reference system are:
> 
> 1. Boot the system up, nothing connected.
> 2. Once up, connect Thunderbolt 4 dock and Thunderbolt 3 NVMe in a chain:
> 
>    [Meteor Lake host] <--> [TB 4 dock] <--> [TB 3 NVMe]
> 
> 3. Authorize PCIe tunnels (whatever your distro provides, my buildroot just
>      has the debugging tools so running 'tbauth -r 301')
> 
> 4. Check that the PCIe topology matches the expected (lspci)
> 
> 5. Enter s2idle:
> 
>    # rtcwake -s 30 -mmem
> 
> 6. Once it is suspended, unplug the cable between the host and the dock.
> 
> 7. Wait for the resume to happen.
> 
> Expectation: The system wakes up fine, notices that the TB and PCIe devices
> are gone, stays responsive and usable.
> 
> Actual result: Resume never completes.
> 
> I added "no_console_suspend" to the command line and the did sysrq-w to
> get list of blocked tasks. I've attached it just in case it is needed.
> 
> If I revert the above commit the issue is gone. Now I'm not sure if this is
> exactly the same issue that you are seeing but nevertheless this is kind of
> normal use case so definitely something we should get fixed.
> 
> Lukas, if you need any more information let me know. I can reproduce this
> easily.
> 
>> I also saw some DRM/connected fixes posted to Linus' master so maybe one of
>> them corrects this new display-crash issue (I'm not home on my big monitor
>> to be able to test yet).
>>
>> -Kenny
>>
>> On 2/14/25 08:29, Mika Westerberg wrote:
>>> Hi,
>>>
>>> On Thu, Feb 13, 2025 at 11:19:35AM -0800, Kenneth Crudup wrote:
>>>>
>>>> On 2/13/25 05:59, Mika Westerberg wrote:
>>>>
>>>>> Hi,
>>>>
>>>> As Murphy's would have it, now my crashes are display-driver related (this
>>>> is Xe, but I've also seen it with i915).
>>>>
>>>> Attached here just for the heck of it, but I'll be better testing the NVMe
>>>> enclosure-related failures this weekend. Stay tuned!
>>>
>>> Okay, I checked quickly and no TB related crash there but I was actually
>>> able to reproduce hang when I unplug the device chain during suspend. I did
>>> not yet have time to look into it deeper. I'm sure this has been working
>>> fine in the past as we tested all kinds of topologies including similar to
>>> this.
>>>
>>> I will be out next week for vacation but will continue after that if the
>>> problem is not alraedy solved ;-)
>>>
>>
>> -- 
>> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County
>> CA

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


