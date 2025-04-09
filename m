Return-Path: <linux-pci+bounces-25579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520CEA82955
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 17:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2E23BD69A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB23E277031;
	Wed,  9 Apr 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8wIdtlx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EDB26A087;
	Wed,  9 Apr 2025 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210290; cv=none; b=ENKZi9VzJFKynQp6fvn+QMrWvMQbsJN7RSxMD3Klux8EIyEdYthEhYdmWhFW5LT779nZYhaj3CUPqqxNeVHx73kDaP5aPTHbD63IraQzflNH1hSZWL2JSfBMfkQYRZeBMtUTKNpDmUem/iWXuKbIZ2Vh3NyZarhFEcNwh6rdOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210290; c=relaxed/simple;
	bh=I3LhX3RHJuENzMWjOlJ7uQw/9Iqe+uTziMBBRl5iv9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgs7ELBiF4G2JYQD8opqI+6JC3Md+CDoppim12/FrikR6qvYTqc/9Pwb/+pvCtXK6cNjd3jPqPPmrKKQ9OhVVQFwo74nn0UI1YNYOUQYyKdF3aZMGfxju/QPZZ8CkfDpedhFp8aUxRB+GRMr5j5Zg4HRUiQWL+v0egDXhjGidUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8wIdtlx; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f05acc13so76537126d6.2;
        Wed, 09 Apr 2025 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210288; x=1744815088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6KDpG33HnsnAHaUls9M6YMElozMNYMw1uYDLkzYs8I=;
        b=X8wIdtlxhuXQk95NRVha/rITRGjvWDnKdnxTRxOtnLs8ZxOX+jtYZcL53tYPRdqFsF
         tzp/ncHG7uUV7GX+ulF3t1/nnQM3CUVORlncKh1cXPK6/ZxbjF1+NTRTBJ4sRAty8906
         8wrnXfRAXpj1wwMyeLk8gUzPsdAIkyXde23zhmKdqZAY120sHCdPWHAp6PgOrPxbHAaM
         9Y/WSl5MFirzzU63VijCj2M9IORK9bRy5y6xSiaPU6sp+7p26Mp1yfNLMGSQD1y1v/Be
         K3Bp9CVzwDdZfLwRNIBvAUKiGRB/rWZUN876BE7xCsgl+xC5grrsPDGIktSybVAB1f19
         cWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210288; x=1744815088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6KDpG33HnsnAHaUls9M6YMElozMNYMw1uYDLkzYs8I=;
        b=YL0Yc4OmUsKFHgD04UpGgp4nveObcoVKUkCSy0ZxbWQRfGSWZWSgrID3ROQbLHspy0
         Ht9CFf+GZNG05Zy6p/SCRIqD4gfQoNNQa3KyGKixxzpohgWDiM1M/CLLk0uLIg3gMbfl
         eY9fMQLHX2d2w4tjyvwkN5ycW5tFjQilD3BYWezw0iqxgde8FTq2AZIF0b6PMn5ROgou
         nO612iONK9cvV4/d5jtCaDzFFYPHtV4GauKQHrudEC+pn7fa8ZrPFgV6gBtpEtKqjphJ
         1AeLFy/8A9TPSI6zkpkSH0nrmfGwbfRYDSBrj37mQAxg61SxBzcFwhT8OSs9p34hVK4o
         0iHg==
X-Forwarded-Encrypted: i=1; AJvYcCVrm72LVdheXMhlTbzGY5OnOnWePpzAxRdG3O4o387va8xnflxEdjutWg4WmEmA3Ilb33Ig2Ct2es7i@vger.kernel.org, AJvYcCVtj8Wp+HnxVArameiKHatdURuyCNHGlOksY5QyjW5zeON8UwQpKP3/ekmL6yBqGxOfEYjG9sC4KUva+r4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsB7FE3pQrS+6uh860xBBpIWkUyypoSacW9sn05SwTekXwjZx4
	mY5f5y8dzNY8Sqs5VN1PtD7MRNmtiOLpJGYYHoCeV0ktKu6VrhWa
X-Gm-Gg: ASbGncu9liCAz8auY93Vm6eSFPXZiF3zK6Ysw8SxErGGz98v4L+t2OnlexI74XNguyG
	cD2MP5I+MDEk0Cbxyf+EIjFg5UQXy+JX96GM+nHxQsRAfjuS9swQVQClNo6jtHdXLeL/S8RfBsM
	vAOQaHKENTVgC3hJbF1y9uj/FAZlcXEbbunlxxSN6347gxeEjbYjKNuAY/dw4SzHtelMQXHQbFf
	/iH1wbwKDd12ptxfWvMWrlk7s1oUaoqtR7F1eLphCKxuY+PN971ZyJOd70HIGJBNX/TZa7Wi8B9
	B8JF7t+w5moVxgojPcrMfu8UI2C+iOkydZM2dQDP92E7LAmrsJIjRNGg9IukDzz/H8fevMqeZyo
	0HWtokiHOzCBC77Nv7INrNripcuVMT9mCEDSaFTlQZCDF
X-Google-Smtp-Source: AGHT+IEj6a/gTtE+8rEv6HGebDehanM2D4q9D2jv4HBP6KvgQF0IBOofx/wC7IRXnPFtdnSjPyqYbg==
X-Received: by 2002:a05:6214:2343:b0:6e8:f3ec:5406 with SMTP id 6a1803df08f44-6f0dd0a3a40mr43823346d6.19.1744210287776;
        Wed, 09 Apr 2025 07:51:27 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:3298])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de95fa89sm8229876d6.6.2025.04.09.07.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:51:26 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Apr 2025 10:51:20 -0400
Subject: [PATCH v2 3/4] rust: list: use consistent self parameter name
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-list-no-offset-v2-3-0bab7e3c9fd8@gmail.com>
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


