Return-Path: <linux-pci+bounces-24191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD936A69E12
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 03:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF1B19C3130
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 02:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CDC192B82;
	Thu, 20 Mar 2025 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="LWs67NfU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB71C5D77
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 02:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436522; cv=none; b=QuFXtoXoXY7R8xycmqHYn8aceKmsG+lYIF4yVpkD2EU+B9EJa87Q8qOimtmjW96HnVDUhSq+ek/1zOIUMhGphOozUyAFb+rw/CsBwomCdnsVkTZfnnxV/nDMlthm/47MAfL//XYveEVcLGFjkP6W+muOq7eSG6grnCB/qwD1lD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436522; c=relaxed/simple;
	bh=55V2j/OQPKYJTWiV+U25GDW5Iw0leNvV8HMgmBJ2+HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTueRFwEtFdggpfLVeYcRIBmqkBFZpHMm2CbM645xVhSUV/NHJiGAkk7i4vfFzzMNtG/a5rj9u1IMBli9tKCaDhmYg/d8KeqGC6VLFHjZI/9v4CPd3YbYIGSqj0GKQb602Tg1Sf9r5KN37t6vhYWUh5zmPT21hNW+PcPCT2lbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=LWs67NfU; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef7c9e9592so2501537b3.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 19:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436520; x=1743041320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYdjsu9Z7/7WUWaSQUOHiYBv7brhy95VtaLf8YZSIL0=;
        b=LWs67NfUHEd94PBe46MENCciIUYHpghRNAKijCxV8DIT5YRXi6RIQE2LP5wEason55
         BReZNWhj5clCRi+rm4Z3vvgmQVWHi5wNVupYbxOc93f1/Pv5Qr6dqNmuVQmhFRxX5HhX
         oKSO3xP2CJ7Rt33MWF6Qlry0hjSUk8G3FLHc75t4TGEWLpGGESaPMtS2gvfVTRZT9pqy
         OdVYLsL6SS82oQ5rnO7sWXOdpWWEWgxfVrpNh6FzAFBUoL8FPdbPpeYkvPFoz66TVTej
         qI5ik3u9Nje6TPyxZKoU+nzNXVGyA7dQdT4M916hA3X+xP42envwwRjTqmUDWKl1iU+f
         AZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436520; x=1743041320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYdjsu9Z7/7WUWaSQUOHiYBv7brhy95VtaLf8YZSIL0=;
        b=KW93DY8j/qgEf/Esl0RciWYZ0YVbangiM/quDw9s3fmMC9XHP2es5zc5k9QsxZYmS7
         +0vkwzTZOnOxdjWP95g68FZMIY8EOTzEoJv3cb0cnqrfB+CFzvm0Eqjp1Pqqf6HHhDGa
         XGVtmhKb5r87atlK7Dh+56ept9zeHD2f2R0sBbYEHkUPifCKbGhuG+lmGXnRkBBjApSG
         39VJYDaLDlWEXAoDCpvGOto2N7RqDCZeviP3/pK0CpniG2Ah3VV9CPQbL9JR7nbOxlbB
         ibIQJc0AO0Rhs0dv+rznoIE4kZSoXA6CMW0YFR1xx4oY6hWz+L7tmojNrAG1MreRDmS7
         v9Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUPefjJ28KFqXjYvG5q3uxafX6qPiiQUQVlFpNXt1RWBhfj8kVfc0j4KzUBQS6AD91Tyxp7J3q+AXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlTxa4BI0FTALLqM+jkm7MrHdqJ/9WLGjhjvSvev7igH5dFtJ
	OK0x9sBIFTVCVnEsySqxQI2YAgBiLJBLtu0xoH5RlgY8TGkhw3cbI2Y8VF5UriE=
X-Gm-Gg: ASbGncue/TBQMYXAq5Ou0aE4NAYNTwVfoHvJD7PioA0kf6pRWJDsAzLYgRRiSOl8LeU
	GT7tPUUyMJvf/sIgQHwbu6S2diZQhozYO7COcSDyBbDkz2LQGwaehb9NErtBHbsS54HlTdgBeL3
	j35tEgq84yr4MgnpelzQtEppLvKe1p92kLcJgYUlbLzUeehPffnP+/PaTxxeeUO0uofY/WLvL43
	8gVX5d0BC2L/LbdGSwmJvcSM541NjQ9euo4NZGIoILC/JNGGn1L2VCeIADJCqTzhZ8bz1sf5m16
	EhJNqIDP9JFvV3pCoRL+t8XfCGlrgPOVbyzrfH42iRDAmLe1ya7LJEKmXx4aZs2FqhFBvo9LdHl
	tgn/sF2Hm5q0ACRO4s/dpgO/aS5byLQ==
X-Google-Smtp-Source: AGHT+IHctHYEVPNjVuLvb2QThCG44XzX6Hlpf6z6uDv1fDPTG2mB/nmST4ANdlI35F2bQBVILOWMeg==
X-Received: by 2002:a05:690c:7281:b0:6f9:87da:b763 with SMTP id 00721157ae682-7009bf78fe0mr72646217b3.12.1742436519870;
        Wed, 19 Mar 2025 19:08:39 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:08:39 -0700 (PDT)
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
Subject: [PATCH v5 07/17] rust: pci: refactor to use `&raw [const|mut]`
Date: Wed, 19 Mar 2025 22:07:26 -0400
Message-ID: <20250320020740.1631171-8-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320020740.1631171-1-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com>
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
 rust/kernel/pci.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f7b2743828ae..6cb9ed1e7cbf 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -17,7 +17,7 @@
     types::{ARef, ForeignOwnable, Opaque},
     ThisModule,
 };
-use core::{ops::Deref, ptr::addr_of_mut};
+use core::ops::Deref;
 use kernel::prelude::*;
 
 /// An adapter for the registration of PCI drivers.
@@ -60,7 +60,7 @@ extern "C" fn probe_callback(
     ) -> kernel::ffi::c_int {
         // SAFETY: The PCI bus only ever calls the probe callback with a valid pointer to a
         // `struct pci_dev`.
-        let dev = unsafe { device::Device::get_device(addr_of_mut!((*pdev).dev)) };
+        let dev = unsafe { device::Device::get_device(&raw mut (*pdev).dev) };
         // SAFETY: `dev` is guaranteed to be embedded in a valid `struct pci_dev` by the call
         // above.
         let mut pdev = unsafe { Device::from_dev(dev) };


