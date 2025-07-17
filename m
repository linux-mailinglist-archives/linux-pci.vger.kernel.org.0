Return-Path: <linux-pci+bounces-32374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E62FB08AC1
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F09E16B189
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0733C29CB53;
	Thu, 17 Jul 2025 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2MGXGuG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5629C33D;
	Thu, 17 Jul 2025 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748383; cv=none; b=mSTZLta51sdUZ4lZd48OBMfo1Kdpnp3EIvhlCxLQTfQQuMbD2xkzEAMflhG8Xuv9CJpJbj++vjf/iKa7T+K+IsikCw4uhvp6vLJd9KZmRGaTOgJJrmE0DAbL/a0JRf1FNfoknVUskPcQNlaAxnEbayGkT0EeK4qf3VpvVn00DLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748383; c=relaxed/simple;
	bh=HzpHN8YcpcUGQ8cTxUMkyRM0WI773zFQRBMcOx7t8Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpFm9/QlUNV3VNZJWzMfqBKGGlIQvOrKfhnu6PTQz8SUH8AnVRTCDETMkidb4uf0aure3KdvpK57S6YGpuQCTvpVm7Eg0Rv6RxPPp8jQuGCQhPuKzcFy/xGLa0Nin/wQ4F6Hh2X9aaOHu9Lrkg5FF/TbqMLyRTw/hOqeTAhALZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2MGXGuG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b611665b96so435362f8f.2;
        Thu, 17 Jul 2025 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752748381; x=1753353181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGNFpZqODfmzhJr9aiRrd+TX86pzNqh5cw08oNQmcLU=;
        b=Y2MGXGuGCVADOfYxQcO17jonVzGmRBMuAhtwNi1GFvrCtTB8QxrhXttqLwwJOoY9Q3
         phoiT1tQUaxSJhtbLwpFwFak+0CAB8LTosY/iio/Xls6HOIfwYgwgnvLH9esNOEMexgN
         zoloLzV5chxPop177WeZYbqqjXCZ+EIkdqN6fO1f5aNiU6lx6I5vHzgOzK4B1GuFthXo
         kfwD3iaRyNC67CvRb3VrqXo8WbW8vWjFywC8ZpAksuAdFSVjNnQwW5a5Rdohc74AiqPA
         4abG6AC2IETzHcuI1ao35xZ3+Y5ySWt7/KuZVyDNpjfXjDOQlpYsPV0AHVmfQV8SfSpc
         1xKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752748381; x=1753353181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGNFpZqODfmzhJr9aiRrd+TX86pzNqh5cw08oNQmcLU=;
        b=xSqo5oTI1efwMaG7zk2YZ2piS0f3KD7tA7lDflwM4rb1A+WDpzB3H6ZS5NQ6NoTpLR
         x+po0p9LhJIlr9UAgggFoZ+0cepdy5kQ4O451hRF2hBlrauq6AGyKDm9UvZ3rdUsz2xy
         1SRYUqCnzHJXoyjSAbMfa5fcUJTz0o2mg6BxOBpHmjCS5L6xf34IwAipGDkC3idBMJfO
         sXQjzqkz1uIwu64UNtzjIQ3BC4le2c+fvyasxAwK4o10bUnGXymRQcVWqGlHJa63+mGA
         16i3CLorJ7evOEgTP9IDRyi2hCL+vRjpcU+EQ60wfBZNHhwubW8SYqhWM3mGerCtAM8T
         XGtg==
X-Forwarded-Encrypted: i=1; AJvYcCUkD4qKGikYl6QyFyH8+5JEnaVNlkMmBLse9u8M1CKDC+bQFrcHt2KznG4f2LjFRbSA+WnpdobJp27h@vger.kernel.org, AJvYcCVGVUmVzxImBKIKUtUiRcoDPhXslXBx+94cyHxtM13lWfGaioMGhw53DjrCb5XHGz0nQD12jgCxZ7g=@vger.kernel.org, AJvYcCWeqGrdt6BZRq96Nk8LNtkZ3xNUfi9I4q9sGzuI2D7s8JBm5AwSFP2dcMW+aVrua8ofUZ+8gAJWInns@vger.kernel.org, AJvYcCWnCDW3eWxjwjbRo2Fk/f5ke7YSJEY0uRk0widWB8AuXjuLcdPvQa6YlJOH3S8lIEj4OJWPDVK3I7M7JQ==@vger.kernel.org, AJvYcCXY+R+tmi2z53eG9w1DJ8xMZfAM2Q5gtAV7VQVHtv6CobK1g7PJ89kf8KLeVhj0jNVrFuMn2nJFzuQ/L+rr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ea3Eif7/dp3tYJuqI9tVH5QP7sTcClDjsGkI8xagQsUAjaBG
	x3FAA+rtE9+VGwboKJjV5W7dwNE2zV3VgAVVC+Q8oQr+bCWuFWue8vS4
