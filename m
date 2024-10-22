Return-Path: <linux-pci+bounces-15074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDB79AB9CC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 01:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD7E284657
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8AB1CDA25;
	Tue, 22 Oct 2024 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoXnp6mT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C0615CD52;
	Tue, 22 Oct 2024 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729638233; cv=none; b=agUZZeEnyrjZctA0yR2nrgb1xy2RgWoJYM2ZLiZbilcgyOHHQGsFW8rFNkN5ykNDXxr4jGOuEURZH5tvPb66FZdUDtH1AL3zCsTOU6abkXUD/C9ozGgTxIbT5IP1Guzy2ZVVtuKXzyS9ErGEDi5fhjrrwjFZGYVs3fkAyyLenBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729638233; c=relaxed/simple;
	bh=n8lD8DCqOlH73Gu9VQdGu1O0WqrfAycD1MpavnIEgK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwGvUbJSVUOXhQ8B03vY6MNx+Lu3EZ/UO36MHZ3B1fq11MqFgolGX7QPQpUeaVY/Xukv3FXWBGRpHkNRSOd3CntRDuSXXllTQgid3+0qE8hh3C3hLcJMRmxg4uDpHx2rqAkNsQuS4yPjKsTT9tyZkjy3yqoD+42CwhGfTHeJOoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoXnp6mT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF69C4CEC3;
	Tue, 22 Oct 2024 23:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729638232;
	bh=n8lD8DCqOlH73Gu9VQdGu1O0WqrfAycD1MpavnIEgK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoXnp6mT6m+lDTaXdvJEIlJtW4bAiMGbBfY/KkVwxf/niiZWtXDh0jwsmIk0RF2aC
	 Dtphi9WPKduVkHpN62lAgTa6Ub9xTP/3kNB3SEAQIsaDfFG8sHqhY4KazThi9FOGo5
	 JK8clH2eVpGpkOfp3jryMK3iC2Fo6E5AqrPljxT1H+1LwX4NU/3RvDyzizRvtcxXBG
	 ksKfCJ8DF+0Af7abdCQZCCLNOfOXZLKxOkn+Qht4fLCx1tI8BC6zYFbP2P5jyBE2xd
	 3CEujJ53dLqFyCKADwqeknKlNmE0gfX4vT0xxIEANkP4YBDzjAMbNQeEZYP71IO9mD
	 KYxb2xfmv/w8g==
Date: Tue, 22 Oct 2024 18:03:51 -0500
From: Rob Herring <robh@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 14/16] rust: of: add `of::DeviceId` abstraction
Message-ID: <20241022230351.GA1848992-robh@kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-15-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213221.2383-15-dakr@kernel.org>

On Tue, Oct 22, 2024 at 11:31:51PM +0200, Danilo Krummrich wrote:
> `of::DeviceId` is an abstraction around `struct of_device_id`.
> 
> This is used by subsequent patches, in particular the platform bus
> abstractions, to create OF device ID tables.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS                     |  1 +
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/of.rs               | 63 +++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+)
>  create mode 100644 rust/kernel/of.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d9c512a3e72b..87eb9a7869eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17340,6 +17340,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
>  F:	Documentation/ABI/testing/sysfs-firmware-ofw
>  F:	drivers/of/
>  F:	include/linux/of*.h
> +F:	rust/kernel/of.rs
>  F:	scripts/dtc/
>  F:	tools/testing/selftests/dt/
>  K:	of_overlay_notifier_
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index cd4edd6496ae..312f03cbdce9 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -15,6 +15,7 @@
>  #include <linux/firmware.h>
>  #include <linux/jiffies.h>
>  #include <linux/mdio.h>
> +#include <linux/of_device.h>

Technically, you don't need this for *this* patch. You need 
mod_devicetable.h for of_device_id. Best to not rely on implicit 
includes. I've tried removing it and it still built, so I guess there is 
another implicit include somewhere...

>  #include <linux/pci.h>
>  #include <linux/phy.h>
>  #include <linux/refcount.h>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 3ec690eb6d43..5946f59f1688 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -51,6 +51,7 @@
>  pub mod list;
>  #[cfg(CONFIG_NET)]
>  pub mod net;
> +pub mod of;
>  pub mod page;
>  pub mod prelude;
>  pub mod print;
> diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
> new file mode 100644
> index 000000000000..a37629997974
> --- /dev/null
> +++ b/rust/kernel/of.rs
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Open Firmware abstractions.

s/Open Firmware/Devicetree/

Or keep both that prior versions of this code had. Most of DT/OF today 
is not OpenFirmware.

> +//!
> +//! C header: [`include/linux/of_*.h`](srctree/include/linux/of_*.h)

I haven't quite figured out how this gets used. I guess just a link in 
documentation? I somewhat doubt this file is going to handle all DT
abstractions. That might become quite long. Most of of_address.h and 
of_irq.h I actively don't want to see Rust bindings for because they 
are mainly used by higher level interfaces (e.g. platform dev 
resources). There's a slew of "don't add new users" APIs which I need to 
document. Also, the main header is of.h which wasn't included here.

As of now, only the mod_devicetable.h header is used by this file, so I 
think you should just put it until that changes. Maybe there would be 
some savings if all of mod_devicetable.h was handled by 1 rust file?

> +
> +use crate::{bindings, device_id::RawDeviceId, prelude::*};
> +
> +/// An open firmware device id.
> +#[derive(Clone, Copy)]
> +pub struct DeviceId(bindings::of_device_id);
> +
> +// SAFETY:
> +// * `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and does not add
> +//   additional invariants, so it's safe to transmute to `RawType`.
> +// * `DRIVER_DATA_OFFSET` is the offset to the `data` field.
> +unsafe impl RawDeviceId for DeviceId {
> +    type RawType = bindings::of_device_id;
> +
> +    const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
> +
> +    fn index(&self) -> usize {
> +        self.0.data as _
> +    }
> +}
> +
> +impl DeviceId {
> +    /// Create a new device id from an OF 'compatible' string.
> +    pub const fn new(compatible: &'static CStr) -> Self {
> +        let src = compatible.as_bytes_with_nul();
> +        // Replace with `bindings::of_device_id::default()` once stabilized for `const`.
> +        // SAFETY: FFI type is valid to be zero-initialized.
> +        let mut of: bindings::of_device_id = unsafe { core::mem::zeroed() };
> +
> +        let mut i = 0;
> +        while i < src.len() {
> +            of.compatible[i] = src[i] as _;
> +            i += 1;
> +        }

AFAICT, this loop will go away when C char maps to u8. Perhaps a note 
to that extent or commented code implementing that.

> +
> +        Self(of)
> +    }
> +
> +    /// The compatible string of the embedded `struct bindings::of_device_id` as `&CStr`.
> +    pub fn compatible<'a>(&self) -> &'a CStr {
> +        // SAFETY: `self.compatible` is a valid `char` pointer.
> +        unsafe { CStr::from_char_ptr(self.0.compatible.as_ptr()) }
> +    }

I don't think we need this. The usage model is checking does a node's 
compatible string(s) match a compatible in the table. Most of the time 
we don't even need that. We just need the match data.

Rob

