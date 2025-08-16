Return-Path: <linux-pci+bounces-34125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F58B28F3F
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 17:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0DA1C2540B
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C1A1B21BD;
	Sat, 16 Aug 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VviRnvZO"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EBF29A2;
	Sat, 16 Aug 2025 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755359237; cv=none; b=X3iKFo2MqKCNJT2Old4h560jDIs/9mTrqCWhG8ruqMHADzBv7Mphpxq1ew85xatCGgDEDZ3FMSy8uAESQ6iO4JfGF0sGKNMpeDfP9cQErZe9sTPxOR90vA+FDKa01q2uUOJEMLbmamv8cQ9tu4Ek9EEppAdyh4epaXM5cYAtpMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755359237; c=relaxed/simple;
	bh=tZD/NI2tbfdKZN3eDHSa07wID0HggpJGNVl01yof5iM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ko7cZFs59knv8vtB+jbWvP+jcCo5fJgEXVh9czb+XcUC9pV9OAHXuMJxbiv/OM+CZw2BP2CnGB5kNerTXnhPIXDmMbYq0G4O6FLpnQu0usIMLVJlPWSnVdgMjpU73N4upCkL6zrNZy/ir9ndX4vF9z8mwMZ6DIhxSq1ugGYJjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VviRnvZO; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5m
	hnomU1tZqz1YQkUYKLJ4Yj9naZm9l9LOEGKmYpfJs=; b=VviRnvZOgwUUNN5LvD
	X4EBV/1dtQ83B5HBidbQOH1d5gcB6sZGQ5v5vFLo6NBirYjcNptFJO8bWXMLeKM7
	3Y4vUi+A4ztL20qqpMmTKsqOEAbNELNSHj+nPOZfOZmqCkpM89YhmBVMpTqJtghI
	SpifUoCzqu0eHZm+dm1KHOGpY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHfLfip6BoVzqMBw--.15530S3;
	Sat, 16 Aug 2025 23:46:43 +0800 (CST)
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
Subject: [PATCH v3 1/3] PCI: Add PCIE_SPEED2LNKCTL2_TLS conversion macro
Date: Sat, 16 Aug 2025 23:46:31 +0800
Message-Id: <20250816154633.338653-2-18255117159@163.com>
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
X-CM-TRANSID:_____wDHfLfip6BoVzqMBw--.15530S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cry8uFy3Cr43CFyUArWUJwb_yoW8JFWUp3
	W7AFy5AFW8W3WUAr98Was2qa4rXFs3GF4Uur47W3sxXFyfK34kAr12yrW3t3sFqr4jkry8
	Z3ZrKrWUCFy29F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRjZXrUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxyro2ignM3xTgAAsp

Introduce PCIE_SPEED2LNKCTL2_TLS() macro to standardize the conversion
between PCIe speed enumerations and LNKCTL2_TLS register values. This
centralizes speed-to-register mapping logic, eliminating duplicated
conversion code across multiple drivers.

Signed-off-by: Hans Zhang <18255117159@163.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/pci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e..679dd0f44d73 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -422,6 +422,15 @@ void pci_bus_put(struct pci_bus *bus);
 	 PCI_SPEED_UNKNOWN);						\
 })
 
+#define PCIE_SPEED2LNKCTL2_TLS(speed) \
+	((speed) == PCIE_SPEED_2_5GT ? PCI_EXP_LNKCTL2_TLS_2_5GT : \
+	 (speed) == PCIE_SPEED_5_0GT ? PCI_EXP_LNKCTL2_TLS_5_0GT : \
+	 (speed) == PCIE_SPEED_8_0GT ? PCI_EXP_LNKCTL2_TLS_8_0GT : \
+	 (speed) == PCIE_SPEED_16_0GT ? PCI_EXP_LNKCTL2_TLS_16_0GT : \
+	 (speed) == PCIE_SPEED_32_0GT ? PCI_EXP_LNKCTL2_TLS_32_0GT : \
+	 (speed) == PCIE_SPEED_64_0GT ? PCI_EXP_LNKCTL2_TLS_64_0GT : \
+	 0)
+
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
 	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
-- 
2.25.1


