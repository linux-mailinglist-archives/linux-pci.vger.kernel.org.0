Return-Path: <linux-pci+bounces-13146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4459E9779E9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 09:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730E31F270FC
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 07:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60F91BD512;
	Fri, 13 Sep 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="nEqf9XgX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04161BC9E1;
	Fri, 13 Sep 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726213353; cv=none; b=VzJT90O0Xeuu7oVAVhHjr7qMsUq5PSjsMT8MNcCy41CWMmMF4BjL10fGyZhPOzCNnnGq1cU/8l+3s6LeIlwbrm+dHJ81jEHr0e7Y1mkCPUdygCH9xpVMHqJ9SMZFwLWvtCH0/JtUWAa/zApPst6nC4l6d7826apM+HYlp+rh7ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726213353; c=relaxed/simple;
	bh=GTsxZPTOZd6mfqLIRjiYK0fiyXE7SXsXw9UTBQZd+CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLroEQgY9G7urhQSo2demMNWii2okq5eMIHpPnK4CWQYQ7GNcFiU5Gb2Qi0orsgxalV2Hp9tpPzV+KTODNQDO9eQ0jZUVSoRACbxnMQp4zE/iJuU/leXDIJIA1/lUigFYB53hHA9RgROFp3FKElfVUeGAb2sMrTiHyenE51bBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=nEqf9XgX; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A358EDAD3A;
	Fri, 13 Sep 2024 09:42:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1726213348; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UPyA4EoVaPPB8Jix49sllO4oSal2U9oXOp5QNqpeuog=;
	b=nEqf9XgXM85QFSQxGdVactBNCG2S7wIvdpCILOsniyW4nVpwYIRrTcxrMvts35aTZ1jTTL
	Yocb0It4hQbZt5N7UYWBBf3h/EkZQcf3v/hU1rD/j06GKUv8u1VNWehhZnxdiSC+bZRAar
	j4mIU3FRdc+TdMXpduBj2XFV1QCvEG+pVuQWkLazJbUkmvfrcSJ5Sr0kyPdir3ItBXFrLF
	7TbvpKOpQ988y8zEDuGfpqopnOZC2mrBlkLxL1na9YDRnjHK9GwFcEPyl4pXH6t9i7RRf+
	/85n954cC9slWL3cyeYVCctEF7vJizZwZkJug/tGKaUBbBeVuoBuP3PRrFaXWQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 13 Sep 2024 09:42:00 +0200
Subject: [PATCH 2/6] scsi: replace blk_mq_pci_map_queues with
 blk_mq_hctx_map_queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-refactor-blk-affinity-helpers-v1-2-8e058f77af12@suse.de>
References: <20240913-refactor-blk-affinity-helpers-v1-0-8e058f77af12@suse.de>
In-Reply-To: <20240913-refactor-blk-affinity-helpers-v1-0-8e058f77af12@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>, 
 20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3

From: Daniel Wagner <dwagner@suse.de>

Replace all users of blk_mq_pci_map_queues with the more generic
blk_mq_hctx_map_queues. This in preparation to retire
blk_mq_pci_map_queues.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/fnic/fnic_main.c             | 4 ++--
 drivers/scsi/megaraid/megaraid_sas_base.c | 4 ++--
 drivers/scsi/mpi3mr/mpi3mr.h              | 1 -
 drivers/scsi/mpi3mr/mpi3mr_os.c           | 3 ++-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      | 4 ++--
 drivers/scsi/pm8001/pm8001_init.c         | 3 ++-
 drivers/scsi/pm8001/pm8001_sas.h          | 1 -
 drivers/scsi/qla2xxx/qla_nvme.c           | 4 ++--
 drivers/scsi/qla2xxx/qla_os.c             | 4 ++--
 drivers/scsi/smartpqi/smartpqi_init.c     | 8 ++++----
 10 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 29eead383eb9..77ad1971351e 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -16,7 +16,6 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <linux/if_ether.h>
-#include <linux/blk-mq-pci.h>
 #include <scsi/fc/fc_fip.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_transport.h>
@@ -601,7 +600,8 @@ void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
 		return;
 	}
 
-	blk_mq_pci_map_queues(qmap, l_pdev, FNIC_PCI_OFFSET);
+	blk_mq_hctx_map_queues(qmap, l_pdev, FNIC_PCI_OFFSET,
+			       pci_get_blk_mq_affinity);
 }
 
 static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 6c79c350a4d5..597bf8476bbc 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -37,7 +37,6 @@
 #include <linux/poll.h>
 #include <linux/vmalloc.h>
 #include <linux/irq_poll.h>
-#include <linux/blk-mq-pci.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -3193,7 +3192,8 @@ static void megasas_map_queues(struct Scsi_Host *shost)
 	map = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 	map->nr_queues = instance->msix_vectors - offset;
 	map->queue_offset = 0;
