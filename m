Return-Path: <linux-pci+bounces-2651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B7783F804
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 17:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592CC1F238C5
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885B31420C2;
	Sun, 28 Jan 2024 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh/2DCXU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B9D1420BA;
	Sun, 28 Jan 2024 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458601; cv=none; b=XRn+1moMK0zPVUsIAjHJxSjoZmzSyF4Q8XU4/z1chbtCP/fjuiKSweqIlSjnozmoyMRzkjrYWJKiCK5hk6a5Xm0XVEc7UKxS0BJxB3sfGnddUkDJy6yTgUo3vrz8w7QBEuol7+w/Af+sgDh6dX8eOrC3zTwynGXmMYPmh8QRjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458601; c=relaxed/simple;
	bh=1TzxqmGFddfhzqSfSrIvvEKg5b+f+nUUuCyd9mP52VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l99AFmCU5cufqmF9suWgWuEmjvIhKzvT7f4ZV5t1PueddnQKlt7uRI5CGP0sH8UtEKPOMbU1V4MIyFey2m8eNR22M341II1E01r0JFBzrDJCAeb8W1+eJrQ3pV0MuYQ3W64Kihu/km35dhHo1J1ejpoTUDCc+wJvM80y/AQalnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh/2DCXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB72C43399;
	Sun, 28 Jan 2024 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458601;
	bh=1TzxqmGFddfhzqSfSrIvvEKg5b+f+nUUuCyd9mP52VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wh/2DCXUTuX6urhtIQ/SRXaseCPBd8myy7+uO83/kw6Kq7j01rUgsbihKLgkyczjY
	 r9sGDaRRqKndwAs0WScm9EOL7+aCMq6j7AUIz0cJg3piyJlx6wuEV+OLK/v7z6bcRu
	 UkGpZ8M8EtVTU+DjUGBaVfijbogH+XNihMLLOKJwVCHINXAzm8NaBBlDxrPCbKM2z7
	 R2IO61tuap/k5i2DgIyRwrYIdeDT0e4tEGq5Qn2NQb+/4R1pmgUO+W0mqK/kQe5TSU
	 LB1fT+FbGJTUtzq/K4YJ7HHDReh0ptiyMnEXC9LwBAUCQ+c+UzxXguRFAey5WuWV0L
	 9A+o46Mu3T6sg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Stodden <dns@arista.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Dmitry Safonov <dima@arista.com>,
	Sasha Levin <sashal@kernel.org>,
	kurt.schwemmer@microsemi.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 02/11] PCI: switchtec: Fix stdev_release() crash after surprise hot remove
Date: Sun, 28 Jan 2024 11:16:23 -0500
Message-ID: <20240128161637.205509-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161637.205509-1-sashal@kernel.org>
References: <20240128161637.205509-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
Content-Transfer-Encoding: 8bit

From: Daniel Stodden <dns@arista.com>

[ Upstream commit df25461119d987b8c81d232cfe4411e91dcabe66 ]

A PCI device hot removal may occur while stdev->cdev is held open. The call
to stdev_release() then happens during close or exit, at a point way past
switchtec_pci_remove(). Otherwise the last ref would vanish with the
trailing put_device(), just before return.

At that later point in time, the devm cleanup has already removed the
stdev->mmio_mrpc mapping. Also, the stdev->pdev reference was not a counted
one. Therefore, in DMA mode, the iowrite32() in stdev_release() will cause
a fatal page fault, and the subsequent dma_free_coherent(), if reached,
would pass a stale &stdev->pdev->dev pointer.

Fix by moving MRPC DMA shutdown into switchtec_pci_remove(), after
stdev_kill(). Counting the stdev->pdev ref is now optional, but may prevent
future accidents.

Reproducible via the script at
https://lore.kernel.org/r/20231113212150.96410-1-dns@arista.com

Link: https://lore.kernel.org/r/20231122042316.91208-2-dns@arista.com
Signed-off-by: Daniel Stodden <dns@arista.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/switch/switchtec.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 2c9c3061894b..0037f368f62b 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1082,13 +1082,6 @@ static void stdev_release(struct device *dev)
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
 
-	if (stdev->dma_mrpc) {
-		iowrite32(0, &stdev->mmio_mrpc->dma_en);
-		flush_wc_buf(stdev);
-		writeq(0, &stdev->mmio_mrpc->dma_addr);
-		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
-				stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
-	}
 	kfree(stdev);
 }
 
@@ -1131,7 +1124,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 		return ERR_PTR(-ENOMEM);
 
 	stdev->alive = true;
-	stdev->pdev = pdev;
+	stdev->pdev = pci_dev_get(pdev);
 	INIT_LIST_HEAD(&stdev->mrpc_queue);
 	mutex_init(&stdev->mrpc_mutex);
 	stdev->mrpc_busy = 0;
@@ -1165,6 +1158,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 	return stdev;
 
 err_put:
+	pci_dev_put(stdev->pdev);
 	put_device(&stdev->dev);
 	return ERR_PTR(rc);
 }
@@ -1407,6 +1401,18 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	return 0;
 }
 
+static void switchtec_exit_pci(struct switchtec_dev *stdev)
+{
+	if (stdev->dma_mrpc) {
+		iowrite32(0, &stdev->mmio_mrpc->dma_en);
+		flush_wc_buf(stdev);
+		writeq(0, &stdev->mmio_mrpc->dma_addr);
+		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
+				  stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
+		stdev->dma_mrpc = NULL;
+	}
+}
+
 static int switchtec_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
@@ -1464,6 +1470,9 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	dev_info(&stdev->dev, "unregistered.\n");
 	stdev_kill(stdev);
+	switchtec_exit_pci(stdev);
+	pci_dev_put(stdev->pdev);
+	stdev->pdev = NULL;
 	put_device(&stdev->dev);
 }
 
-- 
2.43.0


