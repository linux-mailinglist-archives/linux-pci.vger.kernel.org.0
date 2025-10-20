Return-Path: <linux-pci+bounces-38819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2401DBF3EEF
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11D018C5AAC
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 22:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415DD2F617D;
	Mon, 20 Oct 2025 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exq2ePS/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D6E2F361E;
	Mon, 20 Oct 2025 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999763; cv=none; b=ogv1tjkZi/vruh0G0lhUu99nPa4hAIqo5sf+IEWu64885hSL2dvv9sOLdaHSiSl3UvPIdltC+InhYlbu+0hV5cy/4BMbsst1dR/mpHShk0Otw3iPtcnehkP0Fy6AaKcloT4SP4uClPqQ4miSqXPIy4/4LbCi05+3PDFIaOtlxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999763; c=relaxed/simple;
	bh=sO3O0omt7VKS/7RVAA++jwgQ7zwKtYLTJkPtXBm8Lbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxMxTOxfTe8m5dkGWx76+juub2Qkl6Oh2ULzgN0R8ZA3fQgGQglC5+yyooXYM/2t8+frnuBNeFeEZ0DR57lXaahtBsG/d5dsBftfRFS2YJYlOOAXEgRXH4C/hEdGT5hpCwVAfqqFaPGLR6B042nf2zCbaj0CL5vax3rnBHHHZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exq2ePS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F642C116C6;
	Mon, 20 Oct 2025 22:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999761;
	bh=sO3O0omt7VKS/7RVAA++jwgQ7zwKtYLTJkPtXBm8Lbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=exq2ePS/jWSVyd7oknEY4BI0hbbn37Chp2L+H97DLqoTCODI3ntzjAzEm/Rzna506
	 xlsUlWQbvwc5QrWqiK49rAHUhCw40MhOCN1sskk6IfpKttLwFnkv0f1yJgZCGdkYuu
	 INIFSsFUUi2BA22AubbIn+MesEGto2qQyem/l7UPCeQNOdIoH+PJ+vK8dQXY0uVb6j
	 MBuOQN2VW47uhO0rOtKk7FWjR8Wz/FNb+nFp32rHgtDU125nOMeffz/6XfeNT/s46k
	 kvcSvNXAgdcFKEf9nyqbBn6h+7xPVvfOPqR5Da2a0+a4356y1lZjReo4lhaj2ar7Jd
	 YiP7K/hn1MHdw==
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
Subject: [PATCH 6/8] rust: auxiliary: implement parent() for Device<Bound>
Date: Tue, 21 Oct 2025 00:34:28 +0200
Message-ID: <20251020223516.241050-7-dakr@kernel.org>
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

Take advantage of the fact that if the auxiliary device is bound the
parent is guaranteed to be bound as well and implement a separate
parent() method for auxiliary::Device<Bound>.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 497601f7473b..cc67fa5ddde3 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -217,6 +217,16 @@ pub fn id(&self) -> u32 {
     }
 }
 
+impl Device<device::Bound> {
+    /// Returns a bound reference to the parent [`device::Device`].
+    pub fn parent(&self) -> &device::Device<device::Bound> {
+        let parent = (**self).parent();
+
+        // SAFETY: A bound auxiliary device always has a bound parent device.
+        unsafe { parent.as_bound() }
+    }
+}
+
 impl Device {
     /// Returns a reference to the parent [`device::Device`].
     pub fn parent(&self) -> &device::Device {
-- 
2.51.0


