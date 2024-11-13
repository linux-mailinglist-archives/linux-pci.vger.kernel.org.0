Return-Path: <linux-pci+bounces-16660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CB49C738C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 15:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257532817E2
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5943B200C90;
	Wed, 13 Nov 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5gmVPGM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2337A200C82;
	Wed, 13 Nov 2024 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507992; cv=none; b=Lcw8TVP7OPrjfnDn5EBbl6CWIpyE0hAdMyLpF6M/pJ9SaWRBq556TDy2bJAuZtYv262aN7D9biHFJi/DUvCW/xK+GbyDMB/HKc/GNF5Z5aIS/SE0p55daOGNQtHxC8Ay8VfKVrlZlagiUht3Kibpq/r82kylCQTx4/8O14WsRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507992; c=relaxed/simple;
	bh=80LDPDpX9fi8j9wcH0xhw1xU3ocXiJTjjmEwdiRjBuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqzzV7Hk0/5+jfoDSKByrdHWHBLdi6jpYqmV4/NxO8kqtPDttNPb32B+4+7WYYyeyjrxqJUueosSJEIxawOlgYxjZNOxiKY6BxBRyiDZVpzms+ablS/ZTzDGQ//8cU9MiIjFD+j5vIV+IVD/tgiNLGZI1GxCjwxi5rJrHAcDw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5gmVPGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF306C4CEC3;
	Wed, 13 Nov 2024 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731507991;
	bh=80LDPDpX9fi8j9wcH0xhw1xU3ocXiJTjjmEwdiRjBuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q5gmVPGM5cZYvYsjszUPnVvC2YTs+vxd72MMdYs7VzgiwucoXKMZYWyNIBug1gLFc
	 3tVJ+3rte9AcGHpgunbV+WIrrjIFyTV8uPNBk1xzvvZGGriL3qfYAhC2G3hsBxXpb1
	 /tHNTz3B0MAsAJ1n7Cp6Df13/S+u2N8ogdI9DMqPSpEWEztftCfkbpsu5Ks+jKEDXJ
	 UTdi8t0o1BiPOByiyyf6TfvVKmS0zKd/nOIYANlS8DlmGJdAQ4yHlxYeriRYYqHgNR
	 wj7nSuuGLYoI99/JUYtsR4rh+wDa17Oda3bJYTMjFq2Hukld+zzBfkdO0W3Ntx8k3C
	 94mp34sGbuVBA==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 13 Nov 2024 15:26:15 +0100
Subject: [PATCH v4 01/10] driver core: bus: add irq_get_affinity callback
 to bus_type
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-refactor-blk-affinity-helpers-v4-1-dd3baa1e267f@kernel.org>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
In-Reply-To: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Introducing a callback in struct bus_type so that a subsystem
can hook up the getters directly. This approach avoids exposing
random getters in any subsystems APIs.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 include/linux/device/bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index cdc4757217f9bb4b36b5c3b8a48bab45737e44c5..b18658bce2c3819fc1cbeb38fb98391d56ec3317 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -48,6 +48,7 @@ struct fwnode_handle;
  *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
+ * @irq_get_affinity:	Get IRQ affinity mask for the device on this bus.
  *
  * @online:	Called to put the device back online (after offlining it).
  * @offline:	Called to put the device offline for hot-removal. May fail.
@@ -87,6 +88,8 @@ struct bus_type {
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
+	const struct cpumask *(*irq_get_affinity)(struct device *dev,
+			unsigned int irq_vec);
 
 	int (*online)(struct device *dev);
 	int (*offline)(struct device *dev);

-- 
2.47.0


