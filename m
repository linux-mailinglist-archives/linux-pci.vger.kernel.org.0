Return-Path: <linux-pci+bounces-33755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B814B20CC4
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210093AA9D0
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2821DF27F;
	Mon, 11 Aug 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvMQAXra"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6FAE555;
	Mon, 11 Aug 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924240; cv=none; b=K7LThon8ihTq2GlF2WXw3YAfbdgxc1piBESztkbdemnP0WSXvMyjBP23+84XKKkGT/UhcZ1hd8Tzt28cF+6QZaOLl3DNUh7/ZnFdYUZK0en401McCiljz6sQivgz/wfkLClJ0OkBP3+hMt9JK4LIkeDv3OYsS1LyqXj1ez6ppYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924240; c=relaxed/simple;
	bh=5jDqHRY5O6DeyIvlC46m8lUKhRRpDbz9am1Sdt2Jzvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1T3euG75j1NekNbP2Z8zIeiz9QPPxvOtNhoidJ/ErLDr0BYsFDWKNwo0EdKCSv4jsOt8SoQO4Jatx+xKmOVoBTTx7ib6vIVk41au8um+SitouF0iVMoKd10Z1ZEn9mmtcEsa15h3yAqQmnrsPb85y7nMb+NUSEPakaGJuQoOpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvMQAXra; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b06d162789so51463661cf.2;
        Mon, 11 Aug 2025 07:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754924238; x=1755529038; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y/qNnZDiS6GhrMAfdR7l/vOQdZliPihcxBNdoO86to=;
        b=kvMQAXraV6YARmONS+hkbAZrfI5np59IVLJpLGgrIn1zWNw2S9g56gcnvPKWicaOxi
         vmgbeYeOETaSQDcoJ93fLEVe16aF9kOoT26miCidsCO1OEjWqjIyYLlrx2FkWHcnASZo
         ERYP4bsPFuDieBqDBbi6VcbeIZbdu/9bhSH7kD3FW900pRqBqaV5UpGXr/iQlxHmj3iP
         m/y5h9qcb29UipkJhx6ydFnsBRu4FWw2i9NLZecbz+lpGbnWuL1I+/JgVeUYRt4mZNXn
         KQOUW9dDWoBmxhZ2TX7/oQ7R7Tq6M01WqnUOAFrCCbSRef1o3dHU6d4cwckbMkiF5o/x
         POtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754924238; x=1755529038;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Y/qNnZDiS6GhrMAfdR7l/vOQdZliPihcxBNdoO86to=;
        b=RfvTKfh9aIsQqV50yuYonQJQdD9+zUkhF1D6l8vZQ+gw26Rl6BxS1PQHcGAI07NI8B
         xbLnBuYgWVmKNH8vuyop2u4joApH4NEZiA59GhO8DSw3UCiA17xqH5RTFFoBKP8rHznR
         wNwJlZRpusk+bCYJcx5QUJpRFcIwYI/2bgSdK3pBPUaaEfEStN+tIxpAWcvjk1LpttDN
         KZCT4Cv8b/chhc28gmv3f8jWANlGy/I0njZLFiz+1tvf8MujFfMUaE5TrSFWy4LghEov
         U0boX2kC6zg1kkeEk9NzfHtSdADqYuIo8/auRYOFHPuP8PInikp6U6eYQC7fAVT+g6tZ
         qcIA==
X-Forwarded-Encrypted: i=1; AJvYcCUDEy0Q6Je9HESlE5cDjqOQsMFatXN6eWAqS453eM+7bmT7dtB8AS/Qryiy1Opwxg8B38ltVXBWQ10kOuo=@vger.kernel.org, AJvYcCX7uH1erAo0TgKqhWK8e90lhjVGCT365JKK16RD6f1W3OntuShQOHxpvfCx/5O0DlsBkHnwjiOFcs4sdERQ2/Y=@vger.kernel.org, AJvYcCXTONB1Gk+cZFvRhgliQcUzLA9ceKJxAe1NVIFTorLGNkXiOA8JOWVkz802h6m9JLCVYMrHIa8beMFE@vger.kernel.org
X-Gm-Message-State: AOJu0YxX8j0Jk7+csmykzaOOCnQdHiNrPzRInrNbFhEtEBqV0QBV57r/
	SCieM0/luQi28895Z0RhZKOT6vyWvvdZQCy0e6ZAZjLZNejViLAoMKN7
