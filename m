Return-Path: <linux-pci+bounces-27718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F32AB6C2C
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 15:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57F84A4964
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 13:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DC5278772;
	Wed, 14 May 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8rQf3eg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247521805B;
	Wed, 14 May 2025 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747228106; cv=none; b=hvOjp+mfWEyYqoifDiHcUnGSdi24oJ6BL4jowC08u073Nssvi2rMsrvOiML30YbK3lLqhybBB0/Ibc/LY4reaDI/c7wDCiQbitiMoyKNZAr2BDxEHW3UykCmzr3ikT2busCs0le2+jiDp1LLHDLH9MCzGBQ8B8n1tDbbn88zauw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747228106; c=relaxed/simple;
	bh=SVRgRL86JVF3OrrXSAO0oxvw+IbDlhp+cAEEK0Nj1hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/8cy/XrLT1FZPIMs/MarfD7dcyuA+eS6w5LKEPy8s+QHM5YZDpEdN5DAtAV6fmATLOaVDHeBErH/uq1xBJc7Sn7nGJtW09YezNeMrIobkjdbBAy2WhAKvhh7hnpn6P9HiGmjoPGPafqIf3UDd2kOwK5f8VxTrz5cSnmSS9piw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8rQf3eg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747228105; x=1778764105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SVRgRL86JVF3OrrXSAO0oxvw+IbDlhp+cAEEK0Nj1hM=;
  b=i8rQf3egMnuwMGrmzy2N5+uDjFb0zgaOvjwtV3S//IAxQ1ucQZox1kHv
   I12i3BT/gbvou07JQvTGLKNr5h+YdHqXdFKJR8HrlVFczXKvuNywYyG/K
   x/AZ6j5WueCdf1NQUQ4Fc6UKR3ut/FmJ8zhpmwpPF+58mNmaQ4gapoZ01
   8jrqetzt15DYcfxxhTb1JqxV7QTBdR4pJbRBzSuJEsAHOBJDkRHCJoLN6
   Dg/pAHgEIDYdHvBXT5zC3SC6QMX4YqYjAWKOvn3P3MEtiNOWAytgMYGmZ
   rkeaJ4YWmLWV9JsQuQeJYRGEcZ3cDZPQvd1h2ZKuHLhenpyEkq5CosAZ1
   w==;
X-CSE-ConnectionGUID: GtvaTzMpRuCtwWkFqaFRSw==
X-CSE-MsgGUID: R8qV3v+zQ1+zfHUVfeY8/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="51762049"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="51762049"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 06:08:21 -0700
X-CSE-ConnectionGUID: 8/1e31aFQXupl/9Zr6oFjw==
X-CSE-MsgGUID: VTNSiZKHROaIsr7Y6de9dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="168975723"
Received: from carterle-desk.ger.corp.intel.com (HELO [10.245.246.189]) ([10.245.246.189])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 06:08:19 -0700
Message-ID: <0e1005de-f5f8-4ad4-ad23-5fac81b24b33@linux.intel.com>
Date: Wed, 14 May 2025 16:09:30 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] ASoC/SOF/PCI/Intel: add Wildcat Lake support
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
 guennadi.liakhovetski@linux.intel.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
 <0b01a3ae-4766-490e-939d-1d16c2748644@linux.dev>
 <bfb8e9a6-92c1-4079-aec0-b1ad2b245c70@linux.intel.com>
 <7f3b2d28-38d0-482c-b79a-5aabed6b6ea8@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <7f3b2d28-38d0-482c-b79a-5aabed6b6ea8@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14/05/2025 15:47, Pierre-Louis Bossart wrote:
> On 5/13/25 08:23, Péter Ujfalusi wrote:
>>
>>
>> On 12/05/2025 15:59, Pierre-Louis Bossart wrote:
>>>
>>>> The audio IP in Wildcat Lake (WCL) is largely identical to the one in
>>>> Panther Lake, the main difference is the number of DSP cores, memory
>>>> and clocking.
>>>> It is based on the same ACE3 architecture.
>>>>
>>>> In SOF the PTL topologies can be re-used for WCL to reduce duplication
>>>> of code and topology files. 
>>>
>>> Is this really true? I thought topology files are precisely the place where a specific pipeline is assigned to a specific core. If the number of cores is lower, then a PTL topology could fail when used on a WCL DSP, no?
>>
>> Yes, that is true, however for generic (sdw, HDA) topologies this is not
>> an issue as we don't spread the modules (there is no customization per
>> platform).
>> When it comes to product topologies, they can still be named as PTL/WCL
>> if needed and have tailored core use.
>>
>> It might be that WCL will not use audio configs common with PTL, in that
>> case we still can have sof-wcl-* topologies if desired.
> 
> Right, so the topologies can be used except when they cannot :-)

Right, topologies can be used when they are usable, if a new WCL only
config pops it's head then we can add it as sof-wcl-* or so-ptl-* if it
is expected to be present in PTL variants.

>> Fwiw, in case of soundwire we are moving to a even more generic function
>> topology split, where all SDW device can us generic function fragments
>> stitched together to create a complete topology.
>> Those will have to be compatible with all platforms, so wide swing of
>> core use cannot be possible anymore.
> 
> I couldn't follow this explanation, or I am missing some context. My expectation is that as soon as someone starts inserting a 3rd party module all bets on core assignment are off, I am not sure how rules could be generic without adding restrictions on where 3rd party modules are added.

As soon as anyone inserts 3rd party modules in topologies they will
create said topology for the machine they use and either select seaid
topology for the machine or use override to load that.

You cannot really add 3rd party modules to generic topologies since
somehow you need to make sure that the 3rd party module is somehow
available at the same time.

The difference regarding to audio in PTL to WCL is about the same as ARL
to ARL-S, yet with sof-arl-* topologies this somehow was not an issue
(and tgl and adl).

-- 
Péter


