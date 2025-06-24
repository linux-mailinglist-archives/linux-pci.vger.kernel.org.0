Return-Path: <linux-pci+bounces-30555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A58EAE71C0
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 23:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99C9178CEF
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 21:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E6725A63D;
	Tue, 24 Jun 2025 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYAUjcqw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1972550A4;
	Tue, 24 Jun 2025 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802168; cv=none; b=Nf/NsezkHaOiGRNk471WwrpA+oMhWKIenVOEyDwLxA/N07dAQGY8NtQmKnrtAhyisi9XoBU4ghLJh0rqjqIHmwd4Kt1yxW2VUQtM1oG9A2xo0EOap9hZDj5d80Y8QAMk41sGkGR5kKBn+od3YKN8Ho0CTBkN+v40xaIGFt7q1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802168; c=relaxed/simple;
	bh=JRa97lfPaZOPo8bGvoEroFHrSxN0ICPZca9EWd5GZ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCyWH0B+1Kw8o/ilupjiRoWFrkaukgMfRglaQSmKzEuzralTmGM+dXwicoEzJwT8C9ooxDDZ4LDOBUREGt/IM8dF1INJogow8/+eWEbUKumG45QQtp/sgfYNI0TzGizTm9BuRHaD6cwylWQ8aIcWiHaXr33H3PG23E9JeaWHSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYAUjcqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E48AC4CEE3;
	Tue, 24 Jun 2025 21:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750802167;
	bh=JRa97lfPaZOPo8bGvoEroFHrSxN0ICPZca9EWd5GZ7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=gYAUjcqwjPhzMHl2io5vhXV5qO/D7WVWZF//d5XlNsRtjv7Kdk/QPRQk1Hd4J51FJ
	 pGo2HE/ubtdkXSAu1CuQhoEoFpE7/DG2d1N/cHVXOOLzpGuNB2gV50xF880ZvXkB6E
	 0ZdzQWE/YkmzNX+hxHrVWUhOL2NDmXwXfLoJHcf+afUf8YjH8L++CRLUU4Ya4ZRkAs
	 mONi0Mi4nIkF3ivKkl12bRyRLodvlbp5rROLJIgjwuEYU1GzAfGDbZFAYIlWjQBdrL
	 9laxL61TwqZNnAhyIUfVmlAsEWfR66pEHLsIsNNZ6tyOH7lBfdXO4DX84uxxL3+xm4
	 XNAvYc2foPN0g==
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
Subject: [PATCH v3 0/4] Improvements for Devres
Date: Tue, 24 Jun 2025 23:53:58 +0200
Message-ID: <20250624215600.221167-1-dakr@kernel.org>
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

Danilo Krummrich (4):
  rust: revocable: support fallible PinInit types
  rust: devres: replace Devres::new_foreign_owned()
  rust: devres: get rid of Devres' inner Arc
  rust: devres: implement register_release()

 drivers/gpu/nova-core/driver.rs |   7 +-
 drivers/gpu/nova-core/gpu.rs    |   6 +-
 rust/helpers/device.c           |   7 +
 rust/kernel/cpufreq.rs          |  11 +-
 rust/kernel/devres.rs           | 372 +++++++++++++++++++++++---------
 rust/kernel/drm/driver.rs       |  14 +-
 rust/kernel/pci.rs              |  20 +-
 rust/kernel/revocable.rs        |   6 +-
 samples/rust/rust_driver_pci.rs |  19 +-
 9 files changed, 327 insertions(+), 135 deletions(-)


base-commit: d752224c81ec2e5c0e86635c4b1cc835f9ca4151
-- 
2.49.0

