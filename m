Return-Path: <linux-pci+bounces-21643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C937EA38970
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553CC3AC917
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B68226185;
	Mon, 17 Feb 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhkip5dm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E99225A4E;
	Mon, 17 Feb 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810254; cv=none; b=DB/FdG5xUFbpUqGEIbvNmvXVFxUIIILPw73MATqE72QEgG4xTzkWc33n/wqRFCIYEtxAixtUiy/9G8xu20W3QfxzEf4A4nsNarjuEncMzGRMp30O4ieOtg2+uT46+N9M6hg4FyCisvJo34AP+pw3xy5S7H0x+eZk+FNzvGuhcZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810254; c=relaxed/simple;
	bh=zE3UeHdwgOpQSnjKFq4GICu7rZN5tRJ5Y9xFvM16G0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ieeo32d5dMGbtAcD4g2Z8YE1RxhKJZewafaM1/3ysfIO4/AKMen72ugOJAiuKdcqSCHr7Q79X03M55xQ2WNdoWVq27goI0P1fFV7ecvVP/D2mlAw1OQbUDvJ160JYy1O+AhRRfs8sZr9l4aL7EJrODy+Ojxr1ZLmeeESU/NP4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhkip5dm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f504f087eso844f8f.1;
        Mon, 17 Feb 2025 08:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739810249; x=1740415049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/Pliae2eQBpyDaB/rhM+Xrce+n5H7ftTZ7yML/5v4Q=;
        b=mhkip5dmbbsCjESZaRdP1N1oEic1bND9ecebVAzEgrkp0Vav8eQf0TMjvQh76vrCa4
         QAB7rXYnPiW7WnHcnoxjgpZPWILiv4O5LkmtoucWrQQQ/hb4orbPegSBngkMw9aojsWR
         80sr/E0vjbG5SWLl7Acc1oGILrX9WvnFubCT3d8uQ0wx5ZCKibdi43ndiSHdc8x0D2K/
         wLFPdY/cFHCEWDHG5vm69txxKw06AbuyLLiIr1WFwcVn7aQ9EKT/HL8YXAku6xbOJLJR
         4dbjEy5t62MQuYNja8K4MVMy7I+DRFQIBGOklendJtgSvHjviG8EWO2dbhqLIu8NchXf
         X19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810249; x=1740415049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/Pliae2eQBpyDaB/rhM+Xrce+n5H7ftTZ7yML/5v4Q=;
        b=WmTglVqVt+nsArPllXrtB7FGoHLtjdviK13WvQRhvONY88zPtpI0+B/I5j/iuHdM+x
         eIuVWx8nCn3g+w9S0SyKlzOdOcF5X93rT5ilgNg47h2oGA5+JYfos32BBzywB0PYTn3o
         Mt+7Aef6tkvLeo9/jLfoseO3sRS4mYJxH6Xb3uMxNEIHtRJuTzVX8WGian5lSYlINgcM
         Du56Er0Q0PPDeTb0RiF1FyYEzPic6ndGkZTGU5/JhCZYO/IjraFtsUUkwlm5rmr3gdQh
         IhkB46JvzA7W7nTweaubKjb50Cyld0gfyXj6k3dOPWJpeVJH+REn8QzkY20DsiyQJrMj
         FTBA==
X-Forwarded-Encrypted: i=1; AJvYcCUp5BPWExB60JS/FLVI+9W4TQYFY2AtgEBgk/Z5Zsu30ioECY3qudey2ccXz09W41CAajxDdbwBJIFzRQ==@vger.kernel.org, AJvYcCVOatbdctZwf1F9XcQ/5K0Zt1j1vlCJMnJ28AHMWBtvGaMpKVQiniDI2EEJKM4WhU4gR7x2CMjfsOs=@vger.kernel.org, AJvYcCWSlB5dpH9tUkM46Gl0zXf45wQlGC8WhaYLqAPIt9zgMdn1zb9Yek8T3uKBVa18XuzODYgxsGzDvqyy@vger.kernel.org, AJvYcCX9SHs9NVTynY/ZOFybn8Mi4sPBFJs2PUKopsOeyoHqhSTCspOeIcTQv5VJKf1SbA32OKvu97wdFKkOeV4P@vger.kernel.org, AJvYcCXbXpPfyrn76cSuFZPZ2oqJve+rS8+nq1VcBm2LcIfzdHaIPsvvWzR85srIPQ6cXsmsZg2K3FT2nzZD@vger.kernel.org
X-Gm-Message-State: AOJu0YwJyOnEsFgV2eGKUbfCCeb4G40FnKlpDqEVysUVmm/bKej+AIQi
	JgcdNGK/c7M0ffAczR8zX8OzyRiVlJ+hzAbRi1J6P/O79TdmogJy
X-Gm-Gg: ASbGncvfNjDKaqCA3Hl4RK8NuxtF0szZ/NzZ5OgHWXtQDnFcp24dM436C//WLkr2TNo
	ctLqwwNXTQC0LiqbZGaU0VZKvs6AmuVCJWODjAXoQrITuOLasKQvnrxwv/rhCprQimcg1qLDO0H
	yCnm6OJHxrLqSKWF6PXaxyt4MzyAF3EfkyCE317ORidrNFLBd8w2lbPXEnhCuUXwnmiLNV1/aYW
	fY0IWSCTL4bk6BU6/mKouA4EQn+gxUOfYwKhMTSj6AkkP7KDx8Sg0mx2722xWNCcuSfmgQiJFdk
	MuvUzd504J9RZFIpUgWoCdTwJXF0p7s7kUxNDS6M3j+qtQQ7o31rOS67AQgVHobRyhI39nCzh0t
	Y9QAtdMM=
X-Google-Smtp-Source: AGHT+IEcmZoV9E3nZ+6g02c1M8tS19/XgVVrKGZ1S0RbQ0hvdrhxp+y24wkbvweGnlTFrgLbDmIhiQ==
X-Received: by 2002:a5d:6a0a:0:b0:38f:2e78:450c with SMTP id ffacd0b85a97d-38f33f2961cmr6950160f8f.19.1739810249186;
        Mon, 17 Feb 2025 08:37:29 -0800 (PST)
Received: from localhost (p200300e41f22a600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f22:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f259fe1efsm12791371f8f.97.2025.02.17.08.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:37:28 -0800 (PST)
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
Subject: [PATCH 4/7] clk: ingenic: tcu: Embed syscore_ops in TCU context
Date: Mon, 17 Feb 2025 17:37:10 +0100
Message-ID: <20250217163713.211949-5-thierry.reding@gmail.com>
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
2.48.1


