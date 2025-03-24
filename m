Return-Path: <linux-pci+bounces-24581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4607EA6E5BE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 22:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998CC1893A6E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 21:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A5E1EE7BB;
	Mon, 24 Mar 2025 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh4KJPgp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4597F1E9907;
	Mon, 24 Mar 2025 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852043; cv=none; b=D/yS4gt6sSxI0RK1aOFRvfF9pAHuQgXxh/M1sO+yw2phbklLCLWZKmzYMttPAEEJrRDLRIg9XO7AApqci+aDt59sor2S81bcIixHYJLJQdtk50Vio89RosKkommgEg2stFpgNDIPgWlVLwPknntjO2OpeyAOejtnV5/L5Z1kTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852043; c=relaxed/simple;
	bh=UPIkAUVgrLgoo10ZulYm0QWcMYrd1P6bki8vAC5nVdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/P2gSIbPFEDJY4Q/2RSbVDg/mAO+J+BCzVELqfyMG/GADM8kK3tyhQkcoc8j3sNJf3s8G/ncQ8sYKH9aa72FSAUY54bkWAEZWLD06TRtl+bTcyE9kh+zMg1hqej1W2SwwC8/y45SUESx0cRW2vzAnDdEJDYeNsfvPmpnMcT6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh4KJPgp; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0e135e953so507067385a.2;
        Mon, 24 Mar 2025 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742852041; x=1743456841; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylNRb+T5+GBQppZT9y7HdwTw6rPxl9tLyEp3IloGtoo=;
        b=nh4KJPgpX/srC27VVQ1lD4cVli6e71PiQyNZOKH3ZfQF12OarbLzYc3dgKNiN12oca
         WB5r3nhaoM4i0Z0uWS6AgPiaBygwa4g1il/QqjkkepzAcAnuuzfEbTUbm4130AR4nTxu
         Jkqlfep0Tw+zP7gz2HW3Szm//9OS7h563E6ADSP5yaf35/PYdtZDy2j2KtFT8lKjhkTh
         dlvW7wnjk6ESbzSXbt3qsrB3CeqtfGDSCE3brFikcJpUcLOGpKrjnQFmxDPJ2KqyunKb
         7yZC8yGrsnbt68+KqWs7XqtFAx62jjX+7v0oqgSTyCcNoNyt54lLsaYkLbMMrSc6mOzN
         xwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742852041; x=1743456841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylNRb+T5+GBQppZT9y7HdwTw6rPxl9tLyEp3IloGtoo=;
        b=lLkU+08Gwze4Z5j5TGNXD/4AeJS64vGn9cv09slSFp9HcEmawWQBW910qy6Z+zk6t0
         StvJZmN/nCh8KrnLXxObXLA2n8UjKa95RV/q5ueQzEdV0T1MJ6tyRFX9CU16bU1T3Mqw
         o0LU2psYkcwNb0O1bzF3TkFS3KDXwZBcfnu4/sfRmlDavOIea7U+5Qk9S/pBXXEtUh4j
         pNP/dEmI7IpABL4OzrOVhmR8W6SgbZ64Xtf2M7kBpfo/1wJf6wZe91yulRrEEA7fCwCO
         0R2Q8L+wMxYBnKEqhiHP0uQhuGr9TDmXIu4/PN2S4BI3mEig0/wl115NJp/h5BF6jJ8N
         9DJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSYZZQ1CF1+KPEgKfv+BSOW08+wSTZVkxmyGBA5z2IR7ID1rRA4zZX5n+unavtNy4JUXS5hUz2uYHOMdo=@vger.kernel.org, AJvYcCXqD0pbaAWXOvDKD+DcaAD4GqtstxvDoFJ+amn9YA+nDyDzj76cb2IuxrkGn5+hX6ffTg6nRrvxpHsR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9FxNm3psWhgsVmxmk84F0WGQH36vhDVMoEl2xrsRQ02CmKtPL
	wq353VX1Qs0inlEPUS98clFHBj8O5oKGVF9s0P3q28bwobE+0N8p
X-Gm-Gg: ASbGncuSTqJJVZI5D7PyrGfMtmjfQ17c1Sz1GoE+GrHCGhygcsTjfYrLpohVbFlGQfw
	nXAHzDza/THqiYlA6jZDI2Ya7Wh+SDahIEswPM0N07MoG5JE+uSGhE80Qi5laUBjOB/6BPNl3HQ
	by+i7Yy3BxgCQrK79qCCdkeW4EqHMjKI5hRDKovUS3Owvof+5UW59bSWWmuuGiyW8JdaZS2WDdJ
	sZGeyg5mvRkyf36NTElhbnu/DvpvB2t+D+mEkaVDUmKjYCo2CWiMjeZXrW1EGoICHYb6ryrRwR1
	kQ8uFFeiVA+tyESPKKVIZoTO1zh9iM/bmo6d5/HggCubHMk94EEgPB8J+S22d7wk/aRpg7IKAU3
	LYarCetrfgvsH9bP1jm+RT4OeifChhbL+tcr5X+gU5korMa1pbyXcKw==
X-Google-Smtp-Source: AGHT+IGjgpgbERblUHABST7Ycy5fXnhiGKSNNWdan9XOoeRU1z/0D1Puc5uILKt0eD70cFsUQbS1/Q==
X-Received: by 2002:a05:620a:1787:b0:7c5:96a1:16c9 with SMTP id af79cd13be357-7c5ba13a4ffmr1948351285a.5.1742852040873;
        Mon, 24 Mar 2025 14:34:00 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:43c7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5d7eb96fesm63232185a.90.2025.03.24.14.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:34:00 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 17:33:45 -0400
Subject: [PATCH 3/5] rust: list: use consistent type parameter names
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-list-no-offset-v1-3-afd2b7fc442a@gmail.com>
References: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
In-Reply-To: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
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
the same name used in `impl_list_item!`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/list/impl_list_item_mod.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 5ed66fdce953..9d2102138c48 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -41,7 +41,7 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID> {
 /// Implements the [`HasListLinks`] trait for the given type.
 #[macro_export]
 macro_rules! impl_has_list_links {
-    ($(impl$(<$($implarg:ident),*>)?
+    ($(impl$(<$($generics:ident),*>)?
        HasListLinks$(<$id:tt>)?
        for $self:ty
        { self$(.$field:ident)* }
@@ -51,7 +51,7 @@ macro_rules! impl_has_list_links {
         //
         // The behavior of `raw_get_list_links` is not changed since the `addr_of_mut!` macro is
         // equivalent to the pointer offset operation in the trait definition.
-        unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<$id>)? for $self {
+        unsafe impl$(<$($generics),*>)? $crate::list::HasListLinks$(<$id>)? for $self {
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
2.48.1


