Return-Path: <linux-pci+bounces-32277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78088B07908
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0770566989
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4032877D9;
	Wed, 16 Jul 2025 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSteo/O1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308692868B7;
	Wed, 16 Jul 2025 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678261; cv=none; b=GWIPVVhzVXSBlS0KsfFbW655f6QgII0+2LDUsJMhu3MpN966J1nrl5Vc84mLC503MUpDHBvg2pUymIpKg2UjHU6w/ukA5HWONEacgSC0ya81964fDhC/EUIeobvoHTbCsVoFMD4Y/4MlxWzbDn53RtWUQyZcf4QcePNvF3T0bUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678261; c=relaxed/simple;
	bh=EPM3YwSGkqmrGTqOYa2sCJDfuwCH5DaD+f+cAtNk8vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzir8w1k8Nl5bTLkwyIRJDd2rQdc8co/KJFVWyxege1gwi1YHNy0/w5wyemRJDuIa2kJi7eAIVipx1xRUbOLuPmVVKjPRnet871q2SJQufTJAYm8AeULeKLJw1RDKVpyWfYUR1kUcIVQwzQ3KiH+eph9f7nLpbcomEP32owz3NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSteo/O1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06F2C4CEF4;
	Wed, 16 Jul 2025 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752678260;
	bh=EPM3YwSGkqmrGTqOYa2sCJDfuwCH5DaD+f+cAtNk8vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sSteo/O152ltFqRm/AV9hYstGVBylP0pTjAHQwnVveN5GNziNtagrjkVCcdHFmB6A
	 669ByI3FJrKGafXAi0Rg3Qr7DkLpxM95b2BafBUdf7LF5k5agIdTuHXvpdGFII9jWt
	 D+OyjwGRRVuYA+T1r9378t+R2SFu6uMdX0/s/Kmwn89k2vn9qzReXxr5H00GnmmTnk
	 3R5FZ5OfeIiszDHHPZGRPbszPWhgvyWUijDyMkUMzlpl2rhy+wtsQ1EJ2vn4BwVU+I
	 LAmfQZTgyjTfi4oZ5YYR9QrndtNGAU02dRhmXnKXCq4UfE7cwx/unG3LqtP684XetO
	 XGJOB3TOcvcFA==
From: Danilo Krummrich <dakr@kernel.org>
To: abdiel.janulgue@gmail.com,
	daniel.almeida@collabora.com,
	robin.murphy@arm.com,
	a.hindborg@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 3/5] rust: pci: implement the `dma::Device` trait
Date: Wed, 16 Jul 2025 17:02:48 +0200
Message-ID: <20250716150354.51081-4-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716150354.51081-1-dakr@kernel.org>
References: <20250716150354.51081-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI bus is potentially capable of performing DMA, hence implement
the `dma:Device` trait for `pci::Device`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8435f8132e38..c0aef0e1faac 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -434,6 +434,8 @@ pub fn set_master(&self) {
 kernel::impl_device_context_deref!(unsafe { Device });
 kernel::impl_device_context_into_aref!(Device);
 
+impl crate::dma::Device for Device<device::Core> {}
+
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::types::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
-- 
2.50.0


