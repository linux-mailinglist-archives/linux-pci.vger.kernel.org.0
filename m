Return-Path: <linux-pci+bounces-33747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17519B20BEE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19073188A17A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C6E24C09E;
	Mon, 11 Aug 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B35Zk9HE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F524DD07;
	Mon, 11 Aug 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922673; cv=none; b=lek3B0BnPgAOsodb+C+Tm+z3UR9vCoKvB3L6du58sY+01odCo5/6ikw5idmG7mvw2erLpkUDuQnoD23kxYBRByph+0VvddadK2lB5IMHF1HBO/XEuBtfutBNADoUGA+eLnWwABWK3LIS8WrNh7G2gxHo7RjYByt9sPeqDib/ATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922673; c=relaxed/simple;
	bh=mqhbDWtpdJzEAS60HE5ekBAixQ2FtXWUofqZ0255ReQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX0lgKD6RAjp1gII3cYw4nYYM79gGlvhOS5PuG16jFHsItTIQVWehyFuiPJI/UivUFkCnzjGlh87mb4C1kg1XPL2liMVuIHxpgLquXg+zKA46M/0NiCA96LG3/kGdHcUfLqQRJlw/7K6yWFbooPy8CYmlEvrM1lFLv3ZgsVbigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B35Zk9HE; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b062b6d51aso49744491cf.2;
        Mon, 11 Aug 2025 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754922671; x=1755527471; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5XGFLgg8rRTVsY5x1QiNu9G7T+ZZ8mSMfoDpmO0cw2s=;
        b=B35Zk9HE0qftaFYvXrVl5CBchvKpNuCIif9XCEcmEmk9Hkvmn+z64/V3WQBR6H9bxZ
         vIISeWcLzygxe57JE7zUHT9Gl8pwCGWXdJDnKD+JcLG45Qmdzsb22jY+J4gaqsB0ZW/d
         YE8jW36rR4YWtkTpDWtTGAVGT42SgrNPMWu5gB3D9vR1T9VjMA2NmyEnpjwvWe16Fzwc
         7U7jjK2GyZtzOA+9OhNmT1nv/6rNWuAEwpt3w9uvOxAOxBl7sonw/FecKvap3KXDjem+
         obNrUz8FzEfajAug2i7vpgjdcA+WddP2HzhOKzJkoV3qdgx7OIWZ8vdbFq1QhMCQXU9O
         bZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922671; x=1755527471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XGFLgg8rRTVsY5x1QiNu9G7T+ZZ8mSMfoDpmO0cw2s=;
        b=HJg4aHmw7m7TjgqQqGg56MfD6GY7Arg306xRyMinouTpiy+Hhh0wTmCcuQGyM475Ac
         SK/Cdr+15rRrAE3YZIgZNX9chfVY3QpvsndLVKYksIg2ZHFcLwa5JPxMebYw9ldWAcVN
         1oIFjuwJ9w0yhzjRTuViSoNlELkWTRNNzDi6EbfD0LahdH4bKW7jWcrcIJWnyXkieppe
         y0OkWQ26M5h+p/2iK9qA62Nn3jTlYPjgCvogmS7k3PLEUl14c9xPndB5TJ2depj3Q8Wl
         37iImE96Mc4JfvsukHLDjGcF+7QzUgxkeNYFZvGzTo7YizdbY5jsFR19FnIu7YP7QzGX
         SoFg==
X-Forwarded-Encrypted: i=1; AJvYcCW0LPjwOGkXNcEc+e1SNxNAYSwNp7OVwPiYX6DevJvyDD39Ifm0dfMxKb8vR58A+b2Mu7vWDQYx/drr@vger.kernel.org, AJvYcCWgKYLG5FppealUdjKHT/dpND1gawWzsG+3or0WDyVhiOJh9jqABZcitiOz4Be5lkfjhmuyv17yJ7mm1II=@vger.kernel.org, AJvYcCXda4nj5qUt8k0MD662l6X8ES06dEi+7fWcT7GGpSbAC4lRbmBrNC93qtETwEo7UIyL9pYWf03PWw6xyfJvcPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC1KxI1UzwE3DxmUAXNNubYInpymNxV2/P4ClN1oQof2ue9co/
	hat3uZcC6+8h9n4+f0GG0cDP1T1iPyaKELhO91kgejo/blk2AUtk+mUo
