Return-Path: <linux-pci+bounces-36422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E53ADB8571F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 17:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C851C84DC8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5048C2264CB;
	Thu, 18 Sep 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x9O0XxUF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9035E1CAA7D
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207747; cv=none; b=WpJfPffEFr4cEoA0AoMiRMLEACwdo8PlUx4jACWErw+6N8ki6Wop203QmedycmD5L/M/eKZagPYz4NucItiQiBYUcDPQoJFhmjwvifi9xJniQ2/ZkgLOwv91Xt7r0gi5SKY1uUXebLOw0wrHXKublTiOWkydd9h2Vmoy7Tpd9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207747; c=relaxed/simple;
	bh=vJ54JE6+riZlcAldU+0faKQxu82OqxHqyvNXkYI5oGI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pzohqya5BduIetvhTSGuPsjOaG1tyTYpJAY/EDeeBCeLrwlC+lCM0XS6SunHreFBtZGTORJqVgBsEIjYXWj4s0wAIZ3vB/tB0z6VV982m1XHUE0IQLVEPayvXosjVGMeBiKYTNTvnXhcuknf7J35/W6H569CoHsLy2bTw4MDUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x9O0XxUF; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so10986325e9.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758207742; x=1758812542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l7zJnB3yDJu54j7XDPcUHBWHQ2xjhdYOpr3OUldWhZI=;
        b=x9O0XxUFO7N4ZtNhcCOB7pynd1FZ5QJDaTtXr/WiVlQTD45f0sWeZjhqtrWVjMrc40
         ZYp0MdtR54boZEwb6ECU0f9OKqFAzQZ1xBIWXUO6V8EtEd9ac1YWkBCZh13FF2ImyvIt
         XhDoJo4yxBUwJZOD71VDNcwa8T9MB/O8wXvqPIWrw76tuR+6G/hFnf0KHv8hyAXR/gaF
         /HiYUR+gF9Rbmf5zgbw4Si8R3bzpwQ9w7kZOm4xj9hy1hsOclSL2kYAivyQSa/HfQh6n
         ICgE2N9yIcP7q9WjqnYkaZF9Jbulsc3eun/yZQyJmYS6mNO1rY4+VkIQAtkKh0ZjWbxZ
         T7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207742; x=1758812542;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7zJnB3yDJu54j7XDPcUHBWHQ2xjhdYOpr3OUldWhZI=;
        b=Og0pEm+7r/6MbQHdEcY/LB0qry7Tfx46eSib/y90W2M95vx8tVNHcoVTLUA8LiSf55
         b15P+MBTOyG7VpKIZxeYRO3ArTdjRhJol5jSmEWqi1XszklG1o2NSN3Jea7SHI0JDETb
         0t2Qy8qNpE8Ho3XkvgO8+75lxlzmeRPEDsdiT8P8bmtyNa4CRDk8EfJyLM7HEo8sVShH
         4rgxvVyCau78jwooFHxJuEJnun96oSAckv6OgemjNIjMFKH2/QvUkGlPpVokeI24qK1s
         mguplMp/aFkIt5tvSTcDKb+nnQwGRAbX0g0ojtw7zgfL1E6GcDthQDEq+EJMLjSsjbqW
         9hbg==
X-Forwarded-Encrypted: i=1; AJvYcCX5nJk8Z38xy/yXeIt47wL1CStXy6KkkOPyhp+cF9AVv9/fwFjDTrAwEJf9P/XbaQZxAqliokZ0loQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6yjEc6eAji+Mc3YjJs/nZ2rbXUGv32s8dPw4e5/j7zykQjGBT
	fSedL+1fj/54DfVhrT1x9xbwJG3cpZNRBN9C757lsSakJUJqGZVvDlxWZHCrIt5QPMGOgZhSRHh
	4pNTw7qvaPWemo7iv6g==
