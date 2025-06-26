Return-Path: <linux-pci+bounces-30871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6CDAEAA7E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 01:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0A51C27558
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951222541B;
	Thu, 26 Jun 2025 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5Humiyy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369522253EE;
	Thu, 26 Jun 2025 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750980090; cv=none; b=MkOYgIDjQH8h1hsMs8fzb9YFwqXh3WnundtTzoghs9WJwVhgZa1OzmUtRApCkHi/QMHVrzMkEHuXdcHsR8lqJiL8NwSlYF0y4O7T+1cgF3VKqVSaT83M9MiWLWYQyQdIoN9RK+ovVCBfEoek1AvK0ul93yYQNLFYhETt3h60LeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750980090; c=relaxed/simple;
	bh=MUQuxc+UR436Ky0F8krnASl8Mtb6lTMYurVT5poi8Uk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IBVSzE8ql+nPuMK8akImxeUrnONzavLqNy1ZchBK+Bc1HDkjjzAiou7/km8veSHu7ZohrZ46PknKNW/rHnPVcWhboVpFx399IELRFruvZ9SbbjLGDUBv4ayOasn1v+qSF9AfrIYRuMimLA9R837/CnMHkdRoqqG4Vf+loWUX2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5Humiyy; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a43972dcd7so21189001cf.3;
        Thu, 26 Jun 2025 16:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750980088; x=1751584888; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYsFIPhXPnoltKwvWFJRYtiFcpuddCIPVvkRInsQYn4=;
        b=E5HumiyyvmyAtA+FsG8U345Mu+0Bnt9mAuCNoHY5Q7J9PQ2ViDz8veCTqGuhQd7PuY
         CR/mcXVb2TgXk9X1Sen2Yf6myb1ZDLxCWm6PXIb59UXx9KUld0R/+qx42zAqNDP3fhd3
         yfw4vfcQJOsoi15v6/mMTmn8ztVCm4rGzhSDS6jNeyyuFWOli/3Ry+70LBVcXdRUEHl8
         LT2uFOQ/HlxYVZAsArIKDuDlXwj/SUb2uIroyVx41lH1QhIqqZ1rYi1cGuaYlrhrRXuM
         ukGhlddxJVD8lMnYI8tdF7ZXqvMKVsul+EzqsIg5Dnh88v/rsm0TDJLFOWDi0pLm4V0h
         r4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750980088; x=1751584888;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pYsFIPhXPnoltKwvWFJRYtiFcpuddCIPVvkRInsQYn4=;
        b=uWwX6VdETm1wIajQTzHGZemtQVpYAP290PVz03oUcEAcO2a3INV/0V2vOoTpQRYRnk
         HIX2BD8HU9IWtNleuJoOvCoSBulsrtnFJPjtd7rzdqkkRAcVrW/USfLHQLx2XzlhK/WQ
         MEWQrNE3UNPQQv3YtnjJgEgr56t5UOVEmFsX2o0Ri5dcRPqjwjQ2c3YVsocfJJ4d+UFs
         z2zyroMttA9Pqu82xhpBlINpKI9mYJe7v8Ym/UE5ZQPkXAFJhbtq2M8qUe5iSAeXcFNk
         04uALPoDUpa5JU568H8QPyTaWlG285X9b4FV1GcN/SsoImZlSquGQBpq+4395kcZpM07
         sw2g==
X-Forwarded-Encrypted: i=1; AJvYcCUJCnF/npb+TZrrz6IJgzveoS2VuiDS/84AxOEZFCqb8X8kBMhlhKo6AbJqSDlmDuweNVp3RplS6S66R3Y=@vger.kernel.org, AJvYcCVCdXfBm3UjafZdko/b6psiJPz8aEDz6l/Z9g5XoE4nHP+BSsCC+vvYczwIymPkej+q8wk1qKJE0i2A@vger.kernel.org, AJvYcCW8DuvJMTsZdBjz7EU/aGhROixWDwLo56zOin3QUbyFUH23Lk7lbkeQSd93c2GJwbIdOvlegRaFOhoDD1iZMnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFZEi2j5fFKacOF4+tmqZBEvFfWD0XvBd1lv+YYsdQpvew52d+
	ELH9xNQIwNH0OkREUMynYwZ1c1RsPp2TtSzTdjQ9jokWhZ6dOXCvLfn9
