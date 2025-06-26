Return-Path: <linux-pci+bounces-30738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE4AE9BB1
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB1F7BA48D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67BD2E1C50;
	Thu, 26 Jun 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb0+Auz8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13226B97F;
	Thu, 26 Jun 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933746; cv=none; b=j8G+EqqoAw4YVzjDzEYbGe7YKhVrWHHqmCdkjqOmpZZtmo092s2Kpj6pJopm/bkFa2jekl1UJDmyzh0MKmr4OypUc38AKsaSqopk57Q7cnudQLuHGgq6qyX8kVotSqZ7qgdPobtTlCCdUmosvXEjKhvgJTMmSW3dMNM9/WYrSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933746; c=relaxed/simple;
	bh=NxD1GAupdFUe2UjdbUAMvLXm1bj4jITeGOSzkPUL8FI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DHI4+RdT0leAjGTWXpvQFo4gKIzQ/XtlesBUQF1eF2fDwCeVzf5+oorHGXlG8Gz7EAqaI0cGiOlpXKYdgxxtvWJ8/FswAk9ttgI2PyN43Nj0SEQhLpIL1uD3ozqhWcBdlkj1JS/ZGwRcJnUFKyX1T4USSBHYKCfyh7HE9g+OI6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb0+Auz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62057C4CEF1;
	Thu, 26 Jun 2025 10:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933746;
	bh=NxD1GAupdFUe2UjdbUAMvLXm1bj4jITeGOSzkPUL8FI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lb0+Auz87vvhfHj3YKKiYYZftgzmzNa0hh/KmPVZE/uxxeEGRVbWJ8ZvDSDgVKMXG
	 l0h8Hx3RRRSWKKDYKmPu/BZMDbh9nJRAFDGO0hKUPkKb5sCQW1ICyEtqiWMg8Q671C
	 pOcSBjTjelu8BjEGx1RewSUOStNPtt4XryzDyeg4eyhpgLa2hgjJ2piZhkvX3EM0s0
	 HSEK5g0/ugfFtKLsckCx0bHA57RLM5Cff2uGf/tk+HnSII+dGgyuCd+VEfKGSY6FaU
	 YpHz+M4zGz6lhTTJUuaimRS9Umu1MGBgWrbEcPQdaFpaaMWgh145B/YNfT1dskyjuS
	 IdZoSFHzA5QGQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:26:21 +0200
Subject: [PATCH v6 30/31] docs: arm64: gic-v5: Document booting
 requirements for GICv5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-30-48e046af4642@kernel.org>
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

Document the requirements for booting a kernel on a system implementing
a GICv5 interrupt controller.

Specifically, other than DT/ACPI providing the required firmware
representation, define what traps must be disabled if the kernel is
booted at EL1 on a system where EL2 is implemented.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 Documentation/arch/arm64/booting.rst | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index dee7b6de864f..4b1d416c6016 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -223,6 +223,47 @@ Before jumping into the kernel, the following conditions must be met:
 
     - SCR_EL3.HCE (bit 8) must be initialised to 0b1.
 
+  For systems with a GICv5 interrupt controller to be used in v5 mode:
+
+  - If the kernel is entered at EL1 and EL2 is present:
+
+      - ICH_HFGRTR_EL2.ICC_PPI_ACTIVERn_EL1 (bit 20) must be initialised to 0b1.
+      - ICH_HFGRTR_EL2.ICC_PPI_PRIORITYRn_EL1 (bit 19) must be initialised to 0b1.
+      - ICH_HFGRTR_EL2.ICC_PPI_PENDRn_EL1 (bit 18) must be initialised to 0b1.
+      - ICH_HFGRTR_EL2.ICC_PPI_ENABLERn_EL1 (bit 17) must be initialised to 0b1.
+      - ICH_HFGRTR_EL2.ICC_PPI_HMRn_EL1 (bit 16) must be initialised to 0b1.
+      - ICH_HFGRTR_EL2.ICC_IAFFIDR_EL1 (bit 7) must be initialised to 0b1.
+      - ICH_HFGRTR_EL2.ICC_ICSR_EL1 (bit 6) must be initialised to 0b1.
+      - ICH_HFGRTR_EL2.ICC_PCR_EL1 (bit 5) must be initialised to 0b1.
+      - ICH_HFGRTR_EL2.ICC_HPPIR_EL1 (bit 4) must be initialised to 0b1.
+      - ICH_HFGRTR_EL2.ICC_HAPR_EL1 (bit 3) must be initialised to 0b1.
+      - ICH_HFGRTR_EL2.ICC_CR0_EL1 (bit 2) must be initialised to 0b1.
+      - ICH_HFGRTR_EL2.ICC_IDRn_EL1 (bit 1) must be initialised to 0b1.
+      - ICH_HFGRTR_EL2.ICC_APR_EL1 (bit 0) must be initialised to 0b1.
+
+      - ICH_HFGWTR_EL2.ICC_PPI_ACTIVERn_EL1 (bit 20) must be initialised to 0b1.
+      - ICH_HFGWTR_EL2.ICC_PPI_PRIORITYRn_EL1 (bit 19) must be initialised to 0b1.
+      - ICH_HFGWTR_EL2.ICC_PPI_PENDRn_EL1 (bit 18) must be initialised to 0b1.
+      - ICH_HFGWTR_EL2.ICC_PPI_ENABLERn_EL1 (bit 17) must be initialised to 0b1.
+      - ICH_HFGWTR_EL2.ICC_ICSR_EL1 (bit 6) must be initialised to 0b1.
+      - ICH_HFGWTR_EL2.ICC_PCR_EL1 (bit 5) must be initialised to 0b1.
+      - ICH_HFGWTR_EL2.ICC_CR0_EL1 (bit 2) must be initialised to 0b1.
+      - ICH_HFGWTR_EL2.ICC_APR_EL1 (bit 0) must be initialised to 0b1.
+
+      - ICH_HFGITR_EL2.GICRCDNMIA (bit 10) must be initialised to 0b1.
+      - ICH_HFGITR_EL2.GICRCDIA (bit 9) must be initialised to 0b1.
+      - ICH_HFGITR_EL2.GICCDDI (bit 8) must be initialised to 0b1.
+      - ICH_HFGITR_EL2.GICCDEOI (bit 7) must be initialised to 0b1.
+      - ICH_HFGITR_EL2.GICCDHM (bit 6) must be initialised to 0b1.
+      - ICH_HFGITR_EL2.GICCDRCFG (bit 5) must be initialised to 0b1.
+      - ICH_HFGITR_EL2.GICCDPEND (bit 4) must be initialised to 0b1.
+      - ICH_HFGITR_EL2.GICCDAFF (bit 3) must be initialised to 0b1.
+      - ICH_HFGITR_EL2.GICCDPRI (bit 2) must be initialised to 0b1.
+      - ICH_HFGITR_EL2.GICCDDIS (bit 1) must be initialised to 0b1.
+      - ICH_HFGITR_EL2.GICCDEN (bit 0) must be initialised to 0b1.
+
+  - The DT or ACPI tables must describe a GICv5 interrupt controller.
+
   For systems with a GICv3 interrupt controller to be used in v3 mode:
   - If EL3 is present:
 

-- 
2.48.0


