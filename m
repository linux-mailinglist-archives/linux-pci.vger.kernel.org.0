Return-Path: <linux-pci+bounces-7681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BFE8CA163
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 19:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280BE282287
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 17:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECDF13AA5F;
	Mon, 20 May 2024 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEY0UYzJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A1B13AA54
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226058; cv=none; b=Oow7hIYq3kr00RqQYBxKvoly0oBhIoFXPL4wrD4eN2aH0qp3izHaIIUwlBQJyAdciUAydQdhVHEZZqTeMabqARC9Zxt7nFWRDySaSsspMwXCa1tf6ir7zROi1l0gQ1YJ7mPZ0Owe0aMFxfEw7SXdfES8uvIUIJME6GV5oJF3MlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226058; c=relaxed/simple;
	bh=ByeqkzM2jzSrDGnfHWAPGFr2QDs6pyQQOFnYXBVMUb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az9R83WeSmYJg5whqJKbI5jBUmel6lBbDeFpaBo23xiaTIr4d4KUsE8s/uMzHMMwsLfTgmG0+F9tJ11TinYHosJYYflFjk33mPxL6+jTpX3fs4VzqrtK0CyDXp5A5UHl+neHTZpMFypKodP9FdNJHmG9NNF7qIHQKfu7Xlbymso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEY0UYzJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716226056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+KTbXYumAmw16h3rTz/Xv/htYjuUG13nuBarwTBt2A=;
	b=TEY0UYzJ6TIs6wVxhJ+xBpd92VnDrqcllEDmysz3qSLu0ySSC3+s5//HOBPj6q7ORveuqu
	t+R7ws+0wXs59UuMAj/j9sExtqTiBa+0wpVe8PzAJJDBOJJOZ8UTQESlLESMYo37kNedh2
	H+d4RTfjz3ZrVmM6aInTck+7V0cJ/JU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-TYO6iMh7OymeUC5O7D4RMg-1; Mon, 20 May 2024 13:27:34 -0400
X-MC-Unique: TYO6iMh7OymeUC5O7D4RMg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34e01a857a6so6390212f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 10:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226053; x=1716830853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+KTbXYumAmw16h3rTz/Xv/htYjuUG13nuBarwTBt2A=;
        b=F1+f8IiSfPNSubQisEKTSWpIEfbnKa1+YRj7MiC9RAuHGJzsDI2sOg6CHFUtCC1cel
         ZDr+RusqY7X6e2OS6ETGSJVBXzaP2xvYuGUz4N7SK3NXHDk115yJWAxqXsxVx55nGSGr
         NVawJG7F/vK4FZuFhzi1SS3BvlBCNVYdTmOgRqCdEoJTFClIbM0N/G1wpuNTT8GPOH9t
         D1wU0K9x6iTyEXbI4SX6xE/Nul1cKE2upNmC7tWunoibF0W6HG7CqJJT6iXBCzEbCA9h
         9KaSVWVD2WcjngGfks7hDCtyHRmDY2zy8jCM7YpA541D935OArBx1qMPn9JomXyY16+m
         VC3g==
X-Forwarded-Encrypted: i=1; AJvYcCWabm+Bz6/5rPToEv9/4sOjGDc3rdg7rb5MQ+h4kDf1Ci856Yq9lyhF+skmVig2ZhO43RdclGXOWAHS7GWtZZFuiYM/vBWpiN0N
X-Gm-Message-State: AOJu0YwiIaLQ8+DWP2VjUD3AyKiEjPrTz/kdO28eqaAn01VSf9Y96az7
	pYq3Fh5ku3XEFHAkNB/rOJ0gdKMxH0mprhoYxbnwnoJS2Cnoti7fhVmdphXQvoIqmQUcYtrZmYt
	tPgpiXFA08OlTLJpdks4dDH4/0+U+FXVwW1A370G1jk2vCyr0KRaGeDkAkw==
