Return-Path: <linux-pci+bounces-22721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44360A4B2FF
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 17:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06B63B2D44
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E21D1EA7D7;
	Sun,  2 Mar 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="qok9IWfG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6EE1EA7D2;
	Sun,  2 Mar 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932037; cv=none; b=qLe5EzZl8LNMualteFE4g84cGeZLHYZgbJq28vQ5SAuQDclnD51Q3jG8O/d6SRnwfuIg0ydj3MP9v2XLFP6cPLFSvmyUHM5oLbv5b54fOW9QQ7xb3jB8ge8p7aFruxC8I9Dcn2CcOMmrfayZ6+Nt3hamTVb9qY7r3bQrdtzNOCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932037; c=relaxed/simple;
	bh=R44zS5UstGW/mbwuvd3eia/RIOCoDdVVzI52z01wnuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vg0PWBXVnVvQNPy2uCBAB32iARD5bPX/cVCV6K82WQ081J26Dn2p50VVmuWAq+Obby+mokUX/R1h2n1x4Fp936NukHVVlIPL8d2iviNqD4pHx0IDNJaUJXvrzm0I0zGazAWHj5IY4Yo6H8sHd/ALGtSghXdeHdXaSNie3bzf46U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=qok9IWfG; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.126.122] (ip72-219-82-239.oc.oc.cox.net [72.219.82.239])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Z5Rp76ZvVz49rv;
	Sun,  2 Mar 2025 11:13:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1740932033; bh=R44zS5UstGW/mbwuvd3eia/RIOCoDdVVzI52z01wnuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=qok9IWfGHF/F7P/onSSsmeJCBeB78J/opqxwNdyzCWIhiV9yQzAky+sb41aREomKx
	 w7JI6ATSTJ8p2nve7jFMPmNSq9FcS2R0RIYATEi0mPb9d+C0lAqUQ/dXGW+ObaUI7B
	 kRofCB2aPbCOaFw/cqjt/JqcRukI/TzG6ItPb1tQ=
Message-ID: <e5badaa8-20e2-4160-be20-75e174d241bc@panix.com>
Date: Sun, 2 Mar 2025 08:13:51 -0800
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
 <1f214d95-61c0-4be9-8b19-5aef76631c0e@panix.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <1f214d95-61c0-4be9-8b19-5aef76631c0e@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/28/25 08:04, Kenneth Crudup wrote:

> Don't worry about the printk()s WRT to the code; a couple of weeks ago 
> I'd seen an NPE on resume in __tb_path_deactivate_hop so threw in a 
> bunch of tb_port_info(port, "%s(): %d\n", __func__, __LINE__); so I 
> could get an idea of where the crash was.

I've started a separate E-mail about this, but I'd determined those 
crashes were due to d6d458d42e1 ("Handle DisplayPort tunnel activation 
asynchronously").

Since reverting 9d573d1954 and d6d458d42e1 I've been testing several 
resume scenarios (NVMe connected/disconnected and/or external 
DP-tunneled monitor connected/disconnected and have yet to have a resume 
or hibernate failure over several cycles.

Now, how do I help you guys go about fixing these commits?

-K

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


