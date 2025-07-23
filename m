Return-Path: <linux-pci+bounces-32826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43097B0F758
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 17:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C600AC2130
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF621FC0E2;
	Wed, 23 Jul 2025 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/9NUzJX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC7E1B21BF
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285488; cv=none; b=IsMdF+GwGTKSQ5QezdldZtKPwRtbs7ku0gHjh2AmCbKfJFKvI9iPP8KfglvaWPJEpG+G3OLY1/qpCTPIy9sp7ZkRwNcKa87j+Z7MMkQeSjxof9YaVNVQW41AZ7zhGQCMw9aMtI45uiVmPfgYmnfnHj9fsYg4WecfmwDzuI5SnxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285488; c=relaxed/simple;
	bh=jw8TYEc+nEulyIXXXRJnf41j1zUMTr8e6BxmktkG7aA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mljb5jLX89veS82qpGprboXOXvum+XsWAngX5YjU8tHluenE2Rd0j0vyTTIAQJPEtCz6bmFbZ0UHiu2xjR01LUj3sbwfRwTKuTL980OzS/953g+0J387zqUrZoOw0cezDT73dtP8I1UM/iiK+CImTaF+ag6/FpuyUZJomlUFPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p/9NUzJX; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45639e6a320so36952755e9.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 08:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753285485; x=1753890285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXOWdiJ76aqzcJ+Nx0mm5z+V0JOAweMr48E8iTDuzpU=;
        b=p/9NUzJXXGYRbf6U65h2jUYjvU2/9BcBSNGu6hYgJDHNA4yUQGUuM2AzrgU7rRbHq7
         axy60rbgg9Iy42qWct9K5QERjhzOjVvXMk+tsaHNnGqAEwjo6/nkaCyVu3rI+Yhc+eqO
         79uM4Ln7r5B0OCbsAkPbfbLMPe2piv1M5IheC408Z1jFq1zX/EKl1tVoJTmDapfFiV5q
         87wTCsvJp4SS3phsd6fMxkHfh/topuaKzkt0Qm9v1mv3r1BADFwnfQZgrxKxoplDNvdG
         C8WAs+bAKXeIuCtj7S1hyja3sY60w/yGe1KGIbq/bjT2Ok5sEmJRejZ2ubN1ONztaQmh
         3Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753285485; x=1753890285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXOWdiJ76aqzcJ+Nx0mm5z+V0JOAweMr48E8iTDuzpU=;
        b=QmOE/iND85xDA3PunFTp5kKvTT8X3i9UvbmdcQOgNjQXDj5eRRKz7NCcHAr3sjmPrH
         2NCxTS72P/RxM0lV/n9ERbNWZJATxdra0wB2eCwpX4xRqrV89Lm1O+ONsdE/Oj2m0CHf
         gyVbinl85tOD8iLf66DP+Hwh2OIB7gtsIddgc2JIloZ3gbDmQn6zzT93DsliAc/p1ACX
         daiMMFEO6TBxXZCkycrC2DOkqfq1Sde1WCd9qbWyuqXFgVLjTQOKudbNonX8JN0h5hIL
         SKYlbmWadWS+BuK9+7aAaZfHueTjssRftazRTNPlx9Rb1siUoLwLxWEQFDFxYNw+loyH
         odyA==
X-Forwarded-Encrypted: i=1; AJvYcCXMRa2DZagA2r1zrkMdi7R1/SoHkdFB34zE5kUct3U0+5lSOpFIi3G8+dbSBdZMLLkJtmLP4ACbGYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOw16qL0M+fxoOda8mdTSioYCYb+uns7xscH9pY4MvCqMlrgx6
	mqYSBhfKxelemRTNzibkBWJarVSTe2Qor8GBIP91XFzD8mnGsAFpXpHo1dER6ABg/yOME8ubHrq
	G8k78yyXCQ24aMgPYPQ==
X-Google-Smtp-Source: AGHT+IGLuQqTAZTG3JChYcwGQ8hLmPMgRGjl4gGVAS2ZTeeJTYCoACcyAvpCSpgWDQ01q31ft1GIqKLJobK8w8U=
X-Received: from wmqb11.prod.google.com ([2002:a05:600c:4e0b:b0:456:d19:9bcb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e4a:b0:450:d4a6:79ad with SMTP id 5b1f17b1804b1-45868d4e7e0mr27932955e9.23.1753285485308;
 Wed, 23 Jul 2025 08:44:45 -0700 (PDT)
Date: Wed, 23 Jul 2025 15:44:44 +0000
In-Reply-To: <DBJIY7IKSNVH.1Q2QD6X30GIRC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <aIBl6JPh4MQq-0gu@tardis-2.local> <ED19060D-265A-4DEF-A12B-3F5901BBF4F3@collabora.com>
 <aIDxFoQV_fRLjt3h@tardis-2.local> <7fa90026-d2ac-4d39-bbd8-4e6c9c935b34@kernel.org>
 <8742EFD5-1949-4900-ACC6-00B69C23233C@collabora.com> <DBJIY7IKSNVH.1Q2QD6X30GIRC@kernel.org>
Message-ID: <aIEDbB_FcgHgzfKd@google.com>
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and handlers
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C2=B4nski?=" <kwilczynski@kernel.org>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Jul 23, 2025 at 05:03:12PM +0200, Danilo Krummrich wrote:
> On Wed Jul 23, 2025 at 4:56 PM CEST, Daniel Almeida wrote:
> >> On 23 Jul 2025, at 11:35, Danilo Krummrich <dakr@kernel.org> wrote:
> >> On 7/23/25 4:26 PM, Boqun Feng wrote:
> >>> On Wed, Jul 23, 2025 at 10:55:20AM -0300, Daniel Almeida wrote:
> >>> But sure, this and the handler pinned initializer thing is not a blocker
> >>> issue. However, I would like to see them resolved as soon as possible
> >>> once merged.
> >> 
> >> I think it would be trivial to make the T an impl PinInit<T, E> and use a
> >> completion as example instead of an atomic. So, we should do it right away.
> >> 
> >> - Danilo
> >
> >
> > I agree that this is a trivial change to make. My point here is not to postpone
> > the work; I am actually somewhat against switching to completions, as per the
> > reasoning I provided in my latest reply to Boqun. My plan is to switch directly
> > to whatever will substitute AtomicU32.
> 
> I mean, Boqun has a point. AFAIK, the Rust atomics are UB in the kernel.
> 
> So, this is a bit as if we would use spin_lock() instead of spin_lock_irq(),
> it's just not correct. Hence, we may not want to showcase it until it's actually
> resolved.
> 
> The plain truth is, currently there's no synchronization primitive for getting
> interior mutability in interrupts.

Is the actual argument here "we are getting rid of Rust atomics in the
next cycle, so please don't introduce any more users during the next
cycle because if you do it will take one cycle longer to get rid of
all Rust atomics"?

I can accept that argument. But I don't accept the argument that we
shouldn't use them here because of the UB technicality. That is an
isolated demand for rigor and I think it is unreasonable. Using Rust
atomics is an accepted workaround until the LKMM atomics land.

Alice

