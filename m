Return-Path: <linux-pci+bounces-38821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38DEBF3F00
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4663B1E00
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 22:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78C333745;
	Mon, 20 Oct 2025 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssaEuPZ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8057A33343E;
	Mon, 20 Oct 2025 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999771; cv=none; b=YdglPUwMbYO7vEtOcBwOoRk6p57REzPkQKHFqzYEwsAewt9C31avsd1xwPyvavEcNisXcUa98i6kuddXn6N4rKL7NE9EjcOYhquJjG6bWvP6wCOKF4fdFozbuYhkU1Q0YN4UOBeiWP8uyekBJm/TfZF/7a0Rr3lJlyVJDNDesaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999771; c=relaxed/simple;
	bh=QxGK4UEFzt4WjxckGXtrR7+T4t6vEtOAH7gCnrjQeow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCV6iyXZGv7PbVtu2Lr8by2qOhs3M/h0v2BRuYw9Vx5LI1o08Ca/LeUqSxya1sSrvqx9mrM2PQ6wZVAhgL13GQ//fCtN62uZautxueO7NGRgPX3R0dxc46e1nndoAfSW+2djprLX1i8Y2vF+DdyjNCI4uhVLzl6q8l8qe2QMiBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssaEuPZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37F9C116C6;
	Mon, 20 Oct 2025 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999771;
	bh=QxGK4UEFzt4WjxckGXtrR7+T4t6vEtOAH7gCnrjQeow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ssaEuPZ4oOxv9g2hn1GLCbgTX8Aqn2hwpeHezcOC9AUh2TBRpwazxGnNHdmh+YvmU
	 9OoXJOGYA4mcfBscwNrNlusxEtEObzdVVBrcihS8axS1n6Dn9H1k13vYqGywxZOW0Z
	 xEPkhY02w72g6LxbspznwJFnPKEzu2oLYTxHeLZImnPFvk6UnGWOMJjHGYqGdR9k5+
	 wdRkKMWie6cA+EIxEo7Pw/A70Hcc+GygNAdhnritquR+6gef9GcVhsom7cY4YlQxip
	 T1hM+Z0HFv/WS4I27zy2el1ibKMH55mpdlEgdnhZS/lvEeGrxvvf8AWM6Gxft0QT0g
	 z9dbO5jewKVHA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	acourbot@nvidia.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	pcolberg@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 8/8] samples: rust: auxiliary: illustrate driver interaction
Date: Tue, 21 Oct 2025 00:34:30 +0200
Message-ID: <20251020223516.241050-9-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020223516.241050-1-dakr@kernel.org>
References: <20251020223516.241050-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Illustrate how a parent driver of an auxiliary driver can take advantage
of the device context guarantees given by the auxiliary bus and
subsequently safely derive its device private data.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_auxiliary.rs | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index a5d67d4d9e83..5761ea314f44 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -5,10 +5,17 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    auxiliary, c_str, device::Core, devres::Devres, driver, error::Error, pci, prelude::*,
+    auxiliary, c_str,
+    device::{Bound, Core},
+    devres::Devres,
+    driver,
+    error::Error,
+    pci,
+    prelude::*,
     InPlaceModule,
 };
 
+use core::any::TypeId;
 use pin_init::PinInit;
 
 const MODULE_NAME: &CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
@@ -43,6 +50,7 @@ fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<S
 
 #[pin_data]
 struct ParentDriver {
+    private: TypeId,
     #[pin]
     _reg0: Devres<auxiliary::Registration>,
     #[pin]
@@ -63,6 +71,7 @@ impl pci::Driver for ParentDriver {
 
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
+            private: TypeId::of::<Self>(),
             _reg0 <- auxiliary::Registration::new(pdev.as_ref(), AUXILIARY_NAME, 0, MODULE_NAME),
             _reg1 <- auxiliary::Registration::new(pdev.as_ref(), AUXILIARY_NAME, 1, MODULE_NAME),
         })
@@ -70,9 +79,10 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
 }
 
 impl ParentDriver {
-    fn connect(adev: &auxiliary::Device) -> Result {
+    fn connect(adev: &auxiliary::Device<Bound>) -> Result {
         let dev = adev.parent();
-        let pdev: &pci::Device = dev.try_into()?;
+        let pdev: &pci::Device<Bound> = dev.try_into()?;
+        let drvdata = dev.drvdata::<Self>()?;
 
         dev_info!(
             dev,
@@ -82,6 +92,12 @@ fn connect(adev: &auxiliary::Device) -> Result {
             pdev.device_id()
         );
 
+        dev_info!(
+            dev,
+            "We have access to the private data of {:?}.\n",
+            drvdata.private
+        );
+
         Ok(())
     }
 }
-- 
2.51.0


