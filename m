Return-Path: <linux-pci+bounces-38816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 580DBBF3ECD
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 277134E96DC
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 22:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E582F3C03;
	Mon, 20 Oct 2025 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B39RaM8Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC572F2909;
	Mon, 20 Oct 2025 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999750; cv=none; b=h4HNHY2VQvQ+pzcTpFYFtyyJqWS0sljKsS9rCanLn+ZywQnp91OxrKJe1Mh9KuOjY3JI8TYaXIUjEK2kK9VObGaFjhNCAtSFGXAYkRrQG/ATh74AjywmJ0woIdQVCPKdF7Gxwr7ZTamYObOnuFAWSsycpHReaph6Q9NHqsWRrn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999750; c=relaxed/simple;
	bh=ztSeCB3sZ4feAtMAomRbrXlR9m47mCxeryRJO8qptqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFkr3z/2kh1hs0Mr82PgxJ4qqNqelN40r5BoHgf4Ky9hIHb+fzflU76hza7FM5l9dTmWgBw4rGCcbVG/o6K/0ypziC6wWJ394l57BtJktwDvfF/EUbmkc1oz7IW9ygvnkQsbMngpwJf2/Su6rVhht9vS2c7VWkIv4Psm4jW2Y+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B39RaM8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68880C4CEFB;
	Mon, 20 Oct 2025 22:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999747;
	bh=ztSeCB3sZ4feAtMAomRbrXlR9m47mCxeryRJO8qptqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B39RaM8Qlzp/vhiEeWOt5zr+rVxT6Ag2y8at6PjMyzB5uoJ5uFnbVdMbhPIPRiNj5
	 WlQRYlqjMKU/oxy3Io9K0Teq/N5iLwn28e0J4agiR7nNRZ5Q4uY6cU1WI7lMuEFKC5
	 rv8PYReDDwo/iXE0S+sZCDk53nhJsOYBCjb6sDvLlpzz1mdTHSOkzuVQvSuml994ig
	 P350dsrWePcP7/iwwnIvLxDja6XQc+exk4y5ptBDrXbTd8CK51FTCzXwCqvyt0jns2
	 KmB82/DDcqNjTaHCdKQhB95TrvFQeOxX3bSvAZA55shB/VKMTAXQocZlDHeYHXVI+D
	 Tq5NNBt99b4qQ==
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
Subject: [PATCH 3/8] rust: auxiliary: consider auxiliary devices always have a parent
Date: Tue, 21 Oct 2025 00:34:25 +0200
Message-ID: <20251020223516.241050-4-dakr@kernel.org>
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

An auxiliary device is guaranteed to always have a parent device (both
in C and Rust), hence don't return an Option<&auxiliary::Device> in
auxiliary::Device::parent().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/file.rs          | 2 +-
 rust/kernel/auxiliary.rs              | 7 ++++---
 samples/rust/rust_driver_auxiliary.rs | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 90b9d2d0ec4a..a3b7bd36792c 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -28,7 +28,7 @@ pub(crate) fn get_param(
         _file: &drm::File<File>,
     ) -> Result<u32> {
         let adev = &dev.adev;
-        let parent = adev.parent().ok_or(ENOENT)?;
+        let parent = adev.parent();
         let pdev: &pci::Device = parent.try_into()?;
 
         let value = match getparam.param as u32 {
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index a6a2b23befce..e5bddb738d58 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -215,9 +215,10 @@ pub fn id(&self) -> u32 {
         unsafe { (*self.as_raw()).id }
     }
 
-    /// Returns a reference to the parent [`device::Device`], if any.
-    pub fn parent(&self) -> Option<&device::Device> {
-        self.as_ref().parent()
+    /// Returns a reference to the parent [`device::Device`].
+    pub fn parent(&self) -> &device::Device {
+        // SAFETY: A `struct auxiliary_device` always has a parent.
+        unsafe { self.as_ref().parent().unwrap_unchecked() }
     }
 }
 
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 0e221abe4936..2e9afeb83d4f 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -68,7 +68,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
 
 impl ParentDriver {
     fn connect(adev: &auxiliary::Device) -> Result<()> {
-        let parent = adev.parent().ok_or(EINVAL)?;
+        let parent = adev.parent();
         let pdev: &pci::Device = parent.try_into()?;
 
         let vendor = pdev.vendor_id();
-- 
2.51.0


