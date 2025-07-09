Return-Path: <linux-pci+bounces-31803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AA6AFF1E1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 21:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1A316340B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 19:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D4F24466F;
	Wed,  9 Jul 2025 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKao+NZb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6E4242D79;
	Wed,  9 Jul 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089482; cv=none; b=ZzebjTXUpUxJQs211CGpS0eYgJ1b3OHdtdLscXBAUGOhy0EDuZDNwcGquiGrcQQLTCWHNeaaaCKcKuMVxqCmIlX+k+6LVncWWAX1TrLgJ5BAdE/wDkHkNbtnnAmdLFvX3He4GEMn+URk35+fUJJPq89JdYTM/3/lE6gh+z/hSD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089482; c=relaxed/simple;
	bh=rfVTctJezhzHZeEc5LPnMWXQzcKkJ7KvGm+Y0/Cjgfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFJ0XWQu8GZ7kUk8/KEpr9XtzrKgQGzHC27XF4/bEHOOGQSVp+XjmHLvUyc+CObkNVL5ifW3afnABpJuh8JE10iXZstSMj8JCf0/3fT0W04bX3HxuvvpAgQzV2x5MRb8suaHAqcJ6JyoWYKUeEs+724JrF1rY3Ls+QBJDWvCouY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKao+NZb; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d09f11657cso27771185a.0;
        Wed, 09 Jul 2025 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752089478; x=1752694278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uU1W1AJg1khtiFXJRn+2wHqncOyahEVL95tTLku4mAQ=;
        b=kKao+NZbdUgpBhmC/pZ85COgnCAr8OW+zBcBRXnTmaO5Y6m0ay3ukmRdvuuKx8JcMX
         /Y4bmvD8jdobn7cVQ23laGyQa7D0bFWiN7LHsV9C3GXgHKINqbqJZDZidrGG32C7sZ00
         Tsw/i6vswWOcsyD704iMqLVIuxyfP1V4gw0200yGGrcIXjC6OUZW3KKM6oabngENjS5C
         Q5YIeXdyd2E+OJXFXyxM2STOT6jjxSryrQPKdF3hBs/8B4uFEB7ez5cynx1xo+bvhdaf
         igd/1VJHiIOqfA56giNDwLsGXL5yIm9dhId7Ez0/LRnFBEB8CQAkwY2Jksic5zaEqcL0
         rxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752089478; x=1752694278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uU1W1AJg1khtiFXJRn+2wHqncOyahEVL95tTLku4mAQ=;
        b=eHpcX2F2xDYj/9SptGsAY29fbiLPZdk5maDdqOuFhcPVsByDvOiGVmkehAS67zNf5x
         Ie09m/X+TFFB1bG59W5T13L/T4/BUBfi/YWp4rsto3hL3Nltp+5f02gQkAZI5dTb2iMQ
         j9lbiziWxvOkh4pyuO7ko3LbOSoz5FjM6ncFGeGREebdghzBVoodZuysM35Ia983Iqv6
         595vmDMiZmo7N+nDH/lQZWI+k68QOUoiJA7iT/ZxrwuZWh15bRAcaIrCdyJL2GNUp8a4
         vdrEiPu1M6sXcBIKUPlBAhyNcRCxMXNBU//W6f28JREGt3StmqNXv3OrPSbTMi1WPdd8
         TnbA==
X-Forwarded-Encrypted: i=1; AJvYcCWsQYrTOsbM806mvwPAH1wIgf/ZFnOt9lZa6cqFcCACfHvQeledcbykzp1yZGzur/5bq5cSrgysmS2v3H8=@vger.kernel.org, AJvYcCXC4aDcB0WDLRkoDOMjJ54b9JSFgssDCFjCUTpdSAXAI3Pi6MNLTIgfFTLpeGcwIwxtxP3fU+PdpYms@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9vjHLXmWwgPhexf/03qxStVHJ3pBavLy0MaY4Yj1WWFlU/Uv
	JFfnNhe3OIHd7FvW+lvqdMo+3BVuEnt3YVHoadtcY4eC/cbcWgQ7YHWZ
X-Gm-Gg: ASbGncthBwTHrPCoIGZOFivqGPtdNedgCv05Y0o1QvD3Wbj4wzyntlHgJ50D3dHXlNp
	fJVUK6DJ5VqPqt++pUg9OviEb7Is1ZCsR2K8OnM0xm0ifsiYG8I3b7kb1acYewbd14pYfG6/L3P
	ysl1WtdCDb4W3ELxP5s1CqUmlQzjWEs1v5Eb2uCWW1v0tba3fr68MMfwSHjFptm6MVgcSHNKw57
	GhRVigk2tI1/8fceOyc+6x2gXcKg+vYt/acyJgzI2XqqJZNGLk4wwIo/tevN22vk1GSP/GC5v4S
	Iy7gKIf1VlTelFuzBVOE5FrTMnIdgKh52cOJihxL7J++WmNnZE0ADh7VYoHtyEXm9UEXJcx3jU+
	eggesiNfWl+wW4n+QtHK5sHe/7K4u4dTWMtg6FEdRV9GGWNy9URkONgGf6g==
X-Google-Smtp-Source: AGHT+IHtE81Yi1qqk14P+6gFZL5CG2GxZBneBQnMHdbbF1n7EJNN9SgbLROegV+i4KvIoNtw8epZRA==
X-Received: by 2002:a05:620a:2983:b0:7d4:4e61:4673 with SMTP id af79cd13be357-7db7b121330mr593331685a.6.1752089478056;
        Wed, 09 Jul 2025 12:31:18 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbd94242sm991741285a.9.2025.07.09.12.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:31:17 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:31:12 -0400
Subject: [PATCH v4 2/6] rust: list: use consistent type parameter style
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-list-no-offset-v4-2-a429e75840a9@gmail.com>
References: <20250709-list-no-offset-v4-0-a429e75840a9@gmail.com>
In-Reply-To: <20250709-list-no-offset-v4-0-a429e75840a9@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>, 
 Christian Schrefl <chrisi.schrefl@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752089473; l=2752;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=rfVTctJezhzHZeEc5LPnMWXQzcKkJ7KvGm+Y0/Cjgfo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QL1ZR8D35HlhcB8KU6JS+PqXmdvxlK17TMj0KLv7v6m4hGnzFRq5ijCNp+ca9cdS+ZrZ+xAjzcB
 d6c4smvwgmgY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Refer to the type parameters of `impl_has_list_links{,_self_ptr}!` by
the same name used in `impl_list_item!`. Capture type parameters of
`impl_list_item!` as `tt` using `{}` to match the style of all other
macros that work with generics.

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/list/impl_list_item_mod.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 6bfa59fde17b..27feaf849c48 100644
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
2.50.0


