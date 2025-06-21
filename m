Return-Path: <linux-pci+bounces-30307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47156AE2BE5
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 21:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9135189A951
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 19:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B596E273D6E;
	Sat, 21 Jun 2025 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeB4POrs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F1271448;
	Sat, 21 Jun 2025 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535518; cv=none; b=TA3Yjm++u4aNvJPbBKf4c5ff0laCi3yF11sSYvYAZYCQgqDegDuvyC2kJma3BqX8EJ5JhkFhLNo/CVeonGbasJUwxBMsKFHWl/Rj4X6DmHyW13CH02IPbay3FZS+cfM5lbJAwgoYVNKGlnsCMdQaoNAJH8hd2sjD81AvXoyasPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535518; c=relaxed/simple;
	bh=2JkK5rZrOgiP/B+Tmh5/VUxDYFEElGEgx5i/EiKwWQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqQ0+Yk6hA6UH8e+PPsLCUEJKkSMl+zUHWt/TgLbu1Jq78PySq4MZg1cetHBKAJ27zqSnvHGtMSwX4PqPbjP1LZrsMKFNjBqcybIb0qqV+59kCmaj1ov6FTtVJa3IGel68CxzvmAw7FS5EXTtz3+0PgYIEAzzKJiqjD7oevNd6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeB4POrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BADC4CEEF;
	Sat, 21 Jun 2025 19:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750535518;
	bh=2JkK5rZrOgiP/B+Tmh5/VUxDYFEElGEgx5i/EiKwWQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YeB4POrsRlpzYE4d6RgxCMyvx9S+IlY9SQFzm4rSItiFg4IClwpdySqmKIdh+rwhG
	 rlyl/b226EkNfPBG0wJ1R+Go6/Z2boxyg1xoCv3pZmxkBOMbH+Yqw8Q+m4wrDV6VfF
	 ta+7TvJA9ezUEMeh7C8RmhWKvBzu/lsZ8T5zbkSAINse5IXS/TCXNMOPDbg3yfre/y
	 Sj7011Ji8uCJnD2urE+psEEBE3Svz/nzTjWjh9pcMN5w7FC8JyMkRj5MhCdnH9NhxQ
	 ZwUQTSphV4A0yhZyC0fB41BpVs9PPUc8lSeAFcdrUCHLq9QCjscvLF1kpT/nfB1QOd
	 rAM5Y9jiOVOgg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
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
Subject: [PATCH 7/8] rust: pci: implement Driver::unbind()
Date: Sat, 21 Jun 2025 21:43:33 +0200
Message-ID: <20250621195118.124245-8-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621195118.124245-1-dakr@kernel.org>
References: <20250621195118.124245-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there's really only one core callback for drivers, which is
probe().

Now, this isn't entirely true, since there is also the drop() callback of
the driver type (serving as the driver's private data), which is returned
by probe() and is dropped in remove().

On the C side remove() mainly serves two purposes:

  (1) Tear down the device that is operated by the driver, e.g. call bus
      specific functions, write I/O memory to reset the device, etc.

  (2) Free the resources that have been allocated by a driver for a
      specific device.

The drop() callback mentioned above is intended to cover (2) as the Rust
idiomatic way.

However, it is partially insufficient and inefficient to cover (1)
properly, since drop() can't be called with additional arguments, such as
the reference to the corresponding device that has the correct device
context, i.e. the Core device context.

This makes it inefficient (but not impossible) to access device
resources, e.g. to write device registers, and impossible to call device
methods, which are only accessible under the Core device context.

In order to solve this, add an additional callback for (1), which we
call unbind().

The reason for calling it unbind() is that, unlike remove(), it is *only*
meant to be used to perform teardown operations on the device (1), but
*not* to release resources (2).

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 064e74a90904..6bdd3ab23f17 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -91,7 +91,9 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T>>`.
-        let _ = unsafe { pdev.as_ref().drvdata_obtain::<Pin<KBox<T>>>() };
+        let data = unsafe { pdev.as_ref().drvdata_obtain::<Pin<KBox<T>>>() };
+
+        T::unbind(pdev, data.as_ref());
     }
 }
 
@@ -238,6 +240,20 @@ pub trait Driver: Send {
     /// Called when a new platform device is added or discovered.
     /// Implementers should attempt to initialize the device here.
     fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>;
+
+    /// Platform driver unbind.
+    ///
+    /// Called when a [`Device`] is unbound from its bound [`Driver`]. Implementing this callback
+    /// is optional.
+    ///
+    /// This callback serves as a place for drivers to perform teardown operations that require a
+    /// `&Device<Core>` or `&Device<Bound>` reference. For instance, drivers may try to perform I/O
+    /// operations to gracefully tear down the device.
+    ///
+    /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
+    fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
+        let _ = (dev, this);
+    }
 }
 
 /// The PCI device representation.
-- 
2.49.0


