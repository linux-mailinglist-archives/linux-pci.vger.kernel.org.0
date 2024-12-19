Return-Path: <linux-pci+bounces-18793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98F79F8121
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1CE1896926
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3861A2860;
	Thu, 19 Dec 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+Mcfd1W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F581993B7;
	Thu, 19 Dec 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627902; cv=none; b=WgGTbZYhoBjl+GQFAsg9yiS0qYZXKLWTl949FaTxScFjThpZfy4sKiMXkbjtIx6To5zPDKBJOK1rD4/IiGtlKkLUzNgdZDu8yvY2iTts7pXcLbByrIviVyH4YOKyC4lCX+qPGZJkwBQCOzZ/YJwdNOdyvIux4B/7G/4jcN7Nuqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627902; c=relaxed/simple;
	bh=f3aJAybd75kUn8ckkrM70XUmP31IocvKUooiJRxciXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHbMo3xv8Nte1TcPMToBexDmoKwii1xujcTA+zdTSQsdRSBgAmbD10N25yrqW2SCp6ijEzU9J3C9+bSvFBbseA7+0orz5FrD0zgaOFHXX+6x4DUAH8On+wjPoPZrKHPG6mHqnM9leh9oVOwks6Hjg+TokCVKNl64wXGqKpVN6u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+Mcfd1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DC5C4CECE;
	Thu, 19 Dec 2024 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627902;
	bh=f3aJAybd75kUn8ckkrM70XUmP31IocvKUooiJRxciXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+Mcfd1WHMJmGUZefHh6tAnAhd0/9bxH9J+8GP5ltmsKN2eZWH6kJs0sAWG6jImG8
	 06nKniiuzJI18hRPu4QKOoG0B6IL3eACuQOFXitHF7ogEeb3fuzYN2bT43DRJ0sUGS
	 WMDzrYkY+4q8Mh+Go52jO8aP+fjhAAhCeXPYN1L+kSK6yUwUCndRFGiA9i2HrvvFv7
	 FBRxinrKKATfO/Z8gwaFUygz2UVa0RoNBUqrHoPKXMEUiGYNZBldRySwboXocqf4sh
	 TLOlj/L2zwNr/2kFd18xw6dV5zyteXrFGEWJFfxk8bGHTahKZDBl+xbSDli2TuC+OW
	 9sEMH3y8S+LJw==
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
Subject: [PATCH v7 04/16] rust: add rcu abstraction
Date: Thu, 19 Dec 2024 18:04:06 +0100
Message-ID: <20241219170425.12036-5-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219170425.12036-1-dakr@kernel.org>
References: <20241219170425.12036-1-dakr@kernel.org>
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
index 3cfb68650347..0cc69e282889 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19690,6 +19690,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
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


