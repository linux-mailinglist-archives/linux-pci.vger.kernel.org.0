Return-Path: <linux-pci+bounces-22586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB42A486E9
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 18:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0871653D7
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBA61C331E;
	Thu, 27 Feb 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="fFJpw9cO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3671B424D;
	Thu, 27 Feb 2025 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678379; cv=none; b=e2BDcOlvfG2Dw4tQ+ZxO0vXvxc/jFV8AHvE53nErA9AtHvM8U2ojb2mMBRJhxDry3ekA46Z6kwsftpLNsLdvJQepHsmABbQgINzVhlBoDEtMKlC5McwKu7LkhGIkiVUvC9nPYbvRYG6FT26Yc7z5jtiqfTyky8LYTxudtKLaqkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678379; c=relaxed/simple;
	bh=8MLl5qrYFbxDerzAihOT3AbGU/bvtCjbT8e+I+YqEQ0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=mnLQed9NhECpkPpKIClJ4ACkTZZ8Gt7MWi1bOBOz84Duyz68hs7L4VcOE1dbCxyBqjqnpcuGBXuoYcvBIKKOQi83CvR+KlBPAI8+uSg0BbE+lnA9LSgcb0dph9/3HTAcYW8KaKR2tYXsO9UJlU9Wuab4Q7tuCQ1MSw03Ovg4bn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=fFJpw9cO; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.8.125] (unknown [108.147.187.65])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Z3f0052tFz4LJr;
	Thu, 27 Feb 2025 12:46:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1740678370; bh=8MLl5qrYFbxDerzAihOT3AbGU/bvtCjbT8e+I+YqEQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fFJpw9cO1hTP2XtNBZ9+b5hokh3D6/r9azH06FCOnMacAuAwcfC9DU2fhXXqF9bBa
	 d68Tx1HJYl9O3hSvRzWph3vgt/G33aaPhOVluoQLJtO/fyjcLwmfcYZdi2OZWhfLVX
	 Guq+eOa8opeExkFoNFIhx0OnRA43vKNxI8ay5dpo=
Content-Type: multipart/mixed; boundary="------------fdTmZAKaf5Nk2kLWvyH8ITge"
Message-ID: <5c131927-87c1-4e21-90f8-8e3a34cd6dbf@panix.com>
Date: Thu, 27 Feb 2025 09:46:07 -0800
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
 <b6eff06e-1a8c-48c3-b536-39b567015d0c@panix.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <b6eff06e-1a8c-48c3-b536-39b567015d0c@panix.com>

This is a multi-part message in MIME format.
--------------fdTmZAKaf5Nk2kLWvyH8ITge
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


So I think, the failure mode may be related in some part to 
DP/Tunneling,  too- I finally got another lockup (this time, after a 
hibernate, which I guess is some of the same facility) but what was 
different about this time where I couldn't reproduce the lockups (and 
what happens when I use my CalDigit dock) was I had an external USB-C 
monitor connected when I resumed, and when I'm home (where I sometimes 
forget to remove the NVMe USB4 adaptor) I always have my monitor 
connected to the dock.

See attached dump log. I'm using the (somewhat still experimental) Xe 
display driver, but I've seen this same lockup happen with i915.

In any case, I've now reverted 9d573d19, and when I get back to my 
CalDigit I can try instrumenting the code paths in the commit and see 
exactly where we're locking up.

-K

