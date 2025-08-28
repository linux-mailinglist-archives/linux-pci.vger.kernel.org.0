Return-Path: <linux-pci+bounces-35023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83611B39F96
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E18206092
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3548231858;
	Thu, 28 Aug 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IdmHwC/n"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4966622A4EB;
	Thu, 28 Aug 2025 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389660; cv=none; b=to1X+3XsDy5fHOQjzyJebhfjyhOiC+1BpgOYS1JalLOjdjBqUawa0GnAsOwgXFEWieOemX3hw6ZVtKzlcO27GAWg8XZiWUNzUjxk7vg9Ulriz1tYzAUoNfAhbjyYVxxxPMxLonCOVNBTdRGDvllFopIfq+CR1LGEwzZtnjH4qE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389660; c=relaxed/simple;
	bh=cHDdqhva+6AIS0Y/Y6XwJUtXSPl0BO1JBvPsunU1LZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lOShe2KoJiFVfCSbB9crB6wqJm8P9satMPp+uVhBwS8wVESnmb8LUGdyDnb7iiwIMdgbjxXlwFRbO5mJirU0NP2d90CM1huCmWA1qFTwNIO8YgvrCpDa157Uc4q7LQS6tIoiGKaQPJACG9WNXdVxem8Ee7al/2adYxotbsmyeyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IdmHwC/n; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KN
	7TgaWF2kajUdYvrzUZkDw3BqSOqVca4BrK8wbWfaY=; b=IdmHwC/nh8hvGFOOSF
	oU5OOdNn30OFvEAGIrq43kTb5HXzo3Jii/4BPWOguNdDKGN58qNhR423l3BEySon
	qMFlCGdjzo9vqoOaHlE9APrbgl6Rcl+joBHM0uTz5GYke5bsdnb0+OEV+5bHRrRI
	/rOWbjpWSqSFTL/kdg5htvT30=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXJYwNYbBoRejWEw--.829S3;
	Thu, 28 Aug 2025 22:00:46 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 09/13] PCI: fu740: Refactor code by using dw_pcie_*_dword()
Date: Thu, 28 Aug 2025 21:59:47 +0800
Message-Id: <20250828135951.758100-10-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250828135951.758100-1-18255117159@163.com>
References: <20250828135951.758100-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXJYwNYbBoRejWEw--.829S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1DGrWDuryrAw1rWryUWrg_yoW8Wr48pa
	y2yrWrCF1Uta1rZa18A3WkZF1Yga93AFWUWan7Wwn29F9FyrWkWrWFqa4aqFyxGF4Iqr1a
	kw1Utay7X3WayFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pK9av_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhC3o2iwWw2UmwAAs-

SiFive FU740 PCIe driver uses direct register write to initiate link speed
change after setting target link capabilities. The current implementation
sets PORT_LOGIC_SPEED_CHANGE bit via explicit read-modify-write sequence.

Replace manual bit manipulation with dw_pcie_*_dword() for
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
index 66367252032b..5bb19da9e2b2 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -216,9 +216,8 @@ static int fu740_pcie_start_link(struct dw_pcie *pci)
 		tmp |= orig;
 		dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCAP, tmp);
 
-		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-		tmp |= PORT_LOGIC_SPEED_CHANGE;
-		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
+		dw_pcie_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
+				  PORT_LOGIC_SPEED_CHANGE);
 
 		ret = dw_pcie_wait_for_link(pci);
 		if (ret) {
-- 
2.49.0


