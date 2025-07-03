Return-Path: <linux-pci+bounces-31381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F28AF7065
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C909116266F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8EC2ED169;
	Thu,  3 Jul 2025 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFkpoiIN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C221D2ED15C;
	Thu,  3 Jul 2025 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538480; cv=none; b=dZ2OuZgIidn7XvZbzMbSNFO8Gj+mWxXsvX8tWWQdC1AYAS3P9YSGxko3LI+7xfcm4j5C5Z74LCLMz+B1AtZj9jxFvhaxbvtkw7JSr2yKnlbMlEXkL7CiBgLAmrYGxMYRvV3BGlcWAZ7FwJG7zCqJXL8QVXEYIx/fGHjS9WuKn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538480; c=relaxed/simple;
	bh=a9U6Azq4WkypWVG3l97xIWofH9Tf5doWeAgGMdKJXuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yzc8vC/bW1+jAlC63SkG4N7PgeZeTdCCPnKF9VOAJb32+O+rG3nHD7q+rkOJJH8NEsPdmxl/1VPAVyU/7le/1hHU244cVswLptNbI78BYADnQtk7KBMPotHcTKcDhmMF66qZYSl95tJpWJNBNviFmGmH3Anap+U6ZNOGM/EStfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFkpoiIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D42C4CEF1;
	Thu,  3 Jul 2025 10:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538480;
	bh=a9U6Azq4WkypWVG3l97xIWofH9Tf5doWeAgGMdKJXuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TFkpoiINC7Z5rFT3hlV8oq2Vhsf3HmazFCFhtdH4BoIagxTsqLmxUrw5M3Mn4MEEn
	 9kS+n6pTYH9dJxZA7+NohMiNnhVDt2IOYCkCIltc43n2RyIEBz1nwn5JLu/rjc0PhA
	 DjYMqjKYRTyrXHgsuh0WDFcajeHwYWPEKxam8OHVsLDkYGpOuFxQeLV2VgbO7j9RvL
	 q5/ZgTVYqbZ3p2loFCoWKep+L9qAvOjFbxrKUjqeNWW2uJff6wGPSl7Q52Z2iHYAGn
	 LZ91Ik0HsmBh0OY8+ANQ6fRoo26VA9Oy+epkXAsT1Xfxkzlvz5/5HnQio3dlmYGH3u
	 zpMD6zKUz+SUg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 03 Jul 2025 12:25:20 +0200
Subject: [PATCH v7 30/31] docs: arm64: gic-v5: Document booting
 requirements for GICv5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-gicv5-host-v7-30-12e71f1b3528@kernel.org>
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

Document the requirements for booting a kernel on a system implementing
a GICv5 interrupt controller.

Specifically, other than DT/ACPI providing the required firmware
representation, define what traps must be disabled if the kernel is
booted at EL1 on a system where EL2 is implemented.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
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


