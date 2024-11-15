Return-Path: <linux-pci+bounces-16896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C891E9CF1A7
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7D6288367
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0E41D5CD9;
	Fri, 15 Nov 2024 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+kekySO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9521D5CC2;
	Fri, 15 Nov 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688675; cv=none; b=CDoiK1/TWqJIq7TWuxgZS1IN/3Vqp3VrKVJ9Dmhc1mj63ae24N1VaLb3H/dvq714p/VtecZMN9rD2j4C4PrJQeV0BybyJEXHABOuFOSFOPBQdl3MNyUgPUdNHBwQMTQQbVz51k1ylMerpSLMEyiDDiNfvCtDaIJ8B9ubkCtbQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688675; c=relaxed/simple;
	bh=G+QXM0dP/aUGDDuORYwyj7yKPloC4FEoVkfEMuyp+Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uR2smdF5z+qqE1uPV/ZiSTl6c4Y2cM5wK1Ksrvf0azsWwgJ9IcIz4RAxe7ruH7ubmbZ5eZFcgd9nGWAMfpL9C66A0Z23ZJEh8I131jn02HIN/DfQ/8YjP/pyfyCZxZ35NINEuqoRf3hgq4Pmuf1h3jA8LAokkvMfgyd03As85mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+kekySO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC6EC4CED0;
	Fri, 15 Nov 2024 16:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688674;
	bh=G+QXM0dP/aUGDDuORYwyj7yKPloC4FEoVkfEMuyp+Xo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E+kekySOEOy+MjH3wlTA1i9haLjzgntIb4AgKxHTm/3SY8v8D1+t2paa+Hh7sYINs
	 taHvbn7qjSybthKq2gGRcNF4GbOIaoNZjQUIU4UGmvmT10QoGHFOZlheEtXGFQFUDX
	 wEusqWkCov8se2R+oXY2Azlfn4E4EClejwQFYvKAgYUJG5tT3ZTA/0CLITh89VsAXf
	 cG1dj+/C42YkDPVVgRJuDQ1ps72LjbgYacjSQoUyyKVkMOMQRtvrbFtzgFajt++0uY
	 OmZbGrE3fnZ+kuUUhR2zL6w6DL/tYzfXv9xwoZnhaBZXYtk7sFwe6eUcdBVkEntmpG
	 U65dRGgxgHC1w==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 15 Nov 2024 17:37:45 +0100
Subject: [PATCH v5 1/8] driver core: bus: add irq_get_affinity callback to
 bus_type
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-refactor-blk-affinity-helpers-v5-1-c472afd84d9f@kernel.org>
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

Introducing a callback in struct bus_type so that a subsystem
can hook up the getters directly. This approach avoids exposing
random getters in any subsystems APIs.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
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


