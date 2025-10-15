Return-Path: <linux-pci+bounces-38263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35362BE061B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 21:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC7D582CED
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 19:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5B13101DA;
	Wed, 15 Oct 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7LPK/2Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051F30FF10
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556318; cv=none; b=Qjt6L9uj7eEzE6/d9mgLbk3N48DrtqQhb7CO/pjhN00rx/7RB9x455/9KSlWrllFghLOJ7BEq6R2Wcgigv3fOvW59R8slPd6Ba9vr7BonIuZ3N6d67s+auS0Mpdovb7C501XbQaFkKQ1W9KT2ISkUbELBrt+ASUI7O/pENCfTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556318; c=relaxed/simple;
	bh=dVZb5Pcu1XHbZt2SW9FpYlV89iSmsSjiuXxsiQfQLK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TFPrRPtRLf9pdTBtgGzJx6d5F60X8SJ82X0rPChg8J/0TQf8EhF9yXc5zIPD7Zir2vASTDoyUcvgWirmf3Z1OpZX153ciQICWFY6XeAjLcWWmJ3PvywTIJLfx+RUWorpkAXBmLxWqJoMFDdtK/rONtduQEv2rAVvaGaaO/YHVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7LPK/2Z; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87a092251eeso23823396d6.0
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556316; x=1761161116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcA+z8eYaRvOgVrZmY/xhbxjfSBJr0w9ghrKai5yQJ0=;
        b=A7LPK/2ZcjAQL7xVWJxRF0OckSL4EAYosmXjxRhaDABPim0FoifmCoQ8mQAampIf5B
         4jZRg5pwl75YHnlKyC22D8S2So9lb0zOgShysSwArYVYsW82bUXfh1iDgY2pnEsVr/8Z
         yGS12//9A2cCPi1raUg+rJ7IQt/YzJN2wImtSdvLw8XY0/dXHaxQpTgDOTnqDcxWcute
         QJdQTwwWMH/ibrbT6cTbKqeXJX10RMUqBS0OFXREuYLGgSdo6qfFC0oZJENulhbLbgA4
         Fig9gTCGtlIkaxrlmVrBJRi3bX6HkJQ0OXJidjO03JftgSDUsKJg+hV5Z3bcSA4r2ESd
         epuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556316; x=1761161116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcA+z8eYaRvOgVrZmY/xhbxjfSBJr0w9ghrKai5yQJ0=;
        b=gz9OX/B6gYRGewSEj0RiczM7pVbEcy7lkaYCxum1vpnXaM1iHxbjR9l7EbhlPqqEqH
         95ZU6cUlAuyebv3gw4u+WCwumZXIq+fG8Ot3UyyEB95JULZhbKRHuCLI00O3HpdZ/AXB
         nvGYxH/hpfP/5ICXHQGBR9u8lB+PpJq0HvpPx3CK5gofimCRdisCkUvKNCzdR4FYTVt9
         DVSiIJm+WAX7HLl1d7tiJT7Ubro816cYk8FyD6AbRN2rLdD4duyWxtgeh/x4T7qwf5GD
         NIZ4+0npE7qqK3Su9WcjQ2Wlkajurj3857BODv3UK00r/Xvd6rLSO70Mhu0UE00yImjM
         SOuw==
X-Forwarded-Encrypted: i=1; AJvYcCWHivlU1P3r8+TbXRPrwVJ0cMKH1pSsdkXYAIXNRapdogR6nQ00UWJF0Lu44+Gtoiwodjko14HpjLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz82to22N9dNrmiOCsTRugrLxo2LYp8W/DWsWgBiGNHnP33R4R0
	w1osiJlwpoOqvPEarmV0eUaMVHSU2Qk1A9Ow6pFD3Co7bUI4feWpXxcM
X-Gm-Gg: ASbGncuylEkOOjc/IOTnCm/4VFYAxRpmAXsCbEej5ZsGANSLrb79mXCkV0/bzjCkrAF
	7uYxFhgEYv3jDAWplFlIv2JIj+hTuNsWTpCd1/FIUxRURwXq1PXUqew1MHDJvJbh2FjuecFYLaM
	dXAgHymn9nDYbDOJE4P5MihzaP3OFln2d+gN0lB4qXPtHsl4FSmzB+0+9+pVTEWDy2Td6C+rbiV
	rhTWyjrbtAyTwMToV4SDV22+L5HemvhpxDRqmOVya938F8rNqlmfFVKzUVeekJtD5GXhhPV0nOQ
	v+ohZRdx88TGhLGmTRJMmqJs9VWCgMV+oucY3Mgk0sfwLLsfmGqtGHIHGlQHqShtZd6sw+dfY9m
	fDY8UVMSpGJRh3nobpfXQN99uR2dNyLbFP3HGdtJvk8h0egigLfE3je8EJcVJCS0Tmic4m8nODb
	RvlNxcm44SMuS84DRbguDpy9oNUDIgauaQkGAi3oExCGNZV8QGcqRjRSHOLOiadXLDPnzzVcfcP
	/L5UDKKvySt/uJsb8l/Z3kqbQXWLDVUKW6evczJObdTsAQGLkY5mY8zXMYsEWU=
X-Google-Smtp-Source: AGHT+IGtrSTY0FUSiNdgbPyhOIH/YvdyU5sl8fvg654fDJk8BbKW5z4ao5A5UXUjIURMYSPijzmsPA==
X-Received: by 2002:a05:6214:48f:b0:78e:f6cd:4704 with SMTP id 6a1803df08f44-87c0c5cd3aemr17462466d6.5.1760556315435;
        Wed, 15 Oct 2025 12:25:15 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:14 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:37 -0400
