Return-Path: <linux-pci+bounces-33046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8D7B13C41
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB21541A22
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26F72750E9;
	Mon, 28 Jul 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0sMdNLw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F726B2AE;
	Mon, 28 Jul 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710839; cv=none; b=R7AEeyWaDwzBP0RbUqgxEmuSNa/T+repDZS9yxh9hUUOmbHGU86MLZCdpwOYYYD5odeZBBCyO0OLEgaXZ7TMYek0+fcXIZ2Ptg3bslbEbwcKjXw5Kpa0b4g/0fryYOWNOYTx7kyKg53BayH/sYoP5rEyBS10ea7dBjhSg9ZFmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710839; c=relaxed/simple;
	bh=pTFLZSrecLAJYJK7PHzfqJWYpecELNS3T10QO0aiFFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t25hz2yWg9iHJRFDjkWJn19it22GX+mIakDZIEJkPFnI+EUbp585b1ZvxVCfVQbGEGqqMUQ6ftlQfP4oR6SeV7P3g1PRUsTVS+Ygwj78PdPQaS+fXwxpWVC0yxrhrDn1waqdKMPzM5tEAFlTaSaUoUlSAcyW4If9xTQTygHBc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0sMdNLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB702C4CEFF;
	Mon, 28 Jul 2025 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710839;
	bh=pTFLZSrecLAJYJK7PHzfqJWYpecELNS3T10QO0aiFFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0sMdNLwc39LiXKuz8mixWW/o667lasthM0O+hcVRpz0cV+wW3oQ5JY+vRi1+6c0+
	 zBHgENyjFxc1xmj5zfyrQPj/Vw2O8jCtgMYbsZjPx7Bm0LaYt3sUghpWVgMOyuLPz7
	 iYxrjDCnndpzcQYuevVpiU3/MsAJmd7K3R3+g+5gsRO77EAa5ysWJFmmuZ+d7bodNY
	 AKLCN9870hSoc9O3d/EGfgt35DDB1tNn+zsN8uh1zirJzD3hcLr8idRAWzb2KcSUiy
	 0vOddw3HxxpssTyylRBl3Jekqg4bF8nk90cV6djluyHnfPQCcGWb51pIOMDDDBdzts
	 eKSX9AQlNO5nQ==
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
Subject: [RFC PATCH v1 14/38] coco: host: arm64: Device communication support
Date: Mon, 28 Jul 2025 19:21:51 +0530
Message-ID: <20250728135216.48084-15-aneesh.kumar@kernel.org>
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

Add helpers for device communication from RMM

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_cmds.h        |  11 ++
 arch/arm64/include/asm/rmi_smc.h         |  49 ++++++
 drivers/virt/coco/arm-cca-host/arm-cca.c |  45 ++++++
 drivers/virt/coco/arm-cca-host/rmm-da.c  | 198 +++++++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmm-da.h  |  41 +++++
 5 files changed, 344 insertions(+)

diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
index f0817bd3bab4..eb0034a675bb 100644
--- a/arch/arm64/include/asm/rmi_cmds.h
+++ b/arch/arm64/include/asm/rmi_cmds.h
@@ -536,4 +536,15 @@ static inline unsigned long rmi_pdev_get_state(unsigned long pdev_phys, unsigned
 	return res.a0;
 }
 
+static inline unsigned long rmi_pdev_communicate(unsigned long pdev_phys,
+						 unsigned long pdev_comm_data_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_PDEV_COMMUNICATE,
+			     pdev_phys, pdev_comm_data_phys, &res);
+
+	return res.a0;
+}
+
 #endif /* __ASM_RMI_CMDS_H */
diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index a84ed61e5001..8bece465b670 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -47,6 +47,7 @@
 #define SMC_RMI_RTT_INIT_RIPAS		SMC_RMI_CALL(0x0168)
 #define SMC_RMI_RTT_SET_RIPAS		SMC_RMI_CALL(0x0169)
 
+#define SMC_RMI_PDEV_COMMUNICATE        SMC_RMI_CALL(0x0175)
 #define SMC_RMI_PDEV_CREATE             SMC_RMI_CALL(0x0176)
 #define SMC_RMI_PDEV_GET_STATE		SMC_RMI_CALL(0x0178)
 
@@ -338,4 +339,52 @@ struct rmi_pdev_params {
 	};
 };
 
