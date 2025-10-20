Return-Path: <linux-pci+bounces-38818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67154BF3ED9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11607351B33
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 22:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD9D2F3C38;
	Mon, 20 Oct 2025 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH4kT+yg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F342F2916;
	Mon, 20 Oct 2025 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999757; cv=none; b=VL9GjYXvS8V8ZbjviaKsOtNlCx2ZdTbR7DrO3cIdnz9smgVR83O9t0teumjkRilHZlfkYqa1wBeMCw8yB5TPgZ5lUN5ec1nNClS/ATgtEmOrpBI2g5nj0MYheTmPhmxxvoCqnsVEsOUjjV1i3JmcetE9EGyIBk/Aot+UAofzF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999757; c=relaxed/simple;
	bh=mpG5xoWCQZD3UulIuc3X/ziKsLxEWBQwq/RQZw4SiIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aexMMYnybXlSfBiSkOY6FhhuZam1ZtlQ/Vpa6ybPcppeeQ30ywzF1lVItwep+8UO/E+7TflskIg5Fi8FwOOkgKviEuau9URnWu9Gu2Eff+TzkjZtNE8X/F5ziPNpWaEE4UPQ/Y1X5KWTn5PiPAODgjKvU+SAKAmSNMI8RoHOTMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH4kT+yg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3F2C113D0;
	Mon, 20 Oct 2025 22:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999757;
	bh=mpG5xoWCQZD3UulIuc3X/ziKsLxEWBQwq/RQZw4SiIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RH4kT+ygl25+07mFqPnKK3XVjzsVFZRyx+BdGJP4tUONSuPNLCK47lrRINNa5Cp/7
	 cM83JwuT9FNn4uqrM8pEh8HB6tf58FDgBk7j/WtgSaF610YK8sBZI5EOQHmDHqTnPD
	 FsbgMaEH8fwW3spCgNb8TIKWQ6f6Y3Qj3vG0QWBYgoXzEawN6fHRVlgt1MPipszhlI
	 PoEQhV1Xe4r7Vl4bVu1kqE7I/3ScRLeIAWQosvojPIQzTwWxAeRu9mn7qlPcmVuvpv
	 xYG3UPZL92ChOegkNPObPXdnBw2/HZfPn3IAEKU11TtDL2Up5xh40mvQGnxTF9lpnl
	 zvUVDilPLLhjw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	acourbot@nvidia.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	pcolberg@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 5/8] rust: auxiliary: move parent() to impl Device
Date: Tue, 21 Oct 2025 00:34:27 +0200
Message-ID: <20251020223516.241050-6-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020223516.241050-1-dakr@kernel.org>
References: <20251020223516.241050-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the parent method is implemented for any Device<Ctx>, i.e.
any device context and returns a &device::Device<Normal>.

However, a subsequent patch will introduce

	impl Device<Bound> {
	    pub fn parent() -> device::Device<Bound> { ... }
	}

which takes advantage of the fact that if the auxiliary device is bound
the parent is guaranteed to be bound as well.

I.e. the behavior we want is that all device contexts that dereference
to Bound, will use the implementation above, whereas the old
implementation should only be implemented for Device<Normal>.

Hence, move the current implementation.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 8c0a2472c26a..497601f7473b 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -215,15 +215,15 @@ pub fn id(&self) -> u32 {
         // `struct auxiliary_device`.
         unsafe { (*self.as_raw()).id }
     }
+}
 
+impl Device {
     /// Returns a reference to the parent [`device::Device`].
     pub fn parent(&self) -> &device::Device {
         // SAFETY: A `struct auxiliary_device` always has a parent.
         unsafe { self.as_ref().parent().unwrap_unchecked() }
     }
-}
 
-impl Device {
     extern "C" fn release(dev: *mut bindings::device) {
         // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
         // embedded in `struct auxiliary_device`.
-- 
2.51.0


