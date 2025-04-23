Return-Path: <linux-pci+bounces-26568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 977AAA9952D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D7F67A4885
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DBE28B517;
	Wed, 23 Apr 2025 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7GtwgMY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454228A400;
	Wed, 23 Apr 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425823; cv=none; b=U1FUCtaNOV65x7OzmBRpM+e/A9fKN0f5fm3VtSxeTya3/iLCm+wMpdkRpZIeyL/bWwYyQ+rEkLV6typ+Ez8XIlroSr1NYRTDdktTAjt125lwX9LkdtK8gSJVDcA1AAwnOcWPFRQfwROpL2AFQmegWg0edKbe/vvJCxyQEnCastw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425823; c=relaxed/simple;
	bh=oC9GSUWu8OINt1fRsLE6aTBmh2JsdHw6jkuHGO53X10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQcy3JYOXRelci2TDGy0ezo1HtqsVSt+3mqVnemF03ZfgexGE98YEjPl1O/v/NLq5mH3GY5LdPqmoFJi39lysr4ddz+Q/EmZmFd7cfD8NmOWz5mdDfXLcZqwWO5YfI5dXcvyRNEeRAfUaFSiRT3TCbEuwHFD0hu62U2J+7jGggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7GtwgMY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5b8d13f73so4153985a.0;
        Wed, 23 Apr 2025 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745425820; x=1746030620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGa2aKYjlBBrJsbYdL5QXxnaufaMMv87SoV2X8XBVkE=;
        b=k7GtwgMY/7J36sHdIKpHZOKG3FsrjKfT/lCIFkhzQp8/vgityumBCttHUtTKEMUndF
         rkvunjZz+PmFZ9ZdkTsIT3bsGEM9/3iEn03mUAptu/GGwqYFIk8CuHYgxOr2O5Dez+0E
         bDn5i5umyRPwpjk28F0gBlrkFqNfwzTD6aSjorc9LsnvROMl1Ftna9hPHIajv51VGthH
         +/RgP2R+2K0KtlA+hQkXVScVPECeDDc0IC/3XQ27c+E9G0TRcax+kue5GfZfq+TIYWng
         r9//Z+pXN/W3r4PfbW4Ivy5ImaKAOKO7dvMDWEU5G2f6Vzg0C/L1n6rPqeYCM+zvB5iP
         auPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745425820; x=1746030620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGa2aKYjlBBrJsbYdL5QXxnaufaMMv87SoV2X8XBVkE=;
        b=qaFMu/AgJscCEVDvzhsyeVhrZ5IJL290D14PuyU6AQKJx4MAatBvNYCD/FF3gcM5wM
         GLLQwYfEZIEn9P5bwOwhHxe1d8a8m3q2G9IujSqw5+n6gDkGf/k8Sd1fSLhhACQSHuul
         L/0+FLJWtW5jR/4h+LgjevCEFDkjlM/PEosHTuyFaWbqLHd1rbpIbcPcOFhwB8d8L8lm
         R0Y2ZYbH0pdjGkJmUWOwUYmiyXjDG+zssDsp4F4mK4uyQhrUPYvsXvWSC+KULYSn5jQx
         Z6bAzOkNFEu4Y/UtOzPoquYY+SI/q8vMy9uGigBOF51P0SX7UIFQkOztwN9A+Cqg2DrM
         EZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHXgBKpWZBgJG7NFQWTcywC9TM7BJM76R3qtoJT1JAcOWR+ShHYh9mR3hBJ/mHxj+Xh++6sKEErHqh@vger.kernel.org, AJvYcCXnSHAlEONhE7uJ09ogCv6hWFEEEIBEnauVjnC4qG2PbilkMKu5HHb6VqpkplVKifwVRPlfAKjfwiqaKeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT7DTvZl+grDrFXAc6wu2JDhxrkhDw/BxuDdlPUUTSRG48B43e
	AYVKlSDPIzgrzL3BNsjz0LFKZl+75B5D4SC36Z4T0pX1ncHovDul
X-Gm-Gg: ASbGncs3SKBmPCjXbrMTQ/pf9g5VAwGmmwkcGVmuX6jgJWKq7v/aVVADcUfyaMsFRuJ
	wLFWPYAjYbCv/4xbg+0tjWrqlhFBmvOM79yWFjlQb8dPWSGrkcuWEPSGcKqkAeYxxc8OKZ/PNu8
	zL3zl1cSEmnjONswF4sW2+5T5caVbnJTvb7L4FBRMnsM9UKNrFTF80bA2nhbxNgLLm/P51Wy6wM
	4SVJmPF4Zg80qvrUlPICH+vnnOa6jLAlbnAfa5EJHpewlOOl1B+E2GCqEWsuEG2cI/Ndew+0ZtJ
	6ulpjvTE/gHy39QKXAzdsnzV3OSUYjCn6TLTKxlRnLhXvw9/J7ShqQxMn4A7Z9i4siIMm/xGsPT
	G+hmfuEHNEdRpHdnQTDoMIikhNh6u9z6SU1JHcRfFNjJ5H7zHmOtFlQo70xh5
