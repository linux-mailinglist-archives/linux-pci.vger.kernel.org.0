Return-Path: <linux-pci+bounces-38887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DF7BF6808
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7E9F503C55
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1A1332EAB;
	Tue, 21 Oct 2025 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8kbiDNk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550A9332EA2;
	Tue, 21 Oct 2025 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050481; cv=none; b=CS+qqR2Z+98D9Qyi1quKgDa1EYDj8wX6AECoAqkTxQJplnK9TBYGtZ7L9My0lanmRxVnq73wD2lLVeXVQv6kNAYgYqV9jfMqgES0f4oViz6c/gYcpK1FoSm8Dau97JhuNZoZ5bDm8j2/QlMo5PjD+6g8muuG2OG+nJdWWKIp4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050481; c=relaxed/simple;
	bh=+KrQ8+/Xpeyyg0XnnZnoOXc5K2eE7Yf3Idw+8Qii2j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D38Owdr3YyiHUHYcYXnLr6avV6yPPbc+uEk4C1B7ENuXd29+ZMa/E53SPwqNTiq5JUZSmbp1hrbBjeJUOjUrhAVgcxty6fsldQq7lFhyxYQKMyVAv2mTjI3WGaURo7baD8uaoJcA0BRhi4UQKG+f07WscXR9DjN6h9xHXMfWs64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8kbiDNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AFDC4CEFF;
	Tue, 21 Oct 2025 12:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761050480;
	bh=+KrQ8+/Xpeyyg0XnnZnoOXc5K2eE7Yf3Idw+8Qii2j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8kbiDNknMZb/FC+i5v5f+TFVKK+HM/KGJTHGUFkJwM3orpLLSq+vpuZhATlyhVPp
	 Kzc2YTzXJJqczzz1z9sLQdClMg1HeLI1mcmXTT6/lLPPkhLOhZm6eioJqrQv36oJy6
	 PLE0gC19x+g6UoJN3oVY9RmI/FloI06eWdJsWKsG6CVKUXSVr7MjMFwYL05YAueJ3X
	 YyNHG8v0vQVbYX+vPi+pLgbwhVbNizAj8q777TlUPkv5F4OHm9MpAhSTtUACM6Uujg
	 3TThY0i2tXtfxI+Q8Sc6p5PryAXgUZAUf1r69b/aPRIO7o7/fJJbvNa0oGp93dsgzI
	 jd29mY0IyC2ig==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v4 2/5] of/irq: Fix OF node refcount in of_msi_get_domain()
Date: Tue, 21 Oct 2025 14:41:00 +0200
Message-ID: <20251021124103.198419-3-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251021124103.198419-1-lpieralisi@kernel.org>
References: <20251021124103.198419-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In of_msi_get_domain() if the iterator loop stops early because an
irq_domain match is detected, an of_node_put() on the iterator node is
needed to keep the OF node refcount in sync.

Add it.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>
---
 drivers/of/irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 321d40ec229b..ee7d5f0842e8 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -774,8 +774,10 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
 
 	of_for_each_phandle(&it, err, np, "msi-parent", "#msi-cells", 0) {
 		d = irq_find_matching_host(it.node, token);
-		if (d)
+		if (d) {
+			of_node_put(it.node);
 			return d;
+		}
 	}
 
 	return NULL;
-- 
2.50.1


