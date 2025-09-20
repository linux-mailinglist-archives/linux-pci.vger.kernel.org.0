Return-Path: <linux-pci+bounces-36601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E87B8D218
	for <lists+linux-pci@lfdr.de>; Sun, 21 Sep 2025 00:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FD87B11C5
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 22:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2401121579F;
	Sat, 20 Sep 2025 22:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lKBvlV+A"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C721CBEAA;
	Sat, 20 Sep 2025 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758408792; cv=none; b=puznnBMAy/4AVkdGBvbbXRF9RIcQEMOMWmAg6h+GnrzFiU1GEf87ikYiZUWkoCW6kwTcei3DVQXetPxDaN4faioXGKz4DsoMGmxdsf/FO1yaE0eWIdOKxu7N39TwgdpUEKn9+a3GU5B+bMLdKgdg1Hbxr5zWL+zPZR/ch1HakFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758408792; c=relaxed/simple;
	bh=NLG83zG4Iqi1Xyv2M3uzidymYz/T7neW8GLLEwTPTyw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ST5Hd9PwxjbfYhK5CB+u32ybM50JjSlG7xm3gf1f2wXfaxFN73jGt+IGr8i0Wq0Azm8Q0of2SwS9aGl07+tJ9zTRTC1JHc+iju31w39WTCOvg6HAfzFwj9FHXzuWeICjKPnxEE1Tz1bqNv2YKF7mUnrZUJkTQjMu/oCk+wxqgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lKBvlV+A; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758408790; x=1789944790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DbXAa8qTsxyq1mEKjnb+++zhRcJBDvgJFncuYVQDFFE=;
  b=lKBvlV+A0exj4eJ3TXKi6Ast3J3l9xMm6UfX+kC1p3bN0tzZtY8iDUTu
   bmIhXs6jcXdDEqj9BjsMbGyuUyjOSEy7jpZMHjr1vieKXeGdWHOim761m
   XVoJJDgk9QSkZ6uVR/2TmgmQnPPbNyo7GKc3xoYd1WDdNfCcNW4uGWXHm
   UaJmERE2J2IJLewgq8+4RNtE1LOh0RcQ2MrIy5SF+qmjSZtGmBSIJrvJv
   ICcIUqZ0KysWDdGcEyPL/OtrkX7XhZpRrsh+owURnOD49vUfHwE4rVHdy
   pBU9i8/0Eg1DJkUnfwuz/2oCZZXLK9jvH5eCN9FZQys9gVAGXkc7wtyYh
   g==;
X-CSE-ConnectionGUID: zMA0ONwqTy6JSTQNaePjXQ==
X-CSE-MsgGUID: 3Ci37821TSaw+QF3eJWciQ==
X-IronPort-AV: E=Sophos;i="6.18,282,1751241600"; 
   d="scan'208";a="3249959"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 22:53:10 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:4911]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.168:2525] with esmtp (Farcaster)
 id 920169d4-e150-49a4-9281-68b82a9564ae; Sat, 20 Sep 2025 22:53:09 +0000 (UTC)
X-Farcaster-Flow-ID: 920169d4-e150-49a4-9281-68b82a9564ae
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 20 Sep 2025 22:53:09 +0000
Received: from dev-dsk-ravib-2a-f2262d1b.us-west-2.amazon.com (10.169.187.85)
 by EX19D032UWA003.ant.amazon.com (10.13.139.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 20 Sep 2025 22:53:09 +0000
From: Ravi Kumar Bandi <ravib@amazon.com>
To: <mani@kernel.org>, <thippeswamy.havalige@amd.com>
CC: <lpieralisi@kernel.org>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<ravib@amazon.com>, <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Date: Sat, 20 Sep 2025 22:52:32 +0000
Message-ID: <20250920225232.18757-1-ravib@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <C47CF283-C0C4-4ACF-BE07-3E87153D6EC6@amazon.com>
References: <C47CF283-C0C4-4ACF-BE07-3E87153D6EC6@amazon.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D032UWA003.ant.amazon.com (10.13.139.37)

The pcie-xilinx-dma-pl driver does not enable INTx interrupts
after initializing the port, preventing INTx interrupts from
PCIe endpoints from flowing through the Xilinx XDMA root port
bridge. This issue affects kernel 6.6.0 and later versions.

This patch allows INTx interrupts generated by PCIe endpoints
to flow through the root port. Tested the fix on a board with
two endpoints generating INTx interrupts. Interrupts are
properly detected and serviced. The /proc/interrupts output
shows:

[...]
32:        320          0  pl_dma:RC-Event  16 Level     400000000.axi-pcie, azdrv
52:        470          0  pl_dma:RC-Event  16 Level     500000000.axi-pcie, azdrv
[...]

Changes since v1::
- Fixed commit message per reviewer's comments

Fixes: 8d786149d78c ("PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver")
Cc: stable@vger.kernel.org
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


