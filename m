Return-Path: <linux-pci+bounces-34128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D9AB28F43
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 17:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7877A1C269AD
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1D819DFAB;
	Sat, 16 Aug 2025 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E6V0LA+E"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C7B2F39C5;
	Sat, 16 Aug 2025 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755359247; cv=none; b=rnESeb5iArrfxqMTsb5kETqVGRLHJEqopyi+DPsD1/tEOInDo22hhs83b54r+mQawhyliw7EY8VBJrk/hoKAbhS12Kb//Yn+99+g1G2HdFDFCwm2Hjw8PVW4xHrl54b47ppzNPQoS10ASZMBqW8dYgwsTYkEd5kC1CgGBd1vpbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755359247; c=relaxed/simple;
	bh=8UJUmByqC5ZJ/kLIwSKORSBpsuOfmy0bNm7GrUTj6Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MdtfJj7L7Yol+a29LgkOFo/uR7ULKYiIkHQaGq6ZUlRS4lY06L/acPmzDn3h1w75ytKpmOum5gYt/MCG09HfzPe/HydCJpKK1X4kiEJJIuJ7hqI/n4dy2qaORoL7vKXDnTOE2IH4aWjqu5mYN+jdM1RwnyLw59EV7PtAoYLSMaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E6V0LA+E; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ki
	Sx+tc76wSSVUkV3cDAPGdZW0D+Af1HbMarao/S99A=; b=E6V0LA+EnOA9MfGIWW
	bJahCpZMOODxZzh6GrTeIjOqgqHg2N+lY07aAEGtnVnFLL1k5e7lV1M8Or5LlxWl
	eD3n5p1/qKH58dV8Pio/1Shwwt+buZ5xO/3gZtbxVk2SsbnhmfPy+W03R2eauxPh
	ZZ+tvDqS8hEwdwhKdh6LlWcq4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHfLfip6BoVzqMBw--.15530S5;
	Sat, 16 Aug 2025 23:46:44 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 3/3] PCI/bwctrl: Replace legacy speed conversion with shared macro
Date: Sat, 16 Aug 2025 23:46:33 +0800
Message-Id: <20250816154633.338653-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250816154633.338653-1-18255117159@163.com>
References: <20250816154633.338653-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHfLfip6BoVzqMBw--.15530S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr43WrykXFy5urWkAFWrKrg_yoW8AF43pa
	9xZr1UAFy8Aw15ArZ0g3WvqFyUXFnxJrWUCw4fW3s5XFy3A395Ga42yFWSyryaqrWakry8
	C3WUJF48Gw12yaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYXdbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxmro2ignM3xWAABs7

Remove obsolete pci_bus_speed2lnkctl2() function and utilize the common
PCIE_SPEED2LNKCTL2_TLS() macro instead.

Signed-off-by: Hans Zhang <18255117159@163.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/pcie/bwctrl.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 36f939f23d34..802ab8daf68b 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -53,23 +53,6 @@ static bool pcie_valid_speed(enum pci_bus_speed speed)
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
@@ -91,7 +74,7 @@ static u16 pcie_bwctrl_select_speed(struct pci_dev *port, enum pci_bus_speed spe
 	u8 desired_speeds, supported_speeds;
 	struct pci_dev *dev;
 
-	desired_speeds = GENMASK(pci_bus_speed2lnkctl2(speed_req),
+	desired_speeds = GENMASK(PCIE_SPEED2LNKCTL2_TLS(speed_req),
 				 __fls(PCI_EXP_LNKCAP2_SLS_2_5GB));
 
 	supported_speeds = port->supported_speeds;
-- 
2.25.1


