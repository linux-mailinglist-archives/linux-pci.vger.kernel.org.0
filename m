Return-Path: <linux-pci+bounces-24112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B953A68B72
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 12:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFB7164D22
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 11:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C7F253F2B;
	Wed, 19 Mar 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjLefYdT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAF120C480;
	Wed, 19 Mar 2025 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383229; cv=none; b=pIESMOlssiaKwEe5ozqpHiG4HtWY1LuIXOj2+YMu6i0bQlWK6ypPl1VxfIgGPPVSNHP3D3vV3TNUhTSHDow91pDJvfxwGRJwoPDZX+PlBUFx+6ZEx5ZdNv12jdoUCUqxnBSoh5ZEZLPC4whnGflYeZ4bCGfdG1IoZUhCMXtUXsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383229; c=relaxed/simple;
	bh=eiN82U4MpbMqjt065kml1aLmCuStAccfrQ18QCFW9Jw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mNcXsl8RbxdYiOtl09EVo2T4VAcTy7EkQiOfepyroG9LQNLyAdHmu460pUBBaBv4lZ2g86SHmOBEg7vIBiVUuIGRRX0/6GgZ2ncyO6ACjzRLS9SFr0ztuTFqJvHL/X/X5hgKl+Y6lHQpWDjoJKVnIfxKW66fjXc8jjyGFsExJ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjLefYdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F59BC4CEE9;
	Wed, 19 Mar 2025 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742383228;
	bh=eiN82U4MpbMqjt065kml1aLmCuStAccfrQ18QCFW9Jw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jjLefYdTmIXiDDqiP7a9H5MeWDeJJvrzjFaaCvyEglCVF79Nn7HkNzVwi0koE+Ti/
	 iGIEwwMV4ndYgbHRVOYngkGEoILmtI4Ss1UE+0rM8pQnq7R6T0Infj/dy/d0AYYPxk
	 H8bf9g5ydyZXSIPydUgq82J0hE+vwiPSQLXz1ouUsZxcc007BF7LL4QWU9L2IPVAh8
	 P5xNJf8OoIoL+rbonF7NxW+lu3UCD3jyAYnVGE9ME4kGtPS/BsIh9Yl+wDpF0lrUf3
	 6vDYGfIguMpwRAdiUVDCwQxYMNdX4zQA7Iq614LrTCFdNw0MMEG28FGRfIVrT6eBbC
	 d5BTr04zwMvPg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <bhelgaas@google.com>,  <gregkh@linuxfoundation.org>,
  <rafael@kernel.org>,  <ojeda@kernel.org>,  <alex.gaynor@gmail.com>,
  <boqun.feng@gmail.com>,  <gary@garyguo.net>,  <bjorn3_gh@protonmail.com>,
  <benno.lossin@proton.me>,  <aliceryhl@google.com>,  <tmgross@umich.edu>,
  <linux-pci@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: platform: impl Send + Sync for platform::Device
In-Reply-To: <20250318212940.137577-2-dakr@kernel.org> (Danilo Krummrich's
	message of "Tue, 18 Mar 2025 22:29:22 +0100")
References: <20250318212940.137577-1-dakr@kernel.org>
	<v50AuPGR5pLnBdMBsQOf24Mr9fofKOIFO7nzycaqfTk9J1o3banf_YK9Vnz8mxsjB9kk1IdHMJarQpP0q9X_hA==@protonmail.internalid>
	<20250318212940.137577-2-dakr@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 12:20:09 +0100
Message-ID: <87iko5gtcm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Danilo Krummrich" <dakr@kernel.org> writes:

> Commit 4d320e30ee04 ("rust: platform: fix unrestricted &mut
> platform::Device") changed the definition of platform::Device and
> discarded the implicitly derived Send and Sync traits.
>
> This isn't required by upstream code yet, and hence did not cause any
> issues. However, it is relied on by upcoming drivers, hence add it back
> in.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/platform.rs | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index c77c9f2e9aea..2811ca53d8b6 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -233,3 +233,10 @@ fn as_ref(&self) -> &device::Device {
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

Same as for 1/2:

  # git am --show-current-patch=diff | patch -p1
  patching file rust/kernel/platform.rs
  Hunk #1 succeeded at 198 with fuzz 1 (offset -35 lines).


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



