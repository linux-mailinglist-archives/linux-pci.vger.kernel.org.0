Return-Path: <linux-pci+bounces-22651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00123A49E45
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 17:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003F0172F7A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97B3271284;
	Fri, 28 Feb 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="QvwzTtHG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5018CBFE;
	Fri, 28 Feb 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758680; cv=none; b=QWIvvSWHehW6AWUqMqs2OShXfMdZsulYjlzXwHtYLsbUrIT+NEVeuuGVuMygYFGB0h508HjbxrWpYB+UG8d+MlBd68nxeqGlnRYWhsB4n5n0Df7gId3ph2UNiMml75/o6zoJ1Ki3SSQNfwi4G4+CcCC0Ku9Xt/kexZa1r3ORNAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758680; c=relaxed/simple;
	bh=woTai9LiAziQ+4jY6qec3hdV9cbf93oJqaAR5gjFPqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVObQFeL2ZETxxxUJ9kTtBl+/3moKtr9Ura1c1VIPohqOzXLV47UQOqSO0Zr8dO8B2b0mil5o3LT7KH5hmZnKRtvSjWc23nKX7lXMXZXT9dXwl09hMOFJWMXbgLyjlMYaZwVmgze2Hn0PUrw0O/jHX1IirAutJFi3a/ey5zXyS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=QvwzTtHG; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.8.249] (unknown [107.127.24.18])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Z4ChL495wz4Rv0;
	Fri, 28 Feb 2025 11:04:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1740758677; bh=woTai9LiAziQ+4jY6qec3hdV9cbf93oJqaAR5gjFPqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QvwzTtHGOEVAexRJ1Mrk/8nLcObzquf286sNDx9DDjw7oo35hNGCIcPUJy2r+GJbd
	 uQfqDaN/ycfU1SJRk6VsFnnfRsoHOT6cZfMc3bSrMpKqC5lpyoi37pIwBSG3lAGprU
	 t116CDPstv1XE3F3SQQjGtcAaX0T6hQlenoglSnA=
Message-ID: <1f214d95-61c0-4be9-8b19-5aef76631c0e@panix.com>
Date: Fri, 28 Feb 2025 08:04:32 -0800
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
References: <21b72adf-aac6-49fa-af40-6db596c87432@panix.com>
 <20250211055722.GW3713119@black.fi.intel.com>
 <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
 <20250226084404.GM3713119@black.fi.intel.com>
 <b6eff06e-1a8c-48c3-b536-39b567015d0c@panix.com>
 <5c131927-87c1-4e21-90f8-8e3a34cd6dbf@panix.com>
 <20250228104925.GO3713119@black.fi.intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20250228104925.GO3713119@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


I'm still several hundred miles from the consistently-reproducible 
hardware for another couple of days yet, so I've been logging the other 
failures as they happen.

Don't worry about the printk()s WRT to the code; a couple of weeks ago 
I'd seen an NPE on resume in __tb_path_deactivate_hop so threw in a 
bunch of tb_port_info(port, "%s(): %d\n", __func__, __LINE__); so I 
could get an idea of where the crash was.

I'll have more info Sunday with the original kernel, one with the 
revert, and with some of Lukas' proposed(? not sure if they made it in 
there) changes from his previous E-mail.

-K

On 2/28/25 02:49, Mika Westerberg wrote:
> Hi,
> 
> On Thu, Feb 27, 2025 at 09:46:07AM -0800, Kenneth Crudup wrote:
>> So I think, the failure mode may be related in some part to DP/Tunneling,
>> too- I finally got another lockup (this time, after a hibernate, which I
>> guess is some of the same facility) but what was different about this time
>> where I couldn't reproduce the lockups (and what happens when I use my
>> CalDigit dock) was I had an external USB-C monitor connected when I resumed,
>> and when I'm home (where I sometimes forget to remove the NVMe USB4 adaptor)
>> I always have my monitor connected to the dock.
> 
> It would be good to stick with a "proven" use-case so that the steps are
> always the same. This may involve several issues in various parts of the
> kernel and we need to track them one by one. If you change the steps in the
> middle then we may end up finding completely different issues and it is not
> helping the debugging effort.
> 
> The steps at the moment would be simply this:
> 
> 1. Boot the system up, nothing connected.
> 2. Connect Thunderbolt dock and make sure UI authorizes it.
> 3. Connect Thunderbolt NVMe to the Thunderbolt dock and make sure UI authorizes it.
> 4. Verify that the devices behind PCIe tunnels are visible and functional (lspci for example)
> 5. Suspend the laptop by closing lid.
> 6. Unplug the dock (and the NVMe).
> 7. Resume the laptop by opening the lid.
> 
> Expectation: The system resumes just fine, finds the devices gone and stays functional.
> Actual result: The system does not resume properly, seems to crash and burn the screen
> 	       is black.
> 
> Please correct me if I got something wrong. This is essentially that you go
> from work to home, unplugging the dock and then resuming it at home.
> 
> The other thing is that in the pstore I see these:
> 
> thunderbolt 0000:00:0d.2: 0:5: __tb_path_deactivate_hop(): 401
> 
> but there is no such log in the mainline. If you have done some local
> changes I suggest to drop all them to make sure we are looking at the same
> source code.
> 
>> See attached dump log. I'm using the (somewhat still experimental) Xe
>> display driver, but I've seen this same lockup happen with i915.
> 
> Please also keep using tha same graphics driver.
> 
>> In any case, I've now reverted 9d573d19, and when I get back to my CalDigit
>> I can try instrumenting the code paths in the commit and see exactly where
>> we're locking up.
> 
> No need to add any changes. Just try with the revert and see if that at
> least makes the system resume properly. If it does then there could be
> other issues but then you can take full dmesg and send to us instead of
> those pstore snippets.
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


