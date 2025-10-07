Return-Path: <linux-pci+bounces-37654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE16BC0D90
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 11:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B7D04F4348
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8773F2D8363;
	Tue,  7 Oct 2025 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="hEtcKJjD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB22D6E6E
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829019; cv=none; b=a9Ei/aMC4EzJgTTOZwFns3itnQIzoEWUlstb+Cqia5NJxfSGApQAfkoW883v8XfhmiFLOfupGX1g2Tvz3EvDpduz355WWWEqb2y6wrR3QqdbzVfXRGrLUu8KKB8026Os/q/VOlRxzBV+R/yn1d7zlvT7CUVOJ4hx5n6cfK13jDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829019; c=relaxed/simple;
	bh=U4GkNtp5nOav2nmyt8vVluDERiX84m/g+t6fg257pzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQqOqPS7Y9xpeyGyqkJz/LdPuYsKqb7jCvC6sbnsULbtp8NiZzg69xZKGjboCyEvcBtXCLsiddXq6kqnbVc+DwIJtFfWPcc3uWm3prfP8sZw0RH6wNRhR8/slFduDhfGzkFJmn928C2KAFxFhM/Lo7bn6Q3H7FadmWORAiJ5Nlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=hEtcKJjD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4922290b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1759829017; x=1760433817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9DzUNgYrybOaCJXzvxFTfL7BnySvd74Sjls907O7gc=;
        b=hEtcKJjDf9vw4WN4ebFEKxEDRjTEh+g9eQLRDU8K3LIp6gfMRhoyamZOhFVozZCMDM
         wDCw5U2e/nFRkiqgM52mnFU0aH3Yy/sxv4rWvPF6D6+q3fFpDm1F9evs6ao87cJHJRJg
         6XWW1UzDKPNZo3VbuEV4NKg/gQfJJyztZWA7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829017; x=1760433817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9DzUNgYrybOaCJXzvxFTfL7BnySvd74Sjls907O7gc=;
        b=c3Wp7qHbygh69zXXY8H2p7O4JDYlC+iUQF1UN6zeMaN/AUl40miCSXWZ3X/J3/+XS8
         1ppku6GsbDL4iB8trDzs7pXs7y4J0OayVuvrJNLFA0weFk2IIXpvsAtdDJUoo2uBCOds
         dqeAbwuJy/ELXWNYegKShnqV9ddr6fooX3JPh96aLK/IkerJmT+qFdxAUXtinZjnJj2n
         UTKtMGRTbYgAWLea1XA5FOHxJ/viBl9+KBRP5JZ6daLVllKBcGgGd20UU0+OxUtY5Xn0
         Lhlw1gZbZ5qqE7oVyiVMX1bTxcckO+DLggm1oqoYxRDseCcICyfRjXvzGBJQJLg43uuD
         xBrw==
X-Forwarded-Encrypted: i=1; AJvYcCUhMaIVPuCT2vqaEUkow44c1M1v+X8jtgW5ZIOdjbQdBYNszRsa/gqtafPfMXl/nnPFyFDThc2tiFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcHzV7Ebl/OzXNWj8piVsfSBIM8YH2kd+DNOx1PE8J+mbrK29Q
	OGmHwHpPmIpHkiKxScwLFq/GHOnjvGjiyVueajjsUwQVWnWs+2VvXNuLFzT3BdHJtqU=
X-Gm-Gg: ASbGncuCnlDtYYbFNncpBMQsBlreb92Fus4Fj4J4SOkHfGlmiYziJBHs0jLZxZ8L3kS
	rxLH8p8jXoJOaifOHpwH9IVcitRTtopaQow5d6PfL/4p+l+oWWkqd/8FPEhxfLsj2WROwoe7uyN
	wl46Sp7gDwSlBbe0BkvBTMZSxKh76JE544pRh5uLVoUaC7oolDCSfBJsAfvv7P3YpMxxiZOLF+V
	y7M8Ay9ysvBEYdkduBcGR267vjXu02Eqm+kBqRTidAdbhKLnFhokR4fthGOmcH56WDowtsEkwec
	x0v6XGmy88aM6PqWVRmtCid8U2upLyzBOksUod71rBwQriP36nU78Xsydn6Dw1JktIDFOyF/VWA
	yrn9qokU5v27HzASAF8iaicPUHLTucvYOpAkjLiGQoMZKNygOfcNc4h2UwfdPddKOFZ11SK1M2O
	Ah3PLWzvdsc64s8JOsj0IuTF0jcOvAkjFo8+4=
X-Google-Smtp-Source: AGHT+IEwApYE4bcVoj0TdA/p3fC9MzhC83ylm4Bt3jZjLY09+Fp8yf60U6Us/aOsm75FFyq+QvCLWA==
X-Received: by 2002:a05:6a20:e30b:b0:2ce:67b2:3c41 with SMTP id adf61e73a8af0-32d96db80dfmr3802640637.5.1759829017271;
        Tue, 07 Oct 2025 02:23:37 -0700 (PDT)
Received: from kinako.work.home.arpa (p1522181-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [122.26.198.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-78b01f99acesm15123273b3a.5.2025.10.07.02.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:23:36 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: linux-m68k@lists.linux-m68k.org,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [RFC PATCH 2/5] m68k: Increase number of IRQs for Amiga to allow for PCI
Date: Tue,  7 Oct 2025 18:23:10 +0900
Message-ID: <20251007092313.755856-3-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007092313.755856-1-daniel@thingy.jp>
References: <20251007092313.755856-1-daniel@thingy.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the comment the Amiga has 24 interrupts but I needed
4 more to allocate irqs for the 4 PCI interrupts.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 arch/m68k/include/asm/irq.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/irq.h b/arch/m68k/include/asm/irq.h
index 2263e92d418a..ec944dc27710 100644
--- a/arch/m68k/include/asm/irq.h
+++ b/arch/m68k/include/asm/irq.h
@@ -24,7 +24,9 @@
 #define NR_IRQS 72
 #elif defined(CONFIG_Q40)
 #define NR_IRQS	43
-#elif defined(CONFIG_AMIGA) || !defined(CONFIG_MMU)
+#elif defined(CONFIG_AMIGA)
+#define NR_IRQS (32 + 4)
+#elif !defined(CONFIG_MMU)
 #define NR_IRQS	32
 #elif defined(CONFIG_APOLLO)
 #define NR_IRQS	24
-- 
2.51.0


