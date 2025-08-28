Return-Path: <linux-pci+bounces-35025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F01B39F97
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9415A004EE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAFE312814;
	Thu, 28 Aug 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Doq/O5DD"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F251E51EA;
	Thu, 28 Aug 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389661; cv=none; b=AyNfKqDH099ol9lRPvo2X/fkKykGjV6HHEN+JIQDhkvyPrSVWxxMqtlaOQK3zAKLI+wEyY7hQWYqe98R5D8P80vHvdzPzD2Rf5zDhIW856ciYdSo1p6AXAYKWShc7yRndupz+MvDQVmwTd4HVOA52fTPAy5xBY2mwe09kpJWnEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389661; c=relaxed/simple;
	bh=0h/uAYXPWTodmK77bhv0kKWuNaJgts8GLgBTCzBTLOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbcTsF4LBPNqjAz3feqiQ/V5xJ31G20TGZN6hjMedwmcZTYNXJNvaEblH7py1OysozEtZhtZ/BSoZH7LrRa0jHQvxgSWgRpv5sFysilIOVzlGMRqqUlmICB/h+XDIY5VSG/CJ8EJ6MXM/pCewwuLyzKJj839OfiiyNRwLMJZi04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Doq/O5DD; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=en
	+axyEHeun5jrILn7+GgVbrS+V+e7dBdMoJs8WLtS4=; b=Doq/O5DDMZ13wEdqJa
	pEG+wXPubMnzMi8y5NN5kgU229xQpiLA5daQcOogYGgVaSjcLTfzx8MYJF/ek+zv
	j008ULuGEXzJHZfg3wJPjhc38qIlZETP86TT8yOpFSAkzT/up+FZkxyaPkLAoVlC
	fXdXggfcGJDE7psQScMTNX4gI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXBtYDYbBoN0ahAw--.5480S9;
	Thu, 28 Aug 2025 22:00:42 +0800 (CST)
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
Subject: [PATCH v5 07/13] PCI: bt1: Refactor code by using dw_pcie_*_dword()
Date: Thu, 28 Aug 2025 21:59:45 +0800
Message-Id: <20250828135951.758100-8-18255117159@163.com>
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
X-CM-TRANSID:QCgvCgAXBtYDYbBoN0ahAw--.5480S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry8Xw4xCFy5Cw4DuFWDtwb_yoW8Ar4Upa
	9IkF92kF1Iya15ua1jy3Z7uFy5Wan5Ca4jgrnFgw1IgF9Iyr9rWryrKFyYvrZxJr4Iqr1j
	9w1UtFW7AanxZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pinmR8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwi3o2iwWlmkrgAAsW

Baikal-T1 PCIe driver contains a direct register write to initiate
speed change during link training. The current implementation sets
the PORT_LOGIC_SPEED_CHANGE bit via read-modify-write without using
the standard bit manipulation helper.

Replace manual bit set operation with dw_pcie_*_dword() to enable
speed change. The helper clearly expresses the intent to modify a
specific bit while preserving others, eliminating the need for explicit
read-before-write.

Using the standardized interface improves consistency with other
DesignWare drivers and reduces the risk of unintended bit modifications.
The change also simplifies future updates to link training logic.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-bt1.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
index 1340edc18d12..0a9466827e2b 100644
--- a/drivers/pci/controller/dwc/pcie-bt1.c
+++ b/drivers/pci/controller/dwc/pcie-bt1.c
@@ -289,9 +289,8 @@ static int bt1_pcie_start_link(struct dw_pcie *pci)
 	 * attempt to reach a higher bus performance (up to Gen.3 - 8.0 GT/s).
 	 * This is required at least to get 8.0 GT/s speed.
 	 */
-	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
+			  PORT_LOGIC_SPEED_CHANGE);
 
 	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
 				       BT1_CCU_PCIE_LTSSM_LINKUP(val),
-- 
2.49.0