X-Gm-Gg: ASbGncssXdNzCiKPLYUSQIA9aGmW/dgLVsxEdOEufZvHC4VQrTz+k1/QxhzmAGsINuD
	81WYBVk/TXKL/REZPRZImWoiWsl4XEneldyf8DZbZy3ydzpKGgP3cFyfv8R9ScqImzUU0PlA8J0
	Ze56tLix3Whkx2vR8LogpH2JvTIRYzQIq0prerdYNhWVoLWoP6BdKc/skW+v40SwMCvSVBXruoK
	WQ3nO2S5j60yenj3nOEPpZ1clPhQ5xyIzPKSFrUY+vE+LzVYCVAQaBsAhD0nsx0xM3WFhxt7bgK
	bB/Nl1idLfl1NsW1ZENAE1fs7p5VHf9xT6l/+0VPk5E1+L9Gg4KPxRq9czSeJrfVdZKenyhYrMx
	2TuGPJhbyW5+FAHfWYGAkyy//gz5vYTl05ZnsHs0uwhQMbH3Z2dDTA0k3OSi5oIciKuKDkLOV6Q
	OQ+52e3aVqLIbUIYZ/NMoOlGk=
X-Google-Smtp-Source: AGHT+IHKxGzZPsV1zDomytD4KQ3Yf6pRip4gpJI7HmAXndFtkxsJSqNE19OZpyOdM3IwjE8OJ6pHNw==
X-Received: by 2002:a05:622a:a953:10b0:4b0:8f21:cd9 with SMTP id d75a77b69052e-4b0b81c7c8dmr96189951cf.31.1754924237558;
        Mon, 11 Aug 2025 07:57:17 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b09359705asm71750881cf.27.2025.08.11.07.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:57:17 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 48207F40068;
	Mon, 11 Aug 2025 10:57:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 11 Aug 2025 10:57:16 -0400
X-ME-Sender: <xms:zASaaOCmnCqt06sGJklN3Ak8GQiqOLx_srPlquck-Yc4y52CAacTlw>
    <xme:zASaaPFWxg7nKn0Mb60TTaG4mXsUIzGPP_Bvh2sOCB7GwFyycFzezPZba9B3_MAgK
    Avpjuy-ypJ2WCwTbw>
X-ME-Received: <xmr:zASaaDTonrXWDHJvS0MpOo-wnsfC8iIUeAFKf5KQYV5c-uwPfnsySOoH4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefhgfeg
    leefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepug
    grnhhivghlrdgrlhhmvghiuggrsegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohep
    ohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihsehgrghrhihguh
    hordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgt
    ohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehtmhhgrhhoshhssehumhhitghhrdgvughupdhrtghpthhtohepuggrkhhrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurg
    htihhonhdrohhrgh
X-ME-Proxy: <xmx:zASaaGPoJvMBSkf35F75OZPJzhpAPQB5rqWI-bmYRC254d4PJM4cqA>
    <xmx:zASaaEMcVLZglfDxwhNIdDguA48imV5Vv8jFS1o14Y7abeAAmUwD1Q>
    <xmx:zASaaAEvV3WwJ49r19nMNjR1h0VbKYR5LqtXeBFj87ybDXMNjRn6Fg>
    <xmx:zASaaOPAF_r31SFBcpIvBLPj2-q31GKOd1Cn1Pkg-6ngv__ET93UCA>
    <xmx:zASaaCtb-bH-G9HvX0IjktBq-jso1OzkrOW_buERzMiEpp-0JuvGXq9K>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 10:57:15 -0400 (EDT)
Date: Mon, 11 Aug 2025 07:57:14 -0700
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
Message-ID: <aJoEyvq66sD_RtAU@Mac.home>
References: <20250811-irq-bound-device-v2-1-d73ebb4a50a2@google.com>
 <aJn2ogBSmedhpuCa@Mac.home>
 <CAH5fLghitfmSOByu4ZRmhwdsOadzJOLei_qrAjNM+V15spq44w@mail.gmail.com>
 <aJn9M3WPcI_ZGems@Mac.home>
 <CAH5fLgg+1FtiHkXOzKLHFP-gRrq1Dq8yUO4RmyE7tM4aSDYioA@mail.gmail.com>
 <aJn-q-SebbQoyiyy@Mac.home>
 <CAH5fLgicWki8Z+ne9fMn4KbQYYz340FhpOONU5dCCMwfo0wnhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgicWki8Z+ne9fMn4KbQYYz340FhpOONU5dCCMwfo0wnhg@mail.gmail.com>

