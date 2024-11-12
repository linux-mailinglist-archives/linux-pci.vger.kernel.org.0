Return-Path: <linux-pci+bounces-16530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8C79C58F3
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 14:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C221F22761
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0441632F9;
	Tue, 12 Nov 2024 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2MuZjka"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C01632EE;
	Tue, 12 Nov 2024 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418002; cv=none; b=pIhDcr3SycIvzSk/ArgOESQOlYml+ofi01t7oAK3F5ldOPGdQ6SUzSjpZkIzIgeUEDDXaucUNW7qgSvEw0bOBWbCOMfay94U04O+pqs1C8OEvI0fgM0o3WtsQ+Jki2vTZrFI5yBfzDqvDa3SpddhVtEOSsgKP3FxO8XUr4SPn2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418002; c=relaxed/simple;
	bh=WzzdcfvW/fxEt9HmIi8FFjH8HF/HHHnW11D3o4S59RY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KAayAYjzC7PTf9AX0rI+MrL3zlsUPmXZWhb8LFbkqgwU8WpmCkQQGg9+2qzTjLIreaN04wG6KocEPvB5w/xuS4pWBFFtB2lI3Q0LNVBBpB+mQWKb0ysJVOuvwXz0kt5aMhi5dxCTdzzKPGOMjwKDDHNyfSovBfq2wEPOwe/V264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2MuZjka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F24C4CEDA;
	Tue, 12 Nov 2024 13:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731418001;
	bh=WzzdcfvW/fxEt9HmIi8FFjH8HF/HHHnW11D3o4S59RY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o2MuZjkaF69JbVoKSJRODwxcWDuZ7Of09DKzNyycoFpo6ok7x6GbhDhHUHWoVjuMV
	 SggGGc8hgHPgF8b7nCIPC1oAElQHtAL6HxOpm25vhHRBk3dcwHLgF8S+gb4kXnLYzw
	 eE3tinRurbLW40itCmvskntngcX/y4x+iGvKhMXlHawS1OXO0is01KSaFI+I7NkXwc
	 nzAfM/rEpaWZjzeECqdJ3vt2qnAV3H1P41E+D61FLOOimJPdCZy0xwE+7nEZIJqw8+
	 RnlxW9PDZLq4pM6BMf6eFmEBKmqwYHo2LHHeViPDOmJNPHhPhciL4yhkwy6fqZOlDh
	 uRMpKBRnD+7Gw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 12 Nov 2024 14:26:18 +0100
Subject: [PATCH v3 3/8] virtio: hookup irq_get_affinity callback
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-refactor-blk-affinity-helpers-v3-3-573bfca0cbd8@kernel.org>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
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

struct bus_type has a new callback for retrieving the IRQ affinity for a
device. Hook this callback up for virtio based devices.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/virtio/virtio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b9095751e43bb7db5fc991b0cc0979d2e86f7b9b..7774aecdfe52d4dce11eb77e43864981a2e2b2bb 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -377,6 +377,24 @@ static void virtio_dev_remove(struct device *_d)
 	of_node_put(dev->dev.of_node);
 }
 
+/**
+ * virtio_irq_get_affinity - get IRQ affinity mask for device
+ * @_d: ptr to dev structure
+ * @irq_vec: interrupt vector number
+ *
+ * Return the CPU affinity mask for @_d and @irq_vec.
+ */
+static const struct cpumask *virtio_irq_get_affinity(struct device *_d,
+						     unsigned int irq_veq)
+{
+	struct virtio_device *dev = dev_to_virtio(_d);
+
+	if (!dev->config->get_vq_affinity)
+		return NULL;
+
+	return dev->config->get_vq_affinity(dev, irq_veq);
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


