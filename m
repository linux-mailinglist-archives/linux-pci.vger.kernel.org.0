Return-Path: <linux-pci+bounces-21642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C07D5A3895E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0015518861B5
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE607225A46;
	Mon, 17 Feb 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k73Kuf4x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F0422578A;
	Mon, 17 Feb 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810250; cv=none; b=cmY+VhzMR5o2yyEiqISTgqYrui9KIfZkEYWMiTueYzpPft6gUoM9rWNwVlgYsI8kkxaB5avtnTwF+BpRP2CgfbDR4Cp7TTMsdni3f7tpK1TLQwmye3Nh2cRLp/a86gssAMNoLd03eXzVfNHMmNViZTLbLjyk2oFzAkb/sBgO+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810250; c=relaxed/simple;
	bh=IanXyIVqTh9J6eeN5W1FxKF9ROn0I3ECBY3aYf1iB4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSXCsuM+mDkD+FBsj/wR7W35gA6qOGUHxMZaRs9HsfDIjPk986I7+6H7ZeePJczzi/2hVms9LdEmAeJtjGNbFrlQa1QZVf/5iaO2zPlC4xBEuFgU6Mv1TQ+ucLt6i4UhIoGRjA0uOWzTL1UdPU/F9AntYvCghdE1lCGSoEUWEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k73Kuf4x; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43962f7b0e4so27681985e9.3;
        Mon, 17 Feb 2025 08:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739810247; x=1740415047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZ36QZVLWFwcj8T2KkUEKH5QEwqEfUJk7NDzYKKZiQU=;
        b=k73Kuf4xKVjR6d5H0J25/FMEMOGSnm2oRpMvCDCKddgxjfE78hQh3mHP+eZtUvasBr
         MDdpYtp/uMS4cGMrhpEXyYw7gMyIzUUZLVKLXpPuwjzt4RQNCRw/VEBBbaUDLaNn4KSl
         3B5Yzfjg5pwif6KKGApYFGa7Au5/evJXpT7qYk8bQceMko8mWQY1MpoIVDcTg5kg4c2h
         GUBfuuVexW+ajIvi5PYFOZFWnx8It/1HyqaLq1rRT4wWss5edVMv9P5fg49Z84UfSoms
         eOdFfFNHkQc/BaG7+UCjz80QDbUd+WU6t3c901iYJI7e/1/+kMU8fAbUfX1i2TPXQF2v
         MMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810247; x=1740415047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ36QZVLWFwcj8T2KkUEKH5QEwqEfUJk7NDzYKKZiQU=;
        b=aKRB8OnsEHrTEhgsad3yYxA29ppudkwc6UliEYvkk6MiOQcZY1nSSvk4FbFtj4ZCqc
         3D1Sveu2yP+ZzQu9yhYByJ1k7cQLAF3+AUVzWPyCAcS73DT/eqe2T4Zk71S9othg/kkm
         /a/nlGyHdvwkRZNBnOFdXPfZ/nkToaDVFINKzN7lCuMqy3EVRrpopqjR610kbo0CwpFy
         7SxlXwr1L0+4uMsbiXJMo6Mq7nZYgPe7FUve+RUQfEUz4LiFVfCZ37+PYcig6wzcAMle
         WnhlT9BkGF2mE25XKp8DOXfVlCHImqlXHN8rSbasxyncWLM5Q9Gu+C2DAIpaXrxkBULt
         rTpg==
X-Forwarded-Encrypted: i=1; AJvYcCUKkltFNg1jIiajf3zb8OVV4Dhr+hpjfTO0dRu1I1xa5ejAo/oCA+7ysnjARplcmNpoMEwb0WHtQJpk@vger.kernel.org, AJvYcCVK27wucPTjxFVHfZMuEDQpT2dkjt4ChezJF2KzBcgCSsjiY/DWXp8T7Yb/dFKUPJyx2tg+Pnwh4Mc=@vger.kernel.org, AJvYcCVTHdTDy+QWstaUM4EjmdfDbWlmDA4mRkwi4sQx6+Gld6lD/rHvfkaeGEPGXoU/XOiG8gR79ivo89NcCg==@vger.kernel.org, AJvYcCW9SZZChRA4ibB2VK6P6RInQ6rU6NsQ9fuouxyXLySeIGPUykLPcUC7vJGT6tt+x2yS1g3TF/kT8BaI0Za8@vger.kernel.org, AJvYcCWcQUFNEmLJCo5bwTGarIiO3xo4XCYybiYTHAoiHu1bIW9HX+MVRa30q9X8csUv8RCHJWiIvTTAFxV0@vger.kernel.org
X-Gm-Message-State: AOJu0YwS0gGSsn79JaJfIr+paucJJSUbTgdOV1vjvafQLlNTtIVlmCaI
	ENzw3wnOYeW+EWpwUkWCKlP0q7Dy/HekRb4OQu2wWSYp+jCrfphb
