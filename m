Return-Path: <linux-pci+bounces-38782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3807DBF2973
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 19:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07D923433E3
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0FB330B35;
	Mon, 20 Oct 2025 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+KPs0sk"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825EA330B0A
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979766; cv=none; b=HhDmO7JYme0Yq9Bz8uPw6taqnG43ljXltQMkZ0unh6tlR7dfveIKyQEHkvDGEap8Xpxd+M82n0TwN2TBIGEuiGNImbWdvDjBc+rFgvEQLJVZLuq9HQYR8peLVk9hTGH8rw+4tzWlka4QLYQmlGKij0JMGb0zMVPdMq3k4Wh6s0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979766; c=relaxed/simple;
	bh=kMtr8rxMNB8DiOzifUqvwMtBN3H+SuqhXgD87exLlow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aP/8+8pvEdEb1FZjS9/Gm+tL2qdCecYInbqGudCCmcZ4ZfSTqSZ0Q98dEGBA7/cZsawbnMa546vZ8aSyCEwPfnmE5d0KjTmBphQR1UHjcPrXrLCnhcjaXWreUS7FeFHKH3eSGTyTuceHf81jD9a5dz3Z/s+afudj2EXFy/CWhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+KPs0sk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760979763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60e0IVore7boCdNupv+ILyCAnntv+WCulzbwmbp4u7k=;
	b=h+KPs0skYnxCW7jmLoE4PzgzFE63/iPQnJs4OcVME4AVi8MpSliGZHrjNbAUbqzlNP1/s7
	1jrB/e1r+vwA9RDm4DpttqXHqmHt7j3I0SMtoo8FO3eQTFccRSg6IKZjZLNes8FkoB6DFz
	7EswOZd9Z9HkTGwBuOWWdpZhACtTRC8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-kmUAsr4tM6GTcMxSGXz2Ng-1; Mon, 20 Oct 2025 13:02:42 -0400
X-MC-Unique: kmUAsr4tM6GTcMxSGXz2Ng-1
X-Mimecast-MFC-AGG-ID: kmUAsr4tM6GTcMxSGXz2Ng_1760979761
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c2085ff29so163949376d6.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 10:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979761; x=1761584561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60e0IVore7boCdNupv+ILyCAnntv+WCulzbwmbp4u7k=;
        b=MAh88FJTUAx0d/pE954XWU5/i1G/L8pD0SDq+3ViOExNSdGUyfxI6aggwlxrykD08h
         jTmiwboZwdILhN7X5ZIl7ZRIDWXxupBKUaKSS1sVrWN/vwKk2Arjm6QRBM1y2CeD+WrG
         /2P4496qHOwSMGBbcC+N0wn1mt0884TZO/UoTEdfUscWalyGKeKsm4TO/B5v0g8DBOOn
         Zs/yBzNHzaCWqe0feayW1wmI115+rfLw6q7qGOTGzkc3eAfyj7dlnq7oQQqcZPnvoUco
         quS5vzRU/bRe3tAFTKgkeSpS23czyWjKYmldg0F9wEff+6DXMNkKCy6GMK8AxIO5YZhA
         Fwcw==
X-Forwarded-Encrypted: i=1; AJvYcCU6e9tTYulfaE8UWQ9Zkc72zqUZ+uUkOHUwPxuh/X6yfYbCyhKjtfjEeoM5INlhOpCO02hMQxr5Bsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwT2OKH8u0uRvEHxwp1qhB21tA8qJxWzpxJJAXNL5Jd9oYNGFa
	ESiMooSMKjukMG2saw8VMzRNS0+d+cwOv38XmIcfOJqjPDvR4lh1bCKGb9j4e1pFQL4AZiEeKGA
	G4401PD65+6pp+j3412ozEKWv+LESlPVkhcLqFrsG6yDobdSaztO9F2sEwVl6Uw==