+#define RMI_DEV_COMM_EXIT_CACHE_REQ	BIT(0)
+#define RMI_DEV_COMM_EXIT_CACHE_RSP	BIT(1)
+#define RMI_DEV_COMM_EXIT_SEND		BIT(2)
+#define RMI_DEV_COMM_EXIT_WAIT		BIT(3)
+#define RMI_DEV_COMM_EXIT_MULTI		BIT(4)
+
+#define RMI_DEV_COMM_NONE	0
+#define RMI_DEV_COMM_RESPONSE	1
+#define RMI_DEV_COMM_ERROR	2
+
+#define RMI_PROTOCOL_SPDM		0
+#define RMI_PROTOCOL_SECURE_SPDM	1
+
+#define RMI_DEV_VCA			0
+#define RMI_DEV_CERTIFICATE		1
+#define RMI_DEV_MEASUREMENTS		2
+#define RMI_DEV_INTERFACE_REPORT	3
+
+struct rmi_dev_comm_enter {
+	u64 status;
+	u64 req_addr;
+	u64 resp_addr;
+	u64 resp_len;
+};
+
+struct rmi_dev_comm_exit {
+	u64 flags;
+	u64 cache_req_offset;
+	u64 cache_req_len;
+	u64 cache_rsp_offset;
+	u64 cache_rsp_len;
+	u64 cache_obj_id;
+	u64 protocol;
+	u64 req_len;
+	u64 timeout;
+};
+
+struct rmi_dev_comm_data {
+	union { /* 0x0 */
+		struct rmi_dev_comm_enter enter;
+		u8 padding_1[0x800];
+	};
+	union { /* 0x800 */
+		struct rmi_dev_comm_exit exit;
+		u8 padding_2[0x800];
+	};
+};
+
 #endif /* __ASM_RMI_SMC_H */
diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
index 84d97dd41191..294a6ef60d5f 100644
--- a/drivers/virt/coco/arm-cca-host/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -85,6 +85,45 @@ static void cca_tsm_pci_remove(struct pci_tsm *tsm)
 	vfree(dsc_pf0);
 }
 
+static int init_dev_communication_buffers(struct cca_host_comm_data *comm_data)
+{
+	int ret = -ENOMEM;
+
+	comm_data->io_params = (struct rmi_dev_comm_data *)get_zeroed_page(GFP_KERNEL);
+	if (!comm_data->io_params)
+		goto err_out;
+
+	comm_data->resp_buff = (void *)__get_free_page(GFP_KERNEL);
+	if (!comm_data->resp_buff)
+		goto err_res_buff;
+
+	comm_data->req_buff = (void *)__get_free_page(GFP_KERNEL);
+	if (!comm_data->req_buff)
+		goto err_req_buff;
+
+
+	comm_data->io_params->enter.status = RMI_DEV_COMM_NONE;
+	comm_data->io_params->enter.resp_addr = virt_to_phys(comm_data->resp_buff);
+	comm_data->io_params->enter.req_addr  = virt_to_phys((void *)comm_data->req_buff);
+	comm_data->io_params->enter.resp_len = 0;
+
+	return 0;
+
+err_req_buff:
+	free_page((unsigned long)comm_data->resp_buff);
+err_res_buff:
+	free_page((unsigned long)comm_data->io_params);
+err_out:
+	return ret;
+}
+
+static inline void free_dev_communication_buffers(struct cca_host_comm_data *comm_data)
+{
+	free_page((unsigned long)comm_data->req_buff);
+	free_page((unsigned long)comm_data->resp_buff);
+	free_page((unsigned long)comm_data->io_params);
+}
+
 /* per root port unique with multiple restrictions. For now global */
 static DECLARE_BITMAP(cca_stream_ids, MAX_STREAM_ID);
 
@@ -124,6 +163,7 @@ static int cca_tsm_connect(struct pci_dev *pdev)
 	rc = tsm_ide_stream_register(pdev, ide);
 	if (rc)
 		goto err_tsm;
