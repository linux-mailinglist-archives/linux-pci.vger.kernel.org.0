Return-Path: <linux-pci+bounces-39394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64A8C0CCED
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0F5188F4A5
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936B72FB098;
	Mon, 27 Oct 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe0hjflk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E32F3C31;
	Mon, 27 Oct 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559022; cv=none; b=DCirfjvBdsgjdtmVVLALL+X7J4M2jctszIBFSa9oeeRqBbY2RSpZWyS0VEmzxxP6RgLT6omG39oGH40KZ6B6MffrcJAd6uIUFI3oDpGOeBxh6JLWXsfbsia/tHE3gYPlRMtWEhc/3lHz21PFDnF5HvLU3STLHXEJGCk/IWvSycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559022; c=relaxed/simple;
	bh=8xMFN/TY7tHDrYwOABVfX/JHpdB9RJVhkUzDkm+xiUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im1IRgv1ko3zAb/GWiFvJ3AUk5IHvvuPneNidarRwqLNN+DGfNq0+ra+ftXLuWHlagIA0yYAlrc1DKPS57ImIaDT0ZRqEmWjDYmZzTHQEs2fjL81Q7Ck1gZTha7Ddk5CPX2Dje8mrvBI5NuTwHYl0gw1h2P/5A+R7AMnzo3OAtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe0hjflk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72EAC4CEF1;
	Mon, 27 Oct 2025 09:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761559022;
	bh=8xMFN/TY7tHDrYwOABVfX/JHpdB9RJVhkUzDkm+xiUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pe0hjflkB5EiFzda6IDMP8FTV93VulBHe9UAbDBiEwEyqLkI951WVGr4x8PL2m5Tp
	 is7Oawi4gIAc/IjazibbJmGmpDjkU9Y8kP6Fgk2Vk5gaxEki4LAOYUkaBHglBhhcvd
	 gbrJVp3fRGIsLx5sq2q6zqgdrnwKGSyGlqQ2kAqqomPBxQnfuFcYY03aQDy2u+cNRJ
	 B4IZiP8kJDBtCeTj+7peZgjPADDtfnFuMqOw0WvQRKxtYgG0eoIeE/FOY5cf4WzeVT
	 vlFkF0d2bAKiTjDk0Tl6/zu8AliXpW+Tv/1OH0WZceydsVTp4uw6UsZXEcTafSuDCu
	 kDhrv5irPhhQw==
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
Subject: [PATCH RESEND v2 06/12] coco: host: arm64: Add RMM device communication helpers
Date: Mon, 27 Oct 2025 15:25:56 +0530
Message-ID: <20251027095602.1154418-7-aneesh.kumar@kernel.org>
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

- add SMCCC IDs/wrappers for RMI_PDEV_COMMUNICATE/RMI_PDEV_ABORT
- describe the RMM device-communication ABI (struct rmi_dev_comm_*,
  cache flags, protocol/object IDs, busy error code)
- track per-PF0 communication state (buffers, workqueue, cache metadata) and
  serialize access behind object_lock
- plumb a DOE/SPDM worker (pdev_communicate_work) plus shared helpers that
  submit the SMCCC call, cache multi-part responses, and handle retries/abort
- hook the new helpers into the physical function connect path so IDE
  setup can drive the device to the expected state

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_cmds.h        |  20 ++
 arch/arm64/include/asm/rmi_smc.h         |  63 ++++++
 drivers/virt/coco/arm-cca-host/arm-cca.c |  50 +++++
 drivers/virt/coco/arm-cca-host/rmi-da.c  | 273 +++++++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmi-da.h  |  63 ++++++
 5 files changed, 469 insertions(+)

diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
index 4547ce0901a6..b86bf15afcda 100644
--- a/arch/arm64/include/asm/rmi_cmds.h
+++ b/arch/arm64/include/asm/rmi_cmds.h
@@ -536,4 +536,24 @@ static inline unsigned long rmi_pdev_get_state(unsigned long pdev_phys, enum rmi
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
+static inline unsigned long rmi_pdev_abort(unsigned long pdev_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_PDEV_ABORT, pdev_phys, &res);
+
+	return res.a0;
+}
+
 #endif /* __ASM_RMI_CMDS_H */
diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index 10f87a18f09a..53e46e24c921 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -47,6 +47,8 @@
 #define SMC_RMI_RTT_INIT_RIPAS		SMC_RMI_CALL(0x0168)
 #define SMC_RMI_RTT_SET_RIPAS		SMC_RMI_CALL(0x0169)
 
