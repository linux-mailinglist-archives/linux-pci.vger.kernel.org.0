Return-Path: <linux-pci+bounces-17532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3309E04CE
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 15:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E243B25FA8
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 14:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BBF200120;
	Mon,  2 Dec 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAp0ZNOx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1381D90DB;
	Mon,  2 Dec 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148028; cv=none; b=TS3O/kMGBIQaqztXpH+Wh9H8oBuHUf0bbg6rffRxm83K+l6pEbTByiWxbrSyBW93w3XtKTSFY1tZgHnia32kBZImXJ8ycXv8snseM5qd07DFB7qRD49MnVuhClPm7xgPuu0UB/nZscnM5LL86tNnldrWa2XQCbox9qZo8stuT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148028; c=relaxed/simple;
	bh=CI1Glq9VI/L3LuNkj/dEEMHH9MDZKbIsGpsW/ROzcn4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=owZGwDS8IFrLTW8+mu1QOsL0GVdRcApz8DbaQXEi5XG0LHyu17buHQeoyYt6nsEiOAwAPNbfgZDQPjt7hctyDmr7U7MJ1Jl33NM0GE6iXv+ZLCoCb5yG9RPhkyOtnSMbvM3bTHWCihwpwpweDssCt0rbgxjPyEEgAGX0XxUtIgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAp0ZNOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6850BC4CED1;
	Mon,  2 Dec 2024 14:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733148026;
	bh=CI1Glq9VI/L3LuNkj/dEEMHH9MDZKbIsGpsW/ROzcn4=;
	h=From:Subject:Date:To:Cc:From;
	b=gAp0ZNOxz5p8NWTE57a98FY5SHQyiYCmcVXKMMExsmA4we/6A/l30r06G2gdXAwgQ
	 2IGl1+8dHV8tqkvJOvExBSS4+Wq0xEbbJscpwwEllMlbUXWw+pvmK7j4hiqW1DhJ5P
	 IjlgKQvW7OJAa3FOKh9Hua0/Uof6H8sR1+1ZuXVSVPR+uO2FY1qphQkr8KUlEdlauk
	 mNEE7QkRC55WLejYZOri9uUi0L+CqI+7kiKDYAmZeojDqc7V0IRXW86RwyHMqTfpGU
	 8RJNLTmRuqAOqBwXSi0WXe04QR7u17FmdmuPIheAUt2Rfrpy6O2aQgJfW+8uhzao4y
	 24lARYzq0EELw==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v6 0/8] blk: refactor queue affinity helpers
Date: Mon, 02 Dec 2024 15:00:08 +0100
Message-Id: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGi9TWcC/4XQzY7CIBQF4FcxrAfDb2ld+R4TF1Aulti0DlSiM
 X33uWpmphMXZXduyHe43EmGFCGT3eZOEpSY4zhgqD42pO3scAQaPWYimFCs4YImCLadxkRdf6I
 2hDjE6UY76M+QMjWsblyjnXKcETTOeD1en/7n4ZUTfF2wZvobdjEjeHu+ofDH9KdOrtQVThmtg
 ek6GGMDF/t8ybD1QB5uEb8Wx7NmCbSCrJj31gvJ7f4EaYB+O6bji5NLbu0nikROG+lCa1nrfP3
 GqSW3uqlCznvprOUgKhPeOL3k9BqnkWuVETb4WvnmPzfP8zf1SNe4GQIAAA==
X-Change-ID: 20240912-refactor-blk-affinity-helpers-7089b95b4b10
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

I've rebased and retested the series on top of for-6.14/block and updated
the docummentation as requested by John.

Original cover letter:

These patches were part of 'honor isolcpus configuration' [1] series. To
simplify the review process I decided to send this as separate series
because I think it's a nice cleanup independent of the isolcpus feature.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v6:
- collected tags
- Updated documented
- rebased to for-6.14/block
- Link to v5: https://lore.kernel.org/r/20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org

Changes in v5:
- dropped the irq_get_affinity callback from struct device_driver
  again.
- s/blk_mq_hctx_map_queues/blk_mq_map_hw_queues/
- collected tags
- Link to v4: https://lore.kernel.org/r/20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org

