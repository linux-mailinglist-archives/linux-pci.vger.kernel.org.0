Return-Path: <linux-pci+bounces-38814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26944BF3EBE
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A70C18C0C6B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 22:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39B12E0415;
	Mon, 20 Oct 2025 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjFIomUR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65FE21CC47;
	Mon, 20 Oct 2025 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999738; cv=none; b=fmgSdDw2TcxqDWzf/UKGijHfhr+36XMhEpfiXI+GzluIzEO2w2Xc4nXZMBKdn3cG48oots5IiXop3To8QslWOvJeyK+W/9b3PSnSuBZ4f8Olg3Uqt4f8LsFvW1J6TvA2rTGJeNx28nIGuzg6+PS8fVmeU8H0OQgB5heRExkyqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999738; c=relaxed/simple;
	bh=N4vezhO0wwYBBIpkBuSZJyupwVtIFp66xV6fNs6FXSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDOstgXrjlU24SxWS79dQ9JIBHqHpYpqA5VdShiGEpAfSCqouV0JyPX4l05QG8vH7gwipcEHqK9odnbpjAwWh3jPwFv3X9XPuA2gLQH0MsF4a7eLFlX7HZBLLVtc1wiNNM5k5K5GwZyfNPsRgCypBsQOIN3l7NGDsfnVaFEv1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjFIomUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F86C113D0;
	Mon, 20 Oct 2025 22:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999738;
	bh=N4vezhO0wwYBBIpkBuSZJyupwVtIFp66xV6fNs6FXSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjFIomURYwt3CumUaZ7D9MAOB3fygTEkOnuIw2MF9tcZ8FrwO5kJl5Q7g4Zau6mST
	 Wjox5Gbws/mCRYEtllrwI8BzDoK7+He2h2XijmIGIbAikhw3NbsXNX+m6aotL/VUnD
	 8323srdc7Q1/R/T/hCEzPu1G3gYNLBL+v6uSze/cPtgb3EeTDL6nv0W1/83zCEEfWf
	 o6kkKtBs5sWNsk95U1MwyXmXWRmtph/ubd98hxENnofPaWLUvxosbYiFEGc1RQbOQC
	 COVTzDmYbNRuSbwINBXM4KPpYEnviDgk0+VmAR6kNm4AGnnQ237kuIm4WA+mHEN/SP
	 H+FBykhcHGfzg==
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
Subject: [PATCH 1/8] rust: device: narrow the generic of drvdata_obtain()
Date: Tue, 21 Oct 2025 00:34:23 +0200
Message-ID: <20251020223516.241050-2-dakr@kernel.org>
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

Let T be the actual private driver data type without the surrounding
box, as it leaves less room for potential bugs.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 2 +-
 rust/kernel/device.rs    | 4 ++--
 rust/kernel/pci.rs       | 2 +-
 rust/kernel/platform.rs  | 2 +-
 rust/kernel/usb.rs       | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index e12f78734606..a6a2b23befce 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -85,7 +85,7 @@ extern "C" fn remove_callback(adev: *mut bindings::auxiliary_device) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T>>`.
-        drop(unsafe { adev.as_ref().drvdata_obtain::<Pin<KBox<T>>>() });
+        drop(unsafe { adev.as_ref().drvdata_obtain::<T>() });
     }
 }
 
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 343996027c89..106aa57a6385 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -215,7 +215,7 @@ pub fn set_drvdata<T: 'static>(&self, data: impl PinInit<T, Error>) -> Result {
     /// - Must only be called once after a preceding call to [`Device::set_drvdata`].
     /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
     ///   [`Device::set_drvdata`].
-    pub unsafe fn drvdata_obtain<T: ForeignOwnable>(&self) -> T {
+    pub unsafe fn drvdata_obtain<T: 'static>(&self) -> Pin<KBox<T>> {
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
         let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
 
@@ -224,7 +224,7 @@ pub unsafe fn drvdata_obtain<T: ForeignOwnable>(&self) -> T {
         //   `into_foreign()`.
         // - `dev_get_drvdata()` guarantees to return the same pointer given to `dev_set_drvdata()`
         //   in `into_foreign()`.
-        unsafe { T::from_foreign(ptr.cast()) }
+        unsafe { Pin::<KBox<T>>::from_foreign(ptr.cast()) }
     }
 
     /// Borrow the driver's private data bound to this [`Device`].
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 83e19bcec46e..e90b13aebac8 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -148,7 +148,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { pdev.as_ref().drvdata_obtain::<Pin<KBox<T>>>() };
+        let data = unsafe { pdev.as_ref().drvdata_obtain::<T>() };
 
         T::unbind(pdev, data.as_ref());
     }
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 043721fdb6d8..8f7522c4cf89 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -91,7 +91,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { pdev.as_ref().drvdata_obtain::<Pin<KBox<T>>>() };
+        let data = unsafe { pdev.as_ref().drvdata_obtain::<T>() };
 
         T::unbind(pdev, data.as_ref());
     }
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 9238b96c2185..05eed3f4f73e 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -87,9 +87,9 @@ extern "C" fn disconnect_callback(intf: *mut bindings::usb_interface) {
         // SAFETY: `disconnect_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { dev.drvdata_obtain::<Pin<KBox<T>>>() };
+        let data = unsafe { dev.drvdata_obtain::<T>() };
 
-        T::disconnect(intf, data.as_ref());
+        T::disconnect(intf, data.data());
     }
 }
 
-- 
2.51.0


