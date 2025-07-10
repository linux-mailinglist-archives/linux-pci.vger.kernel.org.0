Return-Path: <linux-pci+bounces-31887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E12B00C44
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 21:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E8C5621D9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 19:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C32FE316;
	Thu, 10 Jul 2025 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNHfdAzl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF792FD87A;
	Thu, 10 Jul 2025 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176781; cv=none; b=tiIdrZ+ddkRaXJgszq65FKLMQBT8pxHIi8eO4VNjpCk6bxUP489flOn4P9G3PnceKV7NTHX6I2xdJOqL5VAEzbPZNqp3cmeK/A0qkjpQfuypshMfGw0EEfDBkr2ntL8OQIcPGJLvsMZ602V528z16RzY5sxkdmmLLDHHbhwWctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176781; c=relaxed/simple;
	bh=EPM3YwSGkqmrGTqOYa2sCJDfuwCH5DaD+f+cAtNk8vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtN2kHEAKUareDwMWbuG0EVgbC1yhZ2C1OeIEwQ+aRxh7OuRoD3SAStWhrxbY9pe1hgn9BBKLjcfUqEWn3Cuh4CxM4lS+sowmCksu7CpbYpEqyoGuCCwsRjXHwL8CXMx29xi3ZwK3u5Qgzn/Y4hXCdtvNJr5Ilk3ieDgOqbjFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNHfdAzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40CDC4CEF4;
	Thu, 10 Jul 2025 19:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752176780;
	bh=EPM3YwSGkqmrGTqOYa2sCJDfuwCH5DaD+f+cAtNk8vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gNHfdAzlC0eXssIR/vaKVWaNupOrQFDpaCROAhJQMkxq+qcmPyRRZhirNGzJnbT/m
	 vdTeYCyPbCeyjrQDF9ELge9PI/VZ4ODSVIqWDdvJVI5rqxuz60v7X/aATbAhkYD5bk
	 KfpjZcn73SZoyvJed1X6KW4+L3ngdHx8GLRKjKQaTBj0x1wOJIuLkdS3u3Y5ansYbP
	 OGK3UpTyt5mE6fNK+vnGhbBY5SAt3Ek7mcNqmM4wjZIEfIedAg3HzIpuE9wK9+O/6b
	 4U3NFhb7CWSfWHxdheeHl5j45AqJhycRj6XBmyIbBg6duQea/gy1TNxBELvG6C3k8D
	 DIpnvBiy6Bh8A==
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
Subject: [PATCH 3/5] rust: pci: implement the `dma::Device` trait
Date: Thu, 10 Jul 2025 21:45:45 +0200
Message-ID: <20250710194556.62605-4-dakr@kernel.org>
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


