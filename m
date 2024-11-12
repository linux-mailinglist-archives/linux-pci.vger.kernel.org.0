Return-Path: <linux-pci+bounces-16529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782019C59F1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 15:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB905B3D6A5
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 13:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA29615D5C1;
	Tue, 12 Nov 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF8qYi2p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BE0157494;
	Tue, 12 Nov 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418000; cv=none; b=RJEPtsEV5wkZWEkCsiVxty52vgV9mdDJK00HJF5JFiHvaUCngnf2z/ZSn7T3J3cNsBNNXfmwzTcB7323ixYNElDxWrxB8NO8ytFtaJI1W8JryVPT5PW/phm0VJzv4u+oYJLHGMIUuWp0thrfR/ZW2VGo9QUVpDFuMWLyuMxEm8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418000; c=relaxed/simple;
	bh=8c9yRiNz5l6j6ma+lUrUvRBWbUG9fNcB/XLsfuWbhOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gCFK991NUJrMeg40hxqHMZ8EtyUqEKjwEuNRVZXmTovRt1UBLjaTADuY5CvdcQFPLVeYe1zLUXEPh0Ag4a/xwzLC5FWn19rBG1iNlbjBcXizsv6AhZxuTSe7FZsDLu9yvuoSe7NrHz1jfZ7jL6fGh4nVCHKnbhP4t5d4JzrWW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF8qYi2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4ADC4CED5;
	Tue, 12 Nov 2024 13:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731417999;
	bh=8c9yRiNz5l6j6ma+lUrUvRBWbUG9fNcB/XLsfuWbhOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WF8qYi2pzIBf0y54sQH9lmK5MdgbBym3p6VgwVSB9az4eQJUNihiXZHYuvpA0nkOk
	 7R3spOcB97zvmUjmb3PmSTgPqDRMIFAHMYd5LgfyJiJeb4FgtmKu6HVLQhHodUW7PJ
	 JRDX8f+b3Uk/hJUHu7Cr6xD5NaT5+QR7rmDceoBlEf2SGDmLcxyCcDN0bFxMwGLPWY
	 Qvq1cQf6sDzCO/kBTKVhy9fFXSPe7dTezWSBH9Sm8LpuIwienLYv5kEgefnxsxpUL3
	 QrvsIDCfvVK6GcBYlTxoQCPGePETggQ2sggtwivfG6rPTT+FurgcrgVXLI5vx6AS5N
	 kP2uno8dbV+6A==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 12 Nov 2024 14:26:17 +0100
Subject: [PATCH v3 2/8] PCI: hookup irq_get_affinity callback
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-refactor-blk-affinity-helpers-v3-2-573bfca0cbd8@kernel.org>
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
device. Hook this callback up for PCI based devices.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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


