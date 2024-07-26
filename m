Return-Path: <linux-pci+bounces-10830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E374693D068
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 11:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F711C2111A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 09:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862A4176AA2;
	Fri, 26 Jul 2024 09:28:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E1A3D
	for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721986137; cv=none; b=nhSVQ0pF8pKUeA5HiS6l+Oz45VNAF6jOrR4kg+0oX4Zo/TbLoj1f94nA9ghfA++Lo0NDQnhiGSKfbP9IPYeiIRUq6jeM+o2yYM6QMH/vaimMpm34OaZiVtBbYS/4htyhxqTu5vKm6tEtKU3saDsNDRS5GlcRKwkyfHMASw0MV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721986137; c=relaxed/simple;
	bh=6xGypHD6rib3GM9huVk1wxq1KqCd98TxkhX6q3gKh2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rqHAxIBGWqfvOd+gg1fIOLpErAIJm8jRINjgnsL3vjwcZ5zkIhKo8fxM1ofqNwmrGHhICdG0Jy/IQkElWjPL4sirm8Qlv5kuoF6qaEhpxTOIs4At2rgNuT3tvTbM4UXFPQUMaau2pB/sYbypI9qvkSF5uxaa3Zw7xaCYLbuPjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEBAC32782;
	Fri, 26 Jul 2024 09:28:54 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ming Wang <wangming01@loongson.cn>
Subject: [PATCH] PCI: Prevent LS7A Bus Master clearing on kexec
Date: Fri, 26 Jul 2024 17:28:29 +0800
Message-ID: <20240726092829.2042624-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is similar to commit 62b6dee1b44aa23b39355 ("PCI/portdrv: Prevent
LS7A Bus Master clearing on shutdown"), which prevents LS7A Bus Master
clearing on kexec.

Only skip Bus Master clearing on bridges because endpoint devices still
need it.

Signed-off-by: Ming Wang <wangming01@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f412ef73a6e4..b7d3a4d8532f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -517,7 +517,7 @@ static void pci_device_shutdown(struct device *dev)
 	 * If it is not a kexec reboot, firmware will hit the PCI
 	 * devices with big hammer and stop their DMA any way.
 	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
+	if (kexec_in_progress && !pci_is_bridge(pci_dev) && (pci_dev->current_state <= PCI_D3hot))
 		pci_clear_master(pci_dev);
 }
 
-- 
2.43.5


