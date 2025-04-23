Return-Path: <linux-pci+bounces-26564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FADDA9953C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7451B85627
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4596E288CA5;
	Wed, 23 Apr 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POP75IdI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE63288C80;
	Wed, 23 Apr 2025 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425817; cv=none; b=t8EVQbnJsAJ2po8Fi8vgOocm3LmllVrLqNRuD6MFDnl2ZjZxM87Xx7AKdFV9Uj29s8rn3mRccTFTEMMFVFzLoUrf8BvZbKf7zzO0amOiA9VyrkzDNY8NRceU3KDqA50ZSMgESsQvY9heLbIkDoppYv3OlA6wp35awOewpENlkxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425817; c=relaxed/simple;
	bh=DFFkISZ+wsor0lGXgM1JwIFeqscLbz0j3F8wFkfSE04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfG5yH+c5UDyRPB0dvcJkTZXU11TIx35v4C0t3WcCxMhFgNsl59T1Gj0t9Ey5+hP43SBPqoLlAmyGdUTO2INLH2JOEKL6xJp1ixwDl7Nq4UP/OHMsq0Rj663pDsEEgl/Y5rxeTpFm9at5skCGNdQDx86jwNXg3BkJuuXqSqlSlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POP75IdI; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c9376c4dbaso8904985a.0;
        Wed, 23 Apr 2025 09:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745425814; x=1746030614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0ja/1pV62iEC0nEku9AQfzl6u3YciLHVA48FbywNX0=;
        b=POP75IdIsAqLdw2pCXZeBex+4HNrD6SyyMmiSgJaxDV06UXtiNPuRfRFiN3Tn2t6JZ
         lwwVApG25CgTRbezbBbu/VtV1TJmPpl/gmnzBsWyZ3NfQ/0en6tfdVcCy76UDLrbYd0e
         vl+TzAaB+86ANuvEMof2rz5LLBwRqcSLPx9eLZ+QByr9vq9mcm7OkiLRy7pwDrwCu89Q
         LnGv+o6p4PX6NgAN6e0I/PP4f+i7c7StpqNo0QskZoOw/qz6ivU+C/w4TdYJQq2nQ5WL
         6oEu6Mi3npxhbabepjaPKmwjqC1QARBzpJ6tiMyHxzNVwaHOd5mzO+BTdgQexOzPj3NR
         Dk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745425814; x=1746030614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0ja/1pV62iEC0nEku9AQfzl6u3YciLHVA48FbywNX0=;
        b=Wlxv+i66iCWyZen06MStBsZxsORXW5HnaGjQtiV3fgiV1T9bMdrJb0JH/S0I8NG37q
         OlG/VxwEHcVWOd197zNVookcmaGZ0WZ/wqc6jhTkiKXVrduHWuL+ngA3Y6GOtmigZOhS
         yNqxjCGmsJAD8tOF8AFiK6QXr27S9kFU5pt6ZJffbwHMSsqhKSnL1XaE6QSO3t0r/f6g
         l9YhbzOp5GL/W51psSbPjwT8tsw3AFiynLgfQSmOe4rhxFvNKKXIfUWfvl6clfx3onfc
         N3syMSYPizBgEP6zRVqdiRh6YIJstwtx6+HNrQ3Lb269B+FOjMmCaIMgj6eTR7Eg9/b1
         AgjA==
X-Forwarded-Encrypted: i=1; AJvYcCVk2/xW+xWclkeOdHdhvmKeBsT6JaH5egkiXBGx8mxbrTAlFF/0dVTPAoV0hOizVs+POSoCxtJlZH+0@vger.kernel.org, AJvYcCX0WPRJo2rkmuEABT/l/1Kr6+qlvcRa3ZGN6baHD2d4KOhSYefs6B6soiDcxRxRCrd56Pf/nZl8xWly4Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ng6rAkQHJvyWax4LV9HLnEs04jVFGx7XUCJOvqyAz6nKvd+X
	9SyZmUz94z4uVqJsvjDICIVN79L7rRkbFNnt8KCMSzWcrpq56BBEkVBgfOADc94=
