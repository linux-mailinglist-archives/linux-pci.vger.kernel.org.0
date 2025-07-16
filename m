Return-Path: <linux-pci+bounces-32278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4405B07928
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29371C43789
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF917266580;
	Wed, 16 Jul 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fik1BATe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55EF20F09C;
	Wed, 16 Jul 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678265; cv=none; b=exhWzDkA0kuEhnbmXGsYyLPLDhE1O0NgX8JeoYgeDSIz1m2AaRFL9hBjmXgLmRw77hXq9tXMGJt3PG+Wrsdh//gFvACw9GSWixo22kuM+E5F3sS0HyTDvN59NILN8wIwX/wqZsA5M+pT/YCCwEmwpx8VcJxJa5JK3GJGcJLv/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678265; c=relaxed/simple;
	bh=vhhxnpJlh4ltrVdKPZ0PalFNXVHgE4twQwRORIbzjCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfzS0tRghRV0LSBvurnpSiwrBMTtboB3wo1CmpgV/jPvx2FQf7bhhijE/TxkAN53gbOMPcRwAB6RTI2G21CtF49AeMXPLm2Re7xB6Y7CBVB4TOgbrhjSz6C2fj2i0Akn/AO5crvggy2cz3uVU3oXryYscIT3adGUJcrkHR7lPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fik1BATe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327EAC4CEE7;
	Wed, 16 Jul 2025 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752678265;
	bh=vhhxnpJlh4ltrVdKPZ0PalFNXVHgE4twQwRORIbzjCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fik1BATeBCOOH/UArM6WXi3OgiOC4APPr6olqKF3Vhqozrh1a0nStLkJEmydaQ/iK
	 8cdYHW2Er5obVJHX23FW2d14GqlSzrpQob6RVQTYe7Dx7l796x0YAOTj84HF1uHE2W
	 vRGLYQByicKQcvgzA4qIo4Hw60RDSmqzOAzLFBfVakRJzCnmas/HUvVZVUDt92wrka
	 8VU0bbbhDSEDP990+OQCvdJj47puOBiTPnIhRjYu2CvAtcWEPDV7164k8FT53VwsLL
	 rsM+LXoO9ej5vix2qeXskPj9LZGiCleWfm1vZC+IRJL+M1GGQYGG/sXUzI8OSzjLyt
	 vdlSPQZw7POfA==
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
Subject: [PATCH v2 4/5] rust: platform: implement the `dma::Device` trait
Date: Wed, 16 Jul 2025 17:02:49 +0200
Message-ID: <20250716150354.51081-5-dakr@kernel.org>
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


