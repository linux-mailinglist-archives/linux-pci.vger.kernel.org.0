Return-Path: <linux-pci+bounces-31911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDACB01565
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 10:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF993A2E5F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 08:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA5A20B21F;
	Fri, 11 Jul 2025 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KTEcPqKS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EFB1FC7D2
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221088; cv=none; b=Olx3NHJWBr0Ir4F1PJZjS2OblTv/Xe6iW3Y06Oj3v6cxRjMvYcPfeEhcE60xawq0bndMTGoWk6CETR0u9MnVelMyfWTDPkviY6SmAgJy9cgIJLZwLN9WAO83BBHetvhAx57Ao6bPzWMD7u6o4837EFNrgLhoz8rwYGVPWBjcrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221088; c=relaxed/simple;
	bh=/sM7c3ZlcrID5iVlFoygw6rsnxEGvSLgt7TAXbZimTI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PN/5VJIBlY9gw5DgRVUqn92hS0Ki+hT/Ct5NNpnqbmkS0gj4mRQkbNYFzlTic2cOOrhtoBZjPtwUSRP+ySGSlM7dIOYXrgOou5ZJLlkzI1W63DtDt/w3VOfXbPj4hCwTwdrvA9ae/+aec4KEUYj3GKtklyXHaHARKTz7QPGvzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KTEcPqKS; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso948889f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 01:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752221084; x=1752825884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeddRl2ZjPZG1iB3VuE6BCvJf0DWRoDr9MXVmboPWFw=;
        b=KTEcPqKSwYiUZM0WA6Km4pEKVYDxBE6r+XhHicQkL6wAqd2VF+p+appAOzlGVJ8/OJ
         8vfQk7jMPwa/WFG26DNXf+egQK1+70Wz8qiCWSE2/YCknfrQ57C9by5dwtp9kqI4eyCd
         V5SWX9WTgHP2D5f8ZvIF9dy0St2cX5ylzSSM9kDWCNsVVWNghnBJK22P36/lRpSg882E
         QskJHbvUwHVqf28E49C8MB2eSJUkH/t/D87CR2ZrI8ABmHcb2DuDAMpCBD6uQv5QiHML
         HEsXvlbDi4XflRBO5xSDvl7TDkdNmnP5LCyNqzAag/nc91xYNX1/tD5VlnxYS5jaKiM2
         89mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752221084; x=1752825884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YeddRl2ZjPZG1iB3VuE6BCvJf0DWRoDr9MXVmboPWFw=;
        b=PHI38isEXv+juO60H97DdnoncqcQHymsG7LIlYYOKM6byIOGiidBQpviLLialmEX6J
         9EJbIBbU/5e5UWBsus9LkGKrmMUq6fknJkm84BqwQOP8ghUJ8atyVnNMmYhkvxVLJ5TY
         fYOPTeVdfDdpu0CK0L+hOECN5CrzdoTQ97LRjvhgTGSCaA4Pk0wtW3doizotyO0ppWNL
         ldFzmIOLvOmQ8IzC7/Sa78Ji5nuB73+q8YSqPFYyTpPSHcGVqWe3NIlLWkpjlPgwP6WE
         SdMtmcIu5K7G3oT2zRd7gtJjZtmJIMfG3Fqz3BXlkELlcyEYb3R/3nsciAPjTC0VrOt1
         hPfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXablUMAjiV22jQZ4MO/yNyIeJiMDPv4tk+JXJtheKMoy9hGgs9fISKNYj6CweCJ5sfeIvkhke13po=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOpXud7p+KL8RGL/09L8iO78whRtGHtkNyt7HoaRpKfVz2Ic4s
	Uo8m2jYXN7Rr2g22PJiuAGUY99GsUGDeaBigP/I7m+P1BDoUmuc8ll/BriWHzPgy68tDNRQc6h9
	UtMqNf4+o8yCZdkcAOQ==
