Return-Path: <linux-pci+bounces-27704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0799AB6954
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 12:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D1B4A7EFE
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 10:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58BC2749E5;
	Wed, 14 May 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS6RoZ5g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA8274672;
	Wed, 14 May 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747220316; cv=none; b=DvjOvnG8uRsc/ASlfoXfc5y0HVOKeGknkX/hM80Rxhiq0mX89566U5dtx2cscY65DZwpt4SIRqeYXusG8pKN/sFXEUSuC28m71UQ/5dsJoF8elnLLXXQCf3svO2ZIdy12B/pB+rnVCLgLHW+BF1v4OGToqENweUEr2a2eQtoU+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747220316; c=relaxed/simple;
	bh=+Jx0iphnXuSVjVB7a29W7yimG5/BrqeaURmJ1hW7NZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvKk9S/W/elONyf4fDF2kBWcJxRv9B9RLdQRc0vk1Cd1hKTvY1Zszz2hJ7wglHO9wOI52mn9+18uGNI+4eLcCk+XRM+C8zJHGpk9YnYD3gV/7AZHCqxjAIeI4N5DIzU6hvEMjHRhzRxX+Vvdlbb/Kg/32YBbQ/G6b8gy93KqfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YS6RoZ5g; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6062e41916dso3248600eaf.1;
        Wed, 14 May 2025 03:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747220313; x=1747825113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKfsulkMnbgwajcoUFefYum3KXkpP1AWjoY1QW06NXk=;
        b=YS6RoZ5grZNuoSpHhXfmf/u4R5/Nfr5o2DyQ8v0BylKYwtobkWj88oaZLP4pbRbsDk
         dTibry7ioKXWPPozJFcnMh1/tZz2VRTUdctijxLrGk+o/NCAxu/NFpCJL5SV2Vd4CrnN
         5TK3Qq008Nfj8Du0IqDF32no6XjD6sVgd3MgpGRtxS8JYkUYCd3AWfN3iEHo7HzJxMy5
         URsvpsC1p278FUfs5+pMD4YowchWSbOtz8li3YDQVMQJ74Wqv6BOKiI2j5/Q8ppJl5LM
         GSCbBoiLuOTyRjtdQ3JGDpQuK1o/tkBEgofN1q6QG/rkYYa011KQnJqosAP4mjr5HkhC
         rRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747220313; x=1747825113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKfsulkMnbgwajcoUFefYum3KXkpP1AWjoY1QW06NXk=;
        b=WGud1fMcRLGYjLR6bBvlVbF8nlMR8sEIHHrnikbJjCc26yeVFLpcRtzKwd3olz5wkQ
         zgqkIdmIJy8CWNFOwWG7fPrwF38OSJP7lbTTtEujnTWHO+8tn9gZAqRcJ+gxNkfXTGWi
         2xNIlmVzPSZw68eoaBSreehFkAQEs8yC90GD7xjcHfXXBlh3sL6sS+OsA9Z0IT1sk7ax
         ihl1mj3zb7XlCXzBv52OfQZKMtC6RzfkA/b4TUaFo2kKWjAt91Isi/Hrpq5YYUx7zg7y
         aKrEiuxux7N3G0xdY/QWr8KFuUl5BtANKyHGkWLutiMZjuAiG9Os+hXr2zveUjT3PUe+
         GpIw==
X-Forwarded-Encrypted: i=1; AJvYcCVir54BQQVFDCtMPsm6WFxGxfCacTGBAJGY011BkBEf+mC/Idqo54sY5PJ1H8x/RMx8a5O3Gxvo0ptlUPPQurA=@vger.kernel.org, AJvYcCWtbGO04Y83N6F/+Wwa9Fz79m9Lju/tKzokJzAuAD6/SSR7BcHrgMyxFViXI7PUh7i+xac6GGDwTOv9iO8=@vger.kernel.org, AJvYcCX/qb8KSaZD2112ONldSfQkmfucbspTqcAkfrZwK/rSDf2h3yl4DlDcK1B82VmiAVaff3fHntJCCxKQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyMSVbxU9qpn5fH5ea4XQ83MVONmThdPoGk04E62GUVx6WobkoM
	yAL9+okp7vmZLyVzfMy2ebyAyhvzH2GGXjpLj0N8RWzvDOeGk6mA
X-Gm-Gg: ASbGncsZlGUHn1MvNcQTB8QweZ6XXuw4mfRGQXM+fSYVGeGxoNwD8uqOc1+M34YD79D
	wE3XWWSOxxvgXDjZ2WopsH0bLV2UE7N4dFGoz5moxPqRVhoAFXg3daO1SzfR/33AGbS2lLWfx1V
	hLZaTHeGKIyPTyPZjVsli9lEwg3Y/xiCtHB47H3hVVxw+Zdd4+bfEZm23dS70y5tOFnIINhqzzc
	Pq38RDvU5S6zgFZUP6sCCQHtU7LjnsGc9t0sBNdmdtNWAGJdBsBR7MAhq+Wd1YePYOpOyAlpiwS
	JD7EUaNtwt81d++BUhe1+pSaU4NHdC62A4Z7lMoodsq4wEfD7FrkJ+lMCziHR93uB4rRjIWjOLS
	dPmjNOxp9ITMA4n0ZSOaY9eE=