X-Gm-Gg: ASbGncvNATGWfs5dUPKE3jZ2bX0F5xHhFlljudYSFrjtIMGWFqd/w85yv8O6sw67KGy
	eKuVa047AuppVO/i17Ha83xWBEvneCB/rbKKUoAZqGISp59yEX3JDDSzv6PpFOyVJf5CAg8Unil
	FdVrYMNkTMs44rtwvd/HY9JG4RK19914uuXR3w+hR7JTiJJzBy+eCYK9e7Z/3R+UY9fjEbuZwCH
	+btPoXTyzp3APutJ0yUcyBO/eKl/On8EnuYu0HlSg5DWYxDd3/kUfAbclLj4zvHuRVG2GmjmZ/L
	1k27Xs/1VMLcFIwr7LLYiDcA04Tjlg9gNXF6Q1Dx3/HFtdjIgv/vG/T6k+u0vmm7P3idFmyW0Lg
	inewrGZSG3VlH5uy/levHmJuHnV2Z+ip8WEp0cC5Th9whbps19Rql
X-Google-Smtp-Source: AGHT+IEOxDn+OPKzlzICpXuNvIhC8lx2kx9VF0Em1sA2dl52YtaECjSzi/NXzxO3qK+z+2GJY1HCxw==
X-Received: by 2002:a05:6214:c48:b0:6fa:a724:8769 with SMTP id 6a1803df08f44-7000291853fmr23603726d6.35.1750980088000;
        Thu, 26 Jun 2025 16:21:28 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd77313b17sm12554236d6.118.2025.06.26.16.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:21:27 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0D9E8F40067;
	Thu, 26 Jun 2025 19:21:27 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-01.internal (MEProxy); Thu, 26 Jun 2025 19:21:27 -0400
X-ME-Sender: <xms:9tVdaJxqfimweDHzK2NKKcsFvy8f6XXAtigol5ojAVn6HzPGahTE1w>
    <xme:9tVdaJSoYRYfYvfBaDICEFaFMiocfsUcdDKoJGxGdtIsMVjog72yiW-j_ZRdNAYZj
    R1jup8uMPeGvaFnBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfuehoqhhunhcu
    hfgvnhhgfdcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedufeelfffghefgveejteekvedtleegfedtkedvieekgfffleelkeefhfef
    hfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
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
X-ME-Proxy: <xmx:9tVdaDUX2vx94-SE50Zd2Gx5UTgUZANuRllkfF7t7jx2YZjfoq1vSw>
    <xmx:9tVdaLjrdDk_5X0Ca2gmJaf_iu7oLS9up1Tn2snZIqMcl1NX3tldEg>
    <xmx:9tVdaLBxc5xL2HXBHUd0RwSahhK1vS78ear6B4tgPR4Pmup6EghhDQ>
    <xmx:9tVdaEIkckTjblJ9KaKIoxkQJPyFRVvjLw7I61szs40zZzzr8fIz-A>
    <xmx:99VdaKBNosySiQiicLmujObICC5sCqRgUhlyhCzip4LGdZs6DkKi6v4t>
Feedback-ID: iad51458e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D544D2CC0081; Thu, 26 Jun 2025 19:21:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T383afef5f8ca9bad
Date: Thu, 26 Jun 2025 16:21:06 -0700
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
Message-Id: <45a2bd65-ec77-4ce7-bd8e-553880d85bdf@app.fastmail.com>
In-Reply-To: <DAWUKB7PAZG1.2K2W9VCATZ3O0@kernel.org>
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-5-dakr@kernel.org> <aF2rpzSccqgoVvn0@tardis.local>
 <DAWUKB7PAZG1.2K2W9VCATZ3O0@kernel.org>
Subject: Re: [PATCH v4 4/5] rust: types: ForeignOwnable: Add type Target
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Jun 26, 2025, at 4:17 PM, Benno Lossin wrote:
> On Thu Jun 26, 2025 at 10:20 PM CEST, Boqun Feng wrote:
>> On Thu, Jun 26, 2025 at 10:00:42PM +0200, Danilo Krummrich wrote:
>>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>> index 3958a5f44d56..74c787b352a9 100644
>>> --- a/rust/kernel/types.rs
>>> +++ b/rust/kernel/types.rs
>>> @@ -27,6 +27,9 @@
>>>  /// [`into_foreign`]: Self::into_foreign
>>>  /// [`PointedTo`]: Self::PointedTo
>>>  pub unsafe trait ForeignOwnable: Sized {
>>> +    /// The payload type of the foreign-owned value.
>>> +    type Target;
>>
>> I think `ForeignOwnable` also implies a `T` maybe get dropped via a
>> pointer from `into_foreign()`. Not sure it's worth mentioning though.
>
> What? How would that happen?
>

The owner of the pointer can do from_foreign() and eventually drop
the ForeignOwnable, hence dropping T.

Regards,
Boqun

> ---
> Cheers,
> Benno