X-Gm-Gg: ASbGncvJbyys8kUGS4EhitxwaZIBzZCtw1j6klVZJ3xykOaegw9EJFwYP0DeDaBJRxJ
	w7Vt1ydEgVJm0wY0IGG3IOkMgRSzIOqyojyB2+ZuUN7Ml2jIrRujlqa8cTk895xAwD88hL6/R4s
	vggVcL4LUre45Bl0UQFqSi+/nljaiX2KzA15tPhBcayg75//08asKgvunC1B8j03KnDZ5PMngYk
	HkPBCWqyA+4qBaDwYoEE8iP7XPcLXZmxoldWWY52jjlzWn4yDDqVSED4eqymftrxa/1btR+DV5I
	CswalMTDRc37Yf+m2Edb/axva9WmX4pyavCwEu5thOZoM3b6IUWwCzzHcAgOJsUxTHRNYy0aiiH
	RoCO5BYM=
X-Google-Smtp-Source: AGHT+IEy54knXhOWSdtV9GyJZiVARzLmEOfX1F7j3ZG37VozHahpHs0vmYGUgUyc0AkFNGY48X3mRg==
X-Received: by 2002:a05:600c:3585:b0:439:5b36:b4e3 with SMTP id 5b1f17b1804b1-4396e6e19abmr89349955e9.12.1739810247218;
        Mon, 17 Feb 2025 08:37:27 -0800 (PST)
Received: from localhost (p200300e41f22a600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f22:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439618a9ab0sm125047905e9.35.2025.02.17.08.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:37:25 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] bus: mvebu-mbus: Embed syscore_ops in mbus context
Date: Mon, 17 Feb 2025 17:37:09 +0100
Message-ID: <20250217163713.211949-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217163713.211949-1-thierry.reding@gmail.com>
References: <20250217163713.211949-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

This enables the syscore callbacks to obtain the mbus context without
relying on a separate global variable.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/bus/mvebu-mbus.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 92daa45cc844..1f22bff0773c 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -130,6 +130,7 @@ struct mvebu_mbus_win_data {
 };
 
 struct mvebu_mbus_state {
+	struct syscore_ops syscore;
 	void __iomem *mbuswins_base;
 	void __iomem *sdramwins_base;
 	void __iomem *mbusbridge_base;
@@ -148,6 +149,12 @@ struct mvebu_mbus_state {
 	struct mvebu_mbus_win_data wins[MBUS_WINS_MAX];
 };
 
+static inline struct mvebu_mbus_state *
+syscore_to_mbus(struct syscore_ops *ops)
+{
+	return container_of(ops, struct mvebu_mbus_state, syscore);
+}
+
 static struct mvebu_mbus_state mbus_state;
 
 /*
@@ -1008,7 +1015,7 @@ fs_initcall(mvebu_mbus_debugfs_init);
 
 static int mvebu_mbus_suspend(struct syscore_ops *ops)
 {
-	struct mvebu_mbus_state *s = &mbus_state;
+	struct mvebu_mbus_state *s = syscore_to_mbus(ops);
 	int win;
 
 	if (!s->mbusbridge_base)
@@ -1042,7 +1049,7 @@ static int mvebu_mbus_suspend(struct syscore_ops *ops)
 
 static void mvebu_mbus_resume(struct syscore_ops *ops)
 {
-	struct mvebu_mbus_state *s = &mbus_state;
+	struct mvebu_mbus_state *s = syscore_to_mbus(ops);
 	int win;
 
 	writel(s->mbus_bridge_ctrl,
@@ -1069,11 +1076,6 @@ static void mvebu_mbus_resume(struct syscore_ops *ops)
 	}
 }
 
-static struct syscore_ops mvebu_mbus_syscore_ops = {
-	.suspend	= mvebu_mbus_suspend,
-	.resume		= mvebu_mbus_resume,
-};
-
 static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 					 phys_addr_t mbuswins_phys_base,
 					 size_t mbuswins_size,
@@ -1118,7 +1120,9 @@ static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 		writel(UNIT_SYNC_BARRIER_ALL,
 		       mbus->mbuswins_base + UNIT_SYNC_BARRIER_OFF);
 
-	register_syscore_ops(&mvebu_mbus_syscore_ops);
+	mbus->syscore.suspend = mvebu_mbus_suspend;
+	mbus->syscore.resume = mvebu_mbus_resume;
+	register_syscore_ops(&mbus->syscore);
 
 	return 0;
 }
-- 
2.48.1


