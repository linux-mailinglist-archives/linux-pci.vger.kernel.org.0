Return-Path: <linux-pci+bounces-32172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C603FB062C2
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 17:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674A81657F6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C704126B76A;
	Tue, 15 Jul 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="po6MU4K9"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA15326B767;
	Tue, 15 Jul 2025 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592638; cv=none; b=sfx0czMfl+/sUWx3Mbn+2pTBIOjnAwLf0LeL1VcS773Zy89g8m/uDBNhYkDtjVhAcHjJGYqQbibmRgwV8AYecwKI2t4IfaY9RrQkFI41w1NVhlEMQhqxlKYHwraBFu9hq6hxVDjDwvAJZfAsJNh4syBMXj01A6golbae2lxYyjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592638; c=relaxed/simple;
	bh=Y5QpKSmWd6Wsb5VPbgQX80SRQm5mOODfgl3DJQHXIic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RCUmpt3FNcFGoNP36F1etG1shmBTv1LSqn9Y9J7oEVE/CnW6eqbjpCsv+nQU1rvILk/Ih0vzE+bymnHQZ+PGnPwpuYoS8qbJTpkAZ8j8fTHkL/+VZVX/YVjd9OemS1BKmDmEd/Ywa0CX0jr9JVsDFmpgI1yFMzdxLou//X0IWxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=po6MU4K9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752592635;
	bh=Y5QpKSmWd6Wsb5VPbgQX80SRQm5mOODfgl3DJQHXIic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=po6MU4K9B+NVMA87SwrN4nZJsx2E4MX3JzOC0k76j6/qAgOiV8tBDV6HRo50ztGR7
	 LyvYJyQW7T49UIwswgVWTVjGW73mWBX4PeekQdVRYcIpIVqXxk3ZCyt0W9TtRsBJhV
	 E89IqH/VvbwiDm1QGx0JlM9GGtq+rGwFh+VajA+oVFMAO1T15OsUa6BAjuMam2Qo7Q
	 1d32v6PYYfbr7RfYOWUE3HHcTTIW1bHPK2Xo7SxNiT/f7hf2Y8zUeR2FNtCnqJjNvS
	 EIgzRHqtYVawGlxjjoxuTlAeIh1nSZZgcQyzoNOtfpl7yogqfdgEmZzawujEFtvK2B
	 ojIj5MRT9NasQ==
Received: from [192.168.0.2] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 84B6517E1325;
	Tue, 15 Jul 2025 17:17:12 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 15 Jul 2025 12:16:43 -0300
Subject: [PATCH v7 6/6] rust: pci: add irq accessors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-topics-tyr-request_irq2-v7-6-d469c0f37c07@collabora.com>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
In-Reply-To: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pci@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

These accessors can be used to retrieve a irq::Registration or a
irq::ThreadedRegistration from a pci device. Alternatively, drivers can
retrieve an IrqRequest from a bound PCI device for later use.

These accessors ensure that only valid IRQ lines can ever be registered.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/helpers/pci.c |  8 ++++++++
 rust/kernel/pci.rs | 45 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index ef9cb38c81a6a5375f72c3676cd9730aad17757b..5bf56004478c6945dc3e1a394fcd787c656d8b2a 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -11,3 +11,11 @@ bool rust_helper_dev_is_pci(const struct device *dev)
 {
 	return dev_is_pci(dev);
 }
+
+#ifndef CONFIG_PCI_MSI
+int rust_helper_pci_irq_vector(struct pci_dev *pdev, unsigned int nvec)
+{
+	return pci_irq_vector(pdev, nvec);
+}
+
+#endif
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8b884e324dcfcef2a2e69b009fe1e3071efe7066..1ae390245fc62a078ce9dfd6f67b27368a5aeba2 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -10,8 +10,8 @@
     devres::Devres,
     driver,
     error::{from_result, to_result, Result},
-    io::Io,
-    io::IoRaw,
+    io::{Io, IoRaw},
+    irq::{self, IrqRequest},
     str::CStr,
     types::{ARef, Opaque},
     ThisModule,
@@ -427,6 +427,47 @@ pub fn iomap_region<'a>(
     ) -> impl PinInit<Devres<Bar>, Error> + 'a {
         self.iomap_region_sized::<0>(bar, name)
     }
+
+    /// Returns an [`IrqRequest`] for the IRQ vector at the given index, if any.
+    pub fn irq_vector(&self, index: u32) -> Result<IrqRequest<'_>> {
+        // SAFETY: `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        let irq = unsafe { crate::bindings::pci_irq_vector(self.as_raw(), index) };
+        if irq < 0 {
+            return Err(crate::error::Error::from_errno(irq));
+        }
+        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
+        Ok(unsafe { IrqRequest::new(self.as_ref(), irq as u32) })
+    }
+
+    /// Returns a [`kernel::irq::Registration`] for the IRQ vector at the given
+    /// index.
+    pub fn request_irq<T: crate::irq::Handler + 'static>(
+        &self,
+        index: u32,
+        flags: irq::flags::Flags,
+        name: &'static CStr,
+        handler: T,
+    ) -> Result<impl PinInit<irq::Registration<T>, Error> + '_> {
+        let request = self.irq_vector(index)?;
+
+        Ok(irq::Registration::<T>::new(request, flags, name, handler))
+    }
+
+    /// Returns a [`kernel::irq::ThreadedRegistration`] for the IRQ vector at
+    /// the given index.
+    pub fn request_threaded_irq<T: crate::irq::ThreadedHandler + 'static>(
+        &self,
+        index: u32,
+        flags: irq::flags::Flags,
+        name: &'static CStr,
+        handler: T,
+    ) -> Result<impl PinInit<irq::ThreadedRegistration<T>, Error> + '_> {
+        let request = self.irq_vector(index)?;
+
+        Ok(irq::ThreadedRegistration::<T>::new(
+            request, flags, name, handler,
+        ))
+    }
 }
 
 impl Device<device::Core> {

-- 
2.50.0


