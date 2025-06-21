Return-Path: <linux-pci+bounces-30306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F81AE2BE6
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 21:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3D03BC0C2
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 19:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B072737F0;
	Sat, 21 Jun 2025 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtEBEW6d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB7270ED7;
	Sat, 21 Jun 2025 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535514; cv=none; b=TB/v5GvF7p7wTU1BMkmekZVjIn4gfW2RE9zpAD5VUMvTEZXkWAEYqxZCNTzfBC4BWtxuCIdtjc45RV6kNOcDp892ay8FRvQ0omdUcmOdgiVnCVd1R5w925yz4AAFqm5yBSObXwYfEKKrPApXWpm41Pr+Eb0OAFh1/QHnFcjVi74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535514; c=relaxed/simple;
	bh=7QAcOvOYh5asCbN/n+PaQTUogUpYg0tZ05+enhoXBgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/dCmSuEfIAHUPlV4/ccznmGWUIiXr/BOe/HY8G0fk8e/bg16R3A/Bz+R6ms7E+dE1IMbGWKzP1/hE3MJNiZXXWPhn3IhjEc1Meq55qCystQZAKLLEPSDc6gfeDsUMiAvGrXjm7t6ERMUBpcqMxTq+NJw4kDlVr5uxOdNr9wnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtEBEW6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3284C4CEE7;
	Sat, 21 Jun 2025 19:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750535513;
	bh=7QAcOvOYh5asCbN/n+PaQTUogUpYg0tZ05+enhoXBgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtEBEW6dXTKMhVbZ+EIsCX7ZIs8DLZHY5nq8jzo2BAE18hd6c/Xlx4wr82vMDaywp
	 zX7hhNi/qL1jW95tNcEPmNpHB9Anrk624xT3ycPZoWAPUfjrkgB7bPRm4RAcqLvgml
	 iqEFLOo9JEFSoYFREmYU/rt98GJlJAJe4cfB4Ben0rCSDmhK7XVdtqD0KLH9+3kkE2
	 AarnwwUYA0aNZg20PNsdQvhQLicwDqh0XmCKXyL6y/errLeEY23MwRBFRSoI5m+deL
	 LUgEMjISLrper9B4+irYBui1DZrry1quSWBZ2b1fiB6GytyWtOXAK3mOsQlQWUFHxJ
	 y42eipGMJrgfA==
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
Subject: [PATCH 6/8] rust: platform: implement Driver::unbind()
Date: Sat, 21 Jun 2025 21:43:32 +0200
Message-ID: <20250621195118.124245-7-dakr@kernel.org>
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
 rust/kernel/platform.rs | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index dc0c36d70963..9b3de89dc2f9 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -82,7 +82,9 @@ extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T>>`.
-        let _ = unsafe { pdev.as_ref().drvdata_obtain::<Pin<KBox<T>>>() };
+        let data = unsafe { pdev.as_ref().drvdata_obtain::<Pin<KBox<T>>>() };
+
+        T::unbind(pdev, data.as_ref());
     }
 }
 
@@ -164,6 +166,20 @@ pub trait Driver: Send {
     /// Implementers should attempt to initialize the device here.
     fn probe(dev: &Device<device::Core>, id_info: Option<&Self::IdInfo>)
         -> Result<Pin<KBox<Self>>>;
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
 
 /// The platform device representation.
-- 
2.49.0


