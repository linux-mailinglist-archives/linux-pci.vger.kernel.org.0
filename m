Return-Path: <linux-pci+bounces-36548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E096B8B9E5
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 01:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025E21C20E6F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 23:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5823D27CCF3;
	Fri, 19 Sep 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lIrIa7M5"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6742AD24;
	Fri, 19 Sep 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323628; cv=none; b=jdNrvv1r0focrWxQ/iPBSZ6MbVaYdHmnmbg1i2vJZ9AZHuvvlgsC+BikmOOA1Y5ra6bk0xTOwqnitRWcZGxT0qh70lKESv4P66TVzk/Dp/bNXR1x+eI1crC1U6z6xjvHZMgEkJ2XSuHXXziT2Tj1o8PixrohBghINAy/IETnm/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323628; c=relaxed/simple;
	bh=fKWqEXm+bV6JD3TcSIbfJhfnABvxJkTMRf/Bj+lcaRA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iQJC0R9NmvIPfGHVD0uTZuukiOVRzSoKT/zB5z3qopziOA49ZJH6b8d08pY1L7z0VeUyGwTXx+txCcxg7pKJscUL0UHpc6iIc2PmS4Fs8m77W0oR835cy9YNJy5Ma41WkpZIWGyXAss532TJO3qJZmVoeMf6lfTOtpmQnxqUzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lIrIa7M5; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758323626; x=1789859626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KfKALAbjgmpFUExvcy5RcZ+OJFmwCOtZwZQBuvDSCqI=;
  b=lIrIa7M5Qn7C2fA6o7EIK7E/eSgd8rsxxA4iQWs82oVStsV/gXOX9Rbu
   USD0j9zrCABL3Bh9P9kIUqYFqo4dLN0TDs7jcsIx7YmGh7hd1viTYWCOI
   XECcu1W1DFHnKi80E8HZQhVbfvsRt96Fl0uQVs5gFc1F0L4wI11sYU8i4
   mjVDQm017T2Naj2Lhj8QvMl/cyl8AhdFoeqb+Urrc4ZxXiXHJOBY/AP2Q
   JFbYOVz7ls2hJ6wnuV/YYJTcDIPnctJKMHqZuGkQfmEH6C5VUAs94B9Ks
   SJYQtwGpmsqYcEL5i6pxk49WZoXEMq4PUhTfORpKYx7QhX0QlTLZPS16E
   w==;
X-CSE-ConnectionGUID: svCWeSlkSVC/dSz++PPR0A==
X-CSE-MsgGUID: h8bxUliVSJGGD7+tUhRflA==
X-IronPort-AV: E=Sophos;i="6.18,279,1751241600"; 
   d="scan'208";a="3213750"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 23:13:46 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:10324]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.53:2525] with esmtp (Farcaster)
 id e14a9c00-d7d3-4833-b24c-5d2c4ebae526; Fri, 19 Sep 2025 23:13:46 +0000 (UTC)
X-Farcaster-Flow-ID: e14a9c00-d7d3-4833-b24c-5d2c4ebae526
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 19 Sep 2025 23:13:45 +0000
Received: from dev-dsk-ravib-2a-f2262d1b.us-west-2.amazon.com (10.169.187.85)
 by EX19D032UWA003.ant.amazon.com (10.13.139.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 19 Sep 2025 23:13:45 +0000
From: Ravi Kumar Bandi <ravib@amazon.com>
To: <lpieralisi@kernel.org>, <mani@kernel.org>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
CC: <kwilczynski@kernel.org>, <robh@kernel.org>, <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: xilinx-xdma: Enable legacy interrupts
Date: Fri, 19 Sep 2025 23:13:30 +0000
Message-ID: <20250919231330.886-1-ravib@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D032UWA003.ant.amazon.com (10.13.139.37)

Starting with kernel 6.6.0, legacy interrupts from PCIe endpoints
do not flow through the Xilinx XDMA root port bridge because
interrupts are not enabled after initializing the port.

This issue is seen after XDMA driver received support for QDMA and
underwent relevant code restructuring of old xdma-pl driver to
xilinx-dma-pl (ref commit: 8d786149d78c).

This patch re-enables legacy interrupts to use with PCIe endpoints
with legacy interrupts. Tested the fix on a board with two endpoints
generating legacy interrupts. Interrupts are properly detected and
serviced. The /proc/interrupts output shows:
[...]
32:        320          0  pl_dma:RC-Event  16 Level     400000000.axi-pcie, azdrv
52:        470          0  pl_dma:RC-Event  16 Level     500000000.axi-pcie, azdrv
[...]

Signed-off-by: Ravi Kumar Bandi <ravib@amazon.com>
---
 drivers/pci/controller/pcie-xilinx-dma-pl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index b037c8f315e4..cc539292d10a 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -659,6 +659,12 @@ static int xilinx_pl_dma_pcie_setup_irq(struct pl_dma_pcie *port)
 		return err;
 	}
 
+	/* Enable interrupts */
+	pcie_write(port, XILINX_PCIE_DMA_IMR_ALL_MASK,
+		   XILINX_PCIE_DMA_REG_IMR);
+	pcie_write(port, XILINX_PCIE_DMA_IDRN_MASK,
+		   XILINX_PCIE_DMA_REG_IDRN_MASK);
+
 	return 0;
 }
 
-- 
2.47.3


