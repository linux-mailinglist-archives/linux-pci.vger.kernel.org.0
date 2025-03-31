Return-Path: <linux-pci+bounces-25025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B06A76F53
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 22:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650C51882FB8
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 20:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7DE220696;
	Mon, 31 Mar 2025 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWrylcPR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F07121B9FD;
	Mon, 31 Mar 2025 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452962; cv=none; b=k+w79UWDDkM7gMsmi9ZFrQ9mpXWfrTMXUkFJ/tVzdFfKiCFhky62tFMe/QoAzupIdie+G+qWi+VuCrbUF7aBB8NmNGL8FLKbbhEZdOQGTKRyX+5dbf63W0svIm4j8cauEJ/qQ621Fy+RoWWGyD9q4chm97gGFn7MQ34ccky1Jqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452962; c=relaxed/simple;
	bh=pQKXbW5g5QATkdun2XLx2iYsIxArlMlNIpZWyKcpnYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o06Nq72GqOyzdE4tHH2360p2NKucg7xul2KQ00y97zsAnu5u4F4PyYNSMZiqYrZwiAP3GJyMe5ZpfB0fvps3CXfIA6B8ZqEF4IumhVSjoN1Mc+u8nXb4Ca3YDrLa0UDLWU9Mz+KIW7kx9bWm2LN2GCjVodiAUyWzdUvgn4gzxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWrylcPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA36EC4CEE5;
	Mon, 31 Mar 2025 20:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743452962;
	bh=pQKXbW5g5QATkdun2XLx2iYsIxArlMlNIpZWyKcpnYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uWrylcPR0S0pc/kaUMIHKIS7PWHM4WTLu8Wmf+0LHhnwyGxnzCQAc55fMaq5N2K9j
	 hy4PlwZLv2qMDCR/xEzwdu4FVzzwtIciCsGSMrnFFgdkxWHFFSS0Np+7IougQCNU/w
	 bjZ2mWJGZEJ6bSBXkqmG9xc7JiNTFnj5SKLKSRLiqhDT6rjb9NRAfD9lj8q+9WG21q
	 B/SdYRPIZ7W8W9Ag4rBt4N+EixJTDYKwQcgd37HRZTHV0yUi86mjCCIVAuXKVtaHvZ
	 W0/LbGmnXsBNjZ1OISO40ny3GXbaDjQld4wnoDRe1S9Qz1mh+C5jQJVNevGGge9ZN9
	 rH06KokRxRaIA==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	abdiel.janulgue@gmail.com
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	robin.murphy@arm.com,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 8/9] rust: devres: require a bound device
Date: Mon, 31 Mar 2025 22:28:01 +0200
Message-ID: <20250331202805.338468-9-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331202805.338468-1-dakr@kernel.org>
References: <20250331202805.338468-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Require the Bound device context to be able to a new Devres container.
This ensures that we can't register devres callbacks for unbound
devices.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index ddb1ce4a78d9..1e58f5d22044 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -8,7 +8,7 @@
 use crate::{
     alloc::Flags,
     bindings,
-    device::Device,
+    device::{Bound, Device},
     error::{Error, Result},
     ffi::c_void,
     prelude::*,
@@ -45,7 +45,7 @@ struct DevresInner<T> {
 /// # Example
 ///
 /// ```no_run
-/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::{Io, IoRaw}};
+/// # use kernel::{bindings, c_str, device::{Bound, Device}, devres::Devres, io::{Io, IoRaw}};
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
@@ -83,13 +83,10 @@ struct DevresInner<T> {
 ///         unsafe { Io::from_raw(&self.0) }
 ///    }
 /// }
-/// # fn no_run() -> Result<(), Error> {
-/// # // SAFETY: Invalid usage; just for the example to get an `ARef<Device>` instance.
-/// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
-///
+/// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
 /// // SAFETY: Invalid usage for example purposes.
 /// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
-/// let devres = Devres::new(&dev, iomem, GFP_KERNEL)?;
+/// let devres = Devres::new(dev, iomem, GFP_KERNEL)?;
 ///
 /// let res = devres.try_access().ok_or(ENXIO)?;
 /// res.write8(0x42, 0x0);
@@ -99,7 +96,7 @@ struct DevresInner<T> {
 pub struct Devres<T>(Arc<DevresInner<T>>);
 
 impl<T> DevresInner<T> {
-    fn new(dev: &Device, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
+    fn new(dev: &Device<Bound>, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
         let inner = Arc::pin_init(
             pin_init!( DevresInner {
                 dev: dev.into(),
@@ -171,7 +168,7 @@ fn remove_action(this: &Arc<Self>) {
 impl<T> Devres<T> {
     /// Creates a new [`Devres`] instance of the given `data`. The `data` encapsulated within the
     /// returned `Devres` instance' `data` will be revoked once the device is detached.
-    pub fn new(dev: &Device, data: T, flags: Flags) -> Result<Self> {
+    pub fn new(dev: &Device<Bound>, data: T, flags: Flags) -> Result<Self> {
         let inner = DevresInner::new(dev, data, flags)?;
 
         Ok(Devres(inner))
@@ -179,7 +176,7 @@ pub fn new(dev: &Device, data: T, flags: Flags) -> Result<Self> {
 
     /// Same as [`Devres::new`], but does not return a `Devres` instance. Instead the given `data`
     /// is owned by devres and will be revoked / dropped, once the device is detached.
-    pub fn new_foreign_owned(dev: &Device, data: T, flags: Flags) -> Result {
+    pub fn new_foreign_owned(dev: &Device<Bound>, data: T, flags: Flags) -> Result {
         let _ = DevresInner::new(dev, data, flags)?;
 
         Ok(())
-- 
2.49.0


