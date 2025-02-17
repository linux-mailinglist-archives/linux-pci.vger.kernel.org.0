Return-Path: <linux-pci+bounces-21644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB18A38974
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9504E3AD522
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00145226196;
	Mon, 17 Feb 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNmRLxlb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18379226176;
	Mon, 17 Feb 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810254; cv=none; b=WnnzJhNfQ71kPU+yRx5EsrAQK0Tu8epcvaOSL90VpcF/546xN/TripbHp8hz7hEPrHx6PsFz160e7myD/BRQjK6n/kaU9Q74ZB2dNYCxT5CRuFQdEWb1vQ7BjkpssOj8ZTOCgZxzaC4nf1cIvivAb91gY1Gc0KIQB6F2qLTwcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810254; c=relaxed/simple;
	bh=DuPHIcrT6Z5/GlVXfn7nt7Gawv/AJP9WOltQ42MmeC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apQmSkDsf3zblBZ48d1DlSJkALm5eem9za7EmZtk2zC3/GohLuTrK7uCKX4xomDHEaCzE2ovFss7/GKNvEWPFefvHeApDF88a6CIguaqYtMC8/OCQfVPbivfGnvpBK9nGd1fdzl3lhPHV5MAyNOmTZpy0VqFsvdo/AdClsiptHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNmRLxlb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f3913569fso1072170f8f.1;
        Mon, 17 Feb 2025 08:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739810251; x=1740415051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YX3Bs3MZrgBGo5LMWaEIe0GFuG33MQ381ctUNe/mVnI=;
        b=jNmRLxlb0rkZICLY+y5RxaeDJkeYR38znxIyxyh2/lE8j3OgbVt0Uq9/RU3KjufrsN
         bneLXYkMxv5GhjlUTqaA51yvIa6wdP6ZYwQl16zjr6cVGMpACl8FErVZsLLAXjw5LB5K
         vTdRPqKCIR5X3QOXo/gK2C9HqTKfZe//a5siHFEqw/1e7mJmOEyJTwR1qwDZo3kJTN7a
         fDBrlk1Z6lcp27UPoseoyNbSUV1heAAUDcKE+Ov0+DNQT9/PEJWXLBGjsJDLVTbDlkuQ
         f9AMvpUittFSYrC9mtRRtQwGy3CTYYGo1M/Y6IRSJxMUOACTpi8RzLFfpM5CpaHY+L1B
         xv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810251; x=1740415051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YX3Bs3MZrgBGo5LMWaEIe0GFuG33MQ381ctUNe/mVnI=;
        b=ewsZcErsZCWIR08c0bPe5xYtrSb5jQZ7JmgQcUywpa5J69ScO4ILJIlkLPRFk82NJ/
         IsmBNHVvXDu2Ick1Y7grlyGU+y8xbKLRk0ANr00SQTTH6R/wbBvRu+HyerXqLT064P74
         6Jc3MC7chrjo0KgyyeGGL+r236zhcUTBpGyY5Fgg8cyfpfiyBxXDjuiop8xLxq7WHVrc
         reU4azjfKMAoZHPiNhf1HVy6V1YpVbnQM9ooEGbfkoJW2g5hjTc54J7+RoS4KbIY4jE8
         QPSy91E6k+V2495pTqQHJJxTRUUDWgpggNsE2dyEaPFKwL08SHvvrUAUivsjTLfqwVU7
         VK3g==
X-Forwarded-Encrypted: i=1; AJvYcCUMkG0qxlxyCgSHgs4FllWxC9SAqyCQOMfHkf5SOO3cyiB+2yDR0oP4zxh3E+yQti052HB1MPaVvsA63YYn@vger.kernel.org, AJvYcCUg/LPsTBIWK6ZPatdFxh2LQbtUPhRI//zF47qhDDpY4Kbl1xYQFFDB0lL3iRP9S2UwZTB6Du2H+D4/@vger.kernel.org, AJvYcCWC8wKTSukGSMU8fLK5x9Ieogq4SoW4ZgY+hFidznYzz+jCz1z7wwyX8MEymufSlUseqORvXR9vqbw=@vger.kernel.org, AJvYcCWqwj0I5YrbinOZrlaw1hp4+3wwa1zOJO1VvSJ4UC3xIGVDuXmRk25OEWTrRv/sNmx5es9IAzirH9/nBA==@vger.kernel.org, AJvYcCXRBvfauaBhTIyabkGFL10zpIO9BJr7DxBcU9UETUCcYt0tyLoLmGIk+yVZYVsOCCJGyTuh30qZFiLy@vger.kernel.org
X-Gm-Message-State: AOJu0YwaqYcTuTCEgFBg89ed7LLsfbihZ46BZynv8On08Fn4nHcZYocZ
	6SDU3s8uTyPXJgSbwdHNDeo4gZTvcuL8DcYhbbF08DcR/8fA9UUNHEfhVA==
