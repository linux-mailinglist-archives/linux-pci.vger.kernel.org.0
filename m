Return-Path: <linux-pci+bounces-24063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B146A67E9D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 22:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE9219C36C3
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 21:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5903202C40;
	Tue, 18 Mar 2025 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvN9y32h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53C41E1DE6;
	Tue, 18 Mar 2025 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333388; cv=none; b=us8An0Cfk9kmtlcXmN9Txep3oyOVXkigw1RJ1VAteZI5XAKH7D1km9Hg1SlMGIxMRbsm94nC4kWB4ODO8UUfHzOesMu7tVn2ljkCbUukTCrfhtHzZzvo7meEmpQ2XgNvmDub37SqHnilWDPZVk7XXX5Ai1zV1zC79aGsIdWTYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333388; c=relaxed/simple;
	bh=R16CywZRjvAboLmxAjjnPLISPIrgvVdrl/sH5S8m/3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X95nGnxDoHqlu0ySqPOXG60EP129BnRY9lXL7QRu7BsKN69J96veLAva43+LXR/Yi5/aeFylEhFdUf+XhX1nrTAE+wvHd+vLgkIN8JaEXTI1pfHAsuQEgrfmmbExRb2Tsr4+zjUzAP7cr1VbTIxLjjO6dEhVucbO0I/d0Sy3R3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvN9y32h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB6DC4CEDD;
	Tue, 18 Mar 2025 21:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742333388;
	bh=R16CywZRjvAboLmxAjjnPLISPIrgvVdrl/sH5S8m/3k=;
	h=From:To:Cc:Subject:Date:From;
	b=SvN9y32hBoG0jdPjlh9rzEmMT8Wb2kFvyaT8nXgf/lXMqRo4YTmEhytIp+tYMxpf6
	 fH98FMa4UzQAUflFf1s2Q3IP6bzSe1XyCmDaC9i9hxBcoGXmmioFBlX+PPdE7N7tJ1
	 /p/qVGifTboDSeAjNp+0Zyqv2PLqr3q/mbscLfsUOl/Nq792n7QfM9mF3PkGT0ZmYk
	 uJNX1EK+sxoikDSq1qBFGzDc92ALXsUPlpY6ABYlbAe8V4wnJjtKzQoMNQCtyxMHjN
	 cP5jilMOD14Y1rh9Uqn0qYYsuByRf74/Gb3r50ZCd+p5qTx17RVZY2GRn3uRX00Iel
	 3jvK+im0u7jMw==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/2] rust: pci: impl Send + Sync for pci::Device
Date: Tue, 18 Mar 2025 22:29:21 +0100
Message-ID: <20250318212940.137577-1-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
changed the definition of pci::Device and discarded the implicitly
derived Send and Sync traits.

This isn't required by upstream code yet, and hence did not cause any
issues. However, it is relied on by upcoming drivers, hence add it back
in.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 0ac6cef74f81..0d09ae34a64d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -465,3 +465,10 @@ fn as_ref(&self) -> &device::Device {
         unsafe { device::Device::as_ref(dev) }
     }
 }
+
+// SAFETY: A `Device` is always reference-counted and can be released from any thread.
+unsafe impl Send for Device {}
+
+// SAFETY: `Device` can be shared among threads because all methods of `Device`
+// (i.e. `Device<Normal>) are thread safe.
+unsafe impl Sync for Device {}

base-commit: 4d320e30ee04c25c660eca2bb33e846ebb71a79a
-- 
2.48.1


