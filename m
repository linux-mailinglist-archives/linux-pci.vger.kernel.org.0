Return-Path: <linux-pci+bounces-18306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD75E9EF325
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9591777B0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8422288F8;
	Thu, 12 Dec 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ4mPH4R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7892288E1;
	Thu, 12 Dec 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021322; cv=none; b=Rcgy3tErxbdWAoisaBbFkq1Hp32g6Qj/tShsmM5qnoN4JySviikOWHT39SAeUM64Pu0EHyNWGRltCxyutgtfiUmMCbERtU5KeMWucFABCOYYi4IhmbE/xKQ6c+VM1Anilh4YMcjxU6DrJO1EzWuh2Y4K6EWVekAfF5K93cQ1GDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021322; c=relaxed/simple;
	bh=9BhoWAne0kaH0lvHyD+MIVTUaFrxO30cm6JviLjKikI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nY7Co86PUSKV/e7FmTCvXU38FHe2NQNwMcH8MHP+JCtAUFaV4WfEh+zDOT1BULV8HH5eU2h2ZI10Wvf+RIpXZa+nkujnqtnVFuEiyyDMPejjHrx5H8O+dGH0BHAaj9zw2yP5iSqt93/edNVUkzUrLWHNqFN8BFPSoAlgdVwjY34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZ4mPH4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD47C4CED4;
	Thu, 12 Dec 2024 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734021322;
	bh=9BhoWAne0kaH0lvHyD+MIVTUaFrxO30cm6JviLjKikI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZ4mPH4R9ZiJmx7Iz6zHHaRLfAQRHnTZkQgAGAPYMTVddWhVtpWqG0ijEf7rLEeRB
	 eHJ2mdbF9JHU4I4IjB7JHL61vN6erv4rP6nVKgeJ31TWTVW2NlEnMitrmdmffuBI+m
	 VTkM8z8lw4L3UtBz8e8bxbawxtxF7rbCywklgXJAQe/iNglcka8jD0+e88v0IXvXl0
	 emgWGZhApQPs2qwxzRsIQ447nZ4mAwT6UxyVWWMEiCoODAUp48Z/X16uuEKPyoALT9
	 PgF5uZvYZjS1oFSYanyJ0wPqF7iRTkig1+BUHeHsxVQw4TN2hduz0ndoEg2rXtBVyS
	 uvJUDiKkV8tEw==
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
	saravanak@google.com,
	dirk.behme@de.bosch.com,
	j@jannau.net,
	fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com,
	paulmck@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	rcu@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v6 04/16] rust: add rcu abstraction
Date: Thu, 12 Dec 2024 17:33:35 +0100
Message-ID: <20241212163357.35934-5-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212163357.35934-1-dakr@kernel.org>
References: <20241212163357.35934-1-dakr@kernel.org>
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

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS             |  1 +
 rust/helpers/helpers.c  |  1 +
 rust/helpers/rcu.c      | 13 ++++++++++++
 rust/kernel/sync.rs     |  1 +
 rust/kernel/sync/rcu.rs | 47 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+)
 create mode 100644 rust/helpers/rcu.c
 create mode 100644 rust/kernel/sync/rcu.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c12722bbe9a..f0259b6d958c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19688,6 +19688,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
 F:	Documentation/RCU/
 F:	include/linux/rcu*
 F:	kernel/rcu/
+F:	rust/kernel/sync/rcu.rs
 X:	Documentation/RCU/torture.rst
 X:	include/linux/srcu*.h
 X:	kernel/rcu/srcu*.c
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index dcf827a61b52..060750af6524 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -20,6 +20,7 @@
 #include "page.c"
 #include "pid_namespace.c"
 #include "rbtree.c"
+#include "rcu.c"
 #include "refcount.c"
 #include "security.c"
 #include "signal.c"
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
index 1eab7ebf25fd..0654008198b2 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -12,6 +12,7 @@
 pub mod lock;
 mod locked_by;
 pub mod poll;
+pub mod rcu;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
new file mode 100644
index 000000000000..b51d9150ffe2
--- /dev/null
+++ b/rust/kernel/sync/rcu.rs
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! RCU support.
+//!
+//! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
+
+use crate::{bindings, types::NotThreadSafe};
+
+/// Evidence that the RCU read side lock is held on the current thread/CPU.
+///
+/// The type is explicitly not `Send` because this property is per-thread/CPU.
+///
+/// # Invariants
+///
+/// The RCU read side lock is actually held while instances of this guard exist.
+pub struct Guard(NotThreadSafe);
+
+impl Guard {
+    /// Acquires the RCU read side lock and returns a guard.
+    pub fn new() -> Self {
+        // SAFETY: An FFI call with no additional requirements.
+        unsafe { bindings::rcu_read_lock() };
+        // INVARIANT: The RCU read side lock was just acquired above.
+        Self(NotThreadSafe)
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
+        // SAFETY: By the type invariants, the RCU read side is locked, so it is ok to unlock it.
+        unsafe { bindings::rcu_read_unlock() };
+    }
+}
+
+/// Acquires the RCU read side lock.
+pub fn read_lock() -> Guard {
+    Guard::new()
+}
-- 
2.47.1


