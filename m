Return-Path: <linux-pci+bounces-30830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FB5AEA849
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D043A4A356D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6972EF9C5;
	Thu, 26 Jun 2025 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNSIL/Qf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0D92ECEB9;
	Thu, 26 Jun 2025 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750970248; cv=none; b=G4FGHZ4wmRK//4RJDFUd7Az18I8h1UprgL8MvMovUSXaDMAomZ+3zLP+D77W2kIuQsCtlmEYQ+q7h/M1xMAwn4zPktQ6IifEV3rYxvPhigJlb9fKbIdhZvXEmdmPY/qmaliir9L9eDqXTCxmkzdYh6/R2IbPI9bPZ9eGG8rhvTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750970248; c=relaxed/simple;
	bh=TjETarpWW8rD1QojqRu8kZpa9Wzk7eJudQD6rpxZgjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nr1cU+UWgIkTSbnJiVpp23xUI/Melhmeq9eAtz9o1abfuhPuDhjNSwDvncskaYcesR7wYuE/0pjqJXQFWM4DEbcWLhcDv//wBaGwW1qug3Ljfgkygo731FlTbbUZXwxAqWt5OQxxpTwuj3OxqqpF0MmjfsTiIurFk/xGidulpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNSIL/Qf; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6facacf521eso15402266d6.3;
        Thu, 26 Jun 2025 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750970246; x=1751575046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49HOUtWYGa8Q1wPaREKsJ9GTWTJXnHxy3/BYMvp9qZs=;
        b=gNSIL/QfwoocFyUZnclUd2zN6WGpvlEtqE9fIYon8kAdsc+KODsX+s8G1roynHM3+Z
         dmIQJgglHhppBcKVObdmmIwB2r3H0HC2SEGEQAKHFla8BxlSRb8Z87pY7Pf2pjx3lz9F
         H8FXFiz0aKAMKMCt/Oat+D0uSUL3IH+bSv6eD5+LzZndhSWaDSNHeZHaPcfgHXvg6L5k
         snSVShWuE8bDZofQhpGzUoWrSWaUD99ZGPtYyE+7/vnD0epTxkQ86n2I21qthmIZrm92
         BPISRP73WJHNv/1IxHOV9Vdx3vTLTwtfm5CprWktKa5/++rNqLyHnvxOhgBKRrJm/ziv
         Jz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750970246; x=1751575046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49HOUtWYGa8Q1wPaREKsJ9GTWTJXnHxy3/BYMvp9qZs=;
        b=YEOb47fuHpGw4YRFuTvciStAybA/IAif39BKQUo8zg3HdfRgi3VZCEShLHj4tAjrfA
         FqzCZHUbtBIXnHb6Eh+BhHHCmdn6FmDZIzlH97zYZ917AcynS8fzyMu8okrTnkhO8kU1
         CU5fKVPMnaCvfxDKGcUQSCMze7eV4WHlbq8wI9oWzZlidUJvRbSMVR0vxusoIAnhLj6C
         cKvzVG1xVmLtS/GLINm1YvJ2Ood0QQkzZy7ft2cDIdL09ohAtx55k04VnxP5sAjfS6Q5
         nHkdvB3957s9kJih/2kyQ7rQjAzZEN/JTfc7bdz0jvLK6fGGK+ZuGu8Vk1BO2eEcQPOu
         EVrA==
X-Forwarded-Encrypted: i=1; AJvYcCWBrh8kj+qrKaGDeLZ0REH7zjLZ3VYtlOOgPNLoY2pqf86mZey4LS40pPSlS7kVInhgrt6CwYvRRc8a8LRLOz0=@vger.kernel.org, AJvYcCWlY2M4dVCugJ4yJNfHxzZmgLFIr9LKcQtiu7YMJrtdVvdA2XppdpuIFzrht+riq7WRXRcQ1VlxWPAt@vger.kernel.org, AJvYcCXISgvb58+jEuKzTQPhz4JV0zyJs12H9E5J3MvPZ+ayo2rdvf/xaQ/DIia1+rvGPrVQF2v147OpzUKhTNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywPbfXTkvy424u0MnksJ4LfeR5b5KOK6oUe7RZDeAiPYezobu1
	eR8R7munGMhTkHlC6+c3Rw9A0GKkmpwWmYA6n2rSpGBfrKvO0DdR85bZ