+	init_dev_communication_buffers(&dsc_pf0->comm_data);
 	/*
 	 * Take a module reference so that we won't call unregister
 	 * without rme_unasign_device
@@ -133,6 +173,11 @@ static int cca_tsm_connect(struct pci_dev *pdev)
 		goto err_tsm;
 	}
 	rme_asign_device(pdev);
+	/*
+	 * Schedule a work to fetch device certificate and setup IDE
+	 */
+	schedule_rme_ide_setup(pdev);
+
 	/*
 	 * Once ide is setup enable the stream at endpoint
 	 * Root port will be done by RMM
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
index 426e530ac182..d123940ce82e 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.c
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
@@ -148,3 +148,201 @@ int rme_asign_device(struct pci_dev *pci_dev)
 err_out:
 	return ret;
 }
+
+static int doe_send_req_resp(struct pci_tsm *tsm)
+{
+	u8 protocol;
+	int ret, data_obj_type;
+	struct cca_host_comm_data *comm_data;
+	struct rmi_dev_comm_exit *io_exit;
+
+	comm_data = to_cca_comm_data(tsm->pdev);
+
+	io_exit = &comm_data->io_params->exit;
+	protocol = io_exit->protocol;
+
+	pr_debug("doe_req size:%lld doe_io_type=%d\n", io_exit->req_len, (int)protocol);
+
+	if (protocol == RMI_PROTOCOL_SPDM)
+		data_obj_type = PCI_DOE_PROTO_CMA;
+	else if (protocol == RMI_PROTOCOL_SECURE_SPDM)
+		data_obj_type = PCI_DOE_PROTO_SSESSION;
+	else
+		return -EINVAL;
+
+	ret = pci_tsm_doe_transfer(tsm->dsm_dev, data_obj_type,
+				   comm_data->req_buff, io_exit->req_len,
+				   comm_data->resp_buff, PAGE_SIZE);
+	pr_debug("doe returned:%d\n", ret);
+	return ret;
+}
+
+/* Parallel update for cca_dsc contents FIXME!! */
+static int __do_dev_communicate(int type, struct pci_tsm *tsm)
+{
+	int ret;
+	bool is_multi;
+	u8 *cache_buf;
+	int *cache_offset;
+	int nbytes, cache_remaining;
+	struct cca_host_dsc_pf0 *dsc_pf0;
+	struct rmi_dev_comm_exit *io_exit;
+	struct rmi_dev_comm_enter *io_enter;
+	struct cca_host_comm_data *comm_data;
+
+
+	comm_data = to_cca_comm_data(tsm->pdev);
+	io_enter = &comm_data->io_params->enter;
+	io_exit = &comm_data->io_params->exit;
+
+	dsc_pf0 = to_cca_dsc_pf0(tsm->dsm_dev);
+redo_communicate:
+	is_multi = false;
+
+	if (type == PDEV_COMMUNICATE)
+		ret = rmi_pdev_communicate(virt_to_phys(dsc_pf0->rmm_pdev),
+					   virt_to_phys(comm_data->io_params));
+	else
+		ret = RMI_ERROR_INPUT;
+	if (ret != RMI_SUCCESS) {
+		pr_err("pdev communicate error\n");
+		return ret;
+	}
+
+	/* caching request from RMM */
+	if (io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_RSP) {
+		switch (io_exit->cache_obj_id) {
+		case RMI_DEV_VCA:
+			cache_buf = dsc_pf0->vca.buf;
+			cache_offset = &dsc_pf0->vca.size;
+			cache_remaining = sizeof(dsc_pf0->vca.buf) - *cache_offset;
+			break;
+		case RMI_DEV_CERTIFICATE:
+			cache_buf = dsc_pf0->cert_chain.cache.buf;
+			cache_offset = &dsc_pf0->cert_chain.cache.size;
+			cache_remaining = sizeof(dsc_pf0->cert_chain.cache.buf) - *cache_offset;
+			break;
+		default:
+			/* FIXME!! depending on the DevComms status,
+			 * it might require to ABORT the communcation.
+			 */
+			return -EINVAL;
+		}
+
+		if (io_exit->cache_rsp_len > cache_remaining)
+			return -EINVAL;
+
+		memcpy(cache_buf + *cache_offset,
+		       (comm_data->resp_buff + io_exit->cache_rsp_offset), io_exit->cache_rsp_len);
+		*cache_offset += io_exit->cache_rsp_len;
+	}
+
+	/*
+	 * wait for last packet request from RMM.
+	 * We should not find this because our device communication in synchronous
+	 */
+	if (io_exit->flags & RMI_DEV_COMM_EXIT_WAIT)
+		return -ENXIO;
+
+	is_multi = !!(io_exit->flags & RMI_DEV_COMM_EXIT_MULTI);
+
+	/* next packet to send */
+	if (io_exit->flags & RMI_DEV_COMM_EXIT_SEND) {
+		nbytes = doe_send_req_resp(tsm);
+		if (nbytes < 0) {
+			/* report error back to RMM */
+			io_enter->status = RMI_DEV_COMM_ERROR;
+		} else {
+			/* send response back to RMM */
+			io_enter->resp_len = nbytes;
+			io_enter->status = RMI_DEV_COMM_RESPONSE;
+		}
+	} else {
+		/* no data transmitted => no data received */
+		io_enter->resp_len = 0;
+	}
+
+	/* The call need to do multiple request/respnse */
+	if (is_multi)
+		goto redo_communicate;
+
+	return 0;
+}
+
+static int do_dev_communicate(int type, struct pci_tsm *tsm, int target_state)
+{
+	int ret;
+	unsigned long state;
+	unsigned long error_state;
+	struct cca_host_dsc_pf0 *dsc_pf0;
+	struct rmi_dev_comm_enter *io_enter;
+
+	dsc_pf0 = to_cca_dsc_pf0(tsm->dsm_dev);
+	io_enter = &dsc_pf0->comm_data.io_params->enter;
+	io_enter->resp_len = 0;
+	io_enter->status = RMI_DEV_COMM_NONE;
+
+	state = -1;
+	do {
+		ret = __do_dev_communicate(type, tsm);
+		if (ret != 0) {
+			pr_err("dev communication error\n");
+			break;
+		}
+
+		if (type == PDEV_COMMUNICATE) {
+			ret = rmi_pdev_get_state(virt_to_phys(dsc_pf0->rmm_pdev),
+						 &state);
+			error_state = RMI_PDEV_ERROR;
+		}
+		if (ret != 0) {
+			pr_err("Get dev state error\n");
+			break;
+		}
+	} while (state != target_state && state != error_state);
+
+	pr_info("dev_io_complete: status: %d state:%ld\n", ret, state);
+
+	return state;
+}
+
+static int do_pdev_communicate(struct pci_tsm *tsm, int target_state)
+{
+	return do_dev_communicate(PDEV_COMMUNICATE, tsm, target_state);
+}
+
+struct dev_comm_work {
+	struct pci_tsm *tsm;
+	struct work_struct work;
+	struct completion complete;
+};
+
+static void pdev_ide_setup_work(struct work_struct *work)
+{
+	unsigned long state;
+	struct pci_tsm *tsm;
+	struct dev_comm_work *setup_work;
+
+	setup_work = container_of(work, struct dev_comm_work, work);
+	tsm = setup_work->tsm;
+
+	state = do_pdev_communicate(tsm, RMI_PDEV_NEEDS_KEY);
+	WARN_ON(state != RMI_PDEV_NEEDS_KEY);
+
+	complete(&setup_work->complete);
+}
+
+int schedule_rme_ide_setup(struct pci_dev *pdev)
+{
+	struct dev_comm_work setup_work = {
+		.tsm = pdev->tsm,
+	};
+
+	INIT_WORK_ONSTACK(&setup_work.work, pdev_ide_setup_work);
+	init_completion(&setup_work.complete);
+	schedule_work(&setup_work.work);
+	wait_for_completion(&setup_work.complete);
+	destroy_work_on_stack(&setup_work.work);
+
+	return 0;
+}
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.h b/drivers/virt/coco/arm-cca-host/rmm-da.h
index 179ba68f2430..b9ddc4d9112b 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.h
@@ -11,15 +11,40 @@
 #include <linux/pci-tsm.h>
 #include <asm/rmi_smc.h>
 