-	blk_mq_pci_map_queues(map, instance->pdev, offset);
+	blk_mq_hctx_map_queues(map, instance->pdev, offset,
+			       pci_get_blk_mq_affinity);
 	qoff += map->nr_queues;
 	offset += map->nr_queues;
 
diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index dc2cdd5f0311..8e502e34e18b 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -12,7 +12,6 @@
 
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/delay.h>
 #include <linux/dmapool.h>
 #include <linux/errno.h>
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 69b14918de59..1002c19aa2d1 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -4031,7 +4031,8 @@ static void mpi3mr_map_queues(struct Scsi_Host *shost)
 		 */
 		map->queue_offset = qoff;
 		if (i != HCTX_TYPE_POLL)
-			blk_mq_pci_map_queues(map, mrioc->pdev, offset);
+			blk_mq_hctx_map_queues(map, mrioc->pdev, offset,
+					       pci_get_blk_mq_affinity);
 		else
 			blk_mq_map_queues(map);
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 97c2472cd434..162d3da5d8d0 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -53,7 +53,6 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/raid_class.h>
-#include <linux/blk-mq-pci.h>
 #include <asm/unaligned.h>
 
 #include "mpt3sas_base.h"
@@ -11890,7 +11889,8 @@ static void scsih_map_queues(struct Scsi_Host *shost)
 		 */
 		map->queue_offset = qoff;
 		if (i != HCTX_TYPE_POLL)
-			blk_mq_pci_map_queues(map, ioc->pdev, offset);
+			blk_mq_hctx_map_queues(map, ioc->pdev, offset,
+					      pci_get_blk_mq_affinity);
 		else
 			blk_mq_map_queues(map);
 
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 33e1eba62ca1..47a0917fb2a0 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -101,7 +101,8 @@ static void pm8001_map_queues(struct Scsi_Host *shost)
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
 	if (pm8001_ha->number_of_intr > 1) {
-		blk_mq_pci_map_queues(qmap, pm8001_ha->pdev, 1);
+		blk_mq_hctx_map_queues(qmap, pm8001_ha->pdev, 1,
+				       pci_get_blk_mq_affinity);
 		return;
 	}
 
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index ced6721380a8..c46470e0cf63 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -56,7 +56,6 @@
 #include <scsi/sas_ata.h>
 #include <linux/atomic.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-pci.h>
 #include "pm8001_defs.h"
 
 #define DRV_NAME		"pm80xx"
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 8f4cc136a9c9..ea1ef2fae7dd 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -8,7 +8,6 @@
 #include <linux/delay.h>
 #include <linux/nvme.h>
 #include <linux/nvme-fc.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/blk-mq.h>
 
 static struct nvme_fc_port_template qla_nvme_fc_transport;
@@ -841,7 +840,8 @@ static void qla_nvme_map_queues(struct nvme_fc_local_port *lport,
 {
 	struct scsi_qla_host *vha = lport->private;
 
-	blk_mq_pci_map_queues(map, vha->hw->pdev, vha->irq_offset);
+	blk_mq_hctx_map_queues(map, vha->hw->pdev, vha->irq_offset,
+			      pci_get_blk_mq_affinity);
 }
 
 static void qla_nvme_localport_delete(struct nvme_fc_local_port *lport)
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index bc3b2aea3f8b..521ae591898d 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -13,7 +13,6 @@
 #include <linux/mutex.h>
 #include <linux/kobject.h>
 #include <linux/slab.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/refcount.h>
 #include <linux/crash_dump.h>
 #include <linux/trace_events.h>
@@ -8068,7 +8067,8 @@ static void qla2xxx_map_queues(struct Scsi_Host *shost)
 	if (USER_CTRL_IRQ(vha->hw) || !vha->hw->mqiobase)
 		blk_mq_map_queues(qmap);
 	else
-		blk_mq_pci_map_queues(qmap, vha->hw->pdev, vha->irq_offset);
+		blk_mq_hctx_map_queues(qmap, vha->hw->pdev, vha->irq_offset,
+				       pci_get_blk_mq_affinity);
 }
 
 struct scsi_host_template qla2xxx_driver_template = {
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 24c7cb285dca..9f8c2e16d55b 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -19,7 +19,6 @@
 #include <linux/bcd.h>
 #include <linux/reboot.h>
 #include <linux/cciss_ioctl.h>
-#include <linux/blk-mq-pci.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
@@ -6533,10 +6532,11 @@ static void pqi_map_queues(struct Scsi_Host *shost)
 	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
 
 	if (!ctrl_info->disable_managed_interrupts)
-		return blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
-			      ctrl_info->pci_dev, 0);
+		blk_mq_hctx_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
+				       ctrl_info->pci_dev, 0,
+				       pci_get_blk_mq_affinity);
 	else
-		return blk_mq_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT]);
+		blk_mq_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT]);
 }
 
 static inline bool pqi_is_tape_changer_device(struct pqi_scsi_dev *device)

-- 
2.46.0


