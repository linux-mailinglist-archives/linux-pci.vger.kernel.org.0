Return-Path: <linux-pci+bounces-25577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CBFA82989
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 17:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2723A3BCAF2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA95269B0D;
	Wed,  9 Apr 2025 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dws3JxN4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CA0268FC0;
	Wed,  9 Apr 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210288; cv=none; b=b4aLYzlenybeWQd2DvX0GZvHLMilwQaxCONPu1fvyRk/9vq4QFShwNx2NzqE0yG7lDWwSUh+hPw55Gpt6BKVsFtWayO6wJhXgnZhiTs1KOh7iWk6VfTPaSVdd45kguKyIDS93+OJZ3YIuiG57YCXWuIBceLm9ayYv5gQLAVVkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210288; c=relaxed/simple;
	bh=DFFkISZ+wsor0lGXgM1JwIFeqscLbz0j3F8wFkfSE04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nfxlyR491RpFh4bWuQdb6zIOFK4OkqJsSEG7ewcEQa2A8PLwpH6sEqTHlwpGMc+um6Xyu7aSqH29RWKW2PFl98CEXGCL211uEA+oy3mmYnaPc3Ifdj1ygkatCEHmxqV+/DrnbkEir5mS++5tj0WeQZ0uVQ3AmvHvA/QVJPGYwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dws3JxN4; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ecfbf1c7cbso115910456d6.2;
        Wed, 09 Apr 2025 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210285; x=1744815085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0ja/1pV62iEC0nEku9AQfzl6u3YciLHVA48FbywNX0=;
        b=Dws3JxN4YnaAoDVUe15pPltpw76qlaYvTnT/xwI1hHfPVDXUW4TKsIjs9PP+TDhUhO
         Uzywat8lcaEmyyuFwmsprE63EuO+BAfhsq7gwDYPdemSCXO+zhMLGZvKloO19i1jSlft
         VNmq2reRRMxc8PJ9WeiXdlOiGV1NOcdnmVrxSkFn7eyXJd41ywcB8Y0LQbOHTMfZ1Nw9
         +AX2U/JobAjW1H3YUjfBkJyL6vXkiWDMW68ahxe9QwPe15YOd/IQUid/vI+SI/VgBa7Q
         kOOcZ7LAQG8O5YJrLHRcgRh8GNB2cKZX3Dqix5nr72/WPeBEmj5uyGw9I8eVrYnNBqaw
         GeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210285; x=1744815085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0ja/1pV62iEC0nEku9AQfzl6u3YciLHVA48FbywNX0=;
        b=GomDCVn+d2+WPYV2JQFn3aOV4Lf5hiqZSojBgkSzJqZGTbV05bl5Ca+Rjv2pSMInnj
         ym2EDR+qeBzwsRRTGg+OPITKeZrFvYI407R+HvEginnXQhXgsTXlw7wst5tq8IuNLAAl
         MwMo3EI8qv55shdIwL98pJYQ6KjAYNRKjm22gS93iZ87G1FeHIlw41uDLzDefaD98JzL
         3aYQ5D2Iiy69Twdl/XksZLD72IBuWr7NBUOUKATwqKtUNud+Kbk03trnIDMZdOzkctzo
         bVloixoO2lKAxMytOSS5KTNAKM6ZS2SM/LpGE6VIWbmLGdO1MjJx5L1BZSMwR6vaLYZC
         5/iw==
X-Forwarded-Encrypted: i=1; AJvYcCU7N8XbKqw9/8VUG378eUu/TlH0XqbTU74BnGyi7YPvip6jXy7QILpFf9fD8QyRLml2esFTfcAq6o/WMjs=@vger.kernel.org, AJvYcCVRSG6GggeHmLO6wCMV5nQMGVqI8NNf7iL03kjJpCHdRNwzq/e3q3Dgad4x2NrgqgrwOsYRjpgZXOL/@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGYytL3kNwYyyodthHpkUDRxgEN35GfJYnsH/yq8Ywn+7bWcy
	O+FwZM2j08Pu3mKu834ATy44cl4Uqo5dUewFAjSSUCFbiwZWlciH
X-Gm-Gg: ASbGncsQPXkKmoJiZUDFgyHIKhgtZyBMYsaMNkNlv6RwyNq8bdkQC37WjV/6sUIlI3v
	XeyQUxAPl5j730R28Me+Qs6nXiwpQwtjvklAFfgcNwk+JlB4e0gdc2iQjUM8dJgkskaeMiTMdMa
	t6iQJfdC+lXIzQW8qvce5hOd8Q2TLxEDUVj2IzGZF3jru6Kzj/KkLz2LmqaEMEYxzm3L9mRP+AU
	pFidkhZe+Arq6LzAhA3zN0zPZBFf6LoAIEA7YDe0GO2bpZ7vuJVRvle3KfrxaQiA9ESsLlVlRih
	6VaB+fypUeRhKN00YjS7AksLf5iwtc8FYrEUJgynRW/0i5NG43qkLreXc39cKTqxaLpyewveoJa
	2bZg3x8hsbb05KgUfsFX5mZ+O96cpg3+jz+I7BKrS57+J
X-Google-Smtp-Source: AGHT+IEoqYByp8TMre1nNThTk+9dqK44uGM767j00gxMWA5q6hplDrtk8wvCSopcREYhktQu0jwyvA==
X-Received: by 2002:a05:6214:5016:b0:6d4:1ea3:981d with SMTP id 6a1803df08f44-6f0dd812473mr32099266d6.43.1744210285131;
        Wed, 09 Apr 2025 07:51:25 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:3298])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de95fa89sm8229876d6.6.2025.04.09.07.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:51:24 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Apr 2025 10:51:18 -0400
Subject: [PATCH v2 1/4] rust: list: simplify macro capture
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-list-no-offset-v2-1-0bab7e3c9fd8@gmail.com>
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


