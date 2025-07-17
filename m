Return-Path: <linux-pci+bounces-32372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D47B08AB2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1593B8C04
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2178C29B772;
	Thu, 17 Jul 2025 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHiErBpj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748829ACFD;
	Thu, 17 Jul 2025 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748380; cv=none; b=juObumEueWgRCOQGm5Rsu6X94PKlYlkyjBxUtKEbsBakuTZjksHIxflzDo2VnGXa+OnZkccEuPrSzf/3PMfKw/zQ3U3MHGczYKybYXwdV0OKyATiGJF4WemkBf6HmPiU7RpqOCxH095lb8kV9Y61UmdFm82GkBJNSAQBAH8tDYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748380; c=relaxed/simple;
	bh=gxJPOLe/NygmZOPFvcbQJrkty4d46bYlbvQiaExURr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hca9q8qeTvhJRY4tu7I1ffecINNsMH18E04DC66fpzf0i6ludjmvSKZiC/RhDhykgBdWs4kgaHUy7En7STxYZZKG1rY4gFlPjHW8UEoAtmh3vnPiGZH8jMhVH97VfOGDqsnUqOrlkBE1/yFdr6t1ohxihFoXkHGMZJbtOCWZeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHiErBpj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-455b00283a5so4935075e9.0;
        Thu, 17 Jul 2025 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752748377; x=1753353177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KTffJpKMpn8uJ1Va+yFB5k6/yxUZURkt0Rt5PLMCHI=;
        b=LHiErBpjTZebKUhdFcTo2scjZYFPCvzxOwnFjJiwtWLf3vH3FW4t/AWB/YfaiZgSKN
         iPQlvd1mmTHhL80Ejvq1f/KZoUFLK3m4qaacx9ojSDsC0aq6qlffLtUE29s4DctUjjvt
         con5rSEwHqNoXnXCDLjg2Gupk8e53pWNirNbL4KmwX7PtOxDwYSn3oQwlBmfKOJFPs7/
         7RXrETG7/PyS9eui8zXNCcnbAUVJ2GzCyVscoAMI+76IR0/TLu4dDQNl6up+dKLJ2eYm
         nVZYsQhxZ62oVIvYZkxiUQxCsNPO1J9Jj35dj84K7qgzly2vwtMUutnkYPaBGgPOac8x
         grKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752748377; x=1753353177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KTffJpKMpn8uJ1Va+yFB5k6/yxUZURkt0Rt5PLMCHI=;
        b=aVvHiSDvXUrxtZ7n3P2Q8Zeh4temb5OowPffC1huHU9d5UY5VIjvLJSclnffXRgVSJ
         nVKWkq5B1bcat3v6TOU9CkWSURX+aGuNJIW8DQQxn6xvRcF+pTVDA9OIrZvHU8IN0lP0
         aVk68DJ+qehin503i+10jkc1HPyXu7r8LJ6aXGG875i/ZFlx0rlZnQDyOaXhmd+hLINO
         4Ex6tSDfl8QiF4PGNdxzE7YBzggXn9wwadyCEmsPNg5H+8oshfeMXuIFx722LoE43SMU
         w5aizEs2eULdhRCr7efaPe6o+cMbvOATUYJQFxAM12YCLWmjjIELk5XA4IY+B6nUVcxM
         xpDA==
X-Forwarded-Encrypted: i=1; AJvYcCUTQ5cdIfBFMEtk/dX9xGsdiwtidiLIHmiqmw2CC4lrecDIXqaAsbFBdfz9LqKY5GuSMRMrRT+oX5yM@vger.kernel.org, AJvYcCUTWf1yWEWaVJfeGuls0OUEI1lEIDxM4MuKo6odTxoGsGKr/l0QpIqVGrPiQcZnpdxfO7p+wOfAXn6J2vcj@vger.kernel.org, AJvYcCUpQm7QggrB5sct6Tg3IoEmu9c2znaPPGVtLPWj4VlOrlRRPhaLUtBWy2pr/AsthtBZKWSl+tF+M9m4@vger.kernel.org, AJvYcCUt9pxuJX/+vt5VLCM1WrRYuxsEGg69yGt/Dl2cyeyQoRKXInkF1VsAgIVPRMjGznQx/pmkto/D8Rmf+Q==@vger.kernel.org, AJvYcCXgflYZaNyfSiP+KkBtbY00yP6VQB8+zBhjShIolemWO2+PFr6TF8ozAmDt91QoH68u/mEY23HYjTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Xw6SfVYhWyIlaOLiwyoPCikdI8iwNHdFyoLz4OhG72gGsgPw
	V9RHwF9vE8q+jaJa8/HRA4g4gyPo7+yMWGjJsGmzcSNZTk160Of0YyDH
