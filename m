Return-Path: <linux-pci+bounces-28001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B2EABC496
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 18:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954751B63942
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 16:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6F52853FD;
	Mon, 19 May 2025 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lgcWPvCX"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F168D28851F;
	Mon, 19 May 2025 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672358; cv=none; b=oALR6JTPHU56XzEGa2+QHOdiwjf+8pMfE+LPp3oWu0ELAtNKP1WaNeBLKG4nPtI63In07g6a/EDu9ZumcEWRpLllf6Ibk9r+EOhApTKgfP2+whzfM2DJguIi41eRUIsaItFpSsFR0/S7khGDMniJndKWQcsKG2Yk5CdHOjUtobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672358; c=relaxed/simple;
	bh=PXNCiJ5xoO/xCmMEKbAoMNDvhrwKWD3uo/0LaRx0nvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJcex4eQo9ayMbxc/EUwkLo57loCVJJuN2TzNLW8dglQ68iqVzTChpTnYqG4+UnGvAREApefmuZ373zMbyGHPF9lHz3+c/ALcw0jiojKxO4MOT3DEo98I/tmTJneaXuoQ5SsiKa+G+X9DD4AFd6RUUgBqXn83EacXp64DfP2MHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lgcWPvCX; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ck
	1FJ/X8Z/gmDk70VFd/aZnFUDoMaQAgbxAZxJENzgg=; b=lgcWPvCXC7fVj89HHt
	Pi4wr6F+OS0WYhkgY6dDYIHIjWmlP93S9H35zeXFSxTn5xHC/Mc9BtYK9P/eJDZ9
	UYqr02U2zPl0+ZOsQmJ63tFZUMAN1sDTIoh3sYN6CCYiO9ZlhUqAXxa00h+MWP7q
	5MEDrstcEMDQjFADOOlAPuMcM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC3vJ4CXStoPbk5Cg--.56045S5;
	Tue, 20 May 2025 00:32:05 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	krzk+dt@kernel.org,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 3/3] PCI/bwctrl: Replace legacy speed conversion with shared macro
Date: Tue, 20 May 2025 00:31:56 +0800
Message-Id: <20250519163156.217567-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250519163156.217567-1-18255117159@163.com>
References: <20250519163156.217567-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3vJ4CXStoPbk5Cg--.56045S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7try3CrWruw1fGw4xWw13twb_yoW8Ar4fpa
	9xZr1UAry8Aw15CrZ0g3WvqFyUXFnxJrWUC3yfW3s5XFyfA395Ga4ayFWrtryaqrZIkry8
	Can8JF48Gw17KaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRvtC-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxxSo2grV+Vn8AABsF

Remove obsolete pci_bus_speed2lnkctl2() function and utilize the common
PCIE_SPEED2LNKCTL2_TLS_ENC macro instead.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pcie/bwctrl.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index d8d2aa85a229..3e17f6366a69 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -63,23 +63,6 @@ static bool pcie_valid_speed(enum pci_bus_speed speed)
 	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
 }
 
-static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
-{
-	static const u8 speed_conv[] = {
-		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
-		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
-		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
-		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
-		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
-		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
-	};
-
-	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
-		return 0;
-
-	return speed_conv[speed];
-}
-
 static inline u16 pcie_supported_speeds2target_speed(u8 supported_speeds)
 {
 	return __fls(supported_speeds);
@@ -101,7 +84,7 @@ static u16 pcie_bwctrl_select_speed(struct pci_dev *port, enum pci_bus_speed spe
 	u8 desired_speeds, supported_speeds;
 	struct pci_dev *dev;
 
-	desired_speeds = GENMASK(pci_bus_speed2lnkctl2(speed_req),
+	desired_speeds = GENMASK(PCIE_SPEED2LNKCTL2_TLS_ENC(speed_req),
 				 __fls(PCI_EXP_LNKCAP2_SLS_2_5GB));
 
 	supported_speeds = port->supported_speeds;
-- 
2.25.1