X-Google-Smtp-Source: AGHT+IGPi4MZRXFcoOWPdUNlDZJMVbEdW8oLBAH+1jAR+Diom6ppak8B/S5RDukjmv+fduoTwCEAHE4877UjRK8=
X-Received: from wmbay25.prod.google.com ([2002:a05:600c:1e19:b0:464:f7d9:6b0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e93:b0:45f:2d21:cb36 with SMTP id 5b1f17b1804b1-462074c576amr51491305e9.35.1758207742039;
 Thu, 18 Sep 2025 08:02:22 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:02:11 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPIezGgC/x3MQQqEMAxA0atI1gbaqKBeRVw4NdVsWmmKDoh3t
 7h8i/9vUE7CCmN1Q+JTVGIosHUFbl/CxihrMZChzgy2xytJZozeK2d0MWhG86PGupZ64gVKeCT 28v+m0/w8L+9hGf9kAAAA
X-Change-Id: 20250918-write-offset-const-0b231c4282ea
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7310; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=vJ54JE6+riZlcAldU+0faKQxu82OqxHqyvNXkYI5oGI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBozB748rOfzrnjjSiHKGsX0n/x0Z3PtJbpWHfqq
 gTHB11OZYyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaMwe+AAKCRAEWL7uWMY5
 Rl4RD/4t8Nbnz6TBtCmQoNUw/ZfJv6wR1kk4pmCvIL62u/kkC7XWhfJGvi1fvuVUZNAsyCukNOb
 S0+2aa463z8u2qomYAZNc8ronaonyjtPh8NNcdI3G0b73niWeexkLA7J619ZUlfMxHddicnVACb
 387tj0pEiWOqKBTAm4dxcr/+IyglGnhIgMkSsJdgzjpOODll2GE5zwJJnuQTzw+HxtNM5sxIPPa
 DIUAG71t3yxrqpQBxUBIkD4f8Z+QgNAy+eBzjWMRQXz+nrLve/UcrY9Tbmg8v1qMutTTsrLLVCM
 ghZhVL/Gy0QXTPzEOQBZ2FFHh4Y6LkoRWOn6X90gwyEfoFLn7P00LIxKU9RXwW4tRN9HwSWLqAE
 /r4ftVa79WR5/TiYyB4eMmiYcsCmxbqv3GEwdnIihYn/ioNDllGczIlZ5MzbsRaOB6c4z1E8X1Y
 V+V/fZ9VITnZggfsta5SeDYXrsN5/krxJ/EkD2717cEvfHgLxI45/7ruAiL/+WJ7WvXjGBwytIf
 QtvHPOljIsnugLwZHCGwpAbQQCZXLHKOxsV/dutoOFxODJ8NITd4vurbhyMu21T43/h0HyamWQE
 qCdE4RhoFXxy4z06spZHRF2O6KU8EnLuiQLMetP37LiyVQ+P3wd45B1WGHm6iOREbrDSN0pCWvO OENwPwQjM3fbOLA==
X-Mailer: b4 0.14.2
Message-ID: <20250918-write-offset-const-v1-1-eb51120d4117@google.com>
Subject: [PATCH] rust: io: use const generics for read/write offsets
From: Alice Ryhl <aliceryhl@google.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?utf-8?q?Krzysztof_Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-pci@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Using build_assert! to assert that offsets are in bounds is really
fragile and likely to result in spurious and hard-to-debug build
failures. Therefore, build_assert! should be avoided for this case.
Thus, update the code to perform the check in const evaluation instead.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/tyr/regs.rs     |  4 ++--
 rust/kernel/devres.rs           |  4 ++--
 rust/kernel/io.rs               | 18 ++++++++++--------
 rust/kernel/io/mem.rs           |  6 +++---
 samples/rust/rust_driver_pci.rs | 10 +++++-----
 5 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index f46933aaa2214ee0ac58b1ea2a6aa99506a35b70..e3c306e48e86d1d6047cab7944e0fe000901d48b 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -25,13 +25,13 @@
 impl<const OFFSET: usize> Register<OFFSET> {
     #[inline]
     pub(crate) fn read(&self, dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<u32> {
-        let value = (*iomem).access(dev)?.read32(OFFSET);
+        let value = (*iomem).access(dev)?.read32::<OFFSET>();
         Ok(value)
     }
 
     #[inline]
     pub(crate) fn write(&self, dev: &Device<Bound>, iomem: &Devres<IoMem>, value: u32) -> Result {
-        (*iomem).access(dev)?.write32(value, OFFSET);
+        (*iomem).access(dev)?.write32::<OFFSET>(value);
         Ok(())
     }
 }
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index da18091143a67fcfbb247e7cb4f59f5a4932cac5..3e66e10c05fa078e42162c7a367161fbf735a07f 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -96,7 +96,7 @@ struct Inner<T: Send> {
 /// let devres = KBox::pin_init(Devres::new(dev, iomem), GFP_KERNEL)?;
 ///
 /// let res = devres.try_access().ok_or(ENXIO)?;
-/// res.write8(0x42, 0x0);
+/// res.write8::<0x0>(0x42);
 /// # Ok(())
 /// # }
 /// ```
@@ -232,7 +232,7 @@ pub fn device(&self) -> &Device {
     ///
     ///     // might_sleep()
     ///
-    ///     bar.write32(0x42, 0x0);
+    ///     bar.write32::<0x0>(0x42);
     ///
     ///     Ok(())
     /// }
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 03b467722b8651ebecd660ac0e2d849cf88dc915..563ff8488100d9e07a7f4bffeb085db7bd7e9d6a 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -103,7 +103,7 @@ pub fn maxsize(&self) -> usize {
 ///# fn no_run() -> Result<(), Error> {
 /// // SAFETY: Invalid usage for example purposes.
 /// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
-/// iomem.write32(0x42, 0x0);
+/// iomem.write32::<0x0>(0x42);
 /// assert!(iomem.try_write32(0x42, 0x0).is_ok());
 /// assert!(iomem.try_write32(0x42, 0x4).is_err());
 /// # Ok(())
@@ -120,8 +120,8 @@ macro_rules! define_read {
         /// time, the build will fail.
         $(#[$attr])*
         #[inline]
-        pub fn $name(&self, offset: usize) -> $type_name {
-            let addr = self.io_addr_assert::<$type_name>(offset);
+        pub fn $name<const OFF: usize>(&self) -> $type_name {
+            let addr = self.io_addr_assert::<$type_name, OFF>();
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
             unsafe { bindings::$c_fn(addr as *const c_void) }
@@ -149,8 +149,8 @@ macro_rules! define_write {
         /// time, the build will fail.
         $(#[$attr])*
         #[inline]
-        pub fn $name(&self, value: $type_name, offset: usize) {
-            let addr = self.io_addr_assert::<$type_name>(offset);
+        pub fn $name<const OFF: usize>(&self, value: $type_name) {
+            let addr = self.io_addr_assert::<$type_name, OFF>();
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
             unsafe { bindings::$c_fn(value, addr as *mut c_void) }
@@ -217,10 +217,12 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
     }
 
     #[inline]
-    fn io_addr_assert<U>(&self, offset: usize) -> usize {
-        build_assert!(Self::offset_valid::<U>(offset, SIZE));
+    fn io_addr_assert<U, const OFF: usize>(&self) -> usize {
+        const {
+            build_assert!(Self::offset_valid::<U>(OFF, SIZE));
+        }
 
-        self.addr() + offset
+        self.addr() + OFF
     }
 
     define_read!(read8, try_read8, readb -> u8);
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 6f99510bfc3a63dd72c1d47dc661dcd48fa7f54e..b73557f5f57c955ac251a46c9bdd6df0687411e2 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -54,7 +54,7 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> S
     ///       pdev: &platform::Device<Core>,
     ///       info: Option<&Self::IdInfo>,
     ///    ) -> Result<Pin<KBox<Self>>> {
-    ///       let offset = 0; // Some offset.
+    ///       const OFFSET: usize = 0; // Some offset.
     ///
     ///       // If the size is known at compile time, use [`Self::iomap_sized`].
     ///       //
@@ -66,9 +66,9 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> S
     ///       let io = iomem.access(pdev.as_ref())?;
     ///
     ///       // Read and write a 32-bit value at `offset`.
-    ///       let data = io.read32_relaxed(offset);
+    ///       let data = io.read32_relaxed::<OFFSET>();
     ///
-    ///       io.write32_relaxed(data, offset);
+    ///       io.write32_relaxed::<OFFSET>(data);
     ///
     ///       # Ok(KBox::new(SampleDriver, GFP_KERNEL)?.into())
     ///     }
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 606946ff4d7fd98e206ee6420a620d1c44eb0377..6f0388853e2b36e0800df5125a5dd8b20a6d5912 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -46,17 +46,17 @@ struct SampleDriver {
 impl SampleDriver {
     fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
         // Select the test.
-        bar.write8(index.0, Regs::TEST);
+        bar.write8::<{ Regs::TEST }>(index.0);
 
-        let offset = u32::from_le(bar.read32(Regs::OFFSET)) as usize;
-        let data = bar.read8(Regs::DATA);
+        let offset = u32::from_le(bar.read32::<{ Regs::OFFSET }>()) as usize;
+        let data = bar.read8::<{ Regs::DATA }>();
 
         // Write `data` to `offset` to increase `count` by one.
         //
         // Note that we need `try_write8`, since `offset` can't be checked at compile-time.
         bar.try_write8(data, offset)?;
 
-        Ok(bar.read32(Regs::COUNT))
+        Ok(bar.read32::<{ Regs::COUNT }>())
     }
 }
 
@@ -98,7 +98,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
     fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>) {
         if let Ok(bar) = this.bar.access(pdev.as_ref()) {
             // Reset pci-testdev by writing a new test index.
-            bar.write8(this.index.0, Regs::TEST);
+            bar.write8::<{ Regs::TEST }>(this.index.0);
         }
     }
 }

---
base-commit: cf4fd52e323604ccfa8390917593e1fb965653ee
change-id: 20250918-write-offset-const-0b231c4282ea

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


