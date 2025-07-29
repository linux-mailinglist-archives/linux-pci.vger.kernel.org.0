Return-Path: <linux-pci+bounces-33088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FAAB1455E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 02:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE7517CAF1
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 00:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE58155393;
	Tue, 29 Jul 2025 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc4SyHjM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7869461;
	Tue, 29 Jul 2025 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753749121; cv=none; b=X+whZYXENbGzJTmH6SeEbH7viAx3YdPOfKeE5N5ZaB0PmhtmfoSrQXXXt6mUClAAQcmX+WZBrgjAjFaJkMP8ZFH4I8XEX9SSPIVwVDF17V8WbbERHFU3pWZgS2mht8481MOYbCMORFiIyHI2vMdWgu7jE58Sj7sMBHpguBgnq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753749121; c=relaxed/simple;
	bh=yUtEztOfMVM5dWoR0DRHrEvlYr8ultlYw22nWVaI+og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NJs/Rh6WTjENt1Z8gTfl4H/Tu3RxO931ETQ/D3lzTR5Tqkyv0MuHOFJNMF3S/ceT+0iG+MT0FK5lGPNxVORfJmlUATeNJAsruPYB/p4Azplj0Ci4NGwplC4oJm9XIH1sqlwxmwu+bxg+P7NV6cO60i2LD0AQAUdEuzraaUwdGtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc4SyHjM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7490702fc7cso3166163b3a.1;
        Mon, 28 Jul 2025 17:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753749119; x=1754353919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Jz6iF8q/yFJCJ16p/k5WRpifZDd/z8EpWvv3BpRFNk=;
        b=cc4SyHjMBEN1iRfGVX5I+KOsaeunL2O0ryTAzghx01sbK991AJczSuRWsR1lgCAqW3
         w6xK/cXlN97ZzGHCGompu6StAGlrc0t6a8zxb6DZkgzuvPzmDLEJAulnKSV6y99k0z3j
         ImWIKVCryIjCSYKnUlMrs86Nin17hkkfZmi+UkbAJzU/L2H58d8VFmK1xR2qn/HPfRWT
         NFo/yi8S9/WITnIsrlMFJ19Yqu+44bGFlMj3Sv0w3QCsu6cHBSsc/Xe6HjylSv0mbKP6
         Bvz6PpB3dBWJ8r7DhJP+FfONlrr3wq0rE4nUvvhP7MjaFxm6JRVWrcRvZVwXfm+XHahc
         CTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753749119; x=1754353919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Jz6iF8q/yFJCJ16p/k5WRpifZDd/z8EpWvv3BpRFNk=;
        b=Wno0TYDZ3vJMKNc+m7zQGFhw/AtHawYZpIDYePOMnvnGEsp7fnPsMniTUHI33YnlgO
         Az/dxshjqL27H1Ywtlw7NtjejVigqX0swwhXQXTUal6BEYvbaxPOKyf//6TbsNCR6dCN
         jUgla4SbDXcYeDAsjH8JwsFaAFTGtRr1BbHmUNxNUsb7OOakc2wCvaLUFLCFo7aGEYrz
         0dszlnOaaqkUxnVmqnsPBLjPz73BT1AWnz8DYUniqw2AD9jD0CXYxhpctzl1yJr5DVB0
         dO7adBXmZu9Z1SgBMNqbjRF3f4QqGPNhxP78iNDW2pEDz2nsBIwKh3zyFGKbfpMPmwIC
         iNPA==
X-Forwarded-Encrypted: i=1; AJvYcCUOWA66/pwpUoQbhNX4nLYVWa17hRNYVUjlpHMMuyhjBqT8EEol5f2Coww3hNhtzWCmJ4uLGYk/Me+UXGy7kgI=@vger.kernel.org, AJvYcCUbsLu63slDfrGqF4sQSkRE8GDdAlRIZC3EnK8UxvXnit9pkk+T7zWxueeqWTwNH2ZNUrg7J4zTaP4LYUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOEViIpQRmh6emFVBeLqGzgkVAN5r/rncSzRLeB3He76n+n3+G
	1BdOVfQeSkRqtkk67sSBpesBrslIDGaUYzrTcGQ9vYqrInSFYETZqKTj
X-Gm-Gg: ASbGncsoMvi9H31olkxhcXJgymvkXCgj9VYxx5m0e9MxiyBUks8+GR2A01ANvoaEZUQ
	90j5kGSKlkja0ymoYdvhJZygMnIZmmOB5AZR9NBaOFDdOpNqMejrFXwATU0D2qp5EgTFskS8FxZ
	4s30OB7ElqCkHuusBFTR5x792xbED684TPuPbNMIE+AUQF0LLzsZvt/f9lSbp2kFmbgu3s40Ds5
	p7MFrRUh7UbwdOwYa27BxZl7nZCAJcCJUWB+LahF+mKYiW4SsHFkXn8lzHxHTUF5lvBe5OVFwkM
	diiCENv/qkl32FKnzhaESw6LF0lTN+ZeG80/hKev3ymnv4npBZcqAxNVG8rlx1U2fPQJmgVV9TL
	UfOJmS7YRJOSiqpKKL23ZpaN6b7EUIyJPm/s=
X-Google-Smtp-Source: AGHT+IGzYlSKiWdEk9YIJwMO1mmDe1SmXkX9wPe/K7B830GQSNHWlQ322spZwyZruRrhP4xlAXckKg==
X-Received: by 2002:a05:6a20:7f8f:b0:239:c7c:8de8 with SMTP id adf61e73a8af0-23d700245d9mr20512119637.12.1753749119539;
        Mon, 28 Jul 2025 17:31:59 -0700 (PDT)
Received: from pop-os.. ([2401:4900:1c96:2e3e:1600:4d4c:911f:a526])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c024c1sm6506531b3a.33.2025.07.28.17.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 17:31:58 -0700 (PDT)
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
Subject: [PATCH] rust: pci: use c_* types via kernel prelude
Date: Tue, 29 Jul 2025 05:59:43 +0530
Message-Id: <20250729002941.7643-1-abhinav.ogl@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhinav Ananthu <abhinav.ogl@gmail.com>

 Update PCI FFI callback signatures to use  from the ,
 instead of accessing it via . This aligns with the Rust-for-Linux coding
 guidelines and ensures ABI correctness when interfacing with C code.

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


