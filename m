Return-Path: <linux-pci+bounces-25680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35425A8600F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 16:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438277ACF4F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 14:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586201F4187;
	Fri, 11 Apr 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3IJbWDl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D41F3BB8;
	Fri, 11 Apr 2025 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380520; cv=none; b=ZN8z2Pv+PUOxb2LtzU2KBo1VDb14gze3rvss7TIOp3y9E7UwXebQtCdwS7uyQqQKO1o1QLcP/EAIUm5wHZMmF4srVJPErZmWKUoGauRHaix8+PgUThNBuTpkbN9Aau4hQuRrvk4hEWQjKdYwT5xTSo1rT3Fa/O5jvzMOGADYZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380520; c=relaxed/simple;
	bh=Q3eaWd+6wGMNRQPZybiIJSiRvz0UKOQRz+P7X6jycHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=udRTdI+6fKPzItv/S1ucECP0kJRi2K04EhhDfOYHE+0TZj8kj3MFxC/I4Nkpgo2KQXOF4qU5L6dJn/WEcb1x0GHRXFZk4acauGvctvAlBFedR/oWM+6l/KpQ0tBHO8FZiJyQE3nmspGXLKiB5HOd41UaF8TwDW6VWA2reWLTzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3IJbWDl; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47677b77725so20505301cf.3;
        Fri, 11 Apr 2025 07:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744380517; x=1744985317; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yzM0vwTr4TmNBoJJcVUz9Je6wZw8hkznV+w3yMHTmLs=;
        b=h3IJbWDlhW13bfKWuhbx4beyHVzzKAJhM8muhfO+fXXZAjgws/P3lxupwl2zLbmLaA
         YDuZ9SbcRYNG79Lwo/HTTFe5kEllNiSUNm2Abh9PUKlN7125an9a9rKr9ABMj3zBnkY2
         Vo85ZUuRlB+4wmqDsIPiBIsbT3TIEEzChOLON7dl/ToVzTbNiv19PhHB6Nt6IRGfUm9s
         pNmt03uCfIMZ2Hw3XkXGIir0Y8BqiIYPJ2w1T7tuQcfAxcq4p3dEcxYttbVaJctCRd3z
         PuBGSjy8SzYn0ZEhj5btFAdPxCXpt+ro7LbKIRc+cUpfeodvI6RrMNoh+mxgq4F+dtEJ
         3JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744380517; x=1744985317;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzM0vwTr4TmNBoJJcVUz9Je6wZw8hkznV+w3yMHTmLs=;
        b=mZSMMmKMvfcMmmMwizBMylqwH5QGRGNvlS69bnPlhrohxlV56eBcA9fcgsCk0lkgCn
         Hr5u2Bjt5DmPF06joFDAkhy1kcX1a0wKG+xJqV4n4gFUEezmpweSqg5ZioAcJ/H7MD3S
         HJXPBEueZtYfDwXQMqGUcSBcqeldInL4IymjPHpIgkY3uCp0jYoVgGd7w0Mfcm55fnyZ
         s50PdqMPzIvU7tQcVhI2YrFggdx6HxUntw4k1lPvafMUsrnGc5a9NSwDKSFI+kI1xVpq
         uGpedXx/5rZVQmvzoATA/lRNwj2plkB8n6LNiCWM8TYr6S6x7cX9PnimJcqpY/EJThwo
         /xvw==
X-Forwarded-Encrypted: i=1; AJvYcCUt9AIRz/j66Vn9h3SzmSjvnCCgZMZCn/pT2QwYuFlFOUcFTA/s6T8+NjU9GF4D878eolsTVkV5fM8wn+xAgso=@vger.kernel.org, AJvYcCVDcclDcwx1CiF6+7yc8XfC8llTCIkrjjyicgZtBUemL+nVnOB787ACyCO7TExPU+r8JCkla74gTWHY@vger.kernel.org, AJvYcCVN541V6xF43beR4nP3AeqN9L9Xo0ja2O3dUwfptIBSOW9wbCLYVITkApHDnYpzKXM1Zo9ICgM3k424Q8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC86SK6uhqFFQQDWq5z+q0XZtDP4qqYXQZYO1eY7EplTpI388D
	L90tkSdqymw/6ZK7G6AuE2y5mZDS2k0DwaH3NrV6OjbaoaIn1LCPFE8q3BI5
X-Gm-Gg: ASbGnctefUipodzp0EgxdWascyzELf7aECQPloWAWIg63j7GGkQM5dDtFtGTq3XSLnc
	Fi97FW/a++PhLu3ffk4jacs2VqTdUTZTT8y8J3ESdp3rNc56TB+M40m3vNUefvEEd5hdfcP6Wlh
	17MZ6mDsp0XmrP3tyPJIK/fjYt77lNr6iILlpto+pG2B78B4uwsbW6yM44bIFXeEahGoAVeFRvv
	xBp8AG2g/J+eItSdQZFhBuNVXWR98Q6usX3ZxEocmo2pus2vaap1o10e2uDSozu4VLcYm9cfDHs
	rKvMw45b8kqEzyF11nihQ0+C7nHGtN1ABAB/x43mRK9mWUZwo1Eg4BPX5jGK5iO46qE=
X-Google-Smtp-Source: AGHT+IEkZCpPSOfFFs4p/DramAWWHRy0xJDNth8YSq+TvpMzGWw9fJchjS6mFS3f28qolg0RykLZ5g==
X-Received: by 2002:ac8:5745:0:b0:476:add4:d2a9 with SMTP id d75a77b69052e-4797755dfcemr41402541cf.30.1744380516812;
        Fri, 11 Apr 2025 07:08:36 -0700 (PDT)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:1d83:73da:5aa:7e95])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796ed9cc64sm25872641cf.62.2025.04.11.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 07:08:36 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 11 Apr 2025 10:08:27 -0400
