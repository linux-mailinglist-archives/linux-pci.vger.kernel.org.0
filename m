Return-Path: <linux-pci+bounces-24362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EAEA6BD78
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 15:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422CD16E0A4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E8015855E;
	Fri, 21 Mar 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4DmdkiW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8A2F5E;
	Fri, 21 Mar 2025 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568400; cv=none; b=d1CvZkTdBqVWl2FtsZS/lOrfhYx+ZsRadnBvvapDavIA7/fOoICt9YWGJ/7IFcoQu8XwFdoo6tYA6zQIU7tO0k7U+zspMe4D5E6y7dippWRJ4P2lSFCO72+YdKd6Q0fDE/yrR2SxraAqKPVCh6gUxm4kQlVCdKcJC5TMcBAiJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568400; c=relaxed/simple;
	bh=yw7+2jN/GCF4iIWTOg/rehmkSfqCNgjoVhCNNeY6xbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1eKJqgnYv3pBOCeghYEqmoVviWVdEhwGWH8yiKQv2QKe/Z9q48kvilaypyoRtkiuisZXCm7DD1XsOn+EqeEKQxId5L7cmrDnloVvhMLQVng/Ab5SplMtxnxzsqXNJAo84CFI7UVVj9eVHN1feIuDGo1L+ZeV0zEJDfwBlX5pCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4DmdkiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD0BC4CEE3;
	Fri, 21 Mar 2025 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742568399;
	bh=yw7+2jN/GCF4iIWTOg/rehmkSfqCNgjoVhCNNeY6xbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4DmdkiW9Fzc61G0ig9yNIdat7zDH4GUSkrZYJX3Vu+//jn8h0Vp9ppcEBM79Vx3F
	 Uo4p98aIFpISOY3JspBrOSwDImR2RSCUC0CkMh8oV+E2YjvPk1jGNSQJg+tOUwNhiN
	 r3FlTNUeYS2Mk+tmPK+RunAvJTKjgxJlRMZdZ0ZqrgIHWtQIN9Y4tVpRPWb3ZhY34T
	 93zk9ZxvqJPxS+DqtpexfcD6FaC77ssqR2a6f+Ifrwe6+ioUCU2IOQI7LMjdCSo2iZ
	 ooKLlcP6OrCYZeaHUFkkxvRy7+CJED3pKbd6K1jQs5sR0q615GENG1hHnwvgQtmjpn
	 pF1P8SNuD9Icg==
Date: Fri, 21 Mar 2025 15:46:33 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] rust: device: implement Device::parent()
Message-ID: <Z917yQdlWYo6GrkG@pollux>
References: <20250320222823.16509-1-dakr@kernel.org>
 <20250320222823.16509-2-dakr@kernel.org>
 <Z916eZ1_Jd3VQz3Y@Mac.home>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z916eZ1_Jd3VQz3Y@Mac.home>

On Fri, Mar 21, 2025 at 07:40:57AM -0700, Boqun Feng wrote:
> On Thu, Mar 20, 2025 at 11:27:43PM +0100, Danilo Krummrich wrote:
> > Device::parent() returns a reference to the device' parent device, if
> > any.
> > 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/device.rs | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 21b343a1dc4d..f6bdc2646028 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -65,6 +65,21 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
> >          self.0.get()
> >      }
> >  
> > +    /// Returns a reference to the parent device, if any.
> > +    pub fn parent<'a>(&self) -> Option<&'a Self> {
> > +        // SAFETY:
> > +        // - By the type invariant `self.as_raw()` is always valid.
> > +        // - The parent device is only ever set at device creation.
> > +        let parent = unsafe { (*self.as_raw()).parent };
> > +
> > +        if parent.is_null() {
> > +            None
> > +        } else {
> > +            // SAFETY: Since `parent` is not NULL, it must be a valid pointer to a `struct device`.
> > +            Some(unsafe { Self::as_ref(parent) })
> 
> The safety comment also needs to explain why the parent device won't be
> gone, I assume a struct device holds a refcount of its parent?

Correct, this is taken generically in device_add().

> Therefore
> the borrow checker would ensure the parent exists as long as the Device
> is borrowed.

Yes.

