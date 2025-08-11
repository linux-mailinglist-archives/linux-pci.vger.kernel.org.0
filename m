Return-Path: <linux-pci+bounces-33744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC8DB20BCE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B5B2A0564
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FB823B606;
	Mon, 11 Aug 2025 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEL7zzY4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4523B631;
	Mon, 11 Aug 2025 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922298; cv=none; b=IXiiqcGxN/Jk9NHQmVOq/P0x1UXKRDxkWE/zEARg1FrwFc9vlgOAW0yekCJXc5YalEsRzWYXe4tn41Mh+wjVAY0EpxilJoJzkgub6zp/ERGrZrGoRq2KMe3WNq52JHNH/fvNNzAeFsNUfdHTynffwz8oVZwAYhQvauMHDe3ObTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922298; c=relaxed/simple;
	bh=zGmvTwiWNfBwQbEzhwqgA12UVfRQ8wRSvJ5SWnqWwxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByuKsay1bMGq5GfuRZUoeUP1l/B2bHKBru2n66WEpF6KNKuGAUUJUvXukCuA6dOJxdOmxhVOVN89AR/3DGAJvLcVrBxZnLYwRNpTtZ7yonKQ8c4QZV9KhwjyWYScvSyXjCZnzTeYqla9t/lC7bTJYvqJ2SQkhfboLQsdXhEcod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEL7zzY4; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e8053d3382so501977285a.0;
        Mon, 11 Aug 2025 07:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754922294; x=1755527094; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RPL+y06jGXmS6D3g5W7n0N/JXOEq9MD4HMv4HAW2uug=;
        b=IEL7zzY4oj/4hQbYWez5PcDMn2f1GDt/9k2QZD11Puh/oBYABx5u5dw3SBVzp4qOGi
         9uhU+AmOMSp8srI0hYL/Y7EtUUkkYnEdY43NakFu4jyd1L35yiY2YM3HBunpJrsVyTwr
         5G0hdUynYSnqzkZ8pHfgSbhOGsCkhXmR8jGi6wnLkjwV46zTbFGyD2ww7o+VZHkCY2vC
         1PdKnho3b9VD1xGtEoxwys4lPCmzK+6qlp5DwJL70iv6jnEqpTIrPPRJkDBRCpmQB71J
         iQv/XWI8Tea+cZeFhVObHf9nX73pd1DIRkEcSYPHEDHqzukgCQW28N9MHAqgNhpXB3V3
         tVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922294; x=1755527094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPL+y06jGXmS6D3g5W7n0N/JXOEq9MD4HMv4HAW2uug=;
        b=FRgOznfZUWsRy/Rg9aUHNa1m0dyJEpsTE+p3bgD1LZfSyxEm+oKj7/SmTkxZ8unVir
         k85XOMnqNxT4h44jrIl1Twqa4Ex1/CzjG5CkpPCi1Fv08Uxfwzjk8U94+DNHnu6KFWIz
         a1krRGlDL8j/fBdCIC2PMD814hdKpbL5CyU2ABgQ0+Ta2Zqo9rPE6/gI96dXreh4GfoQ
         ei4Fz6JFcbP6RU/CSsNhhbyZNuBUMLyo/om2JW17yvePsUjj5PCMMBCaPTFNFUrn68dH
         gl59ESV0S+ZmMDaaXPkpjtlldcuWxGP4sG4Qx14mCgTO+hUXuAI3Nj9+gg3V4dpv2QTE
         wQ4g==
X-Forwarded-Encrypted: i=1; AJvYcCVTw+Gra+rP7jMYeweCFe7YdIftY/CPHlLEsk13Kb4mTfZxM8xQu229PzAQMWwxKVVAMv3Jk/fvPqyiz04=@vger.kernel.org, AJvYcCWaUHg6shMDdjIrdhcfG7guabAMrDj4o/ZhzjA8mHzntKsM4D++ZssbxokI5qwEtJVxyTm4o83cRHXj/laXM6A=@vger.kernel.org, AJvYcCXxM0/qcV8rMmi/ajClOsPlaYmfNuh47pi5Hmv1VchKfRV3FmfHA+T+jPA2D9ZvvHmDhczdjT7Lf51M@vger.kernel.org
X-Gm-Message-State: AOJu0YwcUwY07/3sUMH76xkJWPUq5kcCE9ylhnCrdhZAR3iFJf16M5yY
	7MsT2XxPMminjy2HThZBc+sJ8FIVPLNQtb76MNIvhxcGGL1QOvAo6HIL
