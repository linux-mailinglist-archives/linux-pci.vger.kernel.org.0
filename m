Return-Path: <linux-pci+bounces-18064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0199A9EBE26
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 23:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72869284607
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84196225A43;
	Tue, 10 Dec 2024 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtkD9aXC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F936211277;
	Tue, 10 Dec 2024 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871025; cv=none; b=bz/DUb+UAFq7Y1iMJcQuvv0PWSFaZaNbmVVbWLfiMk4daD57+6DsB0kHvpttQbFJs/O2fGiAbjxOVNovwi4IhT0VXbcj3fIUcndQ107atvGKL2sKtKEw5ADdpClamufkXY619WolP9nL48gpN3Iq+vtg0zWj3Wlu9PGicBaTFaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871025; c=relaxed/simple;
	bh=e8fdtrnJQD4e+C55I6bdwSGwqVTXC5F9OkgGcKeaTSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QczoYa0AaxRI+TacMd1zHW0SqP4hjfFzqPfghjKeklfiW1fKVc2aJXAQkAAVlzeWkjV2fzcg4lSMiDJfQhPHh6k1eHTdsdFNxMWxq8o9jnDkkwguDj+vKSzQnDWvIcFAxchDDrl2ryvJS3Ja8SAJHO73DoWV2+5n5g+f0QAeO5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtkD9aXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCC6C4CEDF;
	Tue, 10 Dec 2024 22:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733871024;
	bh=e8fdtrnJQD4e+C55I6bdwSGwqVTXC5F9OkgGcKeaTSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtkD9aXCa5pE8XnawaWoQt5/oJxrAbmwanrlOpmLdP8aa7THMZwwCBioMNcpnkSUN
	 soXFil2j3pPN+PCRbc1nvo8LcRSxn3Uwjk/GXgmYLPj5CSIE2G4rkcsF9Qdfa0/Zlb
	 L8D1g89GQpzRCPJ0xjThS3Rbg0K6MC4LIyd4JtD/gllS3/Gg7ifKXVeRB+AZrrxGFT
	 4vuzVvHTglIr99ahVLdE6nTpn+4/s/ZVvVPC6Z7NN53y/85rAheYaTk2T/+AEdzmHA
	 ufh7Uu4JoafJao7eCojqrtcULfe0PnWK5gpwZ7+MgjR+6FR2ptrWYG9NGUyR2FFvaG
	 Yf888l4c2QxUQ==
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
	chrisi.schrefl@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v5 04/16] rust: add rcu abstraction
Date: Tue, 10 Dec 2024 23:46:31 +0100
Message-ID: <20241210224947.23804-5-dakr@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210224947.23804-1-dakr@kernel.org>
References: <20241210224947.23804-1-dakr@kernel.org>
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
Co-developed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/helpers.c  |  1 +
 rust/helpers/rcu.c      | 13 ++++++++++++
 rust/kernel/sync.rs     |  1 +
 rust/kernel/sync/rcu.rs | 47 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)
 create mode 100644 rust/helpers/rcu.c
 create mode 100644 rust/kernel/sync/rcu.rs

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
index 000000000000..3beef70d5f34
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
2.47.0


