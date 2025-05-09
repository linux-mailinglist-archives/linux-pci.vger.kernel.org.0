Return-Path: <linux-pci+bounces-27480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A89AB08B5
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 05:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6784C6442
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 03:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1300423A99D;
	Fri,  9 May 2025 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDhVI6L8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9341E1DE8;
	Fri,  9 May 2025 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760607; cv=none; b=O0F05jNUSKZVcnlaOkrZVmSIfNvCAAbNS4aCihDGKBoIw7SU5R3C8OXuNPoDDdMKIUbF5qhQTjWERuBeAXXSbFeKAbJnkEo0tdh4pdmemrCb3cjfT09OlvMm6Uvfz179wkxBvRw7QpeQ5BHyMvp6zS4/c+9tndAGe7/jbtFdr3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760607; c=relaxed/simple;
	bh=5NusMEIBNJoOBsG9vJkAZLaj6705hfOlvFPszf7vOmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y20BN1oBuMCPief94pbPeRT2ay9AF6DlgtYGUSDZg7N/7SiCQQSv3VmPlArErayEZDn2vYejcuNWbJrdLlFRiwgjRDWFnvMl6nRoKEbFBA0d199Anklg8xApCfA/YPhu0t3gt9Yj5FPrZY6/nInpdOz+YZAe50hJD5UQUFKH9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDhVI6L8; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6060200710bso835877eaf.3;
        Thu, 08 May 2025 20:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746760604; x=1747365404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJ+SSE57+NVD+voAZIpxys9eSbuHtPfvcAY3huVe52E=;
        b=UDhVI6L8pP0Qu+BwC5sK997whar4KVgqQKz3qRl0EAj30xgL9iexQbiSAi4ylHw5CU
         9R+CClx3kKwtEOWwW/yi+lipg18+/fRgn/TfdRGEA4/qAgnncHVN0+49N2Y1z6VapY9K
         dQrFvDfAifo75P3JuZJibijE27ZXadMKmwGiuo7PsCrDz+EMifYNysYnn9MyOAw04Z3y
         f86PIKa/iD5F0PBLTheFIpxqD8u/Mp2V4ltzVh042y7tCTHjhiBHgo0Ce5QhXHzOAsYn
         vq5UO5yGIuUAqwc7mJhBNzbclbcBlX8wgm5voUiZ8MYbby0U+rarL0La88jFCvUb7IX3
         sgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746760604; x=1747365404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJ+SSE57+NVD+voAZIpxys9eSbuHtPfvcAY3huVe52E=;
        b=vM0bLWModzt1QhM6pgDkH+SxWhb9cQT4lTQpmg1ydu8z6pVcKEXuHlrDQZXUFQzW2p
         bRFRA/kYdhYAHj3/UXjfWksT/nm3ykjp5g9x3s4sO8Bxg2yjwxcpRGBYS3mOYzVHKxqL
         vxVsNNewcoVAceCrfTW3K29YO3LaKRKAYQdbg2i0bIc9ZZaXinpbwikdyhtVgI4A/QLo
         T2l/rXMVWNIArvXFnm8JN8+hZBucTkvvqIR/DVkqLpQdz35jk3ttDrwpAxCPVJEhZ9Lg
         oQIZ9uPnCNarXHA1b9zfKWGTtZtc0k9WtPmXJ/2DhI1R3plD2b981k32T7Xh0jhwqN+w
         2F1g==
X-Forwarded-Encrypted: i=1; AJvYcCV/Wth9P4E0mudWC0PNyTIBYektSrvHRpaddfzhnsqCWpcCGX27n+F5TqtqQ7LXJUJwu5QngvuzBN0eFPk=@vger.kernel.org, AJvYcCXUdXlZ7+/xvjxgLgD3P8/KIRbswGHIGWErq1qJ/kloqzUSBsYvd6HWdscaYNW197auZrdr/Ixgw9/N@vger.kernel.org, AJvYcCXpI0qbd1CY4REF90BWUbgNPrqJEechaP1j/T5VwGTuB1NQWJvBKyyaLL0f8ZRwISppmV5Me709LXvZo6kPCY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5dGjfKZnblBnVTdPeoYY5WgDiP1F6sDs8LecwIvnYkpfGYgbX
	sgS0IzlzIfsONIrm+r8TGmeOgX+xAF66zA2Lp8YvF0Y9twxGV41wyKxvPFap
