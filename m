Return-Path: <linux-pci+bounces-29477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A5FAD5C47
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB563A95D9
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE982040B0;
	Wed, 11 Jun 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UYc1iR1g"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E210205519;
	Wed, 11 Jun 2025 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659583; cv=none; b=HPKkRjUE+AtXmxtqcpyBz1QisS20mYDGH1K0jjepASrR2Q4mDq3ZhOhzBzhZxWnSqTwYrtFkx9vptXylVIqPu3Dz4gSfjBochHVUHJeWztdg9xW4Zvil0dkfutOhUX/WzjB8+vk93POyNwvkRLsmtT3ITTTW2kk2ndzfJbCh0T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659583; c=relaxed/simple;
	bh=ADdaQPFkRSO+VSTMlCDm3GecCwInkppbcV9rC+ipPes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QNHbmPuK6anq1Vvi3m/1DaVZOluQmip2aNGSOTNy6vLy5I5oGJbxMDUeNe1Zlgoi8i6S+C8SM4BecLGxVbp8ooGjpwRtHdQOu6TSCDwtKhQLAplVc5ekFHLlqc1UIzQo53lT7DtNLReo2Q+6rqjj80XIC7h5ZPZvaXo8rzEAtF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UYc1iR1g; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KS
	hWwqB6/OjriKH/vh/97toS6aO3gRr/LJ9FfGdZTCo=; b=UYc1iR1g92ipTCB/7v
	jOdPCT/BLOnUNpU/Fzlh2WidKHGdI2YmeH9My5zHnve3L89OJMgP9p3qEmgZwO5Z
	Ix4YLFw//nLrHu9mPMKPcgRxnCej76Sy3E41EYik+0ncPr0sYjg/pYeqOOuc6hNk
	lHdD9FKnSdPfPx+GkXVBc26lU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXgUmEr0lo72BIHg--.23804S2;
	Thu, 12 Jun 2025 00:32:04 +0800 (CST)
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
Subject: [PATCH 09/13] PCI: dwc: Refactor fu740 to use dw_pcie_clear_and_set_dword()
Date: Thu, 12 Jun 2025 00:32:00 +0800
Message-Id: <20250611163200.861064-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXgUmEr0lo72BIHg--.23804S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1DGrWDuryrAw1rWryUWrg_yoW8WrWxpa
	y2yrWrCF1UJa1ru3WUJa4kZF1agas3CFWUWFs7Wwn29F9FyrWDWFWrta43tFyxGF4Iqr1a
	kw1Utay7WF1ayFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR-eOLUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxFpo2hJrMxGXQAAsO

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


