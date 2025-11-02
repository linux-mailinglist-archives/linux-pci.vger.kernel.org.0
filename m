Return-Path: <linux-pci+bounces-40064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE55C2905A
	for <lists+linux-pci@lfdr.de>; Sun, 02 Nov 2025 15:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D4B3B0E12
	for <lists+linux-pci@lfdr.de>; Sun,  2 Nov 2025 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDC61547F2;
	Sun,  2 Nov 2025 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SVL2gEcd"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F5E221DAD;
	Sun,  2 Nov 2025 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762093968; cv=none; b=GaC3EpjkVcwnSOvtwkQAZgeDrv0QKUyw8+itiKCsvVDPY6l93itjqGT2PRr3rR8sRzICLUMGbjU9LWiBmjPLzVRJQ5R8SDfFAUDuM4/L+NV5XSMkXQ51L0LvL0zCKCXRtGS4UegHgUpevwM20Iqabp7aobsRV2aIzZNRxEOgov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762093968; c=relaxed/simple;
	bh=44+9f5QUL8F96KzX9kNDCAOXu+GBFX0MjZJVcoomQmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IqNAQon74gYYJ7hmgoRdL1G23tVSvG3jwLdvr9kBCVvvSb7CrcO05zUHGNDCrQaoP56kGLLtPZQJMW0GgQdFMGQssq45kkXHMqxg30tg3rQR6RqP/SeAHnrojICgYhAplxu6xaSBSmqi88QSiD+Afz8V7VrrIvyL2Q2jZtKBt98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SVL2gEcd; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Vs
	DxYwS8FJtUeB1QXeElDQeZXyhg/H30pOf2g1BiWjU=; b=SVL2gEcd1JT2zP8O6I
	g8CVZX7BlbJ55aCdVPjXbxm/MJbBIyWL1ZQNoeB80CD2gR6Lnkw+qSKKANQX3Xgh
	9Jdvch2RlET/szs5cMzkVmlhS7wwHABYmd4E9/KzPIzG7KcZhOIEgFMBqUx+YH7y
	kBMSAMejEAp4Mf8z+Y/9GpwAE=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAH5VdpawdpqU+1BA--.1772S4;
	Sun, 02 Nov 2025 22:32:11 +0800 (CST)
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
Subject: [PATCH v4 2/3] PCI: Move pci_bus_speed2lnkctl2() to public header
Date: Sun,  2 Nov 2025 22:32:05 +0800
Message-Id: <20251102143206.111347-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251102143206.111347-1-18255117159@163.com>
References: <20251102143206.111347-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH5VdpawdpqU+1BA--.1772S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4UCw4ktF48ury7Kw1kAFb_yoW5JFy7pa
	9rCry5AF18A3W3AFZYg3WkXa45XFn3JFWUCr43W395XFyfA395Ga42yFWFvryaqrWFkryr
	Ja15JF48C3WUKF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pia0PgUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwsRtGkHa2sPAgAA3O

Move the static array-based pci_bus_speed2lnkctl2() function from
bwctrl.c to pci.h as a public inline function.

This provides efficient O(1) speed-to-LNKCTL2 value conversion using
static array lookup, maintaining optimal performance while enabling
code reuse by other PCIe drivers.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.h         | 17 +++++++++++++++++
 drivers/pci/pcie/bwctrl.c | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e95f2e1d0634..ff0c56fd6568 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -531,6 +531,23 @@ static inline bool pcie_valid_speed(enum pci_bus_speed speed)
 	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
 }
 
+static inline u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
+{
+	static const u8 speed_conv[] = {
+		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
+		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
+		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
+		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
+		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
+		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
+	};
+
+	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
+		return 0;
+
+	return speed_conv[speed];
+}
+
 static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 {
 	switch (speed) {
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 5953b6940992..aa98476879e4 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -48,23 +48,6 @@ struct pcie_bwctrl_data {
 /* Prevent port removal during Link Speed changes. */
 static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
 
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
-- 
2.34.1