X-Google-Smtp-Source: AGHT+IE+1hE1Q+/pQh+mW7/Ct4/eU4EaXfpxLHVjbsq6qa5H2UcdCaWDv6SmoJgr82fypqkELLhKzg==
X-Received: by 2002:a05:6870:4591:b0:296:e698:3227 with SMTP id 586e51a60fabf-2e348846b40mr1366801fac.36.1747220313459;
        Wed, 14 May 2025 03:58:33 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2dba060be9esm2654535fac.10.2025.05.14.03.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 03:58:32 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: dakr@kernel.org,
	a.hindborg@kernel.org,
	airlied@gmail.com,
	akpm@linux-foundation.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	andrewjballance@gmail.com,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	daniel.almeida@collabora.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	kwilczynski@kernel.org,
	me@kloenk.dev,
	ojeda@kernel.org,
	raag.jadav@intel.com,
	rafael@kernel.org,
	simona@ffwll.ch,
	tmgross@umich.edu
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 1/6] rust: helpers: io: use macro to generate io accessor functions
Date: Wed, 14 May 2025 05:57:29 -0500
Message-ID: <20250514105734.3898411-2-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514105734.3898411-1-andrewjballance@gmail.com>
References: <20250514105734.3898411-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fiona Behrens <me@kloenk.dev>

Generate the `rust_helper_read{b,w,l,q}`, `rust_helper_write{b,w,l,q}`
and the relaxed version using a C macro.

This removes a lot of redundant code and is in preparation for pio
functions which uses a similar C macro.

Signed-off-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/helpers/io.c | 105 +++++++++++++---------------------------------
 1 file changed, 29 insertions(+), 76 deletions(-)

diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index 15ea187c5466..d419b5b3b7c7 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -12,90 +12,43 @@ void rust_helper_iounmap(void __iomem *addr)
 	iounmap(addr);
 }
 
-u8 rust_helper_readb(const void __iomem *addr)
-{
-	return readb(addr);
-}
-
-u16 rust_helper_readw(const void __iomem *addr)
-{
-	return readw(addr);
-}
-
-u32 rust_helper_readl(const void __iomem *addr)
-{
-	return readl(addr);
-}
-
+#define define_rust_io_read_helper(rust_name, name, type) \
+	type rust_name(void __iomem *addr)                \
+	{                                                 \
+		return name(addr);                        \
+	}
+
+#define define_rust_io_write_helper(rust_name, name, type) \
+	void rust_name(type value, void __iomem *addr)     \
+	{                                                  \
+		name(value, addr);                         \
+	}
+
+define_rust_io_read_helper(rust_helper_readb, readb, u8);
+define_rust_io_read_helper(rust_helper_readw, readw, u16);
+define_rust_io_read_helper(rust_helper_readl, readl, u32);
 #ifdef CONFIG_64BIT
-u64 rust_helper_readq(const void __iomem *addr)
-{
-	return readq(addr);
-}
+define_rust_io_read_helper(rust_helper_readq, readq, u64);
 #endif
 
-void rust_helper_writeb(u8 value, void __iomem *addr)
-{
-	writeb(value, addr);
-}
-
-void rust_helper_writew(u16 value, void __iomem *addr)
-{
-	writew(value, addr);
-}
-
-void rust_helper_writel(u32 value, void __iomem *addr)
-{
-	writel(value, addr);
-}
-
+define_rust_io_write_helper(rust_helper_writeb, writeb, u8);
+define_rust_io_write_helper(rust_helper_writew, writew, u16);
+define_rust_io_write_helper(rust_helper_writel, writel, u32);
 #ifdef CONFIG_64BIT
-void rust_helper_writeq(u64 value, void __iomem *addr)
-{
-	writeq(value, addr);
-}
+define_rust_io_write_helper(rust_helper_writeq, writeq, u64);
 #endif
 
-u8 rust_helper_readb_relaxed(const void __iomem *addr)
-{
-	return readb_relaxed(addr);
-}
-
-u16 rust_helper_readw_relaxed(const void __iomem *addr)
-{
-	return readw_relaxed(addr);
-}
-
-u32 rust_helper_readl_relaxed(const void __iomem *addr)
-{
-	return readl_relaxed(addr);
-}
-
+define_rust_io_read_helper(rust_helper_readb_relaxed, readb_relaxed, u8);
+define_rust_io_read_helper(rust_helper_readw_relaxed, readw_relaxed, u16);
+define_rust_io_read_helper(rust_helper_readl_relaxed, readl_relaxed, u32);
 #ifdef CONFIG_64BIT
-u64 rust_helper_readq_relaxed(const void __iomem *addr)
-{
-	return readq_relaxed(addr);
-}
+define_rust_io_read_helper(rust_helper_readq_relaxed, readq_relaxed, u64);
 #endif
 
-void rust_helper_writeb_relaxed(u8 value, void __iomem *addr)
-{
-	writeb_relaxed(value, addr);
-}
-
-void rust_helper_writew_relaxed(u16 value, void __iomem *addr)
-{
-	writew_relaxed(value, addr);
-}
-
-void rust_helper_writel_relaxed(u32 value, void __iomem *addr)
-{
-	writel_relaxed(value, addr);
-}
-
+define_rust_io_write_helper(rust_helper_writeb_relaxed, writeb_relaxed, u8);
+define_rust_io_write_helper(rust_helper_writew_relaxed, writew_relaxed, u16);
+define_rust_io_write_helper(rust_helper_writel_relaxed, writel_relaxed, u32);
 #ifdef CONFIG_64BIT
-void rust_helper_writeq_relaxed(u64 value, void __iomem *addr)
-{
-	writeq_relaxed(value, addr);
-}
+define_rust_io_write_helper(rust_helper_writeq_relaxed, writeq_relaxed, u64);
 #endif
+
-- 
2.49.0


