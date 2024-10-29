Return-Path: <linux-pci+bounces-15513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83E9B45FC
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 10:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9EE61F2353B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 09:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8112C204004;
	Tue, 29 Oct 2024 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpwA/4Di"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461857464;
	Tue, 29 Oct 2024 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195411; cv=none; b=c1Ff3WdO1b1HFWHUU8uWmKmA+Wo4FN1kQV4WtnwtzueLvVhAWRoI++F4S/NQcTrjqHDx9T8Ofk2dycQqnpkQ6NqqyV/qvtnceCD5+wwJBvS7fJIssr95dmiVPhZgZhqUEqBN4ZjIP49mgaxUWcl7G5zR7v2N19VNn0DoCSapwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195411; c=relaxed/simple;
	bh=Jn0ABiK+AWZJNL+SopDLk/VwjOzWfJ+dRnvmXfPerLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4xEXnmz4E9n1Y3u9mzXgleDRSAITARkf1tpnbv1RcxGnDF231EGJlXnaoFgCVFW6z9fwSxk3JY4K+hnK/4rXVVy9GgneSmW1P630PK+5eUdAPivIjKBTn3yOZTSh1q7NyiWIMrMHhGc+ZMiiFRFXh7x2vlEHw1d4LK50Entx/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpwA/4Di; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA727C4CECD;
	Tue, 29 Oct 2024 09:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730195410;
	bh=Jn0ABiK+AWZJNL+SopDLk/VwjOzWfJ+dRnvmXfPerLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpwA/4Didjz6wU9pe1VaxOjA92PTwPSTKvIc4SbmJoiKheldKLF8bqblkst9wvEux
	 jttMvgpdJqQslPsy9eU3THhRvqAXAWK4R5IphqmtCyQLYdn3kPCeMY8/f9tmLOo2iu
	 gSgPhkWyK6xWdpeJmKYDwvUG9oWoJvhE+5l0NWayPvaoxkjGkFHruve+2tLHQwWbeI
	 mIAn8EjQtZYMPMB+W0JZfMxaZYPPVEOkVH/dHe7Cn/5V4hyO9KylfFG5NtUXVPlDu+
	 zU1iB4xZS2E7F69X5zSV3nBqyV7H3eu3BaF3yRa5etVi/UzK9yYhcVqQ3EKLjJ4JFK
	 0fb7pP1fNk51g==
Date: Tue, 29 Oct 2024 10:50:02 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 15/16] rust: platform: add basic platform device /
 driver abstractions
Message-ID: <ZyCvyrb5jsY1O4uX@pollux>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
 <42a5af26-8b86-45ce-8432-d7980a185bde@de.bosch.com>
 <Zx9lFG1XKnC_WaG0@pollux>
 <fd9f5a0e-b2d4-4b72-9f34-9d8fcc74c00c@de.bosch.com>
 <ZyCh4_hcr6qJJ8jw@pollux>
 <8d72e37e-9e27-4857-b0eb-0b1e98cc5610@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d72e37e-9e27-4857-b0eb-0b1e98cc5610@de.bosch.com>

On Tue, Oct 29, 2024 at 10:19:08AM +0100, Dirk Behme wrote:
> On 29.10.2024 09:50, Danilo Krummrich wrote:
> > On Tue, Oct 29, 2024 at 08:20:55AM +0100, Dirk Behme wrote:
> > > On 28.10.2024 11:19, Danilo Krummrich wrote:
> > > > On Thu, Oct 24, 2024 at 11:11:50AM +0200, Dirk Behme wrote:
> > > > > > +/// IdTable type for platform drivers.
> > > > > > +pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<of::DeviceId, T>;
> > > > > > +
> > > > > > +/// The platform driver trait.
> > > > > > +///
> > > > > > +/// # Example
> > > > > > +///
> > > > > > +///```
> > > > > > +/// # use kernel::{bindings, c_str, of, platform};
> > > > > > +///
> > > > > > +/// struct MyDriver;
> > > > > > +///
> > > > > > +/// kernel::of_device_table!(
> > > > > > +///     OF_TABLE,
> > > > > > +///     MODULE_OF_TABLE,
> > > > > 
> > > > > It looks to me that OF_TABLE and MODULE_OF_TABLE are quite generic names
> > > > > used here. Shouldn't they be somehow driver specific, e.g. OF_TABLE_MYDRIVER
> > > > > and MODULE_OF_TABLE_MYDRIVER or whatever? Same for the other
> > > > > examples/samples in this patch series. Found that while using the *same*
> > > > > somewhere else ;)
> > > > 
> > > > I think the names by themselves are fine. They're local to the module. However,
> > > > we stringify `OF_TABLE` in `module_device_table` to build the export name, i.e.
> > > > "__mod_of__OF_TABLE_device_table". Hence the potential duplicate symbols.
> > > > 
> > > > I think we somehow need to build the module name into the symbol name as well.
> > > 
> > > Something like this?
> > 
> > No, I think we should just encode the Rust module name / path, which should make
> > this a unique symbol name.
> > 
> > diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> > index 5b1329fba528..63e81ec2d6fd 100644
> > --- a/rust/kernel/device_id.rs
> > +++ b/rust/kernel/device_id.rs
> > @@ -154,7 +154,7 @@ macro_rules! module_device_table {
> >       ($table_type: literal, $module_table_name:ident, $table_name:ident) => {
> >           #[rustfmt::skip]
> >           #[export_name =
> > -            concat!("__mod_", $table_type, "__", stringify!($table_name), "_device_table")
> > +            concat!("__mod_", $table_type, "__", module_path!(), "_", stringify!($table_name), "_device_table")
> >           ]
> >           static $module_table_name: [core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
> >               unsafe { core::mem::transmute_copy($table_name.raw_ids()) };
> > 
> > For the doctests for instance this
> > 
> >    "__mod_of__OF_TABLE_device_table"
> > 
> > becomes
> > 
> >    "__mod_of__doctests_kernel_generated_OF_TABLE_device_table".
> 
> 
> What implies *one* OF/PCI_TABLE per path (file)?

No, you can still have as many as you want for the same file, you just have to
give them different identifier names -- you can't have two statics with the same
name in one file anyways.

Well, I guess you somehow can (just like the doctests do), but it does make
sense to declare drivers in such a way.

I think as long as we take care that separate Rust modules can't interfere with
each other it's good enough.

> 
> For example adding a second FooDriver example to platform.rs won't be
> possible?

Not unless you change the identifier name unfortunately. But that might be
fixable by putting doctests in separate `mod $(DOCTEST) {}` blocks.

> 
> +/// struct FooDriver;
> +///
> +/// kernel::of_device_table!(
> +///     OF_TABLE,
> +///     MODULE_OF_TABLE,
> +///     <FooDriver as platform::Driver>::IdInfo,
> +///     [
> +///         (of::DeviceId::new(c_str!("test,rust-device2")), ())
> +///     ]
> +/// );
> 
> Best regards
> 
> Dirk
> 
> 
> 
> 

