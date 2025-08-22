Return-Path: <linux-pci+bounces-34600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A05C3B3200A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 18:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78DBDBA5A3B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C76326B2D3;
	Fri, 22 Aug 2025 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IVXFx4eN"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15CB1DF99C;
	Fri, 22 Aug 2025 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878587; cv=none; b=Cbqwbw6jnYYADZTqAxbDGhhuv1MG0AyPPqNuTQ5WvBJjim95BP83gTOl+0YbBjUGejTynaa1Vt42i9Oqd/dSh/8qVjmymsPH7T0yWLw6UsscmXcrdP8PwvwNEeZRR/IYCifwWc5Y+znTbAOr5rQwBEYMYi0JTzsKo+vfSfSylMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878587; c=relaxed/simple;
	bh=V1Cw2hsQFGVdSK0O43IBpc3FBvg27wXIB7ES7RXG21E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sqxq5xVWTTG6VljSt//s8FODkLvd+UovJfmNY29Bl8wktBAoxvMJtU51CVglw6K2/RxH/U6Y5bhgZDtPlIwbHToe7wdMNA+hIavq6XFB+2HVK8LOn9lQVEGRJCj9V6AJ+RdcL7SxhDeCHHKTVxBPbPTMm0/VAPTuZxop8axOBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IVXFx4eN; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Jh
	UTm3ze+LHMDVrZVx4fPDMswd+/2krTh5wNPiEtCjk=; b=IVXFx4eNXv7bDx2V/t
	wM0fz7W6c+6R9nk7/PhxwhVoid36E3K4EI0tBnM4kk0B2MpSL25KLf9JW/Rykhup
	4f5ZtwPxJjGvbud2SFRWBF9IkLPQM+UgUyOru6VtjZ6dvDgA5ZO26j5rox9181UA
	1aI80agdOaelcHxG6pCDT+T50=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnxDaplKho3jnHAA--.18200S3;
	Sat, 23 Aug 2025 00:02:51 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 1/7] PCI: Replace msleep(2) with fsleep() for precise delay
Date: Fri, 22 Aug 2025 23:59:02 +0800
Message-Id: <20250822155908.625553-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822155908.625553-1-18255117159@163.com>
References: <20250822155908.625553-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBnxDaplKho3jnHAA--.18200S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy3GFWxtry7Jw47Ar1UJrb_yoW8Ww15pF
	W5GFy0yF1rJa15Xrs5Aa18Cry5G3ZI9FWjkF48K3sav3W3AFWDCw45GFW5GrnFqrWxXr1a
	ya90krWUJFW5trDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRrcTDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwaxo2iokINYqwAAs3

The msleep(2) may sleep longer than intended due to timer granularity.
According to PCIe r7.0 spec, section 7.5.1.3.13, the minimum Trst is 1ms.
We double this to 2ms to ensure we meet the requirement. Using fsleep()
provides a more precise delay.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.c | 7 ++-----
 drivers/pci/pci.h | 6 ++++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cd..fb4aff520f64 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4963,11 +4963,8 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 	ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
 
-	/*
-	 * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
-	 * this to 2ms to ensure that we meet the minimum requirement.
-	 */
-	msleep(2);
+	/* Wait for the reset to take effect */
+	fsleep(PCI_T_RST_SEC_BUS_DELAY_US);
 
 	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e..471dae45e46a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -60,6 +60,12 @@ struct pcie_tlp_log;
 #define PCIE_LINK_WAIT_MAX_RETRIES	10
 #define PCIE_LINK_WAIT_SLEEP_MS		90
 
+/*
+ * PCIe r7.0, sec 7.5.1.3.13, requires minimum Trst of 1ms.
+ * Double this to 2ms to ensure we meet the minimum requirement.
+ */
+#define PCI_T_RST_SEC_BUS_DELAY_US	2000	/* 2ms */
+
 /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
 #define PCIE_MSG_TYPE_R_RC	0
 #define PCIE_MSG_TYPE_R_ADDR	1
-- 
2.25.1


