Return-Path: <linux-pci+bounces-29470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6394AD5C2F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CEA1E1FF3
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82117204680;
	Wed, 11 Jun 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XDY8pA4H"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947C71FAC48;
	Wed, 11 Jun 2025 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659526; cv=none; b=odNi4vIDvRjc/++vn1Ty/2+Rb86RWsGl6pLVGdWSZNBEtzBrywjx2KkxAxyhKVKOLNorwzlXtE9aj19pmuP8TxS3egqCPuKbVZjICUXdYporck50EHJYMQw6kpFGEdtVmMkFg+GTew8OH83Ico1MFTmEcWVhJ8nzmGdxvgu9n6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659526; c=relaxed/simple;
	bh=QsvVTVjEukMOXgp7vsAJHkEP4QuiyFrtI+Q8YTeyeFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ltHLO/lkr9VNslcfXpmAJ3DUhsukHDoz1ywrbDYO08tel3uOSDvLH1aVQFrXO8KDZQeOKsDv7HPAh8smY5au7QOFhjLsr2NhOyy6IybNwTThgaLwR8N/jzc04miArAEbnBKJsNXX44Q62itENXDK3vwFeu8QrLkeElMgSMXjI8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XDY8pA4H; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=04
	fcvJHUcanUs3BderAdxY1w8bpBTNk29ppsje+kwjk=; b=XDY8pA4HSyDJlEVYO0
	28wYHxHSCstmbJV02GH3As5ubE4oX3jlKZbM5z8Nmxv9+AAJHu+S99yYoU98PHc3
	At5Ix0TSdLazqYxxHn5+beY6sTpg4omF8xduhdlq4Reh3CziLjxKFqPex4IuF3Or
	lcAKm5Hrs0V1Zjh4oS1P8iKK4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wA3qEh1r0lo0Y1OHw--.15121S2;
	Thu, 12 Jun 2025 00:31:50 +0800 (CST)
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
Subject: [PATCH 07/13] PCI: dwc: Refactor bt1 to use dw_pcie_clear_and_set_dword()
Date: Thu, 12 Jun 2025 00:31:48 +0800
Message-Id: <20250611163148.860884-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3qEh1r0lo0Y1OHw--.15121S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry8Xw4xCw48Gr45uF4xXrb_yoW8ArW7pa
	9IkF92kF12ya1Y9a1Ut3Z7ZFyYgan5CayjgFn7Kw1IgF9Iyr9rWFyrKFy3trZxJr4Iqr1a
	9w1UtFW7uan8ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRdsqLUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxNpo2hJrMxE4wAAsw

Baikal-T1 PCIe driver contains a direct register write to initiate
speed change during link training. The current implementation sets
the PORT_LOGIC_SPEED_CHANGE bit via read-modify-write without using
the standard bit manipulation helper.

Replace manual bit set operation with dw_pcie_clear_and_set_dword() to
enable speed change. The helper clearly expresses the intent to modify
a specific bit while preserving others, eliminating the need for explicit
read-before-write.

Using the standardized interface improves consistency with other
DesignWare drivers and reduces the risk of unintended bit modifications.
The change also simplifies future updates to link training logic.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-bt1.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
index 1340edc18d12..7cbaeeed033d 100644
--- a/drivers/pci/controller/dwc/pcie-bt1.c
+++ b/drivers/pci/controller/dwc/pcie-bt1.c
@@ -289,9 +289,8 @@ static int bt1_pcie_start_link(struct dw_pcie *pci)
 	 * attempt to reach a higher bus performance (up to Gen.3 - 8.0 GT/s).
 	 * This is required at least to get 8.0 GT/s speed.
 	 */
-	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
+				    0, PORT_LOGIC_SPEED_CHANGE);
 
 	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
 				       BT1_CCU_PCIE_LTSSM_LINKUP(val),
-- 
2.25.1


