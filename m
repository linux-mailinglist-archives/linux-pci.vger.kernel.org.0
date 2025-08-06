Return-Path: <linux-pci+bounces-33465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 569C4B1C838
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 17:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C7B18C42E1
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 15:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7F528FFC8;
	Wed,  6 Aug 2025 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snKiYyUs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3E28FABC;
	Wed,  6 Aug 2025 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492714; cv=none; b=QajUAz1tZr0U4zQTu2LLcShMj8TZTGRTAzsvH8DRZPDFSMhq3VXNgLoxPLdVjjlTBuqZHbVw2JNpvPRTGNTzZzgKauQfPAp5pWUeQCX9f2NkMfR5K6+SWLLdrd/kQ9AOLCxGEPPr5U/u3vegPMEV211mST3WmjEvi+wPetefJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492714; c=relaxed/simple;
	bh=1ZKtCrUhtec/C92tnjeQ8tbmcV2y28wVwt/ue7CIIMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yjk1U2AOJGHFz8yShFMpJKmbTxaKYUB8HtMWjsTBoYUNeK0dRhMwnUQwLEx3RAUdA8iM/l8WygGug6P9KEm3UdKhiKJJDLwjhr/iYriRbYr3paZZ2NIYI76/g+cS/R8ggSQdfMQP8HbTdtGHAp/8ausbm/qmCI67ug0oWUTE4A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snKiYyUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49675C4CEEB;
	Wed,  6 Aug 2025 15:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754492713;
	bh=1ZKtCrUhtec/C92tnjeQ8tbmcV2y28wVwt/ue7CIIMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=snKiYyUs4cA8LFJGxboFiFjmpeexsx+j9FKhn37vMIzoi7z6mrCBRQSEpWcGYfOJ9
	 bySWDCtkL0fk153JygBXjGfs1iTpXco/xGwKDkcj+h6DNoJVGue8DoDl9M5nf45Oc4
	 FyczEtjKkc/6M1669MGwwAGb8iKK2gWJsAB/hqrfMlyNfAbYgtM/OBMxToyGa7xfY5
	 cxurDhuNgDkJKQB8BSySArCoKNUtBQE5zkD3q1K+NKgjZbkKrZDiZfv/wp4CP43OTU
	 hW2npn3RY3KOQ2UmvOBmGsf+5hnzdp+cpdDaFj6FuLBYx/6T29qd3PJcuJuMzeyanI
	 8sGpeC0e/0BbA==
Message-ID: <d079c31f-4785-4a41-8c88-cc56dceee7aa@kernel.org>
Date: Wed, 6 Aug 2025 10:05:11 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] thunderbolt: Update XDomain vendor properties
 dynamically
To: Mika Westerberg <mika.westerberg@linux.intel.com>
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250806150024.GF476609@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/2025 10:00 AM, Mika Westerberg wrote:
> On Wed, Aug 06, 2025 at 09:06:30AM -0500, Mario Limonciello wrote:
>> On 8/6/2025 3:51 AM, Mika Westerberg wrote:
>>> On Wed, Aug 06, 2025 at 11:46:04AM +0530, Rangoju, Raju wrote:
>>>>
>>>>
>>>> On 7/28/2025 12:17 PM, Mika Westerberg wrote:
>>>>> Hi,
>>>>>
>>>>> On Tue, Jul 22, 2025 at 11:20:23PM +0530, Raju Rangoju wrote:
>>>>>> This patch series aims to update vendor properties for XDomain
>>>>>> dynamically for vendors like AMD, Intel and ASMedia.
>>>>>
>>>>> The XDomain properties pretty much describe "software" not the underlying
>>>>> hardware so I don't understand why this is needed? We could have some USB
>>>>> IF registered Linux specific ID there but I don't see why this matters at
>>>>> all.
>>>>
>>>> Currently, it is showing up as "Intel" on AMD host controllers during
>>>> inter-domain connection. I suppose an alternative is to just call it "Linux"
>>>> or "Linux Connection Manager" to ensure we accurately represent the
>>>> connections across different systems.
>>>>
>>>> I appreciate your guidance on this and suggestions you might have.
>>>
>>> Yeah, something like that (I prefer "Linux"). The "ID" still is 0x8086
>>> though but I don't think that matters. AFAIK we have other "donated" IDs in
>>> use in Linux. Let me check on our side if that's okay.
>>
>> Having looked through this discussion I personally like "Linux" for this
>> string too.
>>
>> As for the vendor ID doesn't the LF have an ID assigned already of 0x1d6b?
>> Would it make sense to use that?
> 
> AFAIK that's PCI ID, right? It should be USB IF assigned ID and LF is not
> here at least:
> 
>    https://www.usb.org/members
> 
> If it really matters we can sure register one.

I see that it's used by drivers/usb/gadget/legacy.c for a few USB 
devices too.

So it's "already in the wild".

> 
>> I was also thinking about the device ID, should we consider encoding the
>> VERSION, PATCHLEVEL, and SUBLEVEL into the ID?  The reason I'm thinking
>> about that is let's say there is some bug found in the CM on Linux and
>> another implementation decides to work around it.  We get wind of it and fix
>> the bug but in Linux but now what about the other end?  If we give them a
>> hint on the version by putting it in the device ID they can potentially key
>> off that to decide to tear out the workaround.
> 
> I'm not sure that's a good idea. Then we expose also all the known
> vulnerabilities.

Yeah I see your point.  This wasn't a strong feeling on my side, leaving 
this as is is fine.

