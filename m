Return-Path: <linux-pci+bounces-21499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D6EA364CA
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8C4189587D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA362686A1;
	Fri, 14 Feb 2025 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="CKZcgP7k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF152673B3;
	Fri, 14 Feb 2025 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554779; cv=none; b=A3DV9aBQzhAaiV1e/g9ueJFKrvZjNsiCaStDS5CPs0jKcfREFj0VS36dxAogQXPR+2UIb3pFoGB0UCjo9iYvCywOumk1B1V+9QTR6/OXXlMInGVGadppO3BqHl9FslRWpDU/NR/67qnxZx9zZLApaa12Zy55O7/EsQUbORIad0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554779; c=relaxed/simple;
	bh=qp94OVv6/Nsnsl6NGKU5X5aiarGvKaV4051eZnig458=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIwPO+vCtjY71OU0kU8R+RIRblKt0mCNsI/Y2ZVlC8rHywCoeyxV/6PkH4GZN1ElvAB/hF0BdtzxGlntcJ7b/Z+8k9Ly/XV9y3OHpGg73SQc/DXtRm4H1mCXIYXklD829g3F/lm0NJ65/Q507V7O2cObcy7hEY2rURdy2/Jnv8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=CKZcgP7k; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.55.17] (ip174-65-98-148.sd.sd.cox.net [174.65.98.148])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4YvfSQ5mWNz11Jm;
	Fri, 14 Feb 2025 12:39:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1739554776; bh=qp94OVv6/Nsnsl6NGKU5X5aiarGvKaV4051eZnig458=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CKZcgP7kP/VctYA/EjcbYsD62yTwXN7rRobwXIMJ3/jyMj5PepnDBNZMNEgRhjYmW
	 clhDull1OZBq6gkfh2XzZcb6iV5rB0mxtfcJUoEf/2waThIN+dbXCnMhZGc/W8CsSk
	 S0/8sn8ir0SJPDIw43qS5ifuJ+bCTJkSSP9zdAzU=
Message-ID: <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
Date: Fri, 14 Feb 2025 09:39:33 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Me <kenny@panix.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, ilpo.jarvinen@linux.intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, Jian-Hong Pan <jhp@endlessos.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
References: <20250210210502.GA15655@bhelgaas>
 <21b72adf-aac6-49fa-af40-6db596c87432@panix.com>
 <20250211055722.GW3713119@black.fi.intel.com>
 <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20250214162948.GJ3713119@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


This is excellent news that you were able to reproduce it- I'd figured 
this regression would have been caught already (as I do remember this 
working before) and was worried it may have been specific to a 
particular piece of hardware (or software setup) on my system.

I'll see what I can dig up on my end, but as I'm not expert in these 
subsystems I may not be able to diagnose anything until your return.

I also saw some DRM/connected fixes posted to Linus' master so maybe one 
of them corrects this new display-crash issue (I'm not home on my big 
monitor to be able to test yet).

-Kenny

On 2/14/25 08:29, Mika Westerberg wrote:
> Hi,
> 
> On Thu, Feb 13, 2025 at 11:19:35AM -0800, Kenneth Crudup wrote:
>>
>> On 2/13/25 05:59, Mika Westerberg wrote:
>>
>>> Hi,
>>
>> As Murphy's would have it, now my crashes are display-driver related (this
>> is Xe, but I've also seen it with i915).
>>
>> Attached here just for the heck of it, but I'll be better testing the NVMe
>> enclosure-related failures this weekend. Stay tuned!
> 
> Okay, I checked quickly and no TB related crash there but I was actually
> able to reproduce hang when I unplug the device chain during suspend. I did
> not yet have time to look into it deeper. I'm sure this has been working
> fine in the past as we tested all kinds of topologies including similar to
> this.
> 
> I will be out next week for vacation but will continue after that if the
> problem is not alraedy solved ;-)
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


