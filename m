Return-Path: <linux-pci+bounces-15510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41809B44DF
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 09:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73581C21FC9
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 08:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3426F20409F;
	Tue, 29 Oct 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVA6647f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C95204091;
	Tue, 29 Oct 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191852; cv=none; b=rgE66PVXi2PrjSeYDlhETlP0x4CyL1UcuLFQsDDJ+hXi9q6SfrzxB0juwaYpdQH12wbF0Q90CAGH8XCgVi2DZpNiEquQOl+gwGWJiLWYt6WwZ3IsOaa5GJgogBc7okAeppvkCt0hohCKDo5TptyK0vbrB6nOJv3rOiGcL223Usc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191852; c=relaxed/simple;
	bh=W5rqZ6tX1MxtmhXIMLhi2lKSnRqfo6Db9jRER9ZOPyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Do4/mR4tVwe8NuoXXMIvVJuePsEW8lRKHXA9HpJ0YSQDO5zOi1LiaVZLHfLx5WAPYGx9jtnenL8F4ONLxiQWQlYrNk3ayUWIa+PTGD0VgQZpbHEMjd0UQlI2jzM29/xkm4a+3XosgXunAG3wnT7tlCx8Im/xwa6nYk77LigtlFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVA6647f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7490EC4CEE4;
	Tue, 29 Oct 2024 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730191851;
	bh=W5rqZ6tX1MxtmhXIMLhi2lKSnRqfo6Db9jRER9ZOPyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVA6647f8jsVVS/EBPiL4UabKzSoJHcWMVtg3lHdmISN4XotY7i60/5uD6Y/lIYXR
	 wBIySdLP2nfpmsHxdi5Kuln0s1Bugqol3C2CUZ+m3QfaO40Wufvh17CVtzCNyhWjYD
	 7MsvaXjKf4JCwtYDUZgv2xPwGRckv+DJ5TCmw3FJ8EfHPRtDg9zwnRjoaGUeey4QR7
	 4MP/9PfR2ysd9bvj+CTQTZWK/sRakYvsEyhBKyxFcqeFfhVDL+iCMGUYINITHlLeDP
	 Dxn14HPC71IrHPs/7ZaosbP/qXyJukGidJO7JdN/UVde15tyg427pV3aWhhdwiVtmh
	 VkWUb7Y78KWrQ==
Date: Tue, 29 Oct 2024 09:50:43 +0100
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
Message-ID: <ZyCh4_hcr6qJJ8jw@pollux>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
 <42a5af26-8b86-45ce-8432-d7980a185bde@de.bosch.com>
 <Zx9lFG1XKnC_WaG0@pollux>
 <fd9f5a0e-b2d4-4b72-9f34-9d8fcc74c00c@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd9f5a0e-b2d4-4b72-9f34-9d8fcc74c00c@de.bosch.com>

On Tue, Oct 29, 2024 at 08:20:55AM +0100, Dirk Behme wrote:
> On 28.10.2024 11:19, Danilo Krummrich wrote:
> > On Thu, Oct 24, 2024 at 11:11:50AM +0200, Dirk Behme wrote:
> > > > +/// IdTable type for platform drivers.
> > > > +pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<of::DeviceId, T>;
> > > > +
> > > > +/// The platform driver trait.
> > > > +///
> > > > +/// # Example
> > > > +///
> > > > +///```
> > > > +/// # use kernel::{bindings, c_str, of, platform};
> > > > +///
> > > > +/// struct MyDriver;
> > > > +///
> > > > +/// kernel::of_device_table!(
> > > > +///     OF_TABLE,
> > > > +///     MODULE_OF_TABLE,
> > > 
> > > It looks to me that OF_TABLE and MODULE_OF_TABLE are quite generic names
> > > used here. Shouldn't they be somehow driver specific, e.g. OF_TABLE_MYDRIVER
> > > and MODULE_OF_TABLE_MYDRIVER or whatever? Same for the other
> > > examples/samples in this patch series. Found that while using the *same*
> > > somewhere else ;)
> > 
> > I think the names by themselves are fine. They're local to the module. However,
> > we stringify `OF_TABLE` in `module_device_table` to build the export name, i.e.
> > "__mod_of__OF_TABLE_device_table". Hence the potential duplicate symbols.
> > 
> > I think we somehow need to build the module name into the symbol name as well.
> 
> Something like this?

No, I think we should just encode the Rust module name / path, which should make
this a unique symbol name.

diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 5b1329fba528..63e81ec2d6fd 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -154,7 +154,7 @@ macro_rules! module_device_table {
     ($table_type: literal, $module_table_name:ident, $table_name:ident) => {
         #[rustfmt::skip]
         #[export_name =
-            concat!("__mod_", $table_type, "__", stringify!($table_name), "_device_table")
+            concat!("__mod_", $table_type, "__", module_path!(), "_", stringify!($table_name), "_device_table")
         ]
         static $module_table_name: [core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
             unsafe { core::mem::transmute_copy($table_name.raw_ids()) };

For the doctests for instance this

  "__mod_of__OF_TABLE_device_table"

becomes

  "__mod_of__doctests_kernel_generated_OF_TABLE_device_table".

> 
> 
> Subject: [PATCH] rust: device: Add the module name to the symbol name
> 
> Make the symbol name unique by adding the module name to avoid
> duplicate symbol errors like
> 
> ld.lld: error: duplicate symbol: __mod_of__OF_TABLE_device_table
> >>> defined at doctests_kernel_generated.ff18649a828ae8c4-cgu.0
> >>> rust/doctests_kernel_generated.o:(__mod_of__OF_TABLE_device_table) in
> archive vmlinux.a
> >>> defined at rust_driver_platform.2308c4225c4e08b3-cgu.0
> >>>            samples/rust/rust_driver_platform.o:(.rodata+0x5A8) in
> archive vmlinux.a
> make[2]: *** [scripts/Makefile.vmlinux_o:65: vmlinux.o] Error 1
> make[1]: *** [Makefile:1154: vmlinux_o] Error 2
> 
> __mod_of__OF_TABLE_device_table is too generic. Add the module name.
> 
> Proposed-by: Danilo Krummrich <dakr@kernel.org>
> Link: https://lore.kernel.org/rust-for-linux/Zx9lFG1XKnC_WaG0@pollux/
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
>  rust/kernel/device_id.rs             | 4 ++--
>  rust/kernel/of.rs                    | 4 ++--
>  rust/kernel/pci.rs                   | 5 +++--
>  rust/kernel/platform.rs              | 1 +
>  samples/rust/rust_driver_pci.rs      | 1 +
>  samples/rust/rust_driver_platform.rs | 1 +
>  6 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> index 5b1329fba528..231f34362da9 100644
> --- a/rust/kernel/device_id.rs
> +++ b/rust/kernel/device_id.rs
> @@ -151,10 +151,10 @@ fn info(&self, index: usize) -> &U {
>  /// Create device table alias for modpost.
>  #[macro_export]
>  macro_rules! module_device_table {
> -    ($table_type: literal, $module_table_name:ident, $table_name:ident) =>
> {
> +    ($table_type: literal, $device_name: literal, $module_table_name:ident,
> $table_name:ident) => {
>          #[rustfmt::skip]
>          #[export_name =
> -            concat!("__mod_", $table_type, "__", stringify!($table_name),
> "_device_table")
> +            concat!("__mod_", $table_type, "__", stringify!($table_name),
> "_", $device_name, "_device_table")
>          ]
>          static $module_table_name: [core::mem::MaybeUninit<u8>;
> $table_name.raw_ids().size()] =
>              unsafe { core::mem::transmute_copy($table_name.raw_ids()) };
> diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
> index a37629997974..77679c30638c 100644
> --- a/rust/kernel/of.rs
> +++ b/rust/kernel/of.rs
> @@ -51,13 +51,13 @@ pub fn compatible<'a>(&self) -> &'a CStr {
>  /// Create an OF `IdTable` with an "alias" for modpost.
>  #[macro_export]
>  macro_rules! of_device_table {
> -    ($table_name:ident, $module_table_name:ident, $id_info_type: ty,
> $table_data: expr) => {
> +    ($device_name: literal, $table_name:ident, $module_table_name:ident,
> $id_info_type: ty, $table_data: expr) => {
>          const $table_name: $crate::device_id::IdArray<
>              $crate::of::DeviceId,
>              $id_info_type,
>              { $table_data.len() },
>          > = $crate::device_id::IdArray::new($table_data);
> 
> -        $crate::module_device_table!("of", $module_table_name,
> $table_name);
> +        $crate::module_device_table!("of", $device_name,
> $module_table_name, $table_name);
>      };
>  }
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 58f7d9c0045b..806d192b9600 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -176,14 +176,14 @@ fn index(&self) -> usize {
>  /// Create a PCI `IdTable` with its alias for modpost.
>  #[macro_export]
>  macro_rules! pci_device_table {
> -    ($table_name:ident, $module_table_name:ident, $id_info_type: ty,
> $table_data: expr) => {
> +    ($device_name: literal, $table_name:ident, $module_table_name:ident,
> $id_info_type: ty, $table_data: expr) => {
>          const $table_name: $crate::device_id::IdArray<
>              $crate::pci::DeviceId,
>              $id_info_type,
>              { $table_data.len() },
>          > = $crate::device_id::IdArray::new($table_data);
> 
> -        $crate::module_device_table!("pci", $module_table_name,
> $table_name);
> +        $crate::module_device_table!("pci", $device_name,
> $module_table_name, $table_name);
>      };
>  }
> 
> @@ -197,6 +197,7 @@ macro_rules! pci_device_table {
>  /// struct MyDriver;
>  ///
>  /// kernel::pci_device_table!(
> +///     "MyDriver",
>  ///     PCI_TABLE,
>  ///     MODULE_PCI_TABLE,
>  ///     <MyDriver as pci::Driver>::IdInfo,
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index a926233a789f..fcdd3c5da0e5 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -118,6 +118,7 @@ macro_rules! module_platform_driver {
>  /// struct MyDriver;
>  ///
>  /// kernel::of_device_table!(
> +///     "MyDriver",
>  ///     OF_TABLE,
>  ///     MODULE_OF_TABLE,
>  ///     <MyDriver as platform::Driver>::IdInfo,
> diff --git a/samples/rust/rust_driver_pci.rs
> b/samples/rust/rust_driver_pci.rs
> index d24dc1fde9e8..6ee570b59233 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -31,6 +31,7 @@ struct SampleDriver {
>  }
> 
>  kernel::pci_device_table!(
> +    "SampleDriver",
>      PCI_TABLE,
>      MODULE_PCI_TABLE,
>      <SampleDriver as pci::Driver>::IdInfo,
> diff --git a/samples/rust/rust_driver_platform.rs
> b/samples/rust/rust_driver_platform.rs
> index fd7a5ad669fe..9dfbe3b9932b 100644
> --- a/samples/rust/rust_driver_platform.rs
> +++ b/samples/rust/rust_driver_platform.rs
> @@ -11,6 +11,7 @@ struct SampleDriver {
>  struct Info(u32);
> 
>  kernel::of_device_table!(
> +    "SampleDriver",
>      OF_TABLE,
>      MODULE_OF_TABLE,
>      <SampleDriver as platform::Driver>::IdInfo,
> -- 
> 2.46.2
> 

