Return-Path: <linux-pci+bounces-32373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96667B08ABB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B9B1A603E5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 10:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D16D29B8F5;
	Thu, 17 Jul 2025 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB9ahfT8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4951B29B783;
	Thu, 17 Jul 2025 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748381; cv=none; b=nd/ZNSohL1RQujwGwfkjCcGGWb6hSW+V8AVhASY//sZYc5p7rDGghVpJ2JrMns47Tt/FZqNyf+1KMpxDFHahvJQmzwFAugMzwB7E+YhK38VDoNCrXnstV2WWPLDPL5oN1f88jQIGoZ1VwiBUkYGepJxn9HMC8DsXEXh9jkNSe44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748381; c=relaxed/simple;
	bh=vp8F/aC/cZooJCbJwE+TaQJZ/3NVmFILN3IZLxtFeec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0i6FyWwmCrwuZi1qlp1PLz/8K5zSX/6yHnT8gdwXwmJ8Np8PN+bpKf0EK5rD3LqTu67ach40NXF3Bg8Htie1psKZyE8u7NAsr5B9ydv+IZ6RNV+SEgnFS9rX947YMdZf5qvwGQ3EZunL8Z6rA3zJRPF77U0kuCGy5K60hSzygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mB9ahfT8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso647342f8f.1;
        Thu, 17 Jul 2025 03:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752748378; x=1753353178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAFLXGS25z8S0WanVyIjmw4Vp4se3d5lBR+FdNubaFk=;
        b=mB9ahfT8yCESDDeAwana1ppqWZz3NNxvxpdfKZ6bFloSz+90TlQnhZgQoRdshXkYF9
         evPGvljb6mS+x0YYfYs7Vo10Uia409QJDTllIMv+p04I8xUCQkiFRItPvcs5KfWE99dk
         ybGn7Bq8nz4fx+Om7rauZwA65+Riluy3ZWzj4Ofu6mANGZQ0GhvPj9BEmmGuCW5rKyTw
         kvpSIQg7yCbQs88zazRewj7QWIO6u9759WCigxjpo+NG5gN9vk5PMXhl8k55yNXOQwDm
         wSfSAnb33PkzF+qgkXXO3jfd2ZxAVlLvI1WSV1IMnrSGs7r7V+DU5wCK8StWBv4ECHOP
         FpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752748378; x=1753353178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAFLXGS25z8S0WanVyIjmw4Vp4se3d5lBR+FdNubaFk=;
        b=j3pvzKz09OTba2B47mLdMhHGGx7Ic6Q228HjWkOpRLWUcXEdwVKvxvF76BjtOa0RdB
         Cq6p1niMSrd0BmDIUrDqXBcIY6rEWeEM/NglFZPKLtDqyYsImCrXYbRgIg41Nm6zCFcn
         pZAmzG9ty93Auuvu01k6JYPvgEPP3tP5TChYyJWLKPVbgxD8t6y/tpjAxrBrGkySaLbZ
         KcurOMgUwrkSYExqexUG3enHxQfr825ljrImtV/lzDebD4PSgpkLISlp11BnNNDrd8uH
         8lxvSx7364l8uK3diZxZsaoOgpJxHeKmJWNOfY6SuvOzplMVgeTuFV737JIni7Qu8PPK
         Xy7A==
X-Forwarded-Encrypted: i=1; AJvYcCU/9NkzTc1741zW389aFolVTl25doiBX7+WHPqkVYLVVRTsbD8u5hJ2U1wXr7JUHNf+fWmxR8ilENRTwfUN@vger.kernel.org, AJvYcCUbtfiUlZ0mSQpK/T0Y8sml5+IUNhFuNLzS+lXKSQXH1yCBwsn/JIAejijTNvtDqIYsTWLPw4itWWJL@vger.kernel.org, AJvYcCV5OekxXsrAF7PRnz4cA5WCjGLQGUAlqU9Fj9OveMtaJSEqtJK+sGVuklu8Nm/WgVg0qqDJ4YLd+F2iEQ==@vger.kernel.org, AJvYcCXHl4Um6s6ft/5EfuXFy+iQ2XlXgAKd1eCG01g8Ni0eUwRJnaDRRiRn1H/KksQAXWf3whJa5CXgKTM=@vger.kernel.org, AJvYcCXb0qVTnPLqpU81BOG9Ji1Q6GU0jIVtAFtrbRt79pOYZPC9KBsNy+kMUSaZtxAfUKc1c+CukDgVejjU@vger.kernel.org
X-Gm-Message-State: AOJu0YzUd4g8FuFd4EQWZ1Y3pqW3aN5iM+jIAWUs6n7CG0ZAgqjg4x1z
	xbnCkUbUKJcZTcW9dLfu98iOzjOIEh5k4V5yFy7d/i6bfnAnoYhyRDeq
X-Gm-Gg: ASbGncteV7MUSsZ126eMjFf1UfvfpH2Z56cYgi/gQysrhGs4grO3oe3Go5DhoHL3Kjp
	qvPoZ2LTwdH9KCOZr04DiOzlFgDVkTpF6x5AJ5xj/zeK4qlCbpglGqDDwQ2nSYAJdaosI2nZZXm
	ZY/SaHCaygIzN2vNzBiNzEhoRaSGvnEOgGqefp/UybxS9bOnLDZWsiEaWW2VWvbPBwUXyKfBuM5
	nvH1PehuTs6OCZXbUjpx1+l188cEfUv/FCsMIV5XVjclX2PSMEGkuevRTmunj1LkkV7M6omxC/k
	eaIZoRaLR3tm3MWBqIg7aXYGXvOhZY1z3HuDOIOW9h6L3wlo4CS06VJfidN3CZPN6rWz8U5ZXIe
	yznPrBcZ2H3ouXExMs2r1q/PLGQW14Ze6LWS7Q/rjkO0v48mXTKEpEtAzQTBz3A5ukrI9yAXaro
	RkAcAoVEynCITB7Q==
X-Google-Smtp-Source: AGHT+IEdwrBNkg9M8guchW0vI+6tEPzp3HT7pxcYs5sGp6dD4O7OxQ4GRP3g0Y8ml2hczWmCiC6jOQ==
X-Received: by 2002:a05:6000:1887:b0:3a4:cfbf:519b with SMTP id ffacd0b85a97d-3b60e5103fcmr4782590f8f.44.1752748378428;
        Thu, 17 Jul 2025 03:32:58 -0700 (PDT)
Received: from localhost (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8dc91d8sm20127132f8f.42.2025.07.17.03.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 03:32:57 -0700 (PDT)
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
Subject: [PATCH v2 5/7] clk: mvebu: Embed syscore_ops in clock context
Date: Thu, 17 Jul 2025 12:32:39 +0200
Message-ID: <20250717103241.2806798-6-thierry.reding@gmail.com>
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
2.50.0


