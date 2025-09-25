Return-Path: <linux-pci+bounces-36975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FECAB9FCA2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5641C241C0
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD1B2DC77B;
	Thu, 25 Sep 2025 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeuPt+tL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6CA2DC353
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808552; cv=none; b=Dl6d8otR/jN9jvMlKRa4JJfPbjNi2rr/DWF5AzEGF9ioEop9hg4sK4CfajePr60vpxc3XbZXoriQwj5b4w8QWlZPwGbnmj9ZBVGwUiSC8CnWYuXa9CMmuu4gJLl2Nc8hlmt4QPAvb2EJ/3dKDFPyn+VB3Q23uHCoKuEwqtXODB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808552; c=relaxed/simple;
	bh=/zHlMKa0b7Nk9siO6gKcN+x/h82Zk8zkURVvpzNt6AA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bo/1ap/3eqKcOzUkhA4lTiUsLP+x+IPMiQBYHmR/ZOiUIdmR8LNtJuqQdEsCnF8zSXnOMqchXuQr1ub/ITm+P19DnpI2ArseN70XMWsQUSXjAM1yNNxvbQqEqTM/SQmEfegGG6wexuCU5k9ZopRQS8++QHetqfHecwMeZov5F20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeuPt+tL; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78e9f48da30so6745326d6.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 06:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808549; x=1759413349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGNwJdiqffAB8BrNoFOc3im0f57lc7sAudNYea1lra0=;
        b=KeuPt+tLwr0z6WDSP3y7Sd8ARJjyqhBS+8J19v53/oqlcmaVyTjZxFiSaHYUc0eDWv
         HXtJzPM1aKkv/FaVdl0+9Dg2K1BDc1e+3yquSp9hskiLhew3+7oaC1lAXRBrVixuzxZX
         2pjos2w+kAiFtnlfKbsuBkq//yKRfyGhmiZuxp/m8RBzcKsDDyzd5YtXMqmH18RCBzpE
         pVrGH/KYTlH39BJblDgoplC2+0SetRV3N1H6glaSSKPK38tCBu+1/D6Dmnp9U8vmqJLL
         yQmSg1knJMR6xaj4nUnqodIGwo3vS5nx5G6/+UknyfHYGteUeiVMpFfvIJQRbUqZfm80
         yDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808549; x=1759413349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGNwJdiqffAB8BrNoFOc3im0f57lc7sAudNYea1lra0=;
        b=VbzliPAPVWfZtHSRkbKVUgeu1V1a4EbppD9wpwtKmWgd5PIEK2PeZ1fNJ28WIvgaC7
         nzV9TnVcGxOx4SYhaLdMDhDJ4AKR/mBuIStTL9GX7bnB5PzJpsh2QMEukDdPtOiFPdEB
         MMvgKuda2q48fEZpMhGBr+pDTPxPknYmx74r2Sw67I03nKHKhMymJ9yc9nqR0JoKwNma
         S1sU+POGacr3f/c7l+WMrc/mhTsjbzQWBJZ0l89GbGN5nEuGYExFaMTatnN2AjVsxA0x
         e92QzSkDRczd7QBcyjSx1hzPXYetGwDygSo2wAkFWmF7+ZexDQpH1icA+ozvqj6SGQ+u
         YHEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRkOd+02oXLocAuP3RXPeBCDwWlMp7jaKJEdIIDl1uQvuiZbUeP5CBZY0pA5ZZcPzZclvPt3YoC48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCPyZ9qm/PGAG8gSv29Y7B4PZDltHlkEHai8R8GDhHgk+BFjrt
	YvCZ7CmIZkcjtlnvuhvuKDd0bgbKapwneR2OrLT6yXSQvhiarXwmB9lC
X-Gm-Gg: ASbGnctCSDn0ChafMqakiE2IpP03zCMfkD1B2L2g/vXjglBY1KAPgC78C6TWYOGKtn4
	JdrikcNxKrWAuXAr3h1HEih5Szdufyiuhwh7KTRVIElI2YHmu12F8nq5pk7GJN+GtCWIYokoK/7
	jo7yV3+oh/JXAlMmzhViJ2XDMU+jA3thea+eNtugYbiThzfnhy+qMRBolZ9FYDYh5+Pb+Sij10u
	FjwkpqX/oObJNI3vqY/UG9n7gn8cmcCDdupRJx69XuGsEmSoidDjChiZulumvtCDeyLRhv/iuLs
	0V1EICyBDkUXq41NlX/s4RW1PMX3P88twDrnE9EnShxuU/lgMuobZcQ0FSaK/1FY2X7ZNPO6Vg/
	5huBHZPQwNB6Pj/W13ygPB/zYzPtOCVEeOoyv6jdx7W/Z0XV+kkYDHMrglb8u/OwVN5XQiLSn0S
	OEYycN7x52rKw0qEEuV/OzHdFmSRke+zc+mzBL+agALttF+jIgpHp+bQdUHpM1vyEB5blM
X-Google-Smtp-Source: AGHT+IHxxrN1qiYt8CkNZDH6mAY2ag9p3EBYWx12nFthYZnZa+rBx1Nas4oNQjITBFEWvlFgd3yNGw==
X-Received: by 2002:a05:6214:27c3:b0:7f0:e84e:b2b2 with SMTP id 6a1803df08f44-7fc451680aemr56106776d6.57.1758808548877;
        Thu, 25 Sep 2025 06:55:48 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:48 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:54:03 -0400
Subject: [PATCH v2 15/19] rust: seq_file: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-15-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808438; l=1328;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=/zHlMKa0b7Nk9siO6gKcN+x/h82Zk8zkURVvpzNt6AA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAXSvElYTE8YxZCsGrWl/FvFn0PcrKAZK3BdoNzxQTxfQ/m2OpN47pZ17tScZDRCYR8bMK67o/2
 oeQSiKFoeSw0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/seq_file.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 855e533813a6..518265558d66 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
 
-use crate::{bindings, c_str, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
+use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
 
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -36,7 +36,7 @@ pub fn call_printf(&self, args: fmt::Arguments<'_>) {
         unsafe {
             bindings::seq_printf(
                 self.inner.get(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
             );
         }

-- 
2.51.0


