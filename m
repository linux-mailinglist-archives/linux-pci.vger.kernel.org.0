Return-Path: <linux-pci+bounces-38252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19D7BE0249
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 20:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9901A21E22
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 18:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA6D33EB04;
	Wed, 15 Oct 2025 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvERTfaf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8933A01F;
	Wed, 15 Oct 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552499; cv=none; b=EZWRYjD6booFGkSi8vNvV3yTCu+rsV9n+KYg2j/umUmMlHQwQ+lwqHyxLdNa2Q53A94A4T0Zg7sp/EsuZnyl9OYphkfNjbSQXNh3DOfthtAZvtrCmwQt4kMXWduZuqCgh4Y+uXrdh2Mjl8cxbSxiVZJHlahUUUgS1isvXA3BenA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552499; c=relaxed/simple;
	bh=0jU3SZC0kW+muc4oDf5PDo4jUG2aFggEdQM/J88JpKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BW/g5pN4PysCXY6G1mkQpKAwVloYP5PzBsCLwKvjTJZ6jbpQPhAshoOE9n341lfRwr3RDMACoy8sLIkz7YFlisawz1eB1FryMoKbVMMSJ56ujIXn2AMtq3DCBLHy97BYG/iFPVgfFIrwSlG9AR1+kqAVR0n04/xTFPXzdc+u5Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvERTfaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2541C4AF54;
	Wed, 15 Oct 2025 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760552498;
	bh=0jU3SZC0kW+muc4oDf5PDo4jUG2aFggEdQM/J88JpKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uvERTfafvEQ0FQTycCGn1JqWrBBqIN478sCrtim29abCMBLVbL6O70GHA8ADCjN8I
	 atFacmmYKYEmQAnM0thbH/9B/thxFAsAsn62kFRGGvIglNbQ7PHtweN1Mh9LL0tdq9
	 OFUYMz9rZU1dTEvKXhBTF+XN2uXy1x3o7uNIyZvaMmg6YoZ5uKQUEp2731xyo/Fx3e
	 Tsm90ihX+Hy4Z70d2CVn/zp6KYMJ51n/uMkJoursthIl20vIcfekGLneIKKDI3SOzO
	 HbmLAInrHtrBcaSqrXKKIpVsAEUKIlJGTtAnE58+wgktcF+WyatsZhwKMs23+xcboV
	 W3/+BaJj6NRLg==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/3] rust: pci: implement TryInto<IrqRequest<'a>> for IrqVector<'a>
Date: Wed, 15 Oct 2025 20:14:29 +0200
Message-ID: <20251015182118.106604-2-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015182118.106604-1-dakr@kernel.org>
References: <20251015182118.106604-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement TryInto<IrqRequest<'a>> for IrqVector<'a> to directly convert
a pci::IrqVector into a generic IrqRequest, instead of taking the
indirection via an unrelated pci::Device method.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index d91ec9f008ae..c6b750047b2e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -596,6 +596,20 @@ fn index(&self) -> u32 {
     }
 }
 
+impl<'a> TryInto<IrqRequest<'a>> for IrqVector<'a> {
+    type Error = Error;
+
+    fn try_into(self) -> Result<IrqRequest<'a>> {
+        // SAFETY: `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        let irq = unsafe { bindings::pci_irq_vector(self.dev.as_raw(), self.index()) };
+        if irq < 0 {
+            return Err(crate::error::Error::from_errno(irq));
+        }
+        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
+        Ok(unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) })
+    }
+}
+
 /// Represents an IRQ vector allocation for a PCI device.
 ///
 /// This type ensures that IRQ vectors are properly allocated and freed by
@@ -675,31 +689,15 @@ pub fn iomap_region<'a>(
         self.iomap_region_sized::<0>(bar, name)
     }
 
-    /// Returns an [`IrqRequest`] for the given IRQ vector.
-    pub fn irq_vector(&self, vector: IrqVector<'_>) -> Result<IrqRequest<'_>> {
-        // Verify that the vector belongs to this device.
-        if !core::ptr::eq(vector.dev.as_raw(), self.as_raw()) {
-            return Err(EINVAL);
-        }
-
-        // SAFETY: `self.as_raw` returns a valid pointer to a `struct pci_dev`.
-        let irq = unsafe { crate::bindings::pci_irq_vector(self.as_raw(), vector.index()) };
-        if irq < 0 {
-            return Err(crate::error::Error::from_errno(irq));
-        }
-        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
-        Ok(unsafe { IrqRequest::new(self.as_ref(), irq as u32) })
-    }
-
     /// Returns a [`kernel::irq::Registration`] for the given IRQ vector.
     pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
         &'a self,
-        vector: IrqVector<'_>,
+        vector: IrqVector<'a>,
         flags: irq::Flags,
         name: &'static CStr,
         handler: impl PinInit<T, Error> + 'a,
     ) -> Result<impl PinInit<irq::Registration<T>, Error> + 'a> {
-        let request = self.irq_vector(vector)?;
+        let request = vector.try_into()?;
 
         Ok(irq::Registration::<T>::new(request, flags, name, handler))
     }
@@ -707,12 +705,12 @@ pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
     /// Returns a [`kernel::irq::ThreadedRegistration`] for the given IRQ vector.
     pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
         &'a self,
-        vector: IrqVector<'_>,
+        vector: IrqVector<'a>,
         flags: irq::Flags,
         name: &'static CStr,
         handler: impl PinInit<T, Error> + 'a,
     ) -> Result<impl PinInit<irq::ThreadedRegistration<T>, Error> + 'a> {
-        let request = self.irq_vector(vector)?;
+        let request = vector.try_into()?;
 
         Ok(irq::ThreadedRegistration::<T>::new(
             request, flags, name, handler,
-- 
2.51.0