X-Gm-Gg: ASbGncsU4AdyfXOO3EWkljV5kiRiDuwmikRmRDNqWqE4WLAsKT8F8+7LuXDbP2gZcZ4
	WCnRU50JzdjRS+a8hftLvQxX2BR9CEeoRtuoSNyGnreEnmpGOb4hh/TXk8CvJbjuo4nBxYJ+JNj
	OLJ6i44XXC/LBFmQlUqHZcMuZ9rBwtqff9LJp16DmdWFIAVKO5Oafgsx8a34vmlRpmlfjUzYZj9
	52Vdx45uwdE/pvm6DKKeuSc9fUQ3jxJmGBqrbNVikDwSYgApTUK5+NDZ4UDHEdKS8pi5v2LJsvT
	2RQQMDHwKCUxcQzWCqGoWLwIXB12GMgEKaENsG6qvWECkHHlF5c9COePk2Yz7d8Djp0wHQOawif
	f0Uw7keQ=
X-Google-Smtp-Source: AGHT+IGKeFn1JZI+61Y36W80rkeFL6tO0xV+0w/zCm2hwXiflv2MWSmUK04720sV0csGUnPk6PUGmQ==
X-Received: by 2002:adf:9bdd:0:b0:38d:dffc:c14f with SMTP id ffacd0b85a97d-38f24ce77dcmr14937408f8f.1.1739810251284;
        Mon, 17 Feb 2025 08:37:31 -0800 (PST)
Received: from localhost (p200300e41f22a600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f22:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f259d5d8bsm12702877f8f.70.2025.02.17.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:37:30 -0800 (PST)
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
Subject: [PATCH 5/7] clk: mvebu: Embed syscore_ops in clock context
Date: Mon, 17 Feb 2025 17:37:11 +0100
Message-ID: <20250217163713.211949-6-thierry.reding@gmail.com>
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

This enables the syscore callbacks to obtain the clock context without
relying on a separate global variable.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clk/mvebu/common.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
index ee77d307efe0..53712c3e5087 100644
--- a/drivers/clk/mvebu/common.c
+++ b/drivers/clk/mvebu/common.c
@@ -189,6 +189,7 @@ void __init mvebu_coreclk_setup(struct device_node *np,
 DEFINE_SPINLOCK(ctrl_gating_lock);
 
 struct clk_gating_ctrl {
+	struct syscore_ops syscore;
 	spinlock_t *lock;
 	struct clk **gates;
 	int num_gates;
@@ -196,11 +197,15 @@ struct clk_gating_ctrl {
 	u32 saved_reg;
 };
 
-static struct clk_gating_ctrl *ctrl;
+static inline struct clk_gating_ctrl *from_syscore(struct syscore_ops *ops)
+{
+	return container_of(ops, struct clk_gating_ctrl, syscore);
+}
 
 static struct clk *clk_gating_get_src(
 	struct of_phandle_args *clkspec, void *data)
 {
+	struct clk_gating_ctrl *ctrl = data;
 	int n;
 
 	if (clkspec->args_count < 1)
@@ -217,23 +222,23 @@ static struct clk *clk_gating_get_src(
 
 static int mvebu_clk_gating_suspend(struct syscore_ops *ops)
 {
+	struct clk_gating_ctrl *ctrl = from_syscore(ops);
+
 	ctrl->saved_reg = readl(ctrl->base);
 	return 0;
 }
 
 static void mvebu_clk_gating_resume(struct syscore_ops *ops)
 {
+	struct clk_gating_ctrl *ctrl = from_syscore(ops);
+
 	writel(ctrl->saved_reg, ctrl->base);
 }
 
-static struct syscore_ops clk_gate_syscore_ops = {
-	.suspend = mvebu_clk_gating_suspend,
-	.resume = mvebu_clk_gating_resume,
-};
-
 void __init mvebu_clk_gating_setup(struct device_node *np,
 				   const struct clk_gating_soc_desc *desc)
 {
+	static struct clk_gating_ctrl *ctrl;
 	struct clk *clk;
 	void __iomem *base;
 	const char *default_parent = NULL;
@@ -284,7 +289,9 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 
 	of_clk_add_provider(np, clk_gating_get_src, ctrl);
 
-	register_syscore_ops(&clk_gate_syscore_ops);
+	ctrl->syscore.suspend = mvebu_clk_gating_suspend;
+	ctrl->syscore.resume = mvebu_clk_gating_resume;
+	register_syscore_ops(&ctrl->syscore);
 
 	return;
 gates_out:
-- 
2.48.1


