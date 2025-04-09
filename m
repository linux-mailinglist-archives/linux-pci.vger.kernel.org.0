Return-Path: <linux-pci+bounces-25554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F19A821A5
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 12:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E9F1B86F5B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 10:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8005625DAE2;
	Wed,  9 Apr 2025 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvs7gwMG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C5425D8E2;
	Wed,  9 Apr 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193020; cv=none; b=lNWe0O1S2fJ22h9TwecEMc0QaNWbKM1UvajBPRNteKDmc6DM7XHg3ctCgSleHVc3t0zW2j7UdMIpaGSFEf25wZRbS9tisr0dvImeIlUZknwglnzfec94ujB2Gwf6crz2PNNu13fZJKP3i/fg1F8HMTnYLA8MTFm9VAk+tI7wMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193020; c=relaxed/simple;
	bh=4HUFzLijaqqmDi2vGvHYj35FaaFCBBHbUp2YtC3ZOZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ROSFfBvGDTJ7uYQML4WZm1KgJKkuI+cVyPSbwJml5D8rh1LBEKpSbY17EP2NoIEV+an9Az0vV8Ot5+jekRw/TcT7VnXlrUpjbzeVCwFMiDNuQp9THx1WZbXkCoEeiBu2qYz2Oa4NbwrlAodIKE9P0HpceqjVbscUbZdFjKXIChM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvs7gwMG; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47692b9d059so30909311cf.3;
        Wed, 09 Apr 2025 03:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744193017; x=1744797817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLbUqyimeGVgLsepfBGSq56KRRSrML5/eyV4qttU/Qc=;
        b=hvs7gwMGNj0PdgWsLRWVvUkqo6FlvwRlqoNV63AZVxig/tIfoTeEUB+AArODTPA0sk
         XUKhHgvywftlJAn0CuyuX99f6NahgMHySgeU6NLtFd3CYkb8M5mbq0HFbC8wviVNiHJH
         gfF7fh8h1cBOXhtF4fDOud8xCMFMqxH83bZxHBu3of/t6y1hwmJaB60M4uyD3r2tVAXl
         fsUHRMBG1zSSN8j3QKcUFpdExkG1OWf+DgcxhkhV40VEOzBqjWq4csC6xppypwrlwAKN
         AZ5S9jZfd3ZoV+wAVCpkkad/nYnTFnko9+DDLPwTZsXDqpB3nUbSsi+LDMUZ6pi/PPX4
         17Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744193017; x=1744797817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLbUqyimeGVgLsepfBGSq56KRRSrML5/eyV4qttU/Qc=;
        b=FwcDNOZoDD3kpQJdnXoXT6cCX9q7ti34jIadca//QVFihphvVihipGTfv6fP0s3voY
         i1zkzHwQI2zgTPe6jliazox42iR6c1hwMzuQZexUL5Qbt95FA46T2pDyer9ZGt2aDLO8
         T9bgUljmtdnODjqRu+rGckTwfqw10vqHAYtHkUyQc7CvGtcHD78Kch2IsQ5aK+mxVPGf
         nl6/TpTOT28F9sDSrYETCIJw3hmuUNQG6rcvq8tPovDRZsNFmBuKGOFRZ83GFZIpPyB7
         /sBssxVW4Y2TaPIPv8KynmHIVP3xa9kTJost2njeF7fd9sNtYL50yxFDlf2x9EH2MwIr
         xzkA==
X-Forwarded-Encrypted: i=1; AJvYcCU087j11aenNoS2hwjNog5N/CNAFxLLmfLeu2coBfZ26Zc0p4LmM6LsUQLnHhv9k+y52Og6Dy983MX+jce4tM8=@vger.kernel.org, AJvYcCU3U1U9QK++O1Coze9KJ2duT02f4t555P6c72s4QizCKp0B6O+0jrOY57uvJq8i3lfBu4JYmOVLEQxWAiQ=@vger.kernel.org, AJvYcCWkbA03xnWLOBxEy9yx5037axzEUuaiYG3Huzl4qRyacjyaXxK43Oax8vcEpxD2EVbr7G+jtmfJ/JD2@vger.kernel.org
X-Gm-Message-State: AOJu0YwY4PP1mUaPxXiA1aZAyTmyiRxlguSlD0IIPkjpLa+H7ZFzXjbP
	ZMPryilpi0TPm/GgNURn2rVh5WeRzI1IscWmHJupeapFmEclvQIe
X-Gm-Gg: ASbGncsCXpXwkx9q06clWh550RICqcYYZxAGQ79u4fgmiSIHxfryyosAZ8PODxeoU8c
	hTsnx/wUHuCtPz415eXFS83wwGfs5RToQvQiDIrhM9bzZV2Mvnk9GqSdwSm0t+4THa+AmNn/uN5
	hKdh2Ni5vbZ5I71NDqys02BoBVjtjEKmlR8g5CwoRrsZag+adXyNLYOU2dRnX339QFOOPCmmUqy
	bLDYXAcLoRybbWcEn4zRwkOPoIbtBCOOs4alAcyoCtMNEVtjjWwWVhdx57dur9PIWZbkEWCD+EY
	+OzSAjlCCYxffcq3EcLxvvTTz7kjvOkVQdX5cQSKhe0NIWsH75YfPxJYptJiAA==
X-Google-Smtp-Source: AGHT+IFFQbGuyHGDbxmZnvE7TtoQqlMptM6af/CxtRq0PDqB0wtWM621NnohNAdBvFkAmzbxIl56GQ==
X-Received: by 2002:ac8:5dd1:0:b0:477:dcc:6c18 with SMTP id d75a77b69052e-479600a2faamr24389841cf.14.1744193017296;
        Wed, 09 Apr 2025 03:03:37 -0700 (PDT)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:70db:4589:e2e1:f14])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964de11absm5149601cf.34.2025.04.09.03.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:03:36 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Apr 2025 06:03:22 -0400
Subject: [PATCH v2 2/2] rust: workqueue: remove HasWork::OFFSET
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-no-offset-v2-2-dda8e141a909@gmail.com>
References: <20250409-no-offset-v2-0-dda8e141a909@gmail.com>
In-Reply-To: <20250409-no-offset-v2-0-dda8e141a909@gmail.com>
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
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/workqueue.rs | 45 ++++++++++++---------------------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index f98bd02b838f..1d640dbdc6ad 100644
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
2.49.0