Subject: [PATCH v3] rust: workqueue: remove HasWork::OFFSET
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-no-offset-v3-1-c0b174640ec3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFoi+WcC/22QzW7DIBCEX8XiXCr+jMGnvkeVAz9LglRDCsRqF
 PndQxKp9aHH2d0ZfbM3VKFEqGgebqjAGmvMqQv+NiB3MukIOPquESNsJJxMOGWcQ6jQMAjJpZz
 MxIJF/f5cIMSfZ9bnoetTrC2X6zN6pY/pfykrxQQTNzEVJLdSu4/jYuLXu8sLeqSs7M8piN47W
 Xd6bxRQQY0meu/cXkAFvi+9U3tRIWsq4L5fYpsHYgIL0gK1ginK1WglVc4qabwWEjx4orRxCu1
 /MQ+/JC6nZmKC0oHwcmkJasWWjtwbK7hSfu6tD9t2BwJidGRkAQAA
X-Change-ID: 20250307-no-offset-e463667a72fb
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Implement `HasWork::work_container_of` in `impl_has_work!`, narrowing
the interface of `HasWork` and replacing pointer arithmetic with
`container_of!`. Remove the provided implementation of
`HasWork::get_work_offset` without replacement; an implementation is
already generated in `impl_has_work!`. Remove the `Self: Sized` bound on
`HasWork::work_container_of` which was apparently necessary to access
`OFFSET` as `OFFSET` no longer exists.

A similar API change was discussed on the hrtimer series[1].

Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org/ [1]
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v3:
- Extract first commit to its own series as it is shared with other
  series.
- Reword `HasWork` safety comment.
- Link to v2: https://lore.kernel.org/r/20250409-no-offset-v2-0-dda8e141a909@gmail.com

Changes in v2:
- Rebase on v6.15-rc1.
- Add WORKQUEUE maintainers to cc.
- Link to v1: https://lore.kernel.org/r/20250307-no-offset-v1-0-0c728f63b69c@gmail.com
---
 rust/kernel/workqueue.rs | 50 ++++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index f98bd02b838f..d092112d843f 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -429,51 +429,28 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
 ///
 /// # Safety
 ///
-/// The [`OFFSET`] constant must be the offset of a field in `Self` of type [`Work<T, ID>`]. The
-/// methods on this trait must have exactly the behavior that the definitions given below have.
+/// The methods [`raw_get_work`] and [`work_container_of`] must return valid pointers and must be
+/// true inverses of each other; that is, they must satisfy the following invariants:
+/// - `work_container_of(raw_get_work(ptr)) == ptr` for any `ptr: *mut Self`.
+/// - `raw_get_work(work_container_of(ptr)) == ptr` for any `ptr: *mut Work<T, ID>`.
 ///
 /// [`impl_has_work!`]: crate::impl_has_work
-/// [`OFFSET`]: HasWork::OFFSET
+/// [`raw_get_work`]: HasWork::raw_get_work
+/// [`work_container_of`]: HasWork::work_container_of
 pub unsafe trait HasWork<T, const ID: u64 = 0> {
-    /// The offset of the [`Work<T, ID>`] field.
-    const OFFSET: usize;
-
-    /// Returns the offset of the [`Work<T, ID>`] field.
-    ///
-    /// This method exists because the [`OFFSET`] constant cannot be accessed if the type is not
-    /// [`Sized`].
-    ///
-    /// [`OFFSET`]: HasWork::OFFSET
-    #[inline]
-    fn get_work_offset(&self) -> usize {
-        Self::OFFSET
-    }
-
     /// Returns a pointer to the [`Work<T, ID>`] field.
     ///
     /// # Safety
     ///
     /// The provided pointer must point at a valid struct of type `Self`.
-    #[inline]
-    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
-        // SAFETY: The caller promises that the pointer is valid.
-        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut Work<T, ID> }
-    }
+    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID>;
 
     /// Returns a pointer to the struct containing the [`Work<T, ID>`] field.
     ///
     /// # Safety
     ///
     /// The pointer must point at a [`Work<T, ID>`] field in a struct of type `Self`.
-    #[inline]
-    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
-    where
-        Self: Sized,
-    {
-        // SAFETY: The caller promises that the pointer points at a field of the right type in the
-        // right kind of struct.
-        unsafe { (ptr as *mut u8).sub(Self::OFFSET) as *mut Self }
-    }
+    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self;
 }
 
 /// Used to safely implement the [`HasWork<T, ID>`] trait.
@@ -504,8 +481,6 @@ macro_rules! impl_has_work {
         // SAFETY: The implementation of `raw_get_work` only compiles if the field has the right
         // type.
         unsafe impl$(<$($generics)+>)? $crate::workqueue::HasWork<$work_type $(, $id)?> for $self {
-            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
-
             #[inline]
             unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_type $(, $id)?> {
                 // SAFETY: The caller promises that the pointer is not dangling.
@@ -513,6 +488,15 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_typ
                     ::core::ptr::addr_of_mut!((*ptr).$field)
                 }
             }
+
+            #[inline]
+            unsafe fn work_container_of(
+                ptr: *mut $crate::workqueue::Work<$work_type $(, $id)?>,
+            ) -> *mut Self {
+                // SAFETY: The caller promises that the pointer points at a field of the right type
+                // in the right kind of struct.
+                unsafe { $crate::container_of!(ptr, Self, $field) }
+            }
         }
     )*};
 }

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250307-no-offset-e463667a72fb
prerequisite-change-id: 20250409-container-of-mutness-b153dab4388d:v1
prerequisite-patch-id: 53d5889db599267f87642bb0ae3063c29bc24863

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


