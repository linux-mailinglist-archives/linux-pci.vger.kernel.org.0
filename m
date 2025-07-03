Return-Path: <linux-pci+bounces-31374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9ADAF7049
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365371BC2CFF
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F732EA17D;
	Thu,  3 Jul 2025 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxmPvPSp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870222EA176;
	Thu,  3 Jul 2025 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538442; cv=none; b=dTeHH/2yvLfREC7VRG4AtY4EyO5PbAdTCEK/FUOj70k9UMJyZVQfmch93yby+En8fba+zQpSS8Dh48RK1wlLXDaffS699fhf/ixecyVlD7rBJDmogilke6G04YxxtoroGCUO19xm/lhcZzw4+cmR3viFGv96thbwGqY211nMpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538442; c=relaxed/simple;
	bh=xP1ZSDvdEMNzLFTksEUUUoXYt9M+SQ6BRBD+ihLwiLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mup/6CeKa8CkixC3/wXTlWb9R0xOUqcPENmU6g5OkAGCudsMRfueIf6r0RhUp5T5JeAKY+O0x6r5Hi/t2EPKUACXtW79TpP8LRZsfsw8oyTEKnErENhcjphYbgLK60MpeJuBBFAcoxT/rwtR5Tmzc0RHR2gJhZqSiQhgV22KRDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxmPvPSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BADBC4CEFA;
	Thu,  3 Jul 2025 10:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538442;
	bh=xP1ZSDvdEMNzLFTksEUUUoXYt9M+SQ6BRBD+ihLwiLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uxmPvPSpq33kyeY4be5Z2tqaZ5bDx4d3LlGrIKmUr5634blz9o5VEZeSLXUrMS1nZ
	 mhH11KUbpxOkDlCQlJs2yiKoECjGL8Pzm7npRb+rjy/A3SUxXXyp2oHqRLV74lKMMv
	 g8fY+nOfY3FFnsfER/ALJ2DQtFemxK5Uzf+kITaq/WHIZ7oEsFRXkqrsAJi/fxBgua
	 wEC9e/S5elECcAptXiOMht8j6MuwPWcF37gdyiv/b0JkyTJ1HEvjcryVM8pCgGxAUO
	 JBPlUGzstqUI795XYxO5g1usxHGR5qmD5MoA488hPKCIt24HkB5C2hjZnrfPader6g
	 T+2kfttwTkpIg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 03 Jul 2025 12:25:13 +0200
Subject: [PATCH v7 23/31] irqchip/gic-v5: Enable GICv5 SMP booting
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-gicv5-host-v7-23-12e71f1b3528@kernel.org>
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
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v5.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index 84ed13c4f2b1..97ff935d79bd 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt)	"GICv5: " fmt
 
+#include <linux/cpuhotplug.h>
 #include <linux/idr.h>
 #include <linux/irqdomain.h>
 #include <linux/slab.h>
@@ -918,6 +919,8 @@ static void gicv5_cpu_enable_interrupts(void)
 	write_sysreg_s(cr0, SYS_ICC_CR0_EL1);
 }
 
+static int base_ipi_virq;
+
 static int gicv5_starting_cpu(unsigned int cpu)
 {
 	if (WARN(!gicv5_cpuif_has_gcie(),
@@ -929,6 +932,22 @@ static int gicv5_starting_cpu(unsigned int cpu)
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
@@ -1050,6 +1069,8 @@ static int __init gicv5_of_init(struct device_node *node, struct device_node *pa
 	if (ret)
 		goto out_int;
 
+	gicv5_smp_init();
+
 	return 0;
 
 out_int:

-- 
2.48.0


