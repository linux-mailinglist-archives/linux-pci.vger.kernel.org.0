Return-Path: <linux-pci+bounces-33738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E5EB20B19
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867F13AFA08
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7865622DF85;
	Mon, 11 Aug 2025 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GatdO1cG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22DD2E2664;
	Mon, 11 Aug 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920616; cv=none; b=CqVhtzDX6GJngL5eMKwlsx6tbz2MoZk/L2+wUIq67/ZOxGlk8moIRQqE//OgrmHultzXpkZIv0WKk+607gsU9hyBbWKvrM1pDvCOwyHV+ma/obJxekY4g+R6kCxhsQTtocw7zqbtV3SnDcxRwCtJnb7nBj2aUxD0KvpmAuW3B0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920616; c=relaxed/simple;
	bh=UsLYUXKEmpDtrxFGnMoWzMED061Pyj3KjzMxEq95bVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nutQKZvs//nZl2AV71/VVCQaCePvi9blQjvJ6m3GIhXDCaRwuCx4C5/+9mg3TjimQcOc9wTgphDCWo2lUYupkCv5+Hb/b0YGAoMsXCaB6GvtwII1p7TADEqDAuqsl5lwYaxTHgWrl4B1hwWDqKMsNQEazlwjM3NBixxjSHME4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GatdO1cG; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b0619a353dso34881251cf.3;
        Mon, 11 Aug 2025 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920614; x=1755525414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcKaw7u5cl9yl5NJ5ydxA4qwhPDKsY0xBqWfCdvJ9E8=;
        b=GatdO1cG6DAVdQPaCIyx0A7dW255NAtU9DqYT87Dy39z9TI+557TKSCHoEW8Eh2Qe8
         nS4goLE5G8EESbyXuiczXgHhkFdNsWtkJDhenGIWEcMkGb106tNKJBYQus4bXu7Nm6WA
         iPCkiQhtfu65YTyLfLX0+sqFP6YKs3F/iO7xM1IFYp2+qvkxPEjMVCXcevuSSNw5qqjD
         Bqkx1MsWww50ZoV36JpR3puoQK0/DcZvGxb41YGGU7UX4ww5EASzfUVZiEacOQ3bSDy7
         mJppIHANUXYFmf+kVDBud3adQZroGpNf4mUXF1Vl4xs8wZ/IGhv5XW0sH1N2nNC3LvKK
         3uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920614; x=1755525414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcKaw7u5cl9yl5NJ5ydxA4qwhPDKsY0xBqWfCdvJ9E8=;
        b=eE94y+kdQucFDw0AAnI4WTE5vPSFQNY1q49rcf6o9DXUqtTuM9QTAm0359s49MGLBL
         hOSuSTPxJGWK2T1WDRqSFD9PZEg20NColdu1RExJAZRsUq02SIWr7sAoFi1+tYDAIlfb
         zTA0T9nl05F6Ms/Iwal5pQHe7G1MtyXYYVXsV9njO75YyvF9XJOMlHodV7KhtsLmsiYT
         LFdIRKhnmowujhBxQ2FHn42lMLq9CWs9KivAL8xM91MDLsX3A7QM7+xhnSasjFOobl9E
         ervGtsE7V9SJDSNccHHYlIqxdYffJQLcbY/9Z+OMLx7aawgHiLI0BC9F9qLnneP0ngEa
         xLnw==
X-Forwarded-Encrypted: i=1; AJvYcCU/OOFXzrF4Z30f4PqtABhGzqP+kAmyHMh+b2NRpfpxe6il054RKMY54bO3TAONqgwFIZv83zfNychZiKk=@vger.kernel.org, AJvYcCWPU0R3xgXCfsJZe2V8cm10J5Zmu1SHKbe5Bn9RQPjS6kX6D48kdKdsK4Y0ACCWt2XoVO4l2fbePLGm@vger.kernel.org, AJvYcCWcTISLnZliu8cfPyj7gu8p0vPDfGYfGoneWr6l6YZnrtDaf97PiiPkN65leYW6UCSXT+4zXsZU6Z5Imqf4Yl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv3/BA8HfzlAL5RMyGyQHt3odhZl9jjYEBvsHyIo0hS+kl4Yra
	3Ja/EcwTxas95fKzJ9X7BvBTzrNboemmrCuC+m1rhefp2iCv5FXxwokw
X-Gm-Gg: ASbGnctsen7ebBUE7IqfbSodQYIv5zhz/eFcZuukEkujoaUrbI1vuwEkXWiRtGSIUk3
	FZ7Do+SGkNRQPmjkj9hsjwxr9p2TpfJDRTCzhu/Dgs3XpIvSS0h+4wULb0ZTN74BHTWhhXZcyPu
	jxtDNhn9YUup2wiQklXen5sni1/J5qObAWb3AumKeu+P50mu59UOpCtJX3SPaAvOJYKTJWdKxIt
	Nia/6ioeHOSNvjFwNMgc8Q6PcEJcjzw17iOue+t3KwvtR5JRlGojwHHQh0VVnAQSXllyBUnM5zC
	6V1WIi+FyfL6hdcJ7iYRY1AvIOxJPhmPXZ1QP0etgSOf5iKZ9wCetFYqfQPzxocLz5jmnSyH9X9
	6+9FwaBOVDv/Ub79v717DRP8hMaeHiMblwoYGRTEBdVLor9+rfwhPfw1p0qK4s1juZhn35xp3go
	i7KF6pKPKcVmmpisMTvmjlaIuBkLv1v8Y4VQ==
