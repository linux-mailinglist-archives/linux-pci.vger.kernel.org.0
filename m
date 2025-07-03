Return-Path: <linux-pci+bounces-31378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF04AF705E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B8E3B3066
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BFA2E3AF5;
	Thu,  3 Jul 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAM8WucZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778E42E54CF;
	Thu,  3 Jul 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538463; cv=none; b=tmIOvaxydzQ+i+4f9difBrkXdvJ8DMswKPmXTtrzyZa0DGNin+bhHT1Bnp8qgP//stwqY4I+CQ0i2QikogQia1s9Fr6MAe6LpbRaUKkLG18HRvHofGwaqX2GNeyMhpkLDt7OTO2LzD7f9IzB2LlkRmIcjkvXUTVGncru5pczajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538463; c=relaxed/simple;
	bh=dzBAiGg88kZkWCQEw27NLp04lJrDytYM5jJuijOSK0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqi6NLoF9mnxgVpnanS+wOOmgVS/7kAH6IaoBdha/nazk8hFSTdkqhZ/GiMloY6iJtYWy8DfMWkMTLOuz6fkSZBk5JzaSUqBAyH38Hzf0zX6kbQzMCBA2V9bIeZYtZ8e9cv/en5MFRaBgdeqvZicg8boCt5ai5lBKyc8jSIpXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAM8WucZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FFDC4CEED;
	Thu,  3 Jul 2025 10:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538463;
	bh=dzBAiGg88kZkWCQEw27NLp04lJrDytYM5jJuijOSK0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uAM8WucZveyfVAU+piOtw3vbIcZg3TeIe6BCw9rV/oy+pSiBv//M0Sjkgs3j+atsr
	 mq+dGhaxv0YcfHGdUGKLDWqVuEPlNelzLDRBy8C+/lEn9sGQX+ngTuIDep4fF1LgtI
	 2HwzSOh+u5imF/+O6iXTBvAtnhhNvxgsdUerGgGtE6/EOr1D4vWjjVUsuaLsx4NI9G
	 +LCZk4sfEUisaa2XEk7/qhPn30OSer4OBuWviTpanqgnP45f2hB5XOTaLrIAYCH4HT
	 igfvstcsReqYUPx1ErPeUqk0OAeh/8jPVuYJxKf/L7pdcYn/IIzQfoK13k/Apn4W6/
	 7SAW6TWs97fVQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 03 Jul 2025 12:25:17 +0200
Subject: [PATCH v7 27/31] irqchip/msi-lib: Add
 IRQ_DOMAIN_FLAG_FWNODE_PARENT handling
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-gicv5-host-v7-27-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
In-Reply-To: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Timothy Hayes <timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15-dev-6f78e

In some irqchip implementations the fwnode representing the IRQdomain
and the MSI controller fwnode do not match; in particular the IRQdomain
fwnode is the MSI controller fwnode parent.

To support selecting such IRQ domains, add a flag in core IRQ domain
code that explicitly tells the MSI lib to use the parent fwnode while
carrying out IRQ domain selection.

Update the msi-lib select callback with the resulting logic.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-msi-lib.c | 5 ++++-
 include/linux/irqdomain.h     | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 246c30205af4..454c7f16dd4d 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -133,11 +133,14 @@ int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 {
 	const struct msi_parent_ops *ops = d->msi_parent_ops;
 	u32 busmask = BIT(bus_token);
+	struct fwnode_handle *fwh;
 
 	if (!ops)
 		return 0;
 
-	if (fwspec->fwnode != d->fwnode || fwspec->param_count != 0)
+	fwh = d->flags & IRQ_DOMAIN_FLAG_FWNODE_PARENT ? fwnode_get_parent(fwspec->fwnode)
+						       : fwspec->fwnode;
+	if (fwh != d->fwnode || fwspec->param_count != 0)
 		return 0;
 
 	/* Handle pure domain searches */
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 7387d183029b..25c7cbeed393 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -212,6 +212,9 @@ enum {
 	/* Address and data pair is mutable when irq_set_affinity() */
 	IRQ_DOMAIN_FLAG_MSI_IMMUTABLE	= (1 << 11),
 
+	/* IRQ domain requires parent fwnode matching */
+	IRQ_DOMAIN_FLAG_FWNODE_PARENT	= (1 << 12),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the

-- 
2.48.0


