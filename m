Return-Path: <linux-pci+bounces-35525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612C6B45552
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 12:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215A5585C0E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 10:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3892F619D;
	Fri,  5 Sep 2025 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jH4lr9KD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QmEL5ag9"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E208D179BD;
	Fri,  5 Sep 2025 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069593; cv=none; b=V4LzuaQMeKj05wfs1tGs/KHyu6b6eYC9iYuqHyEbxUKBsWIHWlAny2b0VQMJXGoDgSR1mDJ+EKdyXDyCVeB4QoJpYcZb5ARKhCKCmWAQ4/HF57vEgKT0U9ZzWWxBBTRh/egFawBBcqdQrykOIrt823TE7y8ybYOvO+Qd58T1hYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069593; c=relaxed/simple;
	bh=o7v/HNWnjHt/Uzn1Ge3TzJ7eh0hyU3DB0ZeYdCA8Zk8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Jj4cNL6316CnbAYksra0BurB0fqMpcXcACG4Awjr3wD0z1SOFBGhT5U5aOzERt5kDX/2oVaw4kMHhGltsjXadv4kZVLDqoQddefWpTXR7y8Z1otIPStc/oCGciar2rVHKHGIzX0tuY+yhGluvwpk1lEAYC+o1VUfmzvLvQH8qU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jH4lr9KD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QmEL5ag9; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 24212EC03F9;
	Fri,  5 Sep 2025 06:53:10 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 05 Sep 2025 06:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757069590;
	 x=1757155990; bh=LLX3L6AOVZij89L899m4GOoTR6qvTds5RNaEn3slUp0=; b=
	jH4lr9KDGzqJf3o9wPt8s35oNXSKy5YUhWK4AWy+zrd2Lz7QDfZUNbRmjME6kf63
	u2lOCEwcjey642T8NpEBeEHLbQyufe4Tp0z0klSpY+HyXfd2D8NBBE0OdoRQxmW6
	Avu0bnOg3dMWvCWoSHPlTZUcK6qaAE03Ee0f1BpFM7CoaDA8atty/6EUP78QoeXA
	1ExaSub1qp38LG6DIB1PACOmgoha68w/FUK8nM+hqfwQErfExKUtaCevx8EaYND8
	L+axBmjn5NivHKsVAkeO8OBpTj2/BnyiTodlvMWQTAgbxMDtpl0BAsS/tTTkfm8N
	6nC8iHOl/V7RqW4pY0glKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757069590; x=
	1757155990; bh=LLX3L6AOVZij89L899m4GOoTR6qvTds5RNaEn3slUp0=; b=Q
	mEL5ag9goV29QlI2c24+hx/oAx4oWyV8b5vCwUVAExSeA5fjX1NNQp34EY0iDF9z
	5KRq5vGbIkT/v9rDc+Qo/G2sAFepcOCShNhWOzdBOqier1GPAXzsKcd1i5n1Llqt
	nnrpCdLuJ3mNDRQAaN3uly/GD8PPOoLjE81W4kYL0SbSipE6IP4nMXZPgxxrL8YE
	jQwCTwxg7b2Oag9SZ9y3MxlN2DpF9C2//gGoYXqU0VgCTbUWQMmTCkTBQMPL5/s0
	FLJplIgZxgSRlLyCCyMVy809F6BiRTTETCTRie2vMHn77PBvgb9uGSdKn0p+CEga
	Hkg7QvG61EGlriR5/JygA==
X-ME-Sender: <xms:FcG6aG48mVVtE-tVka-hZF0wTFYusVXo9DWMC914E8dZEDjSjHv0IA>
    <xme:FcG6aP6q538NkYX-o-njEIuQLMk5FQFUnBshrms8GQHILltbLC8unsYuZ4Gvne9ZI
    zURj8l_zjKNlbtufQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    ephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepph
    gvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepkhgvvghssehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegrnhguvghrshdrrhhogigvlhhlsehlihhnrghroh
    drohhrghdprhgtphhtthhopegsvghnjhgrmhhinhdrtghophgvlhgrnhgusehlihhnrghr
    ohdrohhrghdprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehlihhnrghrohdroh
    hrghdprhgtphhtthhopehlkhhftheslhhinhgrrhhordhorhhgpdhrtghpthhtohepnhgr
    rhgvshhhrdhkrghmsghojhhusehlihhnrghrohdrohhrghdprhgtphhtthhopehlkhhfth
    dqthhrihgrghgvsehlihhsthhsrdhlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:FcG6aABbyTmpwQCB5B1ukcfVsjGJ8ALCSDbQGb915dStrKnMhfBBwA>
    <xmx:FcG6aHFS-Ugn6hBNjQVt_BhZ8V2QqzKuTOlBT3OjYVhP1CtzB1IJVg>
    <xmx:FcG6aAsgRlGuUAz_TUFvY3Dht7UDMpqqpM6wBD7rRTDDDILlLs3w8w>
    <xmx:FcG6aNkXhfJ3-_wPhSXJa4CVMG4EyMK5XJdkj18KPS3kJTz6jgzPCw>
    <xmx:FsG6aMOQcHjgRB3ah_2HvCAog_UPeWTqXlgVtrAS07LZLHqhj86HCRr6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6A4E0700065; Fri,  5 Sep 2025 06:53:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABrrY9NwCfcB
Date: Fri, 05 Sep 2025 12:52:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anders Roxell" <anders.roxell@linaro.org>, "Kees Cook" <kees@kernel.org>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>,
 "Linaro Kernel Functional Testing" <lkft@linaro.org>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Benjamin Copeland" <benjamin.copeland@linaro.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Peter Zijlstra" <peterz@infradead.org>, linux-hardening@vger.kernel.org
Message-Id: <f5db760e-c143-4f6c-9389-309a362f0baf@app.fastmail.com>
In-Reply-To: 
 <CADYN=9Kd9w0pAMJJD1jq4RSum5+Xzk04yPZiQxi9tmEBtHPEMA@mail.gmail.com>
References: <20250905052836.work.425-kees@kernel.org>
 <CADYN=9Kd9w0pAMJJD1jq4RSum5+Xzk04yPZiQxi9tmEBtHPEMA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Test for bit underflow in pcie_set_readrq()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 5, 2025, at 10:16, Anders Roxell wrote:
> On Fri, 5 Sept 2025 at 07:28, Kees Cook <kees@kernel.org> wrote:
>> @@ -5949,7 +5950,10 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>>                         rq = mps;
>>         }
>>
>> -       v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
>> +       firstbit = ffs(rq);
>> +       if (firstbit < 8)
>> +               return -EINVAL;
>> +       v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, firstbit - 8);
>
> Hi Kees,
>
> Thank you for looking into this.
>
> These warnings are not a one time thing.  the later versions of gcc
> can figure it
> out that firstbit is at least 8 based on the "rq < 128" (i guess), so
> we're adding
> bogus code.  maybe we should just disable the check for gcc-8.

Out of the three failures I saw, two also happened with gcc-9, but
gcc-10 looks clean so far.

>          \
> +                                       (0 + (_val)) : 0,
>          \
>                                  _pfx "value too large for the field"); \
>                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>                                  __bf_cast_unsigned(_reg, ~0ull),       \
>
> I found similar patterns with ffs and FIELD_PREP here
> drivers/dma/uniphier-xdmac.c row 156 and 165
> drivers/gpu/drm/i915/display/intel_cursor_regs.h row 17

I did not come across build failures for these.

    Arnd

