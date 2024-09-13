Return-Path: <linux-pci+bounces-13144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DD69779DF
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 09:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B360A1F270B6
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 07:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA25D1BC9F8;
	Fri, 13 Sep 2024 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="ImwkuKFB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E469D1D52B;
	Fri, 13 Sep 2024 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726213351; cv=none; b=k9Qf9EZLJO3nLvaGYJSkJSx64od/AR20brhoAEbdVrvNdmoHY7j45l+XCelryICPqg0LgerX2OUGohr+Eb2koTkwYRCjsrIJ2a2DZpCkPMVRJkIdDqBJ3X9N2H15gDO95U5g02WVsX30hH8bYCmknd8f8AMwxi+Q4FCwCiFYcO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726213351; c=relaxed/simple;
	bh=xcN/2MClZQoHLqg74s28dw4Q089iErLpjPvgLY8hzm8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u4NOw8ZyEZgxDXvCzQnrV+8PFmX2/FjnZ+uXStxY02kHQgTLePufl6v1lgnhXy/E2mynsEZZq14Slq4SgcBnifdzqLkHohlnZPVKyNUkVQxf4FVBshIK/F+U7rItc1SqEI1oRC+CO85vfh2ak8MM66+Fwdvb+P3iPaEzp2GZl6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=ImwkuKFB; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DE5FDACDF;
	Fri, 13 Sep 2024 09:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1726213344; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=8al1aKshZXM/ap5AqW/w9WJ//+RM7rrRIU1vsdyXi/o=;
	b=ImwkuKFBRWdjpVxXJShrOW/l2J+O4avGesFuvBBoRUmUggXEHjYcO94uFk8LUQZfvk7ZEK
	fZtXT/1VFOzQcd0gn28Xh1r6EmGDvZIr60i6eclc/s8vLA9WIgMKdgKDqQBXdxmQM85SS8
	LjdrbDnYM+TszCtOKzqKXrmZLxPOGAJkgapJRMu8kgf5oF964xIcHEyB9TZLpiEdBZ/g2X
	wTGChrlIAiwJ5VEmx3h0JEbe79HfHtpNjVoB5e97sVcm7c9Iw3nnXxJ1tBeAmS7YKINfP6
	KrirOua2Yfs042xmKCm48F3OBTf2eElm2nMOu3Y2vp0EW/uvp2sqGmWddfffUg==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH 0/6] EDITME: blk: refactor queue affinity helpers
Date: Fri, 13 Sep 2024 09:41:58 +0200
Message-Id: <20240913-refactor-blk-affinity-helpers-v1-0-8e058f77af12@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMbs42YC/z2NQW7DIBBFr2Kx7lRAbROy6j2qLAYYJ6PGQIC4r
 aLcvTSRunxfX+/dRKXCVMV+uIlCG1dOsYN6GYQ/YTwScOgstNSjtEpDoQV9SwXc+RNwWThy+4E
 TnTOVCkburLOTG52Sojtyv/P3w/9xeHKhy7Vn2nMUK9WKj8x++I+EBDE1SBuVr9KvkD3DijlzP
 MKmQMFuMnp0syc/2vd6rfQa6C/osBL4tK7cum8mZY0zi+1eHNG/SRWCxDBp6aWfrfGa0ARxuN9
 /AV2d8PgKAQAA
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
 20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de, 
 Ming Lei <ming.lei@redhat.com>
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3

These patches were part of 'honor isolcpus configuration' [1] series. To
simplify the review process I decided to send this as separate series
because I think it's a nice cleanup independent of the isolcpus feature.

One thing which I am a bit unsure are the CONFIG bits. I've reused the
BLK_MQ_PCI and BLK_MQ_VIRTIO as guard for the new helpers but it looks a
bit off.

changes:
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

[1] https://lore.kernel.org/all/20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Daniel Wagner (5):
      scsi: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      scsi: hisi_sas: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      nvme: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      virtio: blk/scsi: replace blk_mq_virtio_map_queues with blk_mq_hctx_map_queues
      blk-mq: remove unused queue mapping helpers

Ming Lei (1):
      blk-mq: introduce blk_mq_hctx_map_queues

 block/Makefile                            |  2 --
 block/blk-mq-cpumap.c                     | 35 +++++++++++++++++++++++
 block/blk-mq-pci.c                        | 46 -------------------------------
 block/blk-mq-virtio.c                     | 46 -------------------------------
 drivers/block/virtio_blk.c                |  4 +--
 drivers/nvme/host/fc.c                    |  1 -
 drivers/nvme/host/pci.c                   |  4 +--
 drivers/pci/pci.c                         | 20 ++++++++++++++
 drivers/scsi/fnic/fnic_main.c             |  4 +--
 drivers/scsi/hisi_sas/hisi_sas.h          |  1 -
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c    | 20 +++++++-------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |  5 ++--
 drivers/scsi/megaraid/megaraid_sas_base.c |  4 +--
 drivers/scsi/mpi3mr/mpi3mr.h              |  1 -
 drivers/scsi/mpi3mr/mpi3mr_os.c           |  3 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      |  4 +--
 drivers/scsi/pm8001/pm8001_init.c         |  3 +-
 drivers/scsi/pm8001/pm8001_sas.h          |  1 -
 drivers/scsi/qla2xxx/qla_nvme.c           |  4 +--
 drivers/scsi/qla2xxx/qla_os.c             |  4 +--
 drivers/scsi/smartpqi/smartpqi_init.c     |  8 +++---
 drivers/scsi/virtio_scsi.c                |  4 +--
 drivers/virtio/virtio.c                   | 31 +++++++++++++++++++++
 include/linux/blk-mq-pci.h                | 11 --------
 include/linux/blk-mq-virtio.h             | 11 --------
 include/linux/blk-mq.h                    |  5 ++++
 include/linux/pci.h                       | 11 ++++++++
 include/linux/virtio.h                    | 13 +++++++++
 28 files changed, 152 insertions(+), 154 deletions(-)
---
base-commit: 26e197b7f9240a4ac301dd0ad520c0c697c2ea7d
change-id: 20240912-refactor-blk-affinity-helpers-7089b95b4b10
prerequisite-message-id: 20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de
prerequisite-patch-id: 0d995b19a62289433fe888843af1baa6fd19aec7

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>


