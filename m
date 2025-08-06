Return-Path: <linux-pci+bounces-33463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9739EB1C74B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 16:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE5F720C5C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74AC28C851;
	Wed,  6 Aug 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvZsPBtw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A109328C2AE;
	Wed,  6 Aug 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489193; cv=none; b=HlBDiFxnjFwrUefLTbV6A5ULte2bkO8vLvLttx9oCwAP9DMBPpDEF7qkv/aRJXxgpJY5KhZnz+yMEjX/tSQe1XMJcvEhTpGkSf0ksZZu7egHWKXK7IZ2fNc8RcUtxK3jQaUHPTsYy3bVLvibRdQ2dPxH2UPo5Qc6XnMf7xXOPZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489193; c=relaxed/simple;
	bh=mO3C7XtR9liGDglicafRUdBt0hbXa85qitI1/DxFcN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APFB+lh+B3jJzqO/a7x832sZpmD9+BljGuD+JXoRqtaR5hPQ7aJFUO+t+iWKemDTuOsNg655dIWwLoUp4KEBcjfDVSOWjlzNlDsZhxVDTwmv7/FpsKhUGa3zTg+ubo+6MobI4D5DYcGeU99WNy2U58htbcGXr/D4IvRhDOmRrxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvZsPBtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6809C4CEE7;
	Wed,  6 Aug 2025 14:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754489193;
	bh=mO3C7XtR9liGDglicafRUdBt0hbXa85qitI1/DxFcN8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HvZsPBtw0ev0OSzzjPumu6RRtKc4PMdas4FoYMqQt9T12CHNB33OzQKDS3+87/C30
	 eqHmqFRtJOvuH/ArNuWiKgQ2AuNWpRzAaBj9k4G3t9V5fylH5cQLgheIYOuAei6J59
	 DsVOQa0aUTZl2+mSgHyY7NB5qIEftyQy6aT9lNGedwN7qCIlMgyxNjN7R1kn1pt+oW
	 AWbFx9uWg4q/8O2gZNT9ZaqfWF5JxcGLJH4vku1jI1K9B95JVGTzQuekCKIJNHPFF5
	 eeh1F+sBRKPAB4drpRJ8J2qGswTgQlZAGsVhP/ZhsRPaMRuZrIWKgU3YM7GqvF7SgH
	 PBu0X6v1aJNdw==
Message-ID: <9a757d21-a6e0-4022-b844-57c91323af5e@kernel.org>
Date: Wed, 6 Aug 2025 09:06:30 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] thunderbolt: Update XDomain vendor properties
 dynamically
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rangoju, Raju" <raju.rangoju@amd.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, andreas.noever@gmail.com,
 michael.jamet@intel.com, westeri@kernel.org, YehezkelShB@gmail.com,
 bhelgaas@google.com, Sanath.S@amd.com
References: <20250722175026.1994846-1-Raju.Rangoju@amd.com>
 <20250728064743.GS2824380@black.fi.intel.com>
 <59cd3694-c6e5-42c4-a757-594b11b69525@amd.com>
 <20250806085118.GE476609@black.igk.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250806085118.GE476609@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/2025 3:51 AM, Mika Westerberg wrote:
> On Wed, Aug 06, 2025 at 11:46:04AM +0530, Rangoju, Raju wrote:
>>
>>
>> On 7/28/2025 12:17 PM, Mika Westerberg wrote:
>>> Hi,
>>>
>>> On Tue, Jul 22, 2025 at 11:20:23PM +0530, Raju Rangoju wrote:
>>>> This patch series aims to update vendor properties for XDomain
>>>> dynamically for vendors like AMD, Intel and ASMedia.
>>>
>>> The XDomain properties pretty much describe "software" not the underlying
>>> hardware so I don't understand why this is needed? We could have some USB
>>> IF registered Linux specific ID there but I don't see why this matters at
>>> all.
>>
>> Currently, it is showing up as "Intel" on AMD host controllers during
>> inter-domain connection. I suppose an alternative is to just call it "Linux"
>> or "Linux Connection Manager" to ensure we accurately represent the
>> connections across different systems.
>>
>> I appreciate your guidance on this and suggestions you might have.
> 
> Yeah, something like that (I prefer "Linux"). The "ID" still is 0x8086
> though but I don't think that matters. AFAIK we have other "donated" IDs in
> use in Linux. Let me check on our side if that's okay.

Having looked through this discussion I personally like "Linux" for this 
string too.

As for the vendor ID doesn't the LF have an ID assigned already of 
0x1d6b?  Would it make sense to use that?

I was also thinking about the device ID, should we consider encoding the 
VERSION, PATCHLEVEL, and SUBLEVEL into the ID?  The reason I'm thinking 
about that is let's say there is some bug found in the CM on Linux and 
another implementation decides to work around it.  We get wind of it and 
fix the bug but in Linux but now what about the other end?  If we give 
them a hint on the version by putting it in the device ID they can 
potentially key off that to decide to tear out the workaround.

> 
>>
>>>
>>>> Raju Rangoju (3):
>>>>     thunderbolt: Dynamically populate vendor properties for XDomain
>>>>     PCI: Add PCI vendor ID for ASMedia USB4 devices
>>>>     thunderbolt: Add vendor ASMedia in update_property_block for XDomain
>>>>
>>>>    drivers/thunderbolt/nvm.c     |  2 +-
>>>>    drivers/thunderbolt/xdomain.c | 32 +++++++++++++++++++++-----------
>>>>    include/linux/pci_ids.h       |  1 +
>>>>    3 files changed, 23 insertions(+), 12 deletions(-)
>>>>
>>>> -- 
>>>> 2.34.1
> 


