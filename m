Return-Path: <linux-pci+bounces-30943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D17AEBD14
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 18:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84B83BC159
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2362EACF9;
	Fri, 27 Jun 2025 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="YwGaNcv2"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B92EAB80;
	Fri, 27 Jun 2025 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041337; cv=pass; b=iRpruJo/8Yy9fZm02VBO2Xry3Hy/bvK3B4mmQkMGPGGrSoxS4NgW8oVQ5UF5BOyStkaw1A6Um3Mmg0tEnXvhdkGvI2EfW0qfqUZnqw8x3pELwC73i1Ovt4q+Rm4uQQpVjBJ8ZRr1Bna8PeURKpOqr+v280LzrLL8ajTLqeZTDcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041337; c=relaxed/simple;
	bh=9QVLNmpFlJxco9Io8+xRWl3/tkfvBnkJ5v4p1lVDt5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcL4qnHCI+8iNlECYrwKpMZ7Eizn49YtaKRQ6wiJL//t7GUSU2pa/gILw2a5ZNUzofaRcxuAzq2KsuTwa1sCT7TVur9bs7V8CFB8amkDP7A/XU7vG2WUVhndKg7olALq1+/UPjQtG2b2mxweOQNCva31yUtcOlPBm1zz4TEFFhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=YwGaNcv2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751041317; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A5+fBBw1v95twjhxnyHpCGxc12/Aas6YeGTGuPC6frODMdjnjnbHLAHvkPhlSzRIcefhoHKW5PTkSvioMV5ZyvGmywZ6IF7d0TZd6p0wZdMAkQoYPjhJX9jYZ5ywgIcr9IqB1Lqc6wUCzsFr2FL+bT3Tck455Q17bXEWKOih5P0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751041317; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8KUHteAG14bnq4zqajKJEsvYdoQ2vrt6l/2WIKsu2Dc=; 
	b=AP/WW/g/PvwTBliseLvB5kTJw+EzDWvkcmSyULAXDH1jG4pz8CALaLYF/cDb5MMo/5BfJhTIn0jAKhhFeT3X8TyYx97267gDXzONHTZdnhJqRTZB7uJp8j8vhgAqUiqtGEw4UQxB/lfahGLSx/qRAeOtir9KaUBrHq7BnOV01DI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751041317;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=8KUHteAG14bnq4zqajKJEsvYdoQ2vrt6l/2WIKsu2Dc=;
	b=YwGaNcv2htqWgrIfh4UYa4O0olbuAvBjf4Awqpyg8JRZqBzWR9QSrqP42K1K2x6I
	XV8xF+UBKcKzCNwjK3rP1AS2fPmSe8QFnKDQbXfZl3s7u8SqZ70HrCr9j+RfuQnnbWu
	V1c2ozJODWN4SZavR158W8X3mTeImmADT7By9Gdc=
Received: by mx.zohomail.com with SMTPS id 1751041315119984.016417825778;
	Fri, 27 Jun 2025 09:21:55 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Jun 2025 13:21:08 -0300
Subject: [PATCH v5 6/6] rust: pci: add irq accessors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-topics-tyr-request_irq-v5-6-0545ee4dadf6@collabora.com>
References: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
In-Reply-To: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
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


