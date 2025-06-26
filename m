Return-Path: <linux-pci+bounces-30783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D23EAEA1F2
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 17:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94643A6A74
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F592FD87B;
	Thu, 26 Jun 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UZJG7Fd+"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A52F0C6F;
	Thu, 26 Jun 2025 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949543; cv=none; b=QqIAU+63F8wjEWweP5cXr6SoDpe1b2h1sISLPzGcuiO+FToEN1wmkW22xommlvLKahzOkDmWxe6PsGRNbRCic4YUm59DQ8oIwLTKIJNeaFmVGGcMPU3tUwAClepHWcIVTz1w+0Q2DfsghQ1p9nqWR/cUP8uj+hEq0tt3qL8SATI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949543; c=relaxed/simple;
	bh=ADdaQPFkRSO+VSTMlCDm3GecCwInkppbcV9rC+ipPes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gs3KRP6Rs2f94s1KnvInPdukNlUoYAYsfbx0Iod3sPbAA0YK2cQCKd6gsclCw4OTJClCmkSn41u1T1wFI8ijTu90HTKSQSdnIPHKOCIM5WuJAz+Dbrw2wXtW41K8l1avQwdeEVjET4DGxVOSjqO1I6U9/9PeDOMSaqXt/c6H5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UZJG7Fd+; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KS
	hWwqB6/OjriKH/vh/97toS6aO3gRr/LJ9FfGdZTCo=; b=UZJG7Fd+jZxb0Vamy2
	0rm5tZATPbGqMesA55Iltl4bWckYaTjHrm1zYo0U9S+JesZ7Ff8pca6Mb5EJcU7A
	iVWKYIxvo2Ay5LdxVYDBlkIB+yx4TbTXxALr6fzPP296WhDRV1mbqfKsmHJUX4E5
	LMNUqnmMn5g+hHVO4N+uEIOjA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wB3nPiWXl1o6RnqAg--.56622S6;
	Thu, 26 Jun 2025 22:52:09 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 09/13] PCI: fu740: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Thu, 26 Jun 2025 22:50:36 +0800
Message-Id: <20250626145040.14180-10-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250626145040.14180-1-18255117159@163.com>
References: <20250626145040.14180-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3nPiWXl1o6RnqAg--.56622S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1DGrWDuryrAw1rWryUWrg_yoW8WrWxpa
	y2yrWrCF1UJa1ru3WUJa4kZF1agas3CFWUWFs7Wwn29F9FyrWDWFWrta43tFyxGF4Iqr1a
	kw1Utay7WF1ayFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pELZ2cUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxt4o2hdXLQrSAAAs9

SiFive FU740 PCIe driver uses direct register write to initiate link speed
change after setting target link capabilities. The current implementation
sets PORT_LOGIC_SPEED_CHANGE bit via explicit read-modify-write sequence.

Replace manual bit manipulation with dw_pcie_clear_and_set_dword() for
speed change initiation. The helper encapsulates read-modify-write
operations while providing clear intent through "clear 0, set BIT" usage.

This refactoring aligns the driver with standard DesignWare programming
patterns and reduces code complexity. The change also ensures consistent
handling of speed change initiation across all DesignWare base
controllers.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-fu740.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 66367252032b..8210ff1fd91e 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -216,9 +216,8 @@ static int fu740_pcie_start_link(struct dw_pcie *pci)
 		tmp |= orig;
 		dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCAP, tmp);
 
-		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-		tmp |= PORT_LOGIC_SPEED_CHANGE;
-		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
+		dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
+					    0, PORT_LOGIC_SPEED_CHANGE);
 
 		ret = dw_pcie_wait_for_link(pci);
 		if (ret) {
-- 
2.25.1


