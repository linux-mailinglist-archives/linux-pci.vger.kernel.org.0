Return-Path: <linux-pci+bounces-33922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF31EB23FDA
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2C958820A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45CA2C1590;
	Wed, 13 Aug 2025 04:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PCzDp4Du"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380332BF3E0;
	Wed, 13 Aug 2025 04:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060361; cv=none; b=NGI5mwLFmmF7Ogr+x+MxHr57zoSxvKagRl1j721HLpXqosrWxNR95F71NV4H93oLgsJ6jxcfCOu10do83Pt1oW7etkixzy36ohypoTdPEZ5Er/HuUKzo6eqZSWDaA4MNbU2J0Mp7syo8J0hAh4gMQvUCmMVzQdOxJpXU/5Yf+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060361; c=relaxed/simple;
	bh=ADdaQPFkRSO+VSTMlCDm3GecCwInkppbcV9rC+ipPes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q3gg7Jk9ciyvIi5oE07NQ0DwzvelrimBv+Z3WrJ8KtkTx0/1TlwLVp2X2UlSgxHAITQuVk3oei6C5UD09eAdV7S8SJFv9H+X476/bU6OPRlzs2Z7MSzQ8W+NrMdYCJ47xoxuWz5W2jF5aCG1DoVbgsqdYS0uwZ+PuKr9KvAfSc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PCzDp4Du; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KS
	hWwqB6/OjriKH/vh/97toS6aO3gRr/LJ9FfGdZTCo=; b=PCzDp4DurPvuvvveeJ
	AmjwiaUdKOsJoqKgWURg6AIO+9Y4KLEjB6IJY3wF3dItvF4K4/GkJdj9Lpr+abzl
	YuUML5ARp9pFwLn3290Sqk6GIOXZakJI5O6eBcVBBj8SJhcqc9hr0xoGLQLW7LsE
	90r3R/y/XeCv6QqyPfVsjcfyw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnCKx4GJxoOGujAw--.23777S3;
	Wed, 13 Aug 2025 12:45:46 +0800 (CST)
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
Subject: [PATCH v4 09/13] PCI: fu740: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Wed, 13 Aug 2025 12:45:27 +0800
Message-Id: <20250813044531.180411-10-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250813044531.180411-1-18255117159@163.com>
References: <20250813044531.180411-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnCKx4GJxoOGujAw--.23777S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1DGrWDuryrAw1rWryUWrg_yoW8WrWxpa
	y2yrWrCF1UJa1ru3WUJa4kZF1agas3CFWUWFs7Wwn29F9FyrWDWFWrta43tFyxGF4Iqr1a
	kw1Utay7WF1ayFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKLvucUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhCoo2icEADWHAAAsP

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


