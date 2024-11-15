Return-Path: <linux-pci+bounces-16900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D69CF2DA
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1423B47141
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 16:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6A31E1308;
	Fri, 15 Nov 2024 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWiN7Lwv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4181E1047;
	Fri, 15 Nov 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688686; cv=none; b=Ng1F5A/+ATzLqg0r1pZIQtm+iK6V0pirCM1OXOFqBk0vwPaYdCrNx3ohJ3Vyc/HGAfllbE6hxLVN30tLPKwh2E0MSMTj83Ea+2NASJiYn5anf9Zf2hgJypXuN9gh6MJT9Hb/rTe9Z2Z5OCDUm6SyDxT/CSAzp6v/xCAETCealys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688686; c=relaxed/simple;
	bh=Hf21COOjaOe4bnCahplfMdDfvOoGKTVXZCuwIri17wI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rXdgr3jneBigHSsUOk0FgppZv5c7rDdyh1asF4w4cYpfZ2SfTXaBUDPtMv5TDKYHrImnytAz7OXeJh3nDAXVw/cwG4RpBMzMJFTxQHnVWC49plnR5PUb3qM64ou81wRFr6VxfgrlpN/TIp1vmgEV2s/pRjMVMhxUTYSGPLTV6BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWiN7Lwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1A8C4CED7;
	Fri, 15 Nov 2024 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688685;
	bh=Hf21COOjaOe4bnCahplfMdDfvOoGKTVXZCuwIri17wI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JWiN7LwvzHeYoqWdzuQAlUnoft6Xs0d3Q307PE5avUn/ER6kswDaOxIgN6ipntOfH
	 t8ObttZt50pi1e1eocL7Conb09KmDqJe/3odcnpah4ltQ35jHRBl2nZGzea9RZdK3q
	 v8hu8nUV0tq6rcvHdmOhLgXoFSa/kz/w11msNuiQEVK8/DevYgUFCvvRj4cj4a1LYR
	 t7YYea4iT+i6cmTcOZCtAXpgBx0R8fsIihyQDS7mW0oaagDXokhqFsYpXxBlHpbvRb
	 D/G6jQ3p+forQ+90eRx4iV+o5dMItahfk9GKRc3pmLqmjovQy23GVWpSCpYRQrRGIA
	 vnQUMXZ5WQ9Qg==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 15 Nov 2024 17:37:49 +0100
Subject: [PATCH v5 5/8] scsi: replace blk_mq_pci_map_queues with
 blk_mq_map_hw_queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-refactor-blk-affinity-helpers-v5-5-c472afd84d9f@kernel.org>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Replace all users of blk_mq_pci_map_queues with the more generic
blk_mq_map_hw_queues. This in preparation to retire
blk_mq_pci_map_queues.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/scsi/fnic/fnic_main.c             | 3 +--
 drivers/scsi/hisi_sas/hisi_sas.h          | 1 -
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    | 4 ++--
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +--
 drivers/scsi/mpi3mr/mpi3mr.h              | 1 -
 drivers/scsi/mpi3mr/mpi3mr_os.c           | 2 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      | 3 +--
 drivers/scsi/pm8001/pm8001_init.c         | 2 +-
 drivers/scsi/pm8001/pm8001_sas.h          | 1 -
 drivers/scsi/qla2xxx/qla_nvme.c           | 3 +--
 drivers/scsi/qla2xxx/qla_os.c             | 4 ++--
 drivers/scsi/smartpqi/smartpqi_init.c     | 7 +++----
 12 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index adec0df24bc475ea4d7d8089ea0f75fe96746956..1cb517f731f4ac0e7dfa61ddac8ccbe64f5343dc 100644
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
+	blk_mq_map_hw_queues(qmap, &l_pdev->dev, FNIC_PCI_OFFSET);
 }
 
 static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index d223f482488fc6cebc2838e92ae7ec70fb4e1437..010479a354eeeb47bbee24102e450aa3b7ea6197 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -9,7 +9,6 @@
 
 #include <linux/acpi.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/dmapool.h>
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 4cd3a3eab6f1c47c962565a74cd7284dad1db12e..4a0eefa8ab847d9f81afb422e1a1c49391b7c569 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3322,8 +3322,8 @@ static void hisi_sas_map_queues(struct Scsi_Host *shost)
 		if (i == HCTX_TYPE_POLL)
 			blk_mq_map_queues(qmap);
 		else
