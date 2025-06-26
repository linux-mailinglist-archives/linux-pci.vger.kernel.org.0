Return-Path: <linux-pci+bounces-30881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B84F0AEAB2B
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 02:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7974B1C45995
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3790A26CE39;
	Thu, 26 Jun 2025 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkEx5d9N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2DD26B774;
	Thu, 26 Jun 2025 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750982185; cv=none; b=C6qDMEYOwUKjSL1SciJJEqnmxM6dzjHV8dIyBmkbBFxnw67ShnwEw33BMHOP+qhJ2puLuNMPWznO8MX3cc6d7pA9NvK/A4OJ34oTQtm5jC/yfbSaPqd5kKh1zw3O8JG+DNm7vFvge0UcJnjZMpuKZU99ykU5ARirP10SX34a1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750982185; c=relaxed/simple;
	bh=V6PaD+mOdJf/Wx4LXMvb+V/s4uPvgr65Xac12kZp4Ao=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CJ8RYMSefTOGCmf008a77RenOvtnm1YHezqD31v7CeqULVHQwKUq/fBhx9R8B8G/x8c1e7avXYpk5Wz8wRE9ZLt9/6SB70BGPn9cFhXrFRDZJbwj432HgmpPPN90G9xTLb89gp2S1SuYvHabOwy9tYIsLhFnG973UpRZIK89xM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkEx5d9N; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a58ba6c945so25122601cf.2;
        Thu, 26 Jun 2025 16:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750982182; x=1751586982; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3W4MeTRtq9WpJdM166iO3DjSmO+l8AtQovmURm54GmY=;
        b=TkEx5d9NA+LNit0CHVHVj8iOyBWs2xGR8zmiRYZEL7fSlph3FhpyXa0PcQPMiUqp45
         HnC7bKTPX2v8L53qCKE+5Sjx+LiJzitbdMUyGYutE0jTgFSa96r2pI7s0n31LpTcvNOw
         gaOzJ81LInOBoEcTeGGRt/+wfeuxKDBKr/63ST9WAC7l2oUKogJqCDqoNGqK6mphom3y
         xUU6Pq5d75uTZXcotVVDJSvjWLHYlmTbuozUGjDcS3LQEKmrKA6BN+0HrzL31GMjsntM
         yMDXzrd3BmWD9z9Dp2gr52m/K/XHVJ23XWTi/Rw3a/G5i9ZQoo0I3YxliJbc5PzJE/KJ
         BHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750982182; x=1751586982;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3W4MeTRtq9WpJdM166iO3DjSmO+l8AtQovmURm54GmY=;
        b=uX0kuVkobpylRKC7gzlx59akTlFlKi/VwMQuPLel1HMyWkfD4X66XNGgzqZ23xzgHn
         Vyy2KhqKKXYM8BiXuvlajIUwi6guILeLj+P7DVDlMY1P78+hr2lwF0mGwVAu6diclx4q
         B83c4Tz6jtYGs4RDB9RUv8R56rS18/vrrQuZqFjiZktuVOV88jiqrFWaru5+nrkYhKb2
         Zii+UCCXrfF/YPc/qL1gGYWjWjEAKRibcTxw1NZkk9Ff6BO5c5oHqPwX4h+OMTSr7sk4
         d0+HA0shsja2qcok236RQgYUrOOm8OFGKroqtWBoSjTzbGlNuWu170T1a3mgDQlDyNyj
         oz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJJi/6l1V5ix6+o+HN6es49vBsZ/tiur1AnoDMga6hII51/8lEJnzCbFPHVeq5phoAj+vBCie6QFNSpX6Uu2o=@vger.kernel.org, AJvYcCWd+0Mlqn8GIIUFeO0l5PVhiCkE3CPwVqZGq9K/eDyCxwgLTWJr5AyT9tlPkTUps+WnvsD8qSfv0F6Yx+M=@vger.kernel.org, AJvYcCWx4kirX+sQufw+LpnLe+NupCkUrK3cEsqchqkQ7W4UbvlUW39Z2c5qIkeP1gh7NHQHDoX7WSQs4X1F@vger.kernel.org
