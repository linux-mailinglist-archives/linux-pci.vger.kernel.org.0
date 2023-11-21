Return-Path: <linux-pci+bounces-2-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE047F21E8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 01:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966D12829A1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 00:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09BB184;
	Tue, 21 Nov 2023 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O45wvQ3v"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF0379E;
	Mon, 20 Nov 2023 16:01:57 -0800 (PST)
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1FACF20B74C0;
	Mon, 20 Nov 2023 16:01:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FACF20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700524917;
	bh=LbrVvLvyLjW1PVT2QUs7hez6cFIiMaOwkqYMRmollso=;
	h=Subject:From:To:Date:From;
	b=O45wvQ3vvuq9iNaS0teRoPVL7nECUXTI70YwQLreF0959qLn7RV5tpYl49RKuREOP
	 5NY6F2gksTgl+aOZ1/EVXWivqWkJA3l1AB8AL+QYYO7hOS+2oSTwYD1lJj2NmKDw6m
	 pco2+BMxjqKBdPxU7p+o+cWUSRZNpYfxxxMHIlUk=
Subject: [PATCH v2] PCI: mediatek: Fix sparse warning caused to virt_to_phys()
 prototype change
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: ryder.lee@mediatek.com, jianjun.wang@mediatek.com, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Mon, 20 Nov 2023 16:01:56 -0800
Message-ID: <170052491316.21557.13173111699965824301.stgit@skinsburskii.>
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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311161120.BgyxTBMQ-lkp@intel.com/
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
 



