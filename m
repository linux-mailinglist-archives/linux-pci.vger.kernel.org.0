Return-Path: <linux-pci+bounces-25755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9EEA8730A
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8941F18936A5
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8601F4626;
	Sun, 13 Apr 2025 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh1MglMN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4D21F3BBA;
	Sun, 13 Apr 2025 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744565907; cv=none; b=f8pvyqPBuUPi1/fm76l1/3pZneIxBVUlpeEGni6OWy5DlYwkn5n+vlk53CmP52CiowDPXl1Ih6yyWUbArhxk2+q4x/nvnlNS0MYP8mYLbF8PGUaEabuubUl66iYqxzMruQEjp0g+OZLDiANusni5wYwsZBpSp/E75K9Cddt9Y/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744565907; c=relaxed/simple;
	bh=ZfSAqbjxYp7micRXjG3/lmmGYU5+RMEI2eUyLbtRx9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsrPAo/JDtfglgIx//GOdFsWJh4+gw26KBeewpVlvGA0kDXmA3i3I/ge0cooc5bLMAns6xLpDuel53PNgY955UuCvX7/owQCSqgJY8OJOA+oORd9/80U5zrw0DVN4j9DU+sxaY8DDA+ulLHQN4FOvFeRcsxBhS12N1R6VfTloCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh1MglMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9473C4CEDD;
	Sun, 13 Apr 2025 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744565906;
	bh=ZfSAqbjxYp7micRXjG3/lmmGYU5+RMEI2eUyLbtRx9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nh1MglMNjJW0q03MiD2PsiIL4/2M+aFP/y2YWN2sMmYXzHwYbO1zDw5MEkodleBu0
	 +4NNJERg3uthu2dNclq/JpaIbivx9tBmIiCXkInlgyHeuIuiAP+XnElP9q1+7DeMX/
	 4ZGibik5HzCIF7w7UOeJkPMZNEaesOzlYjLUyO1X7p8bz3LedYoVQWs6eTou2yEQZ7
	 5VNdezyW7RYsKkz0CdJqh078gWFU9ZfVnWWSJ+GEwj3n+vMTvhKT+Js/WSt6zT123v
	 20Asbsb8k3Gpr9KR+YujgeBpE7Pc5Bzg/kMI2U09i2M2MhkcEMQ5i2UY1SytaDRw+Y
	 v1DtYJVP1ymHw==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	abdiel.janulgue@gmail.com
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	robin.murphy@arm.com,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 5/9] rust: pci: preserve device context in AsRef
Date: Sun, 13 Apr 2025 19:37:00 +0200
Message-ID: <20250413173758.12068-6-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413173758.12068-1-dakr@kernel.org>
References: <20250413173758.12068-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since device::Device has a generic over its context, preserve this
device context in AsRef.

For instance, when calling pci::Device<Core> the new AsRef implementation
returns device::Device<Core>.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 7c6ec05383e0..1234b0c4a403 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -360,11 +360,13 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl Device {
+impl<Ctx: device::DeviceContext> Device<Ctx> {
     fn as_raw(&self) -> *mut bindings::pci_dev {
         self.0.get()
     }
+}
 
+impl Device {
     /// Returns the PCI vendor ID.
     pub fn vendor_id(&self) -> u16 {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
@@ -440,8 +442,8 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
-impl AsRef<device::Device> for Device {
-    fn as_ref(&self) -> &device::Device {
+impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
+    fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
         // `struct pci_dev`.
         let dev = unsafe { addr_of_mut!((*self.as_raw()).dev) };
-- 
2.49.0