X-Gm-Gg: ASbGncsalC2wH1/dyNgtTV1AbuglwLdXU7GrLZTOP45TnarIxpHFqSk5RB0zVi8nNqE
	09oRECRK35GUT5VHnPcdfzjSC/iAmQhIqI1yZPW3mLBq9sGVOdLpD1xUjo6TF9fOVG8q+YU+JNg
	d+vmP6JhUez6/NhcFAUe00Q7N92mgz10EGNTCBVY90TF5ZgpQdbFWxkUIdUdeM+4918T+Oy4wJz
	peQnxjrjfg7hNAiqGfw3zVhXrmrbYlVmgsH1t9jufG/44tkh10qPxeuqaVR0SeZWQgTv/p5Xa4T
	6dzfMEdB631PGJHtODq1zlodsaKEjS30hS786eiycRQg6GWeaZt7/R3zue4u1TQedsrUyAZWg+u
	gIuXe0Lp/Icde
X-Received: by 2002:ac8:7d0c:0:b0:4e8:ad2a:b0d8 with SMTP id d75a77b69052e-4e8ad2adf32mr111401301cf.30.1760979761223;
        Mon, 20 Oct 2025 10:02:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbwVmn9czv79qyCwEl1SriY3PLMsY5z230eFIqxhHynrytOJV25/qzzTjQIcPMDVhjxQP5Qw==
X-Received: by 2002:ac8:7d0c:0:b0:4e8:ad2a:b0d8 with SMTP id d75a77b69052e-4e8ad2adf32mr111400681cf.30.1760979760572;
        Mon, 20 Oct 2025 10:02:40 -0700 (PDT)
Received: from mira.orion.internal ([2607:f2c0:b0fc:be00:3640:bdf5:7a8:2136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf58eecbsm589945985a.49.2025.10.20.10.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:02:40 -0700 (PDT)
From: Peter Colberg <pcolberg@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Colberg <pcolberg@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 2/2] rust: pci: normalise spelling of PCI BAR
Date: Mon, 20 Oct 2025 17:02:23 +0000
Message-ID: <20251020170223.573769-3-pcolberg@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020170223.573769-1-pcolberg@redhat.com>
References: <20251020170223.573769-1-pcolberg@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consistently refer to PCI base address register as PCI BAR.
Fix spelling mistake "Mapps" -> "Maps".

Link: https://lore.kernel.org/rust-for-linux/20251015225827.GA960157@bhelgaas/
Link: https://github.com/Rust-for-Linux/linux/issues/1196
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
v2:
- Rebase onto driver-core-testing to follow "Rust PCI housekeeping"
  patches, which move I/O and IRQ specific code into sub-modules.
---
 rust/kernel/pci.rs    | 4 ++--
 rust/kernel/pci/io.rs | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index ce612c9b7b56..3100d37eba2b 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -377,7 +377,7 @@ pub fn subsystem_device_id(&self) -> u16 {
         unsafe { (*self.as_raw()).subsystem_device }
     }
 
-    /// Returns the start of the given PCI bar resource.
+    /// Returns the start of the given PCI BAR resource.
     pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
             return Err(EINVAL);
@@ -389,7 +389,7 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
     }
 
-    /// Returns the size of the given PCI bar resource.
+    /// Returns the size of the given PCI BAR resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
             return Err(EINVAL);
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 65151a0a1a41..3684276b326b 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -18,7 +18,7 @@
 /// # Invariants
 ///
 /// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
-/// memory mapped PCI bar and its size.
+/// memory mapped PCI BAR and its size.
 pub struct Bar<const SIZE: usize = 0> {
     pdev: ARef<Device>,
     io: IoRaw<SIZE>,
@@ -78,7 +78,7 @@ pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
 
     /// # Safety
     ///
-    /// `ioptr` must be a valid pointer to the memory mapped PCI bar number `num`.
+    /// `ioptr` must be a valid pointer to the memory mapped PCI BAR number `num`.
     unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
         // SAFETY:
         // `pdev` is valid by the invariants of `Device`.
@@ -120,7 +120,7 @@ fn deref(&self) -> &Self::Target {
 }
 
 impl Device<device::Bound> {
-    /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
+    /// Maps an entire PCI BAR after performing a region-request on it. I/O operation bound checks
     /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
     pub fn iomap_region_sized<'a, const SIZE: usize>(
         &'a self,
@@ -130,7 +130,7 @@ pub fn iomap_region_sized<'a, const SIZE: usize>(
         Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
     }
 
-    /// Mapps an entire PCI-BAR after performing a region-request on it.
+    /// Maps an entire PCI BAR after performing a region-request on it.
     pub fn iomap_region<'a>(
         &'a self,
         bar: u32,
-- 
2.51.0


