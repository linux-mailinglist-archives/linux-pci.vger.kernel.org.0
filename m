Return-Path: <linux-pci+bounces-30840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E646AEA89E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28394E2BC0
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 21:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D173A21884A;
	Thu, 26 Jun 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wpa+5aA3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB761DE4F3;
	Thu, 26 Jun 2025 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750972610; cv=none; b=awFCPzl/bGn5TmhWBweW4fXqgkeYaZjFl45dJPkryTfu7305oWDqOERZo7wTroEsux5KtP7r5yAW6ggn6qSm14Qg43FScfcxzy5KHOt9uMn7ptcsbhBknePhg7pG74E4ej9RyvY4mz1AC/ZONPggjjcT/Z8pKKvILub/omvtdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750972610; c=relaxed/simple;
	bh=gB1D+i614hMsNCN+9Dr4ELv/AgWCJ6yYLGZWwiIz7XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEYrYpGzPO3Q3ZNd/mlc1+TKejgRR6RK9ugSPjNHYtbgX2/9dVG0MqnyCjNftJ2REQw575C9TlJmxZ4vmT16cAA0vX6oZnWklPaMdWDuPVI1OPpMB30IeSP+8S4ngXw84wWPWIx0LEye+0z7iEbGXRH/5m+p8JkrgeHRmcIJh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wpa+5aA3; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a44b0ed780so21619441cf.3;
        Thu, 26 Jun 2025 14:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750972608; x=1751577408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLVom/J/+xLOTCVxjDew0IkUWGcOk1+WeSaRra2z6nc=;
        b=Wpa+5aA3NYhDTKjQjYagQeeyArz27YYglvILZ2DKcxhv4U33IFMP/L+gSt76zF9aMW
         6MkewdcKeRNE4iQREL3pCHnNrN+ypl6+eLOJPNbH9Zg4XrhHuvA+mcuSZ+wrBvdFcjBY
         ZrY8//tOjb29hyY3in76xtyy3tBF++w+vKfg5CAKLqOP5ywRCPIl192nOUZq2IOOnTO+
         rnjlseAV6+O0M9R69x54P80YGiqAiu8zmkys6m1EvVtDkL2lTqNXE3tKFGRa9OCdJPym
         vFqmsVWTdygtmgBEv75FhWr0OKdKCd9iEcSzNrHo9RKpWq/RVFpKz8q7+zZkQJxxHnkZ
         78dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750972608; x=1751577408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLVom/J/+xLOTCVxjDew0IkUWGcOk1+WeSaRra2z6nc=;
        b=pIT+W1Cson4A1Rtr1rIIfmu8rJXakFZ5TktL6Cq8v9NY8q3r5bwZDZDix8c9kydHJb
         fS5Mj28wDr3cMm6PEo5vGqOeRhpzczfP5bpitmDlIUoPKlZADifYTOA5G66EJiU0euAL
         QA6W4KsGc/T0XFZFyhUbERnSD74jITM8P9ajNxAAXXa52g0cePQsf9ufXv0djKvDN5UN
         I0bLFGXNYt6hLlmcocDYTts7n0QAd9qxaSa6qGH+ziYVEx/2MIul5OC8R1lTrpY51iyc
         MJLSszL5WEwxjoNXWoUzGFvz1l6YAWScroNEZTqiJ3hKH6lWNlnvnjg1YF1hlh+AS+3X
         YQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCVV+BL6WW6X1oElOZqNoC4afNc4Fi2sfkZqs9D4RDAiThXQOaZ/RSaYyB5xzG5pquGYD4cY55eJqr0mGlzQZGk=@vger.kernel.org, AJvYcCWM4c5Poj7stfN640wWjGXsdCg/eGSgCaRw9WdH1eGEIx3F58FsSwrsDyVTwN/RkxRmGKvzPosCK6Pp@vger.kernel.org, AJvYcCXGRX1caGmi3bXwbzCNSXKwAe9O9kVl+gKwxMzKLfNSMFVqboXzIriBZTzFPTkBLug5c/u+msNeMwkGEZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7W+XbNbBpqAsYPRiTF5DSd+lJ+3s6Wparv+as5xlIXq5GCmvH
	oAm8CTT5WEvy4Ia63iK6iijdeRxuLUMmRvHAmwSbiEinvSEOzyHdUzxg
