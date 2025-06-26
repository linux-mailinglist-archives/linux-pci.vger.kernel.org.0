Return-Path: <linux-pci+bounces-30820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C298AEA79A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E012177B44
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB72A215191;
	Thu, 26 Jun 2025 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFkD0Ozu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A9203706;
	Thu, 26 Jun 2025 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968061; cv=none; b=kebGkfBDPhqyiX2AkomfMx4DL37n2Dy40VQq65aIlGXEg+od3vF8QAAlSm4b+p1lxkwfoM6eZIdpdgSMuwQUCIHx+mvS02LrcXzfy6CdBAmHzBn30lm2jKlxLwC0clDh76Gukx3IFHxXuy4PP/G8aBUaJPfP4teIUViXACMYoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968061; c=relaxed/simple;
	bh=NOy9Y3ciqqS6T9tSszDCtRx8iD4avruD6fPvrBwcEnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtM9mP0wYgeylT2SSh/aaK2rxotmkTNZZ1PLDYunINSOKdKBjWXZmpQLdwjSIAWC24kwH6RGcuMYyUeQwn1uOu77HKI9a6woe9bVw3JhYqEaMKdI3uWszHY3N2FtEa/PvDiq2jy2DtO9GJ3xY3UMuWrcmxqenqUxYBUjNEtMsnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFkD0Ozu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FDEC4CEEB;
	Thu, 26 Jun 2025 20:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750968061;
	bh=NOy9Y3ciqqS6T9tSszDCtRx8iD4avruD6fPvrBwcEnU=;
	h=From:To:Cc:Subject:Date:From;
	b=WFkD0OzuYSAfTGms9/4M1NA73AYVCJ5kNW5mY+WslIXIceiLMwcMwq+DDcJeutZ9X
	 XAI+Xrpe3yM5ycaoW6WadEBNfONuTuOMbd3Ropiq+tBRsybSOjWhy6yK7pUWr+Em99
	 b8MyDbuUwHkTjnvBtI5w4AUxbcL43CLU87vos8DSOKZ8GavfILc+gKzuxvAtCFyFYn
	 DS1mfi1tuP20c/S1t56WsBhxelSPUL4xYOWjHD2H+Zfoo57J2nrqm7e/OyGD8ulREW
	 2SDlJkKZ7gJ4BIwaFwT5ysBz/AR1Aa0ltl0s+I07afvtn5CrWzXpf3XWyZ1Mn2psqu
	 4Ei7Wt/SIEWMA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 0/5] Improvements for Devres
Date: Thu, 26 Jun 2025 22:00:38 +0200
Message-ID: <20250626200054.243480-1-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series provides some optimizations for Devres:

  1) Provide a more lightweight replacement for Devres::new_foreign_owned().

  2) Get rid of Devres' inner Arc and instead consume and provide an
     impl PinInit instead.

     Additionally, having the resulting explicit synchronization in
     Devres::drop() prevents potential subtle undesired side effects of the
     devres callback dropping the final Arc reference asynchronously within
     the devres callback.

  3) An optimization for when we never need to access the resource or release
     it manually.

Thanks to Alice and Benno for some great offline discussions on this topic.

This patch series depends on the Opaque patch in [1] and the pin-init patch in
[2], which Benno will provide a signed tag for. A branch containing the patches
can be found in [3].

[1] https://lore.kernel.org/lkml/20250610-b4-rust_miscdevice_registrationdata-v6-1-b03f5dfce998@gmail.com/
[2] https://lore.kernel.org/rust-for-linux/20250529081027.297648-2-lossin@kernel.org/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/devres

Changes in v4:
  - devres::register:
    - require T: Send and ForeignOwnable: Send
  - Devres:
    - require T: Send
    - document possible changes when switching from Opaque to UnsafePinned, once
      possible
  - devres::register_release():
    - rework to Benno's proposal of Release::Ptr
    - require P::Target: Send
  - add a patch adding ForeignOwnable::Target, i.e. the type of the payload data
    (required for devres::register_release())

Changes in v3:
  - devres::register:
    - add 'static bound for ForeignOwnable
    - use drop() instead of `let _ =`
  - Devres:
    - use ptr::from_ref() instead of Inner::as_ptr()
    - use &raw mut instead of addr_of_mut!()
    - use SAFETY comment proposal from Benno
    - add invariant for `Devres::inner`
    - use ScopeGuard in devres_callback()
  - devres::register_release():
    - add impl<T: Release> Release for &T
    - add 'static bound for ForeignOwnable
    - use drop() instead of `let _ =`

Changes in v2:
  - Revocable:
    - remove Error: From<E> bound
  - devres::register:
    - rename devres::register_foreign_boxed() to just devres::register()
    - move T: 'static bound to the function rather than the impl block
  - Devres:
    - Fix aliasing issue by using an Opaque<Inner>; should be
      UnsafePinned<Inner> once available.
    - Add doc-comments for a couple of private fields.
    - Link Revocable on 'revoke' in Devres::new().
  - devres::register_release():
    - expand documentation of Release
    - rename devres::register_foreign_release() for devres::register_release()

Danilo Krummrich (5):
  rust: revocable: support fallible PinInit types
  rust: devres: replace Devres::new_foreign_owned()
  rust: devres: get rid of Devres' inner Arc
  rust: types: ForeignOwnable: Add type Target
  rust: devres: implement register_release()

 drivers/gpu/nova-core/driver.rs |   7 +-
 drivers/gpu/nova-core/gpu.rs    |   6 +-
 rust/helpers/device.c           |   7 +
 rust/kernel/alloc/kbox.rs       |   2 +
 rust/kernel/cpufreq.rs          |  11 +-
 rust/kernel/devres.rs           | 361 +++++++++++++++++++++++---------
 rust/kernel/drm/driver.rs       |  14 +-
 rust/kernel/pci.rs              |  20 +-
 rust/kernel/revocable.rs        |   6 +-
 rust/kernel/sync/arc.rs         |   1 +
 rust/kernel/types.rs            |   4 +
 samples/rust/rust_driver_pci.rs |  19 +-
 12 files changed, 323 insertions(+), 135 deletions(-)


base-commit: 7be11f5d927a548254be5c07291b32a6aa50917f
-- 
2.49.0