X-Google-Smtp-Source: AGHT+IH3vxVwQbj0XnI60Kc3pobJn8GMeusMuZFoprPcIJo4uYmT99dJlqh1I5bFE1s4YoHZSqb4eQ==
X-Received: by 2002:a05:620a:288b:b0:7c7:5b32:1af9 with SMTP id af79cd13be357-7c927fa1549mr3517656985a.25.1745425819777;
        Wed, 23 Apr 2025 09:30:19 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:e2b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4dac4sm698031885a.86.2025.04.23.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:30:19 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Apr 2025 12:30:06 -0400
Subject: [PATCH v3 5/6] rust: list: add `impl_list_item!` examples
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-list-no-offset-v3-5-9d0c2b89340e@gmail.com>
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

There's a comprehensive example in `rust/kernel/list.rs` but it doesn't
exercise the `using ListLinksSelfPtr` variant nor the generic cases. Add
that here. Generalize `impl_has_list_links_self_ptr` to handle nested
fields in the same manner as `impl_has_list_links`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/list/impl_list_item_mod.rs | 96 ++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 3f6cd1b090a7..df21070e1cf6 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -82,20 +82,20 @@ macro_rules! impl_has_list_links_self_ptr {
     ($(impl$({$($generics:tt)*})?
        HasSelfPtr<$item_type:ty $(, $id:tt)?>
        for $self:ty
-       { self.$field:ident }
+       { self$(.$field:ident)* }
     )*) => {$(
         // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
         // right type.
         unsafe impl$(<$($generics)*>)? $crate::list::HasSelfPtr<$item_type $(, $id)?> for $self {}
 
         unsafe impl$(<$($generics)*>)? $crate::list::HasListLinks$(<$id>)? for $self {
-            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
+            const OFFSET: usize = ::core::mem::offset_of!(Self, $($field).*) as usize;
 
             #[inline]
             unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$id>)? {
                 // SAFETY: The caller promises that the pointer is not dangling.
                 let ptr: *mut $crate::list::ListLinksSelfPtr<$item_type $(, $id)?> =
-                    unsafe { ::core::ptr::addr_of_mut!((*ptr).$field) };
+                    unsafe { ::core::ptr::addr_of_mut!((*ptr)$(.$field)*) };
                 ptr.cast()
             }
         }
@@ -109,6 +109,96 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
 /// implement that trait.
 ///
 /// [`ListItem`]: crate::list::ListItem
+///
+/// # Examples
+///
+/// ```
+/// #[pin_data]
+/// struct SimpleListItem {
+///     value: u32,
+///     #[pin]
+///     links: kernel::list::ListLinks,
+/// }
+///
+/// kernel::list::impl_has_list_links! {
+///     impl HasListLinks<0> for SimpleListItem { self.links }
+/// }
+///
+/// kernel::list::impl_list_arc_safe! {
+///     impl ListArcSafe<0> for SimpleListItem { untracked; }
+/// }
+///
+/// kernel::list::impl_list_item! {
+///     impl ListItem<0> for SimpleListItem { using ListLinks; }
+/// }
+///
+/// struct ListLinksHolder {
+///     inner: kernel::list::ListLinks,
+/// }
+///
+/// #[pin_data]
+/// struct ComplexListItem<T, U> {
+///     value: Result<T, U>,
+///     #[pin]
+///     links: ListLinksHolder,
+/// }
+///
+/// kernel::list::impl_has_list_links! {
+///     impl{T, U} HasListLinks<0> for ComplexListItem<T, U> { self.links.inner }
+/// }
+///
+/// kernel::list::impl_list_arc_safe! {
+///     impl{T, U} ListArcSafe<0> for ComplexListItem<T, U> { untracked; }
+/// }
+///
+/// kernel::list::impl_list_item! {
+///     impl{T, U} ListItem<0> for ComplexListItem<T, U> { using ListLinks; }
+/// }
+/// ```
+///
+/// ```
+/// #[pin_data]
+/// struct SimpleListItem {
+///     value: u32,
+///     #[pin]
+///     links: kernel::list::ListLinksSelfPtr<SimpleListItem>,
+/// }
+///
+/// kernel::list::impl_list_arc_safe! {
+///     impl ListArcSafe<0> for SimpleListItem { untracked; }
+/// }
+///
+/// kernel::list::impl_has_list_links_self_ptr! {
+///     impl HasSelfPtr<SimpleListItem> for SimpleListItem { self.links }
+/// }
+///
+/// kernel::list::impl_list_item! {
+///     impl ListItem<0> for SimpleListItem { using ListLinksSelfPtr; }
+/// }
+///
+/// struct ListLinksSelfPtrHolder<T, U> {
+///     inner: kernel::list::ListLinksSelfPtr<ComplexListItem<T, U>>,
+/// }
+///
+/// #[pin_data]
+/// struct ComplexListItem<T, U> {
+///     value: Result<T, U>,
+///     #[pin]
+///     links: ListLinksSelfPtrHolder<T, U>,
+/// }
+///
+/// kernel::list::impl_list_arc_safe! {
+///     impl{T, U} ListArcSafe<0> for ComplexListItem<T, U> { untracked; }
+/// }
+///
+/// kernel::list::impl_has_list_links_self_ptr! {
+///     impl{T, U} HasSelfPtr<ComplexListItem<T, U>> for ComplexListItem<T, U> { self.links.inner }
+/// }
+///
+/// kernel::list::impl_list_item! {
+///     impl{T, U} ListItem<0> for ComplexListItem<T, U> { using ListLinksSelfPtr; }
+/// }
+/// ```
 #[macro_export]
 macro_rules! impl_list_item {
     (

-- 
2.49.0