+#define SMC_RMI_PDEV_ABORT		SMC_RMI_CALL(0x0174)
+#define SMC_RMI_PDEV_COMMUNICATE        SMC_RMI_CALL(0x0175)
 #define SMC_RMI_PDEV_CREATE             SMC_RMI_CALL(0x0176)
 #define SMC_RMI_PDEV_GET_STATE		SMC_RMI_CALL(0x0178)
 
@@ -69,6 +71,7 @@
 #define RMI_ERROR_REALM		2
 #define RMI_ERROR_REC		3
 #define RMI_ERROR_RTT		4
+#define RMI_BUSY		10
 
 enum rmi_ripas {
 	RMI_EMPTY = 0,
@@ -361,4 +364,64 @@ struct rmi_pdev_params {
 	};
 };
 
+#define RMI_DEV_COMM_EXIT_CACHE_REQ	BIT(0)
+#define RMI_DEV_COMM_EXIT_CACHE_RSP	BIT(1)
+#define RMI_DEV_COMM_EXIT_SEND		BIT(2)
+#define RMI_DEV_COMM_EXIT_WAIT		BIT(3)
+#define RMI_DEV_COMM_EXIT_RSP_RESET	BIT(4)
+#define RMI_DEV_COMM_EXIT_MULTI		BIT(5)
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
+	union {
+		u8 status;
+		u64 padding0;
+	};
+	u64 req_addr;
+	u64 resp_addr;
+	u64 resp_len;
+};
+
+struct rmi_dev_comm_exit {
+	u64 flags;
+	u64 req_cache_offset;
+	u64 req_cache_len;
+	u64 rsp_cache_offset;
+	u64 rsp_cache_len;
+	union {
+		u8 cache_obj_id;
+		u64 padding0;
+	};
+
+	union {
+		u8 protocol;
+		u64 padding1;
+	};
+	u64 req_delay;
+	u64 req_len;
+	u64 rsp_timeout;
+};
+
+struct rmi_dev_comm_data {
+	union { /* 0x0 */
+		struct rmi_dev_comm_enter enter;
+		u8 padding0[0x800];
+	};
+	union { /* 0x800 */
+		struct rmi_dev_comm_exit exit;
+		u8 padding1[0x800];
+	};
+};
+
 #endif /* __ASM_RMI_SMC_H */
diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
index 18e5bf6adea4..e79f05fee516 100644
--- a/drivers/virt/coco/arm-cca-host/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -48,6 +48,7 @@ static struct pci_tsm *cca_tsm_pci_probe(struct tsm_dev *tsm_dev, struct pci_dev
 	rc = pci_tsm_pf0_constructor(pdev, &pf0_dsc->pci, tsm_dev);
 	if (rc)
 		return NULL;
+	mutex_init(&pf0_dsc->object_lock);
 
 	pci_dbg(pdev, "tsm enabled\n");
 	return &no_free_ptr(pf0_dsc)->pci.base_tsm;
@@ -70,6 +71,55 @@ static void cca_tsm_pci_remove(struct pci_tsm *tsm)
 	}
 }
 
+static __maybe_unused int init_dev_communication_buffers(struct pci_dev *pdev,
+							 struct cca_host_comm_data *comm_data)
+{
+	int ret = -ENOMEM;
+
+	comm_data->io_params = (struct rmi_dev_comm_data *)get_zeroed_page(GFP_KERNEL);
+	if (!comm_data->io_params)
+		goto err_out;
+
+	comm_data->rsp_buff = (void *)__get_free_page(GFP_KERNEL);
+	if (!comm_data->rsp_buff)
+		goto err_res_buff;
+
+	comm_data->req_buff = (void *)__get_free_page(GFP_KERNEL);
+	if (!comm_data->req_buff)
+		goto err_req_buff;
+
+	comm_data->work_queue = alloc_ordered_workqueue("%s %s DEV_COMM", 0,
+						dev_bus_name(&pdev->dev),
+						pci_name(pdev));
+	if (!comm_data->work_queue)
+		goto err_work_queue;
+
+	comm_data->io_params->enter.status = RMI_DEV_COMM_NONE;
+	comm_data->io_params->enter.resp_addr = virt_to_phys(comm_data->rsp_buff);
+	comm_data->io_params->enter.req_addr  = virt_to_phys(comm_data->req_buff);
+	comm_data->io_params->enter.resp_len = 0;
+
+	return 0;
+
+err_work_queue:
+	free_page((unsigned long)comm_data->req_buff);
+err_req_buff:
+	free_page((unsigned long)comm_data->rsp_buff);
+err_res_buff:
+	free_page((unsigned long)comm_data->io_params);
+err_out:
+	return ret;
+}
+
+static inline void free_dev_communication_buffers(struct cca_host_comm_data *comm_data)
+{
+	destroy_workqueue(comm_data->work_queue);
+
+	free_page((unsigned long)comm_data->req_buff);
+	free_page((unsigned long)comm_data->rsp_buff);
+	free_page((unsigned long)comm_data->io_params);
+}
+
 /* For now global for simplicity. Protected by pci_tsm_rwsem */
 static DECLARE_BITMAP(cca_stream_ids, MAX_STREAM_ID);
 
diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.c b/drivers/virt/coco/arm-cca-host/rmi-da.c
index 390b8f05c7cf..592abe0dd252 100644
--- a/drivers/virt/coco/arm-cca-host/rmi-da.c
+++ b/drivers/virt/coco/arm-cca-host/rmi-da.c
@@ -5,6 +5,8 @@
 
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
+#include <linux/pci-doe.h>
+#include <linux/delay.h>
 #include <asm/rmi_cmds.h>
 
 #include "rmi-da.h"
@@ -139,3 +141,274 @@ int pdev_create(struct pci_dev *pci_dev)
 		free_page((unsigned long)rmm_pdev);
 	return ret;
 }
+
+static int doe_send_req_resp(struct pci_tsm *tsm)
+{
+	int ret, data_obj_type;
+	struct cca_host_comm_data *comm_data = to_cca_comm_data(tsm->pdev);
+	struct rmi_dev_comm_exit *io_exit = &comm_data->io_params->exit;
+	u8 protocol = io_exit->protocol;
+
+	if (protocol == RMI_PROTOCOL_SPDM)
+		data_obj_type = PCI_DOE_FEATURE_CMA;
+	else if (protocol == RMI_PROTOCOL_SECURE_SPDM)
+		data_obj_type = PCI_DOE_FEATURE_SSESSION;
+	else
+		return -EINVAL;
+
+	/* delay the send */
+	if (io_exit->req_delay)
+		fsleep(io_exit->req_delay);
+
+	ret = pci_tsm_doe_transfer(tsm->dsm_dev, data_obj_type,
+				   comm_data->req_buff, io_exit->req_len,
+				   comm_data->rsp_buff, PAGE_SIZE);
+	return ret;
+}
+
+static inline bool pending_dev_communicate(struct rmi_dev_comm_exit *io_exit)
+{
+	bool pending = io_exit->flags & (RMI_DEV_COMM_EXIT_CACHE_REQ |
+					 RMI_DEV_COMM_EXIT_CACHE_RSP |
+					 RMI_DEV_COMM_EXIT_SEND |
+					 RMI_DEV_COMM_EXIT_WAIT |
+					 RMI_DEV_COMM_EXIT_MULTI);
+	return pending;
+}
+
+static int ___do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
+{
+	int ret, nbytes, cp_len;
+	struct cache_object **cache_objp, *cache_obj;
+	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
+	struct cca_host_comm_data *comm_data = to_cca_comm_data(tsm->pdev);
+	struct rmi_dev_comm_enter *io_enter = &comm_data->io_params->enter;
+	struct rmi_dev_comm_exit *io_exit = &comm_data->io_params->exit;
+
+redo_communicate:
+
+	if (type == PDEV_COMMUNICATE)
+		ret = rmi_pdev_communicate(virt_to_phys(pf0_dsc->rmm_pdev),
+					   virt_to_phys(comm_data->io_params));
+	else
+		ret = RMI_ERROR_INPUT;
+	if (ret != RMI_SUCCESS) {
+		if (ret == RMI_BUSY)
+			return -EBUSY;
+		return -ENXIO;
+	}
+
+	if (io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_REQ ||
+	    io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_RSP) {
+
+		switch (io_exit->cache_obj_id) {
+		case RMI_DEV_VCA:
+			cache_objp = &pf0_dsc->vca;
+			break;
+		case RMI_DEV_CERTIFICATE:
+			cache_objp = &pf0_dsc->cert_chain.cache;
+			break;
+		default:
+			return -EINVAL;
+		}
+		cache_obj = *cache_objp;
+	}
+
+	if (io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_REQ)
+		cp_len = io_exit->req_cache_len;
+	else
+		cp_len = io_exit->rsp_cache_len;
+
+	/* response and request len should be <= SZ_4k */
+	if (cp_len > CACHE_CHUNK_SIZE)
+		return -EINVAL;
+
+	if (io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_REQ ||
+	    io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_RSP) {
+		int cache_remaining;
+		struct cache_object *new_obj;
+
+		/* new allocation */
+		if (!cache_obj) {
+			cache_obj = kvmalloc(struct_size(cache_obj, buf, CACHE_CHUNK_SIZE),
+					     GFP_KERNEL);
+			if (!cache_obj)
+				return -ENOMEM;
+
+			cache_obj->size = CACHE_CHUNK_SIZE;
+			cache_obj->offset = 0;
+			*cache_objp = cache_obj;
+		}
+
+		cache_remaining = cache_obj->size - cache_obj->offset;
+		if (cp_len > cache_remaining) {
+
+			if (cache_obj->size + CACHE_CHUNK_SIZE > MAX_CACHE_OBJ_SIZE)
+				return -EINVAL;
+
+			new_obj = kvmalloc(struct_size(cache_obj, buf,
+						       cache_obj->size + CACHE_CHUNK_SIZE),
+					   GFP_KERNEL);
+			if (!new_obj)
+				return -ENOMEM;
+			memcpy(new_obj, cache_obj, struct_size(cache_obj, buf, cache_obj->size));
+			new_obj->size = cache_obj->size + CACHE_CHUNK_SIZE;
+			*cache_objp = new_obj;
+			kvfree(cache_obj);
+		}
+
+		/* cache object can change above. */
+		cache_obj = *cache_objp;
+	}
+
+
+	if (io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_REQ) {
+		memcpy(cache_obj->buf + cache_obj->offset,
+		       (comm_data->req_buff + io_exit->req_cache_offset), io_exit->req_cache_len);
+		cache_obj->offset += io_exit->req_cache_len;
+	}
+
+	if (io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_RSP) {
+		memcpy(cache_obj->buf + cache_obj->offset,
+		       (comm_data->rsp_buff + io_exit->rsp_cache_offset), io_exit->rsp_cache_len);
+		cache_obj->offset += io_exit->rsp_cache_len;
+	}
+
+	/*
+	 * wait for last packet request from RMM.
+	 * We should not find this because our device communication is synchronous
+	 */
+	if (io_exit->flags & RMI_DEV_COMM_EXIT_WAIT)
+		return -ENXIO;
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
+		io_enter->status = RMI_DEV_COMM_NONE;
+	}
+
+	if (pending_dev_communicate(io_exit))
+		goto redo_communicate;
+
+	return 0;
+}
+
+static int __do_dev_communicate(enum dev_comm_type type,
+				struct pci_tsm *tsm, unsigned long error_state)
+{
+	int ret;
+	int state;
+	struct rmi_dev_comm_enter *io_enter;
+	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
+
+	io_enter = &pf0_dsc->comm_data.io_params->enter;
+	io_enter->resp_len = 0;
+	io_enter->status = RMI_DEV_COMM_NONE;
+
+	ret = ___do_dev_communicate(type, tsm);
+	if (ret) {
+		if (type == PDEV_COMMUNICATE)
+			rmi_pdev_abort(virt_to_phys(pf0_dsc->rmm_pdev));
+
+		state = error_state;
+	} else {
+		/*
+		 * Some device communication error will transition the
+		 * device to error state. Report that.
+		 */
+		if (type == PDEV_COMMUNICATE)
+			ret = rmi_pdev_get_state(virt_to_phys(pf0_dsc->rmm_pdev),
+						 (enum rmi_pdev_state *)&state);
+		if (ret)
+			state = error_state;
+	}
+
+	if (state == error_state)
+		pci_err(tsm->pdev, "device communication error\n");
+
+	return state;
+}
+
+static int do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm,
+			      unsigned long target_state,
+			      unsigned long error_state)
+{
+	int state;
+
+	do {
+		state = __do_dev_communicate(type, tsm, error_state);
+
+		if (state == target_state || state == error_state)
+			break;
+	} while (1);
+
+	return state;
+}
+
+static int do_pdev_communicate(struct pci_tsm *tsm, enum rmi_pdev_state target_state)
+{
+	return do_dev_communicate(PDEV_COMMUNICATE, tsm, target_state, RMI_PDEV_ERROR);
+}
+
+void pdev_communicate_work(struct work_struct *work)
+{
+	unsigned long state;
+	struct pci_tsm *tsm;
+	struct dev_comm_work *setup_work;
+	struct cca_host_pf0_dsc *pf0_dsc;
+
+	setup_work = container_of(work, struct dev_comm_work, work);
+	tsm = setup_work->tsm;
+	pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
+
+	guard(mutex)(&pf0_dsc->object_lock);
+	state = do_pdev_communicate(tsm, setup_work->target_state);
+	WARN_ON(state != setup_work->target_state);
+
+	complete(&setup_work->complete);
+}
+
+static int submit_pdev_comm_work(struct pci_dev *pdev, int target_state)
+{
+	int ret;
+	enum rmi_pdev_state state;
+	struct dev_comm_work comm_work;
+	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(pdev);
+	struct cca_host_comm_data *comm_data = to_cca_comm_data(pdev);
+
+	INIT_WORK_ONSTACK(&comm_work.work, pdev_communicate_work);
+	init_completion(&comm_work.complete);
+	comm_work.tsm = pdev->tsm;
+	comm_work.target_state = target_state;
+
+	queue_work(comm_data->work_queue, &comm_work.work);
+
+	wait_for_completion(&comm_work.complete);
+	destroy_work_on_stack(&comm_work.work);
+
+	/* check if we reached target state */
+	ret = rmi_pdev_get_state(virt_to_phys(pf0_dsc->rmm_pdev), &state);
+	if (ret)
+		return ret;
+
+	if (state != target_state)
+		/* no specific error for this */
+		return -1;
+	return 0;
+}
+
+int pdev_ide_setup(struct pci_dev *pdev)
+{
+	return submit_pdev_comm_work(pdev, RMI_PDEV_NEEDS_KEY);
+}
diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.h b/drivers/virt/coco/arm-cca-host/rmi-da.h
index 6764bf8d98ce..1d513e0b74d9 100644
--- a/drivers/virt/coco/arm-cca-host/rmi-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmi-da.h
@@ -9,22 +9,68 @@
 #include <linux/pci.h>
 #include <linux/pci-ide.h>
 #include <linux/pci-tsm.h>