X-Received: by 2002:a5d:4801:0:b0:34d:a5fd:977b with SMTP id ffacd0b85a97d-3504a969ffcmr20289213f8f.60.1716226053146;
        Mon, 20 May 2024 10:27:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa/Dnd6VAJ4Gwv9ggHRXIUtmNL29Xn1V3x1XOit8dv4TaIg0ybWQ9BXCbBKMeVj5eQB/k2Pw==
X-Received: by 2002:a5d:4801:0:b0:34d:a5fd:977b with SMTP id ffacd0b85a97d-3504a969ffcmr20289201f8f.60.1716226052819;
        Mon, 20 May 2024 10:27:32 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d7d0f3absm12506111f8f.73.2024.05.20.10.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:27:32 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [RFC PATCH 10/11] rust: add basic abstractions for iomem operations
Date: Mon, 20 May 2024 19:25:47 +0200
Message-ID: <20240520172554.182094-11-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520172554.182094-1-dakr@redhat.com>
References: <20240520172554.182094-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philipp Stanner <pstanner@redhat.com>

Access to the kernel's IO-functions (e.g., readb()) is needed by almost
all drivers. Currently, there are no abstractions for those functions.

Since iomem is so widely used, it's necessary to provide a generic
interface that all subsystems providing IO memory can use. The existing
C implementations of such subsystems typically provide their own
wrappers around functions like ioremap() which take care of respecting
resource boundaries etc. It is, therefore, desirable to use these
wrappers because using ioremap() and iounmap() directly would
effectively result in parts of those subsystems being reimplemented in
Rust.

As most if not all device drivers should be fully satisfied regarding
their iomem demands by the existing subsystem interfaces, Rust
abstractions as congruent as possible with the existing infrastructure
shall use the existing subsystem (e.g., PCI) interfaces for creating
IO mappings, while simultaneously wrapping those mappings in Rust
containers whose Drop() traits ensure that the resources are released
again.

The process for mapping iomem would consequently look as follows:

  1. The subsystem abstraction (e.g., PCI) requests and ioremaps the
     memory through the corresponding C functions.
  2. The subsystem uses resources obtained in step #1 to create a Rust
     IoMem data structure that implements the IO functionality such as
     readb() for the iomem.
  3. The subsystem code wrapps IoMem into additional containers that
     ensure, e.g., thread safety, prevent UAF etc. Additionally, the
     subsystem ensures that access to IoMem is revoked latest when the
     driver's remove() callback is invoked.

Hereby, the subsystem data structure obtains ownership over the iomem.
Release of the iomem and, possibly, other subsystem associated data is
then handled through the Drop() trait of the subsystem data structure.

IO memory can become invalid during runtime (for example because the
driver's remove() callback was invoked, revoking access to the driver's
resources). However, in parallel executing routines might still be
active. Consequently, the subsytem should also guard the iomem in some
way.

One way to do this is the Devres implementation, which provides a
container that is capable of revoking access to its payload when
the driver's remove() callback is invoked.

The figure illustrates what usage of IoMem through subsystems might look
like:
               Devres
  *------------------------------*
  |                              |
  |   subsystem data structure   |
  |   *----------------------*   |
  |   |        IoMem         |   |
  |   | *------------------* |   |
  |   | |  io_addr = 0x42, | |   |
  |   | |  io_len = 9001,  | |   |
  |   | |                  | |   |
  |   | |  readb(),        | |   |
  |   | |  writeb(),       | |   |
  |   | |  ...             | |   |
  |   | *------------------* |   |
  |   |   deref(),           |   |
  |   |   drop(),            |   |
  |   |   ...                |   |
  |   *----------------------*   |
  |    deref(),                  |
  |    drop(),                   |
  *------------------------------*

For additional convenience, subsystem abstractions can implement the
Deref() trait for their data structures so that access he iomem can be
fully transparent.

In summary, IoMem would just serve as a container providing the IO
functions, and the subsystem, which knows about the memory layout,
request mechanisms etc, shall create and guard IoMem and ensure that its
resources are released latest at remove() (through Devres) or earlier
through its Drop() implementation.

Add 'IoMem', a struct holding an IO-Pointer and a length parameter,
which both shall be initialized validly by the subsystem.

