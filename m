Return-Path: <linux-pci+bounces-17844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BC39E72CC
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8797A188802F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A702066EE;
	Fri,  6 Dec 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJlsO52r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825320C00C
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497916; cv=none; b=YAgf3DOF34O399mx4kWKqGjSz/9ZSASZGWu8fZ4knzX94zWJBcf9TLEQb6UHOMrhkWV7PdeXMEPuJS4K7guycPZrfjZRirCyKAO/JvwAA1Xi4RCN9pY4dHandpaggMkC6Q/6YSNvAwJgynUndQQYKpWpLfR01DPFBwypmH1+7jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497916; c=relaxed/simple;
	bh=VsbWadzQAUzzRCQY34b2ER7Mb+OWCDREIbu52Y041sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlaWmfNfqsWQdjXk7rEOzdTGjuyl3DZNulNclTecwdrHgn0VTLuOWopaGX3vdJZNWuAzsgnpTyI97fUJipnPy1oFZPdgbaVvRc85xdH/3Ys7Hr/JqgVnii7RO+2SjJ5ths1a0dwzFESo9Wr9+NiJvlMTg3/8IFdc4Gsy5e55YSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJlsO52r; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862f32a33eso240390f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 06 Dec 2024 07:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733497912; x=1734102712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjq2xXvft575dfuEG4uN2IK5uPwMYuH3FIUETvWaj5o=;
        b=sJlsO52rF+VYjJFC9i0O54tYoyJJ9FmY0f7XZKQRyGpIqzrR4MlErb/vKwUa/n/6EM
         N7ILwx2EfV0YFgIoHEketX36tFG36jFqQn1GLNdVjOiWrqGUCodrMJh+8UTjDRhrAwOa
         lvMl50UvN0hNLk+2hBJov1NGBV0suiSHYQwppbCa9EZCoXW126Si6faF6naJiGmA6zen
         O67H3r9h4NYTdbxTcbtrZGOMw6Je8YVBVKpJ1vKxZQKOhQNzXlWKuUpWVTztzjBlXzDn
         Yqyg03bAUMaR2uir5QAgSi3i+qnz+sylEgXHKg0JR3UjIIH45oYsvxbXGsmJvQYOKPGx
         tNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733497912; x=1734102712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjq2xXvft575dfuEG4uN2IK5uPwMYuH3FIUETvWaj5o=;
        b=Nq1KhdRkI+MI8Dx3ZJlU3fhzPFu0RQN3UjnaH995lCrlV5ZLMHQZr/5NBm2qQveDys
         Lj5teBmNFUMyTLepxeH3PeKfCHafKG+EIvLec4uYk//n4kYtuggz5ByGg8pMfLl3ut5T
         mNqBWCZfuJhOHgf8d56Cr4BG5fEO1oDSRQ9GmsJfSLAMA/c0+rI6k2ZRyiAYcYhjxhNi
         I8GOdXpmvsOaqJ9tRVIbrw3tdx+9LUbt5TQlt1vJ1AP7hEGJVtsITYtOUD6Zy5FBRt32
         fCFou2IqCLiCwGAqauNulbKsjXHzLMrxq6OYGw24GKrjWjqulfh3CvxO8rM6abl1w2/+
         hxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlXlX4/en/dXiCHF+vsNBQ7db1MdvUMChj0GvTPvbZ0qvSX9IrIgHMyRiZyUVOUkncuFGbXEkI+bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZKUeFjzIPxiJ3+ymWtUu9OQLB9j9b3lN3MlddRBjxgA4laPmD
	m7nZzmhC3q9Se+k5HXT/OVizrQU5aCzf5/ESzTkojru1gPnuNfzpuX2syCd0Uk0im+Q1NJ2ERJ4
	86pVxjj3wpDDPr/yHcDlfaKTKakmGLsOAW1DC
X-Gm-Gg: ASbGncuKyfyWssBV0ngKzO9znHzkPnvKfwh5RKJS+9P6f1I9bBN94zf5ujVUe5uOdDN
	kG34QqtjipXhKJBvjZJrf3nisQKT41oMP