X-Gm-Gg: ASbGnctyC0XghC+XTmTx9E9FZHo0DYfnGnVHna3OmDqRPx/13TJvsJiLxfp7HmGq/bT
	04JyT1XE50e/gqKFLgnLL8HUdDX54r5rrupGzeKQDAzoNErv0qePhMJL+nAxsw2hH4YDFSnssc2
	qyM0Sani5Bt72I+EDi8NsU7HnRXBbY3pH30hH3EdP8TIOYSaBbeqyDCyBAROghK0ypXjjfDMJtN
	q/rXoUJHPvLptCJRHhky70s5xq6DW6/SErQyzFdWsHplq/Uk5CgisaCs7Mwuxkmo0Y4St9Ze8FY
	o1/QMEUtgBdnI6kd0J2d/Ytvd7aClbU5vT3ZF1QzSxCZn0nMnP+IKrIcE+hjGXbe2raLxfDwylw
	Rs8AQ/JCJsTazs8XVs4gIVSKUJ78TXAc4ytcJ5wbLuvqH1MUJOtHt
X-Google-Smtp-Source: AGHT+IGK0mlIVMvvN9i1ApnC+zTrHWTgkdGk4i22vkdNoAEbMAYTTStF/w6jQXdAMO/OxCFhlWNqnQ==
X-Received: by 2002:ac8:58d2:0:b0:4a7:693a:6ae4 with SMTP id d75a77b69052e-4a7fcac6e11mr20292381cf.28.1750972607847;
        Thu, 26 Jun 2025 14:16:47 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc55cd14sm3750411cf.45.2025.06.26.14.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:16:47 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id BEA73F4006A;
	Thu, 26 Jun 2025 17:16:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 26 Jun 2025 17:16:46 -0400
X-ME-Sender: <xms:vrhdaEu1cXjI19yYxBLKWK9R5RsSOCdjPkfDISWsmqMhgQuiiJoX3A>
    <xme:vrhdaBevZeRaVAErv0RjvBTt736uhAFSDRh-zk9mxLZwk0Nf6YVNVTEduE9ncelBo
    Tng8QHetl305owT-g>
X-ME-Received: <xmr:vrhdaPyOLu0fBWAINanrqVnpaWC5zAdv-hf672bKoHqkYqssXfhqZESrmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlih
    hnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgr
    rhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhroh
    htohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vrhdaHO1fG4JtQwkX4AxknMPrKVxmSPUgTYHjOJReapxWX-ht-PRzA>
    <xmx:vrhdaE9YZlJcolxSP4I5h9pZAu-WDJiuMfZsat2YRdvfytarXePw-Q>
    <xmx:vrhdaPUvpXQnYMnjB88c7gEr3I5Q4pEatQAxz1YpmxNB-HLwbVHZSA>
    <xmx:vrhdaNca5TG0eTw2Ob1kfOYnXtZX7mUp2nfgUWmtIZaTa-QfGFr00A>
    <xmx:vrhdaGdkjk21FkxXc7gGp9Ogax5eZhjS9f58wgRulwbCC0CnZpoFZajF>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 17:16:46 -0400 (EDT)
Date: Thu, 26 Jun 2025 14:16:45 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/5] rust: devres: implement register_release()
Message-ID: <aF24vbtHgP-kYuBg@tardis.local>
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-6-dakr@kernel.org>
 <aF2vgthQlNA3BsCD@tardis.local>
 <aF2yA9TbeIrTg-XG@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF2yA9TbeIrTg-XG@cassiopeiae>

