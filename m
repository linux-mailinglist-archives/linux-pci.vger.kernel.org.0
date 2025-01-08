Return-Path: <linux-pci+bounces-19544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B2FA05E16
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 15:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8601631FF
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4203C537E9;
	Wed,  8 Jan 2025 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EDZDoCq0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o/ZnfF6O"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2FD146A69;
	Wed,  8 Jan 2025 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345427; cv=none; b=gHopF3Brp+9xptucPJZjY+cHQ8HfSOB+hQeiRSspZml8I72JSdLRdOAqUKgwsGx/WrQ88VN/s6jatpJHLilSRO1E+RRGnFfFB6gbnjnJ35CSfLBeT0ztZPOJb3dO+qB44BnVJa8xuv4dKa+6XkNDBUXdv2+26q2PIkDo5XIeqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345427; c=relaxed/simple;
	bh=oijcgLIiiWsCQhRKS8twa9jMiuiUqIdfEtpC/NPqAUI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lDY9sOUOCFovDnpoMZ03Wahz39jXa9UIs+DVGfUAQ8unu7wdqRvoSGOnmrdB0ANgkPfNDJDp7BPYnFIZmFD5o1V6pq4CmDLgpBtsAGZ+9vnpdY5qQrBpap1fFKhhs/uwveWsG4PffQGtTiKEkUH35/eVkvV/6Dejjq/4LqCiF0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EDZDoCq0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o/ZnfF6O; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3D47425401A6;
	Wed,  8 Jan 2025 09:10:24 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 08 Jan 2025 09:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736345424;
	 x=1736431824; bh=61T53I/w82LedGxId5hNBpxLhQ/4ttAAbF5gqByYRqo=; b=
	EDZDoCq0ewE808wXeH44GI6ddncaBfSnymsuq5kECFP6Fbu5Sw6gVUl4sUJeKaFZ
	Yr+uAI9O5L6RJDF1WZuofdi0eRGaawWmglqO+dzmna8MocX2K7zGnPuD/+z4Ahu1
	0wcj7CXn29BZLIZk+hns5Ndr4CA/IzjcKFHMXu21v6nD29FdhWlIZPLo43nMoUKk
	J7j52twIkCu8eQUlCidDj1yMLm0X5VyDujOORtiUYrOFTcBZ8C9ZqmnSJroscVCe
	dVwJ36VMFoOdMSdDIlphJZTtn3ga5UVtSae3J/g8Lk/JWeiL3f6p0k95DRXNXgM9
	RGigjsCPaRFeYjkb6dcN9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736345424; x=
	1736431824; bh=61T53I/w82LedGxId5hNBpxLhQ/4ttAAbF5gqByYRqo=; b=o
	/ZnfF6OxnB1IUPWe6zl+rVUMw/MDD5uRfOIpwgC9REGUdZcqrX9exZzX9xUhTHel
	m8YtszHtDY646H+R3mKa4qvL45hSt1gpNdRRIt4yfFLz31D4itybbBvjEVCajt+X
	bIB8A3NE8xH8YCgpzF7xYls0mtOyFstUkEtOlVxQPcf5KjOhB7ape06mSvJeM7oI
	smfDpH61nnaX//lAn6+y8S462OQpKSEWQjCCU69Gahrk/NgiEGmUwXQWuhIl6HnJ
	VsDfLTkVcNN6wseV6tjxuRRMnQ21az2hnTqs/xHGdbWRpnBxTm/ACT7TEOcc199Q
	UK8nHn4iSDYFK9j9I/4Sg==
X-ME-Sender: <xms:T4d-Z98AUpb5MGew5Wt5wVPOFaYFLa2h48ecvv4zPLH3VBmaqaBNWw>
    <xme:T4d-ZxvVPCV8F8aV8U6NRpCzqI996Z6OudFF4S7MYy9OYgdBY0GE09OKbI4sijzrn
    Wa8xxvvPFYX6UiTxFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepudekvdehheduudejudehleesudeife
    drtghomhdprhgtphhtthhopehrohgtkhhsfigrnhhgjeesghhmrghilhdrtghomhdprhgt
    phhtthhopegtrghsshgvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhishhhoh
    hnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghnihhvrghnnhgrnhdrshgrughh
    rghsihhvrghmsehlihhnrghrohdrohhrghdprhgtphhtthhopehkfieslhhinhhugidrtg
    homhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:T4d-Z7BWoVgvbssL1YsYvDKU7jMKHGti5G18X7QXHmAYJsKEwwYZgw>
    <xmx:T4d-Zxd1t3_8-veplpx2MTGPc4BRowevGAYjdix_bB2us2tn601Ozw>
    <xmx:T4d-ZyNJx1PDUglAEriFbs1EBCB3aUwGIMOH969J2lkGzsXEVdRRuA>
    <xmx:T4d-Zzkyuv5aAlrqZ_0QyaFeSA1qGvARuEfk2sZ1Gre4_P57_2wv-A>
    <xmx:UId-ZzhLE0OimCZTiyT9BB-YFXzTb-Nr7XwSUhI_azOppCsDxt15v4Bt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A74D72220072; Wed,  8 Jan 2025 09:10:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 08 Jan 2025 15:10:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Niklas Cassel" <cassel@kernel.org>, "Hans Zhang" <18255117159@163.com>
Cc: "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com
Message-Id: <7e025613-3516-4957-b83a-70b125a24fa7@app.fastmail.com>
In-Reply-To: <Z31O8B14sKd5eac-@ryzen>
References: <20250104151652.1652181-1-18255117159@163.com>
 <Z3vDLcq9kWL4ueq7@ryzen> <d79d5a72-d1b0-4442-a0a3-e53516726204@163.com>
 <Z30CywAKGRYE_p28@ryzen> <96b3a0f7-f144-4f2a-9f84-82c31d8ec23e@163.com>
 <Z30RFBcOI61784bI@ryzen> <270783b7-70c6-49d5-8464-fb542396e2dd@163.com>
 <Z30UXDVZi3Re_J9p@ryzen> <4bfb6c46-6f93-431b-9a8c-038bc7f77241@163.com>
 <Z31O8B14sKd5eac-@ryzen>
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jan 7, 2025, at 16:57, Niklas Cassel wrote:
> On Tue, Jan 07, 2025 at 11:44:21PM +0800, Hans Zhang wrote:
>> On 2025/1/7 19:47, Niklas Cassel wrote:
>> 
>> Hi Niklas,
>> 
>> > The error:
>> > drivers/misc/pci_endpoint_test.c:315: undefined reference to `__udivmoddi4'
>> > sounds like the compiler is using a specialized instruction to do both div
>> > and mod in one. By removing the mod in patch 1/2, I expect that patch 2/2
>> > will no longer get this error.
>> 
>> The __udivmoddi4 may be the way div and mod are combined.
>> 
>> Delete remain's patch 1/2 according to your suggestion. I compiled it as a
>> KO module for an experiment.
>> 
>> There are still __udivdi3 errors, so the do_div API must be used.
>
> Ok. Looking at do_div(), it seems to be the correct API to use
> for this problem. Just change bar_size type to u64 (instead of casting)
> and use do_div() ? That is how it is seems to be used in other drivers.

I think using div_u64_rem() instead of do_div() would make this
more readable as this is always an inline function, so the type can
remain resource_size_t, and the division gets optimized well when
that is a 32-bit type.

     Arnd

