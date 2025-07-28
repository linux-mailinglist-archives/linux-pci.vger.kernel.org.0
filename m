Return-Path: <linux-pci+bounces-33058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BA1B13C5C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DD2188BD9A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691012798FF;
	Mon, 28 Jul 2025 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Og5KxAEy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B0273816;
	Mon, 28 Jul 2025 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710912; cv=none; b=tmmVVknH7WLPE32ILgh2XvTAKLnBdjh0NJa84C0mksrAeXZGpplyy4bTHHpf1MEpV0GtrRd9Ztg7jxOK2ffmXODT8KolM/G1Vk8tgxP9a6KeiolB7vkGRe6QybDh8z8nKo64fhBLIziyqeFIbe50hB31fAAlbWbeIxoVwfRnA2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710912; c=relaxed/simple;
	bh=5O1aCSLxWRGk90AUlS+nM3HRgGXDX51MN4Gn1sHyQ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4cI9MS0FhedkqKQ6K/7fDSPtp/pxGVr09SAvDTw8HX+S0NQsdKGjkZpe3/Ju9EgraZDLG7UfSyHBWMtJu7qX0O6QG/vqUkPY2whB5ywLWTsJVCvA1ubqmWgGaJLWPJqL61vLWFw0f3rX30paYdabBTFy7pxowsoeuGgrmv4AGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Og5KxAEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCABC4AF09;
	Mon, 28 Jul 2025 13:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710912;
	bh=5O1aCSLxWRGk90AUlS+nM3HRgGXDX51MN4Gn1sHyQ5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Og5KxAEyG6Ivs3PPLTPzjDDVh37ivsLjGc9h4+lzF/jmEjAr2hBhNdKcF56rDFUzS
	 i+2Yw8tED3/6DGxOSWSgIyW8RVGd2Q4xRSZ0gMwdHCUiIg0lknwpuNemBSL/ePRdEB
	 4VbZokzy406QwTtF1XU2JzFGmNrzUKcBfzuJJxUEVALRaOlVDeDLcUPkws5tvKGmgD
	 +HCGZ1vcl3ekreIXUoAfE9rj89LkpFE/G2B1SZK11CN+vJnhTlvGAkp0mxxwPpJJPs
	 DjYBPlIrXHB7b5i0SAercLJDjVRi+ngXbDNgpnGDRFG6Tbt1F6L7TM8solfSw/aUYE
	 q4lxZn0uTunxA==
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
Subject: [RFC PATCH v1 26/38] KVM: arm64: Add exit handler related to device assignment
Date: Mon, 28 Jul 2025 19:22:03 +0530
Message-ID: <20250728135216.48084-27-aneesh.kumar@kernel.org>
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

Different RSI calls related to DA result in REC exits. Add a facility to
register handlers for handling these REC exits.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/kvm_rme.h |  3 ++
 arch/arm64/include/asm/rmi_smc.h | 14 +++++++-
 arch/arm64/kvm/rme-exit.c        | 60 ++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_rme.h b/arch/arm64/include/asm/kvm_rme.h
index e954bb95dc86..370d056222e8 100644
--- a/arch/arm64/include/asm/kvm_rme.h
+++ b/arch/arm64/include/asm/kvm_rme.h
@@ -136,4 +136,7 @@ static inline bool kvm_realm_is_private_address(struct realm *realm,
 	return !(addr & BIT(realm->ia_bits - 1));
 }
 
+extern int (*realm_exit_vdev_req_handler)(struct realm_rec *rec);
+extern int (*realm_exit_vdev_comm_handler)(struct realm_rec *rec);
+extern int (*realm_exit_dev_mem_map_handler)(struct realm_rec *rec);
 #endif /* __ASM_KVM_RME_H */
diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index c6e16ab608e1..a5ef68b62bc0 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -219,6 +219,9 @@ struct rec_enter {
 #define RMI_EXIT_RIPAS_CHANGE		0x04
 #define RMI_EXIT_HOST_CALL		0x05
 #define RMI_EXIT_SERROR			0x06
+#define RMI_EXIT_VDEV_REQUEST		0x08
+#define RMI_EXIT_VDEV_COMM		0x09
+#define RMI_EXIT_DEV_MEM_MAP		0x0a
 
 struct rec_exit {
 	union { /* 0x000 */
@@ -264,7 +267,16 @@ struct rec_exit {
 		u8 padding5[0x100];
 	};
 	union { /* 0x600 */
-		u16 imm;
+		struct {
+			u16 imm;
+			u8 padding[6];
+			u64 plane;
+			u64 vdev;
+			u64 vdev_action;
+			u64 dev_mem_base;
+			u64 dev_mem_top;
+			u64 dev_mem_pa;
+		};
 		u8 padding6[0x100];
 	};
 	union { /* 0x700 */
diff --git a/arch/arm64/kvm/rme-exit.c b/arch/arm64/kvm/rme-exit.c
index 1a8ca7526863..25948207fc5b 100644
--- a/arch/arm64/kvm/rme-exit.c
+++ b/arch/arm64/kvm/rme-exit.c
@@ -129,6 +129,60 @@ static int rec_exit_host_call(struct kvm_vcpu *vcpu)
 	return kvm_smccc_call_handler(vcpu);
 }
 
+int (*realm_exit_vdev_req_handler)(struct realm_rec *rec);
+EXPORT_SYMBOL_GPL(realm_exit_vdev_req_handler);
+static int rec_exit_vdev_request(struct kvm_vcpu *vcpu)
+{
+	int ret;
+	struct realm_rec *rec = &vcpu->arch.rec;
+
+	if (realm_exit_vdev_req_handler) {
+		ret = (*realm_exit_vdev_req_handler)(rec);
+	} else {
+		kvm_pr_unimpl("Unsupported exit reason: %u\n",
+			      rec->run->exit.exit_reason);
+		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		ret = 0;
+	}
+	return ret;
+}
+
+int (*realm_exit_vdev_comm_handler)(struct realm_rec *rec);
+EXPORT_SYMBOL_GPL(realm_exit_vdev_comm_handler);
+static int rec_exit_vdev_communication(struct kvm_vcpu *vcpu)
+{
+	int ret;
+	struct realm_rec *rec = &vcpu->arch.rec;
+
+	if (realm_exit_vdev_comm_handler) {
+		ret = (*realm_exit_vdev_comm_handler)(rec);
+	} else {
+		kvm_pr_unimpl("Unsupported exit reason: %u\n",
+			      rec->run->exit.exit_reason);
+		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		ret = 0;
+	}
+	return ret;
+}
+
+int (*realm_exit_dev_mem_map_handler)(struct realm_rec *rec);
+EXPORT_SYMBOL_GPL(realm_exit_dev_mem_map_handler);
+static int rec_exit_dev_mem_map(struct kvm_vcpu *vcpu)
+{
+	int ret;
+	struct realm_rec *rec = &vcpu->arch.rec;
+
+	if (realm_exit_dev_mem_map_handler) {
+		ret = (*realm_exit_dev_mem_map_handler)(rec);
+	} else {
+		kvm_pr_unimpl("Unsupported exit reason: %u\n",
+			      rec->run->exit.exit_reason);
+		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		ret = 0;
+	}
+	return ret;
+}
+
 static void update_arch_timer_irq_lines(struct kvm_vcpu *vcpu)
 {
 	struct realm_rec *rec = &vcpu->arch.rec;
@@ -198,6 +252,12 @@ int handle_rec_exit(struct kvm_vcpu *vcpu, int rec_run_ret)
 		return rec_exit_ripas_change(vcpu);
 	case RMI_EXIT_HOST_CALL:
 		return rec_exit_host_call(vcpu);
+	case RMI_EXIT_VDEV_REQUEST:
+		return rec_exit_vdev_request(vcpu);
+	case RMI_EXIT_VDEV_COMM:
+		return rec_exit_vdev_communication(vcpu);
+	case RMI_EXIT_DEV_MEM_MAP:
+		return rec_exit_dev_mem_map(vcpu);
 	}
 
 	kvm_pr_unimpl("Unsupported exit reason: %u\n",
-- 
2.43.0


