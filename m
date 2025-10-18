Return-Path: <linux-pci+bounces-38600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426EFBED6B5
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 19:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94BE624901
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 17:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3A62E1C58;
	Sat, 18 Oct 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL7XNcaR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DDD2DC79D
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809560; cv=none; b=mhWkitK4Pkk8DsyGIMO2yBkJcjf7jvd5T79ZtKuGQ+B6eSvLVX2Ks2pngc4ui74vyuQVCVNeBYEdbjQ6OOTVN68DfM+q7nOQKBqb8WJk7cTRUslAVAcaboNTpHBFUGxJHBu726hG0tN55JuzqOQcEGlIeOaS4NHFFNCqtrq5jJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809560; c=relaxed/simple;
	bh=2RO1O8x8vlwhifkhfd816jOQiIu5L43+GQ3qhkZvCCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MmkBxeE9x/HjSgxI8bfRdrZRGYdwoK11HCOUAJ7but3IxOQG6qEG7NJCNdUJqaGh5y23kf3vEw3vyGCceWWH3pUkzXAIe2Gy7xqrrRZjJxlIYdsZc1eKU3n0aOBRfczRJpj6KS3mH2ScRSjS6SHGzJxTwqZMVVhyKklN/jdowB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL7XNcaR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-88f79ae58f0so490330585a.2
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809557; x=1761414357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a15d5fAvykxuJ32X4GoFun7W4EexMfG4QkmOfbTlvaA=;
        b=GL7XNcaRisIQRpvNANKfLsPUjWi9UKTcVHFQt3rKxT9e6k6Z7Mq4yV0sQYC4gO1Hcj
         sJyg/79Klvel4XnE0xuudtNs0raQqIomw/EIVxnvdo31WaO+XZDR8estB4jBg5M+8DNg
         URsz2s28FaId/vbAeX53DFBXSGYMLHiveLI683yf3JutpfZ5O+XRJc++HP8IxECwm4yF
         8sEzTLFwSqcIbkp2aiMS4Uz39mbuLXRrWx3q5+MShmY6MLypWnyT/l5akGk1mcXye4OV
         c4/9KfD+bGDJBWvS8XUAuaF170gODiUmD4ZCYEr4uNoR8GZj3ycLBqJwQ4imwcR9Sx2C
         r0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809557; x=1761414357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a15d5fAvykxuJ32X4GoFun7W4EexMfG4QkmOfbTlvaA=;
        b=syEOKIWYZwKtxm3zZLCi3I5tpTQAIxvUM5rIiiGL2gUjT8TzQgSIhIGOGgweKoG68Y
         GYL3xpdCtA8r2grMZy12x5vkQgCINC4NTUahhKGTg+Mn7Ih4LNE3LKHs7oMOPXCCTI2b
         e+Wq/mysr1nxNHfCe+AXoWL9skmjP3p+VU5mPmKDgovQhuBGxxFkRYwjY8pqlE4/oPGg
         5R6+yQR/YSz9hbViIsa59IGKYy1Rqa5tpw9XlhtXaCykcMkSZBW4M3cfU7+WblV1jixd
         BZ1qfiES2MHTwE4Qaf1ixFykAEMzlbxsvMifoIcPFrfkpDeST4wgA7ero+Fju73I2pfH
         sU0w==
X-Forwarded-Encrypted: i=1; AJvYcCXaY0SkwCmYBHD9wL+KXj+tzkbt0ZlRouMTq4R6ajaQzl15hAMHr1Yj4owD6FX3lESsbpyZSabqcd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZwK+/TfIRss0RlUXqBYXKTl8lffIRUzTtwaeawplUL4GPr7b
	D8+uKG9j3XSuonvtXNEPFFi9M1L1UnTUyQI72a0d6LJjs4RkEeszzUFD
X-Gm-Gg: ASbGncvzX/5i/A9JowMDYZOzE7SRDg4Sd5joCtVxAB68RoiMphqDZPc2hKEflRRBRN3
	FGR0SiPBv6pt7ZxXM5Mgh6PrHWQfBMjV12UUdrtic+G6hnrXRzg29/5RS6voBisQNVoJeVStfh1
	TMYBFGfBj2ecaw2KM+NDHX0bXXoVvxHntw8aJczBn1jQPHAdCK5JfiPYDBLhaXivYNU8lgwuM0M
	vf4CBLYh3ETw5lH9eUVkXzGcFCqcnzLJRryxf7UQ4c0rKrw04d9KrPgBQDgkt39nOdMqS2D32UH
	F/vKQnwVa2fJJFQwQ9kWVahQ80MFexaGdXIc/QLZoQbnaYflPPJBvdu8MGOVuSXCFWVu9eP1U8s
	83HAOWhExhB8T6JaoR5odTN3BMh3PJAJdw+7ORrgDVfd1aTNanEtCr5OgpvG5SkDQrN6kAumSsb
	hUmqSGIiQeCB4eSop8mTGnLtRRSoRsFYYJGyg7KyWIfhqHzEEGTbwtAljProS7KojMVwsygiG9G
	I1IuiFMZi8eaoYRdBbU13i3qXPGa3d1y2QtO8C0u409i2YPvXz+PxKnc0F/P9c8O4+hEw2piA==
X-Google-Smtp-Source: AGHT+IF0jDSr4+x2H9ezxo4E3+k6pmF019NwUbAdiwnAzhTA8DToLrkpZSznJQWz124+QD1Dm24uLg==
X-Received: by 2002:a05:622a:1102:b0:4e8:b17d:916b with SMTP id d75a77b69052e-4e8b17d949fmr28810291cf.51.1760809556972;
        Sat, 18 Oct 2025 10:45:56 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:45:55 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:18 -0400
Subject: [PATCH v18 07/16] rust: debugfs: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-7-ef3d02760804@gmail.com>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Tamir Duberstein <tamird@gmail.com>, 
 Matthew Maurer <mmaurer@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809527; l=4664;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=2RO1O8x8vlwhifkhfd816jOQiIu5L43+GQ3qhkZvCCc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMATZCii+4KTdwmO4cL/e3cZ7fEhaFxHdhr1qxcBeKLRmamGNwC2RJ/lvy+nkubg5+s2N1SC1jy
 AY70o32pQ0gI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit 40ecc49466c8 ("rust: debugfs: Add support for
callback-based files") and commit 5e40b591cb46 ("rust: debugfs: Add
support for read-only files").

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Matthew Maurer <mmaurer@google.com>
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
2.51.1


