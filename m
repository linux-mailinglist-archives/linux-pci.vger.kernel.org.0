Return-Path: <linux-pci+bounces-16895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB269CF1A1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDBA1F21173
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9B71D514F;
	Fri, 15 Nov 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ci0n79GX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071C61E4A6;
	Fri, 15 Nov 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688672; cv=none; b=HShJ6/cMsPBVYg+2QdOdDZR7VoZK7Gr2Lg58mclqNQt/grDNOr2Ga1kQIgcR9XB99U2lWgruUW/FXhYRhzmP2Md7krgD3HVq6rOP0rNntvRMnqdz8oCGmzzjHx+Su4XxkQj6dX0qPEk3KBzzyuzfdUU7d5JHIdsFYbMxjxaGY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688672; c=relaxed/simple;
	bh=xPIEzNMgELR96A8fMGWEUYtmUX8fIT/IURHsLtPs3dE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=peUanB6/7XSZAIRlQedxKtdtUa/SeuGs1mUkGV75k9S1CiRrSvrRGQOjm9cEQAmYUwdBd06l2PJKj+L5iogK0VMReq/TVV1HVj28hTJhNsnSAGVoa+FZGFwX08VyH9ugqKL/b4IKhUWdfgNF529Ydk3D3nGfsriC/1iTOs7P/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ci0n79GX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC11C4CED0;
	Fri, 15 Nov 2024 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688671;
	bh=xPIEzNMgELR96A8fMGWEUYtmUX8fIT/IURHsLtPs3dE=;
	h=From:Subject:Date:To:Cc:From;
	b=Ci0n79GXpD+jm0+r+F9HkavA5zO439RHVREHGgBezDSJywcwC8KeVPR4au0Y1sYTJ
	 HJDSqAwJmQCITjKfF3xHy8cFlmW+EGi/mikoxmbtiNSW8oPHDVV9D44sOjBJ8LaFlJ
	 d5J6hTkAq+ewYBE/A5z7RZwyPbxlnu46xg1pmS8KEAemlhufP8hw6IOZbGY7ApNBPo
	 iBa4g2n5umIxHgJZRWtVWxHRxRYZXhDuxgvBX9Cb2s7Auy54QvYNxZXd4L3OVzVl6S
	 26c7LlRuD9PBCtt34ywkFmUA/u/e9c5JvwlhIjy6V50k55ypwhP2ZZaJgTp3nTY5vs
	 69P07L8RWI0fw==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v5 0/8] blk: refactor queue affinity helpers
Date: Fri, 15 Nov 2024 17:37:44 +0100
Message-Id: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANh4N2cC/4XQza7CIBAF4FcxrMXw00rryvcwLoYyWGLTKlRyj
 em731Gj1xsXZXcm5DsMN5YwBkxss7ixiDmkMPQUyuWCNS30B+TBUWZKqELUUvGIHppxiNx2Rw7
 ehz6MV95id8KYuBFVbevSFlYKRsaJroefh7/bP3PE84Vqxr9hGxKB18cbsrxPX3V6pi5LLniFo
 qy8MeCl2qZLwpVDdnezeluSzpylyPJ6LZwDp7SE7RFjj91qiIcnpz+5uZ/ImrjSaOsbEI111Rd
 XfHKzmxbEOactgES1Nv4fN03TLx+3iBnKAQAA
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

It turns out, it's just not worth to add bits to the core just for
hisi_sas_v2 driver. I dropped those changes.

BTW, this series is based on linux-block/for-next from 2024-11-11. Not
sure if this is the right base, if not please let me know which branch I
should use.

Original cover letter:

These patches were part of 'honor isolcpus configuration' [1] series. To
simplify the review process I decided to send this as separate series
because I think it's a nice cleanup independent of the isolcpus feature.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
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
base-commit: c9af98a7e8af266bae73e9d662b8341da1ec5824
change-id: 20240912-refactor-blk-affinity-helpers-7089b95b4b10

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


