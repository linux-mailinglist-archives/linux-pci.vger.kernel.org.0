Return-Path: <linux-pci+bounces-38648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73249BEDE3B
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 07:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909F93E847E
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 05:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5661921B9C0;
	Sun, 19 Oct 2025 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXR1Tjdu"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800642153EA
	for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760850013; cv=none; b=UEZhFXlHiUisq6xjFj86BLRT7jWFU1b7KEQfiTDRaA0lWy3W22O2RA87/0e9KVZAnj9OM3FlYdSRfw6qmxRCbTP1ariwNmw3U8WLV9nXhQx7BWk/zW6Ak8ufZlRhMSz7THY+Dc+JepFGXhSomr+MTVrxJE5BT5zA9EObdFSsOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760850013; c=relaxed/simple;
	bh=YUyYgzYm9tbG09HLL/WAwoU4M99Mv0yjyKmgERRoNjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+h1eM+0pmZs3j72hI6mfgFJiX2eoaxrlMmQXcNLhGwJO+i2IFdbkcQK+vpD1E6mvi/OF93GDxMTdjZda+bP1vm0KnSCtgajmVgW/U7q7bYM3KtcAdP5t+D9tIV+1XF90LJz/EP6T3QeqAoVn7AXEi2Wsg1PsSGd3A2nA3zZhYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RXR1Tjdu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760850010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQXW79VD1VDqu9OOdSqXUG39KL0/s9L9/QkyIlNgoV0=;
	b=RXR1TjduRixxK24JNV3Cjo1L5yaJf1FkSvOYPAaWbn4tk0ZnnYAI6/8MPs99rmJHFCejoD
	g91mXSJuwlm7vGFWjwcpBq42sfkOdWxMuch/WFNX3uzjtg/7J5HRAzArnhrsPzIbmYen7H
	3SBW32U1RklAHQ2awg9JONOoXdbTaH4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-ixyuE-YXNJS2a3y_fQNe1Q-1; Sun, 19 Oct 2025 01:00:09 -0400
X-MC-Unique: ixyuE-YXNJS2a3y_fQNe1Q-1
X-Mimecast-MFC-AGG-ID: ixyuE-YXNJS2a3y_fQNe1Q_1760850008
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-797ab35807eso148541946d6.1
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 22:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760850008; x=1761454808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQXW79VD1VDqu9OOdSqXUG39KL0/s9L9/QkyIlNgoV0=;
        b=E3X1/aenZ1/hYbR5XI0HyBC3OJmgcBFXUSqHQ6Tk7EBl8VgXwwvn6ZJJ1D3PXIuxGI
         Dg8R//w+PMkC+aMwrX8HOkzsOSe1nXZwipKnylnZIsB9OsyFw8eJMd9zHTllYp05R+TK
         4+3aNoMZysSb22Rl5MkAOjGE2HuwC6l2s54jEge3oXR5YPcWHZQwnZt7J9ir3U6hnpGr
         yJYsBP/rmF2lfOTAHBdpEODlDvg4DmJgIRI8EpOijTm4ydZzBuVDSWfkbgFmlH9I04ml
         Cv50xve8vE6vtrwqnaUQ47DjZJQ5XnH1EcdLscf4pFysLj9o8OPiqOC9tmfW2srtumzq
         t6kw==
X-Forwarded-Encrypted: i=1; AJvYcCUFQBgqB1BMmWfBSqm03O1032Df/Pt7XW2p9E1Lzv11+ZeSkZa9Q5ElTLN5knz7Na727AwHDZ3gNIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAFt4UrhIKO8UUDBQTEevDgnpcPeFvQslF02IzXc5N4aUnXw9O
	d0RX//N2GdtuQbAGzbdGLnldHmO+o+OLjvCIxw1GNwXsITKjf0Q2Frmn4dbpYHwHYudVT/6gCyO
	3aBH1+3mC9zuLqM8KhsJDOOxj03A6aNg3G9dZo6lyL+EiD6VnsF6hml6KXGkhAA==
