Return-Path: <linux-pci+bounces-25660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C36A85797
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 11:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D61E7A6775
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A33428FFD8;
	Fri, 11 Apr 2025 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="baRaw0Qe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E82980D9
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362642; cv=none; b=s8KB4lnRJo1iIsKszYhyTn2cGR2gO23WeFEDooAX8S017lSCO5iOqgnPWuZnLoHBdiT2b6vBHPnLO2hbz6pZP25bmdT2Jtfdt43usQ4U5MDJdzbb2GzpZtIfqUfxzYFklFksG+zG/DRJGfozazoz2SzXuXaP9QzdgpJLxWoel1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362642; c=relaxed/simple;
	bh=d4KKNjwuoZFI0UhSHvmeJQu1TqXtlyhxiS6Ao/gYqro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GDFj5ngj5jpv22Y+88bvC/PkgmgAEpePTwwlsX//grBZTrsjObgJQ0+BgOucSuEOSwl60bKVc8oM4dHrFkY61pasYci3y708y+Ztsoc9L1B/wFB/O1q1FPa+zneBMfWXcifbWx24TrM82siauFaKoAzQ8RM3evENyLUASe7jt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=baRaw0Qe; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43eed325461so10251455e9.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 02:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744362639; x=1744967439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zF5GJW+czRiIiu4D0r/0Z8MC9j7bmRNMDvcUyfABZzU=;
        b=baRaw0QeCwrPeLUmZSZf7FJExbK0zaBPMzKzCnNqmkN7HiX33BMJ/0c4P2uJU5hvvB
         4zqVGRXfifPPIenJ575uSTVQMfQBmvsdXN+uSfXB72bzhko6QDmzqItf0Is3lTXEEZCD
         VbyNc3RKlBMAPKQQUORcnXJyffC6WcXTqi4CwKDIIXZT7nbMIwn8tq2Zyx3EVmd4cjZ/
         EoPHecHIUj2Fe+5V6/FL7v0XHrgFpFAQbYrOq1olmZAkOtuaHfnYVSmr+44DVdWiYy2K
         aOIPxHcwgXQEUK5E0mpOi/NfMGqHNAPZmwrFLErZUuS/azx1iDv/GkVnRObiW5od1iRO
         3Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744362639; x=1744967439;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zF5GJW+czRiIiu4D0r/0Z8MC9j7bmRNMDvcUyfABZzU=;
        b=JGVDRBUol6kEkXvxXItvs0yxq71Yyd/06lQ+sOYJX4rYwF3xMyWrlHPYnJj4nqJcd3
         s7Dg/AJUONTQvtk9TSkC5Pq/L0oOz9mp9dquPoL6e7iPTGF9PmLKqa1sb2Y8gF8OaQb3
         bEAtUuwd/AHyUK6G+lNUvkPnEykkE5RgsK7EAIMIUT1yvIrAgqh4h2q2hSBfbWZbmDZO
         wFHuKpsag7eYFFB9+4COc5BDgKaZVvOxMDjGik+iPCmZOd9YY2MRfHoBGlmwCFsR7wm4
         hJhQYTTyLYHe7GC1Sf31QnmsEB+6LIYBo03QQoQ3zmIKsi1OuiTBybfEdzfHmR3OIv+X
         wibg==
X-Forwarded-Encrypted: i=1; AJvYcCVPvgcpTrASC29KN/NCjh7Ndb0YngKnDS32OtYf3+p2ThF+NghBrYqkqYCnNTYoVFdkZ2NaWURir+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtOvbAQ2CnrTShRovXYJYAlAB0z0G0ZuBjymTu2AamC7a1t+yr
	N5TN3C0bO9lh1oGK0a7cJ/vLufjBjXmXVQXo+709FzSb3s5Wwz9puwbmyIOgIJscKD4Tf2n1Aj7
	PCfxe1FSTu0qI2Q==
X-Google-Smtp-Source: AGHT+IHlmejxcmD4jTD6NlcQhR5M2fWZs6vm160cXr9LWOW4REHUSk7IeQbvwGvehOaDQxPxdMQbpfJ4Mva7ALM=
X-Received: from wmcq13.prod.google.com ([2002:a05:600c:c10d:b0:43d:41bf:5b62])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1ca9:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-43f3a9599f2mr13568655e9.18.1744362638990;
 Fri, 11 Apr 2025 02:10:38 -0700 (PDT)
Date: Fri, 11 Apr 2025 09:10:36 +0000
In-Reply-To: <CAJ-ks9kms_jFEAHX9MnW1pUOyTeuFuyWwXk-A+qhCPQQNfJdAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409-no-offset-v2-0-dda8e141a909@gmail.com>
 <20250409-no-offset-v2-2-dda8e141a909@gmail.com> <Z_eMe7y0ixrBrHaz@google.com>
 <CAJ-ks9kms_jFEAHX9MnW1pUOyTeuFuyWwXk-A+qhCPQQNfJdAw@mail.gmail.com>
Message-ID: <Z_jcjEtKZRpRi9Yn@google.com>
Subject: Re: [PATCH v2 2/2] rust: workqueue: remove HasWork::OFFSET
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:15:53AM -0400, Tamir Duberstein wrote:
> On Thu, Apr 10, 2025 at 5:16=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > On Wed, Apr 09, 2025 at 06:03:22AM -0400, Tamir Duberstein wrote:
> > > Implement `HasWork::work_container_of` in `impl_has_work!`, narrowing
> > > the interface of `HasWork` and replacing pointer arithmetic with
> > > `container_of!`. Remove the provided implementation of
> > > `HasWork::get_work_offset` without replacement; an implementation is
> > > already generated in `impl_has_work!`. Remove the `Self: Sized` bound=
 on
> > > `HasWork::work_container_of` which was apparently necessary to access
> > > `OFFSET` as `OFFSET` no longer exists.
> > >
> > > A similar API change was discussed on the hrtimer series[1].
> > >
> > > Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1-=
5bd3bf0ce6cc@kernel.org/ [1]
> > > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > Tested-by: Alice Ryhl <aliceryhl@google.com>
> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > ---
> > >  rust/kernel/workqueue.rs | 45 ++++++++++++--------------------------=
-------
> > >  1 file changed, 12 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> > > index f98bd02b838f..1d640dbdc6ad 100644
> > > --- a/rust/kernel/workqueue.rs
> > > +++ b/rust/kernel/workqueue.rs
> > > @@ -429,51 +429,23 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut=
 bindings::work_struct {
> > >  ///
> > >  /// # Safety
> > >  ///
> > > -/// The [`OFFSET`] constant must be the offset of a field in `Self` =
of type [`Work<T, ID>`]. The
> > > -/// methods on this trait must have exactly the behavior that the de=
finitions given below have.
> > > +/// The methods on this trait must have exactly the behavior that th=
e definitions given below have.
> >
> > This wording probably needs to be rephrased. You got rid of the
> > definitions that sentence refers to.
>=20
> I don't follow. What definitions was it referring to? I interpreted it
> as having referred to all the items: constants *and* methods.

I meant for it to refer to the default implementations of the methods.

> Could you propose an alternate phrasing?

I guess the requirements are something along the lines of raw_get_work
must return a value pointer, and it must roundtrip with
raw_container_of.

Alice

