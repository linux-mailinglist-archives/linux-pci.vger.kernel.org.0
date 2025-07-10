Return-Path: <linux-pci+bounces-31888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4838BB00C46
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 21:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEC01CA56A0
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 19:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098D62FD592;
	Thu, 10 Jul 2025 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU9eVGAb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF25F2FD881;
	Thu, 10 Jul 2025 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176785; cv=none; b=bWGztwICh+ko6kU7MSkSL++qOzNrDatSpMXg72gSCLsFiJ5EHBNYP2bUAQBJwgR+nog3kp3HlYhYcjRGq2kpyZ37zLXX3tltglRaTDuzp5/bOoFR7KMOb6LoloJGNv4BVdMXBke6NQF/xm1RKHRmzCYU25YFAsg/1Pz3hM7gmpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176785; c=relaxed/simple;
	bh=vhhxnpJlh4ltrVdKPZ0PalFNXVHgE4twQwRORIbzjCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JA+JR8HB+mmvYofNZllnY+3YvdQx3cUgu9/+EnQlsH6AwEy+m4ka+rBO5tMZF31DZ90sVnbIFgRTHucatfjzpRrIG5CgiPAARQUdtf8X+bjyISRAusGRmNVVB3EZ7TmYjaTXDN7TrrLYCIPrgFD/CJmyTw5ykuc6F14LMP2HA+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU9eVGAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535FAC4CEF1;
	Thu, 10 Jul 2025 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752176785;
	bh=vhhxnpJlh4ltrVdKPZ0PalFNXVHgE4twQwRORIbzjCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XU9eVGAbThRlUKPswr2WH1X3+yyOQrIXbX4LXRxkLhMueFCuLr4OqwVzS5agcJTkP
	 RzG0pzNtt64HL+r37nJzLHaDbYrNz6D962QbwETA4XOCXVkOhVI+p8ICSspzJLV8pi
	 Y6eMxKzqGR94EZNgNgMo2SnkBB5Z4scTQ3po8fYXZFVWEIRy5NFu/kHK3oOPP8GW7J
	 FP23tl6ifN9ryp1pR06hGbqALUp2E27bObgfa3BzA1dvt3Lq4SU7Tmz1/mipIn/GKD
	 VUrH2ylgqPUc0G84rs45wzOcsyCPcFxyliRZFPiLPwcmkHoU6CdjNU1topjgaycOOk
	 4cWjag5WD0nxw==
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
Subject: [PATCH 4/5] rust: platform: implement the `dma::Device` trait
Date: Thu, 10 Jul 2025 21:45:46 +0200
Message-ID: <20250710194556.62605-5-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710194556.62605-1-dakr@kernel.org>
References: <20250710194556.62605-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The platform bus is potentially capable of performing DMA, hence implement
the `dma:Device` trait for `platform::Device`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 5b21fa517e55..7236af6482be 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -195,6 +195,8 @@ fn as_raw(&self) -> *mut bindings::platform_device {
 kernel::impl_device_context_deref!(unsafe { Device });
 kernel::impl_device_context_into_aref!(Device);
 
+impl crate::dma::Device for Device<device::Core> {}
+
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::types::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
-- 
2.50.0


