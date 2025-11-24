Return-Path: <linux-pci+bounces-41938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6876C7FD75
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 11:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09D11341F74
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB3E26FA6E;
	Mon, 24 Nov 2025 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvdyvZcJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C87B26ED3B
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763979645; cv=none; b=jVb7o4e4Kydk4EVFb75KWnWA/n99PK7pMMGufHFVjCLEiTIoULlRC1eUOZeZNwyjky/5uSRJIlH8d7uytS9fzJHbF6gL67nROtjGgSIJjRG/oNbC0RMIH2rM55TzP9K2f09gUNhot0lyYZQ9/FjmJ3n6XkEbJpO7DCDNaV2ngd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763979645; c=relaxed/simple;
	bh=Vq23B42YQM30fbN3a/FlljXqjGc+yzZDWoRENSi3Iok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AGz4Y2mws5APDFjCcA93w9wgMJOJzG9Ni0OmLQLwrkFx1Qhbbcq5Hc477ctX+lXjW5RHqVsI2z9e3InHk9ZK1e+4wYVMKa8wV8P90ddUuyyT67aHJoX1lA3AEUfQHsmXf8XUkYsTNVip2fcqxV8JS4e19oZLKtoHacQ8zq05DKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvdyvZcJ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42b3339cab7so2766776f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 02:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763979642; x=1764584442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjaxZBnZAO+RdK+lICe94+uM0QkuZZJOu84Gi7JQ2wU=;
        b=MvdyvZcJlnM+iHh8Zaw9/7h7vZtWtsn1sDKj15yYj2D28hFo3zsfDdbcIaVyx70qDf
         aCoQUrbC54znTUpTxaL9MJDozbsquYDBolSZHMl8VvWpbnbMEpRixiS2TCQp4/nY0rWp
         VPNsrkKbHQUkFlBFPQuiEidR7F1B05BodUkyPzMWIad7oSOeeDUscw+HGNEnHmQXaD5h
         7b3VLpp9ggeLAJj8x6uA8iCtJ8UInmz0XRhktS4HphSiC7qy/V4ulJ84i4CVgI32UWmy
         d7JkGuCrgvRSPFoHTm66ATiIGxY3Dms3PoW7m9JEzF0anaJfrVcgr/XDidbu0IAH0tg/
         OcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763979642; x=1764584442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MjaxZBnZAO+RdK+lICe94+uM0QkuZZJOu84Gi7JQ2wU=;
        b=iGmG71EOOBkCegZstBTFnXNxocmpGWQ3iEBJGHzuIkiHc+yPkoNc8HirUtCxn3f/KA
         P5kACwIofQLZX4SqEusDvsoNdbCjFewNfSiQPGpzBxep+FBs4yXjvJ/QeNy3VOS212Ml
         jGvJAeh+JAF/ggmYioRv1lmkXpz7z8gNEEu+PQmWEti6qP+ZlDM1EjxBM+f7LSOkJej1
         p4YtAzzBQDbBhjy+aLxc8o+iCNoH5iHlM6ExzMhncnifgqo8fJ5PuOn2R8zKAufVFoLK
         Fdy1fi5YJzB8755YGZ7MpSVm6CC+UPTwGDbRzvB+i46L9U+LaowaqRrGzKq6+cBlNFNg
         szUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJJ1KjDIGL+CPo8971Xu8yOF6UZix9yD/gpEBxdPn5gss2Zwg1hcAgvpnP1YuqKK2lLKlrJW78IsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw80J0X66yQDj4YHPLq76n6gF57sDOpsmsOsTiZAMEi+RlOTQH4
	DADtqZs3j9zTRgFUOHC7B5792bE9thETsEjyovSHC6ZB4w2Ui4qECuSk+/xrf7QgiosyBokScoC
	2csMckqh7i2U5dJWvQg==