X-Gm-Gg: ASbGncu7yODN/qezTYmmlSIOD4VpaDW2JZXRHT+7J9/QzuhO7qXeaSh2BFUgtDXMV42
	fEkGYithXJ+A6oySxCNKw18vq93eojLK95ZObLXat6Im8Z2Bqdc3t1FplPw8sTeGogCwjD1fXc9
	0I1XSQyl5br+WYkLwuADDq0imVov6zm3CdVRQvVtSj9JGiBZkF9UlvRkDD7XHfcbGUym+iJPwMY
	NEaq3lD+VfIJBhY737hr7DHyfVhzZIsXW8pqJJBsXZXD8nyLfpK/WZgLJTofPyKQ7JSqkgcR4+9
	6hEZbyXglaLR2VXrguhoiRPVujIbtkM4KEwf2QVNg3TsqvaAw4j/XxpLm4vxfY6xofwMBxhYmcF
	xsW4R5BYntMUXDeCztpBGSyrbc6cNynHUSEk3YsunGw7oBsKeY//+GROJFFk/p6LgBjWBTgn625
	8vt7ga7IXgOif0KjLrFPB0TP6F
X-Google-Smtp-Source: AGHT+IHc8vQXtNpyThvJpHCdFDQv27nKu7NYwqVFIiEhHTf13nJ3NAM+LgvjkH4nGyp8L9aYlCB8Ng==
X-Received: by 2002:a05:600c:5246:b0:456:207e:fd86 with SMTP id 5b1f17b1804b1-4562e03bdf0mr74830065e9.2.1752748376435;
        Thu, 17 Jul 2025 03:32:56 -0700 (PDT)
Received: from localhost (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45634f4c34dsm18373635e9.6.2025.07.17.03.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 03:32:55 -0700 (PDT)
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
Subject: [PATCH v2 4/7] clk: ingenic: tcu: Embed syscore_ops in TCU context
Date: Thu, 17 Jul 2025 12:32:38 +0200
Message-ID: <20250717103241.2806798-5-thierry.reding@gmail.com>
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

This enables the syscore callbacks to obtain the TCU context without
relying on a separate global variable.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clk/ingenic/tcu.c | 54 ++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
index 85bd4bc73c1b..503a58d08224 100644
--- a/drivers/clk/ingenic/tcu.c
+++ b/drivers/clk/ingenic/tcu.c
@@ -53,9 +53,9 @@ struct ingenic_tcu {
 	struct clk *clk;
 
 	struct clk_hw_onecell_data *clocks;
-};
 
-static struct ingenic_tcu *ingenic_tcu;
+	struct syscore_ops syscore;
+};
 
 static inline struct ingenic_tcu_clk *to_tcu_clk(struct clk_hw *hw)
 {
@@ -332,6 +332,24 @@ static const struct of_device_id __maybe_unused ingenic_tcu_of_match[] __initcon
 	{ /* sentinel */ }
 };
 
+static int __maybe_unused tcu_pm_suspend(struct syscore_ops *ops)
+{
+	struct ingenic_tcu *tcu = container_of(ops, typeof(*tcu), syscore);
+
+	if (tcu->clk)
+		clk_disable(tcu->clk);
+
+	return 0;
+}
+
+static void __maybe_unused tcu_pm_resume(struct syscore_ops *ops)
+{
+	struct ingenic_tcu *tcu = container_of(ops, typeof(*tcu), syscore);
+
+	if (tcu->clk)
+		clk_enable(tcu->clk);
+}
+
 static int __init ingenic_tcu_probe(struct device_node *np)
 {
 	const struct of_device_id *id = of_match_node(ingenic_tcu_of_match, np);
@@ -430,7 +448,11 @@ static int __init ingenic_tcu_probe(struct device_node *np)
 		goto err_unregister_ost_clock;
 	}
 
-	ingenic_tcu = tcu;
+	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
+		tcu->syscore.suspend = tcu_pm_suspend;
+		tcu->syscore.resume = tcu_pm_resume;
+		register_syscore_ops(&tcu->syscore);
+	}
 
 	return 0;
 
@@ -455,38 +477,12 @@ static int __init ingenic_tcu_probe(struct device_node *np)
 	return ret;
 }
 
-static int __maybe_unused tcu_pm_suspend(struct syscore_ops *ops)
-{
-	struct ingenic_tcu *tcu = ingenic_tcu;
-
-	if (tcu->clk)
-		clk_disable(tcu->clk);
-
-	return 0;
-}
-
-static void __maybe_unused tcu_pm_resume(struct syscore_ops *ops)
-{
-	struct ingenic_tcu *tcu = ingenic_tcu;
-
-	if (tcu->clk)
-		clk_enable(tcu->clk);
-}
-
-static struct syscore_ops __maybe_unused tcu_pm_ops = {
-	.suspend = tcu_pm_suspend,
-	.resume = tcu_pm_resume,
-};
-
 static void __init ingenic_tcu_init(struct device_node *np)
 {
 	int ret = ingenic_tcu_probe(np);
 
 	if (ret)
 		pr_crit("Failed to initialize TCU clocks: %d\n", ret);
-
-	if (IS_ENABLED(CONFIG_PM_SLEEP))
-		register_syscore_ops(&tcu_pm_ops);
 }
 
 CLK_OF_DECLARE_DRIVER(jz4740_cgu, "ingenic,jz4740-tcu", ingenic_tcu_init);
-- 
2.50.0


