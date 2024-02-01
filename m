Return-Path: <linux-pci+bounces-2927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F04845BBA
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AB71F2C26B
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157735F489;
	Thu,  1 Feb 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Qpn2ZfQn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F168F5D46D
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801943; cv=none; b=cLv1wDFJspLcXOoaiaQi66C4xHWTXf+360onrkiTAgHNzslTu5uze0bwb+7gGly3ME2tUfgsmpn4qMEY1gqHYeAoS2oMYnUYqWR/l+clA8UNd+tBxn5z62zIEcy/eADDRLAUwD7e1CMKWHyZqsSoGv3ZyG4o1YDMdU9yA1QThDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801943; c=relaxed/simple;
	bh=twGU2IMSmPFit4IxdgN/+/p43LlEsqMhVV8rI+XwCoQ=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7bel76Hk6C+UeSL2jFQjqiI3UAYx5PotShHSMoKbUpekd5O60FYUN80U23jw7pdbIxScCUc3l3r4gAPoS90BeMJdzMC5zltGKORJmyiS5tM82HA5VR0IdQ+EwzVu2oUpaTtwH81XIwZSd3PGNhkiYlCwLq2/CADZyjbLap/KA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Qpn2ZfQn; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id CE740240028
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 16:38:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1706801929; bh=twGU2IMSmPFit4IxdgN/+/p43LlEsqMhVV8rI+XwCoQ=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type:
	 From;
	b=Qpn2ZfQnW7R9WOFam7/OB/LL+OVNqgqEe2vXjQUafzI/8ol4yj6pV2+ExYNKgKhUV
	 RELdd0mR+Ex+j+ij+UVapsD2TOupugr5Yv6iMvEqqUD1cBh+cTqs7hLmMuz0HgFAvz
	 UcF53tceHFhEk0zOLIh1G5b6WG3rPPqvRWLd5iV2MamO4H35W8qBl7/rItBvKqecun
	 I7LBwgW3HoncfFUkedElj8wNMDqgGf5QJjICVhtfCJ6Wtp9QAQBPdxHj72KNxHyfFs
	 XTWiNZl9AjZrUcxTnR4O+CvdY09fiTxXIwA8TYAeygbUo/O8g1Mq0Au6H7NoPhVJ3k
	 M7Jjq57Vru9qA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TQjk02s02z9rxD;
	Thu,  1 Feb 2024 16:38:48 +0100 (CET)
Date: Thu, 01 Feb 2024 15:38:42 +0000
From: Mateusz Nowicki <nowicki@posteo.net>
Subject: Re: [Question] Custom MMIO handler - is it possible?
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Message-Id: <ISO68S.RPAGJSCS217U3@posteo.net>
In-Reply-To: <20240131212009.GA601947@bhelgaas>
References: <981728318a564e6c3d54ca76ee37348b@posteo.net>
	<20240131212009.GA601947@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Thanks for a quick reply Bjorn!

Actually performance is not the biggest concern.
Mmiotrace has documented SMP race condition:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/trace/mmiotrace.rst#n135

Also playing correctly with page fault is quite a challenge. I'm trying 
to find a simpler/easier solution :)

Thanks for Qemu tip! I'll take a look


On Wed, Jan 31 2024 at 15:20:09 -06:00:00, Bjorn Helgaas 
<helgaas@kernel.org> wrote:
> On Wed, Jan 31, 2024 at 08:42:18PM +0000, nowicki@posteo.net wrote:
>>  Hello,
>> 
>>  I'm trying to implement a fake PCIe device and I'm looking for 
>> guidance (by
>>  fake I mean fully software device).
>> 
>>  So far I implemented:
>>  - fake PCIe bus with custom fake pci_ops.read & pci_ops.write 
>> functions
>>  - fake PCIe switch
>>  - fake PCIe endpoint
>> 
>>  Fake devices have implemented PCIe registers and are visible in 
>> user space
>>  via lspci tool.
>>  Registers can be edited via setpci tool.
>> 
>>  Now I'm looking for a way to implement BAR regions with custom 
>> memory
>>  handlers. Is it even possible?
>>  Basically I'd like to capture each MemoryWrite & MemoryRead 
>> targeted for
>>  PCIe endpoint's BAR region and emulate NVMe registers.
>> 
>>  I'm in dead-end right now and I'm seeing only two options:
>>  - generate page faults on every access to fake BAR region and 
>> execute fake
>>  PCIe endpoint's callbacks - similar/the same as mmiotrace
>>  - periodically scan fake BAR region for any changes
>> 
>>  Both solutions have drawbacks.
>>  Is there other way to implement fake BAR region?
> 
> Sounds kind of cool and potentially useful to build kernel test tools.
> 
> Is the page fault on access option a problem because you want better
> performance?  I assume you really *want* to know about every write and
> possibly even every read, so a page fault seems like the way to do
> that.
> 
> Maybe qemu would have some ideas?  I assume it implements some similar
> things.
> 
> Bjorn



