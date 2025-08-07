Return-Path: <linux-pci+bounces-33566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06246B1DB4F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 18:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78951AA53DD
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 16:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5F226CE2C;
	Thu,  7 Aug 2025 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiWOcEz2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4460146A72;
	Thu,  7 Aug 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582862; cv=none; b=Yd5dud0yza0p830RCQ9BzclqyIRdBspdud9OVXs0oCEoKb6RD34pFwiMbJLDnEt3y4PqAtT8uNYJ/1gGTU91evAW/sU6e4qfSbE7k/vE5kRDlY0vz7hh6pmDlHI4sDmylfZs+y/ChEamOUbgIvZFoSNuguW1Sm97C1NaSoxOoL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582862; c=relaxed/simple;
	bh=pI4qr/j0qJIhw+H5T5HPBhYxSejbgWiUipjxPj+ylic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHoPWxrUhW5XFe7O/U1uTHaLvY4Is2Uw1lX+ZvWJC8EXeq4FQxmg5w9sYJ5Z9DtPZlUzEDYuUsmrQGSxXlvgez/OfyyOzaS3V/1LQerixXKNEQ9Jkao0KHYR7aLz6OaDqvJenk6A42jwvg/N/LxSUuZDwmCAxAOCYCLJEif+g+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiWOcEz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F52AC4CEF4;
	Thu,  7 Aug 2025 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754582861;
	bh=pI4qr/j0qJIhw+H5T5HPBhYxSejbgWiUipjxPj+ylic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RiWOcEz2iCkY0amr9UerXIVMk6Qhn2H0r4DDULEXl3M6Kl/sry3QjCOlAcZOo9wef
	 uBCVWsgA2SfpHzFvMJ0UaHRDTc+8XhGSOtJbOoSHWWhFh+uPEueRl3tQ6xRpABlVBY
	 fOmlvo2edwnlktWBsgzPjlc5GEnS9WAToXu2TgcsrQ1spLTYV5ix3284Ab6Vlrn4fi
	 ZOQTFd4mkZSZSXOfSiwxY+gWy+NLUae9X135/Hwc3XQmGcH9DeEIX1T8aYt1MDnwlU
	 TbH3oOMJgaX1Fj6Y3fgpaEQwOmBi3INydbE76h/zJ0MCNVOgompv0oBs3kDZv7Ijra
	 UBwnOBZ0dmZew==
Message-ID: <17ed42fe-9d8d-46da-8434-f508ec5932fa@kernel.org>
Date: Thu, 7 Aug 2025 11:07:39 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] thunderbolt: Update XDomain vendor properties
 dynamically
To: Greg KH <gregkh@linuxfoundation.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rangoju, Raju" <raju.rangoju@amd.com>, linux-usb@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 andreas.noever@gmail.com, michael.jamet@intel.com, westeri@kernel.org,
 YehezkelShB@gmail.com, bhelgaas@google.com, Sanath.S@amd.com
References: <20250722175026.1994846-1-Raju.Rangoju@amd.com>
 <20250728064743.GS2824380@black.fi.intel.com>
 <59cd3694-c6e5-42c4-a757-594b11b69525@amd.com>
 <20250806085118.GE476609@black.igk.intel.com>
 <9a757d21-a6e0-4022-b844-57c91323af5e@kernel.org>
 <20250806150024.GF476609@black.igk.intel.com>
 <2025080628-viral-untruth-4811@gregkh>
 <20250807051533.GG476609@black.igk.intel.com>
 <2025080758-supervise-craftily-9b7f@gregkh>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2025080758-supervise-craftily-9b7f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/25 11:02 AM, Greg KH wrote:
> On Thu, Aug 07, 2025 at 07:15:33AM +0200, Mika Westerberg wrote:
>> On Wed, Aug 06, 2025 at 05:58:26PM +0100, Greg KH wrote:
>>> On Wed, Aug 06, 2025 at 05:00:24PM +0200, Mika Westerberg wrote:
>>>> On Wed, Aug 06, 2025 at 09:06:30AM -0500, Mario Limonciello wrote:
>>>>> On 8/6/2025 3:51 AM, Mika Westerberg wrote:
>>>>>> On Wed, Aug 06, 2025 at 11:46:04AM +0530, Rangoju, Raju wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 7/28/2025 12:17 PM, Mika Westerberg wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On Tue, Jul 22, 2025 at 11:20:23PM +0530, Raju Rangoju wrote:
>>>>>>>>> This patch series aims to update vendor properties for XDomain
>>>>>>>>> dynamically for vendors like AMD, Intel and ASMedia.
>>>>>>>>
>>>>>>>> The XDomain properties pretty much describe "software" not the underlying
>>>>>>>> hardware so I don't understand why this is needed? We could have some USB
>>>>>>>> IF registered Linux specific ID there but I don't see why this matters at
>>>>>>>> all.
>>>>>>>
>>>>>>> Currently, it is showing up as "Intel" on AMD host controllers during
>>>>>>> inter-domain connection. I suppose an alternative is to just call it "Linux"
>>>>>>> or "Linux Connection Manager" to ensure we accurately represent the
>>>>>>> connections across different systems.
>>>>>>>
>>>>>>> I appreciate your guidance on this and suggestions you might have.
>>>>>>
>>>>>> Yeah, something like that (I prefer "Linux"). The "ID" still is 0x8086
>>>>>> though but I don't think that matters. AFAIK we have other "donated" IDs in
>>>>>> use in Linux. Let me check on our side if that's okay.
>>>>>
>>>>> Having looked through this discussion I personally like "Linux" for this
>>>>> string too.
>>>>>
>>>>> As for the vendor ID doesn't the LF have an ID assigned already of 0x1d6b?
>>>>> Would it make sense to use that?
>>>>
>>>> AFAIK that's PCI ID, right? It should be USB IF assigned ID and LF is not
>>>> here at least:
>>>>
>>>>    https://www.usb.org/members
>>>>
>>>> If it really matters we can sure register one.
>>>
>>> Linux has an official USB vendor id, we use it for when Linux is used as
>>> a USB gadget device and in a few other places.  If you want to reserve a
>>> product id from it, just let me know and I can dole it out (the list is
>>> around here somewhere...)
>>
>> Yes please :) I think this is the right thing to do.
> 
> Great, please let me know why you need it and what it will be for and
> why.  I totally can not figure that out from this thread...
> 
> thanks,
> 
> greg k-h

Actually it's a very similar reason for the gadget drivers.  When 
connected to other machines and using the USB4 networking feature (like 
a host to host communication) the Linux kernel will identify itself and 
the other side will show that to a user.

So right now it's got some hardcoded values.  This thread was prompting 
to change the strings, but it's brought about the realization that we 
should also be using a Linux specific vendor (the one uses in gadget 
devices) and then a Linux specific "device id" which you will allocate.

Hope that helps!

