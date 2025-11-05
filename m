Return-Path: <linux-pci+bounces-40344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFAEC358DD
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 13:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF8A1A23AA0
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 12:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E162330EF94;
	Wed,  5 Nov 2025 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC++mp3V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3987191493;
	Wed,  5 Nov 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344240; cv=none; b=G3h5hrfBs/Ea59b8C8On81PR/jy9MKkcngIQXcw8asJjzuGnRdMC3Ufurkt3YMoo/jnRkOfl0rF1SDELR1CNwFGoN+xWXwIUKJKowpHxG8icGvC6RGOeWJ6dXov3zM6U2mR71G124U+M+pH1kHFHGggPXAP5X0GHGnCQNNZ0IGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344240; c=relaxed/simple;
	bh=vVjkFqMn+W5n5cpfuAnp/22J3xKdZiS5J37+DLKCOJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sb8S+u28yD3pR3N/b89akfvpse3jFC1K5QMvZMMBxGWSzwmEOohNce1Lp9Jdn20ow3lpSI7gkYKObN+Xp2EgNWWKM7W2mdx5eOwTixMf2SORY5hNd5qepGF4m5pLEhC8Qj4sqTAYp/kqchAXQmWNQPD3MoLlBwDazbuCLAqp7uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pC++mp3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D42C4CEFB;
	Wed,  5 Nov 2025 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762344239;
	bh=vVjkFqMn+W5n5cpfuAnp/22J3xKdZiS5J37+DLKCOJI=;
	h=From:To:Cc:Subject:Date:From;
	b=pC++mp3VmLTRf9EkgkAJ40QiGemTjOoC34TIzbWpKep0r2siBsUpg9r7BIpEl0jrf
	 vgJKTqb0RGazjpdvqW4XEpn/lcoxvmmNNbiJTo9FQEveOP67jdKHqXRiCYq8/ISqeE
	 g0Gz72aPuC4ctZg3Dghznwap00dtAXOEIiUoBK12T7apKfvUfA0M9xntovLeA4B/BQ
	 wyL87TW7iRlFIctklU5zofj1I8y9KCA359HyUcP/8w1c6C8ZifJnicL5Ua4vdyDOta
	 6zy/ZeheHv94CBZz7+lk3F/gPLImyQZ5RPZPIhMymvrUmF2IefkGQuJnuslGh3/YJC
	 WiEuNoI1bOrEA==
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
Cc: linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] rust: pci: use "kernel vertical" style for imports
Date: Wed,  5 Nov 2025 13:03:28 +0100
Message-ID: <20251105120352.77603-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert all imports in the PCI Rust module to use "kernel vertical"
style.

With this subsequent patches neither introduce unrelated changes nor
leave an inconsistent import pattern.

While at it, drop unnecessary imports covered by prelude::*.

Link: https://docs.kernel.org/rust/coding-guidelines.html#imports
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs     | 35 +++++++++++++++++++++++++++--------
 rust/kernel/pci/id.rs  |  5 ++++-
 rust/kernel/pci/io.rs  | 13 ++++++++-----
 rust/kernel/pci/irq.rs | 14 +++++++++-----
 4 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index b68ef4e575fc..410b79d46632 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -5,27 +5,46 @@
 //! C header: [`include/linux/pci.h`](srctree/include/linux/pci.h)
 
 use crate::{
-    bindings, container_of, device,
-    device_id::{RawDeviceId, RawDeviceIdIndex},
+    bindings,
+    container_of,
+    device,
+    device_id::{
+        RawDeviceId,
+        RawDeviceIdIndex, //
+    },
     driver,
-    error::{from_result, to_result, Result},
+    error::{
+        from_result,
+        to_result, //
+    },
+    prelude::*,
     str::CStr,
     types::Opaque,
-    ThisModule,
+    ThisModule, //
 };
 use core::{
     marker::PhantomData,
-    ptr::{addr_of_mut, NonNull},
+    ptr::{
+        addr_of_mut,
+        NonNull, //
+    },
 };
-use kernel::prelude::*;
 
 mod id;
 mod io;
 mod irq;
 
-pub use self::id::{Class, ClassMask, Vendor};
+pub use self::id::{
+    Class,
+    ClassMask,
+    Vendor, //
+};
 pub use self::io::Bar;
-pub use self::irq::{IrqType, IrqTypes, IrqVector};
+pub use self::irq::{
+    IrqType,
+    IrqTypes,
+    IrqVector, //
+};
 
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index 7f2a7f57507f..a1de70b2176a 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -4,7 +4,10 @@
 //!
 //! This module contains PCI class codes, Vendor IDs, and supporting types.
 
-use crate::{bindings, error::code::EINVAL, error::Error, prelude::*};
+use crate::{
+    bindings,
+    prelude::*, //
+};
 use core::fmt;
 
 /// PCI device class codes.
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 3684276b326b..0d55c3139b6f 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -4,14 +4,17 @@
 
 use super::Device;
 use crate::{
-    bindings, device,
+    bindings,
+    device,
     devres::Devres,
-    io::{Io, IoRaw},
-    str::CStr,
-    sync::aref::ARef,
+    io::{
+        Io,
+        IoRaw, //
+    },
+    prelude::*,
+    sync::aref::ARef, //
 };
 use core::ops::Deref;
-use kernel::prelude::*;
 
 /// A PCI BAR to perform I/O-Operations on.
 ///
diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
index 782a524fe11c..063b6a5101ff 100644
--- a/rust/kernel/pci/irq.rs
+++ b/rust/kernel/pci/irq.rs
@@ -4,16 +4,20 @@
 
 use super::Device;
 use crate::{
-    bindings, device,
+    bindings,
+    device,
     device::Bound,
     devres,
-    error::{to_result, Result},
-    irq::{self, IrqRequest},
+    error::to_result,
+    irq::{
+        self,
+        IrqRequest, //
+    },
+    prelude::*,
     str::CStr,
-    sync::aref::ARef,
+    sync::aref::ARef, //
 };
 use core::ops::RangeInclusive;
-use kernel::prelude::*;
 
 /// IRQ type flags for PCI interrupt allocation.
 #[derive(Debug, Clone, Copy)]
-- 
2.51.2


