Return-Path: <linux-pci+bounces-27483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C81AB08BF
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 05:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B6A1C212A5
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 03:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5640D241116;
	Fri,  9 May 2025 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+JETfwa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07BA2459CF;
	Fri,  9 May 2025 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760623; cv=none; b=iZJcc9FZVG+GwEx5h1ZFQ+6Io6QX0P73e7zpPeSnFB006RbKPO+YbbBTPM7n9v6NtGbtGE8h6EOrY2hedJ30ooaTQGvO2bihUc/rcCDboF7uPfqzLgdzqdRz6LVT8z/lEa0P5RYesAbXqCt5Wxx/3wnNss3kWi7gVaZKW/ciL1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760623; c=relaxed/simple;
	bh=oU0t3/ogKLzH06pwPNF/J70MAEAOhQFXgT5neGWG3cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aG6f7gyQmVWG6+SsymRHii9oY7eku6aljAdpyxHXJkpJAsWZ8zIT3apSBkfUDFzF2kuZTtw8gRxnjHop9TscIX5OlpY/mtFaDC3JHepgoLu5/z+OgoNpOIK0AHujGiBEcA2hlebsE14XrjmelaJFNqP+A4QAuzs8WW2/UIAOHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+JETfwa; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72c09f8369cso620267a34.3;
        Thu, 08 May 2025 20:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746760621; x=1747365421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoqckDBCEduuhxuaJVPjKVAng30GrSpmzU1JLtBRF8I=;
        b=A+JETfwasbfpiJ1EOP3VkRXX6X0He9SIySEbRieJnRna+cbc7lplYW4cCe1ljaielT
         MpK4O11f/kPXHWk/EiWYlxVKlQTHPciswgUFs7LoT7fTLpn8eyikFutPA9MubWcq9xHU
         unClguhPrJ3Ne4cJZKo5fONn0FkM2xlhX6NJV4VfuTWeCdX/1szexwQbibZFrzMK7/8S
         h9ppblQvJ0vRcpilqLz/lnD2EpsT1Ek9MBeR8BDOdVFCwuTHXVNZO12Wl5c8aa8Wf+5S
         kzC+BnGwdyWEx7Yeq2LamLDUEKCSmLreOk+lwtrl49o4C5P2dS3A1IW+5Vyu7a92ppZt
         L6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746760621; x=1747365421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoqckDBCEduuhxuaJVPjKVAng30GrSpmzU1JLtBRF8I=;
        b=eW8yMJiZu7nuVHCCB93MwO0deKn7iCKf6e+yXb4FL8okt5uONiT5eUMzW4LzrA0IsD
         zz+Aak9XMmVGPapSbzUaHEA9xuhs/qWXuOnojedCJYRELXTOG+NMk9mBj4Zfd+qzS7gl
         eW9TKAHb50jIDpbvoca9Ke/tRll+nFDTGGRcVn8r2Bozt11Fopxig1yfmmJ5DeoqmZlS
         UeUPl+UyXh6jRtz6hxD9E69JUIBEdlo7G6zBDclt62OBxSvgcEQiKhNy8dnGYJKLvk25
         K1wZVgsmnV8SA+rFuS3OAeukkJjPHe0pQa4+gZpxUfhjDmz7bEBihv+P9dlhmZxBXPsB
         KxRg==
X-Forwarded-Encrypted: i=1; AJvYcCUFTIMW0NAW3BV2a3ajflwazVUU4nvSByywtZdjWBeYt9a0FSmiYirTfE1e5rRUGM/XeQZL1VnktGfR@vger.kernel.org, AJvYcCVF65wIHswt9c7yZsxQPq8x9nmQBfOFAP3nk4aFBYSCUUZhESLjny9DM9HmgmVaxYIupfk4fwvLLKulIIL7mgc=@vger.kernel.org, AJvYcCWPdTNGuyOjTQxW5H4EJm5TYifmgMH1vlfnpvXQdI5qvl3E3hTRE5PBLTJJcgyjYRrU0Iw2cnG0MBMCsxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydFmGVuLMzfFuq6XxYTmtxDBiVXX0uPcZCK3Cao0xN4xttae+t
	Te7YYHNbFIjxSZ8nQuJjOeGpyHayLkSaC1qQOnRB2mapTcfJu1r4
X-Gm-Gg: ASbGncuYBm/IH8bjI0uHoFYZn9/JcEOSDtd2hPwgMBiRebo15OlZKEy91Eaf6qFNM0b
	XUNNF97FCLxbDYZXYzZ9WHuviVsfBhG0nZRWz+7uBs5C6P/vQUHUbWlKSoqIxYoTUnJqzrow4bV
	036tsa6yOVCH28O0WT7+INq4KWE1pVU575DiOVHIpv7+wkU1kVqNt2rTKgaMG/KnZfsr7dUe7rW
	pgbOFx148+eYc2yXscqiTvDWexVP83Fq8BDVoWDLFH5WAMzKM0ezFRrXefdGnzrX1ena5fZi/Iw
	rTZaBoWjc6Hq5/N9b0OPBd9f5pmiylrywJnZ+JK7SFOlEIwF8tlx5qBSuH35aacCd9xVu29Xy1n
	zMhBoi5rD3gzO
X-Google-Smtp-Source: AGHT+IFJactH9R43mBMIGMb7nbzPeCuDDlGMTikD03Mao0oUkKw8j52bGTKF3TXqX8VwPN7rT3jqPA==
X-Received: by 2002:a05:6820:1a0b:b0:604:4846:78a with SMTP id 006d021491bc7-6083ff0ff81mr1538256eaf.2.1746760620739;
        Thu, 08 May 2025 20:17:00 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60842b096desm303745eaf.30.2025.05.08.20.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 20:17:00 -0700 (PDT)
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
Subject: [PATCH 09/11] samples: rust: rust_driver_pci: update to use new bar and io api
Date: Thu,  8 May 2025 22:15:22 -0500
Message-ID: <20250509031524.2604087-10-andrewjballance@gmail.com>
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

update rust_driver_pci.rs to use the new bar and io api.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 samples/rust/rust_driver_pci.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 2bb260aebc9e..b645155142db 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,9 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
+use kernel::{
+    bindings, c_str, device::Core, devres::Devres, io::IoAccess, pci, prelude::*, types::ARef,
+};
 
 struct Regs;
 
@@ -16,7 +18,7 @@ impl Regs {
     const END: usize = 0x10;
 }
 
-type Bar0 = pci::Bar<{ Regs::END }>;
+type Bar0 = pci::IoBar<{ Regs::END }>;
 
 #[derive(Debug)]
 struct TestIndex(u8);
-- 
2.49.0


