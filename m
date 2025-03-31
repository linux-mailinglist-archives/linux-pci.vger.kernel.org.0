Return-Path: <linux-pci+bounces-25022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6C1A76F4A
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 22:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4B83AAE6D
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 20:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF10621B905;
	Mon, 31 Mar 2025 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4zSVxqs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16DC21B199;
	Mon, 31 Mar 2025 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452951; cv=none; b=Rt9srwQUClEidyHITRCwz4lx3mBM+pr6pRXVMFAOBOqvdXsveS7gZu5SBarTsqPPDwwqJM/yzMFSn9J4hG6VvdH0U/re9qwVLvIySNh8IlnKHnDptZJVOsFl5e5pZ+KpNNI5E4yurXiwpDYoPFFkcbKNgOQQFnHKpfNFXZvm9+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452951; c=relaxed/simple;
	bh=YxHRs5a6HHHdMxiYXlHaorHuDEWaBr0Vhep1wlSBUhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVskWtbgyf9JlbmWjODaasijU7uMJQBpXbYGD0O0ULALcvrLFnCNN6tbCV9AtLYhC3wtZF4fuRlFHMo68LdTqm/yMIKXkCfHBTIWly+OqUIMbBhGR/6ULm2YyNsDHAJWAx9aL9hVL37A57hNe/M7wjNV73hkOiDhZyhaAgAuGpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4zSVxqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7204FC4CEE3;
	Mon, 31 Mar 2025 20:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743452950;
	bh=YxHRs5a6HHHdMxiYXlHaorHuDEWaBr0Vhep1wlSBUhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T4zSVxqsVW9dEyoK7om3DWhnKEDZFbLfanpUkkPKKbbzRg18ur3S07RpgPqSCOeTT
	 BbamUZzpWcYj94Zw+h+oiNpNg4uG2/iq7ROS3LZRgYsx8WEyzSIbLZFi4AYVC7LloL
	 QFgSvI/oJRGSglsxkgcxHBI0QWi8KNQ2KYaH+BtQolmwFWI5iZ6Q+kw3kvcCcfEKw0
	 XJKA2PUqVv1ZxVStVclslMZlEjM0nc6QxHJViZ39IAZnPrzGptSayImcmddky2Js2b
	 s7STfAH4LRrgLwnF1VVd+98NTbYOXimpD/TwPhFQLfxGOBppYOuYi2SaQoLzZDAaTM
	 4CSYexckOuaeQ==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
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
Subject: [PATCH 5/9] rust: pci: preserve device context in AsRef
Date: Mon, 31 Mar 2025 22:27:58 +0200
Message-ID: <20250331202805.338468-6-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331202805.338468-1-dakr@kernel.org>
References: <20250331202805.338468-1-dakr@kernel.org>
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
index e235aa23c63a..de140cce13cf 100644
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
@@ -438,8 +440,8 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
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


