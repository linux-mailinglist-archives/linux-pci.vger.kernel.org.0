Return-Path: <linux-pci+bounces-24580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01D6A6E5BD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 22:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E12188E870
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 21:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C21EA7F9;
	Mon, 24 Mar 2025 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3ofSrmu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195741B21BD;
	Mon, 24 Mar 2025 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852042; cv=none; b=HELCjM3FY19k0hW6fQFulYDBrAOJJORmNNBvtm0C6kuFV6Fr/LTH+t4GojRbleNLJKuWcnkKuMvBMJCJXLads1ntf8QKQXV6OL8MQXfWTxP3OwQgctxGvmh4tVwnHUbpesWnbUTzdhz1yJA60f02R1EXUIy+DobnqHEQ3LcWDDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852042; c=relaxed/simple;
	bh=7btLvyhH9iVv2PqOSFlWfFuJYdzdZSPAxYmuaLLlzQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RnlUIvQpVf03KaNhHyyeFhsZzlnz6lT0cu6fqsXSsrd1OJOfmrac3/uaLbeBqeCRzQVeh0rUwxMlhEfk+g7mNj5kg0M2TJzcF0frj6lZPeXGYRiXrTIty09gaGfFkxtjjc7zZz7A0Qv+Leyp+BPMTltTHMOGHd+HqQuMCRFSRs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3ofSrmu; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5aecec8f3so724716985a.1;
        Mon, 24 Mar 2025 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742852040; x=1743456840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiJt3uTSVh93mv9thEPIRmNnr7a1YuilRvvelKO7uBs=;
        b=l3ofSrmudoY5EusnQnHeNRtc29MOfnmTIJVaCWDwy0FktHBuFab94KfhMW5gu2WpQS
         /opnd3tkjz62+qi7M0SYOEEB+HHW+ujnZk2JqOLbbE4WF/PjRDIp/b9/HdIgQscEddIo
         tPBWrNdVqYUQdqhSVeINqeznQNBckf+2E8WTQZxin67t4xVrND4a2a5n2Xp9/G45MCRD
         W75Z1oQr53Yx9XJPtxxG/WTjUAcJhpOmFvEP/hdpBCYdPf3dYQZKp3knOL+DAwIV8z3S
         LF7nY+9D80bISzBk3euYYFNumm9uE/+UF5+gkI3c7wtKeuktdoipl3nOMoC5w19SAdTu
         lymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742852040; x=1743456840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiJt3uTSVh93mv9thEPIRmNnr7a1YuilRvvelKO7uBs=;
        b=uQAGM72UP39ZEkNEp+67fj0uVNjrMQ1YhxXwWEPkK4O8J3KujooqO8Ao9RMvTq6xI5
         cCMBk2F5JRuWroEIe7fTEZ9dWAjvhMLtzgMYSkpnzurospJ7LCF2ul/eehs7+KggAEw/
         PhX8f3fIKIEEi6ieH8ZihcJ6ZlXpZp/Wty1PhGJY53HqEACf9moG6TbW8JuHS0zoBq7j
         rfKQrH4fp3NblrlVNfw7WNvqYfqCtPDJZyadc/UhGN5F8oqvZGO7gkyEz8anw8PFJamd
         HViJ9OaGWVCoLKZhm6BCqSI5VpbkRustIPPsEwvbTCaWD+UmUAcFDLQZcZugYEBdw+pI
         WVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVySWOMhVyDqvbuwsyBKdgcEBjnidBLvSbFyrZ2TEUvifsfsuEZFlWxqLORnqZ4iHwtzLjoxEGN/AC2XLA=@vger.kernel.org, AJvYcCW+HlOtYV8HDPQd0dBDpRkDmx8Ox3BDaErAOrvxwqLMBUB131brAextbDjRHyGJPxYpq58D+lqZroSc@vger.kernel.org
X-Gm-Message-State: AOJu0YwKnr73+cQiLY040xmmSiVsu/mQjoOJVcg/LcsMtb+2fOGSrrXN
	TnxFlMG+R/Lwugy4TC7QrbTDfiXakJByuhCC0Ve5aKApVo4dT5FH
X-Gm-Gg: ASbGncs4ithslP9tdEB13c3DzVtnXFEpUmHiAJsTAel69yD4ebojQDHM+u/sYIxYvFq
	PoAwvoaGaZYKFH2T6aljqjcHPQ5JPtRBNy+clpjRCSIhsYqEj6rmE9//Omhg8CN5Fa6s8OH+apy
	FmXZFF9WPB3dBZ6XgpY0/rPSgtcAUFNV/XYoBR5VkBxcjSiz1NBjdv9WgL9lksVhyRS+xHe00p7
	E4pIfocsYjsbzaFS/Y7PZXz6HZ5BRoSoob9/QymJVM1DZHn3w93odyDKTmxwn8VGZUlJgKtD7UW
	PdptLhcoPALKGZO78niDxSSilDuqEMitpXppZbNq9z3/K6hGeRdpu0iTQh1NkWujKbBFNuQCA4z
	lbDZRqQh1BjrbB/+fylE9701lxd5A+DY8UAJWDQd05jDfCQAIKSvCZQ==
X-Google-Smtp-Source: AGHT+IFeeTW5DcojPaGvy4zB1UmY0TMPXv3ig/pMcvGf1V3UIaKRKh1hBjHMa3Ymkjv2blszpWvEzg==
X-Received: by 2002:a05:620a:258a:b0:7c5:4dc4:ae48 with SMTP id af79cd13be357-7c5ba209231mr2136739785a.39.1742852039856;
        Mon, 24 Mar 2025 14:33:59 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:43c7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5d7eb96fesm63232185a.90.2025.03.24.14.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:33:59 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 17:33:44 -0400
Subject: [PATCH 2/5] rust: list: simplify macro capture
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-list-no-offset-v1-2-afd2b7fc442a@gmail.com>
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
2.48.1


