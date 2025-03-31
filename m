Return-Path: <linux-pci+bounces-25021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049CDA76F4B
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 22:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B008F16B08C
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 20:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE5021D3CA;
	Mon, 31 Mar 2025 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDyGRwDk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7121ABC3;
	Mon, 31 Mar 2025 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452946; cv=none; b=RUzKwySiess9uG+EvuSrTVgGob+IqXzQsxSHkR+NFGCF6WVYcI+pExMfz2u/C6NVbx4wT94VI5L8yD0MHQR7SbL8ECS7WpZlgNV1SZDN/vpLtwZExscvQ30vtVqp5uOiYVWYwW0U68WSeoy/ZWTt63h4LjLwLmY5vQZsl77nmcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452946; c=relaxed/simple;
	bh=YooJygfybgW+FdQ7/bu7ky5o5E8yt0T77/D8/f7ELV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brv05/WJWR46XdDQ/17epwfrxXH+l0x0GQaSgE7+72+1owCGHXO+2Klh+0dsSTOMMMdZC5++JM10XVVQonr59zo/a4D0F612NvTyztdZXUvr51pug/gl2oAMKw+AStztKHy//Zne2gF4GGuLHBEDCpLxt6F/AahLXESued/mptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDyGRwDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52732C4CEE3;
	Mon, 31 Mar 2025 20:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743452946;
	bh=YooJygfybgW+FdQ7/bu7ky5o5E8yt0T77/D8/f7ELV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDyGRwDkQhN+FSpeaw1RF3LFiqdVfDSWQTScgiG8S4SRucrG/8qZO4VfNLLcfj6P5
	 I5JM71+2Moh0kTm9oO2H9Gh5JJnXCtN85I+CIDLxD2t/PI4aZqcEADbgCnq9PgUk5l
	 i39TnQWTlymfWlrEIbiay6sPU5noQH6juh+jshg9zbF+9DKWKG/eZc3M6x46TDDPa4
	 HTw9AdPyW8utJnckeyNPcaPtSE+TKbuD9VIhXgdxebgk/m8M5OH13z4npOl8G56Fuh
	 3zzMgLM/2CSJ52llRAvGrSAcGc5g7dNhC6NTstW8f6B+wg6+51mfmT5DfiW7nC/71r
	 vBlZr4gmuu3GA==
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
Subject: [PATCH 4/9] rust: platform: preserve device context in AsRef
Date: Mon, 31 Mar 2025 22:27:57 +0200
Message-ID: <20250331202805.338468-5-dakr@kernel.org>
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

For instance, when calling platform::Device<Core> the new AsRef
implementation returns device::Device<Core>.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 9133490ea4c9..fa07f895af3a 100644
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
@@ -205,8 +205,8 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
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