X-Gm-Gg: ASbGncvZTvmfHTv9LwFlsdf79bFZHpGWk0lgHc/K1z27Ru/InAUtUzPebsRoPh0/FAl
	UbadzFJFjDqJ1OWPIzqrSlNeRGFZ+Sx9GEcMOIfiivmMPnJD43SPs3FauXiqxYh6tiPqFRH37oQ
	RpWE7K7z7yojQaaHCOhLviX8O34ehVkx9jynvT00qM3SK635s8pi/YQdqAuoN9FEikw2jrHeYrQ
	xvbugZHnFFEmqDkNaiyMIJm8lYE0bybUPMYHBon+Nu68NRcQxWajBj1b1O55z5dUCDpMljfbyQv
	fXjYmEGwZOuepx+2um8sLsTk6o41cZckSCMb/uhjeLDvI/0vi//mRCBAxK12FhRt2+p50Evds7V
	0+7gTcfsnBK4qUHVY75KxKVPUfr3x06uEHQDtZqeaCC1sNRbZKxmd+b9NwAuVwfg=
X-Google-Smtp-Source: AGHT+IGB9nMy7ILFoVhr0U892upEJDvEMUN1MTP8Gm1YdP6vS+3aASUQQBoY2mBI+Z8QaYjlVpHPyQ==
X-Received: by 2002:a05:6214:2421:b0:6fd:609d:e925 with SMTP id 6a1803df08f44-70003a8c137mr17456886d6.36.1750970244750;
        Thu, 26 Jun 2025 13:37:24 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771dd8afsm11480516d6.54.2025.06.26.13.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 13:37:24 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id B5971F40068;
	Thu, 26 Jun 2025 16:37:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 26 Jun 2025 16:37:23 -0400
X-ME-Sender: <xms:g69daGZtzUvkCA3l6nDTt6ZH4wUngMhGHvNiTTeHFo9OihMatalUSA>
    <xme:g69daJZUv2zANHnLxvnJswv_Yr_NkE2rdodO1hFbGxnw2qmAfiP4gYe9lTURnXQJB
    yhyPI9Ua3IkyUVLFw>
X-ME-Received: <xmr:g69daA8gHjnsu4xZRI83ckkkmcFxjbafCePXRuAedkHvFBhyMLHwPa7GMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:g69daIqMWDclFsqFfQbaBde1LUxsxtX4xIRqZ3RXEWIc7LdifyS8jg>
    <xmx:g69daBqXc5aPyVRV_ohpjhCmbtYNzGK1IJa17hw7IXUW6GGAru-uPQ>
    <xmx:g69daGRO10EMAESCPC7izUz5rcO3EhSf__kGstakC0j3VUQv6jBZ7A>
    <xmx:g69daBrK5-dTxvltwC8IJVfKitNVY4uaQ3xoc9L0B13Dc5I8CcIoKg>
    <xmx:g69daO417eEe24dg0zOXGXS3xZeYWySDnlXEX83PfM4okWKuj44qQc3m>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 16:37:23 -0400 (EDT)
Date: Thu, 26 Jun 2025 13:37:22 -0700
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
Message-ID: <aF2vgthQlNA3BsCD@tardis.local>
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-6-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626200054.243480-6-dakr@kernel.org>

