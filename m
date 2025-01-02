Return-Path: <linux-pci+bounces-19151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E67E69FF782
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 10:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0BD162113
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F04194089;
	Thu,  2 Jan 2025 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et+cmj6f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C68191F89;
	Thu,  2 Jan 2025 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735810596; cv=none; b=qgCwkfhWCQEsoKbx68dVHd3/Dk7s9X0IK8PPvPwJiUCaLRrlM7q73HlVzgJ1cQFkbL6Zr/4S44JDLoczqul0lEqqF+NxNyY0QFmvgnWaaFDXa/3tKOLpMBWxK0395BDy1iYI394DuEcD1sjpdRw/Cr0kAHJAC8OSYAjy//1O4vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735810596; c=relaxed/simple;
	bh=m4HpPUCNfrmW1y5TFM5fRmU/JVwN1ECD7vuAH4bP3Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgpEKDPTac0iohMGbvs31VP/RzPkCrOoDP6HZJ9VCe9K4WdKIFVpg94qaB01jIQdlz1CUntKxCRNU8yhnzd8+MhyaNuYIurDCaCe0+XjVrNPBGODYO2YJVTfZHA2O0Ccrp9CxCrsdhnQYAR6SB9xe6e1g8OhaBKo1NAg1kwW5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et+cmj6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C871C4CED0;
	Thu,  2 Jan 2025 09:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735810596;
	bh=m4HpPUCNfrmW1y5TFM5fRmU/JVwN1ECD7vuAH4bP3Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Et+cmj6fgjZE3wJkcRpXGpKlmAbZMYErgLORbnn8UFbVMr3Ex9prJdT9YfoITx0if
	 VbPGLSBVDiZId0LCbBw23hvq8vvtQilCfunH3W2ftNa0ph8BQ/Xcxwy3VnLIQrL2r7
	 E6scUeUjudul+U59E1EPtgDtxipdRm4oS14wtVsqhb2A18JP+iU22IGaYGJYUYG6Lk
	 tkRl6Er2Wwx0kKHKlhZVKhJPG7ejBO9csqeWv9VmkFKo7XuV/0kL4zyH4WtcbeYLla
	 JDk1k8lFyNSJsXGDQryE3BeJvLV0JbjEHVSx0En8HvMcemI+xosgX3gaTFzikgtXWQ
	 plJnGTIjEAR0A==
Date: Thu, 2 Jan 2025 10:36:27 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, paulmck@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	rcu@vger.kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v7 03/16] rust: implement `IdArray`, `IdTable` and
 `RawDeviceId`
Message-ID: <Z3ZeG5NJRJEVGCYi@cassiopeiae>
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-4-dakr@kernel.org>
 <20241224201002.6a69c77c.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224201002.6a69c77c.gary@garyguo.net>

On Tue, Dec 24, 2024 at 08:10:02PM +0000, Gary Guo wrote:
> On Thu, 19 Dec 2024 18:04:05 +0100
> Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > Most subsystems use some kind of ID to match devices and drivers. Hence,
> > we have to provide Rust drivers an abstraction to register an ID table
> > for the driver to match.
> > 
> > Generally, those IDs are subsystem specific and hence need to be
> > implemented by the corresponding subsystem. However, the `IdArray`,
> > `IdTable` and `RawDeviceId` types provide a generalized implementation
> > that makes the life of subsystems easier to do so.
> > 
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Co-developed-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Gary Guo <gary@garyguo.net>
> > Co-developed-by: Fabien Parent <fabien.parent@linaro.org>
> > Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> Thank you for converting my prototype to a working patch. There's a nit below.
> 
> > ---
> >  MAINTAINERS              |   1 +
> >  rust/kernel/device_id.rs | 165 +++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs       |   6 ++
> >  3 files changed, 172 insertions(+)
> >  create mode 100644 rust/kernel/device_id.rs
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2ad58ed40079..3cfb68650347 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7033,6 +7033,7 @@ F:	include/linux/kobj*
> >  F:	include/linux/property.h
> >  F:	lib/kobj*
> >  F:	rust/kernel/device.rs
> > +F:	rust/kernel/device_id.rs
> >  F:	rust/kernel/driver.rs
> >  
> >  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
> > diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> > new file mode 100644
> > index 000000000000..e5859217a579
> > --- /dev/null
> > +++ b/rust/kernel/device_id.rs
> > 
> > <snip>
> >
> > +
> > +impl<T: RawDeviceId, const N: usize> RawIdArray<T, N> {
> > +    #[doc(hidden)]
> > +    pub const fn size(&self) -> usize {
> > +        core::mem::size_of::<Self>()
> > +    }
> > +}
> > +
> 
> This is not necessary, see below.
> 
> > <snip>
> >
> > +
> > +/// Create device table alias for modpost.
> > +#[macro_export]
> > +macro_rules! module_device_table {
> > +    ($table_type: literal, $module_table_name:ident, $table_name:ident) => {
> > +        #[rustfmt::skip]
> > +        #[export_name =
> > +            concat!("__mod_device_table__", $table_type,
> > +                    "__", module_path!(),
> > +                    "_", line!(),
> > +                    "_", stringify!($table_name))
> > +        ]
> > +        static $module_table_name: [core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
> > +            unsafe { core::mem::transmute_copy($table_name.raw_ids()) };
> 
> const_size_of_val will be stable in Rust 1.85, so we can start using the
> feature and 
> 
> static $module_table_name: [core::mem::MaybeUninit<u8>; core::mem::size_of_val($table_name.raw_ids())] =
>     unsafe { core::mem::transmute_copy($table_name.raw_ids()) };
> 
> should work.

Thanks for the note, this indeed saves a few lines.

Since the series has been applied already, feel free to send a patch.

> 
> > +    };
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 7818407f9aac..66149ac5c0c9 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -18,6 +18,11 @@
> >  #![feature(inline_const)]
> >  #![feature(lint_reasons)]
> >  #![feature(unsize)]
> > +// Stable in Rust 1.83
> > +#![feature(const_maybe_uninit_as_mut_ptr)]
> > +#![feature(const_mut_refs)]
> > +#![feature(const_ptr_write)]
> > +#![feature(const_refs_to_cell)]
> >  
> >  // Ensure conditional compilation based on the kernel configuration works;
> >  // otherwise we may silently break things like initcall handling.
> > @@ -35,6 +40,7 @@
> >  mod build_assert;
> >  pub mod cred;
> >  pub mod device;
> > +pub mod device_id;
> >  pub mod driver;
> >  pub mod error;
> >  #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
> 

