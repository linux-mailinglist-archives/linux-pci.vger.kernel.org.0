Return-Path: <linux-pci+bounces-39680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D25A2C1C447
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F3E65A5A9E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F5A34F47E;
	Wed, 29 Oct 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly00Kxs6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9B34C9A1
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755638; cv=none; b=KpSsgekGE335fEvQhQaxYJ/B5lSBHF7dl9AOfPffPsK/PpxhiH0YrQl64B87ncu2po2Nx0xC6k0iyv/TbtxibjpWpuBcYMyAnoh0rT20le3+Apet6T3/wqg4FpnbvR79Cb+q+qL+gEDccKpRnZymNsb9/ulpD54YQyrK9DN+c6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755638; c=relaxed/simple;
	bh=oprYoP8yymfB2u4RbgujgsNH+i0ZQOd4dygbCg75p/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBsUOvUoHjx45WZ09t5DyaEp72NQ8uPnMYkoYkH6Z+R6ON+zMIF8ZpYgjuYEls7Jnr+/rR4pNzp8/sUKKjM8KUqDcMOEQkKF9+i2kPu8DB9k7wYLQMpNPnajTTFXBkwSmJEeBfwlVkq97GYD2rn4ZOS48OLHsg7nIWCOewvL464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly00Kxs6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso27663166b.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755634; x=1762360434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7niwucTDN3MnvT2f7z1+zCVDCBNmgQwG7r5182Kk6g=;
        b=ly00Kxs6I33Cts0szvsBGq4htnfjRKgDLfJgp+irQhH6eKg2aQ+FeYSXrktnVcZglE
         LS1X8DzpiRogsiDYx1QlAxeVNlePirHa2e0t8myHtbCX7sceXUAroMRjnaP7pZtJAbGa
         ZQzZ7QGt9Cgzf9F2250kNiJs2S8eGvhA39TaZ7wBXvUJagjjHROm1FCFEM7ezV7ijWgH
         yYqbR7ZF6gG5NFwzSbTizMHnnb6tYgQvX8/iw3UfEgYviyLxh7pJ1sBtoXpBN5ZZsY3J
         VUAZn8FHew4EfgiHNxME1+S8wmyvm3kKigBup4ENf8sONeuxDxeoy2tUw78yc1EHNZon
         eVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755634; x=1762360434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7niwucTDN3MnvT2f7z1+zCVDCBNmgQwG7r5182Kk6g=;
        b=Fx3wFAyZ6sjj1/CsekXsCyM7nHNI5MZE0tayk8RQAGz9nBSwtefiH0Cy/B5dyBymkS
         91Q15OxEYouat+1gpdXo4SmbkcTGf//x+CJzD53CWXfM86VNhyJfr32y/ZH3lR//0uPT
         hZoimX1k90Lj1FxtL7/Z7z9FoRnm7lq/Miw/uX18WizgSmJi8F0UaU14nSuRIFJHBLgC
         h/IRaHvobGZBJctFuUrRcciepw4qt8PVbMYfGRvYFq1bO1A1PSuKuYX736Bw8aDk6GgN
         tRZLDrDxQCqeN6+SkcPedfhtOn6phW/XT4MyGFaOwz3XssZUH//uX86MEKvqPfnpYZGH
         bLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzveVJ3ojrTSQLLpRkPGRe0BgoqlJtRz+htoXxvdhUo/+u5iRH8L7xYb+IZdBsU6FoxebIT04iBOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtTvSICMii9Racplt/HTLLP4RB22cNPrSX6Wo5qP9PMNMxAlX
	ZeiL/9QQRCuAw7XSv0Qkai1hlufr3vfNNpP+X1CMWM2GJ/BuSE6cgLPl
