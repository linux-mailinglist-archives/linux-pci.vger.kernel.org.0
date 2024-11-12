Return-Path: <linux-pci+bounces-16527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03189C59D0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 15:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F0FB2582C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 13:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08F7145B3F;
	Tue, 12 Nov 2024 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2eY277K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F9B143C4C;
	Tue, 12 Nov 2024 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417994; cv=none; b=UN4t61BoNvIZ/Qr45uCq9jN05qcE6gzTurzhpWkSi4kn5/w4KsitjMkZZwN9l3K0ZmQgcV/wFWRRX9AdRzUlUtn6RMQNWez5n5rhJ2ZgIIbVQnvjthOQf9MIRW4qLLXXk5YvsfbzDuS0/WdU7SiHJ0t7eYBBv/9ktBmKX/6p+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417994; c=relaxed/simple;
	bh=sqDWvlYnzmw5LmAND0lJq+irtLs9bjKycO9yQSXxH7o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n4sip+i9gmbqgSsJQ0tlsE6R6gE+fPDCU/R9sG79Xp/aBjx2AeIi22LP1SxmJuohJ6egYmiqtHdygMNvmfFu765cN0rjMQGt7lKWPeXPQ+ZLH2k0v7e8LHl/LC39JKRZKkh9Ye09dehPEaP2+PH8E/FZukw5XjPRBei08ggfgbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2eY277K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778D0C4CED0;
	Tue, 12 Nov 2024 13:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731417993;
	bh=sqDWvlYnzmw5LmAND0lJq+irtLs9bjKycO9yQSXxH7o=;
	h=From:Subject:Date:To:Cc:From;
	b=u2eY277K1Z+ejda+K3q64uVaWGIanQ+OQOkOviyw8rNIM+nuh6K9X8/wOTsCX3IT5
	 U4grL2kpat1CYVn+deagHXvhrq0Hw7tJ7XgdRSojsEs1R+jQR52KqWMt8wDhMYOCld
	 OcVCuVF7k426B1dSXuhiLR/hHcRhOAo6T/iN8psTkF+SAVeQ6PNnNovv6VgT/v/KZR
	 ERtvj4WPMENMTOfefcps47JoqqoGW0Nr6qiVzoM0F6mi2H4TDm9UDVQjE8NWtCceVv
	 oKYcBw+C9Bou+L1IwAd8WRr5zeR1bm+Rxe0lsSAlOEfGZqp5dl6LDg+qqLTBYADLzY
	 04JDH+5ZHtcMw==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v3 0/8] blk: refactor queue affinity helpers
Date: Tue, 12 Nov 2024 14:26:15 +0100
Message-Id: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHdXM2cC/4XOTQ6CMBAF4KuQri3pDwi44h6GRUun0EgAW2gkh
 LtbMOqS2b3J5HuzIgfWgEO3aEUWvHFm6EPglwjVregbwEaFjBhhCSkowxa0qKfBYtk9sNDa9GZ
 acAvdCNbhjOSFLFKZSEpQMMZwbl6Hf68+2cJzDjXTf9kaF8Dl+MHTffut4yd1nmKCcyBprrNMa
 MpKNzuIFaDd9exn0TBnFguW5leilFCMU1E+wPbQxYNtULVt2xsamRUELAEAAA==
X-Change-ID: 20240912-refactor-blk-affinity-helpers-7089b95b4b10
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

As suggested by Christoph I've dropped the special case for hisi_sas v2,
so the open coded loop will stay. That means for the isolcpus patches, I
just need to open code that thing there as well. But overall, this should
be okay and it avoids adding a wierd interface to blk-mq APIs.

Original cover letter:

These patches were part of 'honor isolcpus configuration' [1] series. To
simplify the review process I decided to send this as separate series
because I think it's a nice cleanup independent of the isolcpus feature.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
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
      blk-mp: introduce blk_mq_hctx_map_queues
      scsi: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      nvme: replace blk_mq_pci_map_queues with blk_mq_hctx_map_queues
      virtio: blk/scsi: replace blk_mq_virtio_map_queues with blk_mq_hctx_map_queues
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