X-Gm-Gg: ASbGncvPZnQHwTM7RclPyD/JPh/ajc6T7C5ed5oKs/Uv6lklnq85rR7IL/OClZgPR08
	ffXx/2H/210MY8THDV0uHG2gh6ysHkxKhpvgdHzzCeW7V5S/ZcF1hMLhdWCIrDxb/G6NdJeivaR
	nKS1KPSczJEWe0y7T1A6wB5o4W0YUN05r7X/sZD8ksktyBzKer+SjOQPqnWBgb9d99YIqhi08mK
	PxAwo0Gz79ZY0eRKJRypM8GFlDXx2/4ReBaGVHhS6VucS8ekJMsX1IclTstKmgpAgEKA70zm9+D
	BD5x7dG0gcBkqt2geWOr9fUuOIQ4d8WZvh8g7hQWKSBRgn9ezdri7HGqYEyRbKwUqv/sZbRmz6c
	nbnIP7v1ieKc5CZLXyqrqoStoTm/ImZkrBE6P0UllJQH61forJSzuP97xpa56Z+PXxhBtf2So9V
	ynboW/uw8mLnPkOGNGQJRMxAc=
X-Google-Smtp-Source: AGHT+IHmxQyEYV0GevC7iiAX4vpnjmzER2E45rwc6AryaO6aVgbm1vcPI83OHaVWAAP4lnak0qIwYQ==
X-Received: by 2002:a05:620a:199a:b0:7e6:9bc2:6cb8 with SMTP id af79cd13be357-7e8587db674mr8228285a.2.1754922294010;
        Mon, 11 Aug 2025 07:24:54 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f727eaasm1540554485a.62.2025.08.11.07.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:24:53 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 167BDF40066;
	Mon, 11 Aug 2025 10:24:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 11 Aug 2025 10:24:53 -0400
X-ME-Sender: <xms:NP2ZaFb18BReMHo82BmA-KS8tkGEvRXtd8BqYfDkY4YqbZHmDIkVjg>
    <xme:NP2ZaC_D8TsMjhEpt3PDsDIH_RJtb0O9QF3dlJ3BmUkkOxQqmRwaMd1SJzyUw4IB-
    tUQWvrZIqBeSV8fmw>
X-ME-Received: <xmr:NP2ZaJqyg4FQHjaa1eZsfT2XHuHMoUwx9lHwni8WtH6Cdz66EZDMIKrUsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvieelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Nf2ZaNG5cFt5c3fLhye1jjmqWwADYyM2AHQOSAVIZUi8LMOayu3wEg>
    <xmx:Nf2ZaBkcU-WOhi1t8Uje4XAtr9CZvrIf5furkXolbH-VDs2lzDveQw>
    <xmx:Nf2ZaB9hDP9BGPELJaI_rEg5pCB34buS668GVp-E3Zyqllr496SG4A>
    <xmx:Nf2ZaKkL7Z7lC95-fJOAftEYrWSeg6XXgb8Z2l9dnr40DlTAakNlhw>
    <xmx:Nf2ZaHkVgCRCfD65h-r_hBDL5HXzvAuhncCuBgRsjbEXc0ld6yXWYdIw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 10:24:52 -0400 (EDT)
Date: Mon, 11 Aug 2025 07:24:51 -0700
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
Message-ID: <aJn9M3WPcI_ZGems@Mac.home>
References: <20250811-irq-bound-device-v2-1-d73ebb4a50a2@google.com>
 <aJn2ogBSmedhpuCa@Mac.home>
 <CAH5fLghitfmSOByu4ZRmhwdsOadzJOLei_qrAjNM+V15spq44w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghitfmSOByu4ZRmhwdsOadzJOLei_qrAjNM+V15spq44w@mail.gmail.com>