X-Gm-Gg: ASbGncvgxoVGOmRXHNlJQ10GSPdfN6Ikg9E8Dugj2N11HQvVefU+ex29rte6mdmLHRD
	KX5Bg4tySqqfctd48GUMfDD4z7R9ANLY3GL0eJrvoafaMqSao74VZ5ULZ3RlXG4Uwwqb0C1gTok
	kAjaofqXObzAQgVmbGJa7D0a5g0XMEqNp9N5fPxOsRN0jnsKYB2Od7fHEtZA3g8kaoHcxoccTDM
	G8peyJ///g7sZsDhLr1gG4jE68R73ZkCgwOsY2j36ArpwvlxaVAglpWI0Hcs5O4njJKuomc8Drm
	0ZBVEU7q8xhwmDEc2Q7ZR0R1mA6b7ivV8/Yfg64lnZo+Fu1Vx0/tgmt7ZTG7wPcqrorVLiTmu4/
	cd+JUE2Fq9p/zoEqDtzbpaaVWShGmqzu4OS2IMo55NqfI2Mw4sw==
X-Google-Smtp-Source: AGHT+IF5nP6uIzCJ30umK2Oe32c6tsM0b+7FfAl7tqdWBVvzvhSqUHfBW0bTdBQ9UcSX5b5SX5lr1A==
X-Received: by 2002:a05:620a:290d:b0:7c9:1c6f:b4c8 with SMTP id af79cd13be357-7c94d847c9cmr636861085a.15.1745425814007;
        Wed, 23 Apr 2025 09:30:14 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:e2b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4dac4sm698031885a.86.2025.04.23.09.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:30:13 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Apr 2025 12:30:02 -0400
Subject: [PATCH v3 1/6] rust: list: simplify macro capture
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-list-no-offset-v3-1-9d0c2b89340e@gmail.com>
References: <20250423-list-no-offset-v3-0-9d0c2b89340e@gmail.com>
In-Reply-To: <20250423-list-no-offset-v3-0-9d0c2b89340e@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Avoid manually capturing generics; use `ty` to capture the whole type
instead.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/list/impl_list_item_mod.rs | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index a0438537cee1..5ed66fdce953 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -43,7 +43,7 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID> {
 macro_rules! impl_has_list_links {
     ($(impl$(<$($implarg:ident),*>)?
        HasListLinks$(<$id:tt>)?
-       for $self:ident $(<$($selfarg:ty),*>)?
+       for $self:ty
        { self$(.$field:ident)* }
     )*) => {$(
         // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
@@ -51,9 +51,7 @@ macro_rules! impl_has_list_links {
         //
         // The behavior of `raw_get_list_links` is not changed since the `addr_of_mut!` macro is
         // equivalent to the pointer offset operation in the trait definition.
-        unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<$id>)? for
-            $self $(<$($selfarg),*>)?
-        {
+        unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<$id>)? for $self {
             const OFFSET: usize = ::core::mem::offset_of!(Self, $($field).*) as usize;
 
             #[inline]
@@ -85,18 +83,14 @@ pub unsafe trait HasSelfPtr<T: ?Sized, const ID: u64 = 0>
 macro_rules! impl_has_list_links_self_ptr {
     ($(impl$({$($implarg:tt)*})?
        HasSelfPtr<$item_type:ty $(, $id:tt)?>
-       for $self:ident $(<$($selfarg:ty),*>)?
+       for $self:ty
        { self.$field:ident }
     )*) => {$(
         // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
         // right type.
-        unsafe impl$(<$($implarg)*>)? $crate::list::HasSelfPtr<$item_type $(, $id)?> for
-            $self $(<$($selfarg),*>)?
-        {}
+        unsafe impl$(<$($implarg)*>)? $crate::list::HasSelfPtr<$item_type $(, $id)?> for $self {}
 
-        unsafe impl$(<$($implarg)*>)? $crate::list::HasListLinks$(<$id>)? for
-            $self $(<$($selfarg),*>)?
-        {
+        unsafe impl$(<$($implarg)*>)? $crate::list::HasListLinks$(<$id>)? for $self {
             const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
 
             #[inline]

-- 
2.49.0


