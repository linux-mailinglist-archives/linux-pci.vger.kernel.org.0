Return-Path: <linux-pci+bounces-11239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12529946BE9
	for <lists+linux-pci@lfdr.de>; Sun,  4 Aug 2024 03:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894E7281139
	for <lists+linux-pci@lfdr.de>; Sun,  4 Aug 2024 01:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307DC370;
	Sun,  4 Aug 2024 01:24:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B8D23B0
	for <linux-pci@vger.kernel.org>; Sun,  4 Aug 2024 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722734669; cv=none; b=NFYmZR2Ci+Dsp7Pz3FaiwkKH/NjDL9Yb5IMkc37M1HzOYyb9gji1x8l3lGt/fZZmsWRkeERAKhwGsk9XFwLXCGjPDRxcL5T5nZ8nOz/XjvqAXINeonD3++Q+cr7E0Ge0xiA0CIuJzQWR6aDKTIjmtTEzxMWLSLQhPP03lJkIS7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722734669; c=relaxed/simple;
	bh=y2QFp8spbAGL6/JSqjnaSiIvVvjfGTx1aIp3voVAG20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JwrkLT7jcVGGRrhbY5iYl95+cIENUUB+vHOWcC9DCc2dtvdxQdH0becmCwPSMS+uVEsvhGaU79tDw6m7HrlZORlxLnvfW9eYQVpWWF98QdZJtRK77AMnpQj1BeI3cpqxUgsgGgA74eZQc8Kv4855kyKjBf2At8zUkJmPQK+O37A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6035CC116B1;
	Sun,  4 Aug 2024 01:24:26 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ming Wang <wangming01@loongson.cn>
Subject: [PATCH V2] PCI: Prevent LS7A Bus Master clearing on kexec
Date: Sun,  4 Aug 2024 09:24:18 +0800
Message-ID: <20240804012418.2630238-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is similar to commit 62b6dee1b44a ("PCI/portdrv: Prevent LS7A Bus
Master clearing on shutdown"), which prevents LS7A Bus Master clearing
on kexec.

The key point of this is to work around the LS7A defect that clearing
PCI_COMMAND_MASTER prevents MMIO requests from going downstream, and
we may need to do that even after .shutdown(), e.g., to print console
messages. And in this case we rely on .shutdown() for the downstream
devices to disable interrupts and DMA.

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


