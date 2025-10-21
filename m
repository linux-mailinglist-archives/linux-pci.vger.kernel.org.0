Return-Path: <linux-pci+bounces-38857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDD9BF51B2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 09:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F774036C5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 07:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17592980A8;
	Tue, 21 Oct 2025 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="I37gjNrO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731115.qiye.163.com (mail-m19731115.qiye.163.com [220.197.31.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B122FC00C
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032949; cv=none; b=PW9SRn8UfcApxcaxoixIsDqMlFEsDcrXGy2eUWCP2Y4+dJ0x0jdpEUYZE4PGD4xLK4xMUHS2/wXCQFw/1c9TJiJxVEphn39WvHfOSd4X2sYOZgXA97yB6cOM6JzmE5o0QlhX+wFlQo/T9e5mKFIUAZNZ4xLwphGVZGfBC6FusRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032949; c=relaxed/simple;
	bh=my3VAkuitRgg6EnaeCO9ILIc7ySdO5WIfBJCs0lyAWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hvwZ3oHzTO/pUavL6RAd3hO4fEE7L9Y6Wwv8MgM3Ld8kxLTsOJPOxw39V8Z0coZ/9PulWHtt5mubrofMy+JM2tht/FWUSVb7QgUg6Q5L901nPJUZyKYSOYCOQbWgSuURI4uJ7XH2iizwbNyrNL7FyrCQ46ZPr+onz/wxIQ2rBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=I37gjNrO; arc=none smtp.client-ip=220.197.31.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26a1f5286;
	Tue, 21 Oct 2025 15:49:00 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/4] PCI: of: Add of_pci_clkreq_present()
Date: Tue, 21 Oct 2025 15:48:24 +0800
Message-Id: <1761032907-154829-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
References: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9a05be2cfe09cckunm38953c5864808b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh9LHlZMHUwYHx1ITkwdGUlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=I37gjNrOB0UUpW8X5UZTolq/v5JQkNseWBFPCxyJjgTDoezRAM3/+2JvP2W2Ef1z8gGwtMbpjkm5flw1qYWzTZd8RtBd2lzSSCRbv43yx/efAVGxsxk+WrB48P0tyYFcD1wSCaihiqgU2P8pPaZtLIqKaVNeyp1CihevtWL4Z08=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Hn9ORcaY3DZtJ5tmGSYeDmjTWhW/CR3G52XVpkaa9bU=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

of_pci_clkreq_present() is used by host drivers to decide whether the clkreq#
is properly connected and could enable L1.1/L1.2 support.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/of.c  | 18 ++++++++++++++++++
 drivers/pci/pci.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..52c6d365083b 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -1010,3 +1010,21 @@ int of_pci_get_equalization_presets(struct device *dev,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
+
+/**
+ * of_pci_clkreq_present() - Check if the "supports-clkreq" is present
+ * @np: Device tree node
+ *
+ * If the property is present, it means CLKREQ# is properly connected
+ * and the hardware is ready to support L1.1/L1.2
+ *
+ * Return: true if the property is available, false otherwise.
+ */
+bool of_pci_clkreq_present(struct device_node *np)
+{
+	if (!np)
+		return false;
+
+	return of_property_present(np, "supports-clkreq");
+}
+EXPORT_SYMBOL_GPL(of_pci_clkreq_present);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4492b809094b..2421e39e6e48 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1061,6 +1061,7 @@ bool of_pci_supply_present(struct device_node *np);
 int of_pci_get_equalization_presets(struct device *dev,
 				    struct pci_eq_presets *presets,
 				    int num_lanes);
+bool of_pci_clkreq_present(struct device_node *np);
 #else
 static inline int
 of_get_pci_domain_nr(struct device_node *node)
@@ -1106,6 +1107,11 @@ static inline bool of_pci_supply_present(struct device_node *np)
 	return false;
 }
 
+static inline bool of_pci_clkreq_present(struct device_node *np)
+{
+	return false;
+}
+
 static inline int of_pci_get_equalization_presets(struct device *dev,
 						  struct pci_eq_presets *presets,
 						  int num_lanes)
-- 
2.43.0


