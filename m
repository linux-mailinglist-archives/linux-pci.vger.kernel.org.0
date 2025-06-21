Return-Path: <linux-pci+bounces-30301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E636AE2BD9
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 21:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C9C189A4C8
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 19:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9203E270EC1;
	Sat, 21 Jun 2025 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAd2ESdF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A0A270EB2;
	Sat, 21 Jun 2025 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535492; cv=none; b=A8hCNS1j/p4vYRSkjNE8gyRT+vAQHdb3pdxopaYJ9HknZUxifnLvMdOJobadMjJ7/4liq5MtgIRfl8yDzsxH4oLlRDb4jWlNAU3GmfEJlBORaWO7VyAq10cwm8EeOBgcyAMgn4Bxx1ndBeJu94nSj2FqH0gLoMEQhesl6G2P2/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535492; c=relaxed/simple;
	bh=pjAS50S4PI0FmiSCTxI6FL6s36Lw3uJn25OAPQ7R6MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndM+R8GSOZ0d443Le52f6Nu7od/nVhe3DTTHk7Z3DLIQMPlkaBMVgc9ODcBH0EN+16dT4bFUXCsA/mdkGuujw47FEHtM5Yg1oWJb6WDvxZP4CeJba6pYQreHe5WZUbgwPc+fWVtNilhoM5EosjJdXGdLMdq7w2FdcrvUs0Bh9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAd2ESdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AF0C4CEF1;
	Sat, 21 Jun 2025 19:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750535492;
	bh=pjAS50S4PI0FmiSCTxI6FL6s36Lw3uJn25OAPQ7R6MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAd2ESdFeOHFtJQFC/QSF+YDUBhemjZHjCp9UfZcZ+OUfJr2ofRUL885/rtHSVT1e
	 v2Q3XmVM39n5uICtfLZWJQxrCJjBJuCI/o5OqI/BFyt5TtcpT33rV5TUPT9T+rBYJN
	 K56ScRu2tCqkTIs4dIJXA1hHBthcSWSOVae0OLAgxGOHsyxBp0Bvcz7Dyic5Ek891+
	 2gR/U6qAMfNF76Wt/8qGuTacGX3hVO7W0UcSkLFmd0EKaGXG7Csu6OBYMkTS09oOfO
	 Bo1aLbzPTXHszpk50Kclml26EnskhEWgZczcYbNfdZvZeSbD5wwqcTNfQaK0AimhHY
	 Wk2l3lik6od6g==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/8] rust: device: introduce device::Internal
Date: Sat, 21 Jun 2025 21:43:27 +0200
Message-ID: <20250621195118.124245-2-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621195118.124245-1-dakr@kernel.org>
References: <20250621195118.124245-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce an internal device context, which is semantically equivalent
to the Core device context, but reserved for bus abstractions.

This allows implementing methods for the Device type, which are limited
to be used within the core context of bus abstractions, i.e. restrict
the availability for drivers.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 665f5ceadecc..e9094d8322d5 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -261,6 +261,10 @@ pub trait DeviceContext: private::Sealed {}
 /// any of the bus callbacks, such as `probe()`.
 pub struct Core;
 
+/// Semantically the same as [`Core`] but reserved for internal usage of the corresponding bus
+/// abstraction.
+pub struct Internal;
+
 /// The [`Bound`] context is the context of a bus specific device reference when it is guaranteed to
 /// be bound for the duration of its lifetime.
 pub struct Bound;
@@ -270,11 +274,13 @@ pub trait Sealed {}
 
     impl Sealed for super::Bound {}
     impl Sealed for super::Core {}
+    impl Sealed for super::Internal {}
     impl Sealed for super::Normal {}
 }
 
 impl DeviceContext for Bound {}
 impl DeviceContext for Core {}
+impl DeviceContext for Internal {}
 impl DeviceContext for Normal {}
 
 /// # Safety
@@ -312,6 +318,13 @@ fn deref(&self) -> &Self::Target {
 #[macro_export]
 macro_rules! impl_device_context_deref {
     (unsafe { $device:ident }) => {
+        // SAFETY: This macro has the exact same safety requirement as
+        // `__impl_device_context_deref!`.
+        ::kernel::__impl_device_context_deref!(unsafe {
+            $device,
+            $crate::device::Internal => $crate::device::Core
+        });
+
         // SAFETY: This macro has the exact same safety requirement as
         // `__impl_device_context_deref!`.
         ::kernel::__impl_device_context_deref!(unsafe {
@@ -345,6 +358,7 @@ fn from(dev: &$device<$src>) -> Self {
 #[macro_export]
 macro_rules! impl_device_context_into_aref {
     ($device:tt) => {
+        ::kernel::__impl_device_context_into_aref!($crate::device::Internal, $device);
         ::kernel::__impl_device_context_into_aref!($crate::device::Core, $device);
         ::kernel::__impl_device_context_into_aref!($crate::device::Bound, $device);
     };
-- 
2.49.0