On Mon, Aug 11, 2025 at 04:05:31PM +0200, Alice Ryhl wrote:
> On Mon, Aug 11, 2025 at 3:56 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Aug 11, 2025 at 12:33:51PM +0000, Alice Ryhl wrote:
> > [...]
> > > @@ -207,8 +207,8 @@ pub fn new<'a>(
> > >              inner <- Devres::new(
> > >                  request.dev,
> > >                  try_pin_init!(RegistrationInner {
> > > -                    // SAFETY: `this` is a valid pointer to the `Registration` instance
> > > -                    cookie: unsafe { &raw mut (*this.as_ptr()).handler }.cast(),
> > > +                    // INVARIANT: `this` is a valid pointer to the `Registration` instance
> > > +                    cookie: this.as_ptr().cast::<c_void>(),
> >
> > At this moment the `Regstration` is not fully initialized...
> >
> > >                      irq: {
> > >                          // SAFETY:
> > >                          // - The callbacks are valid for use with request_irq.
> > > @@ -221,7 +221,7 @@ pub fn new<'a>(
> > >                                  Some(handle_irq_callback::<T>),
> > >                                  flags.into_inner(),
> > >                                  name.as_char_ptr(),
> > > -                                (&raw mut (*this.as_ptr()).handler).cast(),
> > > +                                this.as_ptr().cast::<c_void>(),
> > >                              )
> >
> > ... and interrupt can happen right after request_irq() ...
> >
> > >                          })?;
> > >                          request.irq
> > > @@ -258,9 +258,13 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
> > >  ///
> > >  /// This function should be only used as the callback in `request_irq`.
> > >  unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mut c_void) -> c_uint {
> > > -    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
> > > -    let handler = unsafe { &*(ptr as *const T) };
> > > -    T::handle(handler) as c_uint
> > > +    // SAFETY: `ptr` is a pointer to `Registration<T>` set in `Registration::new`
> > > +    let registration = unsafe { &*(ptr as *const Registration<T>) };
> >
> > ... hence it's not correct to construct a reference to `Registration`
> > here, but yes, both `handler` and the `device` part of `inner` has been
> > properly initialized. So
> >
> >         let registration = ptr.cast::<Registration<T>>();
> >
> >         // SAFETY: The `data` part of `Devres` is `Opaque` and here we
> >         // only access `.device()`, which has been properly initialized
> >         // before `request_irq()`.
> >         let device = unsafe { (*registration).inner.device() };
> >
> >         // SAFETY: The irq callback is removed before the device is
> >         // unbound, so the fact that the irq callback is running implies
> >         // that the device has not yet been unbound.
> >         let device = unsafe { device.as_bound() };
> >
> >         // SAFETY: `.handler` has been properly initialized before
> >         // `request_irq()`.
> >         T::handle(unsafe { &(*registration).handler }, device) as c_uint
> >
> > Thoughts? Similar for the threaded one.
> 
> This code is no different. It creates a reference to `inner` before
> the `irq` field is written. Of course, it's also no different in that
> since data of a `Devres` is in `Opaque`, this is not actually UB.
> 

Well, I think we need at least mentioning that it's safe because we
don't access .inner.inner here, but..

> What I can offer you is to use the closure form of pin-init to call
> request_irq after initialization has fully completed.
> 

.. now you mention this, I think we can just move the `request_irq()`
to the initializer of `_pin`:

------>8
diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index ae5d967fb9d6..3343964fc1ab 100644
--- a/rust/kernel/irq/request.rs
+++ b/rust/kernel/irq/request.rs
@@ -209,26 +209,26 @@ pub fn new<'a>(
                 try_pin_init!(RegistrationInner {
                     // INVARIANT: `this` is a valid pointer to the `Registration` instance
                     cookie: this.as_ptr().cast::<c_void>(),
-                    irq: {
-                        // SAFETY:
-                        // - The callbacks are valid for use with request_irq.
-                        // - If this succeeds, the slot is guaranteed to be valid until the
-                        //   destructor of Self runs, which will deregister the callbacks
-                        //   before the memory location becomes invalid.
-                        to_result(unsafe {
-                            bindings::request_irq(
-                                request.irq,
-                                Some(handle_irq_callback::<T>),
-                                flags.into_inner(),
-                                name.as_char_ptr(),
-                                this.as_ptr().cast::<c_void>(),
-                            )
-                        })?;
-                        request.irq
-                    }
+                    irq: request.irq
                 })
             ),
-            _pin: PhantomPinned,
+            _pin: {
+                // SAFETY:
+                // - The callbacks are valid for use with request_irq.
+                // - If this succeeds, the slot is guaranteed to be valid until the
+                //   destructor of Self runs, which will deregister the callbacks
+                //   before the memory location becomes invalid.
+                to_result(unsafe {
+                    bindings::request_irq(
+                        request.irq,
+                        Some(handle_irq_callback::<T>),
+                        flags.into_inner(),
+                        name.as_char_ptr(),
+                        this.as_ptr().cast::<c_void>(),
+                    )
+                })?;
+                PhantomPinned
+            },
         })
     }


Thoughts?

Regards,
Boqun

