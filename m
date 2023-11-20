Return-Path: <linux-pci+bounces-1-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8415A7F2185
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 00:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C6C2811FB
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 23:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8029538F95;
	Mon, 20 Nov 2023 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iRk6psZ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33955C7;
	Mon, 20 Nov 2023 15:40:35 -0800 (PST)
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4C5EF20B74C0;
	Mon, 20 Nov 2023 15:40:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4C5EF20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700523634;
	bh=kBNKNTOrMmmpmm92m7K9B/lNmOkmW5YxSpr4SlRmJSU=;
	h=Subject:From:To:Cc:Date:From;
	b=iRk6psZ1bwoNZfgS9az/eot+ankMIak28Fo+cDfzEmWQSHUUEzYWtV/XNvoId2DVW
	 eEHmDnIkXfNAat1XGSmHQNdb7EuQesbEESVmDF84wT/pKSJN2yKhxjQXQD/s7Igo7+
	 B+cAlTFhs5XLZsZRBVLvq6ueJnm3ywkbiOQ0aVAM=
Subject: [PATCH] PCI: mediatek: Fix sparse warning caused to virt_to_phys()
 prototype change
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: ryder.lee@mediatek.com, jianjun.wang@mediatek.com, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: skinsburskii@gmail.com
Date: Mon, 20 Nov 2023 15:40:33 -0800
Message-ID: <170052362584.21270.8345708191142620624.stgit@skinsburskii.>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Explicitly cast __iomem pointer to const void* with __force to fix the
following warning:

  warning: incorrect type in argument 1 (different address spaces)
     expected void const volatile *address
     got void [noderef] __iomem *

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/pci/controller/pcie-mediatek.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 66a8f73296fc..27f0f79810a1 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -397,7 +397,7 @@ static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	phys_addr_t addr;
 
 	/* MT2712/MT7622 only support 32-bit MSI addresses */
-	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
+	addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
 	msg->address_hi = 0;
 	msg->address_lo = lower_32_bits(addr);
 
@@ -520,7 +520,7 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	u32 val;
 	phys_addr_t msg_addr;
 
-	msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
+	msg_addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
 	val = lower_32_bits(msg_addr);
 	writel(val, port->base + PCIE_IMSI_ADDR);
 



