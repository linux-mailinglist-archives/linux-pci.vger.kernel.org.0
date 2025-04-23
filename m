Return-Path: <linux-pci+bounces-26565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DD5A99524
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5474C7B234E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8A2289364;
	Wed, 23 Apr 2025 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIVehaMh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B86A288C9A;
	Wed, 23 Apr 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425819; cv=none; b=AhB6fy5Tn2Izab9Gx/purRDU5XiO8UBK0zUny7D0NdB90y0/nR4t2Epb6jLuisyv9KHZ60pnd6Wcanl7NFdTju8o/smD4l6wJWnKnqd2QnGkz6WuZFluH7OGrJzWL+FvvlZFxqC7omUDRlnGCru4C3FFz1HwkeO3P8AT9FCdNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425819; c=relaxed/simple;
	bh=cxq8SQPIttegAQ/VdXTVQPKMu7L6YbwbWuqPynYdF28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QmVTaexD1z9B7XkMNq+EhuVQMh32PJ3c6werqqDD2feDNwGXMdaTLUOIC4UM6E6/QZZHnK5tigncJs3dN86JVu976EiOL95Wc095l8adtejCuU8zDDhyaLZLlJFktcAwt0Pn8hHqKI0UKEkqiwVuGZlM1jzHOM3zzR0d79ugPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIVehaMh; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c560c55bc1so736985a.1;
        Wed, 23 Apr 2025 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745425816; x=1746030616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OzkWd7763iU7orIo6m7aRkDgbxfxBvtpXsSVHS4Bj8=;
        b=IIVehaMhx1NmWJ3wSD/QwDC28TqHL63XgffwGOQLDpR3lZrRToK5uC//8TuUsrkmAt
         cDpxt8Amso8QOiEsWxF27meQLSZPkeu3TT6vcQBTy6mpW8n9afoTwBcQ+Bc7z9nKpLaZ
         hboY3Q9EzV5f8pLkGSq6BtBtYpLuwUZoQfOYen8ArZz+8g3b+SqOKeLgTLLI1q/rXqL2
         eQma9bGQPd2NP2d8D7JfMJqSUsvYGMZJp4V09Gn6IH5j/TNtMHkLS46xqMdFwTibSkPG
         4DpckiaRKuGlQ1LvdW4lriT+wFIh/toJv51ezqG6gz4jNVwJ35zdWQncg31pVlnissXH
         ngPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745425816; x=1746030616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OzkWd7763iU7orIo6m7aRkDgbxfxBvtpXsSVHS4Bj8=;
        b=vG88HictbgZnPoKTTVg77B8MT+LXO9erfTI3nrxr3e/Nrczer2vHgkUkRzU5h8GtYd
         6E3mhIZC2P5b1dJmvc3AyHfYSun8UzvO9IY0TbW4g3bx7U2yXUBMZ3yuWPmhgO3YOXrz
         uF58pURb+ACI+jvqMTcw0Koi9ETCHbP/Yby4CkD4KMxAHfGBk2l5K+I0vaeOIRRz9gJe
         rhRBa6EEwFv4fUpKRfzJFmAdD/Sd/U5paLkPWJgPsbd/FmL421MGMIxTBhk6hXxYaJz+
         UU5LFqlpPjlS2WNIBIW25l1LHrMjTZ78t7HwkYyaRrLbDH+ubU8eFHC5YB86ZMrOha8q
         cPzA==
X-Forwarded-Encrypted: i=1; AJvYcCU2tYLuuutc+B+VoMPkr3bhFtth02IG8+nH1GYXCkG9yu5WY+Wq/O4/ZildLWd7sAcH4U2sHXYTJ57I@vger.kernel.org, AJvYcCVnJzDAb/DuDXor1yE/Xon4mqGJBQ4gPdI0xEXC6rzU3SGuowpgaopM+xle4qd2RRyOl8nQIT4zezqr4GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwxQPUycN8cEUpkUX7LTDRQ4mQqqaUHzUymKhR7fL9DBXJWKms
	HJbBN0OYhvHxcrS6n2jP9zzXOVYybmS7yRNqjgES2XMq0i/cHcVY
X-Gm-Gg: ASbGnctVX+/n7fDYqmHmMuGagV86MJ/MXkr0Masy50TyD7uBno4hraljBYambg0wlQG
	UW+v1qfC1UKz4YeBgvJp3/29OrRF3QsNJneYiVhLP+yyc1VJAMV3waL890GQcVvtfSSnBlPpktT
	yUeNoWIERAflzK9dTQD89d9m/jEr4qGTl0NOI2H7U9hy6Kk0hIC3/xFSpd9Nm6xcv6UH25kz+mT
	o7YcjXq7vYEfHlczhjycv+YCd0AczuAUiW9wpsUH+LuY4wX4iZVM7G+l1WMft2LNhfb0CsWrT1W
	GHgaxq0wtingH7CrwoQr7GKCedA4g+9OHbB97/GAmRX8OgEG4UMNpoA39NV2ZlobI7qLV1N2R2Z
	MlClQFQpe+ur6+ptsKBbkYwD8LV9qdP/DhC3MCUftqdPMcCnFztkCZBGdfyqX
X-Google-Smtp-Source: AGHT+IHd54GP84hEi7muy02a3dkpCB1UaHkY3LKmMK+FWfm1/jROl/vYID1fEQeR9RjJbDXGy7hOTQ==
X-Received: by 2002:a05:620a:28ca:b0:7c5:94b2:99da with SMTP id af79cd13be357-7c955dc3934mr35101185a.28.1745425815793;
        Wed, 23 Apr 2025 09:30:15 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:e2b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4dac4sm698031885a.86.2025.04.23.09.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:30:14 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Apr 2025 12:30:03 -0400
Subject: [PATCH v3 2/6] rust: list: use consistent type parameter style
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-list-no-offset-v3-2-9d0c2b89340e@gmail.com>
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


