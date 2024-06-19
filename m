Return-Path: <linux-pci+bounces-8983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C1190F07A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 16:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391BF1C228D8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 14:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC051429B;
	Wed, 19 Jun 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr7mkG2m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F5F125AC
	for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807314; cv=none; b=RSwZ0mi4k4fi8S4RIUiof+Wkr4s1+aycWTTV9oHXgWMtirMlgK7kx0/lPXSC+jzcTGZKs2xxBBdeZfnbv5yOPl+oBt/okxK3byNrtPrssMZFB4Cl/dQhrsUkeX670BK+8Kg5etncM2EL2yx6HCLys/8lRjcS4nZ5Az2hHrBJ9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807314; c=relaxed/simple;
	bh=9THZQoWcY7pppy+k12IgOUowco4lraaYF67MhxmEgwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NKO+cXA02xSxtujKYmTlJI+713BbIjJXY0NiVS6U6MQgYHS5PBkETBKmofbwIVNLMOo62rJ0ceFEFgvx2bVFRt1Ht01Grlwrdh4KyJJkJ6vsJyjX2u9SZUxDvE7guOzxcB4txyJBtwkoKXUWoxJ6peFJsyFr1c/NdnWAOqlVHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr7mkG2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02184C2BBFC;
	Wed, 19 Jun 2024 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807313;
	bh=9THZQoWcY7pppy+k12IgOUowco4lraaYF67MhxmEgwk=;
	h=From:To:Cc:Subject:Date:From;
	b=lr7mkG2mp+xYIAx5A27QwHO7pYZ0TgqquCvOqy/8/rbuUjMgLySUqF1NXkKytmhNN
	 /h0HQahap1RPH27H8wtnDR+UL2kYAHTM65s8daPzCKeH+CptmGh3IlvzguPeOZO2rG
	 Q0ZfF2MZPHvYI+wAQ0PZotJEKMNLnwBBQNIKA0rn8glu5oZXr6lbqxAk198pktbt8l
	 XGj1yv+bqMdo5R3vVpUtpsKNcmSlG7TvV2XnJ/lX9seH7gWuMf0PPcuS9Zh33wr0rC
	 kIcaQGVBQSZM/RqJ1Q/RI5p6gonPbODX05gstRcwdPxuRixsNCHOW0IN11hkPm4lDc
	 +5QkyBx7Ps/KQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: mvebu: Dispose INTx irqs prior to removing INTx domain
Date: Wed, 19 Jun 2024 16:28:29 +0200
Message-ID: <20240619142829.2804-1-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pali Rohár <pali@kernel.org>

Documentation for irq_domain_remove() says that all mapping within the
domain must be disposed prior to domain remove.

Currently INTx irqs are not disposed in pci-mvebu.c device unbind callback
which cause that kernel crashes after unloading driver and trying to read
/sys/kernel/debug/irq/irqs/<num> or /proc/interrupts.

Fixes: ec075262648f ("PCI: mvebu: Implement support for legacy INTx interrupts")
Reported-by: Hajo Noerenberg <hajo-linux-bugzilla@noerenberg.de>
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
[ refactored a little ]
Signed-off-by: Marek Behún <kabel@kernel.org>
---
This was discussed back in 2022
  https://lore.kernel.org/linux-arm-kernel/20220709161858.15031-1-pali@kernel.org/
IMO Pali gave good arguments about why it should be applied, and Lorenzo
agreed.

Can we get this applied?
---
 drivers/pci/controller/pci-mvebu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 29fe09c99e7d..91a02b23aeb1 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1683,8 +1683,15 @@ static void mvebu_pcie_remove(struct platform_device *pdev)
 			irq_set_chained_handler_and_data(irq, NULL, NULL);
 
 		/* Remove IRQ domains. */
-		if (port->intx_irq_domain)
+		if (port->intx_irq_domain) {
+			for (int j = 0; j < PCI_NUM_INTX; j++) {
+				int virq = irq_find_mapping(port->intx_irq_domain, j);
+
+				if (virq > 0)
+					irq_dispose_mapping(virq);
+			}
 			irq_domain_remove(port->intx_irq_domain);
+		}
 
 		/* Free config space for emulated root bridge. */
 		pci_bridge_emul_cleanup(&port->bridge);
-- 
2.44.2


