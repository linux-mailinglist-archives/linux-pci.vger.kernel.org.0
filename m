Return-Path: <linux-pci+bounces-26157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA6FA92F77
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 03:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A46C4A3EDA
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 01:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A622147FD;
	Fri, 18 Apr 2025 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="wlT+Yzs5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CB92144AE
	for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 01:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940561; cv=none; b=p5YLUxaPaNxpBvlUxDUlF1Ir6c/WYl4r1qkl5UR6SPJUyBere11fqxSUkg505YeYQPmzdhwMRO4WsCcVslCMTvEO2JoH4caxsHRqBcMSY/g+jUm1P651R25JLV7tdsMu1hU5U7ujUBzmfcFhNnm27C4la0S41eKVzP2QnyPtULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940561; c=relaxed/simple;
	bh=FyzfpjuzV37kb8DXdRAf2JVqbI26cGWJdP3ZB4YA9Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haHYeGd49EFJeWTlgWRGyc7xhQjxHVBGNESxFvSbBZpTSvtyksgm1l+NH52ruxrTXdXohqrsxrxyQmVDwukPDX3W6UcXm2uAMWpkv4/5r3YNNGoOakTbwqiX6SZw5EfrYjR+Njvk7jpn627c8Hioy2T7vwzT4u/fxKKOONjW+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=wlT+Yzs5; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-707561e5fdcso1201787b3.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 18:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1744940558; x=1745545358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ypjYaS2bCdOwhFfUcatnP6T3YhESxrRRKhPIWxfjEY=;
        b=wlT+Yzs5oqxQ8z8ppn2k2kKpXKkVUTE/fiMNimu8ArT9FF1paMb6rQs6GYnIY92Efu
         w4PLktPsOWE3vAE9iTXy4mJj0IKi5HHmQWrcqqSKTPae4rW0XBII/+C2Syy+TnKqfsMV
         lv5pNERE3yRcyHnb5vxlSoLxNxzt08ZphhnW9noYNNELQcIohHlKgbw1xYzhvBIKY3L1
         Yje7OpJyyJ8bXmu27au8AGTErtxnn02H2f1KHkSBWpD3s+o7P/frp+edLGSeoaH1pVoy
         SWXAptR6C7BeykAHCymK5tLbKvlko0vqJlWzLYrN/yki8I9Z9O6VVSXlh8PIrrm6hJhv
         uRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744940558; x=1745545358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ypjYaS2bCdOwhFfUcatnP6T3YhESxrRRKhPIWxfjEY=;
        b=LeaWmY9Bd7Dk6lc3Ay2698sBvXZPiKoMhxNGmtFRxOVO4qek2w6WfH7ht7QkqYMNxC
         cS4GsqDRDXSZWkx9dh2dgnJzwvALFl2s0T4bvS9RRv5Jab1AO/xBL0P0ySm+7E7ytPLB
         c/viT28Ik2rERgCSBrMEPjtfi+zG9Wdx3bC6HnKHYAnlyiwP7oWUT7Dgy9IbjUMDx7uX
         hLECaECtVl8HXWABoqJASGTJ5UskcTlrJ0au9kVD7fU3vMa4tsgqixXvKCqDt7JeKDXu
         GNLidwBuAX/LjvyaiCTzHwpX8UTDpxNcoaHudsvv0LF9iasXiM8rlh+hWIhZeCu35wCW
         CG3w==
X-Forwarded-Encrypted: i=1; AJvYcCUdtKfn9fYD1R/xGKwfFL9WdnSiNBO7QpzzVnnqvjISyqEnwpZoXo3Bo2ookhmfp04NWhAC9QP0jTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ9Nu9dqoT7rNIqnYik6Mf+EzarimxZG5h293ejv0vwgER2p23
	my+j0MPSSNEID9uomZgsjvYG4jNKWG5P5p2TBcgNlJusnhCdX665ppDtzsiOWWQ=
X-Gm-Gg: ASbGncu9SvDnm0f7OfrKceoW9Mio3gGH6uLl7YawrRXuxp2Xb35lcuvfL+8giKzbQP4
	Jy0tFO1GGi6FeFjdDb5r6zMZKwZD5XnSW5Gj/GTL8MRrSt5g1MVZo8CES0qBTO7IwMrHHwmnYB/
	Lqw3kQEZf1oi0sH83MdoibB4CokR+pM0ajy4gGkzy0tlEKkbU6m4xJ3PRuZaGCjl0yGs2X/ieKa
	w+YTm3tM5vQRj6MHYWZNTqrqFBR/waOmGvJ7FvrjToKBhHAnEw/bhUjc59hL4O+ci2O2X7UmSKP
	8Ogg8otaB5Gc2o/UDU2zeDnDvkFF1UJdbemMpE+h/BHQVfiiNvta3nap5uX4cvlKoTaNZhvexYX
	UdJfWKf/94otmmBDgb8HcLkqbeajzFWCs8YJK
X-Google-Smtp-Source: AGHT+IEHJ+6Pf1f8ODH1sVykiKxg8GkjoeffCbwbuKrlLP91ZhaDAEvmG3W3nEPzfRzvLTxyNUCQWA==
X-Received: by 2002:a05:690c:6a0f:b0:702:627e:a787 with SMTP id 00721157ae682-706cce2592amr16062067b3.29.1744940558537;
        Thu, 17 Apr 2025 18:42:38 -0700 (PDT)
Received: from Machine.localdomain (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706ca44fd13sm2804597b3.20.2025.04.17.18.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 18:42:38 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/18] rust: pci: refactor to use `&raw mut`
Date: Thu, 17 Apr 2025 21:41:35 -0400
Message-ID: <20250418014143.888022-15-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250418014143.888022-1-contact@antoniohickey.com>
References: <20250418014143.888022-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of_mut!(place)`
with `&raw mut place`.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw mut` is similar to `&mut`
making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/pci.rs | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index c97d6d470b28..4ad82f10a8b3 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -17,11 +17,7 @@
     types::{ARef, ForeignOwnable, Opaque},
     ThisModule,
 };
-use core::{
-    marker::PhantomData,
-    ops::Deref,
-    ptr::{addr_of_mut, NonNull},
-};
+use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
 use kernel::prelude::*;
 
 /// An adapter for the registration of PCI drivers.
@@ -459,7 +455,7 @@ impl AsRef<device::Device> for Device {
     fn as_ref(&self) -> &device::Device {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
         // `struct pci_dev`.
-        let dev = unsafe { addr_of_mut!((*self.as_raw()).dev) };
+        let dev = unsafe { &raw mut (*self.as_raw()).dev };
 
         // SAFETY: `dev` points to a valid `struct device`.
         unsafe { device::Device::as_ref(dev) }
-- 
2.48.1