-			blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
-					      BASE_VECTORS_V3_HW);
+			blk_mq_map_hw_queues(qmap, hisi_hba->dev,
+					     BASE_VECTORS_V3_HW);
 		qoff += qmap->nr_queues;
 	}
 }
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 8e75e2e279a40ae5fdc6b7b07a7aed15241a8d54..f87883bf9ae90f4330194ff36e7cdb7cce99af30 100644
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
+	blk_mq_map_hw_queues(map, &instance->pdev->dev, offset);
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
index 5f2f67acf8bf3194cb8ec78904096ffb4bdd7ff2..3f46f37f5c35d86bcf5f815e0117825f7bc79861 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -4042,7 +4042,7 @@ static void mpi3mr_map_queues(struct Scsi_Host *shost)
 		 */
 		map->queue_offset = qoff;
 		if (i != HCTX_TYPE_POLL)
-			blk_mq_pci_map_queues(map, mrioc->pdev, offset);
+			blk_mq_map_hw_queues(map, &mrioc->pdev->dev, offset);
 		else
 			blk_mq_map_queues(map);
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index f2a55aa5fe65036a3beabae5c0c6e9db835d2aab..9599d7a50028687e3ac09d4eadbdf8b5b00dbe03 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -53,7 +53,6 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/raid_class.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/unaligned.h>
 
 #include "mpt3sas_base.h"
@@ -11890,7 +11889,7 @@ static void scsih_map_queues(struct Scsi_Host *shost)
 		 */
 		map->queue_offset = qoff;
 		if (i != HCTX_TYPE_POLL)
-			blk_mq_pci_map_queues(map, ioc->pdev, offset);
+			blk_mq_map_hw_queues(map, &ioc->pdev->dev, offset);
 		else
 			blk_mq_map_queues(map);
 
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 33e1eba62ca12c2555419197ecdbebad817e4a6d..b53b1ae5b74c3039618c65e4620ae744e084b157 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -101,7 +101,7 @@ static void pm8001_map_queues(struct Scsi_Host *shost)
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
 	if (pm8001_ha->number_of_intr > 1) {
-		blk_mq_pci_map_queues(qmap, pm8001_ha->pdev, 1);
+		blk_mq_map_hw_queues(qmap, &pm8001_ha->pdev->dev, 1);
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
index 8f4cc136a9c9c46f5f2d5408f9b7688ef520a8a3..8ee2e337c9e1b71c031e70c9f67cf131b4a0682c 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -8,7 +8,6 @@
 #include <linux/delay.h>
 #include <linux/nvme.h>
 #include <linux/nvme-fc.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/blk-mq.h>
 
 static struct nvme_fc_port_template qla_nvme_fc_transport;
@@ -841,7 +840,7 @@ static void qla_nvme_map_queues(struct nvme_fc_local_port *lport,
 {
 	struct scsi_qla_host *vha = lport->private;
 
-	blk_mq_pci_map_queues(map, vha->hw->pdev, vha->irq_offset);
+	blk_mq_map_hw_queues(map, &vha->hw->pdev->dev, vha->irq_offset);
 }
 
 static void qla_nvme_localport_delete(struct nvme_fc_local_port *lport)
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 7f980e6141c28282d4c4a0123dda96e36e1f180e..e46cb72fe9e9b058a176ff43260608948590ecdc 100644
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
+		blk_mq_map_hw_queues(qmap, &vha->hw->pdev->dev,
+				       vha->irq_offset);
 }
 
 struct scsi_host_template qla2xxx_driver_template = {
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 870f37b7054644426a2695e857c45a0a12aff051..04fb24d77e9b5c0137f26bc41f17191cc4c49728 100644
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
+		blk_mq_map_hw_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
+				       &ctrl_info->pci_dev->dev, 0);
 	else
-		return blk_mq_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT]);
+		blk_mq_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT]);
 }
 
 static inline bool pqi_is_tape_changer_device(struct pqi_scsi_dev *device)

-- 
2.47.0