X-Gm-Gg: ASbGncuyrW6hNht6Cwd1qtgFg4GoB56l4SymPv+Uv7bzZ/xxd2BVnfaZov5tub8VoC9
	+A7ViaBffPuSdNX47QGpwudRato7jtWnAAXQKCC2clJb1O7S6kVu5Li9WTqlc1cHJrgYrZZcqfV
	u2t5aabouaBM9V72FXDmgC/R5Q6CW4wySkT8BR0PsGbVcc2UKRu+63NV6T+0lbfvN4pjG3D5RcZ
	tmVCqQbfnOjmYD2ubCJNe3kJzukg7leXjIzsnTMWFDWaLVeGGwluSmq68LvRO+tMqL6ZvtzQeKZ
	7NVaTg8+IhGXU8L8fIQNtZygjp2Xddj0qezhDIjzbgmSLYmORFmpLjGdRbKyDRV0iXT425S7UEK
	IkDKcD4CJk2vDRDSDN2fNw8H5PFQIqpeTi/SI4SzGL2U2ITmdPwCwdDVp6srmyvc+oTirDWt5Td
	lW9tDP0bzg6yccvA==
X-Google-Smtp-Source: AGHT+IEJyseOSQ7/RZYPnww/L9LgeDBNM4g6hD4cUsfsALyidX4LqCToCF9T7Owp+uYfqFCAdatHoQ==
X-Received: by 2002:a05:6000:2901:b0:3b6:1ed:9ad2 with SMTP id ffacd0b85a97d-3b60e51b8bdmr5306916f8f.42.1752748380572;
        Thu, 17 Jul 2025 03:33:00 -0700 (PDT)
Received: from localhost (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8bd1924sm20547938f8f.16.2025.07.17.03.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 03:32:59 -0700 (PDT)
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
Subject: [PATCH v2 6/7] irqchip/irq-imx-gpcv2: Embed syscore_ops in chip context
Date: Thu, 17 Jul 2025 12:32:40 +0200
Message-ID: <20250717103241.2806798-7-thierry.reding@gmail.com>
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

This enables the syscore callbacks to obtain the IRQ chip context
without relying on a separate global variable.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index bdee15a327f3..8e606baf3a01 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -19,6 +19,7 @@
 
 
 struct gpcv2_irqchip_data {
+	struct syscore_ops	syscore;
 	struct raw_spinlock	rlock;
 	void __iomem		*gpc_base;
 	u32			wakeup_sources[IMR_NUM];
@@ -26,7 +27,11 @@ struct gpcv2_irqchip_data {
 	u32			cpu2wakeup;
 };
 
-static struct gpcv2_irqchip_data *imx_gpcv2_instance __ro_after_init;
+static inline struct gpcv2_irqchip_data *
+from_syscore(struct syscore_ops *ops)
+{
+	return container_of(ops, struct gpcv2_irqchip_data, syscore);
+}
 
 static void __iomem *gpcv2_idx_to_reg(struct gpcv2_irqchip_data *cd, int i)
 {
@@ -35,14 +40,10 @@ static void __iomem *gpcv2_idx_to_reg(struct gpcv2_irqchip_data *cd, int i)
 
 static int gpcv2_wakeup_source_save(struct syscore_ops *ops)
 {
-	struct gpcv2_irqchip_data *cd;
+	struct gpcv2_irqchip_data *cd = from_syscore(ops);
 	void __iomem *reg;
 	int i;
 
-	cd = imx_gpcv2_instance;
-	if (!cd)
-		return 0;
-
 	for (i = 0; i < IMR_NUM; i++) {
 		reg = gpcv2_idx_to_reg(cd, i);
 		cd->saved_irq_mask[i] = readl_relaxed(reg);
@@ -54,22 +55,13 @@ static int gpcv2_wakeup_source_save(struct syscore_ops *ops)
 
 static void gpcv2_wakeup_source_restore(struct syscore_ops *ops)
 {
-	struct gpcv2_irqchip_data *cd;
+	struct gpcv2_irqchip_data *cd = from_syscore(ops);
 	int i;
 
-	cd = imx_gpcv2_instance;
-	if (!cd)
-		return;
-
 	for (i = 0; i < IMR_NUM; i++)
 		writel_relaxed(cd->saved_irq_mask[i], gpcv2_idx_to_reg(cd, i));
 }
 
-static struct syscore_ops imx_gpcv2_syscore_ops = {
-	.suspend	= gpcv2_wakeup_source_save,
-	.resume		= gpcv2_wakeup_source_restore,
-};
-
 static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct gpcv2_irqchip_data *cd = d->chip_data;
@@ -275,8 +267,9 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	 */
 	writel_relaxed(~0x1, cd->gpc_base + cd->cpu2wakeup);
 
-	imx_gpcv2_instance = cd;
-	register_syscore_ops(&imx_gpcv2_syscore_ops);
+	cd->syscore.suspend = gpcv2_wakeup_source_save;
+	cd->syscore.resume = gpcv2_wakeup_source_restore;
+	register_syscore_ops(&cd->syscore);
 
 	/*
 	 * Clear the OF_POPULATED flag set in of_irq_init so that
-- 
2.50.0


