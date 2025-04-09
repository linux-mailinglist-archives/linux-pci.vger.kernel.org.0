Return-Path: <linux-pci+bounces-25578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA15EA82991
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 17:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790C49A00CF
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A9026A095;
	Wed,  9 Apr 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ7Qcxgv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D41269AE5;
	Wed,  9 Apr 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210289; cv=none; b=J/Q7ksrSfGuH8ESRJ4+oqAJeNZl2BS3RlhNMLY01lay//eZvhPgK95OrXqXToAvUVRhdzJFYDsmcqzvUnPJ5Al1iwCaZaH4hQtazIdRxdtwskm/xUS7FSTkrvGfHcwmm1we3fLIxG/tMsLToYd5RGuNQV63Lp6hFjZvODOY2eug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210289; c=relaxed/simple;
	bh=cxq8SQPIttegAQ/VdXTVQPKMu7L6YbwbWuqPynYdF28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CiC8cDqw/hn/jLHDw3f+7VcAjnXCLvGFc7d6DHBYoAXBOPcReqL9mQHziQ0SpnKI4DGNtUlwxclAnax7hxS8bQRm5nTpyMT4Lx9BpWiUbTBNnYtRT+sO1ENivXeFpm6XgCQOjytUgC6McbQ6leQuG56DQK65Jlte3A6t2ecUWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ7Qcxgv; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8f6970326so66504436d6.0;
        Wed, 09 Apr 2025 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210286; x=1744815086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OzkWd7763iU7orIo6m7aRkDgbxfxBvtpXsSVHS4Bj8=;
        b=IZ7QcxgvfN2IlTU6XeZqK4+ZXl9JcYgRNbVG6Z1E8t8S438kz7d99ERAwOQifFcF2Z
         +smL2/A6fruj6O4pn0o0n7z4EiDIznC7D1Othm4qzhTKAdbswZ0Rg0BSXImItrSPmaAm
         7tV2T5sY9zUz+TB4EJMILfELYVvnSrISzfttwoVVQ1SmxDgZlfXgAsPxOs/U430kxSeU
         PbFDMP+N8baiDw1Tgus9cK6C1a6ZbibBmGzguyfouFlozxNhfO10cU3w8OZ5N2+moQB8
         1h+3ol2QDczWqo9zyXCQ8S0Z+L8nSEf/LyZfeXzv/42DxBTpvXS1YhHqRWE1+IaUUYMA
         BnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210286; x=1744815086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OzkWd7763iU7orIo6m7aRkDgbxfxBvtpXsSVHS4Bj8=;
        b=IywJ4wHJ1iLY5d/eGnwggY2TLesrzCpRmT0038lncfUrEX9Cjs9E//ZaWOszqevZnz
         myaJDLYbCULt9nQpTUOWgzj6ftW/iHJaED9vi5NqFaJ/opkxl2XGfcHHckypICoILlR6
         QcIhPgeFVkqL8MAWF7rKx5M3O+CF9FQWQd5PGcsOiy9x4AuopqEkduPiMNaDjsNDghE9
         0JEbzUO0zTQo1nKVr8raqsGUYgLFz/31jDGkC6rG9oPiDpVUgTb5qLUyftIfIuuW9Ive
         HuqhdOqYbEwnguAtZmb4jnyrGGRukJ7qmyo+u9W2JyKFb5VozUmaaNczwMoxzFkkF64u
         Gl9A==
X-Forwarded-Encrypted: i=1; AJvYcCWKl5wi7RgWK/m0UUbZfb5y0KL97cbBKY/uUvTjSRGOThcU4GzgSF0er/Wo/1cehViwDaIkBqWT1X+T@vger.kernel.org, AJvYcCXP24iovXNVI4CHq9UZnJe01kunTaia0OhCh9EJEd9Cqys0UHM/qcTDDFqotvGZF0xbGrKvZSDDcKQeGZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJXWs1akP4bOvgihZOz6o+xbycX6qydGtfsxYbdUZ69+iSYrM
	g7KB9I8CYX+LMDwWLcoxb6tEVtC/tAdwncxiA656LxvBwI2i32bS