On Thu, Jun 26, 2025 at 10:48:03PM +0200, Danilo Krummrich wrote:
> On Thu, Jun 26, 2025 at 01:37:22PM -0700, Boqun Feng wrote:
> > On Thu, Jun 26, 2025 at 10:00:43PM +0200, Danilo Krummrich wrote:
> > > register_release() is useful when a device resource has associated data,
> > > but does not require the capability of accessing it or manually releasing
> > > it.
> > > 
> > > If we would want to be able to access the device resource and release the
> > > device resource manually before the device is unbound, but still keep
> > > access to the associated data, we could implement it as follows.
> > > 
> > > 	struct Registration<T> {
> > > 	   inner: Devres<RegistrationInner>,
> > > 	   data: T,
> > > 	}
> > > 
> > > However, if we never need to access the resource or release it manually,
> > > register_release() is great optimization for the above, since it does not
> > > require the synchronization of the Devres type.
> > > 
> > > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > ---
> > >  rust/kernel/devres.rs | 73 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 73 insertions(+)
> > > 
> > > diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> > > index 3ce8d6161778..92aca78874ff 100644
> > > --- a/rust/kernel/devres.rs
> > > +++ b/rust/kernel/devres.rs
> > > @@ -353,3 +353,76 @@ pub fn register<T, E>(dev: &Device<Bound>, data: impl PinInit<T, E>, flags: Flag
> > >  
> > >      register_foreign(dev, data)
> > >  }
> > > +
> > > +/// [`Devres`]-releaseable resource.
> > > +///
> > > +/// Register an object implementing this trait with [`register_release`]. Its `release`
> > > +/// function will be called once the device is being unbound.
> > > +pub trait Release {
> > > +    /// The [`ForeignOwnable`] pointer type consumed by [`register_release`].
> > > +    type Ptr: ForeignOwnable;
> > > +
> > > +    /// Called once the [`Device`] given to [`register_release`] is unbound.
> > > +    fn release(this: Self::Ptr);
> > > +}
> > > +
> > 
> > I would like to point out the limitation of this design, say you have a
> > `Foo` that can ipml `Release`, with this, I think you could only support
> > either `Arc<Foo>` or `KBox<Foo>`. You cannot support both as the input
> > for `register_release()`. Maybe we want:
> > 
> >     pub trait Release<Ptr: ForeignOwnable> {
> >         fn release(this: Ptr);
> >     }
> 
> Good catch! I think this wasn't possible without ForeignOwnable::Target.
> 
> Here's the diff for the change:
> 

Looks good to me.

> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 92aca78874ff..42a9cd2812d8 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -358,12 +358,9 @@ pub fn register<T, E>(dev: &Device<Bound>, data: impl PinInit<T, E>, flags: Flag
>  ///
>  /// Register an object implementing this trait with [`register_release`]. Its `release`
>  /// function will be called once the device is being unbound.
> -pub trait Release {
> -    /// The [`ForeignOwnable`] pointer type consumed by [`register_release`].
> -    type Ptr: ForeignOwnable;
> -
> +pub trait Release<Ptr: ForeignOwnable> {

My bad, is it possible to do

	pub trait Release<Ptr: ForeignOwnable<Target=Self>> {

? that's better IMO.

Regards,
Boqun

>      /// Called once the [`Device`] given to [`register_release`] is unbound.
> -    fn release(this: Self::Ptr);
> +    fn release(this: Ptr);
>  }
> 
>  /// Consume the `data`, [`Release::release`] and [`Drop::drop`] `data` once `dev` is unbound.
> @@ -384,9 +381,7 @@ pub trait Release {
>  ///     }
>  /// }
>  ///
> -/// impl Release for Registration {
> -///     type Ptr = Arc<Self>;
> -///
> +/// impl Release<Arc<Self>> for Registration {
>  ///     fn release(this: Arc<Self>) {
>  ///        // unregister
>  ///     }
> @@ -401,7 +396,7 @@ pub trait Release {
>  pub fn register_release<P>(dev: &Device<Bound>, data: P) -> Result
>  where
>      P: ForeignOwnable,
> -    P::Target: Release<Ptr = P> + Send,
> +    P::Target: Release<P> + Send,
>  {
>      let ptr = data.into_foreign();
> 
> @@ -409,7 +404,7 @@ pub fn register_release<P>(dev: &Device<Bound>, data: P) -> Result
>      unsafe extern "C" fn callback<P>(ptr: *mut kernel::ffi::c_void)
>      where
>          P: ForeignOwnable,
> -        P::Target: Release<Ptr = P>,
> +        P::Target: Release<P>,
>      {
>          // SAFETY: `ptr` is the pointer to the `ForeignOwnable` leaked above and hence valid.
>          let data = unsafe { P::from_foreign(ptr.cast()) };

