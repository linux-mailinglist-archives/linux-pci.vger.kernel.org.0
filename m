Return-Path: <linux-pci+bounces-29179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112D8AD156E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 00:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB70C3AB1E6
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jun 2025 22:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87F125D204;
	Sun,  8 Jun 2025 22:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="RrH6Tee0"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB120F069;
	Sun,  8 Jun 2025 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749423481; cv=pass; b=Vx/ihC05Zu2lcM8HIX5mNnFRiMPoJrTAZZuIGnZc76oQWZo8RbFlHJrhZBx1hbD7gkRm+dhkw2I7cxArKc5Wx48PBYQ3Nclk84AnxKNat0F0haAgGPThFTQpXp49J/CQWDjttZPaFeTMWvKmBTYJ/qH+sPw3aDrVkOtxPtQrvp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749423481; c=relaxed/simple;
	bh=CkCQ/sC8APhLpnw/J5o2x0EMAxl/8BjS9udEH3fE3Og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orIIK2aXI4NXFR9awkLfW/0twKn3FqkLSguiF027VlQUdkcKOlouE5Yt8O8gxTVvZV33cnCn+RWGTxzaEO440RY04ubkSguKfL3dbY9QtDOdke0pSmMBZwUt7zOjEarMDYmHiOzhJYQfzeYQUoiZIId95wC2kLYNuHYcbMPuj2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=RrH6Tee0; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749423463; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xp0OclK6eEHNmxKsFxFz9e1nl3REcWmdWlaI56tFB5vp5dkmarxLaVowtil94jYvexlmyfzx6PvNjX9gGF+fCLZKS7RN0OnfPSkHYEw4sqGIubHiI3PEIbKltXaPTUmxMI9J1GQMRcO1iuld+iOIqFvcOaaVvHzlrYHCqCDx6RQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749423463; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2s63SOE1NoYXN+GdFgykz83zv7+aivrpcY1WlxZbQwU=; 
	b=Y7dw1cayq5RePppcr5KUw9dAT1qndkuXwgUMWsbA6pVhGA1ZE1k+Bvs1gvqfdiyzZ4k05nV6i2iC5kE/HLRkkUA6uddNH0Q2DWw1p0I3aCSnxivOA2WJkShZgONtznuwtQHpLIaRT9DeevvofcEN+rB5yUT9SQ7uOJnd7gbxt1o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749423463;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=2s63SOE1NoYXN+GdFgykz83zv7+aivrpcY1WlxZbQwU=;
	b=RrH6Tee0jSphoDTgSjhySl+j8U5G/+EJtOkXKNdq7g2zTpvv9eZDnvNIJ9yEHkHz
	S6dDG8wpcq00dN67VbQZownvErV0ksHBUbO5Z4K2nVXboDhX4b0ekjTIb0s+l/slKz9
	b+5u9nX5Bb6vlG7pbR8YNGlZCzq7ZgyjOYSTIjg0=
Received: by mx.zohomail.com with SMTPS id 1749423460299953.9085347616196;
	Sun, 8 Jun 2025 15:57:40 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Sun, 08 Jun 2025 19:51:11 -0300
Subject: [PATCH v4 6/6] rust: pci: add irq accessors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250608-topics-tyr-request_irq-v4-6-81cb81fb8073@collabora.com>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
In-Reply-To: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pci@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

These accessors can be used to retrieve a irq::Registration or a
irq::ThreadedRegistration from a pci device.

These accessors ensure that only valid IRQ lines can ever be registered.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/pci.rs | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8435f8132e38129ccc3495e7c4d3237fcaa97ad9..c690fa1c739c937324e902e61e68df238dbd733b 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -395,6 +395,32 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
     }
 }
 
+macro_rules! gen_irq_accessor {
+    ($(#[$meta:meta])* $fn_name:ident, $reg_type:ident, $handler_trait:ident) => {
+        $(#[$meta])*
+        pub fn $fn_name<T: crate::irq::$handler_trait + 'static>(
+            &self,
+            index: u32,
+            flags: crate::irq::flags::Flags,
+            name: &'static crate::str::CStr,
+            handler: T,
+        ) -> Result<impl PinInit<crate::irq::$reg_type<T>, crate::error::Error> + '_> {
+            // SAFETY: `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+            let irq = unsafe { crate::bindings::pci_irq_vector(self.as_raw(), index) };
+            if irq < 0 {
+                return Err(crate::error::Error::from_errno(irq));
+            }
+            Ok(crate::irq::$reg_type::<T>::register(
+                self.as_ref(),
+                irq as u32,
+                flags,
+                name,
+                handler,
+            ))
+        }
+    };
+}
+
 impl Device<device::Bound> {
     /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
     /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
@@ -413,6 +439,15 @@ pub fn iomap_region_sized<const SIZE: usize>(
     pub fn iomap_region(&self, bar: u32, name: &CStr) -> Result<Devres<Bar>> {
         self.iomap_region_sized::<0>(bar, name)
     }
+
+    gen_irq_accessor!(
+        /// Returns a [`kernel::irq::Registration`] for the IRQ vector at the given index.
+        irq_by_index, Registration, Handler
+    );
+    gen_irq_accessor!(
+        /// Returns a [`kernel::irq::ThreadedRegistration`] for the IRQ vector at the given index.
+        threaded_irq_by_index, ThreadedRegistration, ThreadedHandler
+    );
 }
 
 impl Device<device::Core> {

-- 
2.49.0