X-Gm-Gg: ASbGncsPrzbb637wmB+aAXr9QIkxYXjnnlRiftwG2Bts7UQq1HXZHX9cNdGp2/HcRPu
	E3FlMPbtGSGZeI8ZO4tfb9HxiYnUxYlGlKZ1t5kvx7oy1okFvZQYTRonmYAINnVnN0PLQLZ+PVR
	lM6Gkc8U39gh+nCEqI1QR8dsfw1Fc1riKF6aqJpXCdgMvIrjeetaDlQZWXldWq4WB9iOTG/yzLe
	Up/L7f57/0cVZ3pwcUKRl3BTQBweMoCJbP5Rv/DnYDkP6yAjjrqwlDG3G0RNLFxJCHVjlR8X0Vz
	AGP+bhe3++nHh8Oz+nzZNYcFjh2sKktgfocq1pDBNZN54VkDNlyg4zR5InTaPOu3AYILzE2ujcs
	0wO7Vfrx7GlMYZ8JMGVS3gyOb7RHvcIvBUTDx0fhHZaUbHdfvOCsPTRQ=
X-Google-Smtp-Source: AGHT+IFEgXOQQgDsZwCtINEDiVAbz67PVXNc0OsrH929ybBY44azL5LL2jW8hqyUIGciSgHdrSaxhw==
X-Received: by 2002:a05:6214:19eb:b0:6e6:6599:edf6 with SMTP id 6a1803df08f44-6f0dbc6b8acmr52816466d6.34.1744210286195;
        Wed, 09 Apr 2025 07:51:26 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:3298])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de95fa89sm8229876d6.6.2025.04.09.07.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:51:25 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Apr 2025 10:51:19 -0400
Subject: [PATCH v2 2/4] rust: list: use consistent type parameter style
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-list-no-offset-v2-2-0bab7e3c9fd8@gmail.com>
References: <20250409-list-no-offset-v2-0-0bab7e3c9fd8@gmail.com>
In-Reply-To: <20250409-list-no-offset-v2-0-0bab7e3c9fd8@gmail.com>
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

Refer to the type parameters of `impl_has_list_links{,_self_ptr}!` by
the same name used in `impl_list_item!`. Capture type parameters of
`impl_list_item!` as `tt` using `{}` to match the style of all other
macros that work with generics.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/list/impl_list_item_mod.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 5ed66fdce953..49f5af12e796 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -41,7 +41,7 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID> {
 /// Implements the [`HasListLinks`] trait for the given type.
 #[macro_export]
 macro_rules! impl_has_list_links {
-    ($(impl$(<$($implarg:ident),*>)?
+    ($(impl$({$($generics:tt)*})?
        HasListLinks$(<$id:tt>)?
        for $self:ty
        { self$(.$field:ident)* }
@@ -51,7 +51,7 @@ macro_rules! impl_has_list_links {
         //
         // The behavior of `raw_get_list_links` is not changed since the `addr_of_mut!` macro is
         // equivalent to the pointer offset operation in the trait definition.
-        unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<$id>)? for $self {
+        unsafe impl$(<$($generics)*>)? $crate::list::HasListLinks$(<$id>)? for $self {
             const OFFSET: usize = ::core::mem::offset_of!(Self, $($field).*) as usize;
 
             #[inline]
@@ -81,16 +81,16 @@ pub unsafe trait HasSelfPtr<T: ?Sized, const ID: u64 = 0>
 /// Implements the [`HasListLinks`] and [`HasSelfPtr`] traits for the given type.
 #[macro_export]
 macro_rules! impl_has_list_links_self_ptr {
-    ($(impl$({$($implarg:tt)*})?
+    ($(impl$({$($generics:tt)*})?
        HasSelfPtr<$item_type:ty $(, $id:tt)?>
        for $self:ty
        { self.$field:ident }
     )*) => {$(
         // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
         // right type.
-        unsafe impl$(<$($implarg)*>)? $crate::list::HasSelfPtr<$item_type $(, $id)?> for $self {}
+        unsafe impl$(<$($generics)*>)? $crate::list::HasSelfPtr<$item_type $(, $id)?> for $self {}
 
-        unsafe impl$(<$($implarg)*>)? $crate::list::HasListLinks$(<$id>)? for $self {
+        unsafe impl$(<$($generics)*>)? $crate::list::HasListLinks$(<$id>)? for $self {
             const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
 
             #[inline]

-- 
2.49.0


