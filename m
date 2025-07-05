Return-Path: <linux-pci+bounces-31569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1DEAFA0A2
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F19B7AE4B9
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF2E17A5BE;
	Sat,  5 Jul 2025 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLcAqjQk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF42CA9;
	Sat,  5 Jul 2025 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751727975; cv=none; b=BY20yDectHuDWc1HzMumTUPvZeY7LhajUVNq3iNG2B+/uMLL19auM6t0WGGiqpgBTABlWZx2qSnndsXVjxDFNTj9oaQ3AJP0stsLXYLRGIoAPbWpCL+zipGB2xJ/GzsgbDPIG5vmf/nt4x38eU3uCsIq+4imZp3lVkzuF6fRsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751727975; c=relaxed/simple;
	bh=0RAT1QzWcZIXw2i/MINS/triAT6nnVcva9zpNrI0LLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwLcXnlIb1wzn+3k9wx04DfLabDY1veFOagEcbLW0lww26EmDcBCWNQuvhsBR6bn0NKyklw1CA2mH2NppQGQe3ErfbiB/ZCgVduTZ81hqP6Bf0PoTRI9Pqf9y2Mcgoc2cPxZvRo+0DK7v2FOGQ3uqRZpshAK6EokPoI2GcyOuvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLcAqjQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14241C4CEE7;
	Sat,  5 Jul 2025 15:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751727975;
	bh=0RAT1QzWcZIXw2i/MINS/triAT6nnVcva9zpNrI0LLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLcAqjQkbE5VH+oStc615DdfriNe9c6q+qG+6fXcpOAwGEl5rjzUbsy4FwGmikAVM
	 MLHY/egV/Sqoijv6+RWZ8HiE2IJFqskiZpcJ4TNbbYoR+doxy4M5sGIEb/LJKYfw8X
	 PDPi+9J7IGf+Zp34umbVD6EyZKKsh37qeDGNMlZa79Pr/nV/64rybeLxf861FVWvfx
	 NXNEpqjj5U3sNrD5Q2kIGVp1/2mqHMDBuJxlf6G86wFmZrydGNVu9j0mlPusVxYXx2
	 s7bT3YObs1o0j5QIgAXtJv3c4qAB5AWcSk6yDNp4frVHcVWj9lcvKMNEyUpIAF3ipP
	 S5iTxB0C10AMA==
Date: Sat, 5 Jul 2025 17:06:08 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/8] rust: device: add drvdata accessors
Message-ID: <aGk_YBCGqrO-A6bG@cassiopeiae>
References: <20250621195118.124245-1-dakr@kernel.org>
 <20250621195118.124245-3-dakr@kernel.org>
 <DB42TQY2E57U.1PKC16LW38MH9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB42TQY2E57U.1PKC16LW38MH9@kernel.org>

On Sat, Jul 05, 2025 at 01:15:06PM +0200, Benno Lossin wrote:
> On Sat Jun 21, 2025 at 9:43 PM CEST, Danilo Krummrich wrote:
> > +impl Device<Internal> {
> > +    /// Store a pointer to the bound driver's private data.
> > +    pub fn set_drvdata(&self, data: impl ForeignOwnable) {
> > +        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
> > +        unsafe { bindings::dev_set_drvdata(self.as_raw(), data.into_foreign().cast()) }
> > +    }
> > +
> > +    /// Take ownership of the private data stored in this [`Device`].
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// - Must only be called once after a preceding call to [`Device::set_drvdata`].
> > +    /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
> > +    ///   [`Device::set_drvdata`].
> > +    pub unsafe fn drvdata_obtain<T: ForeignOwnable>(&self) -> T {
> > +        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
> > +        let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
> > +
> > +        // SAFETY: By the safety requirements of this function, `ptr` comes from a previous call to
> > +        // `into_foreign()`.
> 
> Well, you're also relying on `dev_get_drvdata` to return the same
> pointer that was given to `dev_set_drvdata`.
> 
> Otherwise the safety docs look fine.

Great! What do you think about:

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 146eba147d2f..b01cb8e8dab3 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -80,8 +80,11 @@ pub unsafe fn drvdata_obtain<T: ForeignOwnable>(&self) -> T {
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
         let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };

-        // SAFETY: By the safety requirements of this function, `ptr` comes from a previous call to
-        // `into_foreign()`.
+        // SAFETY:
+        // - By the safety requirements of this function, `ptr` comes from a previous call to
+        //   `into_foreign()`.
+        // - `dev_get_drvdata()` guarantees to return the same pointer given to `dev_set_drvdata()`
+        //   in `into_foreign()`.
         unsafe { T::from_foreign(ptr.cast()) }
     }

