Return-Path: <linux-pci+bounces-18115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8499ECACD
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 12:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A71B1889163
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361DB1A8408;
	Wed, 11 Dec 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MasPMn0r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0195F239BCB;
	Wed, 11 Dec 2024 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914831; cv=none; b=Kzib8jjpjG7BsSl0ljZx7Qu7+f8Otp9DCcPgPED3onz6CTf7/+cHBUbIuMG2YqmbDYlNmrO0zW2v9WDIx+rSiTf5AN0GbehiMgNQLyU8uv+rTEDYqATSDCOmkLyal7ONY5PFWGhg7s/MNaJ6Imp8S5mc5lDt+Qxyrtv76dH1I/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914831; c=relaxed/simple;
	bh=4OzPg3WyJaJKdfR65t5nQR/nppUaqHxzmltFY/EM0Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvtHqLpYlyJ+1mdo6NqyJx5ff3ICPjvm0BTfyN1uJJ6JTKgwusfsHZtKqDnkkvA4OHRA20gG+1gPKlO1xxJer3vJHXLO9Ceifp+Ey/PwSC21H0GsmT3VGRKqvsVqHVUL4Hl+Lcm3VZraP9X11Ans43RcDQ6YyGj7B1/akV/JcMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MasPMn0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DAAC4CED2;
	Wed, 11 Dec 2024 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733914830;
	bh=4OzPg3WyJaJKdfR65t5nQR/nppUaqHxzmltFY/EM0Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MasPMn0r40dd6N6g9uhAiJK2oRd8DGgx0Hthbfz4wzmwHiiQ1WPQb4mwSXYJsfpjz
	 5So5nsBG2XKwIKw3QQf21w99qbQkV+g93JSajw4XDFuEdxk+U7qaM8KF1o0XwoqDBC
	 uPlZKgU3e2hY/W5MseUb8VbtpWav1ZiLTV1lHRuA=
Date: Wed, 11 Dec 2024 11:59:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 01/16] rust: pass module name to `Module::init`
Message-ID: <2024121128-mutt-twice-acda@gregkh>
References: <20241210224947.23804-1-dakr@kernel.org>
 <20241210224947.23804-2-dakr@kernel.org>
 <2024121112-gala-skincare-c85e@gregkh>
 <2024121111-acquire-jarring-71af@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024121111-acquire-jarring-71af@gregkh>

On Wed, Dec 11, 2024 at 11:48:23AM +0100, Greg KH wrote:
> On Wed, Dec 11, 2024 at 11:45:20AM +0100, Greg KH wrote:
> > On Tue, Dec 10, 2024 at 11:46:28PM +0100, Danilo Krummrich wrote:
> > > In a subsequent patch we introduce the `Registration` abstraction used
> > > to register driver structures. Some subsystems require the module name on
> > > driver registration (e.g. PCI in __pci_register_driver()), hence pass
> > > the module name to `Module::init`.
> > 
> > Nit, we don't need the NAME of the PCI driver (well, we do like it, but
> > that's not the real thing), we want the pointer to the module structure
> > in the register_driver call.
> > 
> > Does this provide for that?  I'm thinking it does, but it's not the
> > "name" that is the issue here.
> 
> Wait, no, you really do want the name, don't you.  You refer to
> "module.0" to get the module structure pointer (if I'm reading the code
> right), but as you have that pointer already, why can't you just use
> module->name there as well as you have a pointer to a valid module
> structure that has the name already embedded in it.

In digging further, it's used by the pci code to call into lower layers,
but why it's using a different string other than the module name string
is beyond me.  Looks like this goes way back before git was around, and
odds are it's my fault for something I wrote a long time ago.

I'll see if I can just change the driver core to not need a name at all,
and pull it from the module which would make all of this go away in the
end.  Odds are something will break but who knows...

thanks,

greg k-h