X-Google-Smtp-Source: AGHT+IF8S0it1+GhoOO3nZ/1kXLt4XUmfk2TDfnUVhFKCQUNw3c7NJSXstpPE1SfO3stNbsOGXDZ9186zRs4lJA=
X-Received: from wmbjd14.prod.google.com ([2002:a05:600c:68ce:b0:474:979d:a20d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5252:b0:477:569c:34e9 with SMTP id 5b1f17b1804b1-477c01defd8mr118517125e9.23.1763979642501;
 Mon, 24 Nov 2025 02:20:42 -0800 (PST)
Date: Mon, 24 Nov 2025 10:20:41 +0000
In-Reply-To: <20251124120846.267078e5.zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251119112117.116979-1-zhiw@nvidia.com> <20251119112117.116979-4-zhiw@nvidia.com>
 <aSB1Hcqr6W7EEjjK@google.com> <20251124120846.267078e5.zhiw@nvidia.com>
Message-ID: <aSQxeSX0q4Z_jaAu@google.com>
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io trait
From: Alice Ryhl <aliceryhl@google.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dakr@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	markus.probst@posteo.de, helgaas@kernel.org, cjia@nvidia.com, 
	smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, acourbot@nvidia.com, 
	joelagnelf@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 24, 2025 at 12:08:46PM +0200, Zhi Wang wrote:
> On Fri, 21 Nov 2025 14:20:13 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
> > On Wed, Nov 19, 2025 at 01:21:13PM +0200, Zhi Wang wrote:
> > > The previous Io<SIZE> type combined both the generic I/O access
> > > helpers and MMIO implementation details in a single struct.
> > > 
> > > To establish a cleaner layering between the I/O interface and its
> > > concrete backends, paving the way for supporting additional I/O
> > > mechanisms in the future, Io<SIZE> need to be factored.
> > > 
> > > Factor the common helpers into new {Io, Io64} traits, and move the
> > > MMIO-specific logic into a dedicated Mmio<SIZE> type implementing
> > > that trait. Rename the IoRaw to MmioRaw and update the bus MMIO
> > > implementations to use MmioRaw.
> > > 
> > > No functional change intended.
> > > 
> > > Cc: Alexandre Courbot <acourbot@nvidia.com>
> > > Cc: Alice Ryhl <aliceryhl@google.com>
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > Cc: Danilo Krummrich <dakr@kernel.org>
> > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> > 
> > I said this on a previous version, but I still don't buy the split
> > into IoFallible and IoInfallible.
> > 
> > For one, we're never going to have a method that can accept any Io -
> > we will always want to accept either IoInfallible or IoFallible, so
> > the base Io trait serves no purpose.
> > 
> > For another, the docs explain that the distinction between them is
> > whether the bounds check is done at compile-time or runtime. That is
> > not the kind of capability one normally uses different traits to
> > distinguish between. It makes sense to have additional traits to
> > distinguish between e.g.:
> > 
> > * Whether IO ops can fail for reasons *other* than bounds checks.
> > * Whether 64-bit IO ops are possible.
> > 
> > Well ... I guess one could distinguish between whether it's possible
> > to check bounds at compile-time at all. But if you can check them at
> > compile-time, it should always be possible to check at runtime too, so
> > one should be a sub-trait of the other if you want to distinguish
> > them. (And then a trait name of KnownSizeIo would be more idiomatic.)
> > 
> 
> Thanks a lot for the detailed feedback. Agree with the points. Let's
> keep the IoFallible and IoInfallible traits but not just tie them to the
> bound checks in the docs.

What do you plan to write in the docs instead?

> > And I'm not really convinced that the current compile-time checked
> > traits are a good idea at all. See:
> > https://lore.kernel.org/all/DEEEZRYSYSS0.28PPK371D100F@nvidia.com/
> > 
> > If we want to have a compile-time checked trait, then the idiomatic
> > way to do that in Rust would be to have a new integer type that's
> > guaranteed to only contain integers <= the size. For example, the
> > Bounded integer being added elsewhere.
> > 
> 
> Oops, this is a interesting bug. :) I think we can apply the bound
> integer to IoFallible and IoInfallible to avoid possible problems
> mentioned above. E.g. constructing a Bounded interger when constructing
> Mmio and ConfigSpace objects and use them in the boundary checks in the
> trait methods.
> 
> I saw Alex had already had an implementation of Bounded integer [1] in
> rust-next. While my patchset is against driver-core-testing
> branch. Would it be OK that we move on without it and switch to Bounded
> integer when it is landed to driver-core-testing? I am open to
> suggestions. :)

The last -rc of this cycle is already out, so I don't think you need to
worry about branch issues - you won't land it in time for that.

But there is another problem: Bounded only supports the case where the
bound is a power of two, so I don't think it's usable here. You can have
Io regions whose size is not a power of two.

Alice

