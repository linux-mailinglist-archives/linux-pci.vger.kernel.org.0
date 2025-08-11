Return-Path: <linux-pci+bounces-33762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 723F9B21167
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 18:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD8D189D86C
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25722E4244;
	Mon, 11 Aug 2025 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="q2r0s0/i"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30D32E4240;
	Mon, 11 Aug 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928274; cv=none; b=s19uhjRAJUqz/Nk4tEow3QMr2Fok2XoDDZURRKk0uvkFsccrUILII8NEZlBBLQ4jz8O9iaPFvDK7R2g20P2f3toSKKqkmrfojawKPriTsAZyRTcM2qOUOAU15LZhT5v629Ds89FKnKgDUas48WoATuZyivUFqfqAyhCENfIflgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928274; c=relaxed/simple;
	bh=mOSeltVes00yZ6zMOLeC+fORp4G9BVNpUzfSg1BVS6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=avTMAz8zxrlBZZ6HEWnPxoEXyXWruk/lyMsDuC9YQkS9DU0BxKnJfByC1pal14BDMRnobNW5IG4c13tv1QRy5gCFOI0+RWrI8BLuxvSt7dQyF2S57+LWrVHDct4sFaRxAez7b5mhQiOPjtMNC8UwcS0HptVLESSeO4Hc/i4PNuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=q2r0s0/i; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754928271;
	bh=mOSeltVes00yZ6zMOLeC+fORp4G9BVNpUzfSg1BVS6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q2r0s0/iQmNuyUziY3HWEmR3Tdgz7PTOEcHigllncZjuN0J+4o84m621fwU7moFDU
	 jpfIwL4rFcqtIlCQCMfQ1OcmYx3liFbwtxJ/uLDKtcZ0vep4f0OG3eWabonqcYGEG8
	 Psz+YHoKQF7uWXtWGrIsQZ58ppqr3RnreGeZK7K9TlumJLUvAEp7RmjCQsFcDxKOQo
	 1+rL20qwFdiicngDm75ViSkfQljgDg5eX9VYQwzW02aliL1c13nLtzN9FN/aFPJlxq
	 DSAhL+d3EklCmY+7psV1c9RX0xPgYaWuk/r+KAp3n+4lAybZZlT9isU4wezlrXN+SP
	 4hcfSuy2hq+eg==
Received: from [192.168.0.23] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0485917E00EC;
	Mon, 11 Aug 2025 18:04:26 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 11 Aug 2025 13:03:44 -0300
Subject: [PATCH v9 6/7] rust: pci: add irq accessors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-topics-tyr-request_irq2-v9-6-0485dcd9bcbf@collabora.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
In-Reply-To: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
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
 linux-pci@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>, 
 Dirk Behme <dirk.behme@de.bosch.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

These accessors can be used to retrieve a irq::Registration or a
irq::ThreadedRegistration from a pci device. Alternatively, drivers can
retrieve an IrqRequest from a bound PCI device for later use.

These accessors ensure that only valid IRQ lines can ever be registered.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
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
index 887ee611b55310e7edbd512f9017b708ff9d7bd8..3bf1737635a9e219c3eec3f4c5f8e4e07b553b86 100644
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
@@ -431,6 +431,47 @@ pub fn iomap_region<'a>(
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
+    pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
+        &'a self,
+        index: u32,
+        flags: irq::Flags,
+        name: &'static CStr,
+        handler: impl PinInit<T, Error> + 'a,
+    ) -> Result<impl PinInit<irq::Registration<T>, Error> + 'a> {
+        let request = self.irq_vector(index)?;
+
+        Ok(irq::Registration::<T>::new(request, flags, name, handler))
+    }
+
+    /// Returns a [`kernel::irq::ThreadedRegistration`] for the IRQ vector at
+    /// the given index.
+    pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
+        &'a self,
+        index: u32,
+        flags: irq::Flags,
+        name: &'static CStr,
+        handler: impl PinInit<T, Error> + 'a,
+    ) -> Result<impl PinInit<irq::ThreadedRegistration<T>, Error> + 'a> {
+        let request = self.irq_vector(index)?;
+
+        Ok(irq::ThreadedRegistration::<T>::new(
+            request, flags, name, handler,
+        ))
+    }
 }
 
 impl Device<device::Core> {

-- 
2.50.1