X-Gm-Gg: ASbGnctgDyNH+eUpp5LEnFHa1FjZz22RIeRdsMvrD0tLL57YM3gcLcpH9OJg/zqCHc3
	f1Bi/mV6Qgal6ucWsrg3/2dr4HF6pQwJyX7+Ktkd7fU8FjIqZDSOJVDPw2jOUzdFhBhhTFiCGxL
	nWNVqpfrjUCkr7G+MQ1ih/yiGJLzQd+ehneRwgqv/61AoVcZI2Bb7vBeai00fjmYhMoP2m+od/H
	qfU2n6+MMsr5tFYtpZwyEJA68AjrtoqNfg8gjTlEKzxFeiJiMq3u8qmBcQkHYcDxDDtVd2BEUZV
	migmajkXwcm1XVc012zZ0GjJGK9Cyt5YJOt91spcLvSoP6U89t33h6T1+bRYKgSUw6WXyS/7gym
	X6gdMzS0KyaMJiLalGMaQatx91srfjxC5GCyCmgBn2J3vOqnKRnAIfNSrcntmh/RUGIE0MpwbsA
	28KSChvJyhH9SC1P0RaSnmudQ=
X-Google-Smtp-Source: AGHT+IGEoHzQ3mMuBvzaQa4fa04wcUc+oHstUP/ydAU8dz/d7ih+MaX28q+RTQbkQn2wEQYCtrsI0A==
X-Received: by 2002:a05:622a:15c2:b0:4af:322:346a with SMTP id d75a77b69052e-4b0aedd7ce5mr183253671cf.37.1754922670330;
        Mon, 11 Aug 2025 07:31:10 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b08a54e82dsm82369091cf.14.2025.08.11.07.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:31:09 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5709DF40066;
	Mon, 11 Aug 2025 10:31:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 11 Aug 2025 10:31:09 -0400
X-ME-Sender: <xms:rf6ZaKLdZoynPFdIQm3V-MBq5-fkkiB279ki1zrjTNjE19BWRwvsfw>
    <xme:rf6ZaIvz6RU5W6Quz3Znw_dga7Tuv8y2eFLYYQ9nnt-aVziU4nVebFEN3Ah6Zw6TI
    54jEL-cq6m6J99syA>
X-ME-Received: <xmr:rf6ZaMbxcqhC8P2O26S5dw45e3GGliWOEue90k_QUSrd6ugoi1pSSwvz6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvjedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:rf6ZaI0noEbn9ymPfmPlrjML-kDqOtIJTmHWY0fv2wz93zC9lsy11g>
    <xmx:rf6ZaCW9a9aiYt9roRLmm2z7cz9p4ps3r613869qhmEjbY0DfaOHtQ>
    <xmx:rf6ZaDu7SabvshhhLSJHIRdyHGqGCMcDeXngsWx0UAStEXJ6Nb3X5A>
    <xmx:rf6ZaJWR0UzVQrUrjpaJo5c6MNtyU1ADLpaNCBKxs59httu3M8OIsA>
    <xmx:rf6ZaPUir5xtseJI890A90LIkeKwGDM2Nouo71qMDGmztrBCiZFYzk03>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 10:31:08 -0400 (EDT)
Date: Mon, 11 Aug 2025 07:31:07 -0700
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
Message-ID: <aJn-q-SebbQoyiyy@Mac.home>
References: <20250811-irq-bound-device-v2-1-d73ebb4a50a2@google.com>
 <aJn2ogBSmedhpuCa@Mac.home>
 <CAH5fLghitfmSOByu4ZRmhwdsOadzJOLei_qrAjNM+V15spq44w@mail.gmail.com>
 <aJn9M3WPcI_ZGems@Mac.home>
 <CAH5fLgg+1FtiHkXOzKLHFP-gRrq1Dq8yUO4RmyE7tM4aSDYioA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgg+1FtiHkXOzKLHFP-gRrq1Dq8yUO4RmyE7tM4aSDYioA@mail.gmail.com>