On 2/26/25 13:14, Kenneth Crudup wrote:
> OK, just did a resume after suspended (for an hour, which somehow seems 
> to matter) while my CalDigit dock was attached with the ASMedia NVMe 
> adaptor at suspend, but both disconnected on resume, and I am indeed 
> locked up.
> 
> I can attached the "pstore" report if necessary.
> 
> Unfortunately I won't be able to get back to the CalDigit until Saturday 
> afternoon California time.
> 
> I'll be trying all the reverts/commits listed herein and at least check 
> for regressions in other cases, though.
> 
> -Kenny
> 
> On 2/26/25 00:44, Mika Westerberg wrote:
>> Hi Kenneth,
>>
>> On Fri, Feb 14, 2025 at 09:39:33AM -0800, Kenneth Crudup wrote:
>>>
>>> This is excellent news that you were able to reproduce it- I'd 
>>> figured this
>>> regression would have been caught already (as I do remember this working
>>> before) and was worried it may have been specific to a particular 
>>> piece of
>>> hardware (or software setup) on my system.
>>>
>>> I'll see what I can dig up on my end, but as I'm not expert in these
>>> subsystems I may not be able to diagnose anything until your return.
>>
>> [Back now]
>>
>> My git bisect ended up to this commit:
>>
>>    9d573d19547b ("PCI: pciehp: Detect device replacement during system 
>> sleep")
>>
>> Adding Lukas who is the expert.
>>
>> My steps to reproduce on Intel Meteor Lake based reference system are:
>>
>> 1. Boot the system up, nothing connected.
>> 2. Once up, connect Thunderbolt 4 dock and Thunderbolt 3 NVMe in a chain:
>>
>>    [Meteor Lake host] <--> [TB 4 dock] <--> [TB 3 NVMe]
>>
>> 3. Authorize PCIe tunnels (whatever your distro provides, my buildroot 
>> just
>>      has the debugging tools so running 'tbauth -r 301')
>>
>> 4. Check that the PCIe topology matches the expected (lspci)
>>
>> 5. Enter s2idle:
>>
>>    # rtcwake -s 30 -mmem
>>
>> 6. Once it is suspended, unplug the cable between the host and the dock.
>>
>> 7. Wait for the resume to happen.
>>
>> Expectation: The system wakes up fine, notices that the TB and PCIe 
>> devices
>> are gone, stays responsive and usable.
>>
>> Actual result: Resume never completes.
>>
>> I added "no_console_suspend" to the command line and the did sysrq-w to
>> get list of blocked tasks. I've attached it just in case it is needed.
>>
>> If I revert the above commit the issue is gone. Now I'm not sure if 
>> this is
>> exactly the same issue that you are seeing but nevertheless this is 
>> kind of
>> normal use case so definitely something we should get fixed.
>>
>> Lukas, if you need any more information let me know. I can reproduce this
>> easily.
>>
>>> I also saw some DRM/connected fixes posted to Linus' master so maybe 
>>> one of
>>> them corrects this new display-crash issue (I'm not home on my big 
>>> monitor
>>> to be able to test yet).
>>>
>>> -Kenny
>>>
>>> On 2/14/25 08:29, Mika Westerberg wrote:
>>>> Hi,
>>>>
>>>> On Thu, Feb 13, 2025 at 11:19:35AM -0800, Kenneth Crudup wrote:
>>>>>
>>>>> On 2/13/25 05:59, Mika Westerberg wrote:
>>>>>
>>>>>> Hi,
>>>>>
>>>>> As Murphy's would have it, now my crashes are display-driver 
>>>>> related (this
>>>>> is Xe, but I've also seen it with i915).
>>>>>
>>>>> Attached here just for the heck of it, but I'll be better testing 
>>>>> the NVMe
>>>>> enclosure-related failures this weekend. Stay tuned!
>>>>
>>>> Okay, I checked quickly and no TB related crash there but I was 
>>>> actually
>>>> able to reproduce hang when I unplug the device chain during 
>>>> suspend. I did
>>>> not yet have time to look into it deeper. I'm sure this has been 
>>>> working
>>>> fine in the past as we tested all kinds of topologies including 
>>>> similar to
>>>> this.
>>>>
>>>> I will be out next week for vacation but will continue after that if 
>>>> the
>>>> problem is not alraedy solved ;-)
>>>>
>>>
>>> -- 
>>> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
>>> County
>>> CA
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

--------------fdTmZAKaf5Nk2kLWvyH8ITge
Content-Type: application/x-bzip; name="pstore-202502262249.tar.bz2"
Content-Disposition: attachment; filename="pstore-202502262249.tar.bz2"
Content-Transfer-Encoding: base64

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
JDvOXdwA

--------------fdTmZAKaf5Nk2kLWvyH8ITge--

