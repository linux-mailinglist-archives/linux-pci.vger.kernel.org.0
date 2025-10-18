Return-Path: <linux-pci+bounces-38596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 523EDBED655
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 19:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E18DF4F08B5
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 17:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E78327A103;
	Sat, 18 Oct 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiUSbTna"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9CD277029
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809546; cv=none; b=ILWJPkEiJI+RRDnoHrx6VH0esBwMpXo/34T9z8UW8CB8Fmy2tyxLDZm2VS5HwCyHdDGc6P2iH5hQVu31aho1lLgxAswgaoGCu8wWKwu0XIZCICMzQwlS1udnAxrIOmdCRSJq7t9Vi5tG9NSB8kqT6SKre97SwYGo65uotPbwBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809546; c=relaxed/simple;
	bh=872/2/9eITdb9tB+ajd4McXNzNIKi7XLnXFm8ifjokI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P7VmC39PSHzBvJC/a9D7KNrEAwbN/+AuRAxkKn9yp9xMq6rDgEPe8ATVjvh/W35H2dr+ariCwR3tM8cMDA+HC5MsAczG/nlGSTFZKeSIkn4X8WWVUP3F0mXu0JNnmdXCNi7KXI0sHP38m+F79Eg+y/gtVOV9th0MdlJJw2vC7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiUSbTna; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7f04816589bso472529385a.3
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 10:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809543; x=1761414343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxxD2K5FdBz/EnZVjAulq7wLhETf3uBIbeo+/VSTI5o=;
        b=PiUSbTnawi0Y2gAOle6WmnfWCMP15/NZEFmhoWZ/P8IE/4TCxmGjSoi53OpB/Yl7Lo
         /Zswgw8ol5/9UeFvKlNkHdyWX81ZKlWnsSmTb9/L9ttW3D+7oojqWaXLXBm5IuaTAWAZ
         zzx7mr2BpUeRb+HK/FjLv/xzNThgx2XnCClmTyRlPo6/twf/ocjqFQWg1IUcESd8hnVP
         m1S44t3z4VO+iQ9fuLTi03/HdihgxNiTi9JqOcYIdKACT2i21syOexoVSijXEAZWEM/w
         TBLUaURZjJI2t4IhEj9sagARG3zDp0VCz56QWREA0Z1RqrYl7Pz/sZAalkncJcCLNSGL
         xVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809543; x=1761414343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxxD2K5FdBz/EnZVjAulq7wLhETf3uBIbeo+/VSTI5o=;
        b=NyZkeqRfVxHimTI0DZxJ1dxFLYf6TQ0iP9rIQMJ4cZhtttfdUGQ1bc0ukRbkHl29t3
         ZUO4J7eYw8lUW3etQYk00OjGpfzuwnFfztLWtRfwsv0huooGZ0fzydR6vJWrqDb8+hsx
         xq8WFn3hbBDLhfmKEXChdauOyEYCeMBPTFBo/L/DxBroCn9JhPdJVVXBmTD9v1ayVtJb
         Ru7JkJqNB100d+JGXsVwBC8zK2Q3sanVo3lbvd9Z4GI8RbSXg9b9ANP8xnSITQKuOoOo
         F4VV774skHMvwBH2WKOGXsBQ/UPwhz7ZL/wHySo4atFxtmSj5JYg7GvO3aTVLHsUVv/f
         ioBg==
X-Forwarded-Encrypted: i=1; AJvYcCXSNjTgBrjm35NoP138eOxLfVbZ8J9FYrngCA4NntZd5cJ1QQHmd57Evoj5yr6yEkiwpH4oF1/KohY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKWmxUs+MLsBPdQ86vyHiy5Lbe/GOp5PY7DJVzzd43bJM6sze3
	jh4/+/i5OfStBIvo2jqodPU3VD2Qii8B5qd7fp5rt5A9/bnzkD548xlP
X-Gm-Gg: ASbGncu8DT1GNqixo0+FpOhjkwR8WVi0yEMa5g88zZ+i319rFth10VI0Om3DmWmv2P7
	qNQBxVSjsGO6Vqljxm8jAFf40+shjvfZX+jpgcIRWL3Ic7M1Kr1cabM6JeHqkF09ed/30JDE/90
	FF66RpDKoPOPhhnSx3rU51OuDN0pfnPdFbkIfnsMg6cm7tbOMlSIMLe467s07OOn06dqJdVnH5M
	fBnqmaucVTR4EibuXkDWBexWG31qt3UkYsZ3E5VvqMGKTU6t85EnRY/7/DQVw6qH2XkcR1jvMzm
	7LlsVH7jJn4L0z7DJ1vwX/J5G3ioZL6p8BQtTdx/wMsFbJPm1MmK1/Rv04aikLXGmvk9pTHfI5Y
	1yTC9LWEjVTeVw6RZGShjvyYhpO4SxDhhHaXcRDU+98fatzzlIjuZ4QY78xOG3PQH9FfcegS3FX
	covKyKgb9J91wlLNtQis0h65M5Rbe8sKOzU3KKoQ6UVCMbo/yIERtuX/UHuktm+gtjtShy1kncZ
	jQZCbukCSUCbpDv3xpnbrgvlgIjCzMijmB4cVWuuYL+EI8cbbC1t212nlr+s7I=
X-Google-Smtp-Source: AGHT+IFKKdVLl3mAPx5GW1O57JDFIbYY3aQNyGp5ohShtikkzbyW7xTlAHv9ByPokofKb8ncQ992Dw==
X-Received: by 2002:a05:620a:28d0:b0:891:7def:94a5 with SMTP id af79cd13be357-8917def9615mr601979985a.89.1760809543355;
        Sat, 18 Oct 2025 10:45:43 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:45:42 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:14 -0400
Subject: [PATCH v18 03/16] rust_binder: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-3-ef3d02760804@gmail.com>
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
 dri-devel@lists.freedesktop.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809526; l=1195;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=872/2/9eITdb9tB+ajd4McXNzNIKi7XLnXFm8ifjokI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNpeE2O2veZx/WAQcXn2BPsuVFmwejvaIZ814PGVaIzTcLISv+9UjXgL3SnRuXBWt3P0YjfBZ5X
 ySAtgUYGZcgw=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
driver").

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/android/binder/error.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index 9921827267d0..b24497cfa292 100644
--- a/drivers/android/binder/error.rs
+++ b/drivers/android/binder/error.rs
@@ -2,6 +2,7 @@
 
 // Copyright (C) 2025 Google LLC.
 
+use kernel::fmt;
 use kernel::prelude::*;
 
 use crate::defs::*;
@@ -76,8 +77,8 @@ fn from(_: kernel::alloc::AllocError) -> Self {
     }
 }
 
-impl core::fmt::Debug for BinderError {
-    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+impl fmt::Debug for BinderError {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self.reply {
             BR_FAILED_REPLY => match self.source.as_ref() {
                 Some(source) => f

-- 
2.51.1


