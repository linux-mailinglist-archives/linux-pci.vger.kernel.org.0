Return-Path: <linux-pci+bounces-16460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610649C4463
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 19:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F72282701
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5349A1AB6C4;
	Mon, 11 Nov 2024 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8gPEJ3e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7651AB53F;
	Mon, 11 Nov 2024 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348162; cv=none; b=et3HOWnrPirRdLAUYzOpC0P52vB7nejVHz7euUMHhWmKXFjAA//YyIs8z8ZlY+e9woqi3AWrLmhRH0KK9jl0pK/WCUcTo9DatQ22TB+59EYbAvZZ5pFAoV6oB1XXnpisOgeC27RWszc0wTcyx7wjRhqE2/nkUmiGrcqLvVU/xes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348162; c=relaxed/simple;
	bh=Q7fYE/xJlWDN03gBfQlsFtirezGmffiTBEXil1qb08I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qf1DKWNMfO8zQ+qNd9Vt4SRENCei4vEPWxiW11lqtdvruqunrUNrrqh7pDvs7W4FACieCBqOfyeVP5YVlHpXMeZfmT65x3XssIMVx0gv+1pSeuzc/JD/hNM/1ImYfS+USsBNMIo1W0J8khI1zcw+K8+1oDGGdRSJVERjaAtGPjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8gPEJ3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABE5C4CED4;
	Mon, 11 Nov 2024 18:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731348161;
	bh=Q7fYE/xJlWDN03gBfQlsFtirezGmffiTBEXil1qb08I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E8gPEJ3ef6mhNz+R4hf+B2dQyf6FMwCFFQR347b7vuZOLmZFUv11F2mzFMDEwqJPQ
	 m718RBOQMu7sD2M9n7mdO7n9ur//hSd+tIEW4Zp1+5hsVZbh2PlBfkbjogZIaibIT+
	 BOz+9/qd1nJrWlTXJoJqa13ET2YEvBjLqy+5NnOAVF1+kRW2CES5BXArqZ9L231rNK
	 IX8chxe0q4aqdIRKCduNiBAfJWmAxs/DqEV6TlBx1nZqqN0kl3eJCm2WtfKJub2YWd
	 DeD+CwKKMRJ14ZqVNSa1+HGKU7NsF9hYXVZ/s4ZZHRuag7uv5waWjCW6jfhuKsrkda
	 FpLya7WRq3T3Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 11 Nov 2024 19:02:10 +0100
Subject: [PATCH v2 2/6] scsi: replace blk_mq_pci_map_queues with
 blk_mq_hctx_map_queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-refactor-blk-affinity-helpers-v2-2-f360ddad231a@kernel.org>
References: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org>
In-Reply-To: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org>
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
 Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

From: Daniel Wagner <dwagner@suse.de>

Replace all users of blk_mq_pci_map_queues with the more generic
blk_mq_hctx_map_queues. This in preparation to retire
blk_mq_pci_map_queues.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/scsi/fnic/fnic_main.c             | 3 +--
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +--
 drivers/scsi/mpi3mr/mpi3mr.h              | 1 -
 drivers/scsi/mpi3mr/mpi3mr_os.c           | 3 ++-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      | 4 ++--
 drivers/scsi/pm8001/pm8001_init.c         | 2 +-
 drivers/scsi/pm8001/pm8001_sas.h          | 1 -
 drivers/scsi/qla2xxx/qla_nvme.c           | 4 ++--
 drivers/scsi/qla2xxx/qla_os.c             | 4 ++--
 drivers/scsi/smartpqi/smartpqi_init.c     | 7 +++----
 10 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index adec0df24bc475ea4d7d8089ea0f75fe96746956..42033e08a233be67e64181b2461d05ab0cddd8f9 100644
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
@@ -601,7 +600,7 @@ void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
 		return;
 	}
 
-	blk_mq_pci_map_queues(qmap, l_pdev, FNIC_PCI_OFFSET);
+	blk_mq_hctx_map_queues(qmap, &l_pdev->dev, FNIC_PCI_OFFSET, NULL);
 }
 
 static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 8e75e2e279a40ae5fdc6b7b07a7aed15241a8d54..7979a8f5a50377c1af5d166ec23ac2e543c6c404 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -37,7 +37,6 @@
 #include <linux/poll.h>
 #include <linux/vmalloc.h>
 #include <linux/irq_poll.h>
