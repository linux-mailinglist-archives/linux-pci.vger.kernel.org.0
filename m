Return-Path: <linux-pci+bounces-24278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3CFA6B1C9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 00:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA504A3BC1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 23:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2E41FC7D9;
	Thu, 20 Mar 2025 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io8c09ag"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E916F858;
	Thu, 20 Mar 2025 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514378; cv=none; b=BwKUtguLQadt5gUamHK9EPtpeT5KXl94ZkkUQUo+KBo5hAODjsGkple7Q2Q++ZrK5WzpoZyGGfktM5qLNKcGITPFkCBbSgF+438rRWoWKp5FZHPLXeLPe43fpHJCgXA9scN8PzfVLInMuRHa+Y9+Wu8f1RM26TZ+NxOzfzHaiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514378; c=relaxed/simple;
	bh=zR8JiUrDg+oxQxUIYSvuZe8YOVCm4FlpHS4YNTD0jTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZIkJrsEi4wQ4KE9Bjh9Eg01kJr3pxwUWbv6FubQ+/h9DxgHdbKdBikBdv81Jta1me8QMcmyGwOJH/xJ57NxlZUwmH/bo3FVEvoih5roKDOTyHXLbM9ehlvvIvwUnP02OrzmKyLtUcBGZ8G5DDWVt4Af08EXQHHsWqZPozM91Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io8c09ag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B298BC4CEDD;
	Thu, 20 Mar 2025 23:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742514375;
	bh=zR8JiUrDg+oxQxUIYSvuZe8YOVCm4FlpHS4YNTD0jTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=io8c09agAtlCsPGrCUDW99b3kitPIXLS9aqowx51n2/+C4KNJWMZOYWDv3gdz4WAx
	 uIM8IhwuGfPO09JVCLoFb7DrbtiXKAoxRS7S6RAl7TgcjFwRkO4pMXLFpYNurO9IP2
	 pWwmj/sJx+sAjU2+pIj8T5r2KqU3m3x7NF+2ayoNcCv47YoFI+LDBufG82T+YeBXPv
	 h8e56mi6fNOcnoJwxMK2dxz1V7mGryo94P+enyiAygSXcNbsW5Y6s80I114lx/ZGx3
	 xsSpwAlxMesymAy2BbFO7C/jdGPwApRSH8+sjynmIAi0fRmSARjsSVzLbr0qPLtLgv
	 OFNkxH9ol+7Og==
Date: Fri, 21 Mar 2025 00:46:09 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] rust: device: implement Device::parent()
Message-ID: <Z9yowSwzNQqPzc0r@cassiopeiae>
References: <20250320222823.16509-1-dakr@kernel.org>
 <20250320222823.16509-2-dakr@kernel.org>
 <D8LGHC6DMPIW.29Y3XD1X6Q1L3@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8LGHC6DMPIW.29Y3XD1X6Q1L3@proton.me>

On Thu, Mar 20, 2025 at 10:44:38PM +0000, Benno Lossin wrote:
> On Thu Mar 20, 2025 at 11:27 PM CET, Danilo Krummrich wrote:
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
> Why is this valid for `'static`? Since you declare the lifetime `'a`
> independently from the elided one on `&self`, the user can set it to
> `'static`.

Good catch -- this is indeed a problem when the &Device comes from an
ARef<Device>, rather than Device::as_ref(), which is what I had in mind
originally.

