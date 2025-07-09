Return-Path: <linux-pci+bounces-31774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE16FAFEB28
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 16:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CD8189886B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4952E0B4B;
	Wed,  9 Jul 2025 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1SKxBIWW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0B42DFA39
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069225; cv=none; b=nuv4h515ooEEjVgQhlnwbFAZncEEz6up+eKRP9gt7Ro5Jd4zdG1VJLNDLN8SelCqHkjkdZdkmDrhM0MPFAY7KpUJDBHizNycqo5jKEevgV//EI2PSeLF3ieO8ExQIaU1kAhXTAE8Sl21Xdpn7fzr1n9G0jw0OyO3spGcCT9Ezhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069225; c=relaxed/simple;
	bh=klo7c5tt7NekeywtmvFjoxiWI5wByU3xZSRM1fO02/0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XxPp5KrOpKeJX4pZPAwDQPXnEJw8MExU3DDsmdMHz31NUlf1OfRCQ3lAjdVw8cXyuzMH4KyfxjG18lMMtJp6FSM6Bqazoxiz345KeW9zOhMtUcVo6kvE7Rws2qZQ+nwcwUW7727tp8BLIxPcRQwfcbQzynKB5mL3ITrr03Jdqq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1SKxBIWW; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ae354979e7aso446687666b.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2025 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752069220; x=1752674020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PjMR0rkfLib4KOAwr7EUr2rSkaUKKqk5NcFEo0YbN/w=;
        b=1SKxBIWWOETW0WUnPY3krdBhANPAcOM5YunJSwyQfs6HtwkUgNhe+hMOpa4fLqJMoO
         keFgsAGrdOx88toneluQwcUVWM3F3EY5GGfM7dnQGE5vrgSfGKkGV33lTjnZx+EOhJBK
         lpQHG9N1dkNZDFR4zyqX/g5GZJ6Oo7xDaa/7AfpwA84vkYYpwvjwZ7/7dw2UF24cFhK0
         DOCwpYx2HBhnyumyxhJnOd9dxueH/tv1IL63I0/UkQWONEISkmwPaIJ4XFoBED3gS+6j
         p7fMvjVCOcBwbmTheKssMaB1v+5RzbXNSP5GvAU80GMHXzzpruVKIKDO2f7R3mwVffSc
         5cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069220; x=1752674020;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjMR0rkfLib4KOAwr7EUr2rSkaUKKqk5NcFEo0YbN/w=;
        b=oeD8I+R8avOD500uIrXzIc9Bxurz1zCYSnLOYL5nAzOSy9tVPdGN9U1DJDJXg6TtUx
         56aEO5tVeav+ynFezNr0h8XUAA1gqIMPMZQKlCeSxezqL9zemA7szWAxSRhZvmE0XFYd
         fzc972PWbI6MiSOL0Sc+aN8iVm0ZjrBPkrqGoMHXd2W5VrF2DwhVW5M6JQw908yQ6B9F
         V3ydcWjMTP8DmbsTQa9F3vd5k9NSiu06152ZeROYHypfrl2SVpYhxu4BLTcxLH1Nh7DP
         rBuhzTYQvDdF+kXBHMK4N1bxUTr5sfcalSvyoRhxBfaQn4JCqITvo8fuDUIKkrXnjUh+
         Qsdw==
X-Forwarded-Encrypted: i=1; AJvYcCU3rIzvOB6wvaAct2trgKVgtyY4A/KGuiLeUUMKF1LgBvQSLv77NNoU04ueNmhp3P7d3vyZT2CDOmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxjabIHbhg5QcRrMHL3BuIJj2XjX7k0MXIjHgu6TBnYEI9O/gd
	YpjNLFSlv/g6qJXfhAt46xeGt7kNVtbw1/XkT+vLide0xb8eH/0g6jsoFbEgcDOOxWa0ixWp6H0
	Xy/MnKiZFeaOAIeO0KQ==
