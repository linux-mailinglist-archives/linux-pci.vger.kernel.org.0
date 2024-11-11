Return-Path: <linux-pci+bounces-16458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F09259C4458
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 19:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15DD282233
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6AB19F133;
	Mon, 11 Nov 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8ml36Ps"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E149E4C66;
	Mon, 11 Nov 2024 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348157; cv=none; b=g7HPVQoF2Wwj2hezzv/6cJssKwwZLu/Bh4MKu69L8cCK9uIqmIfffzw+GkV3fy5Qw9ro5REpwwnwQ77xncbbsv1IB6NgFmt2ypNerOPiMjn6YwMDBLeD0s2Tc7vAmpag5EDajc+AnRuxAW9uuvxqeswSf9ilwEWZ8OD0sryJKcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348157; c=relaxed/simple;
	bh=xxm6F3WGpyk3HJ+Nw0RIX0xxEpe7bahxx6eBcWwy7FY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H19Hm2C9h1dXjcl0GduolOFoVxKF2C9lnpbxnXVMXXP+mNkX6vOF/PdUwRQpTFl9vrNxOwid4Fj+eu2HNNulcFkapX4mSjUTby2I47Cd5VrXLvU38evhtD2GsctCceqbtrqyfdfkRbp5qaGir7bsFNfEMaIac5HfVR9RQHVse3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8ml36Ps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1683EC4CED4;
	Mon, 11 Nov 2024 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731348156;
	bh=xxm6F3WGpyk3HJ+Nw0RIX0xxEpe7bahxx6eBcWwy7FY=;
	h=From:Subject:Date:To:Cc:From;
	b=E8ml36PsPE+X1uPSnm0CcJubv3HROgtHQKJsm+nFeo4G08Qba2KOJXkGROkodttBC
	 gnwAU51XQuRpsozwBOaHoIyKOAsPJyEtTXVas0pUgeB9in5g8t0qEJy7C+RSkAjcvT
	 ExOM1HefKsb7EUdd1XiOZ+jLjpN/R2OBzBVlkgICFxSt/WBmZU/xiXWJmbSGF2beqY
	 rcmy6gY//9F9/HJCys70CuOTRbL1/3M/y5XZSOdx3CgJaZGSNc10FGGtbTVlBnLYIw
	 GIgttWp5WBshPr7SGGwj5Z56iWgL1paohNwm79225I8cz6wp2dmPYNt2JvxUFNRF8K
	 cViRi2t4JrjPg==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v2 0/6] blk: refactor queue affinity helpers
Date: Mon, 11 Nov 2024 19:02:08 +0100
Message-Id: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKBGMmcC/4WOQQ6CMBBFr0Jm7Zi2QgBX3sOwaGEqEwlgW4iEc
 Hcrxrh0+X4m780KnhyTh3OygqOZPQ99BHVIoG51fyPkJjIooVJRSoWOrK7D4NB0d9TWcs9hwZa
 6kZzHXBSlKTOTGikgOsZ4zs/df60+7OgxxUz4jS37KFz2H2b5Xr+505/cLFFgQSIrbJ5rK9XFT
 56ODUG1bdsLceXxJt0AAAA=
X-Change-ID: 20240912-refactor-blk-affinity-helpers-7089b95b4b10
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

As Christoph suggested, I introduced a new callback to struct bus_type
and hooked up the callbacks directly in virtio and pci subsystem. This
looks pretty neat!

I've decided to provide only one version of blk_mq_hctx_map_queues but
with an additional argument to pass in a driver specific callback.

Currently, there is only one user of this additional callback. Maybe it
would be better to provide an variant of blk_mq_hctx_map_queues for the
additional argument. Not sure though. Thoughts?

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
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
  https://lore.kernel.org/all/20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de

---
Daniel Wagner (6):
      blk-mq: introduce blk_mq_hctx_map_queues
      scsi: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      scsi: hisi_sas: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      nvme: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      virtio: blk/scsi: replace blk_mq_virtio_map_queues with blk_mq_hctx_map_queues
      blk-mq: remove unused queue mapping helpers

 block/Makefile                            |  2 --
 block/blk-mq-cpumap.c                     | 40 +++++++++++++++++++++++++++
 block/blk-mq-pci.c                        | 46 -------------------------------
 block/blk-mq-virtio.c                     | 46 -------------------------------
 drivers/block/virtio_blk.c                |  4 +--
 drivers/nvme/host/fc.c                    |  1 -
 drivers/nvme/host/pci.c                   |  3 +-
 drivers/pci/pci-driver.c                  | 16 +++++++++++
 drivers/scsi/fnic/fnic_main.c             |  3 +-
 drivers/scsi/hisi_sas/hisi_sas.h          |  1 -
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c    | 22 +++++++--------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |  4 +--
 drivers/scsi/megaraid/megaraid_sas_base.c |  3 +-
 drivers/scsi/mpi3mr/mpi3mr.h              |  1 -
 drivers/scsi/mpi3mr/mpi3mr_os.c           |  3 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      |  4 +--
 drivers/scsi/pm8001/pm8001_init.c         |  2 +-
 drivers/scsi/pm8001/pm8001_sas.h          |  1 -
 drivers/scsi/qla2xxx/qla_nvme.c           |  4 +--
 drivers/scsi/qla2xxx/qla_os.c             |  4 +--
 drivers/scsi/smartpqi/smartpqi_init.c     |  7 ++---
 drivers/scsi/virtio_scsi.c                |  3 +-
 drivers/virtio/virtio.c                   | 12 ++++++++
 include/linux/blk-mq-pci.h                | 11 --------
 include/linux/blk-mq-virtio.h             | 11 --------
 include/linux/blk-mq.h                    |  5 ++++
 include/linux/device/bus.h                |  3 ++
 27 files changed, 107 insertions(+), 155 deletions(-)
---
base-commit: c9af98a7e8af266bae73e9d662b8341da1ec5824
change-id: 20240912-refactor-blk-affinity-helpers-7089b95b4b10

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