+#include <linux/sizes.h>
 #include <asm/rmi_smc.h>
 
+#define MAX_CACHE_OBJ_SIZE	SZ_16M
+#define CACHE_CHUNK_SIZE	SZ_4K
+struct cache_object {
+	int size;
+	int offset;
+	u8 buf[] __counted_by(size);
+};
+
+struct dev_comm_work {
+	struct pci_tsm *tsm;
+	int target_state;
+	struct work_struct work;
+	struct completion complete;
+};
+
+struct cca_host_comm_data {
+	void *rsp_buff;
+	void *req_buff;
+	struct rmi_dev_comm_data *io_params;
+	/*
+	 * Only one device communication request can be active at
+	 * a time. This limitation comes from using the DOE mailbox
+	 * at the pdev level. Requests such as get_measurements may
+	 * span multiple mailbox messages, which must not be
+	 * interleaved with other SPDM requests.
+	 */
+	struct workqueue_struct *work_queue;
+};
+
 /* dsc = device security context */
 struct cca_host_pf0_dsc {
+	struct cca_host_comm_data comm_data;
 	struct pci_tsm_pf0 pci;
 	struct pci_ide *sel_stream;
 
 	void *rmm_pdev;
 	int num_aux;
 	void *aux[MAX_PDEV_AUX_GRANULES];
+
+	struct mutex object_lock;
+	struct {
+		struct cache_object *cache;
+
+		void *public_key;
+		size_t public_key_size;
+
+		bool valid;
+	} cert_chain;
+	struct cache_object *vca;
 };
 
 struct cca_host_fn_dsc {
 	struct pci_tsm pci;
 };
 
+enum dev_comm_type {
+	PDEV_COMMUNICATE = 0x1,
+};
+
 static inline struct cca_host_pf0_dsc *to_cca_pf0_dsc(struct pci_dev *pdev)
 {
 	struct pci_tsm *tsm = pdev->tsm;
@@ -42,5 +88,22 @@ static inline struct cca_host_fn_dsc *to_cca_fn_dsc(struct pci_dev *pdev)
 	return container_of(tsm, struct cca_host_fn_dsc, pci);
 }
 
+static inline struct cca_host_comm_data *to_cca_comm_data(struct pci_dev *pdev)
+{
+	struct cca_host_pf0_dsc *pf0_dsc;
+
+	pf0_dsc = to_cca_pf0_dsc(pdev);
+	if (pf0_dsc)
+		return &pf0_dsc->comm_data;
+
+	pf0_dsc = to_cca_pf0_dsc(pdev->tsm->dsm_dev);
+	if (pf0_dsc)
+		return &pf0_dsc->comm_data;
+
+	return NULL;
+}
+
 int pdev_create(struct pci_dev *pdev);
+void pdev_communicate_work(struct work_struct *work);
+int pdev_ide_setup(struct pci_dev *pdev);
 #endif
-- 
2.43.0


