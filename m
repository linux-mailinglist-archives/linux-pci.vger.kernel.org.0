Return-Path: <linux-pci+bounces-22504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A54A47372
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278C23B6B91
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC1E1B0F0A;
	Thu, 27 Feb 2025 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="jAhTTqR7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XsYrHFoA"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34269187FEC;
	Thu, 27 Feb 2025 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625936; cv=none; b=gURNA93n6SHyNPhKWG6gLda+R+PnC0RjRNAu0EHVy7ejhZkP8BYcG4R05rSaEQkH86Mqy3YMtXARV+0ReiMLUUSPNpLJWzSmbaApxQg/tnlYbVg6Cy4PtygdnGSQ6oqAld8kZ6pWTZeNjgL3cDOCXPZUGqDjO9iwumqDYiVyfHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625936; c=relaxed/simple;
	bh=gzEph50CMKYWc/2RzHgjwSr/eSkelmxLwSNoIw/pV/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsp3q7VcAoU44qEc50UH3JTDlMWmDIhjOEwyKFUpQO0PPQG8+yyb0o830l5VgNAGr2IB8mJvihm6Ef/9kUzDC015yybRFiJCQT8uh2rfn2zouX9r9/JaXqK/fkaORUHGReHEQiYKMxaPEclp4Rf7T69ALOznF9PYAhp0PaKBUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=jAhTTqR7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XsYrHFoA; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C9C3B254020E;
	Wed, 26 Feb 2025 22:12:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 26 Feb 2025 22:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625933; x=
	1740712333; bh=tlNpy+1s0z/XXtMrDxajZ6ojSkUYPqcxJ6nv+synffs=; b=j
	AhTTqR7z/IoQPzKDlQKS9Qu86ZWdhGzNDfVXb0THxSsxRK9s/1//9cfrXVwlUGE7
	VuYMTLjzlkeGCmsxzQBg94E8EsXxtDrR4PZzZlVH/ibX+sXgswuwywx4UOuXNjYK
	PT82atID1Mx77nYUG20EYiFQapjCIJmNkRP5UU7FG02Yy2YqyxkazS/QCRTg3AG8
	/vSDfI6rWh8RUqNJ0FEbIgb2Ju1De2GXGvN1Skqt0T658ZRhfs/EAlMnuaIAZPKY
	AkOdJgaduLhF8vCDwCqD1r1EKIqrgbdZdYgbvU4w5XcQcNgFn+O04JcUAOkMjt9Q
	WcipG5eKEqxNi6NPXFLtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625933; x=1740712333; bh=t
	lNpy+1s0z/XXtMrDxajZ6ojSkUYPqcxJ6nv+synffs=; b=XsYrHFoADJoeUx0HL
	6/sGNVuy5xLuYXYjRpLDujDdnm41DkE+i8WU2gheSZOJ4dyHC3RiDevuEE24fNnH
	NhDChRtLbeUezw9puOBYJ2P73ng/fsxz2X08AcOEumWkvSOIlJR9KmQToApi9bH8
	tDrPlORSQYbniDDj+vfaAiuajxxTxKMrLog3Qy6l3bYmcpk/ZuCQNPxHDwAj5uo5
	0irichrLBET2RWBBb+liaJSHpuKVIe9j+3efXrS3ugkRgFase2O2mZZzIXTWWGVz
	M/f6xwN3DN4wcK9JJsATlMqSVaHwV8CTWn9356McU2DIhYhx6es38Fi0TXAmKJHC
	WYkSw==
X-ME-Sender: <xms:Ddi_ZwLNLDYNJfnrTGyHh5PaBwiBfYS63YfCWejiYMlvsd_dZ9q5jg>
    <xme:Ddi_ZwIyEVNg7-2AhFJjnpk_-hZbdzSyEPHv7kuv9S3_2EHLk6I7Gl7UypDPBKsg2
    9FYtHJjGxik7yf29No>
X-ME-Received: <xmr:Ddi_ZwtveJ73O4Esezw-l7KOpbtxMnpyreQT4SS5-Opxc05TCfTsgOPNKFDHnosAQiao9NIK8VA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvg
    gtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetledvleevveeu
    ueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhr
    vdefrdhmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopehlihhnuhigqdhptghi
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhu
    rgifvghirdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgu
    rghtihhonhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:Ddi_Z9aVEtoFGvZczYPSuwG5NyyUhK0wsRVXVMCVIkw74tbcdxbNVA>
    <xmx:Ddi_Z3bUE36MPKXW9sayWI0BlXBXGE9dmflI906RMVCas13C9E9d1A>
    <xmx:Ddi_Z5AWAjHYh9IsFn1haz7yhKYEtdhEJjbDfDr--yit5miFeuZ8sA>
    <xmx:Ddi_Z9aMht3ivjW149jWSW3nOjjTwDxa2XW2Mgo5KY93B-kc_FtT0A>
    <xmx:Ddi_Zxak0-JPTatXo0_sp2BpDJBHW0zPKGRSXBpUTQi3P5ahu3GUkKIl>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:12:07 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org
Cc: boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alistair23@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	gary@garyguo.net,
	alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC v2 18/20] lib: rspdm: Support SPDM certificate validation
Date: Thu, 27 Feb 2025 13:09:50 +1000
Message-ID: <20250227030952.2319050-19-alistair@alistair23.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227030952.2319050-1-alistair@alistair23.me>
References: <20250227030952.2319050-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/lib.rs                | 17 ++++++
 lib/rspdm/state.rs              | 95 ++++++++++++++++++++++++++++++++-
 rust/bindings/bindings_helper.h |  2 +
 3 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 1535e3a69518..b7ad3b8c659e 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -137,6 +137,17 @@
         provisioned_slots &= !(1 << slot);
     }
 
