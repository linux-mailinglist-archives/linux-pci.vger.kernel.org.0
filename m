Return-Path: <linux-pci+bounces-7712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 251808CAB59
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 11:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBBFF281EE0
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 09:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D1B61664;
	Tue, 21 May 2024 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yszcimwy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3C56763;
	Tue, 21 May 2024 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285578; cv=none; b=hGVulJzO6RFxg5LWodrh2JWLLu6a7TBGzQbeZ01Sr8NMapVYkXsHC0+3MwofYFlcVEbm1L4mKYv7dTuuwH6fH3qHciVKCqVmOZdw0/25+q3d3y+Iq6SMayeRftcdmktuiBXBUHBZ+qxJc7MXmr8N4UnaBIbRaO3hXntCoh5JJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285578; c=relaxed/simple;
	bh=xfWhlHbdXog64Mscjfj1ATrii7G5sb/JK0wl+AddZTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha5W72OtfRKLaKu5pAF0Vg6G9vQYQ9xLbxumzOgGY5ihE7nv0SHbw+TPAPR7m3MPhvUUB9L2stt9BmeotTNBP4HJj0WZlJd0sFMcn5jG4zJV74b0ek0QowiWvXqgc/6Gv3PkfEq9Upy2+fOnfOa4IUBl8WZFedSWEHsKy502H3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yszcimwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A90C2BD11;
	Tue, 21 May 2024 09:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716285578;
	bh=xfWhlHbdXog64Mscjfj1ATrii7G5sb/JK0wl+AddZTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YszcimwycM+IexTz0jrEP8E1xDPyyLZSdnrf55ZBaRCTBl1Z32sFg2y/o04kDfJIM
	 J9Mmp4eWJk5PV2MDSnDoq43cqd+AcvgR/HRnLRCbMTP6nHY6vxZLScbJTXDuZsLzbg
	 P+HnCKR88qUgsXY0v2pEByLIx/IjqRddliCZnV60=
Date: Tue, 21 May 2024 11:59:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] rust: add driver abstraction
Message-ID: <2024052140-unchanged-huntress-1ea4@gregkh>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-3-dakr@redhat.com>
 <2024052045-lived-retiree-d8b9@gregkh>
 <ZkvPDbAQLo2/7acY@pollux.localdomain>
 <2024052155-pulverize-feeble-49bb@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052155-pulverize-feeble-49bb@gregkh>

On Tue, May 21, 2024 at 11:35:43AM +0200, Greg KH wrote:
> On Tue, May 21, 2024 at 12:30:37AM +0200, Danilo Krummrich wrote:
> > > > +impl<T: DriverOps> Drop for Registration<T> {
> > > > +    fn drop(&mut self) {
> > > > +        if self.is_registered {
> > > > +            // SAFETY: This path only runs if a previous call to `T::register` completed
> > > > +            // successfully.
> > > > +            unsafe { T::unregister(self.concrete_reg.get()) };
> > > 
> > > Can't the rust code ensure that this isn't run if register didn't
> > > succeed?  Having a boolean feels really wrong here (can't that race?)
> > 
> > No, we want to automatically unregister once this object is destroyed, but not
> > if it was never registered in the first place.
> > 
> > This shouldn't be racy, we only ever (un)register things in places like probe()
> > / remove() or module_init() / module_exit().
> 
> probe/remove never calls driver_register/unregister on itself, so that's
> not an issue.  module_init/exit() does not race with itself and again,
> module_exit() is not called if module_init() fails.
> 
> Again, you are adding logic here that is not needed.  Or if it really is
> needed, please explain why the C code does not need this today and let's
> work to fix that.

And, to be more explicit, a driver should not have any state of its own,
any "internal state" should always be bound to the device that it is
controlling, NOT generic to the driver itself, as a driver can, and
should, be able to control multiple devices all at the same time without
ever knowing anything is going on.  A driver is just code, not data or
state.

Yes, we have bad examples in the kernel where drivers do keep
independent state, but those are the exceptions, never the rule, and I
would argue, should be fixed to not do that.  Most were due to being
created before the driver model existed, or programmers being lazy :)

thanks,

greg k-h

