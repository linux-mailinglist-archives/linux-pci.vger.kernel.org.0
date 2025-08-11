Return-Path: <linux-pci+bounces-33682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E695B1FD53
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 02:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A203F176A9F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 00:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04601E493C;
	Mon, 11 Aug 2025 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dZbh67sa"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C297A19CC3E;
	Mon, 11 Aug 2025 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754872398; cv=none; b=lUklFjywjx1XYQfL1OUiyJYmi+RibF+LhLpV4OtWwm84aU4UItLVhzF3DW7soniIKyCaCx7gG+V8b9xZKgYtW/XvMWvYLdCM2rlJJFhCH8JwSAKHNS668s8f71hddoin+J2qQF0rHJjqqzlrUt+tbij7H8B8YkqnqGUHhM60224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754872398; c=relaxed/simple;
	bh=CYOapTVPSDx9GSpWtaaFifCskH311+ECf5s+Y9qoPqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ip2xxoN+sFUk0Bwgz7paMERtD4j2uCOwAV6dhuhc0dqbi9tJXo/XlYXzdROvnzZ2xzz+s5hmbGA80YCQV32gSLpXymTRIY2grxsCzqE8HN1aAkg0DXWvL9stfeTb5HqdQEkjMIqB6/JK3BsC2hWzPJhHn+QC+Mi/9MT1c4C1sys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dZbh67sa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754872395;
	bh=CYOapTVPSDx9GSpWtaaFifCskH311+ECf5s+Y9qoPqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dZbh67saU8PuWrTKFkVLS6iRHRyuIh0bfFPC4xW2Pfj6tXCZ6AknpNyHA6OYvAuGE
	 eJgTmC1mtbX7MhFQLm4fwioTRRqc5tIj8rEeTz/z/IBNTEl6Rr5oxQCgtYP7UI7xmE
	 DKWTJvsVR1jAq6+qPKN1PJsYDkxmVlqOwGYRPh3MTyA1UJTh8KDZxz3l7CtxnYscPd
	 eMAK/xqBwXAhAoIW4cFtfP7ub6MrKFLBFs7UTUPgmISUy+z0scyB8B8nKljX8vFKH/
	 JQy6160rjZwKMQ5RW2rUvIoBcdCl53n8MbW3D6FLH6EU6ivL6jBS+7fBJBZSlHdNcC
	 GqxTlJvWmE79A==
Received: from [192.168.0.23] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 37A6E17E0B8C;
	Mon, 11 Aug 2025 02:33:10 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Sun, 10 Aug 2025 21:32:19 -0300
Subject: [PATCH v8 6/6] rust: pci: add irq accessors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-topics-tyr-request_irq2-v8-6-8163f4c4c3a6@collabora.com>
References: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com>
In-Reply-To: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com>
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
index 887ee611b55310e7edbd512f9017b708ff9d7bd8..d84ebabb8d04a932e68e48d40fef667dcda25ded 100644
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
+        flags: irq::flags::Flags,
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
+        flags: irq::flags::Flags,
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


