Return-Path: <linux-pci+bounces-24230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E422A6A7C0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 14:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D828598497D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 13:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B762222A5;
	Thu, 20 Mar 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8jBjX0C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84024221F35
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479003; cv=none; b=go2+iGuuVE3GW31jKLucZWWIm2CPyRm7pVoAGA05LB7fIkvgOXpvH3itabBC10Yjf6vmcrvTGlXXWRlKfVy+yPnQYUnhEoUX8Od8bN29xs/lGDdA7fENORQu4RM8oLg18YIRrvLrx4wtJPCN9eHPNWbhv+uzlikq1SGgiAcpiow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479003; c=relaxed/simple;
	bh=S9T/qBL+z4aNd6M0Hkz2pYEIkgtE38X3OTfgtg4dx7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ebMgsTfY5sylazdZEArYrAFp1/RJzZwS1cWb74CjfcAXDlMLR1W9AiNUlK/c/84fD41BHOoiU5OGQ2+Ca8PUTdqSwdF5TFbEJ2wYHmy+tdUh8qX6k4k6r3VPz8zJ6FdNDZmOKGJWktksMTRaNDkdwtm8mUvwne5xxIaGCbzXkUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8jBjX0C; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3912539665cso956418f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742479000; x=1743083800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWWAhmzvNwlqSFcvmaCbepdAYIL6fnNZCCrItGOwILo=;
        b=I8jBjX0CNcMzw4nly5M5euWr4s1AomnOZikZCs4AhYo35H1WlvSQkF67ZT6XMVFEuB
         WJN+LCfdxGw2g7k2UIP1uc6B2tF+xkKgwq/8YcI2t+FxfWuC1fD+YZkDjz5S2AvzLWaz
         mkvH+uS4/p5RS69qMmouGPhS7SJOmubS+eVWs3yAIs8xPeFY1Y7S0e+DD3U62vFbFW1u
         Kc3ggIzSQmdsN+cTsnOMpLikbi1iQF5PAgfSE1bLQZ0eSEjhAcZBgBaOYfCrOmLptg0w
         kHVw/h3N/siEMaZoHQmEEFttcHJcDBxCEt7kwd01oM6i04OrhAI3mRe+kxy2saFnWClM
         PsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479000; x=1743083800;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kWWAhmzvNwlqSFcvmaCbepdAYIL6fnNZCCrItGOwILo=;
        b=Tufp8upm5DVyvs8cRs4WGOZj6bWgtP8ogWPnFXCmwq1/Z8Z5c5LUDYr0KnnsGRCkxz
         FPdB8Jk5YT8MuAbRGSPTZcq5AXRx2ecLhWAGwatIeti74qybBcu2668o1PEDMG37hvA7
         D8eP5bpbju+8Lz2aPzyL38bVVSNlW+DHnaNbOaRkdrwNMVnphE0rxas5aV4jMY9Xdpmg
         oXS4AVILGMWG4lr5hm48WJF4jhURdpk5C5reooZojRMpk6Lr7xEcNslFW32qh9xZMQbp
         KzFleZHz+fr7rrKgTnMblmQipgGb8V52jlUQ6ewoS1nbhy7Vp01WHg3v8pJHOYlUsK0Q
         8WdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW0T4rYVaNV9oFTzM7EWJuO0HntXkfgzzwEarhSd1zXSJwLf+mCfhMmE59EpyFRk6kmU/n9G+S3aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsilohBVno5u76XgtISNVs3tkye1wZ772G5YRb5FN2K2UWGJAp
	OCqw8AsA1K3JexH5Ofbe8nbhmFw8zQcGk3HI20fxF+k6yNKe+vewqzXtCzb/Np429vI1g2pjAjm
	aAdB+21nUOVBLTQ==
X-Google-Smtp-Source: AGHT+IFGmucGm31xquzCIdMPfx+iY6I4pvpkEGnfiBPJy7YBlidkxn1rhz3SbgkwfrscFWZRuiT3zZv9bZSaQQs=
X-Received: from wmbfl10.prod.google.com ([2002:a05:600c:b8a:b0:43c:f122:1874])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1f88:b0:399:6d6a:90d9 with SMTP id ffacd0b85a97d-39979586b74mr3303422f8f.18.1742478999908;
 Thu, 20 Mar 2025 06:56:39 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:38 +0000
In-Reply-To: <Z9wHv-2HXfoYZFmk@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319203112.131959-1-dakr@kernel.org> <20250319203112.131959-2-dakr@kernel.org>
 <Z9vTDUnr-G4vmUqS@google.com> <CAH5fLggvFanUvysDkZiLqFz4Ay7XSP5LF3CvxBU3xgWE3PSZXQ@mail.gmail.com>
 <Z9wHv-2HXfoYZFmk@pollux>
Message-ID: <Z9wellJ7Rsm6Wvd-@google.com>
Subject: Re: [PATCH 1/4] rust: device: implement Device::parent()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 01:19:11PM +0100, Danilo Krummrich wrote:
> On Thu, Mar 20, 2025 at 09:40:45AM +0100, Alice Ryhl wrote:
> > On Thu, Mar 20, 2025 at 9:34=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > On Wed, Mar 19, 2025 at 09:30:25PM +0100, Danilo Krummrich wrote:
> > > > Device::parent() returns a reference to the device' parent device, =
if
> > > > any.
> > > >
> > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > > ---
> > > >  rust/kernel/device.rs | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > >
> > > > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > > > index 21b343a1dc4d..76b341441f3f 100644
> > > > --- a/rust/kernel/device.rs
> > > > +++ b/rust/kernel/device.rs
> > > > @@ -65,6 +65,19 @@ pub(crate) fn as_raw(&self) -> *mut bindings::de=
vice {
> > > >          self.0.get()
> > > >      }
> > > >
> > > > +    /// Returns a reference to the parent device, if any.
> > > > +    pub fn parent<'a>(&self) -> Option<&'a Self> {
> > > > +        // SAFETY: By the type invariant `self.as_raw()` is always=
 valid.
> > > > +        let parent =3D unsafe { *self.as_raw() }.parent;
> > >
> > > This means:
> > > 1. Copy the entire `struct device` onto the stack.
> > > 2. Read the `parent` field of the copy.
> > >
> > > Please write this instead to only read the `parent` field:
> > > let parent =3D unsafe { *self.as_raw().parent };
> >=20
> > Sorry I meant (*self.as_raw()).parent
>=20
> Good catch, thanks!=20

With that fixed you may add
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