Add Rust abstractions for basic IO memory operations on IoMem.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/helpers.c       | 106 +++++++++++++++++++++++++++++++++
 rust/kernel/iomem.rs | 135 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 241 insertions(+)
 create mode 100644 rust/kernel/iomem.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index c3d80301185c..dc2405772b1a 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -34,6 +34,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/pci.h>
+#include <linux/io.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -179,6 +180,111 @@ int rust_helper_devm_add_action(struct device *dev, void (*action)(void *), void
 	return devm_add_action(dev, action, data);
 }
 
+/* io.h */
+u8 rust_helper_readb(const volatile void __iomem *addr)
+{
+	return readb(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readb);
+
+u16 rust_helper_readw(const volatile void __iomem *addr)
+{
+	return readw(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readw);
+
+u32 rust_helper_readl(const volatile void __iomem *addr)
+{
+	return readl(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readl);
+
+#ifdef CONFIG_64BIT
+u64 rust_helper_readq(const volatile void __iomem *addr)
+{
+	return readq(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readq);
+#endif
+
+void rust_helper_writeb(u8 value, volatile void __iomem *addr)
+{
+	writeb(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writeb);
+
+void rust_helper_writew(u16 value, volatile void __iomem *addr)
+{
+	writew(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writew);
+
+void rust_helper_writel(u32 value, volatile void __iomem *addr)
+{
+	writel(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writel);
+
+#ifdef CONFIG_64BIT
+void rust_helper_writeq(u64 value, volatile void __iomem *addr)
+{
+	writeq(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writeq);
+#endif
+
+u8 rust_helper_readb_relaxed(const volatile void __iomem *addr)
+{
+	return readb_relaxed(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readb_relaxed);
+
+u16 rust_helper_readw_relaxed(const volatile void __iomem *addr)
+{
+	return readw_relaxed(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readw_relaxed);
+
+u32 rust_helper_readl_relaxed(const volatile void __iomem *addr)
+{
+	return readl_relaxed(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readl_relaxed);
+
+#ifdef CONFIG_64BIT
+u64 rust_helper_readq_relaxed(const volatile void __iomem *addr)
+{
+	return readq_relaxed(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_readq_relaxed);
+#endif
+
+void rust_helper_writeb_relaxed(u8 value, volatile void __iomem *addr)
+{
+	writeb_relaxed(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writeb_relaxed);
+
+void rust_helper_writew_relaxed(u16 value, volatile void __iomem *addr)
+{
+	writew_relaxed(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writew_relaxed);
+
+void rust_helper_writel_relaxed(u32 value, volatile void __iomem *addr)
+{
+	writel_relaxed(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writel_relaxed);
+
+#ifdef CONFIG_64BIT
+void rust_helper_writeq_relaxed(u64 value, volatile void __iomem *addr)
+{
+	writeq_relaxed(value, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_writeq_relaxed);
+#endif
+
 void rust_helper_pci_set_drvdata(struct pci_dev *pdev, void *data)
 {
 	pci_set_drvdata(pdev, data);
diff --git a/rust/kernel/iomem.rs b/rust/kernel/iomem.rs
new file mode 100644
index 000000000000..efb6cd0829b4
--- /dev/null
+++ b/rust/kernel/iomem.rs
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use crate::bindings;
+use crate::error::{code::EINVAL, Result};
+
+/// IO-mapped memory, starting at the base pointer @ioptr and spanning @malxen bytes.
+///
+/// The creator (usually a subsystem such as PCI) is responsible for creating the
+/// mapping, performing an additional region request etc.
+pub struct IoMem {
+    pub ioptr: usize,
+    maxlen: usize,
+}
+
+impl IoMem {
+    pub(crate) fn new(ioptr: usize, maxlen: usize) -> Result<Self> {
+        if ioptr == 0 || maxlen == 0 {
+            return Err(EINVAL);
+        }
+
+        Ok(Self { ioptr, maxlen })
+    }
+
+    fn get_io_addr(&self, offset: usize, len: usize) -> Result<usize> {
+        if offset + len > self.maxlen {
+            return Err(EINVAL);
+        }
+
+        Ok(self.ioptr + offset)
+    }
+
+    pub fn readb(&self, offset: usize) -> Result<u8> {
+        let ioptr: usize = self.get_io_addr(offset, 1)?;
+
+        Ok(unsafe { bindings::readb(ioptr as _) })
+    }
+
+    pub fn readw(&self, offset: usize) -> Result<u16> {
+        let ioptr: usize = self.get_io_addr(offset, 2)?;
+
+        Ok(unsafe { bindings::readw(ioptr as _) })
+    }
+
+    pub fn readl(&self, offset: usize) -> Result<u32> {
+        let ioptr: usize = self.get_io_addr(offset, 4)?;
+
+        Ok(unsafe { bindings::readl(ioptr as _) })
+    }
+
+    pub fn readq(&self, offset: usize) -> Result<u64> {
+        let ioptr: usize = self.get_io_addr(offset, 8)?;
+
+        Ok(unsafe { bindings::readq(ioptr as _) })
+    }
+
+    pub fn readb_relaxed(&self, offset: usize) -> Result<u8> {
+        let ioptr: usize = self.get_io_addr(offset, 1)?;
+
+        Ok(unsafe { bindings::readb_relaxed(ioptr as _) })
+    }
+
+    pub fn readw_relaxed(&self, offset: usize) -> Result<u16> {
+        let ioptr: usize = self.get_io_addr(offset, 2)?;
+
+        Ok(unsafe { bindings::readw_relaxed(ioptr as _) })
+    }
+
+    pub fn readl_relaxed(&self, offset: usize) -> Result<u32> {
+        let ioptr: usize = self.get_io_addr(offset, 4)?;
+
+        Ok(unsafe { bindings::readl_relaxed(ioptr as _) })
+    }
+
+    pub fn readq_relaxed(&self, offset: usize) -> Result<u64> {
+        let ioptr: usize = self.get_io_addr(offset, 8)?;
+
+        Ok(unsafe { bindings::readq_relaxed(ioptr as _) })
+    }
+
+    pub fn writeb(&self, byte: u8, offset: usize) -> Result {
+        let ioptr: usize = self.get_io_addr(offset, 1)?;
+
+        unsafe { bindings::writeb(byte, ioptr as _) }
+        Ok(())
+    }
+
+    pub fn writew(&self, word: u16, offset: usize) -> Result {
+        let ioptr: usize = self.get_io_addr(offset, 2)?;
+
+        unsafe { bindings::writew(word, ioptr as _) }
+        Ok(())
+    }
+
+    pub fn writel(&self, lword: u32, offset: usize) -> Result {
+        let ioptr: usize = self.get_io_addr(offset, 4)?;
+
+        unsafe { bindings::writel(lword, ioptr as _) }
+        Ok(())
+    }
+
+    pub fn writeq(&self, qword: u64, offset: usize) -> Result {
+        let ioptr: usize = self.get_io_addr(offset, 8)?;
+
+        unsafe { bindings::writeq(qword, ioptr as _) }
+        Ok(())
+    }
+
+    pub fn writeb_relaxed(&self, byte: u8, offset: usize) -> Result {
+        let ioptr: usize = self.get_io_addr(offset, 1)?;
+
+        unsafe { bindings::writeb_relaxed(byte, ioptr as _) }
+        Ok(())
+    }
+
+    pub fn writew_relaxed(&self, word: u16, offset: usize) -> Result {
+        let ioptr: usize = self.get_io_addr(offset, 2)?;
+
+        unsafe { bindings::writew_relaxed(word, ioptr as _) }
+        Ok(())
+    }
+
+    pub fn writel_relaxed(&self, lword: u32, offset: usize) -> Result {
+        let ioptr: usize = self.get_io_addr(offset, 4)?;
+
+        unsafe { bindings::writel_relaxed(lword, ioptr as _) }
+        Ok(())
+    }
+
+    pub fn writeq_relaxed(&self, qword: u64, offset: usize) -> Result {
+        let ioptr: usize = self.get_io_addr(offset, 8)?;
+
+        unsafe { bindings::writeq_relaxed(qword, ioptr as _) }
+        Ok(())
+    }
+}
-- 
2.45.1


