Return-Path: <linux-pci+bounces-30048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3342AADE8A5
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 12:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D15163BC9
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 10:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F77C2DFF32;
	Wed, 18 Jun 2025 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlEetfEQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D0D2DFF2D;
	Wed, 18 Jun 2025 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241992; cv=none; b=uVRmsDB5na7YaKLQnLWvJY5r7s8B047hvt5lFEZ+7YHX4lOFuHClQIjKytX+6xQAbmQR3c7maUtpRLxHdN6t8iG8ieXqJkBUa60GESUzZHsGvx0FPiVM1KJVhpMLFm5JNO3FDcJRna9rg6840JBGbjzh+WnF6VzUp2+s35Dzi3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241992; c=relaxed/simple;
	bh=Va9KYuR92Ny8pbO7LbUswID7eIVCWK7Q27i68S+Wfe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P5CGPj4QPnFec72O45VIj9MkaYVOVXBWWnMRYl5YK03I3vRhkO8CEdAoHcvH9ajbiHn46fhlEVsFW9ZDORyzpoGmhem7zVbi0F90HNYUuvgWe5rLknfKAruKSsJ5t8j1FDs7mb13+YVeQ7wQS+IedB0ePqEF+AfSQSD0BjhUyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlEetfEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152B8C4CEF2;
	Wed, 18 Jun 2025 10:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750241992;
	bh=Va9KYuR92Ny8pbO7LbUswID7eIVCWK7Q27i68S+Wfe8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OlEetfEQJw4aCrKp6FQzlBzn3RJaonPtqBfY91YutpTiLWGF+IUBeoYwlI1/dQ7h7
	 ZEAlQ7Q1mlOr4kIHOnX1OoMlU7BK+0w0WmBoXrCB5n4O1iZbhhBmS3Rt2iv2psFoPT
	 056YknfpoWrxS1hELqs24f9bA97PRS4AfEsP4B2iCj0QyT05uA+7V+qIANiQQVhxpD
	 6wUVHMuC/zFB7og7MK00D1wV6KCOXM0CzhMQRLRK3k9HBgXLYIIkmG5EMYqR4q3OBj
	 BjlgC13hrYjl+exXlLPNT56I+pF8/K36kedEoP8hx3ZWydxDOkAmve4gOGkEt4d67k
	 esyLKuo+pPOPQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 18 Jun 2025 12:17:38 +0200
Subject: [PATCH v5 23/27] irqchip/gic-v5: Enable GICv5 SMP booting
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-gicv5-host-v5-23-d9e622ac5539@kernel.org>
References: <20250618-gicv5-host-v5-0-d9e622ac5539@kernel.org>
In-Reply-To: <20250618-gicv5-host-v5-0-d9e622ac5539@kernel.org>
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

Set up IPIs by allocating IPI IRQs for all cpus and call into
arm64 core code to initialise IPIs IRQ descriptors and
request the related IRQ.

Implement hotplug callback to enable interrupts on a cpu
and register the cpu with an IRS.

Co-developed-by: Sascha Bischoff <sascha.bischoff@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
Co-developed-by: Timothy Hayes <timothy.hayes@arm.com>
Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v5.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index cee29aa750a2..c2e7ba7e38f7 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt)	"GICv5: " fmt
 
+#include <linux/cpuhotplug.h>
 #include <linux/idr.h>
 #include <linux/irqdomain.h>
 #include <linux/slab.h>
@@ -909,6 +910,8 @@ static void gicv5_cpu_enable_interrupts(void)
 	write_sysreg_s(cr0, SYS_ICC_CR0_EL1);
 }
 
+static int base_ipi_virq;
+
 static int gicv5_starting_cpu(unsigned int cpu)
 {
 	if (WARN(!gicv5_cpuif_has_gcie(),
@@ -920,6 +923,22 @@ static int gicv5_starting_cpu(unsigned int cpu)
 	return gicv5_irs_register_cpu(cpu);
 }
 
+static void __init gicv5_smp_init(void)
+{
+	unsigned int num_ipis = GICV5_IPIS_PER_CPU * nr_cpu_ids;
+
+	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
+				  "irqchip/arm/gicv5:starting",
+				  gicv5_starting_cpu, NULL);
+
+	base_ipi_virq = irq_domain_alloc_irqs(gicv5_global_data.ipi_domain,
+					      num_ipis, NUMA_NO_NODE, NULL);
+	if (WARN(base_ipi_virq <= 0, "IPI IRQ allocation was not successful"))
+		return;
+
+	set_smp_ipi_range_percpu(base_ipi_virq, GICV5_IPIS_PER_CPU, nr_cpu_ids);
+}
+
 static void __init gicv5_free_domains(void)
 {
 	if (gicv5_global_data.ppi_domain)
@@ -1041,6 +1060,8 @@ static int __init gicv5_of_init(struct device_node *node, struct device_node *pa
 	if (ret)
 		goto out_int;
 
+	gicv5_smp_init();
+
 	return 0;
 out_int:
 	gicv5_cpu_disable_interrupts();

-- 
2.48.0


