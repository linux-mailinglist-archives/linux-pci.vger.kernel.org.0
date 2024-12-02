Return-Path: <linux-pci+bounces-17534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E415B9E06B2
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 16:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4DA7B3FBBC
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 14:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDF1204F62;
	Mon,  2 Dec 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vILuAv9k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E92040BB;
	Mon,  2 Dec 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148032; cv=none; b=jDd6LKy39uOkIIoYbpAixKhv0uI3oFwMJqQtrOFNY9mzk0HfwTGNLXzPNj0To4bYaXGSlKy2C1nPGGGp68AcrNBcMM6UZDm92YiVQFV+axewCOr/2B/b3H85qOBOmJ/oDqCttI9s5DIlgBbfuGuncse+8IQotHQx04IxX+735d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148032; c=relaxed/simple;
	bh=QwopfMBlIpOJKvr84RlumMLTnY5y/KlMMcdWguS43pQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BFKConL5LGBSM9oDZV1Xyhfxxr28zyjzxjg2PbN+0CDeBK2iZg5pjNjjaob5VPwGwyfBk9G24mHNJMK4Imy5OqwNa8haEMTNj+QW0lGGfukJbqbKI4Mu6bape/DZQONNwoKHZ7NC3tWx/jAn6V46YGN9OJ7KSmhIzbISlRk2zT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vILuAv9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E82C4CEDA;
	Mon,  2 Dec 2024 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733148032;
	bh=QwopfMBlIpOJKvr84RlumMLTnY5y/KlMMcdWguS43pQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vILuAv9kzZEUUbo+6bQQUIEj33xabc+2LPXE6xcQkvqMHgAH1aBdy133YS7lnQ3pS
	 K+w6AftighOsw6MS+9LjK1bZ3HSL8jweR9lZXIlSkTo26bG04HRjhKDx9Oij+ZUd7J
	 AesheAr3s/QFZE5BKlg2eMc51l/05nqFiGXMlZMvPhEX8g8EIyIyYei1t6q+khXwqJ
	 xTRlQlqKiHxMerLC1PkozpmEC1pAqP6/mB0DKw1MoYxSqvih78jjaB3LcgImkT+Ui6
	 EazyrShhcg612YOUxJCu4y2IMEQdXdQScRtVeneX+OQ6Wby5k2JrKsTnRiZW5vsicW
	 Bb7nC1Mn34Z0w==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 02 Dec 2024 15:00:10 +0100
Subject: [PATCH v6 2/8] PCI: hookup irq_get_affinity callback
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-refactor-blk-affinity-helpers-v6-2-27211e9c2cd5@kernel.org>
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
device. Hook this callback up for PCI based devices.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/pci/pci-driver.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 35270172c833186995aebdda6f95ab3ffd7c67a0..f57ea36d125d6eecfb60a6dc84d189cf9ed9b423 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1670,6 +1670,19 @@ static void pci_dma_cleanup(struct device *dev)
 		iommu_device_unuse_default_domain(dev);
 }
 
+/*
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


