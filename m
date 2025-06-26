Return-Path: <linux-pci+bounces-30879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17F7AEAACD
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 01:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5522716D1F0
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7011F8724;
	Thu, 26 Jun 2025 23:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1b+IqCi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D211459FA;
	Thu, 26 Jun 2025 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750981541; cv=none; b=YXL+A9ONfc8N8jjmGg6+0Q3t9K1ZJRW0MmPCrJUfB9n1tvDjQL6V5SN+Ss6YAbOQg2t1XCZ8cES3YuP6JnrABKJIfpxvpq+kX2P8s4hcdBCl06T7o0Gs8JCzEn+j6xVf7aHsrcvahMwpcTXl9zgjpMfQnbRCzIckfSbLqxQSJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750981541; c=relaxed/simple;
	bh=HjNHxuUtVtqJ+E+XFMhXbJFRRAtTO4J1wmzly/ahXZE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HHc3fAdbqvGcXW5o7rh4qTnGMHpmoIKr0AL3SFFWEUqKb0sp62ik5npQ9xlgJcef6rpShPeqz9LvZDO0yXVA8BuigQ90FZVJMnOjsw7ioEFC8o23fkfVRlo7rp6zRlit8M33VuWGRTarlGNWqptvW5oI/H5jZLrusAC3qkULCEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1b+IqCi; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d0a2220fb0so184359785a.3;
        Thu, 26 Jun 2025 16:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750981537; x=1751586337; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RlRZzJJo69Hb7oEfyDdPzBBhlLTwP8vir0dHoRyHIE=;
        b=E1b+IqCi1SCM+kRphDbDXo3ecZa3/1ivfc9lkGapfc8RbW35jW9vqcz18NS7tF+0sG
         zV6ElIUxYlQ3xKs/j3vu4hSeDFC4sebN1mEhsM3WIq/iKoifHS5N8Wt3ZOvNSJBXgWi6
         ZoSOr31yVfzkAp53ta4Hk/gEWibeuTzTjaDqH62ySXAxralK0io+7actLkfOhpiH9n/i
         AVSlpjfP9KLDHigKSOaA8+P7XYPVBJm8jBKKqMN+UHxWSvZ2fPD0lJN5FlU3rgsXNF+Z
         XPEPSCk94yo5/HpaIcVyp76bUkWhdKW5GjVSOGMx1ri5n1p/SNhddOFcuk1mST41i33r
         wkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750981537; x=1751586337;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+RlRZzJJo69Hb7oEfyDdPzBBhlLTwP8vir0dHoRyHIE=;
        b=tkm/dpSo8UUjBrNeORygx3ZYInmzQT6fFMQ1ukmVkxv9dmLdtkU7ISZyQfgoNdhRYh
         KBL+0JnGUE+sfTTEsRzgyc8S3CR+cEhGoqv8NrVqW16BZqE4PExISjNP3ZfcyB5wLmKi
         yqLA2YJ/57cDMNMs7Qu58yPZRhi6A+MXbNSIga010v3z0iTAxjSTH2+bfoishhTnufo8
         FDfCVactTw5vwb1dzqx9gwFItyTaei3oouhH/L9fhTxfeD/YhtjOx4wRFT2wFnjoTKQq
         ANUrZ4fI9t+KlnUDjGKdkXvOJipfb607w6X22QuvLus3yTumyl3wGLWPDARUFXngOPtA
         pm/g==
X-Forwarded-Encrypted: i=1; AJvYcCUgu90UmSilBYUvz3JxQf+InWUtiLmAu75iPV9wtzNffa5FOAAIs9HqlC0E4H5Tzg3cwP2TdGKk42Rp@vger.kernel.org, AJvYcCWLJ5+NHjyaQLnZFbUjLQEocY+MWpaNDnrwUSywRyUZyt8fmHVpSr0ndRX97OD9jM7gyYmAsIz+WjaMlphrYAI=@vger.kernel.org, AJvYcCXlf4lM2ZIogmY5z+P0rzSFCOgJFrTaRdnQUHFhnao7tTKILIWX4qUnSeTwKR0CXzUzUVWDnxW9J4hZv/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVF+ivxIqz5u3hS6ZB6hhVfb6C98E4kbLHxrcXZdqN0TDnX6Dr
	o7zO9vOnwvQ9rK9fmwSfsM3CFJ9/6fj9Ggq+2Jia+HWDEgs4oTEFGmI58X72GA==
X-Gm-Gg: ASbGncvXoXBL837CqKn65lc8FkQ7+lQfDpfn2qwfWJMHAispeteHlys/zjrXnGN2ajQ
	tHE/TPLi8MP5SpU1dWM+X6Z1KqrikT1b+oKxu9AeYk/k7U0I0Ieba8oRU0MSGMcQv+od57K5z0N
	ayakvDuwP6qXHxAmTY827tixviDUbK1xDx7JLtoRIcSFNwTOSJvDIIDnVQIu5saZDVPo2ZxEklE
	0k+ALUxfBKBGNthvnlOSp2r7PvqsHvlo5NVu04kKJHiC6Z0vEA700qIBhUjxxHaCIbLfSOy/cdi
	J/B0sJQdbaGl2rOMyqhKGF3Jo12rXwnbomi1TAqY7Y/+G8BEwMC3IIAC/3ETEj+bdOOOFTmGkSY
	Qx7QcHYFQIXGzdOD+E2JahMPbiA5e2xwTZcP4f1Zxsyl5RNPkreKD
