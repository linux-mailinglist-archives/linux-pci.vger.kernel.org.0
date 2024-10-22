Return-Path: <linux-pci+bounces-15053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5429AB88B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5431F23E98
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF611CDFA9;
	Tue, 22 Oct 2024 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqr1DSmU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CC1CC144;
	Tue, 22 Oct 2024 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632785; cv=none; b=RcX7CQ1T9cU/GE3H3Y47U65QPoWWdaONn12muBQkGerZjGo+Dez9U9xkPPyLgFj9As0U2LCdf8YOyX8AZS0vs4DY0Cm0lC7fWoBK5qgccyXzqM/C5Teuov1zoPy7uoV964NrULkfOMX3V/sWipZrEiaYQd9fVkZT6P28xkpVb7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632785; c=relaxed/simple;
	bh=Noe35AjzbyfXRcjkYKVDR0W06ecTf78zYPGz7+D0E1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pwyt88Ps80x5XlQFfO5IyJ/kA/wGyDnINX8xInHYQ0ATm2hWhLjXhWomZeCAyC0Nm/jLJnQ2smW3qPbnY+Yth3uncbmVKjTUfR0LkuvMXLffsM8/u0+zcqoxmtD/izAMb4R/w/kcgExw2I+tTdHhAPME+gXaeq48HYlK46njJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqr1DSmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28B0C4CEC3;
	Tue, 22 Oct 2024 21:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729632785;
	bh=Noe35AjzbyfXRcjkYKVDR0W06ecTf78zYPGz7+D0E1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqr1DSmUdTNhts/5YZyeQ9TYBo7V4UHbDjOAzKDQbubGiTEesY0Q5qsnyMQt/aq17
	 Ne0CR/z/I66/PClKt7DFvDr8bb2xsMI0zyktDzPtolMYo3yGsL4WjGnbhbyIYqMUR8
	 rOkvM4E+7AHHDZx0JSUSg6ppAn2gu74mJG8XU5ncWGME9ij0PrgCmjCYn+tlaanCnV
	 IRnnvFSw/YIjLvHWepkQHUqoIes9wlQPiFGcsKETDqFjuabLWlY/LFI1G5mZqU0uzR
	 YDNpoT4k1U/FYxPY3n9jkPqgPy52QHwK6IlgroUueefdP/v7he0mzBK+3XWo8rKyYE
	 QSC2KRxF7UWHA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	tmgross@umich.edu,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com,
	saravanak@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 06/16] rust: add rcu abstraction
Date: Tue, 22 Oct 2024 23:31:43 +0200
Message-ID: <20241022213221.2383-7-dakr@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022213221.2383-1-dakr@kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
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

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/helpers.c  |  1 +
 rust/helpers/rcu.c      | 13 +++++++++++
 rust/kernel/sync.rs     |  1 +
 rust/kernel/sync/rcu.rs | 52 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+)
 create mode 100644 rust/helpers/rcu.c
 create mode 100644 rust/kernel/sync/rcu.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 20a0c69d5cc7..0720debccdd4 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -16,6 +16,7 @@
 #include "mutex.c"
 #include "page.c"
 #include "rbtree.c"
+#include "rcu.c"
 #include "refcount.c"
 #include "signal.c"
 #include "slab.c"
diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
new file mode 100644
index 000000000000..f1cec6583513
--- /dev/null
+++ b/rust/helpers/rcu.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/rcupdate.h>
+
+void rust_helper_rcu_read_lock(void)
+{
+	rcu_read_lock();
+}
+
+void rust_helper_rcu_read_unlock(void)
+{
+	rcu_read_unlock();
+}
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
index 000000000000..5a35495f69a4
--- /dev/null
+++ b/rust/kernel/sync/rcu.rs
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! RCU support.
+//!
+//! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
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
2.46.2


