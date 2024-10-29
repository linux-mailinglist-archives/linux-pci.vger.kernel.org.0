Return-Path: <linux-pci+bounces-15514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0019B463A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 10:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF46B1F2360F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 09:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF238205E16;
	Tue, 29 Oct 2024 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfSP3Fs/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE547205E0E;
	Tue, 29 Oct 2024 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195764; cv=none; b=pi74Qm0ftlCOiCaD0ZYeR3QYvrhNoC2X8f1UMK8sa9J7L6ISu3h9+REnk46egB5TPgos3E35ZLeUKn2h/ARyjHhZ6GYdMk8a8AHf/NXv7d1R5JXNkRAuLjwu7mf/oJk+x7GpjuMMadkNOgN/hAmdp5VcVLRj1yMiYd2HxeDkhFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195764; c=relaxed/simple;
	bh=UfI0Ixag2dwAPeNNXqkWkliOPPIn35EDbuIlsihqvfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NO6aMQ/RYuBcBMTWqdMEBt/GLA5Qc8U1CKslE4wT38ikruzF2aK/gTOoGUVO23n4UZPyS60CGZWzD1iMb9cc5z9sqW/KjIVWrVkPYoyM5M3lqd4mKJwb/Uudix2epSQCygnrE9dk1cbBu1Q3lRSvygvh5029FjniSzggQ2pbrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfSP3Fs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B672C4CECD;
	Tue, 29 Oct 2024 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730195764;
	bh=UfI0Ixag2dwAPeNNXqkWkliOPPIn35EDbuIlsihqvfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bfSP3Fs/igj4q2BI7Wbmal7TBlbwhe5gOC7XZ6mVYWnAR7LfpKDT96KSZf5elhmSo
	 uiIT07lOXtJzmhazpCgzcpa9gVQyzuOsBst41OdB2anow6zKQqVsCVDqjBaaYUnoBt
	 chfVCJRaUc10NUnLj+SrZ1XevkAtMfVZgYnx85FluppP0Jjy+eSiuHZb+Bvc9u2LJJ
	 sy1oB3i1iUDjAOFlSdkYteAaweK5BqEuIYHIoEsaXOMf7UfOzXRqWrzmZDigSxyu+L
	 pW/9UDuy77nlYcNwyn5+ghYHhmF/TkUEXq6drRJKiy+ZRffs31TAVLvc8pTkBMNorq
	 yoVxqRXHeaznw==
Date: Tue, 29 Oct 2024 10:55:56 +0100
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
Message-ID: <ZyCxLLE0Wzem0mzi@pollux>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
 <42a5af26-8b86-45ce-8432-d7980a185bde@de.bosch.com>
 <Zx9lFG1XKnC_WaG0@pollux>
 <fd9f5a0e-b2d4-4b72-9f34-9d8fcc74c00c@de.bosch.com>
 <ZyCh4_hcr6qJJ8jw@pollux>
 <8d72e37e-9e27-4857-b0eb-0b1e98cc5610@de.bosch.com>
 <ZyCvyrb5jsY1O4uX@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyCvyrb5jsY1O4uX@pollux>

