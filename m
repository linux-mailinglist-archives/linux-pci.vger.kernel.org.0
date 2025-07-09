Return-Path: <linux-pci+bounces-31802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D49AFF1E0
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 21:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF90516D899
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 19:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1049243954;
	Wed,  9 Jul 2025 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv1MUjq5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D747242D7A;
	Wed,  9 Jul 2025 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089481; cv=none; b=Bt1hpI4vctJL5+V2BXNaP6omZHFOiNcrfZU4pwfzeamwgVlw5THyNrwo0J16MsBk3dkrgLQVo3VVehmsOP0x21IGTh+C24JGd8IdHA9R+oOvAcxOdYZCRNOwKo7oi/TnFyL/ZRNuyoX5Pohldl8ub9hPM8qYEnBpqM39Vr5b4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089481; c=relaxed/simple;
	bh=BzxsdrZ2gtJ7sd/WRv6JQx15k276m3sIML3wx+BFdbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BNdp7NTIv4aJUR/W0IKvADRzMQdwcLdDwx+wESWckWp87njA5EY10UJ5EsdR2hfl/wBlxHSlJvjLBMFDRXN+rxmT8EHuGCe4HdcEzsv9lAnaxf7XotGt84NijbdIuJ0ZUNc2U+9BDqozGSoOf5OSmb6zV8MkoncGWhTE0WUAHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv1MUjq5; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d0a2220fb0so27166085a.3;
        Wed, 09 Jul 2025 12:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752089479; x=1752694279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IS3q5kNqrEANinnk2Dyg6SnvCsCPgNsMH+95sAwdenk=;
        b=Hv1MUjq5JgU+XsxXcwCUG/XqFGhTT2injKHJBN0GedBXefbzIVEKtrtwGfOIrcGfCU
         CvJqTIflH5xveXNkphe0z3TPQEBllxoCxo56m1/i7C9cza8R/c3EmyjlPUAScE1ebxs1
         rdiHeK2pNUMCOOL17hvcOSQZk8VZuCQqOqAGSLYARqd/I06ZZr3lzPf9N1SJmr3oAMam
         gNAtZnfH26PTolJBnSXuA4FG4EUsN2KWepsGvjd5tFAa+xwX0drri/RlM6EcqgGyd2bg
         hu/QLs2sIb5rzt8UWE220yuAV2/bx9SnBra0GqskuyskX7gXEpxrOkxZaBmo2RaJxGLN
         Cxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752089479; x=1752694279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS3q5kNqrEANinnk2Dyg6SnvCsCPgNsMH+95sAwdenk=;
        b=h0Vsm9ere8+tkvi0F34quvuyxg+EPKC3wS8x7NvdoGEHegkm3wTbvn7qSkXyvrqSR0
         5HVqtrWTHRrdaCGUM62DlPfOZ/Du8UCG2QlIKatGTRHC0oAyejHsHlZ+rwZ1HMdi9tL7
         b1cy9adsxm4kcfIhkkvwC/CD84XXNpIhSvNpWpPsAV32krH04N0FohW0ydNxKwjZTulB
         Vni6gLXz41tBzgi0P85cxQz9vbHuO0NWN5q81nAkolwCXGhsPFgSZYOJzal5Oc+JkPhQ
         RBVehfhr8D5Wu/HKmAnOGsYLzvqjDmueFUGhXKasmMCP4lNyZFVV4Vq+4Uf/AbJV0gd4
         Hrmg==
X-Forwarded-Encrypted: i=1; AJvYcCW7N15717QnlksVw/AflDkpNfT0xLMCZHtRnPRtgJGjCh+Ku7FCtphmZ+jLMzH/Q5kQDkUMIVFpHgGdNTo=@vger.kernel.org, AJvYcCWC6jo6cVcxvv7+iVkYWk3e1EQasexpJ9sKC62IGxBdf8RCE37Rq2IKZinp/TcUuc8vYDzjvhpW/oT8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8l6UdNEl4CMLMD6bRG8yuAkU2lUdteR6wiytj4R2Tz0mFLgIY
	rN3S+aF89NkRv8P4jnJghBRwUHoOiykvmO6v++wJvF9fmylEpRkGymbfHv63fRFYwgJrDQ==
X-Gm-Gg: ASbGnctCFMp3TWN28cyA+6pUyaPy3HdTvBTmKWlZJn10SbG03frBq8u+kKreSDoiS3Q
	ES+aY1VY0T8rDe+bH7FMNt7BVvDRRwyIqOvbl7/gXDbILFVtE+POxbUDVskfYrUBDW2UZhF9jNC
	v2PDZOU9rkKLJ3uI26b3a7MTQGyH/nSuKkUJ53X8C2u1OjDp+VrVvImVUt03/GNfb4MQKBwA3oQ
	HcmKXyeLxb5CYIzkDz1oR2vlus7dnhhPTi4qQeys4x3DdgdwYboW9t5hQyKd7s2Ruh/xK+N+pzu
	4649AfZKYH1EnUQfEwjUWHK7iRuMxoTPfwHNg3PkmY3qVU64ODKJPlEc71pUNzoU98kW2kIF7O8
	RYgcNzMB/Os/mcDmtWsjO+hr2xDMA0yBCsNetSaZLYJkU3XarlTdb80zuoHuPpPi/g1Zi
X-Google-Smtp-Source: AGHT+IGdQOu4PjbwkS+xHnFLfgJqtktLatg01q6v02y434AbtH1/W3pF4tprIcB6Xw9wmMwdeuyThg==
X-Received: by 2002:a05:620a:19a0:b0:7d0:a128:e30a with SMTP id af79cd13be357-7dcca01047emr789885a.2.1752089479142;
        Wed, 09 Jul 2025 12:31:19 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbd94242sm991741285a.9.2025.07.09.12.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:31:18 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:31:13 -0400
Subject: [PATCH v4 3/6] rust: list: use consistent self parameter name
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-list-no-offset-v4-3-a429e75840a9@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752089474; l=2223;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=BzxsdrZ2gtJ7sd/WRv6JQx15k276m3sIML3wx+BFdbI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEcO9tFR42lIexUJhkTHQcbAYxc4+4L2TznqVFNnwwkLdXNMHlp9FM374PMMaSQ2uqTorxAwRTh
 wXzX6nJqdHgc=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Refer to the self parameter of `impl_list_item!` by the same name used
in `impl_has_list_links{,_self_ptr}!`.

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/list/impl_list_item_mod.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 27feaf849c48..050299380330 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -114,12 +114,12 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
 #[macro_export]
 macro_rules! impl_list_item {
     (
-        $(impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
+        $(impl$({$($generics:tt)*})? ListItem<$num:tt> for $self:ty {
             using ListLinks;
         })*
     ) => {$(
         // SAFETY: See GUARANTEES comment on each method.
-        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $t {
+        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $self {
             // GUARANTEES:
             // * This returns the same pointer as `prepare_to_insert` because `prepare_to_insert`
             //   is implemented in terms of `view_links`.
@@ -178,12 +178,12 @@ unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
     )*};
 
     (
-        $(impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
+        $(impl$({$($generics:tt)*})? ListItem<$num:tt> for $self:ty {
             using ListLinksSelfPtr;
         })*
     ) => {$(
         // SAFETY: See GUARANTEES comment on each method.
-        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $t {
+        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $self {
             // GUARANTEES:
             // This implementation of `ListItem` will not give out exclusive access to the same
             // `ListLinks` several times because calls to `prepare_to_insert` and `post_remove`

-- 
2.50.0