Subject: [PATCH v17 07/11] rust: debugfs: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-7-dc5e7aec870d@gmail.com>
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=4568;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=dVZb5Pcu1XHbZt2SW9FpYlV89iSmsSjiuXxsiQfQLK4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIygDVPZERtANioDtpZsLIsIx6DMuRfppWFXkHaK3hI5+YEfWJFA0uNjCcv/4Z25JqUAs3bOoMG
 11/p3YDZDuQA=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit 40ecc49466c8 ("rust: debugfs: Add support for
callback-based files") and commit 5e40b591cb46 ("rust: debugfs: Add
support for read-only files").

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/debugfs.rs                   |  2 +-
 rust/kernel/debugfs/callback_adapters.rs |  7 +++----
 rust/kernel/debugfs/file_ops.rs          |  6 +++---
 rust/kernel/debugfs/traits.rs            | 10 +++++-----
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index 381c23b3dd83..8c35d032acfe 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -8,12 +8,12 @@
 // When DebugFS is disabled, many parameters are dead. Linting for this isn't helpful.
 #![cfg_attr(not(CONFIG_DEBUG_FS), allow(unused_variables))]
 
+use crate::fmt;
 use crate::prelude::*;
 use crate::str::CStr;
 #[cfg(CONFIG_DEBUG_FS)]
 use crate::sync::Arc;
 use crate::uaccess::UserSliceReader;
-use core::fmt;
 use core::marker::PhantomData;
 use core::marker::PhantomPinned;
 #[cfg(CONFIG_DEBUG_FS)]
diff --git a/rust/kernel/debugfs/callback_adapters.rs b/rust/kernel/debugfs/callback_adapters.rs
index 6c024230f676..a260d8dee051 100644
--- a/rust/kernel/debugfs/callback_adapters.rs
+++ b/rust/kernel/debugfs/callback_adapters.rs
@@ -5,10 +5,9 @@
 //! than a trait implementation. If provided, it will override the trait implementation.
 
 use super::{Reader, Writer};
+use crate::fmt;
 use crate::prelude::*;
 use crate::uaccess::UserSliceReader;
-use core::fmt;
-use core::fmt::Formatter;
 use core::marker::PhantomData;
 use core::ops::Deref;
 
@@ -76,9 +75,9 @@ fn deref(&self) -> &D {
 
 impl<D, F> Writer for FormatAdapter<D, F>
 where
-    F: Fn(&D, &mut Formatter<'_>) -> fmt::Result + 'static,
+    F: Fn(&D, &mut fmt::Formatter<'_>) -> fmt::Result + 'static,
 {
-    fn write(&self, fmt: &mut Formatter<'_>) -> fmt::Result {
+    fn write(&self, fmt: &mut fmt::Formatter<'_>) -> fmt::Result {
         // SAFETY: FormatAdapter<_, F> can only be constructed if F is inhabited
         let f: &F = unsafe { materialize_zst() };
         f(&self.inner, fmt)
diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_ops.rs
index 50fead17b6f3..9ad5e3fa6f69 100644
--- a/rust/kernel/debugfs/file_ops.rs
+++ b/rust/kernel/debugfs/file_ops.rs
@@ -3,11 +3,11 @@
 
 use super::{Reader, Writer};
 use crate::debugfs::callback_adapters::Adapter;
+use crate::fmt;
 use crate::prelude::*;
 use crate::seq_file::SeqFile;
 use crate::seq_print;
 use crate::uaccess::UserSlice;
-use core::fmt::{Display, Formatter, Result};
 use core::marker::PhantomData;
 
 #[cfg(CONFIG_DEBUG_FS)]
@@ -65,8 +65,8 @@ fn deref(&self) -> &Self::Target {
 
 struct WriterAdapter<T>(T);
 
-impl<'a, T: Writer> Display for WriterAdapter<&'a T> {
-    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
+impl<'a, T: Writer> fmt::Display for WriterAdapter<&'a T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         self.0.write(f)
     }
 }
diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.rs
index ab009eb254b3..ad33bfbc7669 100644
--- a/rust/kernel/debugfs/traits.rs
+++ b/rust/kernel/debugfs/traits.rs
@@ -3,10 +3,10 @@
 
 //! Traits for rendering or updating values exported to DebugFS.
 
+use crate::fmt;
 use crate::prelude::*;
 use crate::sync::Mutex;
 use crate::uaccess::UserSliceReader;
-use core::fmt::{self, Debug, Formatter};
 use core::str::FromStr;
 use core::sync::atomic::{
     AtomicI16, AtomicI32, AtomicI64, AtomicI8, AtomicIsize, AtomicU16, AtomicU32, AtomicU64,
@@ -24,17 +24,17 @@
 /// explicitly instead.
 pub trait Writer {
     /// Formats the value using the given formatter.
-    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result;
+    fn write(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result;
 }
 
 impl<T: Writer> Writer for Mutex<T> {
-    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result {
+    fn write(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         self.lock().write(f)
     }
 }
 
-impl<T: Debug> Writer for T {
-    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result {
+impl<T: fmt::Debug> Writer for T {
+    fn write(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         writeln!(f, "{self:?}")
     }
 }

-- 
2.51.0