X-Google-Smtp-Source: AGHT+IHZ3nBXn4N+Z/Az/MiLRCZM7g2v/tIjPHAsSbmJjozLE+XeV0YAsnIKDu0plnzQocXtSqnZLEtbNnWHtEI=
X-Received: from ejbgz19.prod.google.com ([2002:a17:906:f2d3:b0:ae3:5be2:d994])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d09:b0:ae4:107f:dba2 with SMTP id a640c23a62f3a-ae6cf5bb9eemr254498366b.13.1752069220513;
 Wed, 09 Jul 2025 06:53:40 -0700 (PDT)
Date: Wed, 09 Jul 2025 13:53:36 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAF90bmgC/x2MQQqAMAwEvyI5G0gtRfQr4qE2UXOp0oII4t8NH
 meZnQeqFJUKY/NAkUurHtnAtQ2kPeZNUNkYOuoC9TQgm5QEY8UiK/pAvATvemYH9jlt1PvvTfP 7frzFDO5fAAAA
X-Change-Id: 20250709-device-as-ref-350db5317dd1
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=15349; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=klo7c5tt7NekeywtmvFjoxiWI5wByU3xZSRM1fO02/0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBobnRjFzxphfhr1oQAtBDE3uhqImpX6deYUUCMw
 bw2msuQsTOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaG50YwAKCRAEWL7uWMY5
 Ri/ZD/49Qg8p0AqQvWJc5hIrQoxfp0DPvLgQRASaSQqQL16JfVwqYkiJWmLXNhoEFnHtEDKy36h
 NTLiqgIpvoiKHrNOPidWGRsAQ4FCu5cXTR6lviorTPTn3RfLbysnaob1l++famJhRvq60yP/m6H
 1cXbZBAHGnBhXR+jJ4AOo7t2PlJlk7HC4P/HZQXxHYUEzTPVYH9M5keesYpG1CTDlUqvIkZ6nkY
 QyvqZhqE9RB2RmSQl00WjKpbXo3vp5QwMHnxu9T6mQw5ZPkDoy8GCoAOwNSbj7G1AzvSdW9EP0I
 39B2vWyiFGsSH4qsyN18O8xQGkDasyrRXzhYBbgSD9GB3jKVqXgmj32NOKp2dN4tj2d5MS+bNep
 8bjjLiDhTtdAALZD+QdKL/mMDiccN+/ELyrixhzy1RvnTcNgRVZJUd8/rWypxcCYr05TGuEwKZY
 DhZ1z8Bx/5pcZ8V2zK49YE0M0qvesNVvHL+16Gxpftcj1Mcvkru+9UTWuLw0At+P8iVyzfX4w7Z
 t7red/rmRstR9VXshFXZBxso7fs7O5TYji8Ij+d7+fBQmT4l8UQuOl1gFEIkULwFJWRFSzsl67R
 RSmZozJtG/Zfyq275ra9gOzIQaE5XaAnmhGrwmGzQ3SevDvqxgn2ZZBbcR1k2zu8r9E1tCPgeQc totRF3oE0IsOnrQ==
X-Mailer: b4 0.14.2
Message-ID: <20250709-device-as-ref-v1-1-ebf7059ffa9c@google.com>
Subject: [PATCH] drm: rust: rename Device::as_ref() to Device::from_raw()
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

