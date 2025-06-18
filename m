Return-Path: <linux-pci+bounces-30051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C8AADE8C8
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 12:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D983AE82A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213E42E425F;
	Wed, 18 Jun 2025 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcroIcuB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7AC289E3C;
	Wed, 18 Jun 2025 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242009; cv=none; b=fXDqXHvPGfyTkRtpRGoAN5SWzQInLtH+Kcs0NLHzhIot+57y3e+SXIn14iHj5Js/GrEUvEqm/6o0OVHDMvJtBiJXaM/kF4hVC0HciuWDlx9DO1QNEsxiAP6ebvNwqwA+gvrf9h9lHbhUnJ0WMA9n7TV+kbd+6yG8FuafLGmZ8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242009; c=relaxed/simple;
	bh=NxD1GAupdFUe2UjdbUAMvLXm1bj4jITeGOSzkPUL8FI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LW+I856TQs5E9O0VfHNHDRaD/xl2ulNu48w1FfWtVH37mUAn5dhA7yj89sEFvQ51CHKqqN2flGVw26uByYLi4oqTTtFphwWXmSBJqFAYK2SP7mx48/+b3HgPJKcg/xPFWi1P/mAR0K1yk3/oY0MyXo2ff0Leep4ufEPv86B3CMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcroIcuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85669C4CEF1;
	Wed, 18 Jun 2025 10:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750242008;
	bh=NxD1GAupdFUe2UjdbUAMvLXm1bj4jITeGOSzkPUL8FI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GcroIcuB+z/8xMOqeUYC4Nzh6sc1fXQA8z7eMr8uaMkNV5NPm3VyqQBqsm8cLrzym
	 nIbcom/UPtDQ9TwfjFC8zEhcEtfYEPMlZdu+aNQcXO/Re1mgVYsBIOyeJLZ2b+iaFo
	 gzqm0I1vRbhTG6M+5DyltiugMfYyg9z0t34hVGdREtBuR81uEyE0nnwWdde9/+QvUa
	 UZOiP/NvzKPCt2sUuq7M1hlF/e/UmdHWB9IHBd72FV7cfJkLD3k7I/o8AmBsYYffmt
	 dW9n3eB4YPaiUP8zI3y+EL2Wdkl3/yjwJb0+LLJ52AuLCV39VmU6diB02B4AtMycB6
	 H0LdOUESjiL+Q==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 18 Jun 2025 12:17:41 +0200
Subject: [PATCH v5 26/27] docs: arm64: gic-v5: Document booting
 requirements for GICv5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-gicv5-host-v5-26-d9e622ac5539@kernel.org>
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