X-Gm-Gg: ASbGnct8NAsL7tSsGnD4F1hpZ59pWJSkN7XvgZBIEo4oQ9iW/xWUCggRkV4k1YO6p1f
	5S+1aOX6mT1zoF5DomNwNDVOnjbD/zpYEO+FUWT0QZRvm1xvs/yb+2jVg+gA7KlKZbNDMstwzUQ
	qutmFqwZw07XG+Jco85Zt8FSWb4tcKuzOzH2BzYBG3qKm/E+JWlJ+QvPL88cuf8F7Q9Q29xYhpV
	eqsgddAKL+dnlKqLAGpCFZIJpolCadxKUgLS8chQk8s5mEh/3qHGar9+q7X+7LIKF01XtzAgs3N
	7pQLjLoZk60R9URElyBYFs64yrsXowGWQ55DThEYgC0NJNuTLxhKYa0Yex9ujfdPkIfZFfRSbdg
	KwblPCMK5XcJd
X-Google-Smtp-Source: AGHT+IGpMx7dY3dkHvqr4awICZ7vr0q2bv50WztDT96Nqcfn11nY3aHVKib+jqiYd+/U5X2LVifHrA==
X-Received: by 2002:a4a:ec44:0:b0:606:293f:f37e with SMTP id 006d021491bc7-6084c0ff314mr1382389eaf.6.1746760604235;
        Thu, 08 May 2025 20:16:44 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60842b096desm303745eaf.30.2025.05.08.20.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 20:16:43 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	akpm@linux-foundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	raag.jadav@intel.com,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	me@kloenk.dev,
	andrewjballance@gmail.com,
	fujita.tomonori@gmail.com,
	daniel.almeida@collabora.com
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 06/11] io: move PIO_OFFSET to linux/io.h
Date: Thu,  8 May 2025 22:15:19 -0500
Message-ID: <20250509031524.2604087-7-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509031524.2604087-1-andrewjballance@gmail.com>
References: <20250509031524.2604087-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fiona Behrens <me@kloenk.dev>

Move the non arch specific PIO size to linux/io.h.

This allows rust to access `PIO_OFFSET`, `PIO_MASK` and
`PIO_RESERVED`. This is required to implement `IO_COND` in rust.

Signed-off-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 include/linux/io.h | 13 +++++++++++++
 lib/iomap.c        | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index 6a6bc4d46d0a..df032061544a 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -12,6 +12,19 @@
 #include <asm/io.h>
 #include <asm/page.h>
 
+#ifndef HAVE_ARCH_PIO_SIZE
+/*
+ * We encode the physical PIO addresses (0-0xffff) into the
+ * pointer by offsetting them with a constant (0x10000) and
+ * assuming that all the low addresses are always PIO. That means
+ * we can do some sanity checks on the low bits, and don't
+ * need to just take things for granted.
+ */
+#define PIO_OFFSET	0x10000UL
+#define PIO_MASK	0x0ffffUL
+#define PIO_RESERVED	0x40000UL
+#endif
+
 struct device;
 
 #ifndef __iowrite32_copy
diff --git a/lib/iomap.c b/lib/iomap.c
index a65717cd86f7..e13cfe77c32f 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -24,19 +24,6 @@
  * implementation and should do their own copy.
  */
 
-#ifndef HAVE_ARCH_PIO_SIZE
-/*
- * We encode the physical PIO addresses (0-0xffff) into the
- * pointer by offsetting them with a constant (0x10000) and
- * assuming that all the low addresses are always PIO. That means
- * we can do some sanity checks on the low bits, and don't
- * need to just take things for granted.
- */
-#define PIO_OFFSET	0x10000UL
-#define PIO_MASK	0x0ffffUL
-#define PIO_RESERVED	0x40000UL
-#endif
-
 static void bad_io_access(unsigned long port, const char *access)
 {
 	static int count = 10;
-- 
2.49.0


