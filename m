Return-Path: <linux-pci+bounces-29137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F81AD0E51
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 17:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEAA168EF6
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E576204680;
	Sat,  7 Jun 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nkicv9jl"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F80F1F4C94;
	Sat,  7 Jun 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749311790; cv=none; b=hBL9PQlgmxcwDwezclpJXFlOXOHQOXnZWu4zeLMPNpYPUDLOt9Vw3qOM2/xQzc0YodUzLx3g8V5P7/hkUFFr28FHxoxIrTRlYb10rNBOpz/PFWoaXBcPEj4xw+LAjnzJziiH784jlprugyn69qMgtKGKpGSEARfeCP2FRKR/zAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749311790; c=relaxed/simple;
	bh=Pc7Qom0KKkFpSWIW57jEO7mM9ZbqoQXVmiH5CdunMoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4etP65umW9ZldwPR0xxZcAht4hkSubYa5GNLHwSnX5z7J3b98j8CJjZ+kd3yxkZEuURBXqrR5h8oNoKLPtAL7x4TxobyhkN8ufVxbcMPtqO/aMXKuUFhI9qz/ScORexR0nUJid8sSTd97qOInGDm0NFwxQOXfRmij5oN7tcmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nkicv9jl; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6W
	76j04zvlqq/OoBm/X67iqNSUqmGknmHQ6PW9oOO+8=; b=nkicv9jlUfvVfoI0u/
	/HfGT5cDJjZVFJxyIVfUbGicOCU2RDMo2OkH+csYz60cvCpvWrJbuODuQyU00fOc
	YB7ADwopJWGYJxmcAuuQiXnN16Cm8GcNjgW5dtYNi3dYrjskUMNt3PGDldekmIl+
	14P7jkgCqPgttz8d1u0eB80p0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC3dpsKYURonH09Gw--.59622S5;
	Sat, 07 Jun 2025 23:55:56 +0800 (CST)
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
Subject: [PATCH v2 3/3] PCI/bwctrl: Replace legacy speed conversion with shared macro
Date: Sat,  7 Jun 2025 23:55:45 +0800
Message-Id: <20250607155545.806496-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250607155545.806496-1-18255117159@163.com>
References: <20250607155545.806496-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3dpsKYURonH09Gw--.59622S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1DKrW3ZFyUWFWktr17GFg_yoW8Ar4Upa
	9xZr1UAFy8Aw15CrZ0g3WvqFyUXFn3JFWUC3yfW3s5XFy7A395Ga42yFWftryaqrZIkry8
	C3WUJF48Cw12kaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRv4i5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhhlo2hEXNpgJQACsJ

Remove obsolete pci_bus_speed2lnkctl2() function and utilize the common
PCIE_SPEED2LNKCTL2_TLS() macro instead.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pcie/bwctrl.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 36f939f23d34..5afc1f45c444 100644
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


