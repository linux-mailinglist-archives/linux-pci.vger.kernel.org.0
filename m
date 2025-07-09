Return-Path: <linux-pci+bounces-31801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430ADAFF1DE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 21:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B514C3A03D5
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 19:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A275F242902;
	Wed,  9 Jul 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK9+ZfmZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DD61FF5F9;
	Wed,  9 Jul 2025 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089479; cv=none; b=Ya9g46KQa+UwL0TNyBOquure7ZiatWcaw+px78Djbq2PR9w7UuA7zFQ8hlMBnrVaeqXYclAJ0EVlJUdBbw4/gIqHvhUweeWTJdmXtPQ2VHl5+jVeDoQJM1f0GP8eyL+PydpllyOgT6vnCZJL6Nlc7dOcOSweoCGFtiwVuX8tK/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089479; c=relaxed/simple;
	bh=ad0JLCjojYueo3Sm2psnrCMmwWyDVQ5VOKEoot7PSzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJy2XnmXlqIDcv6tPdHs4TsMMf79XJQnkRpdicngZvWoRs86KRsIqGdIsA9rycESkmpZX03nmJUC7I9VOyz4qM+QplgclF9TZFxHd6bL0SB8m0n2YQ1h3R0zOe4ChgmBwWdmvc35KrJtglxKTcjYeiK2vtwCssQmu/r6xntDBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK9+ZfmZ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d0976776dcso26393585a.2;
        Wed, 09 Jul 2025 12:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752089477; x=1752694277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldMka5dibqXZ7WdzcWGUOI29OAgjt9RZ/4NFPnclSgw=;
        b=fK9+ZfmZh9hDhM4+nW0eJ8h/fyyAN2hZ7SzHbEV8iBf/hjGXCDu8DlC/4zWhoY+l3P
         yS/4z5BVDT7IIrSkWYPAosebG4MiIY9AG+fpGbeb7hqpedaEZhCNCiW0kSYV94ef6uu9
         c5BEdK/DA423HuVYJFG+uAALB4D0wvRg1NCo9JFsh/aB01tga7gv/Yln9t/1m27qSmYK
         WAlcBpNL6A5v/84KtgmAl21wD4OWO8xGuW1o/61YQnRG7GhUepYjX+1AUj3Bbz1OxGho
         6Xt4YFCp9o9nLJ0EYhoUU6vnHR9xnG7kXsXLf+gNHeB8IJUzMeWeUAwxuEQTIK0TPix4
         Fdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752089477; x=1752694277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldMka5dibqXZ7WdzcWGUOI29OAgjt9RZ/4NFPnclSgw=;
        b=YIksf8BqbE7wE5dZAuyafIk5NPBqhlz5FsT5/uHjHO1ROIUgoCx7FmTnpWKH9eiw9X
         St+MLZWHYYEyDJkC6WFaEt9Vb5DQTp6nDVV3A8ZUv2yGrIOajHDBEYMEgnVa5mxpFoN9
         MwKgRA5OD8DF6GjmcbsJhg7bUY99On5sf8KIFV1gEN0saW2q2WkUqXrgJUcPJadrj4sX
         pmnGrmTGnsYxyFLer9XeaF/TFvFtBI6EgzJdXbeyWTycPbR5b/8r54Z/B2jada1EssGe
         FwO2Pgn3FD3s+8n+S7il1D8kjGTFBQ5YZGUObiPPySX/3Y0P342WOVL79bdosNAJccul
         XamA==
X-Forwarded-Encrypted: i=1; AJvYcCUjDEIva7ympd85/gDsPkhFMp5CxOWOFqPyfS9vu3uYljeX/TsLrpQvIBpXhFUggFnlVPfMIQ9eNtCy@vger.kernel.org, AJvYcCXVTUH7iRbd6ui4b2dSk68dPd8Fu+YFBvNxKnh5NXuhWyEzFx7feIPdevFQ57ggIwHQ4MxszhBylEdD7QE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4FsmIaD9eL5tTfb5uxnw2iwPivKzgeo4TprX8UPCxAeDRrG1l
	oDKI/qa+2tr3trXPUW9R0t9ZCHpU3M8kOcRB+pVeOcGyiR4Aei1SOCOj
X-Gm-Gg: ASbGncuHUlqGnK4t5UCaJHK5rzt+wiNlmGk6UisaUvCMvU+LkwTzvQUAgyDcFHQCrrH
	uvJ8Ltp6ud26LaOruU3/u+mVKBmwo5iXGKmTa+oRzqEY6tvU+r4O78mKgAGMfn9jHUbQsF2gnzQ
	820R0h/64v9yVCx9gtYkk+bDIdTYi8OTgB23i1j3mtgYfbYn72QlZOZ0NpPbMzMgMwTi1jbA+jS
	SoGnUISpppoL66K4WGXGNOr+IIXcX88lTiGU2fd4lvl28CCcR6Gv7qTCkiKxsREqKtUmPe0rec2
	9UabDP7aC7FeGrct/BvOUhMWgzWaYtcw9k5PE8GpGg2cXOfxhcVWeS0li0PxKI0ameGrRaDPQpk
	LD2G3/pWX8A88iaFHz/lxWjcjY7QO5V4WemelOnpnd7CW6PR9dsaz7At8hQ==
X-Google-Smtp-Source: AGHT+IEH1UwHra46hpBf3iMMwE4Hix+6e2RpwFrxKVfp8/PjbWTFld0HMynQTrUS+cTLlcMEytOZ3A==
X-Received: by 2002:a05:620a:2729:b0:7db:665b:67ce with SMTP id af79cd13be357-7db80d77003mr436568785a.38.1752089476730;
        Wed, 09 Jul 2025 12:31:16 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbd94242sm991741285a.9.2025.07.09.12.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:31:16 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:31:11 -0400
Subject: [PATCH v4 1/6] rust: list: simplify macro capture
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-list-no-offset-v4-1-a429e75840a9@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752089473; l=2683;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=ad0JLCjojYueo3Sm2psnrCMmwWyDVQ5VOKEoot7PSzs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE1tdh31f5IvmitGCzPAfgKxFcjqOlJkrOMeCtjq7MkCeqe49/K0841BDiovf24hPTEDJ2iQ3xM
 LL+jDomP+TAk=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Avoid manually capturing generics; use `ty` to capture the whole type
instead.

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/list/impl_list_item_mod.rs | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 1f9498c1458f..6bfa59fde17b 100644
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
2.50.0


