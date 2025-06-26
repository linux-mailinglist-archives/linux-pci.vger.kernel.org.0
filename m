Return-Path: <linux-pci+bounces-30724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBB6AE9B56
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63431C21818
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6852D3ECC;
	Thu, 26 Jun 2025 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skVXL6jb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09A7263C90;
	Thu, 26 Jun 2025 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933671; cv=none; b=ZrcYQt5Ur3IrhBm+JBUp7Ep3b9ib/B2KMFAQqXH4a+THoNgASoajXvjEIRH3Rd/9/c4zyP1z+zMovsTpc9RLNbuauG9r8r1qS9/DqVQVAzhyPLzzLurAlo2rGmVhuIzYqMN6INSvOVQjzIFbhoFyInH2VakkEM2R4kg13GPvc9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933671; c=relaxed/simple;
	bh=cMjcYS3nYWnZwMk3IuZcL+D8usjwsSZbBSXX5Y6yRtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQDm9DMS3mbyY68oXx9bplsS9nOkveFkXg5eXjzNdcy5SZXa+cOPlqTYGt5CNw00yQuShj83/aeBnRUTzYAgMiOVuopfqoW5XiS5sMqfgT9qDpV/qWojCuvg3MR101esT0vTgcZVVD/bfLfzJbB7chFw1ozqsDFbKB0jlmHfmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skVXL6jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7455EC4CEEE;
	Thu, 26 Jun 2025 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933671;
	bh=cMjcYS3nYWnZwMk3IuZcL+D8usjwsSZbBSXX5Y6yRtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=skVXL6jbFl/Yc2a8ybHkOuKyRfx02/biThOYbEUilhkRny6TR4UhSTvNGgMxHsCID
	 rq0Y5ssW7O8PZJ9Q5u76vTSPZ5RRbhJg5gB5AOqlMCwCirEOxie8gHKe4PlmztbFu5
	 fiZjf/V2DJpuP/F5m8miSAgmzgo5qY+TVWyXJlBMTBXPEUEY7hwYd/FHMLUrYRIqIo
	 xMHGvQTmYAX15zagj3SD5OsPwkP9OocflGOX3wW5HS42kmCLq/rHArxW3oJJy950cI
	 9sKcEKb9tubH9AMP/GQaHJMwF8dLs7muC8LSN9Lgi4OHZLZVdjJWqzFTpMX2FPAI0Y
	 zeQu3Trlu5Gmw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:26:07 +0200
Subject: [PATCH v6 16/31] arm64: cpucaps: Rename GICv3 CPU interface
 capability
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-16-48e046af4642@kernel.org>
References: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
In-Reply-To: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
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

In preparation for adding a GICv5 CPU interface capability,
rework the existing GICv3 CPUIF capability - change its name and
description so that the subsequent GICv5 CPUIF capability
can be added with a more consistent naming on top.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 10 +++++-----
 arch/arm64/tools/cpucaps       |  2 +-
 drivers/irqchip/irq-gic.c      |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b34044e20128..42ba76b6c8cd 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2296,11 +2296,11 @@ static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
 				   int scope)
 {
 	/*
-	 * ARM64_HAS_GIC_CPUIF_SYSREGS has a lower index, and is a boot CPU
+	 * ARM64_HAS_GICV3_CPUIF has a lower index, and is a boot CPU
 	 * feature, so will be detected earlier.
 	 */
-	BUILD_BUG_ON(ARM64_HAS_GIC_PRIO_MASKING <= ARM64_HAS_GIC_CPUIF_SYSREGS);
-	if (!cpus_have_cap(ARM64_HAS_GIC_CPUIF_SYSREGS))
+	BUILD_BUG_ON(ARM64_HAS_GIC_PRIO_MASKING <= ARM64_HAS_GICV3_CPUIF);
+	if (!cpus_have_cap(ARM64_HAS_GICV3_CPUIF))
 		return false;
 
 	return enable_pseudo_nmi;
@@ -2496,8 +2496,8 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_always,
 	},
 	{
-		.desc = "GIC system register CPU interface",
-		.capability = ARM64_HAS_GIC_CPUIF_SYSREGS,
+		.desc = "GICv3 CPU interface",
+		.capability = ARM64_HAS_GICV3_CPUIF,
 		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
 		.matches = has_useable_gicv3_cpuif,
 		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, GIC, IMP)
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 10effd4cff6b..a7a4d9e6e12e 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -35,7 +35,7 @@ HAS_GENERIC_AUTH
 HAS_GENERIC_AUTH_ARCH_QARMA3
 HAS_GENERIC_AUTH_ARCH_QARMA5
 HAS_GENERIC_AUTH_IMP_DEF
-HAS_GIC_CPUIF_SYSREGS
+HAS_GICV3_CPUIF
 HAS_GIC_PRIO_MASKING
 HAS_GIC_PRIO_RELAXED_SYNC
 HAS_HCR_NV1
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 6503573557fd..1269ab8eb726 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -54,7 +54,7 @@
 
 static void gic_check_cpu_features(void)
 {
-	WARN_TAINT_ONCE(this_cpu_has_cap(ARM64_HAS_GIC_CPUIF_SYSREGS),
+	WARN_TAINT_ONCE(this_cpu_has_cap(ARM64_HAS_GICV3_CPUIF),
 			TAINT_CPU_OUT_OF_SPEC,
 			"GICv3 system registers enabled, broken firmware!\n");
 }

-- 
2.48.0


