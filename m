Return-Path: <linux-pci+bounces-26817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE733A9DC53
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 18:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063261B63D2D
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 16:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9405925C829;
	Sat, 26 Apr 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoooCYhE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D512E7F;
	Sat, 26 Apr 2025 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745686504; cv=none; b=KHbZu37svgCpcI5VaHY5DZFPybJmpbEi1giQ5eR6jSWtuuXyUzwos8fI4DUxHX2xYcfjNwBvAO0pXTpuOq6WsART007fwal0MFhB7/EU0NdC+XesKwXFvZI17OXX53rs2Jpi5dNggASKL6rgnie99+fjq15WIPumcth5cejsrtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745686504; c=relaxed/simple;
	bh=pTb+imELWEoiiCJWiJ8ZEvNP62cub7dfELump9pY29Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4J5I/KLVZsbw6+BKD/bmtHTngkLT2jOuwKEqEXA2yJc1lEA2Niz81+mHLtAtJ7iq/AJ0eDtMkUitj6EAgz8DtX1PzogAFj5IMMcOJLF0vs6NAnOxs0BuIT2bAPvzEMXPZD+cpmVgG9Y9PiiGamgHNZAyVttVP7XFOIHQJH4JEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoooCYhE; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4774d68c670so58493091cf.0;
        Sat, 26 Apr 2025 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745686502; x=1746291302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MW9WWUb46PLlxl+QlQxiDPJ4639YRrU8DuLI799K4s=;
        b=DoooCYhElLI/4cC6BtA1yOJwtUv3iZw0/smhZUG87nD97PeDEDQQYa4/AosoqPCGG5
         NDJAayw5E8JXktiVflOa2MiQOwoyhHtDk2sZWQVRmAA+/pLF1D+22Z4Af8asdh5FQPT9
         NEbfo16EvA/5E0J1hFCMRS7wvnLIX1f8K20p2CNXgZ9klWXYEdwrA/VhwjoPRfGTDp8q
         54WGxhpGwIWU3IbDW9ArGzu4jjc9ClPlhcXJoeSzBiBgG1vlNsu6FRj15yY+DtfIMf5o
         L33xG2sWCHKf4RuPA/HB6gg5Q1x05EN1Z+u3ethuvBlUH9JXk2nyaCP32CaSFvF6H3rd
         Dinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745686502; x=1746291302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MW9WWUb46PLlxl+QlQxiDPJ4639YRrU8DuLI799K4s=;
        b=EzSu1bh7JakWaWxcbruv7BdCYcAMeC9vZONEtH+BKhTkNwBsuBXezdj68qWZXCB8M1
         w4acXNHS1kZv69X8AzH4LTl60RtoVkMyOmp/ULRtXzd9LyXP5Xk4LMwGN04cIM7eR/wc
         wYfsQhTW3vT8hUkrP8lz50QR4bRrMI6iHN8qoodg96TQa/YIoQz7AsMoOsbS4fPs1myi
         5Ck5pJ4cBZ2WaEBmAw4PZhAXIzO20dKMMEoKL6G1C4ysdJK5SG/c9KHAILTsn3wcQUrr
         JggTWCndfDkY4dX5qqaoltc5IRKHIkbMsGFl6ovN11ZT52wSxYAciGLp3aVHS0lVpNVb
         P+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy9b2Vmkv9DmWhj+CUELuMQj2sogwlgJ58zo2EK9Xs2TMdgWbuZgkbA4X7D/Kcg+8XE69q2zmiBBuz5Wzr1Pw=@vger.kernel.org, AJvYcCW4/vWeapLrgO9XLS7lO7gcfE+KhCDMqkfW8ENzfMdR2J9XSEP3MpBS+d4hoqLw8tEO+WYdmN+gPfPkUuc=@vger.kernel.org, AJvYcCXmA1sxHBUW9NCyJDbthBZTYU0rfk678velTIA2KozXqB/4/d+i6wY6eI/eX+OLzekJcVjudyRF54Vz@vger.kernel.org
X-Gm-Message-State: AOJu0YwIsBY6Ry7la1VTl8el2KQEgaMfr8IOnKSNchtnEbYT031mx1Hv
	kePI2znLEknKdfN75l1URRmS+/S7PvI5J7uZMYx749EbnCZa2FOV
X-Gm-Gg: ASbGncvG6T5Hxyou4PnctoFp+QFysbuj6oTtKnWZqY3O7BHKs5t4TqNvhXZbO8GN+z/
	X+wQ8FwhXxNLLH23GVnCx4ddHaY71z0PHjmcclO3TRR4r1KXvZCYqjRDwD0tRW87xCH02uz5YBs
	znGHVdpDeAGNg3R3V6jLSySA6KOWc180tqzJQDCeCuaESFtOMQl5C4tLnBAY/O7FSBiVBuJL9MV
	E+Rvza8f1fFTAV9UDQtpQRArEXFEFDyC4s4BtybnBlJxBkbd5h8tFVFT9h320umqki/vDQOwf6G
	2Bw8Rg61OM+xJc2LuEoILSoz+2eo+JhXbh7qn2sOd8ZuJeVoTgkrDDJ7vmbWxuka76aOAkkLgC2
	Pf3/Yb7g1IyXDA4HFSCAq10kdKBvaAog=