X-Google-Smtp-Source: AGHT+IG/XgF1fLGGyXshyCet6B/sQYLy7ohXFOqAGO6mIla8fi/6od2tPDsSefKFOrRxYDhDW/XtZherTVAYt0s=
X-Received: from wrqh8.prod.google.com ([2002:a5d:4308:0:b0:3a6:dd7d:9cb8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4b11:b0:3a5:3b63:58f0 with SMTP id ffacd0b85a97d-3b5f2dc2cd1mr1247364f8f.18.1752221084546;
 Fri, 11 Jul 2025 01:04:44 -0700 (PDT)
Date: Fri, 11 Jul 2025 08:04:37 +0000
In-Reply-To: <20250711-device-as-ref-v2-0-1b16ab6402d7@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-device-as-ref-v2-0-1b16ab6402d7@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7303; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/sM7c3ZlcrID5iVlFoygw6rsnxEGvSLgt7TAXbZimTI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBocMWaRIEy+we9THrmpSxj2hWR8Lw49HZvEH02W
 /KlLzxaMt6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaHDFmgAKCRAEWL7uWMY5
 RqUnD/97xg55WZUfcoF6IkTgRF74u19GiaS/m4ptRtTjwEWsPlsSfXdZwVCl11AsH7Vka1TOWXF
 9BIPig1/8MgviPmubeCSl0nsPSgCxtUoBLIJkJ6Nfz+1QazS6AqLULUPo0Dn+PBVZDfcU3wV4ge
 KR6uL3IxSa8moOXWU8i9z/IxeOpoHJOGXdcjPMT5FWGi8ZTJlVXj+h1D0Eaw5oAWWUZpylC8D5B
 Jnhscr0fdP6X7C4xgh/AmF7fWuhDJW1Q+TFPbrFUYi4vrLgR+AgKWYSDjZaMaN96N5ThDm6gnwr
 BU2EqI/CQHH5im0bChZWfcUTXoXaMFRQcEe51+GsRMFCwbau//ACU9HcGqKK/YxtRwM0Jd+IOHt
 npTx4ygolfDsNTGzcGRIEXU4O3ivlMIMisHc2joZ1X3MviFvCmKIvXQSFvHY8FzuRm86FX2Vtqr
 v91Vt5dBRpOQkLICTTMAxi0oeV11gWDWNhEKaD5+xoRjCZ7D6Mn0+HF2/CBqizEdgc6XxIBmUkh
 EaD5mhdr1vQv+lx7Rvj8WBfl6QnHAtPJpBWnG3wNhkB3FK3nQA+hHbLTfXV6UcxhGJaQgo0GANm
 lRJv1U81I9iu4wlqNBVBR7II1sjtVyQk1lg28BpLAspAGr+MjxkEbCgopXxbXhvc6PaG2aJW0a+ hqsp0UieNeVAvPw==
X-Mailer: b4 0.14.2
Message-ID: <20250711-device-as-ref-v2-1-1b16ab6402d7@google.com>
Subject: [PATCH v2 1/2] device: rust: rename Device::as_ref() to Device::from_raw()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?utf-8?q?Krzysztof_Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The prefix as_* should not be used for a constructor. Constructors
usually use the prefix from_* instead.

Some prior art in the stdlib: Box::from_raw, CString::from_raw,
Rc::from_raw, Arc::from_raw, Waker::from_raw, File::from_raw_fd.

There is also prior art in the kernel crate: cpufreq::Policy::from_raw,
fs::File::from_raw_file, Kuid::from_raw, ARef::from_raw,
SeqFile::from_raw, VmaNew::from_raw, Io::from_raw.

Link: https://lore.kernel.org/r/aCd8D5IA0RXZvtcv@pollux
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/auxiliary.rs  | 2 +-
 rust/kernel/cpu.rs        | 2 +-
 rust/kernel/device.rs     | 6 +++---
 rust/kernel/drm/device.rs | 2 +-
 rust/kernel/faux.rs       | 2 +-
 rust/kernel/miscdevice.rs | 2 +-
 rust/kernel/net/phy.rs    | 2 +-
 rust/kernel/pci.rs        | 2 +-
 rust/kernel/platform.rs   | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index d2cfe1eeefb6054a97fefd6e499772c3fc4c443e..a4ac00990a441f6f92ec6e6bdbd7699d2777da00 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -276,7 +276,7 @@ fn as_ref(&self) -> &device::Device<Ctx> {
         let dev = unsafe { addr_of_mut!((*self.as_raw()).dev) };
 
         // SAFETY: `dev` points to a valid `struct device`.
-        unsafe { device::Device::as_ref(dev) }
+        unsafe { device::Device::from_raw(dev) }
     }
 }
 
diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
index b75403b0eb5614e5652e6cad9341ae217edbe5bb..5de730c8d81722873ba2349a1c9c4d6c17701134 100644
--- a/rust/kernel/cpu.rs
+++ b/rust/kernel/cpu.rs
@@ -147,5 +147,5 @@ pub unsafe fn from_cpu(cpu: CpuId) -> Result<&'static Device> {
 
     // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
     // a `struct device` and is never freed by the C code.
-    Ok(unsafe { Device::as_ref(ptr) })
+    Ok(unsafe { Device::from_raw(ptr) })
 }
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index dea06b79ecb536cee4d2b90c21b74658658417c7..f70d768351204d7f49c6bebbf27ee26f4d11cdfa 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -57,7 +57,7 @@ impl Device {
     /// While not officially documented, this should be the case for any `struct device`.
     pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
         // SAFETY: By the safety requirements ptr is valid
-        unsafe { Self::as_ref(ptr) }.into()
+        unsafe { Self::from_raw(ptr) }.into()
     }
 }
 