+    let mut provisioned_slots = state.provisioned_slots;
+    while (provisioned_slots as usize) > 0 {
+        let slot = provisioned_slots.trailing_zeros() as u8;
+
+        if let Err(e) = state.validate_cert_chain(slot) {
+            return e.to_errno() as c_int;
+        }
+
+        provisioned_slots &= !(1 << slot);
+    }
+
     0
 }
 
@@ -145,6 +156,12 @@
 /// @spdm_state: SPDM session state
 #[no_mangle]
 pub unsafe extern "C" fn spdm_destroy(state: &'static mut SpdmState) {
+    if let Some(leaf_key) = &mut state.leaf_key {
+        unsafe {
+            bindings::public_key_free(*leaf_key);
+        }
+    }
+
     if let Some(desc) = &mut state.desc {
         unsafe {
             bindings::kfree(*desc as *mut _ as *mut c_void);
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index ae259623fe50..974d2ee8c0ce 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -12,7 +12,7 @@
 use kernel::prelude::*;
 use kernel::{
     bindings,
-    error::{code::EINVAL, to_result, Error},
+    error::{code::EINVAL, from_err_ptr, to_result, Error},
     str::CStr,
     validate::Untrusted,
 };
@@ -76,9 +76,10 @@
 /// @slot: Certificate chain in each of the 8 slots.  NULL pointer if a slot is
 ///  not populated.  Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
 /// @slot_sz: Certificate chain size (in bytes).
+/// @leaf_key: Public key portion of leaf certificate against which to check
+///  responder's signatures.
 ///
 /// `authenticated`: Whether device was authenticated successfully.
-#[expect(dead_code)]
 pub struct SpdmState {
     pub(crate) dev: *mut bindings::device,
     pub(crate) transport: bindings::spdm_transport,
@@ -111,6 +112,7 @@ pub struct SpdmState {
     // Certificates
     pub(crate) slot: [Option<KVec<u8>>; SPDM_SLOTS],
     slot_sz: [usize; SPDM_SLOTS],
+    pub(crate) leaf_key: Option<*mut bindings::public_key>,
 }
 
 #[repr(C, packed)]
@@ -153,6 +155,7 @@ pub(crate) fn new(
             authenticated: false,
             slot: [const { None }; SPDM_SLOTS],
             slot_sz: [0; SPDM_SLOTS],
+            leaf_key: None,
         }
     }
 
@@ -745,4 +748,92 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
+        let cert_chain_buf = self.slot[slot as usize].as_ref().ok_or(ENOMEM)?;
+        let cert_chain_len = self.slot_sz[slot as usize];
+        let header_len = 4 + self.hash_len;
+
+        let mut offset = header_len;
+        let mut prev_cert: Option<*mut bindings::x509_certificate> = None;
+
+        while offset < cert_chain_len {
+            let cert_len = unsafe {
+                bindings::x509_get_certificate_length(
+                    &cert_chain_buf[offset..] as *const _ as *const u8,
+                    cert_chain_len - offset,
+                )
+            };
+
+            if cert_len < 0 {
+                pr_err!("Invalid certificate length\n");
+                to_result(cert_len as i32)?;
+            }
+
+            let _is_leaf_cert = if offset + cert_len as usize == cert_chain_len {
+                true
+            } else {
+                false
+            };
+
+            let cert_ptr = unsafe {
+                from_err_ptr(bindings::x509_cert_parse(
+                    &cert_chain_buf[offset..] as *const _ as *const c_void,
+                    cert_len as usize,
+                ))?
+            };
+            let cert = unsafe { *cert_ptr };
+
+            if cert.unsupported_sig || cert.blacklisted {
+                to_result(-(bindings::EKEYREJECTED as i32))?;
+            }
+
+            if let Some(prev) = prev_cert {
+                // Check against previous certificate
+                let rc = unsafe { bindings::public_key_verify_signature((*prev).pub_, cert.sig) };
+
+                if rc < 0 {
+                    pr_err!("Signature validation error\n");
+                    to_result(rc)?;
+                }
+            } else {
+                // Check aginst root keyring
+                let key = unsafe {
+                    from_err_ptr(bindings::find_asymmetric_key(
+                        self.keyring,
+                        (*cert.sig).auth_ids[0],
+                        (*cert.sig).auth_ids[1],
+                        (*cert.sig).auth_ids[2],
+                        false,
+                    ))?
+                };
+
+                let rc = unsafe { bindings::verify_signature(key, cert.sig) };
+                unsafe { bindings::key_put(key) };
+
+                if rc < 0 {
+                    pr_err!("Root signature validation error\n");
+                    to_result(rc)?;
+                }
+            }
+
+            if let Some(prev) = prev_cert {
+                unsafe { bindings::x509_free_certificate(prev) };
+            }
+
+            prev_cert = Some(cert_ptr);
+            offset += cert_len as usize;
+        }
+
+        if let Some(prev) = prev_cert {
+            if let Some(validate) = self.validate {
+                let rc = unsafe { validate(self.dev, slot, prev) };
+                to_result(rc)?;
+            }
+
+            self.leaf_key = unsafe { Some((*prev).pub_) };
+        }
+
+        Ok(())
+    }
 }
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 5ba1191429f8..daeb599fb990 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -21,6 +21,8 @@
 #include <linux/hash.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
+#include <keys/asymmetric-type.h>
+#include <keys/x509-parser.h>
 #include <linux/mdio.h>
 #include <linux/miscdevice.h>
 #include <linux/of_device.h>
-- 
2.48.1