X-Google-Smtp-Source: AGHT+IEo+hlZvbxkNeRGx3kYoxJtFh++ApszonB41Wh2Hvqi74i+5EjVggdjDomEooqVMDhisQDJkQ==
X-Received: by 2002:a05:620a:4487:b0:7d4:4004:307a with SMTP id af79cd13be357-7d4439505f4mr196626385a.29.1750981537366;
        Thu, 26 Jun 2025 16:45:37 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44313695dsm56555385a.1.2025.06.26.16.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:45:37 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 91367F40066;
	Thu, 26 Jun 2025 19:45:36 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-01.internal (MEProxy); Thu, 26 Jun 2025 19:45:36 -0400
X-ME-Sender: <xms:oNtdaG9QMKqXLvt4edhTWTnE6IeCv3pSOBzmcadQuB8TGMymlk4uyg>
    <xme:oNtdaGsVII8PhvoQO6jFD9d0z_f3lzhGOFKwpee9EYDJMmHD-qE97PkcdrjWoMGCy
    bIN96Q4MS5PCnbJCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheefucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:oNtdaMCY60Pu_sE1pTGglxVl_nEUCW9riLTy5RpSU25_iZ0XxB-yrg>
    <xmx:oNtdaOf1byy9xHqilTNyrGeBOhEK93kz9mBDt8L3mRUORIc3il9lxg>
    <xmx:oNtdaLMB0cHU50PFNA81yKySj5wP3ccq3WYRh0UiL9wEowikrdqi6Q>
    <xmx:oNtdaIknb5kQNkIMQ6uQV5hO5wCqvIX8J8tHa5vOZAoKVcTOjXbPew>
    <xmx:oNtdaNt8wuTHMpMoMizAClssb3ClQdu_KS1fxhMyDrQ7wdRg-sAYyDDC>
Feedback-ID: iad51458e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 69B2A2CC0081; Thu, 26 Jun 2025 19:45:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T383afef5f8ca9bad
Date: Thu, 26 Jun 2025 16:45:15 -0700
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
Message-Id: <8922f6f0-241a-4659-b382-fb8c62b77e8f@app.fastmail.com>
In-Reply-To: <DAWUY4YH6XP9.TWAP6N95L5BR@kernel.org>
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-5-dakr@kernel.org> <aF2rpzSccqgoVvn0@tardis.local>
 <DAWUKB7PAZG1.2K2W9VCATZ3O0@kernel.org>
 <45a2bd65-ec77-4ce7-bd8e-553880d85bdf@app.fastmail.com>
 <DAWUY4YH6XP9.TWAP6N95L5BR@kernel.org>
Subject: Re: [PATCH v4 4/5] rust: types: ForeignOwnable: Add type Target
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Jun 26, 2025, at 4:36 PM, Benno Lossin wrote:
> On Fri Jun 27, 2025 at 1:21 AM CEST, Boqun Feng wrote:
>> On Thu, Jun 26, 2025, at 4:17 PM, Benno Lossin wrote:
>>> On Thu Jun 26, 2025 at 10:20 PM CEST, Boqun Feng wrote:
>>>> On Thu, Jun 26, 2025 at 10:00:42PM +0200, Danilo Krummrich wrote:
>>>>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>>>> index 3958a5f44d56..74c787b352a9 100644
>>>>> --- a/rust/kernel/types.rs
>>>>> +++ b/rust/kernel/types.rs
>>>>> @@ -27,6 +27,9 @@
>>>>>  /// [`into_foreign`]: Self::into_foreign
>>>>>  /// [`PointedTo`]: Self::PointedTo
>>>>>  pub unsafe trait ForeignOwnable: Sized {
>>>>> +    /// The payload type of the foreign-owned value.
>>>>> +    type Target;
>>>>
>>>> I think `ForeignOwnable` also implies a `T` maybe get dropped via a
>>>> pointer from `into_foreign()`. Not sure it's worth mentioning thoug=
h.
>>>
>>> What? How would that happen?
>>
>> The owner of the pointer can do from_foreign() and eventually drop
>> the ForeignOwnable, hence dropping T.
>
> I'm confused, you said `into_foreign` above. I don't think any sensible
> ForeignOwnable implementation will drop a T in any of its functions.
>

A KBox<T> would drop T when it gets dropped, no?
A Arc<T> would drop T when it gets dropped if it=E2=80=99s the last refc=
ount.

I was trying to say =E2=80=9CForeignOwnable::drop() may implies Target::=
drop()=E2=80=9D,
that=E2=80=99s what a =E2=80=9Cpayload=E2=80=9D means. Maybe that I used=
 =E2=80=9CT=E2=80=9D instead of =E2=80=9CTarget=E2=80=9D
in the original message caused confusion?

Regards,
Boqun

> ---
> Cheers,
> Benno

