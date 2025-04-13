Return-Path: <linux-pci+bounces-25758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EEBA87314
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A0E3BB9FD
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CC61F5425;
	Sun, 13 Apr 2025 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8/tOA95"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172E31F3FEE;
	Sun, 13 Apr 2025 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744565919; cv=none; b=aLA0cTl7ByIJrU1Bd55bKbRszXEg5dFowzhTjtiIx20ecV+dIYopZoqwtAh3vuJXfsvH+MBEfnQs2raSvAqyPIdo4KauSzXi5Lq6Oioojt8+2cyU+OMocCAA+LhYYAASkL6UN+IlA4sYh3aSa3mBjcozQYXhZHMz1PmOOU5ZvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744565919; c=relaxed/simple;
	bh=pQKXbW5g5QATkdun2XLx2iYsIxArlMlNIpZWyKcpnYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czObZT4qZKDfPgQ9zW4rAN0a9UWypWpT+dMsX/K+mnX7/cHA0GgAVd8Fbc6hOgWWShPmyuwyouamFN3sREV/E42pyaHrNIq7yc9LNgidRhfKhjEBSJRZTXyvTyjPyet+A96VpAtF1zriLGMvYT068AXBpKHojS2WcCeZKehWzKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8/tOA95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3DEC4CEE7;
	Sun, 13 Apr 2025 17:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744565919;
	bh=pQKXbW5g5QATkdun2XLx2iYsIxArlMlNIpZWyKcpnYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8/tOA95aSQfxIogv4/Zyeqi9p2IAKsLr0Nm3f40NfQ0Mlf3idRBDinR8OHvirpOK
	 Ie/UTThPY+e4YgmC8ciaU5+oi+fV/y4l5VZvfjfrgyqjGiMubzMo9OyPYjwRWnDA2n
	 hDahPowRfj51IdPAxI/ZQ4KrF01AIeC4J6NN+YuRY7w8VhJ8k1+5jOEAKf4x9uiHar
	 1qpNtFQOUbMe+t1EUgxzgSbM2o84/BYBAjCK7U7LmqE6u9b1i2oCgSS0AcSMnclMMi
	 8rgPDY8JBHCAhi7AKYGXfgYYVVctmSdwQ49ihF7Km8tLFHYSRtbYUO15Diqel0JDC7
	 Ou2pdWP0la0wA==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
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
Subject: [PATCH v2 8/9] rust: devres: require a bound device
Date: Sun, 13 Apr 2025 19:37:03 +0200
Message-ID: <20250413173758.12068-9-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413173758.12068-1-dakr@kernel.org>
References: <20250413173758.12068-1-dakr@kernel.org>
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


