Return-Path: <linux-pci+bounces-30315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0FAAE30D3
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 18:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336843AFF1D
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7847B1E7C2E;
	Sun, 22 Jun 2025 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6fpjUXF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5C2AE8E;
	Sun, 22 Jun 2025 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750610481; cv=none; b=c1pRjM4VwZ66+z2LCku8D/sSEOSMJ31HjWhqSK5vfDLmva2yKtnDd3DgDPiow3m957DcLNccmcWF4n4ENfU4/KikRHbSWlAG/rIn8b/06/CH5JIfCXbm+d99oHwIkvf71dRMkWqfMNUu1cgmx42pP9ZimS90g6PCWrLDqjiE5xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750610481; c=relaxed/simple;
	bh=Sgk0d5UKWtMUGyHkYfKjDvC58QxrXe0Ysc8tLDM9kNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YcKrVRXs3o5HtLYr9b5shPCAvsIYp/bubzWV/JVym3NnMvS5hUyH1B5xmM7KTh5IEZiO7+W8MLdCK+L3mJeOTJn5Y1VDM7GFM3r9ktcLVBvgDGZjNBktjPUCvTzoFvvOKxBrAAkYMvSsAElC01P6e+5TMkFbWIcbvnMsbFqY98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6fpjUXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DA1C4CEE3;
	Sun, 22 Jun 2025 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750610480;
	bh=Sgk0d5UKWtMUGyHkYfKjDvC58QxrXe0Ysc8tLDM9kNk=;
	h=From:To:Cc:Subject:Date:From;
	b=Q6fpjUXF8ahre6g4+HpKmuCJPqNsAJCRLLVyF+JjG8LfLJiv6Qnx5TTLrbcqj2o/y
	 6Ek+yhN0CH4c7QlCVfwYmi5s9Z1eg4yTqvgH427uxCs+Rwkhwu9WtwoF3lPWPsPf0z
	 6ANnef5q6qKoJwubx5pxPZoM7n4zlRwU2JeAEprk/JGUVni3wauo2urGmte+FNNEKb
	 6GAW+d7RETiokX4R5b5CUHJfrwOaY8NMeyzrqrKkDuvAV3pQpErIp7rJBvbLFbFlcx
	 D0HYGc9P7rHJqJrsOtJxKzwiBV2PS0tGHH+8FO6/llnZf0lKCiOL6dqkbB4/LyLjmd
	 14J0Qizymhgkg==
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
Subject: [PATCH v2 0/4] Improvements for Devres
Date: Sun, 22 Jun 2025 18:40:37 +0200
Message-ID: <20250622164050.20358-1-dakr@kernel.org>
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
 rust/kernel/devres.rs           | 362 +++++++++++++++++++++++---------
 rust/kernel/drm/driver.rs       |  14 +-
 rust/kernel/pci.rs              |  20 +-
 rust/kernel/revocable.rs        |   6 +-
 samples/rust/rust_driver_pci.rs |  19 +-
 9 files changed, 318 insertions(+), 134 deletions(-)


base-commit: 946d082536c43ed7d394aaba927f3d85eccfc03a
-- 
2.49.0