X-Google-Smtp-Source: AGHT+IEpNOny78GtYin3Z9CdQL7mUpJ0txiUwOuBzB1kVUNFsbjYXSkHT3D6Q0kbVYXs3Uqc0OdSsw==
X-Received: by 2002:a05:622a:a953:20b0:4b0:80c7:ba33 with SMTP id d75a77b69052e-4b0bc71bf16mr101696271cf.23.1754920613508;
        Mon, 11 Aug 2025 06:56:53 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b069ca56e5sm102676711cf.40.2025.08.11.06.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:56:53 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 795BEF4006C;
	Mon, 11 Aug 2025 09:56:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 11 Aug 2025 09:56:52 -0400
X-ME-Sender: <xms:pPaZaI_h27NZriDfbSVevKKo2y5BoZWzsyAFd_lD4g6_M9InUCGErg>
    <xme:pPaZaHSNvyjcbXtFaKxFu5x0GZkulUy4kDH9TRGKj_wv0cd5LyCzkOvlVTJOJ_n5B
    r6J-EDJltFUgxzELA>
X-ME-Received: <xmr:pPaZaPvPeIYqpUh7wbygKsdcF1KtLRbzTTYNmNzSHSb-XeCI2kyjP7hXiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvieehgedtudfgueekheeuudethfejfefhhfdvgedtleduvdejveehveetgeet
    jeenucffohhmrghinhepuggvvhhitggvrdgrshenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    udelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhdrrghlmhgvihgurgestgholhhl
    rggsohhrrgdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhn
    fegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsoh
    hrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdr
    vgguuhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:pPaZaB5in-MZV8f6vU7DIZRuZMLZYUWCUv5GLcogrHTnrC6MIKyAiA>
    <xmx:pPaZaOLyYbkhJSEJf9q0cSMIYsCaPCBCjfmxzE_nFzN5JGbTRMQUWg>
    <xmx:pPaZaLRqou2ICYP8mMCjv8zVoq5BSQda5GBnjqEJlW9sYGzmWkIzVQ>
    <xmx:pPaZaBr-xgz-mqVj1J1Ko_yzA2D6OS6KS4lePuPeyqBBebGFhxgZ9A>
    <xmx:pPaZaJbVSTjiJSIzUAV-V0r5svy4tW9LFvJxMyC89w7I8MNGiGXisEK8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 09:56:51 -0400 (EDT)
Date: Mon, 11 Aug 2025 06:56:50 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Benno Lossin <lossin@kernel.org>, Dirk Behme <dirk.behme@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] rust: irq: add &Device<Bound> argument to irq
 callbacks
Message-ID: <aJn2ogBSmedhpuCa@Mac.home>
References: <20250811-irq-bound-device-v2-1-d73ebb4a50a2@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-irq-bound-device-v2-1-d73ebb4a50a2@google.com>

On Mon, Aug 11, 2025 at 12:33:51PM +0000, Alice Ryhl wrote:
[...]
> @@ -207,8 +207,8 @@ pub fn new<'a>(
>              inner <- Devres::new(
>                  request.dev,
>                  try_pin_init!(RegistrationInner {
> -                    // SAFETY: `this` is a valid pointer to the `Registration` instance
> -                    cookie: unsafe { &raw mut (*this.as_ptr()).handler }.cast(),
> +                    // INVARIANT: `this` is a valid pointer to the `Registration` instance
> +                    cookie: this.as_ptr().cast::<c_void>(),

At this moment the `Regstration` is not fully initialized...

>                      irq: {
>                          // SAFETY:
>                          // - The callbacks are valid for use with request_irq.
> @@ -221,7 +221,7 @@ pub fn new<'a>(
>                                  Some(handle_irq_callback::<T>),
>                                  flags.into_inner(),
>                                  name.as_char_ptr(),
> -                                (&raw mut (*this.as_ptr()).handler).cast(),
> +                                this.as_ptr().cast::<c_void>(),
>                              )

... and interrupt can happen right after request_irq() ...

>                          })?;
>                          request.irq
> @@ -258,9 +258,13 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
>  ///
>  /// This function should be only used as the callback in `request_irq`.
>  unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mut c_void) -> c_uint {
> -    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
> -    let handler = unsafe { &*(ptr as *const T) };
> -    T::handle(handler) as c_uint
> +    // SAFETY: `ptr` is a pointer to `Registration<T>` set in `Registration::new`
> +    let registration = unsafe { &*(ptr as *const Registration<T>) };

... hence it's not correct to construct a reference to `Registration`
here, but yes, both `handler` and the `device` part of `inner` has been
properly initialized. So

	let registration = ptr.cast::<Registration<T>>();

	// SAFETY: The `data` part of `Devres` is `Opaque` and here we
	// only access `.device()`, which has been properly initialized
	// before `request_irq()`.
	let device = unsafe { (*registration).inner.device() };
	
	// SAFETY: The irq callback is removed before the device is
	// unbound, so the fact that the irq callback is running implies
	// that the device has not yet been unbound.
	let device = unsafe { device.as_bound() };

	// SAFETY: `.handler` has been properly initialized before
	// `request_irq()`.
	T::handle(unsafe { &(*registration).handler }, device) as c_uint

Thoughts? Similar for the threaded one.

Regards,
Boqun

> +    // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
> +    // callback is running implies that the device has not yet been unbound.
> +    let device = unsafe { registration.inner.device().as_bound() };
> +
> +    T::handle(&registration.handler, device) as c_uint
>  }
>  
[...]