X-Google-Smtp-Source: AGHT+IHS8cG/kq81OOAK08T7ktIQybZ1OqiRrLbS+nzho3PteiPlsCy1pSgmnpw1MzFKl9K+xpLd3OKFc7CQmnxLc/I=
X-Received: by 2002:a5d:47a5:0:b0:385:f13c:570a with SMTP id
 ffacd0b85a97d-3862b33b791mr2320443f8f.7.1733497911519; Fri, 06 Dec 2024
 07:11:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205141533.111830-1-dakr@kernel.org> <20241205141533.111830-6-dakr@kernel.org>
In-Reply-To: <20241205141533.111830-6-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 6 Dec 2024 16:11:39 +0100
Message-ID: <CAH5fLggw8Z74updxX6HtXRnZ7Zk16_ZLCoi-wkj=t2khhoV6mQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/13] rust: add `Revocable` type
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 3:16=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>
> Revocable allows access to objects to be safely revoked at run time.
>
> This is useful, for example, for resources allocated during device probe;
> when the device is removed, the driver should stop accessing the device
> resources even if another state is kept in memory due to existing
> references (i.e., device context data is ref-counted and has a non-zero
> refcount after removal of the device).
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Overall looks reasonable, but some comments below.

> +impl<T> Revocable<T> {
> +    /// Creates a new revocable instance of the given data.
> +    pub fn new(data: impl PinInit<T>) -> impl PinInit<Self> {
> +        pin_init!(Self {
> +            is_available: AtomicBool::new(true),
> +            // SAFETY: The closure only returns `Ok(())` if `ptr` is ful=
ly initialized; on error
> +            // `ptr` is not partially initialized and does not need to b=
e dropped.
> +            data <- unsafe {
> +                Opaque::try_ffi_init(|ptr: *mut T| {
> +                    init::PinInit::<T, core::convert::Infallible>::__pin=
ned_init(data, ptr)
> +                })

This is pretty awkward ... could we have an Opaque::pin_init that
takes an `impl PinInit instead of using fii_init?

> +            },
> +        })
> +    }
> +
> +    /// Tries to access the revocable wrapped object.
> +    ///
> +    /// Returns `None` if the object has been revoked and is therefore n=
o longer accessible.
> +    ///
> +    /// Returns a guard that gives access to the object otherwise; the o=
bject is guaranteed to
> +    /// remain accessible while the guard is alive. In such cases, calle=
rs are not allowed to sleep
> +    /// because another CPU may be waiting to complete the revocation of=
 this object.
> +    pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
> +        let guard =3D rcu::read_lock();
> +        if self.is_available.load(Ordering::Relaxed) {
> +            // Since `self.is_available` is true, data is initialised an=
d has to remain valid
> +            // because the RCU read side lock prevents it from being dro=
pped.
> +            Some(RevocableGuard::new(self.data.get(), guard))
> +        } else {
> +            None
> +        }
> +    }
> +
> +    /// Tries to access the revocable wrapped object.
> +    ///
> +    /// Returns `None` if the object has been revoked and is therefore n=
o longer accessible.
> +    ///
> +    /// Returns a shared reference to the object otherwise; the object i=
s guaranteed to
> +    /// remain accessible while the rcu read side guard is alive. In suc=
h cases, callers are not
> +    /// allowed to sleep because another CPU may be waiting to complete =
the revocation of this
> +    /// object.
> +    pub fn try_access_with_guard<'a>(&'a self, _guard: &'a rcu::Guard) -=
> Option<&'a T> {
> +        if self.is_available.load(Ordering::Relaxed) {
> +            // SAFETY: Since `self.is_available` is true, data is initia=
lised and has to remain
> +            // valid because the RCU read side lock prevents it from bei=
ng dropped.
> +            Some(unsafe { &*self.data.get() })
> +        } else {
> +            None
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that there are no more concurrent users of t=
he revocable object.
> +    unsafe fn revoke_internal(&self, sync: bool) {

This boolean could be a const generic to enforce that it must be a
compile-time value.

Alice

