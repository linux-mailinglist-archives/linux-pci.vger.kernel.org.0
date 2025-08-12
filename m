Return-Path: <linux-pci+bounces-33815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CCEB21BAA
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7158C1902F7A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 03:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6CD214204;
	Tue, 12 Aug 2025 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPyQDdNg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC901A76DE;
	Tue, 12 Aug 2025 03:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754969518; cv=none; b=m1zW029zuJf3RUBBtPikeTIWWBbW0j0ee3RuEUVmAXl47l6tiL3sZnw7maGDSJlxAs6MsFZ9ZClDovycmuu+oiv9xeEgb9iCowwL874d2qDAz0klZcJ3nx3O5iOAKGlF0IaEK3GBxrE2ntma0T8q4z9hhC2YLadnpqrwxeP5Ax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754969518; c=relaxed/simple;
	bh=vfyvdPP9L3lM7kDtAuquN+RNsdO/iJpXaQt7vqW3n8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Asi4Qd+abt4gz158WN5bwUyG58atGeyWNXmqpCp4ftOW2jJG697afFSQxyOAsBI75CDgCnsgSquvHUDxNDKzPKVez5gio4ZP2nTsRkpHqDcZ+OukPrX0bhKGuW8U6Nnu6nM2zNNxF+TemJ3J0d4rFuOg5+x0W5GGjAOGz0hAtdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPyQDdNg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so5181221b3a.2;
        Mon, 11 Aug 2025 20:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754969517; x=1755574317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8S+no+XL5nD240u8M1Zin3Q7p8a0DhzQRaJrnzy39J8=;
        b=fPyQDdNgrcheSyoXSezabg11clLUa1V/CD2BLx/PZlbtDO95kR3YLfJl6w69YmB5CG
         ySGUJj5pLPAcC+qGV8kqEJW4GRP/p/tvYc+ticOdn0xNQi4hpQjRnQiVqysA/diyt+uf
         8AnKeqayQyn/HiR8SGOVCXWTOLFwB51kAzhbusqOs9a4sRUkvSnvGW8Ucgm62gWE7O71
         6VXLeOjx2x3wJK5ownFrusUaiowIujcm9zue0PIIaT1psJ7sB3oBrDU/lg9nwT2ZYnim
         Gbh+sggva7+cIVyD8dGzNPQcXlcFFbTrV9UHfWEUdpseE7gghMi8Ag87Z6arbuJNK4mB
         rKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754969517; x=1755574317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8S+no+XL5nD240u8M1Zin3Q7p8a0DhzQRaJrnzy39J8=;
        b=CmAxWDipjnmkoiLB809F2HTI4SyfhBYHRmB61cas1wSLAs7XQINl+QjQCQvqhzPASe
         u0n2n5qfCT1n5yOJWn9dA/ODpksru1wxJVqmdt64QbUhXNhEWY8Fm7JtCgY0APu7iGF+
         k7QWa8AaZdG/f6arP1z8Rc4LOkX2OxP7VseTtTrhXpeaL1WTWVf51CT7c1F7svWI4t55
         RL347d3eGnUM4dtU4IOADTV1/piDOcJK7x6uP8tiX03ex4UpgmNWGk27cKiRp4eVe7r1
         XK3tyBJcoENXw+JPlyoPK1CV8L6Ul7cd6AEEnruEM2Z3+V5fdihiKYMtUpaVWP7m6NKf
         1Ieg==
X-Forwarded-Encrypted: i=1; AJvYcCU2iE1+TljOGbyMGNZ9YDRsy6k112QrdwIw2JEIgpNJc7gCCCbuaJ338TET5U3KVAocuewha7jQ/nC410I=@vger.kernel.org, AJvYcCVmEyZiotBztGplWpn0MV4IvSYdgZQVHF8Cp9RvJjVlcBiMMoUqJT27Qz/RB4U3bAqzFIMTknDGDtkxaL040IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YygURdaehVc8jp+t2cKaxvzenRG3ARN4WUIlT5e/i1VDidzTpmB
	BXv+I6Q53WgwApGSdGAiD+iyf8pIcwELsD6T/i09aoVaOjJ9rT6PcUBj
X-Gm-Gg: ASbGnctmNgOeiaamRz9YJdX8+KA9fSSsMGxNj+PnFvPhvWiYpYmZKFddXLZjTCfs1/x
	+FhG3jEaQ1RoJrXPCvxZ6zW3Ci3XztQsQnwfZLMwkTi5OyUiSPJCCjruLdZarQpAWz8mRnIfq/7
	/HNtqPAjXiN76DkpBnUz/JIQmiPp9knpnV+sHd0N3v5wxDqdrAfJxod/0E58esKAGtRcWKkJ7nF
	kVKnFcoDSRe+41X2OJJC7wpz9eq0q6wRP9VoNAn/lxUxKtJ1vbjSgFgIyRPc3u35ajnTLqn4cGS
	4FObskxdH5K7KQ233Saum3gUswPEXxuBPxR6/wPkqBIJbm6IuPT2Gx8ecyT7S8aIuaAZM5ut+Sj
	3ca7I7/brFFzkqIYAUWUrKIps
X-Google-Smtp-Source: AGHT+IGiXvUO7CJi9ioOHnbz+EgEKBNFp1mg+EhD1KSh2unYYVRsummizomz+JScV+I7SUjWg8KgEQ==
X-Received: by 2002:a05:6a20:72ac:b0:240:1b99:1595 with SMTP id adf61e73a8af0-2409a8bcf16mr3360034637.17.1754969516602;
        Mon, 11 Aug 2025 20:31:56 -0700 (PDT)
Received: from pop-os.. ([2401:4900:91d5:9edd:11bb:d389:5e47:9179])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b46e5074e87sm3091824a12.54.2025.08.11.20.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 20:31:56 -0700 (PDT)
From: herculoxz <abhinav.ogl@gmail.com>
To: dakr@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhinav Ananthu <abhinav.ogl@gmail.com>
Subject: [PATCH v3 1/1] rust: pci: use c_* types via kernel prelude
Date: Tue, 12 Aug 2025 09:01:02 +0530
Message-Id: <20250812033101.5257-1-abhinav.ogl@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhinav Ananthu <abhinav.ogl@gmail.com>

Update PCI FFI callback signatures to use `c_` from the prelude,
instead of accessing it via `kernel::ffi::`.

Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
---
 rust/kernel/pci.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5ce07999168e..fbeeaec4e044 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -61,7 +61,7 @@ impl<T: Driver + 'static> Adapter<T> {
     extern "C" fn probe_callback(
         pdev: *mut bindings::pci_dev,
         id: *const bindings::pci_device_id,
-    ) -> kernel::ffi::c_int {
+    ) -> c_int {
         // SAFETY: The PCI bus only ever calls the probe callback with a valid pointer to a
         // `struct pci_dev`.
         //
@@ -333,7 +333,7 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
         // `ioptr` is valid by the safety requirements.
         // `num` is valid by the safety requirements.
         unsafe {
-            bindings::pci_iounmap(pdev.as_raw(), ioptr as *mut kernel::ffi::c_void);
+            bindings::pci_iounmap(pdev.as_raw(), ioptr as *mut c_void);
             bindings::pci_release_region(pdev.as_raw(), num);
         }
     }
-- 
2.34.1


