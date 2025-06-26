Return-Path: <linux-pci+bounces-30725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C30AE9B80
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EE37B7A9C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166952D3EF0;
	Thu, 26 Jun 2025 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBx8KwQ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD90B23815F;
	Thu, 26 Jun 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933677; cv=none; b=AG6CY7Fdr8FPgT4cMHE8BUYd9nVw3TkKIls+pUqo+vnf1c+H1lGuBLPh0nIwDxM/wO+KeFUmGC/Igd+suOZmhki09aKtn0CUxqAzo6ogdmVa0Ei6k2vjognkt8GE9J6JW31Rjg5gPWxPo8a3aMKs0CaVp1u0itjXea8Z13obQv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933677; c=relaxed/simple;
	bh=/dE8LD/ePWA/0RVJBLeEqlL5qzeRTK7k8l1BILw0Xkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNN6CgosAbqkcFoeGrKESrqymnE9seBPIXA5IQ6r9Q9HVUkCP3a2KN4uO10Y8WzF0QuAWst7aSvF53bENhKUXVYpcQPhqnjKNo9IqVFT7AWR9oqOEA0GLZeFaLqPdVX8X2fnC5Ufolkq4ruz0Yl6IV3UK3VqHX9H9xwmi4gUD/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBx8KwQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09BBC4CEEB;
	Thu, 26 Jun 2025 10:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933676;
	bh=/dE8LD/ePWA/0RVJBLeEqlL5qzeRTK7k8l1BILw0Xkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NBx8KwQ/BAWKpevPsWEBVC9utzRnBHepvygNP57P/2sLF53lXXu3qu1MVTFcbEhNh
	 Yb8cE/j5BPrM9lLmyNmgJDuI8t8Wxnk3VqZK+57ecgCoeHW1AT9pS2u4Se/V5FtvyB
	 diDPuMIBSGRsZja2dXCYTEiq37g2YChq+sl/qwn8tWJydbjOUdLwyFOiazAmy0B4yY
	 npE2GgpwQqeTyIhkE+45IRDz2EU9mqg9Spl42Mx1rbcX80OckjZq35jC9JUAFZvlu2
	 dcSDf3Ypge5sPoB8HFHvN9Jice1VGqOgZyBIDA7YTIRnAQ24O3lNFSWqDbVoCUyJjh
	 tljtPloGkyP7A==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:26:08 +0200
Subject: [PATCH v6 17/31] arm64: cpucaps: Add GICv5 CPU interface (GCIE)
 capability
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-17-48e046af4642@kernel.org>
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

Implement the GCIE capability as a strict boot cpu capability to
detect whether architectural GICv5 support is available in HW.

Plug it in with a naming consistent with the existing GICv3
CPU interface capability.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 7 +++++++
 arch/arm64/tools/cpucaps       | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 42ba76b6c8cd..2fa26129762c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3061,6 +3061,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_pmuv3,
 	},
 #endif
+	{
+		.desc = "GICv5 CPU interface",
+		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
+		.capability = ARM64_HAS_GICV5_CPUIF,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64PFR2_EL1, GCIE, IMP)
+	},
 	{},
 };
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index a7a4d9e6e12e..8665e4cfbeab 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -36,6 +36,7 @@ HAS_GENERIC_AUTH_ARCH_QARMA3
 HAS_GENERIC_AUTH_ARCH_QARMA5
 HAS_GENERIC_AUTH_IMP_DEF
 HAS_GICV3_CPUIF
+HAS_GICV5_CPUIF
 HAS_GIC_PRIO_MASKING
 HAS_GIC_PRIO_RELAXED_SYNC
 HAS_HCR_NV1

-- 
2.48.0


