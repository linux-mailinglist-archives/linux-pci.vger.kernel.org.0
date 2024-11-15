Return-Path: <linux-pci+bounces-16897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E079CF37A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 19:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 660EDB4315A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8393D1D63CF;
	Fri, 15 Nov 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTbph4s8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5F1D63C6;
	Fri, 15 Nov 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688677; cv=none; b=M/CcrYrrYZ+qbAVs2FKEAt7EnHGM2lmIyQ8+qMHQCWhvm1QkUAUgKu2Jn9ZS4v7hInkoiJ4h7uD5lJUy+4im7HMU9ISpLdGWlrvZmPnk11U3hSSdlNnZHOMWEeB2RINLx83wQgUb8pLjQDf9qFrpQWKH97fup5bB/WS8UqWArJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688677; c=relaxed/simple;
	bh=b3SULPoG7TV8R1Uq/VGS/o6LyNqWL9JV5NNkp2h0Sik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZI4pJrypOE2HpQmjhtNDGjM6ii4bB8L/yC9XrXvzXChNHqxXKT13srfyZLIHzRoEAWYVQlN/2cpLizxr1uLDjRrCuIz1+6bP4bi/3IeZXen2x0G8PxZDbdDC0N23EuIbBGtxHV0Mnfd4h1CXaN4nEjwgVjzaE2x48oaKhXpCqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTbph4s8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2B8C4CED5;
	Fri, 15 Nov 2024 16:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688677;
	bh=b3SULPoG7TV8R1Uq/VGS/o6LyNqWL9JV5NNkp2h0Sik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DTbph4s8r2YYm6XpOLpxDEG+pIi1dcJgbQwkP9r+Zngp08n26ZOADnmv92f0j85z4
	 JNGF/J/dpE1AD5cwgXP8qLnQ4ZywSjqMMohihayeBVnPJf48hkcR0SxaFwYgiyNe85
	 3YC8BBzhYRlazSVikpMbvUAGmeXY9OjEsQAHkPLMRq9efdbWznllS+VsjUv7EqJP0A
	 OaT1HwEv+fjsGGs4dkVkzJ1nt+QrLDhNZHMAlVFOATSOTgQAY24V+vLOrpzqEG6Emv
	 2oaT1J8BsdwiZ1wcghNFtVhCRIHeB/NWPL4s/j3Eid/fs0aASA/m3jbf7fvKHPDQU9
	 A0ejAc9RlCnxQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 15 Nov 2024 17:37:46 +0100
Subject: [PATCH v5 2/8] PCI: hookup irq_get_affinity callback
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-refactor-blk-affinity-helpers-v5-2-c472afd84d9f@kernel.org>
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

struct bus_type has a new callback for retrieving the IRQ affinity for a
device. Hook this callback up for PCI based devices.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/pci/pci-driver.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 35270172c833186995aebdda6f95ab3ffd7c67a0..a9cb0e3ad2e6eca58c34683303b1242228e96909 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1670,6 +1670,19 @@ static void pci_dma_cleanup(struct device *dev)
 		iommu_device_unuse_default_domain(dev);
 }
 
+/**
+ * pci_device_irq_get_affinity - get IRQ affinity mask for device
+ * @dev: ptr to dev structure
+ * @irq_vec: interrupt vector number
+ *
+ * Return the CPU affinity mask for @dev and @irq_vec.
+ */
+static const struct cpumask *pci_device_irq_get_affinity(struct device *dev,
+					unsigned int irq_vec)
+{
+	return pci_irq_get_affinity(to_pci_dev(dev), irq_vec);
+}
+
 const struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
@@ -1677,6 +1690,7 @@ const struct bus_type pci_bus_type = {
 	.probe		= pci_device_probe,
 	.remove		= pci_device_remove,
 	.shutdown	= pci_device_shutdown,
+	.irq_get_affinity = pci_device_irq_get_affinity,
 	.dev_groups	= pci_dev_groups,
 	.bus_groups	= pci_bus_groups,
 	.drv_groups	= pci_drv_groups,

-- 
2.47.0


