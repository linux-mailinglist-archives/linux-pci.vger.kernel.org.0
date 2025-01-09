Return-Path: <linux-pci+bounces-19589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B4BA06E3D
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 07:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0383A7864
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 06:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0DC1F76D1;
	Thu,  9 Jan 2025 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OJF+XRF0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SHBUJucD"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3F19BBA;
	Thu,  9 Jan 2025 06:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736404167; cv=none; b=LPbsFBKmw9+s3m1ba0WRwHbphuwt8fnJQRkh+/8DLyWdhRIjxmEmQJjL7AvqftZn8o/WngUc9znH0kWIwnvfLg7eRBSvWR21KRnosxR+krVJSs8J/34kSUhC25grBI4yMwBUy8QGPP5oFcilEkW1IA0QaSlbF0v/8Vv64AJe2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736404167; c=relaxed/simple;
	bh=rTOSHpWKA/TFQljZP9dDng0HmRxk6TEHGd4vINZJUMU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pQIdnHmeYLFXTuBuB4cdmdSAICowxtk4QS8j5NtQaWZIYLhzlVy1PFwKxiKfrNevvUx9FO5v3C9Zy6I2sjNsb9unhaDNFp1Io9dXYTFpBedCEoA+y6r6C+fIkvfluasr/p0o3BNyDI4YFER4naIsKw3vxVKwxVboGMfAadQbCQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OJF+XRF0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SHBUJucD; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B196411401D4;
	Thu,  9 Jan 2025 01:29:23 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 09 Jan 2025 01:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736404163;
	 x=1736490563; bh=r0H4KhJhw9oZuXiFEcpgNiv0lbM72Quzo+7KCVOexSs=; b=
	OJF+XRF0U4rcqHlqzxfE/9HFzMYq5aG5GKmv7zTowKvVjX8cQTQhB3jJmPk3OT+y
	VwHsgJh6NhnuzrOM7QFarNyqe+xcXRh6rDVK4RYxAwWomkOWd74NqmhJVrlBL8uJ
	9ZEEPx1t41nkHgyuvXW7Rp9Kel4XMpqEts9qN/dS+vVcZknCEgY9dwE2J7LRxwQ8
	VIUBLB0aAWgWuEaTtf8c5PS8rpE/8Y6jK0t+HESb6ekgCFBLEzNOCjnG3R5mcQaB
	DL4LVIJ3UyRvUsBybU9cDHiaJN6JVcSaYeg8VjrMzYe8wvr0jM+bw3u6fAChxfsO
	ugV/TfKFPSOWAKdz9iLmBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736404163; x=
	1736490563; bh=r0H4KhJhw9oZuXiFEcpgNiv0lbM72Quzo+7KCVOexSs=; b=S
	HBUJucD721QMcK6+decH0Ebq6wycu3cf18d0JDbsBgfydEWi2K/GoyqpeN9yddAa
	lbrKMfRFQTGnqqoFZC3grRMAM+/StVfrpNdWc0DNUIECiY4rTfliOBpgLDrqclr3
	N3BT/Aj+97dEq7ySQEHeKg7lRGi7i1K0VlTM5o/D6SmVOoPfVqSRyRe0eoodw2ld
	+pKJ3P2gwlxGB8Hx9k09hNzlwySEkFvYCWj8yEbcvxlC5a6hjQlEJ8eLVufDwKVV
	6Jr69K5OtO+CXI5m+/mNmktZuNwj+cTdXkffzScZ1Ft43ppYiLWBD4hYoy5IzoXM
	uzlNZMCxc3dHmnB3UPgyA==
X-ME-Sender: <xms:w2x_Z-f7JbJ98Qy2AZCtAyB9Zvny5ObcKP2pk8HcYzrNlo3K-9Oing>
    <xme:w2x_Z4PnZ83Lx18AneKGCi90gldSBO-79u_69JdUTiv9OzrkNtGk81BIDCLVN2VD1
    jIV4nMozS_HCfgQP00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedgleehucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:w2x_Z_icYc04cuZL8SpFwOGnJWYtveIkoUG3qz8DG7_CDR7g0XejdQ>
    <xmx:w2x_Z78RGi8CiH9C2mRJNQ44wKhTp0vzYVuU_eUqIpLvCZhxkKeH7w>
    <xmx:w2x_Z6vsYrTx9AxBgEoca5kVlPdFD-psxXPRuTjnw7n9RuoB4pq1cA>
    <xmx:w2x_ZyEDS6cGdGKj5CCqhMrVon7m5tLJ2Ot6Q6exbRia63d9vAOogQ>
    <xmx:w2x_Z4CzEUHekMnlu_VN93PC45EJGh8YbKN8UfOTPRPgLbAD4sTa3A90>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2ED802220072; Thu,  9 Jan 2025 01:29:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 09 Jan 2025 07:29:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hans Zhang" <18255117159@163.com>, "Niklas Cassel" <cassel@kernel.org>
Cc: "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com
Message-Id: <2b6eabad-ebd1-4e7d-b4bf-6b818dfc20ac@app.fastmail.com>
In-Reply-To: <f2901d4f-52c8-496d-9939-3b0e113cba4b@163.com>
References: <Z3vDLcq9kWL4ueq7@ryzen>
 <d79d5a72-d1b0-4442-a0a3-e53516726204@163.com> <Z30CywAKGRYE_p28@ryzen>
 <96b3a0f7-f144-4f2a-9f84-82c31d8ec23e@163.com> <Z30RFBcOI61784bI@ryzen>
 <270783b7-70c6-49d5-8464-fb542396e2dd@163.com> <Z30UXDVZi3Re_J9p@ryzen>
 <4bfb6c46-6f93-431b-9a8c-038bc7f77241@163.com> <Z31O8B14sKd5eac-@ryzen>
 <7e025613-3516-4957-b83a-70b125a24fa7@app.fastmail.com>
 <Z36IJ6ql09I_dO98@ryzen> <f2901d4f-52c8-496d-9939-3b0e113cba4b@163.com>
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jan 9, 2025, at 03:59, Hans Zhang wrote:
> On 2025/1/8 22:13, Niklas Cassel wrote:
>>>> Ok. Looking at do_div(), it seems to be the correct API to use
>>>> for this problem. Just change bar_size type to u64 (instead of casting)
>>>> and use do_div() ? That is how it is seems to be used in other drivers.
>>>
>>> I think using div_u64_rem() instead of do_div() would make this
>>> more readable as this is always an inline function, so the type can
>>> remain resource_size_t, and the division gets optimized well when
>>> that is a 32-bit type.
>> 
>> After patch 1/2, we no longer care about the remainder, so I guess
>> div64_u64() is the correct function to use then?

div_u64() is the correct interface here, div64_u64() is the
even slower version where both arguments are 64-bit wide.

>  >> drivers/misc/pci_endpoint_test.c:311:11: warning: comparison of 
> distinct pointer types ('typeof ((bar_size)) *' (aka 'unsigned int *') 
> and 'uint64_t *' (aka 'unsigned long long *')) 
> [-Wcompare-distinct-pointer-types]
>       311 |         remain = do_div(bar_size, buf_size);
>           |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~

You don't use div_u64() or div64_u64() here, do_div() is the macro
version that must be called with a 64-bit argument.

    Arnd

