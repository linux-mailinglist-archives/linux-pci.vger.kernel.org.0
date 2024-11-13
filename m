Return-Path: <linux-pci+bounces-16661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BA09C74C4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 15:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD2FB364DC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5058F201276;
	Wed, 13 Nov 2024 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpZ2ihZj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E27C20125A;
	Wed, 13 Nov 2024 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507994; cv=none; b=MHl2BAAUKIMlkuiumuKGgK0G0dKZhft+kWiAxBuLGZRG9B8c+G2vG8oH1V3SQX6qaHyy7w0OuXkpAh2TvKsM/DxYTHuHSUtak52AbmD5HJaUMQiqy5HWpyYMOSveF1sqQkn03w6YugRntmPkt+sB/rx+9lna0JCliiezcgDtimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507994; c=relaxed/simple;
	bh=75UYmyTYuXcBh21qnxL8a7xEYVI0TRKMVuk8+5dIe0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GPQzYakJaUTClkdOk3+Ofgg/yfd4honGHY5XuwOhK7o+DGLNc5M5NJefAIP30SMt2LghUv8J0RaF9LijKgn9qc4mI4FY0L///4hfcH6aYz56zdOC10GusDqjEJbnguli3462L89O4TPiNKNbUfM0JsA7QPIZU13BXS8H1BJDA4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpZ2ihZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528C6C4CEC3;
	Wed, 13 Nov 2024 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731507993;
	bh=75UYmyTYuXcBh21qnxL8a7xEYVI0TRKMVuk8+5dIe0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZpZ2ihZjYywFiKV3/cRgPCdS8RYQSWApYb62AnXJE2Lzxj3NQum7QCIZxYW4Mq43s
	 e2P2YpmeHIV5S7vXbe5vc/dLKC4Uz5h9pxIXwAn8DPkxWDrwUSKnQJ6Dtg3/p/rtbv
	 A0QsZyQbD47QweEnMeYYeOYdSqzsDOO9P9sUdHZ7XbN23LqMt09unrh9tX7lNfAY9v
	 XwWXExgqJSRb7JPHFmY3UWp81lrebBnhfNMFRArM+It13Twy7Z18+UdieImjU+z6Vs
	 ltul7jBybBHLjfOL7bWCjvy70Lt395urjLj3o1aS/eLJ7Up7e747yTUO+1Bgs0s3vE
	 F6Xi7QwqUO0Iw==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 13 Nov 2024 15:26:16 +0100
Subject: [PATCH v4 02/10] driver core: add irq_get_affinity callback
 device_driver
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-refactor-blk-affinity-helpers-v4-2-dd3baa1e267f@kernel.org>
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

Introducing a callback in struct device_driver so that a device driver
can hook up the getters directly. This approach avoids exposing random
getters in drivers.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 include/linux/device/driver.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 5c04b8e3833b995f9fd4d65b8732b3dfce2eba7e..0d1aee423f6c076ae102bdd0536233c259947fac 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -74,6 +74,7 @@ enum probe_type {
  * @suspend:	Called to put the device to sleep mode. Usually to a
  *		low power state.
  * @resume:	Called to bring a device from sleep mode.
+ * @irq_get_affinity:	Get IRQ affinity mask for the device.
  * @groups:	Default attributes that get created by the driver core
  *		automatically.
  * @dev_groups:	Additional attributes attached to device instance once
@@ -112,6 +113,8 @@ struct device_driver {
 	void (*shutdown) (struct device *dev);
 	int (*suspend) (struct device *dev, pm_message_t state);
 	int (*resume) (struct device *dev);
+	const struct cpumask *(*irq_get_affinity)(struct device *dev,
+			unsigned int irq_vec);
 	const struct attribute_group **groups;
 	const struct attribute_group **dev_groups;
 

-- 
2.47.0


