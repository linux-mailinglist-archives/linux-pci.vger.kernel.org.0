Return-Path: <linux-pci+bounces-33060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C8CB13C5E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9138518903F0
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271AC273D77;
	Mon, 28 Jul 2025 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TznB8qC9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF307270EA9;
	Mon, 28 Jul 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710924; cv=none; b=uUQKF/zi4B1yYnO8yT6Wwerk7cqJ5f5PUicNTZDr6wiV0CQIXZOenq834xiQIKStmAvI5BixRNwJ1fgT59K+aJXN9OmYIXRAsL79Zx6JH2GP+LwFpqTjTUMSf2zeWSSuo8cSXWUB59ikvsTU3ewfdVa0NooV7C5BAHwVw7H4Vqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710924; c=relaxed/simple;
	bh=uAR/fHNQy0wfaJGiSb9ysOvjo+hmJLlA8JN4JOUsFiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6q0fYKtJ9CZdW3S0lY7IV6lnzx1jcSuh6J+bUpJXMrgrrdco9w+uAzJc0I3n8kdt3MCM/E9PzrBLLO2AsdGcU/O75VLycni2FGRf5ngXZZjRMqoNLkPhXgvQ5K/oDqU653MDxx2kaem6obaM3ognFjFfWHetRXso4zs2UZ9qlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TznB8qC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D28C4CEF8;
	Mon, 28 Jul 2025 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710923;
	bh=uAR/fHNQy0wfaJGiSb9ysOvjo+hmJLlA8JN4JOUsFiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TznB8qC94CBNClsONzdJpQ1lDat0p5hFbSDwJGQzr5qpetO2lbP52rtuoIU1ZotUG
	 ET62gdXUgRNIHIeTYJ2+PfyRUk2+R5mgCfURTXGPFS9m493pwWz3sP1qsrCqJClhzz
	 1cJVUs0ORHpTl3rRY8AvAxYYzAAo9+olRQkUF70TieUNJrQTPUuFT7AEPIouKAOb4V
	 czXlK43d1LhGmAcrl8r+16WbLYnvm3pBVIgQ7koUtCw4X6PC71qpNANSWFB2alnr26
	 ZkRSHEwfCBPkcf9L1iYmOT2WkiihBKAz05iOxBpQiCk/fKdjzs4/OKPsRfviVZVytr
	 dGbobRT5MaEDg==
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
Subject: [RFC PATCH v1 28/38] coco: host: arm64: Add support for device communication exit handler
Date: Mon, 28 Jul 2025 19:22:05 +0530
Message-ID: <20250728135216.48084-29-aneesh.kumar@kernel.org>
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

Different RSI calls that require device communication result in a REC
exit, which is handled by the device communication exit handler.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_smc.h         |  6 ++
 drivers/virt/coco/arm-cca-host/arm-cca.c |  1 +
 drivers/virt/coco/arm-cca-host/rmm-da.c  | 75 ++++++++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmm-da.h  |  4 ++
 4 files changed, 86 insertions(+)

diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index 6b23afa070d1..7073eccaec5f 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -457,4 +457,10 @@ struct rmi_vdev_params {
 	};
 };
 
+#define RMI_VDEV_ACTION_GET_INTERFACE_REPORT	0x0
+#define RMI_VDEV_ACTION_GET_MEASUREMENTS	0x1
+#define RMI_VDEV_ACTION_LOCK			0x2
+#define RMI_VDEV_ACTION_START			0x3
+#define RMI_VDEV_ACTION_STOP			0x4
+
 #endif /* __ASM_RMI_SMC_H */
diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
index 837bd10ccd47..be1296fb1bf2 100644
--- a/drivers/virt/coco/arm-cca-host/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -243,6 +243,7 @@ static struct pci_tdi *cca_tsm_bind(struct pci_dev *pdev, struct pci_dev *pf0_de
 	rmm_vdev = rme_create_vdev(realm, pdev, pf0_dev, tdi_id);
 	if (!IS_ERR_OR_NULL(rmm_vdev)) {
 		host_tdi->rmm_vdev = rmm_vdev;
+		host_tdi->vdev_id = tdi_id;
 		return &no_free_ptr(host_tdi)->tdi;
 	}
 
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
index d4f1da590b90..bef33e618fd3 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.c
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
@@ -233,6 +233,16 @@ static int __do_dev_communicate(int type, struct pci_tsm *tsm)
 			cache_offset = &dsc_pf0->cert_chain.cache.size;
 			cache_remaining = sizeof(dsc_pf0->cert_chain.cache.buf) - *cache_offset;
 			break;
+		case RMI_DEV_INTERFACE_REPORT:
+			cache_buf = dsc_pf0->interface_report.buf;
+			cache_offset = &dsc_pf0->interface_report.size;
+			cache_remaining = sizeof(dsc_pf0->interface_report.buf) - *cache_offset;
+			break;
+		case RMI_DEV_MEASUREMENTS:
+			cache_buf = dsc_pf0->measurements.buf;
+			cache_offset = &dsc_pf0->measurements.size;
+			cache_remaining = sizeof(dsc_pf0->measurements.buf) - *cache_offset;
+			break;
 		default:
 			/* FIXME!! depending on the DevComms status,
 			 * it might require to ABORT the communcation.
@@ -661,6 +671,21 @@ void rme_unbind_vdev(struct realm *realm, struct pci_dev *pdev, struct pci_dev *
 	}
 }
 
+static struct pci_tsm *find_pci_tsm_from_vdev(phys_addr_t vdev_phys)
+{
+	struct pci_dev *pdev = NULL;
+	struct cca_host_tdi *host_tdi;
+
+	for_each_pci_dev(pdev) {
+		host_tdi = to_cca_host_tdi(pdev);
+		if (!host_tdi)
+			continue;
+		if (virt_to_phys(host_tdi->rmm_vdev) == vdev_phys)
+			return pdev->tsm;
+	}
+	return NULL;
+}
+
 static struct pci_tsm *find_pci_tsm_from_vdev_id(unsigned long vdev_id)
 {
 	struct pci_dev *pdev = NULL;
@@ -676,6 +701,55 @@ static struct pci_tsm *find_pci_tsm_from_vdev_id(unsigned long vdev_id)
 	return NULL;
 }
 
+static int rme_exit_vdev_comm_handler(struct realm_rec *rec)
+{
+	int ret;
+	unsigned long state;
+	struct cca_host_tdi *host_tdi;
+	struct cca_host_comm_data *comm_data;
+	phys_addr_t vdev_phys = rec->run->exit.vdev;
+	struct pci_tsm *tsm = find_pci_tsm_from_vdev(vdev_phys);
+
+	if (!tsm)
+		goto err_out;
+
+	host_tdi = to_cca_host_tdi(tsm->pdev);
+	if (!host_tdi)
+		goto err_out;
+
+	comm_data = to_cca_comm_data(tsm->pdev);
+	if (!comm_data->vdev_comm_active) {
+		struct rmi_dev_comm_enter *io_enter;
+
+		io_enter = &comm_data->io_params->enter;
+		io_enter->resp_len = 0;
+		io_enter->status = RMI_DEV_COMM_NONE;
+		comm_data->vdev_comm_active = true;
+	}
+
+	/* FIXME!! Should this be a work? */
+	ret = __do_dev_communicate(VDEV_COMMUNICATE, tsm);
+	if (ret)
+		goto err_out;
+
+	ret = rmi_vdev_get_state(virt_to_phys(host_tdi->rmm_vdev), &state);
+	if (ret)
+		goto err_out;
+	/*
+	 * If vdev is done communicating, the next update should
+	 * reinitialize the cache
+	 */
+	if (state != RMI_VDEV_COMMUNICATING)
+		comm_data->vdev_comm_active = false;
+
+err_out:
+	/*
+	 * Return back to the guest without calling DEV communicate.
+	 * The Realm will treat that as an error.
+	 */
+	return 1;
+}
+
 static int rme_exit_vdev_req_handler(struct realm_rec *rec)
 {
 	struct cca_host_tdi *host_tdi = NULL;
@@ -697,5 +771,6 @@ static int rme_exit_vdev_req_handler(struct realm_rec *rec)
 
 void rme_register_exit_handlers(void)
 {
+	realm_exit_vdev_comm_handler = rme_exit_vdev_comm_handler;
 	realm_exit_vdev_req_handler = rme_exit_vdev_req_handler;
 }
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.h b/drivers/virt/coco/arm-cca-host/rmm-da.h
index 7f51b611467b..cebddab8464d 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.h
@@ -22,6 +22,8 @@ struct cca_host_comm_data {
 	void *resp_buff;
 	void *req_buff;
 	struct rmi_dev_comm_data *io_params;
+
+	bool vdev_comm_active;
 };
 
 struct cca_host_dsc_pf0 {
@@ -43,6 +45,8 @@ struct cca_host_dsc_pf0 {
 		bool valid;
 	} cert_chain;
 	struct cache_object vca;
+	struct cache_object interface_report;
+	struct cache_object measurements;
 };
 
 struct cca_host_tdi {
-- 
2.43.0