On Mon, Aug 11, 2025 at 04:37:44PM +0200, Alice Ryhl wrote:
> On Mon, Aug 11, 2025 at 4:31 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Aug 11, 2025 at 04:25:50PM +0200, Alice Ryhl wrote:
> > > On Mon, Aug 11, 2025 at 4:24 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Mon, Aug 11, 2025 at 04:05:31PM +0200, Alice Ryhl wrote:
> > > > > On Mon, Aug 11, 2025 at 3:56 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 11, 2025 at 12:33:51PM +0000, Alice Ryhl wrote:
> > > > > > [...]
> > > > > > > @@ -207,8 +207,8 @@ pub fn new<'a>(
> > > > > > >              inner <- Devres::new(
> > > > > > >                  request.dev,
> > > > > > >                  try_pin_init!(RegistrationInner {
> > > > > > > -                    // SAFETY: `this` is a valid pointer to the `Registration` instance
> > > > > > > -                    cookie: unsafe { &raw mut (*this.as_ptr()).handler }.cast(),
> > > > > > > +                    // INVARIANT: `this` is a valid pointer to the `Registration` instance
> > > > > > > +                    cookie: this.as_ptr().cast::<c_void>(),
> > > > > >
> > > > > > At this moment the `Regstration` is not fully initialized...
> > > > > >
> > > > > > >                      irq: {
> > > > > > >                          // SAFETY:
> > > > > > >                          // - The callbacks are valid for use with request_irq.
> > > > > > > @@ -221,7 +221,7 @@ pub fn new<'a>(
> > > > > > >                                  Some(handle_irq_callback::<T>),
> > > > > > >                                  flags.into_inner(),
> > > > > > >                                  name.as_char_ptr(),
> > > > > > > -                                (&raw mut (*this.as_ptr()).handler).cast(),
> > > > > > > +                                this.as_ptr().cast::<c_void>(),
> > > > > > >                              )
> > > > > >
> > > > > > ... and interrupt can happen right after request_irq() ...
> > > > > >
> > > > > > >                          })?;
> > > > > > >                          request.irq
> > > > > > > @@ -258,9 +258,13 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
> > > > > > >  ///
> > > > > > >  /// This function should be only used as the callback in `request_irq`.
> > > > > > >  unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mut c_void) -> c_uint {
> > > > > > > -    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
> > > > > > > -    let handler = unsafe { &*(ptr as *const T) };
> > > > > > > -    T::handle(handler) as c_uint
> > > > > > > +    // SAFETY: `ptr` is a pointer to `Registration<T>` set in `Registration::new`
> > > > > > > +    let registration = unsafe { &*(ptr as *const Registration<T>) };
> > > > > >
> > > > > > ... hence it's not correct to construct a reference to `Registration`
> > > > > > here, but yes, both `handler` and the `device` part of `inner` has been
> > > > > > properly initialized. So
> > > > > >
> > > > > >         let registration = ptr.cast::<Registration<T>>();
> > > > > >
> > > > > >         // SAFETY: The `data` part of `Devres` is `Opaque` and here we
> > > > > >         // only access `.device()`, which has been properly initialized
> > > > > >         // before `request_irq()`.
> > > > > >         let device = unsafe { (*registration).inner.device() };
> > > > > >
> > > > > >         // SAFETY: The irq callback is removed before the device is
> > > > > >         // unbound, so the fact that the irq callback is running implies
> > > > > >         // that the device has not yet been unbound.
> > > > > >         let device = unsafe { device.as_bound() };
> > > > > >
> > > > > >         // SAFETY: `.handler` has been properly initialized before
> > > > > >         // `request_irq()`.
> > > > > >         T::handle(unsafe { &(*registration).handler }, device) as c_uint
> > > > > >
> > > > > > Thoughts? Similar for the threaded one.
[...]
> >
> > Ah, right. I was missing that. Then back to the "we have to mention that
> > we are not accessing the data of Devres" suggestion, which I think is
> > more appropriate for this case.
> 
> I will add:
> 
> // - When `request_irq` is called, everything that `handle_irq_callback`
> //   will touch has already been initialized, so it's safe for the callback
> //   to be called immediately.
> 

This looks good to me.

> Will you offer your Reviewed-by ?
> 

I want to wait and see Daniel's new version with your patch included.
But overall LGTM. Thanks!

Regards,
Boqun

> Alice