X-Gm-Gg: ASbGncu7InidI+hHJjM/VVHUIzC7l7jpaUAcQPoq97iA+pJJNfDBWqi4iArBp/7u8bk
	Q8AMGPyw4EDbnIfKYobPntIFdA0I5qWtAEMVbcxeFZqwmnkSZJmHxLvZfN3Edw4qZYSs19NBFXp
	WMq625rc4Lll6JPBE6jRCrWGi6USyBFBEGYeG53Ry+ijxDwiDwE2UpU1UADC8TPc9iuGdtjg7LM
	YT4eIU6iFOrf2nhnWd+Vq3n0l7MMb6vkzW/eRkSLTZvQKqETpM0iRwvfd8NW/RPomLLBqdDgsq8
	W+lbXOb1JMRuv58Sc/LknIVPrbJY4hLsALlD8t/1aq07VrgM9c78uqkJrfLrlmscoPeEL+kVA02
	E/NYeiMUOrN6e
X-Received: by 2002:ac8:5ad0:0:b0:4e8:aee7:c559 with SMTP id d75a77b69052e-4e8aee7c85cmr47240361cf.31.1760850008592;
        Sat, 18 Oct 2025 22:00:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2GCOUQgg388o06Q5JSqBle/dvEc3Un/4442RGMFaboTta85NJv6+LnGnnuvBC07NDv3meCA==
X-Received: by 2002:ac8:5ad0:0:b0:4e8:aee7:c559 with SMTP id d75a77b69052e-4e8aee7c85cmr47240031cf.31.1760850008184;
        Sat, 18 Oct 2025 22:00:08 -0700 (PDT)
Received: from mira.orion.internal ([2607:f2c0:b0fc:be00:3640:bdf5:7a8:2136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028ad781sm27154396d6.49.2025.10.18.22.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 22:00:07 -0700 (PDT)
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
Subject: [PATCH 2/2] rust: pci: normalise spelling of PCI BAR
Date: Sun, 19 Oct 2025 04:56:20 +0000
Message-ID: <20251019045620.2080-3-pcolberg@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019045620.2080-1-pcolberg@redhat.com>
References: <20251019045620.2080-1-pcolberg@redhat.com>
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
 rust/kernel/pci.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 18f9b92a745e..747a0487d1e5 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -363,7 +363,7 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
 /// # Invariants
 ///
 /// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
-/// memory mapped PCI bar and its size.
+/// memory mapped PCI BAR and its size.
 pub struct Bar<const SIZE: usize = 0> {
     pdev: ARef<Device>,
     io: IoRaw<SIZE>,
@@ -423,7 +423,7 @@ fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
 
     /// # Safety
     ///
-    /// `ioptr` must be a valid pointer to the memory mapped PCI bar number `num`.
+    /// `ioptr` must be a valid pointer to the memory mapped PCI BAR number `num`.
     unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
         // SAFETY:
         // `pdev` is valid by the invariants of `Device`.
@@ -537,7 +537,7 @@ pub fn subsystem_device_id(&self) -> u16 {
         unsafe { (*self.as_raw()).subsystem_device }
     }
 
-    /// Returns the start of the given PCI bar resource.
+    /// Returns the start of the given PCI BAR resource.
     pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
             return Err(EINVAL);
@@ -549,7 +549,7 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
     }
 
-    /// Returns the size of the given PCI bar resource.
+    /// Returns the size of the given PCI BAR resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
             return Err(EINVAL);
@@ -656,7 +656,7 @@ fn drop(&mut self) {
 }
 
 impl Device<device::Bound> {
-    /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
+    /// Maps an entire PCI BAR after performing a region-request on it. I/O operation bound checks
     /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
     pub fn iomap_region_sized<'a, const SIZE: usize>(
         &'a self,
@@ -666,7 +666,7 @@ pub fn iomap_region_sized<'a, const SIZE: usize>(
         Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
     }
 
-    /// Mapps an entire PCI-BAR after performing a region-request on it.
+    /// Maps an entire PCI BAR after performing a region-request on it.
     pub fn iomap_region<'a>(
         &'a self,
         bar: u32,
-- 
2.51.0


