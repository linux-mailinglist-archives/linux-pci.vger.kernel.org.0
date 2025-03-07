Return-Path: <linux-pci+bounces-23156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECB0A5743F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 22:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBF33B46B8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 21:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866092580F4;
	Fri,  7 Mar 2025 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6XcjMM2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D088F241CA5;
	Fri,  7 Mar 2025 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384737; cv=none; b=QIQ+U5qnRU7boDeIPWgQ/BTUc4UZWygrNWwB6VnASFSQHR/+EeQ6ws8Net2AIl7EbLQNN01gl9P18vSD13Q87ywxcgSSkLfuoNZCIJQ4kVJHjC7O8s1f3woH66964KXEhvuduDf+LS46DcPp5J9u5D/qwRdwc4fguy/ba0RYCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384737; c=relaxed/simple;
	bh=/DKrhnmPZZIQv+8vQPWliOACuceoct8j/sl5tF1Rz6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLaWA8faowgOImzZRM9WVdhc5zYfBHkKEOQMxgKnvw7IB6SGPz1fck6jApVwlwn9a57pyDL6xaLVqgZqsbrkfBXltZBeOhhqJ7aMhx1BG72xxlqtvuQaiE55PzPFFNK3vpx15GcHMj4Jk80NnTieq9PBYYFS2Ic+ON/t0CF9/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6XcjMM2; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c3d1b78b93so167057985a.0;
        Fri, 07 Mar 2025 13:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741384735; x=1741989535; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pi5cI/LLlwHQg6RvcCMpGvpsOGvk8/oT/vsRBptznRc=;
        b=J6XcjMM2M8B+A6GvivVMnBFX392lW2rT5jq7uhBeOM62032M02dvreeyZlY0/tHbW/
         m6OTn7dntvIUKvgPDmP4ykQ1s36ui60+UAvo+2R9+BjS8g6x2vCyIeW4Sj3JNpWIw1Hz
         D08pAvoeXijLXvTMzl/4nJACMTfVZ65e2MJal2zkl1jvPoLW67AqKEF0uLnhbfA1m2SU
         51yAvF2YFzkhReJAiSrLqV7bHFY69RUvzp8GiMmUmIt8c/WjnhOrN9uplTj3uN5LNM4+
         MwekJbWF+GtuRyVBvnw+XJ+uqFq1Yqi0SkdsXBoTgF8nPCNoTI/3ETvcyMEWMjytX4dF
         4tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741384735; x=1741989535;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pi5cI/LLlwHQg6RvcCMpGvpsOGvk8/oT/vsRBptznRc=;
        b=TFoMrjX5wAzk6+krwjYaxT06qZxSyWaSWE2a+b5+H2efXVeV/UKOJafwA+vW5EcsHp
         s/K212XJg12l9X+O6e3gKgjWmWZB53Dd2dQoLt1K4yHaHgoMOV0s7XbQISwMJ/97bdtS
         W3XHrlI1e/OgfFANj6ZoD/jXBSAyWvwCkIeqm+5baFLHof5KG2KUujjaIfQb+G/SRGWr
         TXNZmuqfqaUEUbaOEGFQxUJoqbvTILfFd1aXCKDnUiTG1S0FEpmScDE3Agd5Jdn6fklP
         QeDCmhswtbklnjxTzOvgBu/GnOtXN5di7U+GXqUoKs66dBy8p1wz/SnKc/XQRbNRD8X8
         sCAg==
X-Forwarded-Encrypted: i=1; AJvYcCVyybvF96S4SQZJVFsUWxdnpxgorOe+bijYW6HEUO9FpPgv3NlkSjZ8NNESPuf8gaOIWn4TxarEFo5m@vger.kernel.org, AJvYcCX6JDI4BjkwkK56Ba5Jiv1xGQyaDVCh2H9mNcH4whzA3X89Pm5kMwbrGh0jIb0cSgZi2HURRN0/Bg+2F3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHC0tztvE9bPJCkVMUZk4AFLrSSj0AdxanYbomOLU+qqk7wLEL
	Z1B8u8UBkAwHto1428JIUxb5c2TNVhrTPA8nBs3QhouafuV3YGZw
X-Gm-Gg: ASbGnctsoUA9BYIJJpwUJMOuFIXQZBtMlRFiJW3EddH3buSgEQ+1yKZ6YOpHeswItIt
	MZwZ4zTm2hbk6QRy5Gof5J69et+sy8X1HfvMQMLCK7LcXTq2ylUPLTAeQtaUnh+DJ/LRioHXoJK
	eqE97P4eNfaWXHXDrEfJtbTxXl0/pmbCHl8+VqIqFqjZWNwNipWjBc+xDfHb/edj97+3H1YYNlI
	ewvPY8BZNowmqT3Sq6yDT65TSbxs/tNuav0TOC8hDL0IriJvCJRKF71WkvQ/nMZH6rGbIdnmRz+
	MlqjxGgu8a/ditWukujUoRXokzz1yTRZifZemtltRbjrCcdguIGeibQXkdItam/HCrYrI2trTVC
	3Y+iAhg==
X-Google-Smtp-Source: AGHT+IEn6eaklWfFbYG9BMbTxey++4gqPUxT+6qQxC4MqEDmQ8eJRUPM9y8mXMbq5l8lfnbVjBw9Og==
X-Received: by 2002:a05:620a:4885:b0:7c3:d314:7238 with SMTP id af79cd13be357-7c4e61a0c12mr837645285a.49.1741384734601;
        Fri, 07 Mar 2025 13:58:54 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a481sm293735085a.13.2025.03.07.13.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 13:58:54 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Mar 2025 16:58:49 -0500
Subject: [PATCH 2/2] rust: workqueue: remove HasWork::OFFSET
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-no-offset-v1-2-0c728f63b69c@gmail.com>
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com>
In-Reply-To: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/workqueue.rs | 45 ++++++++++++---------------------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 0cd100d2aefb..0e2e0ecc58a6 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -429,51 +429,23 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
 ///
 /// # Safety
 ///
-/// The [`OFFSET`] constant must be the offset of a field in `Self` of type [`Work<T, ID>`]. The
-/// methods on this trait must have exactly the behavior that the definitions given below have.
+/// The methods on this trait must have exactly the behavior that the definitions given below have.
 ///
 /// [`impl_has_work!`]: crate::impl_has_work
-/// [`OFFSET`]: HasWork::OFFSET
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
@@ -504,8 +476,6 @@ macro_rules! impl_has_work {
         // SAFETY: The implementation of `raw_get_work` only compiles if the field has the right
         // type.
         unsafe impl$(<$($generics)+>)? $crate::workqueue::HasWork<$work_type $(, $id)?> for $self {
-            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
-
             #[inline]
             unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_type $(, $id)?> {
                 // SAFETY: The caller promises that the pointer is not dangling.
@@ -513,6 +483,15 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_typ
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

-- 
2.48.1


