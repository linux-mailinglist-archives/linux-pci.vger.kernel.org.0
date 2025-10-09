Return-Path: <linux-pci+bounces-37753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A19CBC7B80
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 09:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 104FE3500B3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 07:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899372D12E2;
	Thu,  9 Oct 2025 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="a4cS2opG"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F02D0C7F
	for <linux-pci@vger.kernel.org>; Thu,  9 Oct 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995000; cv=none; b=YiYPiyrcAxZDDKhfPHIZJuToUV5D5dQFxsKRi5JHQyD2sDm2H/NS2oCX9tHFSPtIxo4tPOEESJVc07fgd/ppXKvWbFwFqO7pRf3rZkLKUYpCP2RP22GtEO6uIbaCRo02oAomw7NN4hqLyRX85FXPKDMfGVJ1srP4uy9DKyhetLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995000; c=relaxed/simple;
	bh=AvU5y2EZwNEOasH3Rw3u9jt+KYU0oGFHC5NITljnt4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9C9LNRVzsO3WN+9QbTe2yPjYz2YXcxkgFBd9HU8hLD+mSoxFG2lP2GRYOQgVzsOMQLCB2JG81L/ZAKXcRQE542UNwR3hc9OV+YnRMOkxy3scwTm+1Y/+XtomU8KSZx4oM2zHtZo20dmD5LY5K2cmzR4OSjMNXRWz/a7P8hUzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=a4cS2opG; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <2faffdc3-f956-4071-a6a4-de9b5889096d@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1759994985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XctEP1PmvlonKK+tqQioF2QyhiyRxsTAlDxZqSe8HUM=;
	b=a4cS2opGDZ5zCgy75R1mQZX4fvqlmaFN2tnDuK/nca6axt/TP2u0V5EdwMlZZ03x9FG5DT
	zztAynu4oPCdy5aMr6AJlm2JnWnrEaS/Cg3Ciwz2qxlqs+HTdCp1Wsjw3dUPbIPccgTwoM
	GN/VSF9m13bvbmRe87lnBZFAJ3Y3PAaxpSVgEZyAkJU0g7bLXHLuSE/J5ap+NlWAWL28hk
	m2SUPnmDoYG77BNW37xH6tny1XjH4E/7PXO4JLwOwSqsAyMDGtDKra3ns4pgVC3G2k7hq9
	lHffFnw7SVmq3+51x6rhMcTkoPUUV/pg1FX0tCc/5K0loGoD5NHKM04QOrvvqg==
Date: Thu, 9 Oct 2025 04:29:34 -0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Lucas De Marchi <lucas.demarchi@intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
 <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com>
 <017ff8df-511c-4da8-b3cf-edf2cb7f1a67@packett.cool>
 <f5eb0360-55bd-723c-eca2-b0f7d8971848@linux.intel.com>
 <cd8a1d3c-1386-476b-a93d-1259b81c04e9@packett.cool>
 <8f9c9950-1612-6e2d-388a-ce69cf3aae1a@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <8f9c9950-1612-6e2d-388a-ce69cf3aae1a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/7/25 12:43 PM, Ilpo Järvinen wrote:

> On Mon, 6 Oct 2025, Val Packett wrote:
>> [..]
>>
>> I think it's that early check in pci_read_bridge_bases that avoids the setup
>> here:
>>
>>      if (pci_is_root_bus(child)) /* It's a host bus, nothing to read */
>>          return;
> If there's a PCI device as is the case in pci_read_bridge_windows()
> which inputs non-NULL pci_dev, the config space of that device can be read
> normally (or should be readable normally, AFAIK). The case where bus->self
> is NULL is different, we can't read from a non-existing PCI device, but
> it doesn't apply to pci_read_bridge_windows().
>
> I don't think reading the window is the real issue here but how the
> resource fitting algorithm corners itself by reserving space for bridge
> windows before it knows their sizes, so basically these lines from the
> earlier email:
>
> pci 0004:00:00.0: bridge window [mem 0x7c300000-0x7c3fffff]: assigned
> pci 0004:00:00.0: bridge window [mem 0x7c400000-0x7c4fffff 64bit pref]: assigned
> pci 0004:00:00.0: BAR 0 [mem 0x7c500000-0x7c500fff]: assigned
>
> ...which seem to occur before the child buses have been scanned so that
> space reserved is either hotplug reservation or due to "old_size" lower
> bounding. That non-prefetchable bridge window is too small to fit the
> child resources.
>
> Could you try passing pci=hpmemsize=0M to kernel command line if that
> helps?
>
> The other case is the "old_size" in calculate_memsize() which too can
> cause the same effect preventing sizing bridge window truly to zero when
> it's not needed (== disable it == not assign it at all at that point).
> Forcing it to zero would perhaps be worth a test (or removing the max()
> related to old_size)
>
> I've no idea why the old_size should decide anything, I hate that black
> magic but I've just not dared to remove it (it's hard to know why some
> things were made in the past, there could have been some HW issue worked
> around by such odd feature but it's so old code that there isn't any real
> information about whys anymore to find).
Well, you did dare to mess with resource assignment sequence, and it got 
very quickly and quietly merged into linux-next causing a big regression 
on hardware that's not made by your company.. so maybe it's better not 
to touch anything there at all (:
> pci=realloc on command line might help too, but I'm not sure. There seems
> to be some extra space within the root bus resource so it might work.
>
> I'm not sure what call chain is causing the assignment of those 3 bridge
> windows. One easy way to find out where it comes from would be to put
> WARN_ON(res->start == 0x7c400000); into pci_assign_resource() next to the
> line which prints "...: assigned".

OK, I've uploaded the full big chungus logs (all with the WARN_ON):

https://owo.packett.cool/lin/pcifail.reverted.dmesg
https://owo.packett.cool/lin/pcifail.noarg.dmesg
https://owo.packett.cool/lin/pcifail.hpmeme.dmesg (hpmemsize didn't help)
https://owo.packett.cool/lin/pcifail.realloc.dmesg (realloc didn't help 
either)

So without your change, the assignment first comes from pci_rescan_bus → 
pci_assign_unassigned_bus_resources *via IRQ*, and then in the probe of 
the wifi driver.

~val