+#define MAX_CACHE_OBJ_SIZE	4096
+struct cache_object {
+	u8 buf[MAX_CACHE_OBJ_SIZE];
+	int size;
+};
+
+/* dsc = device security context */
+struct cca_host_comm_data {
+	void *resp_buff;
+	void *req_buff;
+	struct rmi_dev_comm_data *io_params;
+};
+
 struct cca_host_dsc_pf0 {
+	struct cca_host_comm_data comm_data;
 	struct pci_tsm_pf0 pci;
 	struct pci_ide *sel_stream;
 
 	void *rmm_pdev;
 	int num_aux;
 	void *aux[MAX_PDEV_AUX_GRANULES];
+
+	struct {
+		struct cache_object cache;
+
+		void *public_key;
+		size_t public_key_size;
+
+		bool valid;
+	} cert_chain;
+	struct cache_object vca;
 };
 
+#define PDEV_COMMUNICATE	0x1
 static inline struct cca_host_dsc_pf0 *to_cca_dsc_pf0(struct pci_dev *pdev)
 {
 	struct pci_tsm *tsm = pdev->tsm;
@@ -30,5 +55,21 @@ static inline struct cca_host_dsc_pf0 *to_cca_dsc_pf0(struct pci_dev *pdev)
 	return container_of(tsm, struct cca_host_dsc_pf0, pci.tsm);
 }
 
+static inline struct cca_host_comm_data *to_cca_comm_data(struct pci_dev *pdev)
+{
+	struct cca_host_dsc_pf0 *dsc_pf0;
+
+	dsc_pf0 = to_cca_dsc_pf0(pdev);
+	if (dsc_pf0)
+		return &dsc_pf0->comm_data;
+
+	dsc_pf0 = to_cca_dsc_pf0(pdev->tsm->dsm_dev);
+	if (dsc_pf0)
+		return &dsc_pf0->comm_data;
+
+	return NULL;
+}
+
 int rme_asign_device(struct pci_dev *pdev);
+int schedule_rme_ide_setup(struct pci_dev *pdev);
 #endif
-- 
2.43.0


