Return-Path: <linux-pci+bounces-39384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DD0C0CC69
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A5419A122B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6E12FCBF3;
	Mon, 27 Oct 2025 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRCT1A4w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50F2FBE01;
	Mon, 27 Oct 2025 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558680; cv=none; b=L5DYapvdYq18dxL0Cx1Le8zgXWZkjxnn5WBsl0x8AhNtf4/aSqyOmfWenfdju2TfTHTUhhS+jF649j2xcUr35rEqXkKUYXIvMOu/a8juQIYZ/f5RjMi7GtJaqa0IrXxjP5YhD/waPrOnw3X2e+q2Eb/yTc0GAhUEGVQczIbbaR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558680; c=relaxed/simple;
	bh=pC+eGt5qR3M3nYfPyNbPQUDtDiJDp1JmXs8kzQjP70M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USjiD+7n6SML1Oo0vrXBLtvD/d/wf9aAf36PW+g2wBacq/b97NcOet3C876LvJZnG1bjXWfqv0n0JVA7iAGi6Issik3mcqRFeGHMfImoqboZubbnZs8NHetHQkAFaqRhMhourNtmu6EqT1CflUkwdtpTllsGb7oxpfgOII4SzK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRCT1A4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A134C116D0;
	Mon, 27 Oct 2025 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761558680;
	bh=pC+eGt5qR3M3nYfPyNbPQUDtDiJDp1JmXs8kzQjP70M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nRCT1A4wo+j6nSmeTchw/Y788Hca5kiuL058I7plCkadGnyb4GOJeXA9STNePgU3H
	 IK4dPBfrz6T6OVgxqqCzyn8F6Dh5f7J7cY9HKMxetQHYnpjxdQBB5DKrLn4woZ8LdZ
	 jwXHXSNztB2T+2U80kZx9jlt/LgNa0AvYCrLwQldV/pd6XwuoJUdr3TqXlJ0xwMegC
	 HD8PrO/bKmr0VbQoJ6h5sf4CIAWndlCrQZxun4OlTUwyIiwC2LsJ14V8YcFSzLsNPK
	 kxOKXeWQ1gKP3BMXsYm4Iv7GZaLs0RO+CR+vZpVv3PIEzhI3bcXr/KE7yeS3wxKpVD
	 YI17FsxyVgwUg==
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
Subject: [PATCH v2 01/12] KVM: arm64: RMI: Export kvm_has_da_feature
Date: Mon, 27 Oct 2025 15:19:05 +0530
Message-ID: <20251027094916.1153143-14-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
References: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
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


