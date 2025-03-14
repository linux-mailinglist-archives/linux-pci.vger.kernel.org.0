Return-Path: <linux-pci+bounces-23763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65876A615EA
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 17:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33499881B30
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FEA2046AC;
	Fri, 14 Mar 2025 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbaTvZ4Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43495204851;
	Fri, 14 Mar 2025 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968586; cv=none; b=jbYC4y6BaxElv+EXFrrpPKf8pIruejxOT4yFDmZbFD56QNSZK0Ep5FLOvL+lvKhX/g6v7hYUcAyHYN9TUEJykDayygg8ycZyNPqLIw2SKLX9uKYSsnOJptAhHZDXVIPom22Zlpy3pbc/F4QhxMKuxNhwYe+oilIxfesTUgWylKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968586; c=relaxed/simple;
	bh=v/gp1b7tzV12McsPQPA3dkBbRM4YjwkiFePRBVO9owg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltjp756lY+it9XAhkJMdhOcgEG4DeF0hreUhskssAQVOWUgciGNxCmz/iouN3BOmSKqASSqnNqV+/awunCmkqUv5FHC5lva4wX+1veM9UgvCWkFBb9WfjMqKM2WN7/bLBfYqxEwXsE5bh9hqCK05r/AKPfyL/9Wj7vpFq1JQMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbaTvZ4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E81BC4CEEE;
	Fri, 14 Mar 2025 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741968585;
	bh=v/gp1b7tzV12McsPQPA3dkBbRM4YjwkiFePRBVO9owg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbaTvZ4QS4jp2fK63wiahyXOL1ooPvm+NIwNHRRGoOV0s/f/38lXbST5lXNBJ/eAN
	 +Txw3pKcVwfG1D9VPuVll6T6d1vkWpwx3oGdZ5bMWEZHGCl83f/Sbe0pfTyTnzcuRV
	 QmWhSvb9rVI6ERfHp80isrT7EOfODayZ3uiskn5saAu9GsGh1XC4uQ1qOv6zjTK8iQ
	 Q8BrviNP8bvf5CHEL1a39Tc2nE40fluvVI6yPT/8KJNRnA+yLhTPVk7348UDpS80Cj
	 7POZTdnlN1mm3MJ0yDOW16Zis6sXQj423zFAt36Yyj9DrRXV5PCQS9pLniLwFAFyJJ
	 JjbtGs4rJN+EA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 2/4] rust: device: implement device context marker
Date: Fri, 14 Mar 2025 17:09:05 +0100
Message-ID: <20250314160932.100165-3-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314160932.100165-1-dakr@kernel.org>
References: <20250314160932.100165-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some bus device functions should only be called from bus callbacks,
such as probe(), remove(), resume(), suspend(), etc.

To ensure this add device context marker structs, that can be used as
generics for bus device implementations.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index db2d9658ba47..21b343a1dc4d 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -209,6 +209,32 @@ unsafe impl Send for Device {}
 // synchronization in `struct device`.
 unsafe impl Sync for Device {}
 
+/// Marker trait for the context of a bus specific device.
+///
+/// Some functions of a bus specific device should only be called from a certain context, i.e. bus
+/// callbacks, such as `probe()`.
+///
+/// This is the marker trait for structures representing the context of a bus specific device.
+pub trait DeviceContext: private::Sealed {}
+
+/// The [`Normal`] context is the context of a bus specific device when it is not an argument of
+/// any bus callback.
+pub struct Normal;
+
+/// The [`Core`] context is the context of a bus specific device when it is supplied as argument of
+/// any of the bus callbacks, such as `probe()`.
+pub struct Core;
+
+mod private {
+    pub trait Sealed {}
+
+    impl Sealed for super::Core {}
+    impl Sealed for super::Normal {}
+}
+
+impl DeviceContext for Core {}
+impl DeviceContext for Normal {}
+
 #[doc(hidden)]
 #[macro_export]
 macro_rules! dev_printk {
-- 
2.48.1