X-Gm-Gg: ASbGnct43Sa9VnV8TjwblB00sWbD0bUMWxJ1lcPQ5BzXzXvmZ3kEbQi3rCkVoBtht7y
	kEBJqM0qSxsvOkTctByx9nvdOFkQzQWknyLCe8lZzPAPu8RSQUMTkbTOngEGFj2xtpKZgffr4f/
	b5izAfjDtDt/n3na2wd7FMH8joMBcgn63hYpOoVw2mVuW5zpLuKYWN/+mBicKodwR0ZFL5PqIs9
	4yLvg7IsCoe+fDeBOsWUU6PYLI15RxwtM4wLhbjFxQUBt6qAbkz7O5dBgLeli/rue7Sxb6RpVk4
	DUxTVg0iGXn+22C9Z/Fdz4Mp0TlB7B966hfAuokioAuLc6VOXJ4gFNprXUK7zPbszro2iBGvGEl
	QGxo5Cps4G26eKt7rASO1Y4VrSdHAKQht8qbQMyZt/RIh2WZ0rwgxdadPXX0GY+q4HEa5fCaQG3
	WB2mv4MlEu5m7AufRa46HV7rvrDVt2Z0EHq8SOcC3lZc+sl5wLnIe0mbUmOo6ryBDNEXiy
X-Google-Smtp-Source: AGHT+IGxst0GGPbE3zlpzuYvmZD7MtT+fgNns/2gbspQBUcAcExwpAJ9gNyBIh9hmr+9IwgchPtgzg==
X-Received: by 2002:a17:906:6a21:b0:b3f:f6d:1d9e with SMTP id a640c23a62f3a-b7051f278acmr28890666b.6.1761755633985;
        Wed, 29 Oct 2025 09:33:53 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d853696a3sm1468789266b.27.2025.10.29.09.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:52 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
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
Subject: [PATCH v3 5/7] clk: mvebu: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:34 +0100
Message-ID: <20251029163336.2785270-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029163336.2785270-1-thierry.reding@gmail.com>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Pass the driver-specific data via the syscore struct and use it in the
syscore ops.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- adjust for API changes and update commit message

 drivers/clk/mvebu/common.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
index 5adbbd91a6db..8797de93472c 100644
--- a/drivers/clk/mvebu/common.c
+++ b/drivers/clk/mvebu/common.c
@@ -189,6 +189,7 @@ void __init mvebu_coreclk_setup(struct device_node *np,
 DEFINE_SPINLOCK(ctrl_gating_lock);
 
 struct clk_gating_ctrl {
+	struct syscore syscore;
 	spinlock_t *lock;
 	struct clk **gates;
 	int num_gates;
@@ -196,11 +197,10 @@ struct clk_gating_ctrl {
 	u32 saved_reg;
 };
 
-static struct clk_gating_ctrl *ctrl;
-
 static struct clk *clk_gating_get_src(
 	struct of_phandle_args *clkspec, void *data)
 {
+	struct clk_gating_ctrl *ctrl = data;
 	int n;
 
 	if (clkspec->args_count < 1)
@@ -217,12 +217,16 @@ static struct clk *clk_gating_get_src(
 
 static int mvebu_clk_gating_suspend(void *data)
 {
+	struct clk_gating_ctrl *ctrl = data;
+
 	ctrl->saved_reg = readl(ctrl->base);
 	return 0;
 }
 
 static void mvebu_clk_gating_resume(void *data)
 {
+	struct clk_gating_ctrl *ctrl = data;
+
 	writel(ctrl->saved_reg, ctrl->base);
 }
 
@@ -231,13 +235,10 @@ static const struct syscore_ops clk_gate_syscore_ops = {
 	.resume = mvebu_clk_gating_resume,
 };
 
-static struct syscore clk_gate_syscore = {
-	.ops = &clk_gate_syscore_ops,
-};
-
 void __init mvebu_clk_gating_setup(struct device_node *np,
 				   const struct clk_gating_soc_desc *desc)
 {
+	static struct clk_gating_ctrl *ctrl;
 	struct clk *clk;
 	void __iomem *base;
 	const char *default_parent = NULL;
@@ -288,7 +289,9 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 
 	of_clk_add_provider(np, clk_gating_get_src, ctrl);
 
-	register_syscore(&clk_gate_syscore);
+	ctrl->syscore.ops = &clk_gate_syscore_ops;
+	ctrl->syscore.data = ctrl;
+	register_syscore(&ctrl->syscore);
 
 	return;
 gates_out:
-- 
2.51.0


