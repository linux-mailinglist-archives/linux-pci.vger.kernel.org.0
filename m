Return-Path: <linux-pci+bounces-17353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D09D9958
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 15:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFC9284212
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B8A1D6DB1;
	Tue, 26 Nov 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrUs2r8n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E47F1D5ABD;
	Tue, 26 Nov 2024 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732630437; cv=none; b=coNsKyC+m/yXPqW6e/QFgSJA6JJAMEAYp2BttyCbsW29Sj3rwTiOj64SETNqUDvmksNtjmwf10hMIiZLIlZOlK5zZJt27m5JetNbsTFAof6lUkOi0pZxBoYAdP5LMxuqUoIl9EBsPbeAtaNnj/FRAEajqJeK0FCeDfqzFTAerhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732630437; c=relaxed/simple;
	bh=ZJ2m72DenWAWcEv53PWHLtMe7bOXh8kD3LS1bOTBgiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e55U76WWNxjEP+QA5uirRjQUTPxaqeOCgyourrSzPYjGuAXOw/JSffebV/JcWsD9oDXk+pdRSmzE6QGy9GAXYo399oMaVoSFOLNp+upYHV3+On5XkWkF4ENVeF+I/Sr5KMQ1Xxe8Ht5X84vSONumxuMlJpvXJ/gLAEE4mkbq3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrUs2r8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BE1C4CED0;
	Tue, 26 Nov 2024 14:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732630436;
	bh=ZJ2m72DenWAWcEv53PWHLtMe7bOXh8kD3LS1bOTBgiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OrUs2r8nvnRIKtjmFUd7JuGx+omnLjW6HwSoVSLEBGb6XNku8V97l/eGbFFlC/pAF
	 9VB5LcIAop8/8ikGXfmCAsM/aEQOPbsD8CchBHQV/C2Z9bp/PqPFY9DpFzqtf+5ux2
	 lb2dhUcxY90rTMJX+WkFIZyHAKiipOZKtOiNWYUzK7JZjoyUR8kLVbv4ffYEwy3FRF
	 Hc6ZlWXrIwTfTw3fWdDwyiUQnNCFlV/bUHbxtEZoqTE3nWpoLQ3Zv8X0QVOD5NjYZN
	 C/ji+5brGdvpKEi1PlTfsoYIcw0Ws+xvJ0cAoqCSnjrC6PXRJ5iewyilYTVFz2JJQa
	 INHM6/P5EqokQ==
Date: Tue, 26 Nov 2024 15:13:49 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 15/16] rust: platform: add basic platform device /
 driver abstractions
Message-ID: <Z0XXnazDo8SmDNXb@cassiopeiae>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
 <CAH5fLghVDqWiWfi2WKsNi3n=2pR_Hy3ZLwY8q2xfjAvpHuDx=w@mail.gmail.com>
 <ZyJ19GDyVrGPbSEM@pollux>
 <CAH5fLgjADyNAmdNJG+cKRcpZPLx8iKbxAvm4ZQo=c+cVNjuw=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjADyNAmdNJG+cKRcpZPLx8iKbxAvm4ZQo=c+cVNjuw=w@mail.gmail.com>

On Thu, Oct 31, 2024 at 09:23:58AM +0100, Alice Ryhl wrote:
> On Wed, Oct 30, 2024 at 7:07 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Wed, Oct 30, 2024 at 04:50:43PM +0100, Alice Ryhl wrote:
> > > On Tue, Oct 22, 2024 at 11:33 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > +/// Drivers must implement this trait in order to get a platform driver registered. Please refer to
> > > > +/// the `Adapter` documentation for an example.
> > > > +pub trait Driver {
> > > > +    /// The type holding information about each device id supported by the driver.
> > > > +    ///
> > > > +    /// TODO: Use associated_type_defaults once stabilized:
> > > > +    ///
> > > > +    /// type IdInfo: 'static = ();
> > > > +    type IdInfo: 'static;
> > > > +
> > > > +    /// The table of device ids supported by the driver.
> > > > +    const ID_TABLE: IdTable<Self::IdInfo>;
> > > > +
> > > > +    /// Platform driver probe.
> > > > +    ///
> > > > +    /// Called when a new platform device is added or discovered.
> > > > +    /// Implementers should attempt to initialize the device here.
> > > > +    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>>;
> > >
> > > This forces the user to put their driver data in a KBox, but they
> > > might want to use an Arc instead. You don't actually *need* a KBox -
> > > any ForeignOwnable seems to fit your purposes.
> >
> > This is intentional, I do need a `KBox` here.
> >
> > The reason is that I want to enforce that the returned `Pin<KBox<Self>>` has
> > exactly the lifetime of the binding of the device and driver, i.e. from probe()
> > until remove(). This is the lifetime the structure should actually represent.
> >
> > This way we can attach things like `Registration` objects to this structure, or
> > anything else that should only exist from probe() until remove().
> >
> > If a driver needs some private driver data that needs to be reference counted,
> > it is usually attached to the class representation of the driver.
> >
> > For instance, in Nova the reference counted stuff is attached to the DRM device
> > and then I just have the DRM device (which itself is reference counted) embedded
> > in the `Driver` structure.
> >
> > In any case, drivers can always embed a separate `Arc` in their `Driver`
> > structure if they really have a need for that.
> 
> Is this needed for soundness of those registrations?

Yes, we must ensure that the class is unregistered before the driver is removed.

However, I just noticed that by letting class abstractions return the
`Registration` without being wrapped as `Devres<Registration>` the driver can
theoretically still stuff them in whatever other structure and keep the
registration alive.

So, maybe there is no way around `Devres` even for class registrations.

> 
> Also, I've often seen drivers use devm_kzalloc or similar to allocate
> exactly this object. KBox doesn't allow for that.
> 
> 
> Alice
> 

