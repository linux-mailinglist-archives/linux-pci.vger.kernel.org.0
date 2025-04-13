Return-Path: <linux-pci+bounces-25754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5B8A87311
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C623BA22C
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50331F4184;
	Sun, 13 Apr 2025 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+2FbAIW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7171F3BA3;
	Sun, 13 Apr 2025 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744565902; cv=none; b=hl4ptVEwpvtZaL/BqVQ3/fIW6gNNO9p+3n9BQF+eSyLs20CLSzr7PWnLJKXf3FhYmmBivgbgL5a4L4uAxxR4RBqs699Iw/n4bpJxwVINcmSel6GPqWVLT3h0Q4qVZf59cRT/VGT9s9nQYvCnXo38hBTJPrVfYtFyhHyNRZ5H/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744565902; c=relaxed/simple;
	bh=EzfjRnRLuRUm/3m/Zp071bKg/YimuUsvy/AL0I0smyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBK/G0+K5BnAOyW1OJcPyTwIgspDJqilXrCR2p0NiMhPeCV3nF858N4oetyqOsH5R1UU6lBI+abxkwelK38iRrgA0UUlGbV+jSHeERfSUXTweD1CEKlu4AayDxe/rSDNzIvSbuv5qmS7QN4uy9ogqOtBqr2IOpZPa46l4VM2ttM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+2FbAIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EE3C4CEDD;
	Sun, 13 Apr 2025 17:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744565902;
	bh=EzfjRnRLuRUm/3m/Zp071bKg/YimuUsvy/AL0I0smyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+2FbAIWMtf86jRA/jNlfWou4L6cPe0rx6+u8buw09YAHyjgpFx2/Dj3eeo9hRjtU
	 qWwnj/wHPKH9slBHXK0R3gppz4t7Wmxa6pvsQPSMt5egQ/fGld3ofgfritdMaq9eGW
	 CFjvri5aSGpWCSpwy8WgIU/j4+1tPvhPDcRqIVR+KPZul4cvplZIyQj+4YsfBaX+Mx
	 i5Qa3+7SUNhXa8U3RdhpA4kz9OTuRmIR7B6zJbT9Y6bfuBi0QMqPKnqKJ1pHGPoEWC
	 gA/YYibZGDPN8JLtyu2xCKyb91hVRNy7xWiuy7wwcD4KaBXUdn/DNJpnjd+wPHmMGn
	 Q0YqpDWbMQqTA==
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
Subject: [PATCH v2 4/9] rust: platform: preserve device context in AsRef
Date: Sun, 13 Apr 2025 19:36:59 +0200
Message-ID: <20250413173758.12068-5-dakr@kernel.org>
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

For instance, when calling platform::Device<Core> the new AsRef
implementation returns device::Device<Core>.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 9476b717c425..b1c48cd95cd6 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -183,7 +183,7 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
     PhantomData<Ctx>,
 );
 
-impl Device {
+impl<Ctx: device::DeviceContext> Device<Ctx> {
     fn as_raw(&self) -> *mut bindings::platform_device {
         self.0.get()
     }
@@ -207,8 +207,8 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
-impl AsRef<device::Device> for Device {
-    fn as_ref(&self) -> &device::Device {
+impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
+    fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
         // `struct platform_device`.
         let dev = unsafe { addr_of_mut!((*self.as_raw()).dev) };
-- 
2.49.0


