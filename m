Return-Path: <linux-pci+bounces-33068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68533B13C74
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C931C213B4
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC626F477;
	Mon, 28 Jul 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQgYFKli"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA126AAB5;
	Mon, 28 Jul 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710971; cv=none; b=jiiH3AMFeSv11aoXsynjzedOM6p7VTuPkJ62m6aZqOw8gdoAErulVWUcx5qrYOF11r0xkvwxnoM1DYz9K0q3FnkClcnqcTJFfY0H4EKXPYJgmnQXqsktoAwMmoqaFgXX9vPXh5C1TqIUQyEJWYr5iViPT0vc1OACqmvSehTIt1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710971; c=relaxed/simple;
	bh=3efNmr/84SDYWqmCQPInd8xkYI9ZwW9+f+F31pYvQt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9EoNm4U9AipN8bIAI/iDJekYh52b70lR6Vot0DSfKLVHmi+M15Zn8ImT4dBR7TogKDs9/jxBi0mtlJJ+XKozcqw+xY9F1W5ZIJSSp8XrpP1MWqeP1IQthTHMALG5Ua32A84PdCN0/gmk93BhuXtG6oHU87BW7gel+NjF/dbyMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQgYFKli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDD2C4CEFB;
	Mon, 28 Jul 2025 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710971;
	bh=3efNmr/84SDYWqmCQPInd8xkYI9ZwW9+f+F31pYvQt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQgYFKli6Mf5uciiy2WxU3Z0aQV89Bp9MmO5GboTspMWIhhfRAcy/xIgOxSNFGF5H
	 rpqV+31CtKLAQkYJRfCi/HR3srwp0vP0RO6AtWC2fgRlFIb5O38VjeK8fVt+REpYoQ
	 sWICTfhoH2nkVSjQuqwqdlZnOU0aCpG6mdrQF/jq1wCgJa9vcQShkaDYZbLUNR017C
	 ln8nvT1vXc7qD6ufNBqQwO26ISDZW0dfq7V2KYQRkwWZJPIFIvcm0eg28w4WkDe/XZ
	 9hMmqza/bHCJg7lvX27ynB+itblE7mOXeUyJj8rYlZJeHpYVUh5dKDZLH84Q6irT0J
	 HV1K26oyGsuDg==
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
Subject: [RFC PATCH v1 36/38] KVM: arm64: CCA: enable DA in realm create parameters
Date: Mon, 28 Jul 2025 19:22:13 +0530
Message-ID: <20250728135216.48084-37-aneesh.kumar@kernel.org>
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

Now that we have all the required steps for DA in-place, enable
DA while creating ralm.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_smc.h | 1 +
 arch/arm64/kvm/rme.c             | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index ab169b375198..f664954a2a91 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -112,6 +112,7 @@ enum rmi_ripas {
 #define RMI_REALM_PARAM_FLAG_LPA2		BIT(0)
 #define RMI_REALM_PARAM_FLAG_SVE		BIT(1)
 #define RMI_REALM_PARAM_FLAG_PMU		BIT(2)
+#define RMI_REALM_PARAM_FLAG_DA			BIT(3)
 
 /*
  * Note many of these fields are smaller than u64 but all fields have u64
diff --git a/arch/arm64/kvm/rme.c b/arch/arm64/kvm/rme.c
index 11c8d47e3e9b..394d1534e6c2 100644
--- a/arch/arm64/kvm/rme.c
+++ b/arch/arm64/kvm/rme.c
@@ -695,6 +695,8 @@ static int realm_create_rd(struct kvm *kvm)
 	if (r)
 		goto out_undelegate_tables;
 
+	/* For now default enable DA */
+	params->flags = RMI_REALM_PARAM_FLAG_DA;
 	params_phys = virt_to_phys(params);
 
 	if (rmi_realm_create(rd_phys, params_phys)) {
-- 
2.43.0


