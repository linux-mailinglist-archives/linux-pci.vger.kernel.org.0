Return-Path: <linux-pci+bounces-39371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A48D7C0CBFA
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C13C4E6063
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35AB2E6100;
	Mon, 27 Oct 2025 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFKiBw30"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BCC26463A;
	Mon, 27 Oct 2025 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558605; cv=none; b=VKbOR8RV4NHEK1JjMy2+XHWLHatptutQ24WIFyXboLR4NstrM4PFr+TBAPuX+Lbbfvt5tVD7Lw4TxSkhIXtu9tuYNwyE7TtYcmHpoEQ0O3Y4up9kuQcVCuQXAvLZ6Vhjm6YeVbqTnFR8HCMcubQAqUTcL7rlQztuIDlXY+u1x5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558605; c=relaxed/simple;
	bh=pC+eGt5qR3M3nYfPyNbPQUDtDiJDp1JmXs8kzQjP70M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2RabYH6nlUIznb1xC1mZpviM/CdAzWn4ieboQm1cX6swWgtUs9+U3YLcQcDzzwHNOdhjxnFBFUIpLIwbGe3IjXTUZpJN6Q7PKGnM7+tVXQFYnlunukBkkXafRTLnHZdM/WkB3l0nM1bvlO675iFNguiYBt06jMYTdySprf4piU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFKiBw30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA9DC4CEF1;
	Mon, 27 Oct 2025 09:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761558605;
	bh=pC+eGt5qR3M3nYfPyNbPQUDtDiJDp1JmXs8kzQjP70M=;
	h=From:To:Cc:Subject:Date:From;
	b=aFKiBw30yZAtpxPySbZuiysW1bdv54aEjmulI9JcVbBHTvBcqNnWedtKG4+QLBNHl
	 /MwOb0JJ1QDaAGnCZZVoWvsefP0EoYKr3T3ziqgvZs8vhFL3ulxXDbdsr5ZDWDKAkB
	 XJZUj0sd5SRavf0/7Ufhvx1Nd9rkFE31Inc+lNNrDgA9hCuuOw2gh0yQt7Sihy3rQX
	 iMpflYSJ4oW7YmVVswCuv6tY+Kod8+PtQWaNz58T/OVCIX28J8EHALF0YEcAbehNFG
	 vqXNvpsbbNX0Yj0X5n67Mto9jFaYaHcsFryxRVJKW/EUYNet5IuOD2R9aXbdNF9/6G
	 rkQRveScw4HDw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH 01/12] KVM: arm64: RMI: Export kvm_has_da_feature
Date: Mon, 27 Oct 2025 15:18:52 +0530
Message-ID: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used in later patches

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/kvm_rmi.h | 1 +
 arch/arm64/include/asm/rmi_smc.h | 1 +
 arch/arm64/kvm/rmi.c             | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_rmi.h b/arch/arm64/include/asm/kvm_rmi.h
index 1b2cdaac6c50..a967061af6ed 100644
--- a/arch/arm64/include/asm/kvm_rmi.h
+++ b/arch/arm64/include/asm/kvm_rmi.h
@@ -90,6 +90,7 @@ u32 kvm_realm_ipa_limit(void);
 u32 kvm_realm_vgic_nr_lr(void);
 u8 kvm_realm_max_pmu_counters(void);
 unsigned int kvm_realm_sve_max_vl(void);
+bool kvm_has_da_feature(void);
 
 u64 kvm_realm_reset_id_aa64dfr0_el1(const struct kvm_vcpu *vcpu, u64 val);
 
diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index 1000368f1bca..2ea657a87402 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -87,6 +87,7 @@ enum rmi_ripas {
 #define RMI_FEATURE_REGISTER_0_GICV3_NUM_LRS	GENMASK(37, 34)
 #define RMI_FEATURE_REGISTER_0_MAX_RECS_ORDER	GENMASK(41, 38)
 #define RMI_FEATURE_REGISTER_0_Reserved		GENMASK(63, 42)
+#define RMI_FEATURE_REGISTER_0_DA		BIT(42)
 
 #define RMI_REALM_PARAM_FLAG_LPA2		BIT(0)
 #define RMI_REALM_PARAM_FLAG_SVE		BIT(1)
diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
index 478a73e0b35a..08f3d2362dfd 100644
--- a/arch/arm64/kvm/rmi.c
+++ b/arch/arm64/kvm/rmi.c
@@ -1738,6 +1738,12 @@ int kvm_init_realm_vm(struct kvm *kvm)
 	return 0;
 }
 
+bool kvm_has_da_feature(void)
+{
+	return rmi_has_feature(RMI_FEATURE_REGISTER_0_DA);
+}
+EXPORT_SYMBOL_GPL(kvm_has_da_feature);
+
 void kvm_init_rmi(void)
 {
 	/* Only 4k page size on the host is supported */
-- 
2.43.0


