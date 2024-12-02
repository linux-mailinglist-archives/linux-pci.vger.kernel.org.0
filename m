Return-Path: <linux-pci+bounces-17533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14029E0434
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 15:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB901679D3
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 14:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCD820370C;
	Mon,  2 Dec 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gihYJs6s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534A203704;
	Mon,  2 Dec 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148029; cv=none; b=mBCgZbdS8S4mT1CaiDNuPGinUx8KPaqoXFQKT7Ru1Qk+Fn8h9g/AtWVbwTRq6FuaCdc3bAiyIpxFstnBqUqmKoEmzx+QFI7YD/vC1IknGOO5KuDmkgBXYWILrl1Pij8+ZMNlZ2AYA8TQbKJs1lGavusyRiHR5gVcThYCDnRbnE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148029; c=relaxed/simple;
	bh=Xnjsn5CeW974ObCQuqa0Z+CwPGGhRk0jK5nChV5JWhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qIIrQT/v6LxPUqtgC2IteqS422kRynwq0MCkU5Vx2u00ZBIGq+l78atDSR7ODgRyWMdWRS39WMARnCStL39XR0zEjwIddKd4rM4UWIErzJEY15dpnLDBy9rZkgfAtGAjg2qsVjkYB8TNw8S0TY92oyUsnQGCUdD+bfQEljmDef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gihYJs6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186D2C4CEDE;
	Mon,  2 Dec 2024 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733148029;
	bh=Xnjsn5CeW974ObCQuqa0Z+CwPGGhRk0jK5nChV5JWhY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gihYJs6sH7FsUEhZ3dC//xkdgTQZEZbG7ECwDNLCsp+1vwwn3L1qyEARC5IajXlRS
	 k/Ij4ocvkgn/mwbu6I9aCr1n6U3p6br1g8/VIZp8Ik+DwO7qxB0Y8djvLO2rKHMZdz
	 Rs5ZemFdzb5wtsiY7rpcpGMi86imiZP1CUCyHDVqIGSQMQIiyJ8xa/ExCoY51MU01z
	 B3Jh4+amo328tKSoSKYQzrGD44+RvZ8hb4AT5RbfyyghHV57B3/Pr4fJzSW5tzQd3M
	 C5fCVO/lB3e4or3al7+CQ/jbVcXN08NYb2WaeXVCfRLzzajbgJq34JRUs16b6n2bYq
	 f80Oqmiwo5Wxg==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 02 Dec 2024 15:00:09 +0100
Subject: [PATCH v6 1/8] driver core: bus: add irq_get_affinity callback to
 bus_type
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-refactor-blk-affinity-helpers-v6-1-27211e9c2cd5@kernel.org>
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

Introducing a callback in struct bus_type so that a subsystem
can hook up the getters directly. This approach avoids exposing
random getters in any subsystems APIs.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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