On Thu, Jun 26, 2025 at 10:00:43PM +0200, Danilo Krummrich wrote:
> register_release() is useful when a device resource has associated data,
> but does not require the capability of accessing it or manually releasing
> it.
> 
> If we would want to be able to access the device resource and release the
> device resource manually before the device is unbound, but still keep
> access to the associated data, we could implement it as follows.
> 
> 	struct Registration<T> {
> 	   inner: Devres<RegistrationInner>,
> 	   data: T,
> 	}
> 
> However, if we never need to access the resource or release it manually,
> register_release() is great optimization for the above, since it does not
> require the synchronization of the Devres type.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/devres.rs | 73 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 3ce8d6161778..92aca78874ff 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -353,3 +353,76 @@ pub fn register<T, E>(dev: &Device<Bound>, data: impl PinInit<T, E>, flags: Flag
>  
>      register_foreign(dev, data)
>  }
> +
> +/// [`Devres`]-releaseable resource.
> +///
> +/// Register an object implementing this trait with [`register_release`]. Its `release`
> +/// function will be called once the device is being unbound.
> +pub trait Release {
> +    /// The [`ForeignOwnable`] pointer type consumed by [`register_release`].
> +    type Ptr: ForeignOwnable;
> +
> +    /// Called once the [`Device`] given to [`register_release`] is unbound.
> +    fn release(this: Self::Ptr);
> +}
> +

I would like to point out the limitation of this design, say you have a
`Foo` that can ipml `Release`, with this, I think you could only support
either `Arc<Foo>` or `KBox<Foo>`. You cannot support both as the input
for `register_release()`. Maybe we want:

    pub trait Release<Ptr: ForeignOwnable> {
        fn release(this: Ptr);
    }

?

Regards,
Boqun

> +/// Consume the `data`, [`Release::release`] and [`Drop::drop`] `data` once `dev` is unbound.
> +///
> +/// # Examples
> +///
> +/// ```no_run
> +/// use kernel::{device::{Bound, Device}, devres, devres::Release, sync::Arc};
> +///
> +/// /// Registration of e.g. a class device, IRQ, etc.
> +/// struct Registration;
> +///
> +/// impl Registration {
> +///     fn new() -> Result<Arc<Self>> {
> +///         // register
> +///
> +///         Ok(Arc::new(Self, GFP_KERNEL)?)
> +///     }
> +/// }
> +///
> +/// impl Release for Registration {
> +///     type Ptr = Arc<Self>;
> +///
> +///     fn release(this: Arc<Self>) {
> +///        // unregister
> +///     }
> +/// }
> +///
> +/// fn from_bound_context(dev: &Device<Bound>) -> Result {
> +///     let reg = Registration::new()?;
> +///
> +///     devres::register_release(dev, reg.clone())
> +/// }
> +/// ```
> +pub fn register_release<P>(dev: &Device<Bound>, data: P) -> Result
> +where
> +    P: ForeignOwnable,
> +    P::Target: Release<Ptr = P> + Send,
> +{
> +    let ptr = data.into_foreign();
> +
> +    #[allow(clippy::missing_safety_doc)]
> +    unsafe extern "C" fn callback<P>(ptr: *mut kernel::ffi::c_void)
> +    where
> +        P: ForeignOwnable,
> +        P::Target: Release<Ptr = P>,
> +    {
> +        // SAFETY: `ptr` is the pointer to the `ForeignOwnable` leaked above and hence valid.
> +        let data = unsafe { P::from_foreign(ptr.cast()) };
> +
> +        P::Target::release(data);
> +    }
> +
> +    // SAFETY:
> +    // - `dev.as_raw()` is a pointer to a valid and bound device.
> +    // - `ptr` is a valid pointer the `ForeignOwnable` devres takes ownership of.
> +    to_result(unsafe {
> +        // `devm_add_action_or_reset()` also calls `callback` on failure, such that the
> +        // `ForeignOwnable` is released eventually.
> +        bindings::devm_add_action_or_reset(dev.as_raw(), Some(callback::<P>), ptr.cast())
> +    })
> +}
> -- 
> 2.49.0
> 