X-Gm-Message-State: AOJu0YyKyQH2Gb/GpG48otGYIYaXKjPgUwxQKmwhI9FMFGjT4V4fYE+6
	WczhIKmuIvJsUVRkS/17Aiw7w8JcaSCMtYz0PJWdIOkx3LincEcBuE9K
X-Gm-Gg: ASbGnctAQKd2F8LhKOCBp+lUEZ3GIN6rN5aKgKhGvbQqCP4yvoKVDyXh8hcPu8vM2Es
	rjpv1iiuj2UiZFX2InZqpTD2rxDXWTPXdbpKd3kyaU6LUGTmhB9Pyz5HOsXmOIQGjBUnJ5NvUbo
	qIjZiKSdqmewG01H0rCA+S03vNGDAwkESLkXBtYohJtpYirRPDi+meHiEBw0TH0cmFm51bCDvV1
	YbOvSqmFxIh4rqEaWGrJ0UazKGuLjGCG8SpN9NJc3Lc4jWXV2pNcB0/jGfQ+IVpDjabckNDgZ3e
	U7HfP/e1SNt6mp3suLkVmY4JTB583MaooHhnRRfvzlQ/0T6Mup76VrlPJ4Nr5g6W8YMaDlg2Ruo
	IaRbcuzmn5VUCGOBxzWV3EeTiFhI4dSI+XDfspXfYH1pJKlCCSpT3
X-Google-Smtp-Source: AGHT+IFppTeb51InjM3DH/7AlqJmcKHpDoI9MLS6ubjHI5kzjPr0oRH5uGXYaVRX2SdMc4Uk1G74mA==
X-Received: by 2002:a05:622a:30d:b0:4a7:f9ab:7895 with SMTP id d75a77b69052e-4a7fc9ca69emr27580001cf.4.1750982182074;
        Thu, 26 Jun 2025 16:56:22 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc13a34esm4984701cf.24.2025.06.26.16.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:56:21 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3A6E0F40066;
	Thu, 26 Jun 2025 19:56:21 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-01.internal (MEProxy); Thu, 26 Jun 2025 19:56:21 -0400
X-ME-Sender: <xms:Jd5daB-nGdEImip4pjGUqAFWZMGV8c1lVj4zQv1B1d8GXLZmcV4yvg>
    <xme:Jd5daFsenE5PSAvY7UWHjd1VXi4pQyo51eNVVEJPDtroARm3CovOiySYUyOqMZWth
    UBiUh2vWsndS4783g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfuehoqhhunhcu
    hfgvnhhgfdcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepieelueeiffefffeigfelheeggfeuuedtvdejvdejteevudffteeffffgkedt
    uedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtoheprghlvgigrd
    hgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepuggrvhhiugdrmhdrvghrthhmrghnsehinhhtvghlrdgtohhmpdhr
    tghpthhtohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomhdprhgtphhtthhopegrrd
    hhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkfihilhgtiiihnhhskhhisehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:Jd5daPAGA5mkTpn2DRdIeBB2Zosch4kDEGVFpVWW9BwRjnEsSpbvjw>
    <xmx:Jd5daFcAqah402dpcL84tCy-N9Ti2pdoFTZNrJ6AyTeyMS9cHiLzYQ>
    <xmx:Jd5daGMTu6SGygJdpWFZ9U-8JPfJ-zKl0G75Nd0kOCIMmsoKHDHC8Q>
    <xmx:Jd5daHnPPHFHxJ0lsy6oTh-2WoI9Y1lmial86hJxEkh0PJJaEVBrmQ>
    <xmx:Jd5daAuedH2o9yWI2s5xkCn_3bqx0AJeBSr7Rt0wWQ7ZJPKaVmtSVOu4>
