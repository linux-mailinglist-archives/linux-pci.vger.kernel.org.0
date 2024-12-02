Return-Path: <linux-pci+bounces-17535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F3A9E045B
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 15:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61941B61B7A
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4806A204F92;
	Mon,  2 Dec 2024 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvqUQ/VS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EBB202F99;
	Mon,  2 Dec 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148036; cv=none; b=QyNZEP2ltNVIVv3aKZxRzdfm+f21R2d/hEmmtcZYHQAhnd7kAqAgtq2skiuxW9K3WoT6n0kWgKP4Px/IRdmCe3Dend8w+Gr4cs/sKJRqo3sGZ2OBFIfecFT87h9iwUcuk4ihQK4neVC1drVnX2Hj+k/IHwZ/OVo2SazRr6HAH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148036; c=relaxed/simple;
	bh=5fZ7EXrytyCpiro/tG84vBDeaW3vHOORuXZTueXikB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mav9nJS1BovBWi7wiSKeWxvwMObNootxFOTeSChgjHV8Yi5sr4hiGgVd2yim2jN7/QM9J6L5FO/iRaSawKqcXM5Du33GvTB6md94lq4BCXG/vdldhWF+Vv75/zvJa8b1Ew0w5N2YE0N5LQXMl+KnWx0+vuqyzsrgTKNdzaWw8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvqUQ/VS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46828C4CED6;
	Mon,  2 Dec 2024 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733148034;
	bh=5fZ7EXrytyCpiro/tG84vBDeaW3vHOORuXZTueXikB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bvqUQ/VS7hBSvNuY72vN7+D0BNoN1TYVsmReR+ugpZ4Mdb0jYb0ej/7yV7eOIyCOz
	 2vyGFHAq0Cp/KXp1N9aqU3fXXWqskEoP38lTPnAdwSbbjcXqNphjqbl8r453fSPfOn
	 2DSrFBiob05SZceAGX5gsWZYN8itXF0LNXYrt6kEwu/nezlxS4kiauOD1E4Rth0y5t
	 WO91U46MtvVHWmKMzWBfIUz4tXR2CzppISi5iWHYCQyc4tq26wsRcWAbXCWt3HA1hI
	 7mgyXBzHAmrZLF1iDjC50pvxQUvECe77FVv3jVC+Ag3fE0gvIDmMUEJkna7eFzV+NC
	 dZnqbKSfrQg/Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 02 Dec 2024 15:00:11 +0100
Subject: [PATCH v6 3/8] virtio: hookup irq_get_affinity callback
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-refactor-blk-affinity-helpers-v6-3-27211e9c2cd5@kernel.org>
References: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
In-Reply-To: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
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

struct bus_type has a new callback for retrieving the IRQ affinity for a
device. Hook this callback up for virtio based devices.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/virtio/virtio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b9095751e43bb7db5fc991b0cc0979d2e86f7b9b..b10ed9f5b5435ae0bf7ab52a6519a7fdc4d5920d 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -377,6 +377,24 @@ static void virtio_dev_remove(struct device *_d)
 	of_node_put(dev->dev.of_node);
 }
 
+/*
+ * virtio_irq_get_affinity - get IRQ affinity mask for device
+ * @_d: ptr to dev structure
+ * @irq_vec: interrupt vector number
+ *
+ * Return the CPU affinity mask for @_d and @irq_vec.
+ */
+static const struct cpumask *virtio_irq_get_affinity(struct device *_d,
+						     unsigned int irq_vec)
+{
+	struct virtio_device *dev = dev_to_virtio(_d);
+
+	if (!dev->config->get_vq_affinity)
+		return NULL;
+
+	return dev->config->get_vq_affinity(dev, irq_vec);
+}
+
 static const struct bus_type virtio_bus = {
 	.name  = "virtio",
 	.match = virtio_dev_match,
@@ -384,6 +402,7 @@ static const struct bus_type virtio_bus = {
 	.uevent = virtio_uevent,
 	.probe = virtio_dev_probe,
 	.remove = virtio_dev_remove,
+	.irq_get_affinity = virtio_irq_get_affinity,
 };
 
 int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)

-- 
2.47.0