Changes in v4:
- added irq_get_affinity callback to struct device_driver
- hisi_sas use dev pointer directly from hisi_hba.
- blk_mq_hctx_map_queues: ty irq_get_affinity callback
  from device_driver first then from bus_type
- collected tags
- fixed typos
- Link to v3: https://lore.kernel.org/r/20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org

Changes in v3:
- dropped the additinal argument in blk_mq_hctx_map_queues.
  leave open coded version in hisi_sas_v2.
- splitted "blk-mp: introduce blk_mq_hctx_map_queues" patch into
  three patches.
- dropped local variable in pci_device_irq_get_affinity
- Link to v2: https://lore.kernel.org/r/20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org

Changes in v2:
- added new callback to struct bus_type and call directly the affinity
  helpers from there.
- Link to v1: https://lore.kernel.org/r/20240913-refactor-blk-affinity-helpers-v1-0-8e058f77af12@suse.de

Changes in v1:
- renamed blk_mq_dev_map_queues to blk_mq_hctx_map_queues
- squased 'virito: add APIs for retrieving vq affinity' into
  'blk-mq: introduce blk_mq_hctx_map_queues'
- moved hisi_sas changed into a new patch
- hisi_sas use define instead of hard coded value
- moved helpers into their matching subsystem, removed
  blk-mq-pci and blk-mq-virtio files
- fix spelling/typos
- fixed long lines in docu (yep new lines in brief descriptions are
  supported, tested ti)
- based on the first part of
  [1] https://lore.kernel.org/all/20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de

---
Daniel Wagner (8):
      driver core: bus: add irq_get_affinity callback to bus_type
      PCI: hookup irq_get_affinity callback
      virtio: hookup irq_get_affinity callback
      blk-mq: introduce blk_mq_map_hw_queues
      scsi: replace blk_mq_pci_map_queues with blk_mq_map_hw_queues
      nvme: replace blk_mq_pci_map_queues with blk_mq_map_hw_queues
      virtio: blk/scsi: replace blk_mq_virtio_map_queues with blk_mq_map_hw_queues
      blk-mq: remove unused queue mapping helpers

 block/Makefile                            |  2 --
 block/blk-mq-cpumap.c                     | 37 +++++++++++++++++++++++++
 block/blk-mq-pci.c                        | 46 -------------------------------
 block/blk-mq-virtio.c                     | 46 -------------------------------
 drivers/block/virtio_blk.c                |  4 +--
 drivers/nvme/host/fc.c                    |  1 -
 drivers/nvme/host/pci.c                   |  3 +-
 drivers/pci/pci-driver.c                  | 14 ++++++++++
 drivers/scsi/fnic/fnic_main.c             |  3 +-
 drivers/scsi/hisi_sas/hisi_sas.h          |  1 -
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |  4 +--
 drivers/scsi/megaraid/megaraid_sas_base.c |  3 +-
 drivers/scsi/mpi3mr/mpi3mr.h              |  1 -
 drivers/scsi/mpi3mr/mpi3mr_os.c           |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      |  3 +-
 drivers/scsi/pm8001/pm8001_init.c         |  2 +-
 drivers/scsi/pm8001/pm8001_sas.h          |  1 -
 drivers/scsi/qla2xxx/qla_nvme.c           |  3 +-
 drivers/scsi/qla2xxx/qla_os.c             |  4 +--
 drivers/scsi/smartpqi/smartpqi_init.c     |  7 ++---
 drivers/scsi/virtio_scsi.c                |  3 +-
 drivers/virtio/virtio.c                   | 19 +++++++++++++
 include/linux/blk-mq-pci.h                | 11 --------
 include/linux/blk-mq-virtio.h             | 11 --------
 include/linux/blk-mq.h                    |  2 ++
 include/linux/device/bus.h                |  3 ++
 26 files changed, 92 insertions(+), 144 deletions(-)
---
base-commit: 22db180127a901ce41aa14d74da2e2eb452540b1
change-id: 20240912-refactor-blk-affinity-helpers-7089b95b4b10

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


