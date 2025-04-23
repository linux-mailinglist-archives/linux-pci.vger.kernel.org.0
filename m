Return-Path: <linux-pci+bounces-26566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3BCA99544
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3541B8266F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C763028A1F7;
	Wed, 23 Apr 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEvw+WfU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8322820D8;
	Wed, 23 Apr 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425820; cv=none; b=S27Z6G6SxjOG/gKr/cfKz/WIXXfEYQppWzQYoAYujgDAEOLxxaKKzOa2k7Vj7Dhb4rDpzbJ54OrygwyCVXbe8nVKYIF8Q6HriMHcpmb8cJriUkyphNDw0FjlsZpysFjgBhm5nnOyi6OYx6T4ZdHvoeuMkHUffubVRsrPF/wNaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425820; c=relaxed/simple;
	bh=I3LhX3RHJuENzMWjOlJ7uQw/9Iqe+uTziMBBRl5iv9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Twi/jFICnMiLn8RJQB6ldtSYbf+c8dPO3xrCzFS2kXK+qtLtNQi88m/nAbXU4JFdI4qseQgY3AXwHUNA6efcgeMXzFhpsN/h5ok+V85/O7u6kLCHDnA7ggkeJzGqc6NDievgpjJbnjD5VbAzBW+liMbdm+LZ4wdeJrm6XvE2Ceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEvw+WfU; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c58974ed57so53885a.2;
        Wed, 23 Apr 2025 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745425818; x=1746030618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6KDpG33HnsnAHaUls9M6YMElozMNYMw1uYDLkzYs8I=;
        b=KEvw+WfU2RDgcqiz8UmFTEsIUcKUljFWH0KBk5/phWBXzatOur6s229FemIV+4Pd34
         mJG53rEUUqorHP+hCkRlts1vdzvWiUsSaKS4vK5/E8gYheE0XXu/vvOkAKA/dSUY8F76
         FOGHJuKKUbU8h6uGVN4osdSM6wJSgXmNG37TKVkpNbj8dAjz3cueSUGEsJUY12u9QMFE
         6BnRbI2T5jYPYmJluRAcw38ViaJVR4ucBVXKgh9txzixSMIbUxw2QgcVIhek0zQPnSIi
         abZOFpy5hS9h8kQ8/PjZIsk4vzjXm/qsWJdqmT0hjEdD5xXWc/QTsQG62mjjWF++ONRV
         07Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745425818; x=1746030618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6KDpG33HnsnAHaUls9M6YMElozMNYMw1uYDLkzYs8I=;
        b=asLRTIjT7RwEmaFHpGHe63IVkeXIlIuH9oxe+QLJC+xWMdAh9MZcF7MqiZwiidXGc+
         Y5nAHbpJz6lr7S/M6zdVsd9JH3mbwJdHZhaOKMbBaHmr5HrpFEGWi+2Nb4Cuyt6er4Rz
         6i0BLHg7PYIRV8fwCB1F6TqfwUHJMPj/0N/43JtcLvT8QsSSMInDNh0v+wya059Pi6IK
         m0w49RWgJa11EsdDNwQKXmpYdp3r/ZKTBUCCbkaJxNMTh/uwG4hCx31vcAmQs9EK9yTU
         DVZ5C28fwW29oLydKYHpc4jl/RDtQsRiQO4x3cqIKOtMlmcMZR9YsXl4JHtH91DJwhRW
         6z6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUm5JfXm/EIZ3qBOkFretn8FDQj0GRSQY8DuaeeB9RsVD/5wSPCpjmCm0CkLGhbkixuvOt1aG2raw9Zwjk=@vger.kernel.org, AJvYcCXqnrVU4PgPIMFypXegQyutEUn+URe5fyFA/V7+7ud68Lq0RtnZflMH9LmbiXrtwBB8ET8rtxXOBUKF@vger.kernel.org
X-Gm-Message-State: AOJu0YwgYQYk6JlZ3SZR+PgZdgpH/MNr3CU1mcG5zxtX8plA50xM5y17
	FCbJuW1sVdye+81xSyC4tLtKWxZwdH3KKlJnh5wfpmDhDBSzp7v2
X-Gm-Gg: ASbGncuae4GO02b15JGTV8xuehiDiY1MbfyLPxI7YxgXq+xCPwdX0vcqHq18SNchQFl
	VZicz+Q7gbTPMuOAmVcNo0qaTpeIUaBANXuKS3AwCZiGcY+D0LefQ9X/JUuBscfqOY2wG3g1fPg
	O5VyqeaiJ8P6FS649b8PgNeJWssG36HM4tqot/MpW22wJ/hxDeebUa2VgFypEjsHxlDexV36ath
	scn2+mdL/3Th9ND5t0CmWAAdbFdCYPkC4ckoQxZTnhNdfbglFp5lnyKxOoAIcjgr0KbteKcTRqU
	+FLOcFhkzLpO6KRvS8UjMPRAjT8TqW1Baaww5W3dfF4ijl6J4GArusY9bag+u2WPxfskzp2gTXt
	88eAaCHbISt3hBIIzqT2cw/LSGHhWJNrGL5rtHCasSb+US1+lhQ==
X-Google-Smtp-Source: AGHT+IGFwowwvobb+M40ZUbTBkk5Ue3MbBo/otwh2KFEhB1oNBH1LDMMzoKmKv0VK5INNPKg/cEGuw==
X-Received: by 2002:a05:620a:3707:b0:7c9:443e:7026 with SMTP id af79cd13be357-7c955d9f5camr51955085a.8.1745425817349;
        Wed, 23 Apr 2025 09:30:17 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:e2b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4dac4sm698031885a.86.2025.04.23.09.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:30:16 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Apr 2025 12:30:04 -0400
Subject: [PATCH v3 3/6] rust: list: use consistent self parameter name
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-list-no-offset-v3-3-9d0c2b89340e@gmail.com>
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

Refer to the self parameter of `impl_list_item!` by the same name used
in `impl_has_list_links{,_self_ptr}!`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/list/impl_list_item_mod.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 49f5af12e796..d79bebb363ce 100644
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
2.49.0


