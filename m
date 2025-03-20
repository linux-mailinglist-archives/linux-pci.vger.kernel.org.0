Return-Path: <linux-pci+bounces-24228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 857CAA6A621
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 13:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC6C8855D5
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 12:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAB2221D9A;
	Thu, 20 Mar 2025 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvnCtAMR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7621CC4A;
	Thu, 20 Mar 2025 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473160; cv=none; b=mBIXqusSIM10zuKAOG4n8/J02EzlrWHfeBSQuAekM15bKGEqOV4WlGxuIz+Ao2dVO5JcnDALE8RWP9bMZ5I8p5eqKFsMDIK2FiZNekyqmLNjQrczr+/ccmXZvpEOc4JTf6VViTisDDmuklmwMTpCYFbjALi6qNziht/eCFZ72o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473160; c=relaxed/simple;
	bh=IgacscJu0BctP1CTVeEZ9NwpbUaiPSFQC+NgqU0li6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARZQRlFPe4t2G+SHuv/SmrIukbpO8TfgtxBkMnxr9ZZy76b89x5HpSbZjXeq+igQfAsRosrkgXbhIxZvz4hv74ZHxlt4jDuT9nkmG9FvM2NfPv8/cYO/xpM7PG1kJk10N2TedNzFzrOLoCrsqBZtwfwYZrlSC2Blv7f2xS3IwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvnCtAMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6343C4CEDD;
	Thu, 20 Mar 2025 12:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742473157;
	bh=IgacscJu0BctP1CTVeEZ9NwpbUaiPSFQC+NgqU0li6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvnCtAMR+Cdxhn515+kNe7/mOya6e3QfxwbVaNQe3ALkjZ0fOw18xkwon2X4bRL/s
	 EPUBVWXn6ycWxGNjRerBUTuFMmLWQj+suAtjxPTyFEzKsMxDIe4+OVYP/j7zufls8m
	 4O/3gLyT+5r1oeNt4IAS8psKlMfSSTxhr6rC7ENa+N/XrXMF1EGxjEccllbBzzh+tL
	 poRfIuckikq87dLxa/3Ce9LdM9E7yNSJIDcl6rUfdwJMsmB/WKfazNr5+eSxXYwVq2
	 uKiP5U32g+4/e2zMPIdzIONQl8wVstmvW1EcmS5tRcx8Jh5U8I7m2nDuQxfso7lVW0
	 nuS7+No287dIQ==
Date: Thu, 20 Mar 2025 13:19:11 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] rust: device: implement Device::parent()
Message-ID: <Z9wHv-2HXfoYZFmk@pollux>
References: <20250319203112.131959-1-dakr@kernel.org>
 <20250319203112.131959-2-dakr@kernel.org>
 <Z9vTDUnr-G4vmUqS@google.com>
 <CAH5fLggvFanUvysDkZiLqFz4Ay7XSP5LF3CvxBU3xgWE3PSZXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggvFanUvysDkZiLqFz4Ay7XSP5LF3CvxBU3xgWE3PSZXQ@mail.gmail.com>

On Thu, Mar 20, 2025 at 09:40:45AM +0100, Alice Ryhl wrote:
> On Thu, Mar 20, 2025 at 9:34 AM Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 09:30:25PM +0100, Danilo Krummrich wrote:
> > > Device::parent() returns a reference to the device' parent device, if
> > > any.
> > >
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > ---
> > >  rust/kernel/device.rs | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >
> > > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > > index 21b343a1dc4d..76b341441f3f 100644
> > > --- a/rust/kernel/device.rs
> > > +++ b/rust/kernel/device.rs
> > > @@ -65,6 +65,19 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
> > >          self.0.get()
> > >      }
> > >
> > > +    /// Returns a reference to the parent device, if any.
> > > +    pub fn parent<'a>(&self) -> Option<&'a Self> {
> > > +        // SAFETY: By the type invariant `self.as_raw()` is always valid.
> > > +        let parent = unsafe { *self.as_raw() }.parent;
> >
> > This means:
> > 1. Copy the entire `struct device` onto the stack.
> > 2. Read the `parent` field of the copy.
> >
> > Please write this instead to only read the `parent` field:
> > let parent = unsafe { *self.as_raw().parent };
> 
> Sorry I meant (*self.as_raw()).parent

Good catch, thanks! 