X-Google-Smtp-Source: AGHT+IGeCFQXa3o0jz77AIwE802+C0Hyjz1gRI1PHcPUcQm66I5JkOtymJieWHl+HIMb+Rj1/GOWFA==
X-Received: by 2002:a05:622a:1350:b0:47a:fb28:8ef0 with SMTP id d75a77b69052e-48131de3b6emr55132531cf.29.1745686501706;
        Sat, 26 Apr 2025 09:55:01 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ea1ba2868sm40700351cf.74.2025.04.26.09.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 09:55:01 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3EF4A1200043;
	Sat, 26 Apr 2025 12:55:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 26 Apr 2025 12:55:00 -0400
X-ME-Sender: <xms:5A8NaFzyyzGyLgRZABFX27JaIe4e53d1YcOXW1iakjDmNdMt4uoIQQ>
    <xme:5A8NaFT1Wuydfd_kNNGk2cWaC5m-B2Bz7Q3FY7rbnUUrjMV8hpeR0BG1VNKwDH4B-
    HI3anSZjP1MsGl6GA>
X-ME-Received: <xmr:5A8NaPVE9FNuIE0RwNSQizuqhuc0enqgsWAUHWVkcOAgOnhE5jGFt9qI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheehjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeejveffleefvefgudejieeffeeklefgleeh
    heehvefhgeffkedvhedutddtjedugeenucffohhmrghinhepthhrhigprggttggvshhsrd
    hmrghpnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    sghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtie
    egqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhi
    gihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheptghhrhhishhirdhstghhrhgvfhhlsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslh
    hinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkfihilhgtiiihnhhskhhisehkvghrnhgvlhdrohhrghdprhgtphht
    thhopeiihhhifiesnhhvihguihgrrdgtohhmpdhrtghpthhtoheptghjihgrsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehjhhhusggsrghrugesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:5A8NaHjmtIEOjcK2IPF9_LnfEfJP7RfGrns0c7BW3UMdZ1Y9oSlCSg>
    <xmx:5A8NaHC1-YNJ_XNICv9g6uBXV5gCz_jobNBkDrUf8yb5FIr9X-JC4A>
    <xmx:5A8NaAJ9e24vAFhGRWLTDDNG3m9CeXpqy2DWX4mryH5NIxXGch_mtg>
    <xmx:5A8NaGCXWWlJPb_nYLrxsfHzwR-j_pC-alunBH-qF1PhRLEkUp75ZA>
    <xmx:5A8NaLyAVi61T_Lb6QMH6GiU8MqzD8ZtN5wfgHm5czSnefgmbJSBiIys>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Apr 2025 12:54:59 -0400 (EDT)
Date: Sat, 26 Apr 2025 09:54:58 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org,
	rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	bskeggs@nvidia.com, acurrid@nvidia.com, joelagnelf@nvidia.com,
	ttabi@nvidia.com, acourbot@nvidia.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: revocable: implement Revocable::access()
Message-ID: <aA0P4lr0A2s--5bI@Mac.home>
References: <20250426133254.61383-1-dakr@kernel.org>
 <20250426133254.61383-2-dakr@kernel.org>
 <aa747122-fc78-45db-a410-ceb53b4df65e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa747122-fc78-45db-a410-ceb53b4df65e@gmail.com>

On Sat, Apr 26, 2025 at 06:44:03PM +0200, Christian Schrefl wrote:
> On 26.04.25 3:30 PM, Danilo Krummrich wrote:
> > Implement an unsafe direct accessor for the data stored within the
> > Revocable.
> > 
> > This is useful for cases where we can proof that the data stored within
> > the Revocable is not and cannot be revoked for the duration of the
> > lifetime of the returned reference.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> > The explicit lifetimes in access() probably don't serve a practical
> > purpose, but I found them to be useful for documentation purposes.
> > --->  rust/kernel/revocable.rs | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> > index 971d0dc38d83..33535de141ce 100644
> > --- a/rust/kernel/revocable.rs
> > +++ b/rust/kernel/revocable.rs
> > @@ -139,6 +139,18 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
> >          self.try_access().map(|t| f(&*t))
> >      }
> >  
> > +    /// Directly access the revocable wrapped object.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The caller must ensure this [`Revocable`] instance hasn't been revoked and won't be revoked
> > +    /// for the duration of `'a`.
> > +    pub unsafe fn access<'a, 's: 'a>(&'s self) -> &'a T {
> I'm not sure if the `'s` lifetime really carries much meaning here.
> I find just (explicit) `'a` on both parameter and return value is clearer to me,
> but I'm not sure what others (particularly those not very familiar with rust)
> think of this.

Yeah, I don't think we need two lifetimes here, the following version
should be fine (with implicit lifetime):

	pub unsafe fn access(&self) -> &T { ... }

, because if you do:

	let revocable: &'1 Revocable = ...;
	...
	let t: &'2 T = unsafe { revocable.access() };

'1 should already outlive '2 (i.e. '1: '2).

Regards,
Boqun

> 
> Either way:
> 
> Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>
> 
> > +        // SAFETY: By the safety requirement of this function it is guaranteed that
> > +        // `self.data.get()` is a valid pointer to an instance of `T`.
> > +        unsafe { &*self.data.get() }
> > +    }
> > +
> >      /// # Safety
> >      ///
> >      /// Callers must ensure that there are no more concurrent users of the revocable object.
> 

