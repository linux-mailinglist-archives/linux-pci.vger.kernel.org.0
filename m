Return-Path: <linux-pci+bounces-41378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D3C6359E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 10:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B35B380FA4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC2332779B;
	Mon, 17 Nov 2025 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="T0EkJgKC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qYUEP6bx"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19D299A96;
	Mon, 17 Nov 2025 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372603; cv=none; b=jheNm4YnGANRDDLBbHdKMMjt1v1upcg6Ox6EhEcij40w891gv50XDhLMd3xDG3ipzuZDpoS2PN0vZcHhCxEkU0pQOX/LBC4pc9SjFE2wQbpztW4EdazO9dQQlB0eKiyi8Gi3OvhKJbTUb8aO9GDzlvBrj2xaXZKX3HHkORLeRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372603; c=relaxed/simple;
	bh=Fq6cDpU79qOWFGK1t0X95O9tDLh2cB4gJjqrGSnshp0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oOEbRBjdNLiV35pmSgLlDdJ0kZ20PznWmUYznKma3trWsDTPNjd3XNdOoehA2wRpegXIeM/iG7OYHDA2hi1kM7dPOH4h88NS+QDB4WrbSO+ladVJbDXSwk5j1/9U4lPje60ALxG5JYP+3FPFLd0uVzqV5+ZJDRBW8LC9viZmxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=T0EkJgKC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qYUEP6bx; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB8FA14001D3;
	Mon, 17 Nov 2025 04:43:19 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 17 Nov 2025 04:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763372599;
	 x=1763458999; bh=sT1vNBwVROLZPKVddoZIohPPUecTNY2R/P13dlzJXbI=; b=
	T0EkJgKCLIMPF806+hzXmRAcbNfdJCAILARWg4EZM3zfUKfFxdOLqpcgIcwiXOfO
	erQot5VlD2cux2/ErnW+Iv1l0l7wCQyqGQS5kuIvo4T6Gm4bUGlrsoKqk47Uotca
	E9nDWWD1KIQlF0KHgJRTA6ZWwgQBf9Q51OpxtbrPKnx94NIW/33yT58y+KTZSWrC
	K86nm98bpfBAuhFBlmr716VG14/0oVuZZkwCGPQw498/7shNMjSYpRQ7hLF7N66R
	BMBQoCOkLCd+kUYVWgYf8vmw0KMI/Cjztmjq5RpMDbQGVpXIezXjCCIRvQIpuHhL
	mQmxwOPFQqhc8FeahVF+tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763372599; x=
	1763458999; bh=sT1vNBwVROLZPKVddoZIohPPUecTNY2R/P13dlzJXbI=; b=q
	YUEP6bxzDTn7NmjJyBFJumNssyRd1QtWpfl+IGOcEttrH4b3TnZgECNvRF1zW2px
	FfeSi1D821IA9dGrt0mbg0zD+CjogPIihHYkM3iOi5mBVLPE7RaouVzTy7MjHe1Y
	HOnCupfVSPg1PmJdfOySY2CuUirqIwIginvXWiDJOtarpDXGWhmEE+5+HCR+iXfL
	Cwkd5htyewgMzRGwOMgGzMhdqEt6l0uCHqN90bf8/3xFEhref5atI5k8xaN2vcc+
	ex1x1Isd+J/HM36HkJoj75Cq6WRlvmzwSSv8fn5I3pupiWBcUGHkhhGiDbRwbhy6
	AWwfsDNDO0/aCtXlxMbuw==
X-ME-Sender: <xms:N-4aac2RFyGLnUqijeqQVvomJGuo2PxuLYBAqt0uglJeLGzaAuYzaw>
    <xme:N-4aaR4Wkk4LEKkpbrgFkPuY7RXosBHwr6SIRFQ1Y4FRNe_mRDo2CILmNGPDlH9eM
    JgPMTQwgWtIocecGg5aJj77D02aDMuLaq5sfcIoLvulH3wSHjNV1Ds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudekudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhishhhohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkfihilhgtiiihnhhs
    khhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlphhivghrrghlihhsiheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepmhgrnhhisehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmh
    dqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    uhhnihgtohhrnhgpfigrnhhgsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepshdqvh
    gruggrphgrlhhlihesthhirdgtohhm
X-ME-Proxy: <xmx:N-4aaRyxh3Q8AJLSnX6F5evD92we4PcMxwOS-dT1AmzJTQqO4UacmA>
    <xmx:N-4aaWfYNUUD9IFnF7hWPzYPR00X20e1hiEmn-Z4V-wRVLRicp8vXg>
    <xmx:N-4aaes1uMi8oAZ3-VSieEl5QqNgqZnZIMPKuAs6SYRRxv6QTri8kQ>
    <xmx:N-4aaTBWohPtb6UOlfDQzdIsxUIZXQlJTbrVRf42yzQ-N57mnU6W3A>
    <xmx:N-4aaRep-p8ziAyI6weD5d5bkRxM78vHFBwKvGArWFGK7Qz1G5IzeFM2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 76DBE700063; Mon, 17 Nov 2025 04:43:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AO4N9SNPwumV
Date: Mon, 17 Nov 2025 10:42:58 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Siddharth Vadapalli" <s-vadapalli@ti.com>
Cc: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>,
 bhelgaas@google.com, "Chen Wang" <unicorn_wang@outlook.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>, stable@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
Message-Id: <477b851b-56b1-497a-812a-eb0c9bfdc4d8@app.fastmail.com>
In-Reply-To: <8ac2ed36a85f854a54ee1d05599891632087869d.camel@ti.com>
References: <20251113092721.3757387-1-s-vadapalli@ti.com>
 <084b804f-2999-4f8d-8372-43cfbf0c0d28@app.fastmail.com>
 <250d2b94d5785e70530200e00c1f0f46fde4311b.camel@ti.com>
 <201b9ad1-3ebd-4992-acdd-925d2e357d22@app.fastmail.com>
 <7eaa4d917f7639913838abd4fd64ae8fe73a8cfc.camel@ti.com>
 <37f6f8ce-12b2-44ee-a94c-f21b29c98821@app.fastmail.com>
 <8ac2ed36a85f854a54ee1d05599891632087869d.camel@ti.com>
Subject: Re: [PATCH] PCI: cadence: Kconfig: change PCIE_CADENCE configs from tristate
 to bool
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 17, 2025, at 10:23, Siddharth Vadapalli wrote:
> On Mon, 2025-11-17 at 10:06 +0100, Arnd Bergmann wrote:
>> On Mon, Nov 17, 2025, at 07:05, Siddharth Vadapalli wrote:
>> 
>> but you may want to split it up further to get better dead
>> code elimination and prevent similar bugs from reappearing when
>> another call gets added without this type of check.
>> 
>> If you split j721e_pcie_driver into a host and an ep driver
>> structure with their own probe/remove callbacks, you can
>> move the IS_ENABLED() check all the way into module_init()
>> function.
>
> Thank you for the suggestion :)
>
> Would it work if I send a quick fix for `cdns_pcie_host_disable` using
> IS_ENABLED in the existing driver implementation and then send the
> refactoring series later? This is to resolve the build error quickly until
> the refactoring series is ready.
>
> On the other hand, if it should be fixed the right way by refactoring, I
> will not post the temporary fix. Please let me know.

Please see if my suggestion works in practice using all the
combinations of build options, I may have missed something.
If it fixes all the build failures, merging and backporting
this first makes sense.

     Arnd

