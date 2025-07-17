Return-Path: <linux-pci+bounces-32371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E9BB08AAA
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EB4189C432
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 10:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D19129ACEA;
	Thu, 17 Jul 2025 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1/gMg7j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A129AAFD;
	Thu, 17 Jul 2025 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748378; cv=none; b=pTwgyvHTb9S+gR2X7ya05vIyROxV8yMlLSQScvJRGEOr7MbqoEBZVcYHP9XSBewOuVAIwoKShej1snvOYO28oIs6atcpqukg/aQ8mZoMiJFPc1k6NYw+3++F5txF0rAHaQsnL2TZuKkyEMfqsLU4g4eGRdJWVze7n4Iq3M9BlFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748378; c=relaxed/simple;
	bh=Ngdxmfsw7khuHkpFPEaaMiq7KTg8BovR3y92Uhy13MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEg4aDqctzAyyi48sbW9Bu7S/1gbAcjnu4yOlZJMWmevvh6Pl/i/kTTsNKBouas8nCzyLeuHCTucmOOsL7YgRwltl/G2UGuMx13UDUTHd6JzeL9IBY2YMAbrx8XR96Msl90o9Gl3rpmIO/gmwe9McuVv/bFbeCQznH/Lmr1KJg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1/gMg7j; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so761284f8f.0;
        Thu, 17 Jul 2025 03:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752748375; x=1753353175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GoTBLEmLxVjzP5x5JCQ9EAKICcOeZGsg/sgJv78VUk=;
        b=E1/gMg7jpSl/MEfjC3iz4aomo7hZtZg7t8yHZdW6U06EnqJM9bzyw32F1AuQn5Ytkt
         T+uiEYwp8yzSWD7cUas/hwhop24FpKutwcnwOn7/uboofksbvx3lPXO6goLXQTzQNmhg
         F0XHJ+zhck/xc/YPxbRNKBfupy3kyE56rMG9KmmKClGchs73LsObKpoKCWByALAfWQl0
         dC9amEK0xM4HIEu/yZdPKwwgr/0ETyTs51j74poEnqwH3kOrcVEVOggVz5H6vvE1K0wA
         rbvbcLg4izQedhYTcVd2qzjVMDp0rGuB/e8PYiPbXjLvWjOD/tCwojm4FPllIQZkVReF
         Qa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752748375; x=1753353175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GoTBLEmLxVjzP5x5JCQ9EAKICcOeZGsg/sgJv78VUk=;
        b=o6v4b2DfJubCnnLb6e2LTM707sHddzOePxedwfguL/8KgmJkfA+ReVujNV2pwp4BeC
         UOqD+HA8oXDoQmueJd4LqYuzbzZn53D/GdmCoL3v8SEqSNtxO7lAhFwSMLdlZWPsIrbH
         Sc64zHgYLCMZLbqxLks1mez8soKUpqONpGlhm6KzFvCpcukSnOocp1cDfjTTCEve+WgQ
         4wVJoRt43E8L9qPjyeZoqbdh+IY3tAAQtVjONzAjvDqp9y4FSHurC/qCFob+8/HG8sK2
         NnUGntVctNGJrhF/EGREkgoJqG4wqNsxAbhgRfEgx4b36l4U1xDUpBpVsxQm5raY8jZp
         55Ng==
X-Forwarded-Encrypted: i=1; AJvYcCV16sOk9txjLOJSVDBBitGWJfCITIPqHZCULYylHS/DBonuTQCDrJXkXHIA+HzpHklsVoSXkSDcn1J/@vger.kernel.org, AJvYcCVCBtoWD5gjiMaUNHOSzTXKPDOPjsfSegugzZBzbB0OG0QDXrnjIWx2tZEzlmdlaILxom975MaiwktF8lZz@vger.kernel.org, AJvYcCVKKYLY7IaORtNjv9P99x/ro1b7CT7K3cjyORBnN5QegV//53CHqBZ6acdd+gZ5IqlgN6tASdkNcza8@vger.kernel.org, AJvYcCW0rnShKoazCPfEAYAFmteXWNbGAQ98hpiFz35MUBx+JZbl1Zbpg8Oq5KsQ+cKjrLLq+TlRso7A8Zs=@vger.kernel.org, AJvYcCW980sHKFutvGe/+dw2RZG45c6xBAYTYMkfmfeG6b1GKGHBTvrmL/ur90AWDt6H8op9pA7VaOQPMmHSTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjVwIu9yuKY6Q65vc0+kEr419ZYvdFdANsaTjl75b9EOu6UDRK
	9+L8d3o5t9jGs7zaPnyhaXzWyiWrsDndQOuB//IvOEcU5YcQRUwa2Qo0
X-Gm-Gg: ASbGncsQmSZCu/kJ4G0ywUQl1m79dIyEf8cLmzWoxUKM7/btpLrm6BSuWb/ghKzs7uR
	WQ9+OSdpQvFFtr1IplbGEY9bfWK5HBXKqwx1o+RK/w0dfp8BVgxBdkekyclbQi2zQe8DjnmC9Qz
	bHZVi/VVmpOx3Q1WnbFYlFGmdoPqO28I8KzxFS3lclwYuHPXEGQm/5ARFCq2QfLLd50Dps7sBWe
	BM06UmiqrrhTzxXnSqYgnjxWlen6elWUCJwcm27Jsd1ID15nT5TmA0+JqTVyLi998TX2rWmoB6k
	QWGmsZTMWlvIBSssOM02JkeSDJzQnWv/4ikXyuFbrIq/I5tRm+/cE0J/OVPdD4f4e1HZn29FRKc
	gdGXl3eB3irJXjychG8Ro9DZC4k0yTaAV3L4pM6YGjI7I/9oqGLl5hcc4TwaXOWxafCsf4sj26P
	DXC+2vVZ+mdi6eIg==
X-Google-Smtp-Source: AGHT+IFzelVEVcHZ/OEffn+B3ZOPH1G6XXdnoiZLhN8P1cfO9z6/oEzmEO+w51ye1sA65QFg9m/KUA==
X-Received: by 2002:a05:6000:2d84:b0:3a4:fb33:85ce with SMTP id ffacd0b85a97d-3b60dd7d98emr3809652f8f.46.1752748374338;
        Thu, 17 Jul 2025 03:32:54 -0700 (PDT)
Received: from localhost (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8bd163csm20204660f8f.4.2025.07.17.03.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 03:32:53 -0700 (PDT)
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
Subject: [PATCH v2 3/7] bus: mvebu-mbus: Embed syscore_ops in mbus context
Date: Thu, 17 Jul 2025 12:32:37 +0200
Message-ID: <20250717103241.2806798-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250717103241.2806798-1-thierry.reding@gmail.com>
References: <20250717103241.2806798-1-thierry.reding@gmail.com>
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
2.50.0


