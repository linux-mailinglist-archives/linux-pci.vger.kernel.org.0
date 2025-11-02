Return-Path: <linux-pci+bounces-40065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2101C29060
	for <lists+linux-pci@lfdr.de>; Sun, 02 Nov 2025 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 112014E80EC
	for <lists+linux-pci@lfdr.de>; Sun,  2 Nov 2025 14:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915D114A62B;
	Sun,  2 Nov 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="efe4IK8B"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C11C3C18;
	Sun,  2 Nov 2025 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762093979; cv=none; b=PYP5FZzM09i/oVdoGEATjQLJlmsDWJEdxGTg1QXWAXhRuIODws9fsckdOs5H/M3XEF5+2amN/pGADV4pHApUsKC1i1C1dx1nvFLwte7rMXmsQZ349WnQXV6miC1F8+idj8pqOjFpfoknJJ28KV9aJHf0p2pEsPuUH4qEQpDltXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762093979; c=relaxed/simple;
	bh=hEiJbhYD13gFMTAh0JXxdsVAfQ4EQ9Br4DKPtYZ0fW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D90nXXUOOtE+RlplKBBIYqVRRV0CYqYQidZEPYQgkB49is/n4Eemq8HBpxVumUM3cKLCsgZcZ8idIZYGkTZZpCMN0U6ynN6aJAczb6ZWWrOUTR/PUJ++MzqkNHUkz9gejx/jR2CgqbCRJnY2zdnnuKTFZGf94U4DzNxYZ4iS2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=efe4IK8B; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Hh
	ls6A+3/SNax9SaFUeFpATr4kJuyuoT+8CwX9o9kfs=; b=efe4IK8BYjPcCbZyhC
	UL01GHjWMbSF08QDyXK1AQm9X2zh+cfO9Hm4Af3glGxKj3vQFL8hmfRAituWadQk
	bfxop0+nfcHnpoXxkgYq4kBt2Y6DqKwwj28Ff4DjdjKoddO5q6gDGGWUrD6OI3ba
	57Iqj+JCeRfTDoDBEHqHEuhRA=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAH5VdpawdpqU+1BA--.1772S3;
	Sun, 02 Nov 2025 22:32:10 +0800 (CST)
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
Subject: [PATCH v4 1/3] PCI: Add public pcie_valid_speed() for shared validation
Date: Sun,  2 Nov 2025 22:32:04 +0800
Message-Id: <20251102143206.111347-2-18255117159@163.com>
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
X-CM-TRANSID:_____wAH5VdpawdpqU+1BA--.1772S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW5CF43uw45Xw15KF43trb_yoW8WrWxpa
	yDAa45AF18Ja15ZFsYya18XFy5GFZayFW0krW3u39xZF13A3s3Jay5tayxtry2qrWIyF15
	Xa1YyF18CF4jyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR0oGdUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDxr5o2kHZmtoewAAs-

Extract the PCIe speed validation logic from bwctrl.c's static
pcie_valid_speed() into a public static inline function in pci.h.

This allows consistent speed range checks (2.5GT/s to 64.0GT/s) across
multiple drivers and functions, avoiding duplicate code and ensuring
validation consistency as per PCIe specifications.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.h         | 5 +++++
 drivers/pci/pcie/bwctrl.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4492b809094b..e95f2e1d0634 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -526,6 +526,11 @@ void pci_bus_put(struct pci_bus *bus);
 	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
 	 0)
 
+static inline bool pcie_valid_speed(enum pci_bus_speed speed)
+{
+	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
+}
+
 static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 {
 	switch (speed) {
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 36f939f23d34..5953b6940992 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -48,11 +48,6 @@ struct pcie_bwctrl_data {
 /* Prevent port removal during Link Speed changes. */
 static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
 
-static bool pcie_valid_speed(enum pci_bus_speed speed)
-{
-	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
-}
-
 static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
 {
 	static const u8 speed_conv[] = {
-- 
2.34.1