On Tue, Oct 29, 2024 at 10:50:11AM +0100, Danilo Krummrich wrote:
> On Tue, Oct 29, 2024 at 10:19:08AM +0100, Dirk Behme wrote:
> > On 29.10.2024 09:50, Danilo Krummrich wrote:
> > > On Tue, Oct 29, 2024 at 08:20:55AM +0100, Dirk Behme wrote:
> > > > On 28.10.2024 11:19, Danilo Krummrich wrote:
> > > > > On Thu, Oct 24, 2024 at 11:11:50AM +0200, Dirk Behme wrote:
> > > > > > > +/// IdTable type for platform drivers.
> > > > > > > +pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<of::DeviceId, T>;
> > > > > > > +
> > > > > > > +/// The platform driver trait.
> > > > > > > +///
> > > > > > > +/// # Example
> > > > > > > +///
> > > > > > > +///```
> > > > > > > +/// # use kernel::{bindings, c_str, of, platform};
> > > > > > > +///
> > > > > > > +/// struct MyDriver;
> > > > > > > +///
> > > > > > > +/// kernel::of_device_table!(
> > > > > > > +///     OF_TABLE,
> > > > > > > +///     MODULE_OF_TABLE,
> > > > > > 
> > > > > > It looks to me that OF_TABLE and MODULE_OF_TABLE are quite generic names
> > > > > > used here. Shouldn't they be somehow driver specific, e.g. OF_TABLE_MYDRIVER
> > > > > > and MODULE_OF_TABLE_MYDRIVER or whatever? Same for the other
> > > > > > examples/samples in this patch series. Found that while using the *same*
> > > > > > somewhere else ;)
> > > > > 
> > > > > I think the names by themselves are fine. They're local to the module. However,
> > > > > we stringify `OF_TABLE` in `module_device_table` to build the export name, i.e.
> > > > > "__mod_of__OF_TABLE_device_table". Hence the potential duplicate symbols.
> > > > > 
> > > > > I think we somehow need to build the module name into the symbol name as well.
> > > > 
> > > > Something like this?
> > > 
> > > No, I think we should just encode the Rust module name / path, which should make
> > > this a unique symbol name.
> > > 
> > > diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> > > index 5b1329fba528..63e81ec2d6fd 100644
> > > --- a/rust/kernel/device_id.rs
> > > +++ b/rust/kernel/device_id.rs
> > > @@ -154,7 +154,7 @@ macro_rules! module_device_table {
> > >       ($table_type: literal, $module_table_name:ident, $table_name:ident) => {
> > >           #[rustfmt::skip]
> > >           #[export_name =
> > > -            concat!("__mod_", $table_type, "__", stringify!($table_name), "_device_table")
> > > +            concat!("__mod_", $table_type, "__", module_path!(), "_", stringify!($table_name), "_device_table")
> > >           ]
> > >           static $module_table_name: [core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
> > >               unsafe { core::mem::transmute_copy($table_name.raw_ids()) };
> > > 
> > > For the doctests for instance this
> > > 
> > >    "__mod_of__OF_TABLE_device_table"
> > > 
> > > becomes
> > > 
> > >    "__mod_of__doctests_kernel_generated_OF_TABLE_device_table".
> > 
> > 
> > What implies *one* OF/PCI_TABLE per path (file)?
> 
> No, you can still have as many as you want for the same file, you just have to
> give them different identifier names -- you can't have two statics with the same
> name in one file anyways.
> 
> Well, I guess you somehow can (just like the doctests do), but it does make
> sense to declare drivers in such a way.
> 
> I think as long as we take care that separate Rust modules can't interfere with
> each other it's good enough.
> 
> > 
> > For example adding a second FooDriver example to platform.rs won't be
> > possible?
> 
> Not unless you change the identifier name unfortunately. But that might be
> fixable by putting doctests in separate `mod $(DOCTEST) {}` blocks.

Another option would be to not only encode the module path, but also the line
number:

diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 5b1329fba528..7956edbbad52 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -154,7 +154,7 @@ macro_rules! module_device_table {
     ($table_type: literal, $module_table_name:ident, $table_name:ident) => {
         #[rustfmt::skip]
         #[export_name =
-            concat!("__mod_", $table_type, "__", stringify!($table_name), "_device_table")
+            concat!("__mod_", $table_type, "__", module_path!(), "_", line!(), "_", stringify!($table_name), "_device_table")
         ]
         static $module_table_name: [core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
             unsafe { core::mem::transmute_copy($table_name.raw_ids()) };

This way you'll get

  "__mod_of__doctests_kernel_generated_3875_OF_TABLE_device_table"
  "__mod_of__doctests_kernel_generated_3946_OF_TABLE_device_table"

if you put identical doctests.

> 
> > 
> > +/// struct FooDriver;
> > +///
> > +/// kernel::of_device_table!(
> > +///     OF_TABLE,
> > +///     MODULE_OF_TABLE,
> > +///     <FooDriver as platform::Driver>::IdInfo,
> > +///     [
> > +///         (of::DeviceId::new(c_str!("test,rust-device2")), ())
> > +///     ]
> > +/// );
> > 
> > Best regards
> > 
> > Dirk
> > 
> > 
> > 
> > 

