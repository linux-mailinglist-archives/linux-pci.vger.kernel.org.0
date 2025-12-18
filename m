Return-Path: <linux-pci+bounces-43274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37634CCB543
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 11:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C181530B61CF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EE333D510;
	Thu, 18 Dec 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5x6jANk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799633D501;
	Thu, 18 Dec 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052909; cv=none; b=EXhHnO21m7wRcL8mG/cH+YkyM21KMWVeTwCVRMqzbe8LhNmx2IdP1DK6hleKLa9zIxLvGWu3HPNdazRWTuxV9vkyk2hofsEkJ07617KM4XX2x5fJfSkb06CafZTeWDnyau47yc3cc5y4bLe4YDd/0uvEP2sVpuO2DuOSylH0fq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052909; c=relaxed/simple;
	bh=vnKEmMAe21QcHMZuNYI4JA27L1lMdTDSUIpCnogDK/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AhqcOmdi3bgVtvkDUd4AtCzEUgKwnlpvPXU5/YHxH2A9qYIsRJex1MSYNiaLr1PCa1NAlNR0Ll00ylhkD/QahjDHi75ei24GXxOiAyuQE97Gtq8E/KtZHfQfbJYqpO+62uk7tzkFIJQHMRvrI/urHN1E6iTYADOEtzBaaOhaHyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5x6jANk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0317C113D0;
	Thu, 18 Dec 2025 10:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766052909;
	bh=vnKEmMAe21QcHMZuNYI4JA27L1lMdTDSUIpCnogDK/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k5x6jANk0HZCdFNmQ8ONf84TXV/hnSyODKlwPkYcldqK35T835k0zhX+1J4vW7h3x
	 YuB87dKAHfjZqQktHnSNr4I87e8QoyWT5BOJ269qYwQLCmSCWMU2w1Q6fhpovy0gLP
	 4eWRN+g777w/a0xuPlSuAun1xmByvIKvT/LLFIqgow5KUjz5yV1YRNf2DWvopeDGr0
	 P1epYRKg9q7Q1XG+lQpKfb0Yxo5vd3IJuudlbkUYwRI5n+asIIoPcWcBhAUkOjCAVe
	 9mfSNHPmKQKiuQvf7L3sP4dyf0ZEBcc/0nxFTgJ3I5yVKNinhOY83mAZay6hnUkWZq
	 y4rqden517tFg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 18 Dec 2025 11:14:27 +0100
Subject: [PATCH v2 1/7] ACPICA: Add GICv5 MADT structures
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-gicv5-host-acpi-v2-1-eec76cd1d40b@kernel.org>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
In-Reply-To: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Jose Marinho <jose.marinho@arm.com>
X-Mailer: b4 0.14.3

From: Jose Marinho <jose.marinho@arm.com>

The GICv5 adds the following MADT structures:
- IRS
- ITS Config Frame
- ITS Translate Frame

The ACPI spec ECR is at https://github.com/tianocore/edk2/issues/11148

Link: https://github.com/acpica/acpica/commit/69cca52d
Signed-off-by: Jose Marinho <jose.marinho@arm.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
 include/acpi/actbl2.h | 49 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index f726bce3eb84..fdabc6c64a9c 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1167,7 +1167,10 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_IMSIC = 25,
 	ACPI_MADT_TYPE_APLIC = 26,
 	ACPI_MADT_TYPE_PLIC = 27,
-	ACPI_MADT_TYPE_RESERVED = 28,	/* 28 to 0x7F are reserved */
+	ACPI_MADT_TYPE_GICV5_IRS = 28,
+	ACPI_MADT_TYPE_GICV5_ITS = 29,
+	ACPI_MADT_TYPE_GICV5_ITS_TRANSLATE = 30,
+	ACPI_MADT_TYPE_RESERVED = 31,	/* 31 to 0x7F are reserved */
 	ACPI_MADT_TYPE_OEM_RESERVED = 0x80	/* 0x80 to 0xFF are reserved for OEM use */
 };
 
@@ -1289,7 +1292,7 @@ struct acpi_madt_local_x2apic_nmi {
 	u8 reserved[3];		/* reserved - must be zero */
 };
 
-/* 11: Generic interrupt - GICC (ACPI 5.0 + ACPI 6.0 + ACPI 6.3 + ACPI 6.5 changes) */
+/* 11: Generic interrupt - GICC (ACPI 5.0 + ACPI 6.0 + ACPI 6.3 + ACPI 6.5 + ACPI 6.7 changes) */
 
 struct acpi_madt_generic_interrupt {
 	struct acpi_subtable_header header;
@@ -1310,6 +1313,8 @@ struct acpi_madt_generic_interrupt {
 	u8 reserved2[1];
 	u16 spe_interrupt;	/* ACPI 6.3 */
 	u16 trbe_interrupt;	/* ACPI 6.5 */
+	u16 iaffid;		/* ACPI 6.7 */
+	u32 irs_id;
 };
 
 /* Masks for Flags field above */
@@ -1332,7 +1337,7 @@ struct acpi_madt_generic_distributor {
 	u8 reserved2[3];	/* reserved - must be zero */
 };
 
-/* Values for Version field above */
+/* Values for Version field above and Version field in acpi_madt_gicv5_irs */
 
 enum acpi_madt_gic_version {
 	ACPI_MADT_GIC_VERSION_NONE = 0,
@@ -1340,7 +1345,8 @@ enum acpi_madt_gic_version {
 	ACPI_MADT_GIC_VERSION_V2 = 2,
 	ACPI_MADT_GIC_VERSION_V3 = 3,
 	ACPI_MADT_GIC_VERSION_V4 = 4,
-	ACPI_MADT_GIC_VERSION_RESERVED = 5	/* 5 and greater are reserved */
+	ACPI_MADT_GIC_VERSION_V5 = 5,
+	ACPI_MADT_GIC_VERSION_RESERVED = 6	/* 6 and greater are reserved */
 };
 
 /* 13: Generic MSI Frame (ACPI 5.1) */
@@ -1611,6 +1617,41 @@ struct acpi_madt_plic {
 	u32 gsi_base;
 };
 
+/* 28: Arm GICv5 IRS (ACPI 6.7) */
+struct acpi_madt_gicv5_irs {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 reserved;
+	u32 irs_id;
+	u32 flags;
+	u32 reserved2;
+	u64 config_base_address;
+	u64 setlpi_base_address;
+};
+
+#define ACPI_MADT_IRS_NON_COHERENT      (1)
+
+/* 29: Arm GICv5 ITS Config Frame (ACPI 6.7) */
+struct acpi_madt_gicv5_translator {
+	struct acpi_subtable_header header;
+	u8 flags;
+	u8 reserved;		/* reserved - must be zero */
+	u32 translator_id;
+	u64 base_address;
+};
+
+#define ACPI_MADT_GICV5_ITS_NON_COHERENT      (1)
+
+/* 30: Arm GICv5 ITS Translate Frame (ACPI 6.7) */
+struct acpi_madt_gicv5_translate_frame {
+	struct acpi_subtable_header header;
+	u16 reserved;		/* reserved - must be zero */
+	u32 linked_translator_id;
+	u32 translate_frame_id;
+	u32 reserved2;
+	u64 base_address;
+};
+
 /* 80: OEM data */
 
 struct acpi_madt_oem_data {

-- 
2.50.1


