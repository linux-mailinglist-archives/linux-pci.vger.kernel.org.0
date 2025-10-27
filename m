Return-Path: <linux-pci+bounces-39395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB1EC0CD53
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 11:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFD764F75AD
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D212FB99E;
	Mon, 27 Oct 2025 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAYt0soL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B892FB967;
	Mon, 27 Oct 2025 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559028; cv=none; b=Pl8e5aKmrnc2zW8V0QNo1ebIw7Eicea6NfEy/at/9RovDxMkiZkTXqB7TC4oNgRncdGzwwtTMTQ2Aiwh67EGS12pm3R9/fGAi1bdQ4U6PP5gMGwQPkhDizgzFpACvfLidGJHNqnzQrJasrD0udgJzRYqmssBVy8AtQXbySONHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559028; c=relaxed/simple;
	bh=B7+ugvWyCLD3rludeB5A8gujO3Mf6Ml2lNniTy9+Wsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j16MABK0qgeNUnBEw83GIcdeJRI2L5bO2vZyvawMhp6/b0xIBfHDIttQpt3XNLDmiVJ8vyex4d6Mx6L5PCbMdExVbkCk6vkFAU7nZA/8DqGun4bqKRP/dX7sxhRTDcpbdTAzjOmC51gnIlOTIZb0VYAfqysqDHUX+eWtfhgNbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAYt0soL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDE2C4CEF1;
	Mon, 27 Oct 2025 09:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761559027;
	bh=B7+ugvWyCLD3rludeB5A8gujO3Mf6Ml2lNniTy9+Wsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAYt0soLSpVtRM2lX3hz4geVUjRoS1cF4K/bdu9SaNR/p4/juwLCKgXq0Tr5LmdfZ
	 XSww+3UfDf08kLx6JNiLdLTOwwpO7QRkKXsC1rTz6p1VVz3ijz5vskxYh6IRSbF5sL
	 oBv8I1oA+InDwwe3TtUXEe2tvEXMFOjdSy9M6JGgQJ202k56Cgjo50+cvZ12vOuznm
	 oSacrlGND1g7BYFKJ/xVjJ5O7b8Aus+XC817Wizb3oVP2PV06aXhiLGDkSHzmnfK12
	 m4/f4u3wx5J+yl0zfhU/BMdlSG6+urtT650heoPMkCAeFdcvhfvVq9DtHm91uMzxpy
	 XLFImIQc6QuVg==
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
Subject: [PATCH RESEND v2 07/12] coco: host: arm64: Add helper to stop and tear down an RMM pdev
Date: Mon, 27 Oct 2025 15:25:57 +0530
Message-ID: <20251027095602.1154418-8-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- describe the RMI_PDEV_STOP/RMI_PDEV_DESTROY SMC IDs and provide
  wrappers in rmi_cmds.h
- implement pdev_stop_and_destroy() so the host driver stops the pdev,
  waits for it to reach RMI_PDEV_STOPPED, destroys it, frees auxiliary
  granules, and drops the delegated page

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_cmds.h       | 18 +++++++++++++++
 arch/arm64/include/asm/rmi_smc.h        |  2 ++
 drivers/virt/coco/arm-cca-host/rmi-da.c | 30 +++++++++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmi-da.h |  1 +
 4 files changed, 51 insertions(+)

diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
index b86bf15afcda..f10a0dcaa308 100644
--- a/arch/arm64/include/asm/rmi_cmds.h
+++ b/arch/arm64/include/asm/rmi_cmds.h
@@ -556,4 +556,22 @@ static inline unsigned long rmi_pdev_abort(unsigned long pdev_phys)
 	return res.a0;
 }
 
+static inline unsigned long rmi_pdev_stop(unsigned long pdev_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_PDEV_STOP, pdev_phys, &res);
+
+	return res.a0;
+}
+
+static inline unsigned long rmi_pdev_destroy(unsigned long pdev_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_PDEV_DESTROY, pdev_phys, &res);
+
+	return res.a0;
+}
+
 #endif /* __ASM_RMI_CMDS_H */
diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index 53e46e24c921..6eb6f7e4b77f 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -50,7 +50,9 @@
 #define SMC_RMI_PDEV_ABORT		SMC_RMI_CALL(0x0174)
 #define SMC_RMI_PDEV_COMMUNICATE        SMC_RMI_CALL(0x0175)
 #define SMC_RMI_PDEV_CREATE             SMC_RMI_CALL(0x0176)
+#define SMC_RMI_PDEV_DESTROY		SMC_RMI_CALL(0x0177)
 #define SMC_RMI_PDEV_GET_STATE		SMC_RMI_CALL(0x0178)
+#define SMC_RMI_PDEV_STOP		SMC_RMI_CALL(0x017c)
 
 #define RMI_ABI_MAJOR_VERSION	1
 #define RMI_ABI_MINOR_VERSION	0
diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.c b/drivers/virt/coco/arm-cca-host/rmi-da.c
index 592abe0dd252..644609618a7a 100644
--- a/drivers/virt/coco/arm-cca-host/rmi-da.c
+++ b/drivers/virt/coco/arm-cca-host/rmi-da.c
@@ -412,3 +412,33 @@ int pdev_ide_setup(struct pci_dev *pdev)
 {
 	return submit_pdev_comm_work(pdev, RMI_PDEV_NEEDS_KEY);
 }
+
+void pdev_stop_and_destroy(struct pci_dev *pdev)
+{
+	unsigned long ret;
+	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(pdev);
+	phys_addr_t rmm_pdev_phys = virt_to_phys(pf0_dsc->rmm_pdev);
+
+	ret = rmi_pdev_stop(rmm_pdev_phys);
+	if (WARN_ON(ret != RMI_SUCCESS))
+		return;
+
+	submit_pdev_comm_work(pdev, RMI_PDEV_STOPPED);
+
+	ret = rmi_pdev_destroy(rmm_pdev_phys);
+	if (WARN_ON(ret != RMI_SUCCESS))
+		return;
+
+	kfree(pf0_dsc->cert_chain.public_key);
+	kvfree(pf0_dsc->cert_chain.cache);
+	kvfree(pf0_dsc->vca);
+	pf0_dsc->cert_chain.cache = NULL;
+	pf0_dsc->vca = NULL;
+
+	/* Free the aux granules */
+	free_aux_pages(pf0_dsc->num_aux, pf0_dsc->aux);
+	pf0_dsc->num_aux = 0;
+	if (!rmi_granule_undelegate(rmm_pdev_phys))
+		free_page((unsigned long)pf0_dsc->rmm_pdev);
+	pf0_dsc->rmm_pdev = NULL;
+}
diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.h b/drivers/virt/coco/arm-cca-host/rmi-da.h
index 1d513e0b74d9..e556ccecc1cb 100644
--- a/drivers/virt/coco/arm-cca-host/rmi-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmi-da.h
@@ -104,6 +104,7 @@ static inline struct cca_host_comm_data *to_cca_comm_data(struct pci_dev *pdev)
 }
 
 int pdev_create(struct pci_dev *pdev);
+void pdev_stop_and_destroy(struct pci_dev *pdev);
 void pdev_communicate_work(struct work_struct *work);
 int pdev_ide_setup(struct pci_dev *pdev);
 #endif
-- 
2.43.0


