Return-Path: <linux-pci+bounces-24113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B963A68B74
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 12:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BB6461B05
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6950E25524F;
	Wed, 19 Mar 2025 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuUXWWw+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E44D253B60;
	Wed, 19 Mar 2025 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383233; cv=none; b=M6ic+fEhCE+eYBTfnV/9VRX288I8XqQV04Ve1ZgXZXaUk0kQhNGUjjgnpgT9BdpzEyLVZUaJD+vhMFe/j58V2yUvBCqovKjAxwZyeb+Ahybmjv1tFoN9A/pOG2GrZR5VgXNxUaPOd6kzL7YfZaltEswsfa6NovrLW8ASQX/4Fqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383233; c=relaxed/simple;
	bh=B+17j5jolfdx3WXL9Gf2rnba3jqFhU90Ia7tK66cMlw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bA68FI5dt/vw/eRoOD7OPnxlMl8bRKBCfO3cuRrgyIHGPfxLCyZtm0o6zHIMD2QOPqe2qWJCNmVRz8F6ivIKaWIX3MpZZlsQTqV0QPJYqyJbVR57A3JC174e0OAtTWALG5SDyFwKuEcPtLlDTeB1gPCDxA79LUQFR3/M3hBe6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuUXWWw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEB2C4CEF0;
	Wed, 19 Mar 2025 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742383232;
	bh=B+17j5jolfdx3WXL9Gf2rnba3jqFhU90Ia7tK66cMlw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EuUXWWw+NeeLGBB3nCjSsozR6iGNlrYLwWvH2lLXJj10zj04Wkm661PTmnn4WJau4
	 NeL14YD3/Rifdaj7q8rVNLhW7JZWtbZc9d/oiR+DmKiX0wgWPbPyZ1t4E3kos0cgax
	 C6zcZ6LJvZwpryUVSzBd9FxmnUAOMke3YlBoDgo7esh+7HSvbxBArioiJb5MTam7za
	 vdX5acEElMKAPfqB2b93XaYqQ0FHKMLfI9YTqknoI5PG0Pa8KWeN4PIJIuFgJNWr2v
	 hJuqgyfcYRUOmmvpjYPwQRp/n36IX8jDTo2NjiN0HaGFo2gtP+xjwGhxnGLKCc6MoI
	 Gx0sPk8zo+qAg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <bhelgaas@google.com>,  <gregkh@linuxfoundation.org>,
  <rafael@kernel.org>,  <ojeda@kernel.org>,  <alex.gaynor@gmail.com>,
  <boqun.feng@gmail.com>,  <gary@garyguo.net>,  <bjorn3_gh@protonmail.com>,
  <benno.lossin@proton.me>,  <aliceryhl@google.com>,  <tmgross@umich.edu>,
  <linux-pci@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: pci: impl Send + Sync for pci::Device
In-Reply-To: <20250318212940.137577-1-dakr@kernel.org> (Danilo Krummrich's
	message of "Tue, 18 Mar 2025 22:29:21 +0100")
References: <ddLRqqXuFiaRVyCNUWk5k3cc0pJCteUQ5tBxGr5_7QXDeygE0d-YFc9nbJD0pNJ8RjZ3nCaWOCM56r0ZWmWdJw==@protonmail.internalid>
	<20250318212940.137577-1-dakr@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 12:18:35 +0100
Message-ID: <87o6xxgtf8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Danilo Krummrich" <dakr@kernel.org> writes:

> Commit 7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
> changed the definition of pci::Device and discarded the implicitly
> derived Send and Sync traits.
>
> This isn't required by upstream code yet, and hence did not cause any
> issues. However, it is relied on by upcoming drivers, hence add it back
> in.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/pci.rs | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 0ac6cef74f81..0d09ae34a64d 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -465,3 +465,10 @@ fn as_ref(&self) -> &device::Device {
>          unsafe { device::Device::as_ref(dev) }
>      }
>  }
> +
> +// SAFETY: A `Device` is always reference-counted and can be released from any thread.
> +unsafe impl Send for Device {}
> +
> +// SAFETY: `Device` can be shared among threads because all methods of `Device`
> +// (i.e. `Device<Normal>) are thread safe.
> +unsafe impl Sync for Device {}
>
> base-commit: 4d320e30ee04c25c660eca2bb33e846ebb71a79a

I can't find the base-commit and the patch does not apply clean on v6.14-rc7:

  patching file rust/kernel/pci.rs
  Hunk #1 succeeded at 432 with fuzz 1 (offset -33 lines).

Otherwise looks good. You might want to rebase?


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