@@ -82,7 +82,7 @@ pub(crate) fn parent(&self) -> Option<&Self> {
             // - Since `parent` is not NULL, it must be a valid pointer to a `struct device`.
             // - `parent` is valid for the lifetime of `self`, since a `struct device` holds a
             //   reference count of its parent.
-            Some(unsafe { Self::as_ref(parent) })
+            Some(unsafe { Self::from_raw(parent) })
         }
     }
 
@@ -94,7 +94,7 @@ pub(crate) fn parent(&self) -> Option<&Self> {
     /// i.e. it must be ensured that the reference count of the C `struct device` `ptr` points to
     /// can't drop to zero, for the duration of this function call and the entire duration when the
     /// returned reference exists.
-    pub unsafe fn as_ref<'a>(ptr: *mut bindings::device) -> &'a Self {
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::device) -> &'a Self {
         // SAFETY: Guaranteed by the safety requirements of the function.
         unsafe { &*ptr.cast() }
     }
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 624d7a4c83ead64b93325189f481d9b37c3c6eae..11ce1e7f2d52ae4ddfbd4e47dfb17e390653bc45 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -190,7 +190,7 @@ impl<T: drm::Driver> AsRef<device::Device> for Device<T> {
     fn as_ref(&self) -> &device::Device {
         // SAFETY: `bindings::drm_device::dev` is valid as long as the DRM device itself is valid,
         // which is guaranteed by the type invariant.
-        unsafe { device::Device::as_ref((*self.as_raw()).dev) }
+        unsafe { device::Device::from_raw((*self.as_raw()).dev) }
     }
 }
 
diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
index 8a50fcd4c9bbba1f894a09080446ca3173571b03..7a906099993f1bf8c8caf6ab64f920faf81cafb4 100644
--- a/rust/kernel/faux.rs
+++ b/rust/kernel/faux.rs
@@ -54,7 +54,7 @@ impl AsRef<device::Device> for Registration {
     fn as_ref(&self) -> &device::Device {
         // SAFETY: The underlying `device` in `faux_device` is guaranteed by the C API to be
         // a valid initialized `device`.
-        unsafe { device::Device::as_ref(addr_of_mut!((*self.as_raw()).dev)) }
+        unsafe { device::Device::from_raw(addr_of_mut!((*self.as_raw()).dev)) }
     }
 }
 
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 939278bc7b03489a647b697012e09223871c90cd..a6dc11935ee3fe495640e06509d86f89bd201ca1 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -92,7 +92,7 @@ pub fn device(&self) -> &Device {
         // function tells the borrow-checker that the `&Device` reference must not outlive the
         // `&MiscDeviceRegistration<T>` used to obtain it, so the last use of the reference must be
         // before the underlying `struct miscdevice` is destroyed.
-        unsafe { Device::as_ref((*self.as_raw()).this_device) }
+        unsafe { Device::from_raw((*self.as_raw()).this_device) }
     }
 }
 
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 32ea43ece6465a7e09c9d2332ca83c4bc27b7104..bd43a726f7d398278dae2546fca702fa70c68cf0 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -285,7 +285,7 @@ impl AsRef<kernel::device::Device> for Device {
     fn as_ref(&self) -> &kernel::device::Device {
         let phydev = self.0.get();
         // SAFETY: The struct invariant ensures that `mdio.dev` is valid.
-        unsafe { kernel::device::Device::as_ref(addr_of_mut!((*phydev).mdio.dev)) }
+        unsafe { kernel::device::Device::from_raw(addr_of_mut!((*phydev).mdio.dev)) }
     }
 }
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8435f8132e38129ccc3495e7c4d3237fcaa97ad9..d620902219d78191d744df6a8970c0a99dbd47da 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -454,7 +454,7 @@ fn as_ref(&self) -> &device::Device<Ctx> {
         let dev = unsafe { addr_of_mut!((*self.as_raw()).dev) };
 
         // SAFETY: `dev` points to a valid `struct device`.
-        unsafe { device::Device::as_ref(dev) }
+        unsafe { device::Device::from_raw(dev) }
     }
 }
 
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 5b21fa517e55348582622ec10471918919502959..76e09429cdc275354b3ce84da5e74f7b97660430 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -215,7 +215,7 @@ fn as_ref(&self) -> &device::Device<Ctx> {
         let dev = unsafe { addr_of_mut!((*self.as_raw()).dev) };
 
         // SAFETY: `dev` points to a valid `struct device`.
-        unsafe { device::Device::as_ref(dev) }
+        unsafe { device::Device::from_raw(dev) }
     }
 }
 

-- 
2.50.0.727.gbf7dc18ff4-goog


