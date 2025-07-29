Return-Path: <linux-pci+bounces-33103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A79B14C38
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 12:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF476545670
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 10:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E071121D001;
	Tue, 29 Jul 2025 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKY4T4MM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D8228C99;
	Tue, 29 Jul 2025 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785028; cv=none; b=X+Ausyt2XTKijbb6246FRJJsAZUT8Nzqw21JKi0LvWMCnT7zhw51DGxAMMBd+h9kly+398kKLMmEQ/6d6ofzYqrOQiD6Dk5uGQKyD6y9D1NvdI424Q6ozynMKBUZPQTlUQkZS9uD+ksL7pQhg3vsvHIb0W0ONutrfwpPkYK4WAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785028; c=relaxed/simple;
	bh=GDS2DivCVTjsuqAbeiYBAP4HfVuf2+VQktNWQjuhZqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LlrWf5obLJg9LcrLpd3WIb2i9Bv6rgXQn+NEO43kuIT67IzRbeNjdE+cT0c3IpH68ietudzTrXB1uMqnos8TQ6OkUjt5TQ+uuYujyOWYAp9HUB1o2XAmL98Y5dX8iqk4/Z0yDfvHYmVg/FE2eyXJLxk53mrzS+Uc/Jgmy7FPe7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKY4T4MM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso174417b3a.3;
        Tue, 29 Jul 2025 03:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753785026; x=1754389826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7VKvcC3HHzJrLAxDozGlxN+FIhSWHQP7yIiLAufEHE=;
        b=dKY4T4MMIHr4Akv8NQ0ypgkHFnewdRph75FEALs5MsAq7t4FNdbGUJVW4vjB4ha0Go
         n8OlK+aVLCJTmc224UDpYA1lk6v+6Ush1htZyVV41dRlXBhLKjISFBwD6CKgnI6Bq6YO
         LrlKHnj6uuRLX7zjzdBh2bGbXTXw4bWbjwkBoMOv2/LCauuP28+xEAlTxqGLlPiHTbun
         0sK2y7HXfMF/PY8I08enxzf7rZLZhX51zuRHrFBwByFwh+Z/RIJ8/bOe6kQVXooKsRUw
         SzlN1AMiLPK86p1lb+rS6R6vQ7VC89fFWTbEnYaHKrbbe+H6HPY5xVUcEXEbA2kwVhLb
         rJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785026; x=1754389826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7VKvcC3HHzJrLAxDozGlxN+FIhSWHQP7yIiLAufEHE=;
        b=a7nxn1jIhErZDON/E5Vi/0MElPyE+ZCVSs88S1M+M3FMtT0XGXSGlZPU4OPWtlyUAH
         sOV0B5AKbcWZBtn8pxqdQAztiSK/Ejg+xDfHvg2Tc5rGnVEycR3b5BfzGV81jNNGtNPd
         J3LddXotnGtFOezhtlWiO/PxblWhgsoJlQg+q31SgeZQePAdHNQU1NW9G2JWAkAYiZYD
         IeGPpkG2mdGw2Ut1Gr6EMXGv6ra52JSDtNk+5lW6vUg94ulEN8cMfhwdYaQGN0CCGWdP
         vXsMJfkebqcDxyq8dIUj92gXtXIBVU6nULaHsY5WLvWUTBQIlerLNhMN4NCSs4PCQy71
         KCfw==
X-Forwarded-Encrypted: i=1; AJvYcCWTk2pfoTLT+tkcZAejvwgi+NI86cPzHVoXT9yX+qNuBZbDqfWYv1EHcO+PUPscqhw4o1MYv2KiCa7NZfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHrPzxYN05wvkj7Lx8Kj743XOBwZ0TwPK70U7TU6wk1e8Uq0h6
	X87A+Cd7pVhhKG4l7rVR2TokpzP9NtLeXg82Ye2YIsJ4xux+aJFIySWnzUmoqUs0
X-Gm-Gg: ASbGncuuHQahVqBY5fwKO49aUkcOHJC/ECwmihzevRZdLpSk12u1QW+3AtX6tGoy6ld
	/Jykuy6SZY7PmTBNAEgbeJU2AofY8iAiKw7wDcn7A7GzJa+UhoDe7kGy7G0EgX+AraKN7uIO1SB
	2AGZw2YJjx8iGuT6LhJCBGQbavhx72lDtalex0pGJocT/MPMZUyJ4dLXk0iFUHsDWFEmcUUDZSn
	H005nW4hkYaB6ZGwTwVJCUVRPLIBbuN93Boghao1dvwZMp5rjGSDoF7rotdkMQNE4sR6tboBnan
	CiS7x/TkB/4PwmhwH8fDt0+lKJuM8o7VBAQnpANnPbSfA3XG7i9uhayyKbqnOl7knNPDxmcBaHw
	ZnqYMpwf8Un35J3f9hTuIUEDb
X-Google-Smtp-Source: AGHT+IFVd5vS3sqBz9mldXBBud0gro+383l7Zj3chGaPhaiisuezyFdfYPfF5WFWo3rfTZsLqYszCA==
X-Received: by 2002:a05:6a20:7488:b0:215:eafc:abd9 with SMTP id adf61e73a8af0-23d700e9754mr26792263637.14.1753785026070;
        Tue, 29 Jul 2025 03:30:26 -0700 (PDT)
Received: from pop-os.. ([2401:4900:1c96:2e3e:1600:4d4c:911f:a526])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-767979350b3sm4895419b3a.122.2025.07.29.03.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:30:25 -0700 (PDT)
From: herculoxz <abhinav.ogl@gmail.com>
To: linux-pci@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dakr@kernel.org,
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
	tmgross@umich.edu,
	Abhinav Ananthu <abhinav.ogl@gmail.com>
Subject: [PATCH v2] rust: pci: Use explicit types in FFI callbacks
Date: Tue, 29 Jul 2025 15:59:53 +0530
Message-Id: <20250729102953.141412-1-abhinav.ogl@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhinav Ananthu <abhinav.ogl@gmail.com>

Update PCI FFI callback signatures to use `c_int` from the prelude,
instead of accessing it via `kernel::ffi::c_int`.

This follows Rust-for-Linux coding guidelines and improves ABI
correctness when interfacing with C code.

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


