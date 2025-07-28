Return-Path: <linux-pci+bounces-33043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5888B13C36
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 15:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC601C2021E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E22626CE2F;
	Mon, 28 Jul 2025 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F13jPxay"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B626CE1C;
	Mon, 28 Jul 2025 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710824; cv=none; b=P8OeezRjkrr3wzeJ9a++Nqx4zGKQJtl+NwRgGa29VsNQt5fMIASQkzQfm9Vo4NABvcIZLWVqgY9547qbORt3qGzVAr6bBVXUNsAQiic829d/UrSe7MLKtb9iaJ77QrqvfXsXD2jSHkqGS7HeBi1h4wosXZ7VWylIkdXpQJWhRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710824; c=relaxed/simple;
	bh=b8DNZd0OWQO+/qyBhIEURTzrRcRTx4S5avd9jivd7EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOGmPR1caHcHzarFzAEYpH3g9Nf4o5WiKtNG8EvA56Mwcieon4hUksDnQvH8jfTJpaLBN8OqRhdB1xJQgzqzYVtVsx7EgAd04X1/Od8ERwAEONEjlCy9frAtNdTcblQHXoUr+Eg1XUmb/ZfKWt4LEaUs0lWs/0ekvNBPLXhmtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F13jPxay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3101FC4CEE7;
	Mon, 28 Jul 2025 13:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710822;
	bh=b8DNZd0OWQO+/qyBhIEURTzrRcRTx4S5avd9jivd7EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F13jPxayOoMzgp7VKZEdViJybGfxuLkSHJUCPgTuWQJ0i+CLH33v+qmwcZJUi8lNT
	 Q1RtRnDhuxiqteYRDQAmCJE9bhpkyhDmetlhujeaP4VHVfS5/3+seo0w99SRxy32Ql
	 O/38UqmGE7syHkqUW2JLox1WdLGknXnhzFsPL80PGhfbpp7PpGAOQrqiZ4u2ZkKl8N
	 QeZ4BzZkzNYEnvdyI+IhhfX1+Xa7qG7LFYLUN0zsxIebsekBqwXUfAc2NUrSRI2tHp
	 w7zxhSFR0mF+5N7HwdyU4ZpuerB0kLeUg0xgQb10HKxqN8hwwABigryOPDnQ5AyZQ1
	 LXqmvqfoDoeAw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform device
Date: Mon, 28 Jul 2025 19:21:48 +0530
Message-ID: <20250728135216.48084-12-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728135216.48084-1-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register a platform device if the CCA DA feature is supported.
A driver for this platform device will further drive the CCA DA workflow.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_smc.h |  3 +++
 arch/arm64/kvm/rme.c             | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index 504009a42035..42708d500048 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -12,6 +12,8 @@
 
 #include <linux/arm-smccc.h>
 
+#define RMI_DEV_NAME "arm-rmi-dev"
+
 #define SMC_RMI_CALL(func)				\
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
 			   ARM_SMCCC_SMC_64,		\
@@ -87,6 +89,7 @@ enum rmi_ripas {
 #define RMI_FEATURE_REGISTER_0_GICV3_NUM_LRS	GENMASK(37, 34)
 #define RMI_FEATURE_REGISTER_0_MAX_RECS_ORDER	GENMASK(41, 38)
 #define RMI_FEATURE_REGISTER_0_Reserved		GENMASK(63, 42)
+#define RMI_FEATURE_REGISTER_0_DA		BIT(42)
 
 #define RMI_REALM_PARAM_FLAG_LPA2		BIT(0)
 #define RMI_REALM_PARAM_FLAG_SVE		BIT(1)
diff --git a/arch/arm64/kvm/rme.c b/arch/arm64/kvm/rme.c
index ec8093ec2da3..d1c147aba2ed 100644
--- a/arch/arm64/kvm/rme.c
+++ b/arch/arm64/kvm/rme.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/kvm_host.h>
+#include <linux/platform_device.h>
 
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
@@ -1724,6 +1725,18 @@ int kvm_init_realm_vm(struct kvm *kvm)
 	return 0;
 }
 
+static struct platform_device cca_host_dev = {
+	.name = RMI_DEV_NAME,
+	.id = PLATFORM_DEVID_NONE
+};
+
+static void rmm_tsm_init(void)
+{
+	if (!platform_device_register(&cca_host_dev))
+		pr_info("CCA host DA platform device initialized.\n");
+
+}
+
 void kvm_init_rme(void)
 {
 	if (PAGE_SIZE != SZ_4K)
@@ -1737,6 +1750,9 @@ void kvm_init_rme(void)
 	if (WARN_ON(rmi_features(0, &rmm_feat_reg0)))
 		return;
 
+	if (rme_has_feature(RMI_FEATURE_REGISTER_0_DA))
+		rmm_tsm_init();
+
 	if (rme_vmid_init())
 		return;
 
-- 
2.43.0