On Mon, Aug 11, 2025 at 04:25:50PM +0200, Alice Ryhl wrote:
> On Mon, Aug 11, 2025 at 4:24 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Aug 11, 2025 at 04:05:31PM +0200, Alice Ryhl wrote:
> > > On Mon, Aug 11, 2025 at 3:56 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Mon, Aug 11, 2025 at 12:33:51PM +0000, Alice Ryhl wrote:
> > > > [...]
> > > > > @@ -207,8 +207,8 @@ pub fn new<'a>(
> > > > >              inner <- Devres::new(
> > > > >                  request.dev,
> > > > >                  try_pin_init!(RegistrationInner {
> > > > > -                    // SAFETY: `this` is a valid pointer to the `Registration` instance
> > > > > -                    cookie: unsafe { &raw mut (*this.as_ptr()).handler }.cast(),
> > > > > +                    // INVARIANT: `this` is a valid pointer to the `Registration` instance
> > > > > +                    cookie: this.as_ptr().cast::<c_void>(),
> > > >
> > > > At this moment the `Regstration` is not fully initialized...
> > > >
> > > > >                      irq: {
> > > > >                          // SAFETY:
> > > > >                          // - The callbacks are valid for use with request_irq.
> > > > > @@ -221,7 +221,7 @@ pub fn new<'a>(
> > > > >                                  Some(handle_irq_callback::<T>),
> > > > >                                  flags.into_inner(),
> > > > >                                  name.as_char_ptr(),
> > > > > -                                (&raw mut (*this.as_ptr()).handler).cast(),
> > > > > +                                this.as_ptr().cast::<c_void>(),
> > > > >                              )
> > > >
> > > > ... and interrupt can happen right after request_irq() ...
> > > >
> > > > >                          })?;
> > > > >                          request.irq
> > > > > @@ -258,9 +258,13 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
> > > > >  ///
> > > > >  /// This function should be only used as the callback in `request_irq`.
> > > > >  unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mut c_void) -> c_uint {
> > > > > -    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
> > > > > -    let handler = unsafe { &*(ptr as *const T) };
> > > > > -    T::handle(handler) as c_uint
> > > > > +    // SAFETY: `ptr` is a pointer to `Registration<T>` set in `Registration::new`
> > > > > +    let registration = unsafe { &*(ptr as *const Registration<T>) };
> > > >
> > > > ... hence it's not correct to construct a reference to `Registration`
> > > > here, but yes, both `handler` and the `device` part of `inner` has been
> > > > properly initialized. So
> > > >
> > > >         let registration = ptr.cast::<Registration<T>>();
> > > >
> > > >         // SAFETY: The `data` part of `Devres` is `Opaque` and here we
> > > >         // only access `.device()`, which has been properly initialized
> > > >         // before `request_irq()`.
> > > >         let device = unsafe { (*registration).inner.device() };
> > > >
> > > >         // SAFETY: The irq callback is removed before the device is
> > > >         // unbound, so the fact that the irq callback is running implies
> > > >         // that the device has not yet been unbound.
> > > >         let device = unsafe { device.as_bound() };
> > > >
> > > >         // SAFETY: `.handler` has been properly initialized before
> > > >         // `request_irq()`.
> > > >         T::handle(unsafe { &(*registration).handler }, device) as c_uint
> > > >
> > > > Thoughts? Similar for the threaded one.
> > >
> > > This code is no different. It creates a reference to `inner` before
> > > the `irq` field is written. Of course, it's also no different in that
> > > since data of a `Devres` is in `Opaque`, this is not actually UB.
> > >
> >
> > Well, I think we need at least mentioning that it's safe because we
> > don't access .inner.inner here, but..
> >
> > > What I can offer you is to use the closure form of pin-init to call
> > > request_irq after initialization has fully completed.
> > >
> >
> > .. now you mention this, I think we can just move the `request_irq()`
> > to the initializer of `_pin`:
> >
> > ------>8
> > diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
> > index ae5d967fb9d6..3343964fc1ab 100644
> > --- a/rust/kernel/irq/request.rs
> > +++ b/rust/kernel/irq/request.rs
> > @@ -209,26 +209,26 @@ pub fn new<'a>(
> >                  try_pin_init!(RegistrationInner {
> >                      // INVARIANT: `this` is a valid pointer to the `Registration` instance
> >                      cookie: this.as_ptr().cast::<c_void>(),
> > -                    irq: {
> > -                        // SAFETY:
> > -                        // - The callbacks are valid for use with request_irq.
> > -                        // - If this succeeds, the slot is guaranteed to be valid until the
> > -                        //   destructor of Self runs, which will deregister the callbacks
> > -                        //   before the memory location becomes invalid.
> > -                        to_result(unsafe {
> > -                            bindings::request_irq(
> > -                                request.irq,
> > -                                Some(handle_irq_callback::<T>),
> > -                                flags.into_inner(),
> > -                                name.as_char_ptr(),
> > -                                this.as_ptr().cast::<c_void>(),
> > -                            )
> > -                        })?;
> > -                        request.irq
> > -                    }
> > +                    irq: request.irq
> >                  })
> >              ),
> > -            _pin: PhantomPinned,
> > +            _pin: {
> > +                // SAFETY:
> > +                // - The callbacks are valid for use with request_irq.
> > +                // - If this succeeds, the slot is guaranteed to be valid until the
> > +                //   destructor of Self runs, which will deregister the callbacks
> > +                //   before the memory location becomes invalid.
> > +                to_result(unsafe {
> > +                    bindings::request_irq(
> > +                        request.irq,
> > +                        Some(handle_irq_callback::<T>),
> > +                        flags.into_inner(),
> > +                        name.as_char_ptr(),
> > +                        this.as_ptr().cast::<c_void>(),
> > +                    )
> > +                })?;
> > +                PhantomPinned
> > +            },
> >          })
> >      }
> >
> >
> > Thoughts?
> 
> That calls free_irq if request_irq fails, which is illegal.
> 

Ah, right. I was missing that. Then back to the "we have to mention that
we are not accessing the data of Devres" suggestion, which I think is
more appropriate for this case.

Regards,
Boqun

> Alice