Feedback-ID: iad51458e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 148B12CC0081; Thu, 26 Jun 2025 19:56:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T383afef5f8ca9bad
Date: Thu, 26 Jun 2025 16:55:50 -0700
From: "Boqun Feng" <boqun.feng@gmail.com>
To: "Benno Lossin" <lossin@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, rafael@kernel.org,
 "Miguel Ojeda" <ojeda@kernel.org>, alex.gaynor@gmail.com,
 "Gary Guo" <gary@garyguo.net>, bjorn3_gh@protonmail.com,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Message-Id: <44579f29-a8a4-41cb-97ea-5ab7711e4d2a@app.fastmail.com>
In-Reply-To: <8922f6f0-241a-4659-b382-fb8c62b77e8f@app.fastmail.com>
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-5-dakr@kernel.org> <aF2rpzSccqgoVvn0@tardis.local>
 <DAWUKB7PAZG1.2K2W9VCATZ3O0@kernel.org>
 <45a2bd65-ec77-4ce7-bd8e-553880d85bdf@app.fastmail.com>
 <DAWUY4YH6XP9.TWAP6N95L5BR@kernel.org>
 <8922f6f0-241a-4659-b382-fb8c62b77e8f@app.fastmail.com>
Subject: Re: [PATCH v4 4/5] rust: types: ForeignOwnable: Add type Target
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Jun 26, 2025, at 4:45 PM, Boqun Feng wrote:
> On Thu, Jun 26, 2025, at 4:36 PM, Benno Lossin wrote:
>> On Fri Jun 27, 2025 at 1:21 AM CEST, Boqun Feng wrote:
>>> On Thu, Jun 26, 2025, at 4:17 PM, Benno Lossin wrote:
>>>> On Thu Jun 26, 2025 at 10:20 PM CEST, Boqun Feng wrote:
>>>>> On Thu, Jun 26, 2025 at 10:00:42PM +0200, Danilo Krummrich wrote:
>>>>>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>>>>> index 3958a5f44d56..74c787b352a9 100644
>>>>>> --- a/rust/kernel/types.rs
>>>>>> +++ b/rust/kernel/types.rs
>>>>>> @@ -27,6 +27,9 @@
>>>>>>  /// [`into_foreign`]: Self::into_foreign
>>>>>>  /// [`PointedTo`]: Self::PointedTo
>>>>>>  pub unsafe trait ForeignOwnable: Sized {
>>>>>> +    /// The payload type of the foreign-owned value.
>>>>>> +    type Target;
>>>>>
>>>>> I think `ForeignOwnable` also implies a `T` maybe get dropped via a
>>>>> pointer from `into_foreign()`. Not sure it's worth mentioning thou=
gh.
>>>>
>>>> What? How would that happen?
>>>
>>> The owner of the pointer can do from_foreign() and eventually drop
>>> the ForeignOwnable, hence dropping T.
>>
>> I'm confused, you said `into_foreign` above. I don't think any sensib=
le
>> ForeignOwnable implementation will drop a T in any of its functions.
>>
>
> A KBox<T> would drop T when it gets dropped, no?
> A Arc<T> would drop T when it gets dropped if it=E2=80=99s the last re=
fcount.
>
> I was trying to say =E2=80=9CForeignOwnable::drop() may implies Target=
::drop()=E2=80=9D,
> that=E2=80=99s what a =E2=80=9Cpayload=E2=80=9D means. Maybe that I us=
ed =E2=80=9CT=E2=80=9D instead of =E2=80=9CTarget=E2=80=9D
> in the original message caused confusion?
>

The point is whichever receives the pointer from a into_foreign()
would owns the Target, because it can from_foreign() and
drop the ForeignOwnable. So for example, if the pointer can
be passed across threads, that means Target needs to be Send.

Regards,
Boqun

> Regards,
> Boqun
>
>> ---
>> Cheers,
>> Benno

