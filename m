Return-Path: <linux-pci+bounces-7674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCF18CA152
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 19:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFCE1C21026
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598E7139580;
	Mon, 20 May 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8kUejGT"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7A5137C48
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226030; cv=none; b=nyDQ2svgwhOMBZIYjpxKlzW9ack7cet96FzFdTMJ0nQHgCjxH1vWj53fM+GKjv1FVo8cMt9wc00knQGHONjw0Pm1UMkpyToWP0xP2tpuvQ3OoXeTmgWeW9MZnlnSU/idq6WyWZoDO4NVsqXC15tvLosm2A/RYCBDFORZkWrx6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226030; c=relaxed/simple;
	bh=wZpumSaAgofzk39YfBsp32v4+ebHuETq3cEP9jzCvOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vic02Adg4ONVV4yWdt3I2UUrTdn6PgrajCrxGn7miFnjFYaEs8wOF8Kqwo/KMYAQTfo9WdbQnWwyZ557KxO5PUZ+BUphAFnZvX/IZQJGBBfz22Z3KZCn+9C8Y/mdo8yOBfUBcwsyrey7ndyU046zW+a2ZXcaRqNe02tExIHiVEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8kUejGT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716226027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CImq0b4mEhq1pg3qJ1z+g35+FLQKy2u4BGJkZOUedY=;
	b=M8kUejGT966ZQvgKzLtiyjigQvuoaYOysHWIe7ZurdnJEX9cVpvPrjmyzMfqCxMmQAbXvk
	cTsVFlvq5AJHzjI00g1mvJbRA7X/fAWhsn6t6VVzE3chqgXKKOGceXCbpM/wRgYN3S2SEF
	kMXb/kPu4CqyPjSMGDvOZFQQPkt8T4s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-0tdEDKQWN1ercoXJkX9N_w-1; Mon, 20 May 2024 13:27:06 -0400
X-MC-Unique: 0tdEDKQWN1ercoXJkX9N_w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41ffc807e80so45569375e9.2
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 10:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226025; x=1716830825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CImq0b4mEhq1pg3qJ1z+g35+FLQKy2u4BGJkZOUedY=;
        b=gOHXqdLgTgSxao+5FeMfyi8WF9b+KfXWBPEp7IrZN3eIWw7nZZiaid8iQZWDV0T4lb
         dIIpsErUYTnZs9Swu1Xsw2jzOTgYZ8lnTvQyC91ZpIsQvV746O7Wng4TDJwhlJmfbOH9
         s4X6iuuz4WGog6sxIzuVrvUlTMNBrU/mtdEGHkIv7b9EQPcI3PQEz8Qkh7FV73p5Pj4k
         yGTnwa6p/HTjGLNl9EzYx8pmVu1ywoH/rk7g9DT2xPeTh4aZXo1YbkBULCJxaKr6hJOe
         lqX6NyigR4cE2pv5GeF8KUnfJmNpwB9jAHvDj6kTW+LBAVoaRa7/lYWpwZZkCCg4P/0w
         l1og==
X-Forwarded-Encrypted: i=1; AJvYcCVpN34D+l+DD7IHWGIZVVCq3giaqFxAGDmFYawlOyZVSjzh6iCAaN+EuAVIxx01c8z9S4yaT2WN0Gn4J92eS6ve9al2TOXTvOqI
X-Gm-Message-State: AOJu0YxtMVXqdTDHiJgUYznjIRlPZaMvaRKLXDCkkH73KG1CiDnQ1WUV
	EsT3XLGXX+c+KrFSx4y/BnRIm/wX8+R1YIwXjoOJ+hdhmYYormBs3XQc9niteM/jcM5rmX2JknJ
	hS7EZWeERoLyUATnKmN8Wj7LyUkeE1GuQMZyqTULhz9dC665Jw2OeY2r+SQ==
X-Received: by 2002:a05:600c:4f93:b0:41b:e416:43d3 with SMTP id 5b1f17b1804b1-41fead6a51dmr216213155e9.35.1716226025167;
        Mon, 20 May 2024 10:27:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/bF4bRoSUln2A7cqDJukXexNcMjambbxJHYjat/XzwST1JPeAlpPwPz2OHv0SZFXR65NeCA==
X-Received: by 2002:a05:600c:4f93:b0:41b:e416:43d3 with SMTP id 5b1f17b1804b1-41fead6a51dmr216212835e9.35.1716226024359;
        Mon, 20 May 2024 10:27:04 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42028c7730dsm189604005e9.25.2024.05.20.10.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:27:03 -0700 (PDT)
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
Subject: [RFC PATCH 03/11] rust: add rcu abstraction
Date: Mon, 20 May 2024 19:25:40 +0200
Message-ID: <20240520172554.182094-4-dakr@redhat.com>
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a simple abstraction to guard critical code sections with an rcu
read lock.

Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/helpers.c          | 15 ++++++++++++
 rust/kernel/sync.rs     |  1 +
 rust/kernel/sync/rcu.rs | 52 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 rust/kernel/sync/rcu.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index f9d2db1d1f33..1d3e800140fc 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -27,6 +27,7 @@
 #include <linux/err.h>
 #include <linux/errname.h>
 #include <linux/mutex.h>
+#include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
 #include <linux/spinlock.h>
@@ -158,6 +159,20 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
 }
 EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
 
+/* rcu */
+void rust_helper_rcu_read_lock(void)
+{
+	rcu_read_lock();
+}
+EXPORT_SYMBOL_GPL(rust_helper_rcu_read_lock);
+
+void rust_helper_rcu_read_unlock(void)
+{
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(rust_helper_rcu_read_unlock);
+/* end rcu */
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5..1806767359fe 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,6 +11,7 @@
 mod condvar;
 pub mod lock;
 mod locked_by;
+pub mod rcu;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
new file mode 100644
index 000000000000..1a1c8ea49359
--- /dev/null
+++ b/rust/kernel/sync/rcu.rs
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! RCU support.
+//!
+//! C header: [`include/linux/rcupdate.h`](../../../../include/linux/rcupdate.h)
+
+use crate::bindings;
+use core::marker::PhantomData;
+
+/// Evidence that the RCU read side lock is held on the current thread/CPU.
+///
+/// The type is explicitly not `Send` because this property is per-thread/CPU.
+///
+/// # Invariants
+///
+/// The RCU read side lock is actually held while instances of this guard exist.
+pub struct Guard {
+    _not_send: PhantomData<*mut ()>,
+}
+
+impl Guard {
+    /// Acquires the RCU read side lock and returns a guard.
+    pub fn new() -> Self {
+        // SAFETY: An FFI call with no additional requirements.
+        unsafe { bindings::rcu_read_lock() };
+        // INVARIANT: The RCU read side lock was just acquired above.
+        Self {
+            _not_send: PhantomData,
+        }
+    }
+
+    /// Explicitly releases the RCU read side lock.
+    pub fn unlock(self) {}
+}
+
+impl Default for Guard {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl Drop for Guard {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, the rcu read side is locked, so it is ok to unlock it.
+        unsafe { bindings::rcu_read_unlock() };
+    }
+}
+
+/// Acquires the RCU read side lock.
+pub fn read_lock() -> Guard {
+    Guard::new()
+}
-- 
2.45.1