Link: https://lore.kernel.org/r/aCZYcs6Aj-cz81qs@pollux
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/auxiliary.rs   |  2 +-
 rust/kernel/cpu.rs         |  2 +-
 rust/kernel/device.rs      |  6 +++---
 rust/kernel/drm/device.rs  |  4 ++--
 rust/kernel/drm/file.rs    |  8 ++++----
 rust/kernel/drm/gem/mod.rs | 16 ++++++++--------
 rust/kernel/drm/ioctl.rs   |  4 ++--
 rust/kernel/faux.rs        |  2 +-
 rust/kernel/miscdevice.rs  |  2 +-
 rust/kernel/net/phy.rs     |  2 +-
 rust/kernel/pci.rs         |  2 +-
 rust/kernel/platform.rs    |  2 +-
 12 files changed, 26 insertions(+), 26 deletions(-)

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
index 624d7a4c83ead64b93325189f481d9b37c3c6eae..d4906675c8d59f838a15388d1dad6b2960696ebb 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -154,7 +154,7 @@ unsafe fn from_drm_device(ptr: *const bindings::drm_device) -> *mut Self {
     /// Additionally, callers must ensure that the `struct device`, `ptr` is pointing to, is
     /// embedded in `Self`.
     #[doc(hidden)]
-    pub unsafe fn as_ref<'a>(ptr: *const bindings::drm_device) -> &'a Self {
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::drm_device) -> &'a Self {
         // SAFETY: By the safety requirements of this function `ptr` is a valid pointer to a
         // `struct drm_device` embedded in `Self`.
         let ptr = unsafe { Self::from_drm_device(ptr) };
@@ -190,7 +190,7 @@ impl<T: drm::Driver> AsRef<device::Device> for Device<T> {
     fn as_ref(&self) -> &device::Device {
         // SAFETY: `bindings::drm_device::dev` is valid as long as the DRM device itself is valid,
         // which is guaranteed by the type invariant.
-        unsafe { device::Device::as_ref((*self.as_raw()).dev) }
+        unsafe { device::Device::from_raw((*self.as_raw()).dev) }
     }
 }
 
diff --git a/rust/kernel/drm/file.rs b/rust/kernel/drm/file.rs
index b9527705e5514f00ed5a9c459f3c4161daf5b61d..e8789c9110d654df2561a88a53bc6b1cfa709fdd 100644
--- a/rust/kernel/drm/file.rs
+++ b/rust/kernel/drm/file.rs
@@ -32,7 +32,7 @@ impl<T: DriverFile> File<T> {
     /// # Safety
     ///
     /// `raw_file` must be a valid pointer to an open `struct drm_file`, opened through `T::open`.
-    pub unsafe fn as_ref<'a>(ptr: *mut bindings::drm_file) -> &'a File<T> {
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::drm_file) -> &'a File<T> {
         // SAFETY: `raw_file` is valid by the safety requirements of this function.
         unsafe { &*ptr.cast() }
     }
@@ -61,10 +61,10 @@ pub(crate) extern "C" fn open_callback(
         // SAFETY: A callback from `struct drm_driver::open` guarantees that
         // - `raw_dev` is valid pointer to a `struct drm_device`,
         // - the corresponding `struct drm_device` has been registered.
-        let drm = unsafe { drm::Device::as_ref(raw_dev) };
+        let drm = unsafe { drm::Device::from_raw(raw_dev) };
 
         // SAFETY: `raw_file` is a valid pointer to a `struct drm_file`.
-        let file = unsafe { File::<T>::as_ref(raw_file) };
+        let file = unsafe { File::<T>::from_raw(raw_file) };
 
         let inner = match T::open(drm) {
             Err(e) => {
@@ -89,7 +89,7 @@ pub(crate) extern "C" fn postclose_callback(
         raw_file: *mut bindings::drm_file,
     ) {
         // SAFETY: This reference won't escape this function
-        let file = unsafe { File::<T>::as_ref(raw_file) };
+        let file = unsafe { File::<T>::from_raw(raw_file) };
 
         // SAFETY: `file.driver_priv` has been created in `open_callback` through `KBox::into_raw`.
         let _ = unsafe { KBox::from_raw(file.driver_priv()) };
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 4cd69fa84318c3ff2cec57949e9bab05559a3c2f..a24c9a2fc201b69cc31b76282a68aec188aaac73 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -51,7 +51,7 @@ pub trait IntoGEMObject: Sized + super::private::Sealed + AlwaysRefCounted {
     /// - `self_ptr` must be a valid pointer to `Self`.
     /// - The caller promises that holding the immutable reference returned by this function does
     ///   not violate rust's data aliasing rules and remains valid throughout the lifetime of `'a`.
-    unsafe fn as_ref<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self;
+    unsafe fn from_raw<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self;
 }
 
 // SAFETY: All gem objects are refcounted.
@@ -86,12 +86,12 @@ extern "C" fn open_callback<T: BaseDriverObject<U>, U: BaseObject>(
 ) -> core::ffi::c_int {
     // SAFETY: `open_callback` is only ever called with a valid pointer to a `struct drm_file`.
     let file = unsafe {
-        drm::File::<<<U as IntoGEMObject>::Driver as drm::Driver>::File>::as_ref(raw_file)
+        drm::File::<<<U as IntoGEMObject>::Driver as drm::Driver>::File>::from_raw(raw_file)
     };
     // SAFETY: `open_callback` is specified in the AllocOps structure for `Object<T>`, ensuring that
     // `raw_obj` is indeed contained within a `Object<T>`.
     let obj = unsafe {
-        <<<U as IntoGEMObject>::Driver as drm::Driver>::Object as IntoGEMObject>::as_ref(raw_obj)
+        <<<U as IntoGEMObject>::Driver as drm::Driver>::Object as IntoGEMObject>::from_raw(raw_obj)
     };
 
     match T::open(obj, file) {
@@ -106,12 +106,12 @@ extern "C" fn close_callback<T: BaseDriverObject<U>, U: BaseObject>(
 ) {
     // SAFETY: `open_callback` is only ever called with a valid pointer to a `struct drm_file`.
     let file = unsafe {
-        drm::File::<<<U as IntoGEMObject>::Driver as drm::Driver>::File>::as_ref(raw_file)
+        drm::File::<<<U as IntoGEMObject>::Driver as drm::Driver>::File>::from_raw(raw_file)
     };
     // SAFETY: `close_callback` is specified in the AllocOps structure for `Object<T>`, ensuring
     // that `raw_obj` is indeed contained within a `Object<T>`.
     let obj = unsafe {
-        <<<U as IntoGEMObject>::Driver as drm::Driver>::Object as IntoGEMObject>::as_ref(raw_obj)
+        <<<U as IntoGEMObject>::Driver as drm::Driver>::Object as IntoGEMObject>::from_raw(raw_obj)
     };
 
     T::close(obj, file);
@@ -124,7 +124,7 @@ fn as_raw(&self) -> *mut bindings::drm_gem_object {
         self.obj.get()
     }
 
-    unsafe fn as_ref<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self {
+    unsafe fn from_raw<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self {
         let self_ptr: *mut Opaque<bindings::drm_gem_object> = self_ptr.cast();
 
         // SAFETY: `obj` is guaranteed to be in an `Object<T>` via the safety contract of this
@@ -170,9 +170,9 @@ fn lookup_handle(
         // - A `drm::Driver` can only have a single `File` implementation.
         // - `file` uses the same `drm::Driver` as `Self`.
         // - Therefore, we're guaranteed that `ptr` must be a gem object embedded within `Self`.
-        // - And we check if the pointer is null befoe calling as_ref(), ensuring that `ptr` is a
+        // - And we check if the pointer is null befoe calling from_raw(), ensuring that `ptr` is a
         //   valid pointer to an initialized `Self`.
-        let obj = unsafe { Self::as_ref(ptr) };
+        let obj = unsafe { Self::from_raw(ptr) };
 
         // SAFETY:
         // - We take ownership of the reference of `drm_gem_object_lookup()`.
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 445639404fb7fe2cf3276890b1236f611ded9f3f..fdec01c371687c79d660457bd2bd6e09b2400d35 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -134,7 +134,7 @@ macro_rules! declare_drm_ioctls {
                             // FIXME: Currently there is nothing enforcing that the types of the
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
-                            let dev = $crate::drm::device::Device::as_ref(raw_dev);
+                            let dev = $crate::drm::device::Device::from_raw(raw_dev);
                             // SAFETY: The ioctl argument has size `_IOC_SIZE(cmd)`, which we
                             // asserted above matches the size of this type, and all bit patterns of
                             // UAPI structs must be valid.
@@ -142,7 +142,7 @@ macro_rules! declare_drm_ioctls {
                                 &*(raw_data as *const $crate::types::Opaque<$crate::uapi::$struct>)
                             };
                             // SAFETY: This is just the DRM file structure
-                            let file = unsafe { $crate::drm::File::as_ref(raw_file) };
+                            let file = unsafe { $crate::drm::File::from_raw(raw_file) };
 
                             match $func(dev, data, file) {
                                 Err(e) => e.to_errno(),
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
 

---
base-commit: 86731a2a651e58953fc949573895f2fa6d456841
change-id: 20250709-device-as-ref-350db5317dd1

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


