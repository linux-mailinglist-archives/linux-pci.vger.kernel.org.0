Return-Path: <linux-pci+bounces-31454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3C8AF816E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 21:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B354E0227
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 19:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F61301147;
	Thu,  3 Jul 2025 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="d8wnR/LI"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686DA301140;
	Thu,  3 Jul 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751571089; cv=pass; b=HdfgZgD3BDFLlDex4Lqug76ppGn5SKW/Dj/8zPDmZRoLJ34PMFxScODvNRo+Lyx0mbCMfBS0xtKat/Z/IGLSJqlTjRHFeHRG7/0fcsNOMkiY+5IhI6uQA/gZhTdaKAjgbn8WTU15fUX0bB5e6+Ku/BAjEGA3IAsP3Jlz1ZBehO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751571089; c=relaxed/simple;
	bh=9QVLNmpFlJxco9Io8+xRWl3/tkfvBnkJ5v4p1lVDt5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxcU+rjlijixfOd3bgVYPwWmUy+SZF9uCf8TCe907cDPb/4oKc7rLbS0LY4XKd71MVb8Sj6/IX0zSXalVGOfVZ2RW/QFS/zu9MLFG2S2WW9I+NnZLcTrU0kuzPTQ7N1ZhSR5aV8aHHa/6JHVZpDPt9lHfKJPpraQF8qDciS3CNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=d8wnR/LI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751571066; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nEcR6+v1uOVjI1O9P9cY7K3lU3fMAldzjK5ivz7yQPMS2lC7JhDtTZtroOgcPmgj4eyKTg3deBjMi07jwiywg1EHpwmkgtR3BKtQu7DX/DNkM1Ne+MrHjvRjyNZ8Xu2SPmnlCGI591kLUOSUGOtfkestEA4ZME2ER2ZtDIGj8kw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751571066; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8KUHteAG14bnq4zqajKJEsvYdoQ2vrt6l/2WIKsu2Dc=; 
	b=Z4cVVJTpSwvlkWcUm1cKlewpoHB0Ya6M2GmOQaVdtvoZwbp+tUiatOC9/MCqeeN4QI76L5ZnGs037m0iEUnbPjYvNWLaAlLbwHqaGYS+CzwFpl05ny1Fpwe+cxEkZ+47mq1TpSHNlVNfmeV3Ts7fvytIXb8TkHhTciJK8BHK0LU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751571066;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=8KUHteAG14bnq4zqajKJEsvYdoQ2vrt6l/2WIKsu2Dc=;
	b=d8wnR/LIwgYjb5ppI5fnfixPwvvhY/liVDH7V6JBUbHCCcc5T7Bm8G740fZKpNuG
	5GIDazcQ083fq9lIygTP6l1xHju59zd6wjDeTm8iPTDeEMibQFzoepOfKX1lcKz+BWl
	NDhKs2qx/zlBRiLHc9BVbe7y9Eut4+P5HSUWRjqE=
Received: by mx.zohomail.com with SMTPS id 1751571065262167.70532316283425;
	Thu, 3 Jul 2025 12:31:05 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 03 Jul 2025 16:30:04 -0300
Subject: [PATCH v6 6/6] rust: pci: add irq accessors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-topics-tyr-request_irq-v6-6-74103bdc7c52@collabora.com>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
In-Reply-To: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
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
irq::ThreadedRegistration from a pci device. Alternatively, drivers can
retrieve an IrqRequest from a bound PCI device for later use.

These accessors ensure that only valid IRQ lines can ever be registered.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/helpers/pci.c |  8 ++++++++
 rust/kernel/pci.rs | 45 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index cd0e6bf2cc4d9b37db3a717e7a8422b054f348ec..f372a32e8fd19730563ab51500e8c8764854ae47 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -21,3 +21,11 @@ bool rust_helper_dev_is_pci(const struct device *dev)
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
index db0eb7eaf9b10c5316366ef16fe722a03044a517..60d37d6459518c79136535ce03c73a5a3097eda8 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -10,8 +10,8 @@
     devres::Devres,
     driver,
     error::{to_result, Result},
-    io::Io,
-    io::IoRaw,
+    io::{Io, IoRaw},
+    irq::{self, request::IrqRequest},
     str::CStr,
     types::{ARef, ForeignOwnable, Opaque},
     ThisModule,
@@ -413,6 +413,47 @@ pub fn iomap_region<'a>(
     ) -> impl PinInit<Devres<Bar>, Error> + 'a {
         self.iomap_region_sized::<0>(bar, name)
     }
+
+    /// Returns an [`IrqRequest`] for the IRQ vector at the given index, if any.
+    pub fn request_irq_by_index(&self, index: u32) -> Result<IrqRequest<'_>> {
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
+    pub fn irq_by_index<T: crate::irq::Handler + 'static>(
+        &self,
+        index: u32,
+        flags: irq::flags::Flags,
+        name: &'static CStr,
+        handler: T,
+    ) -> Result<impl PinInit<irq::Registration<T>, Error> + '_> {
+        let request = self.request_irq_by_index(index)?;
+
+        Ok(irq::Registration::<T>::new(request, flags, name, handler))
+    }
+
+    /// Returns a [`kernel::irq::ThreadedRegistration`] for the IRQ vector at
+    /// the given index.
+    pub fn threaded_irq_by_index<T: crate::irq::ThreadedHandler + 'static>(
+        &self,
+        index: u32,
+        flags: irq::flags::Flags,
+        name: &'static CStr,
+        handler: T,
+    ) -> Result<impl PinInit<irq::ThreadedRegistration<T>, Error> + '_> {
+        let request = self.request_irq_by_index(index)?;
+
+        Ok(irq::ThreadedRegistration::<T>::new(
+            request, flags, name, handler,
+        ))
+    }
 }
 
 impl Device<device::Core> {

-- 
2.50.0