-#include <linux/blk-mq-pci.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -3193,7 +3192,7 @@ static void megasas_map_queues(struct Scsi_Host *shost)
 	map = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 	map->nr_queues = instance->msix_vectors - offset;
 	map->queue_offset = 0;
-	blk_mq_pci_map_queues(map, instance->pdev, offset);
+	blk_mq_hctx_map_queues(map, &instance->pdev->dev, offset, NULL);
 	qoff += map->nr_queues;
 	offset += map->nr_queues;
 
diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 81bb408ce56d8f9599e6f62276666bedce6d0d32..57ccea42ece1ecf1c471ee744213453b13db0ea1 100644
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
index 5f2f67acf8bf3194cb8ec78904096ffb4bdd7ff2..7aa631126d39d0d696c19943b78519f512a49751 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -4042,7 +4042,8 @@ static void mpi3mr_map_queues(struct Scsi_Host *shost)
 		 */
 		map->queue_offset = qoff;
 		if (i != HCTX_TYPE_POLL)
-			blk_mq_pci_map_queues(map, mrioc->pdev, offset);
+			blk_mq_hctx_map_queues(map, &mrioc->pdev->dev,
+					       offset, NULL);
 		else
 			blk_mq_map_queues(map);
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index f2a55aa5fe65036a3beabae5c0c6e9db835d2aab..3fa6b5295198e5a27acbb31dbc0becffdb21a9e1 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -53,7 +53,6 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/raid_class.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/unaligned.h>
 
 #include "mpt3sas_base.h"
@@ -11890,7 +11889,8 @@ static void scsih_map_queues(struct Scsi_Host *shost)
 		 */
 		map->queue_offset = qoff;
 		if (i != HCTX_TYPE_POLL)
-			blk_mq_pci_map_queues(map, ioc->pdev, offset);
+			blk_mq_hctx_map_queues(map, &ioc->pdev->dev,
+					       offset, NULL);
 		else
 			blk_mq_map_queues(map);
 
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 33e1eba62ca12c2555419197ecdbebad817e4a6d..825f5ad29ebd13f6ef1e63e67e1a5e9ab0a45f86 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -101,7 +101,7 @@ static void pm8001_map_queues(struct Scsi_Host *shost)
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
 	if (pm8001_ha->number_of_intr > 1) {
-		blk_mq_pci_map_queues(qmap, pm8001_ha->pdev, 1);
+		blk_mq_hctx_map_queues(qmap, &pm8001_ha->pdev->dev, 1, NULL);
 		return;
 	}
 
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index ced6721380a85345a74a87ebd2facdaa513f8768..c46470e0cf63b7b18b9572c8d6b4f4ddf489aa2b 100644
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
index 8f4cc136a9c9c46f5f2d5408f9b7688ef520a8a3..8931e3c17e767954cfd2d0b5d14cc42a93d97e85 100644
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
+	blk_mq_hctx_map_queues(map, &vha->hw->pdev->dev,
+			       vha->irq_offset, NULL);
 }
 
 static void qla_nvme_localport_delete(struct nvme_fc_local_port *lport)
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 7f980e6141c28282d4c4a0123dda96e36e1f180e..de201f8e89922d9b931804ca3d491c45db05bb99 100644
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
@@ -8070,7 +8069,8 @@ static void qla2xxx_map_queues(struct Scsi_Host *shost)
 	if (USER_CTRL_IRQ(vha->hw) || !vha->hw->mqiobase)
 		blk_mq_map_queues(qmap);
 	else
-		blk_mq_pci_map_queues(qmap, vha->hw->pdev, vha->irq_offset);
+		blk_mq_hctx_map_queues(qmap, &vha->hw->pdev->dev,
+				       vha->irq_offset, NULL);
 }
 
 struct scsi_host_template qla2xxx_driver_template = {
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 870f37b7054644426a2695e857c45a0a12aff051..78f097d4e33fcca553167febedd78e3de4798014 100644
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
@@ -6547,10 +6546,10 @@ static void pqi_map_queues(struct Scsi_Host *shost)
 	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
 
 	if (!ctrl_info->disable_managed_interrupts)
-		return blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
-			      ctrl_info->pci_dev, 0);
+		blk_mq_hctx_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
+				       &ctrl_info->pci_dev->dev, 0, NULL);
 	else
-		return blk_mq_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT]);
+		blk_mq_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT]);
 }
 
 static inline bool pqi_is_tape_changer_device(struct pqi_scsi_dev *device)

-- 
2.47.0


