Return-Path: <linux-pci+bounces-38027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47FFBD89C1
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 11:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECBE1923E5C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 10:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3792FDC31;
	Tue, 14 Oct 2025 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CW4Fk7su"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34262EBDC5;
	Tue, 14 Oct 2025 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435944; cv=none; b=VfHuOlVUto5hGV/xzOG1JphDfT2y8VdI3uLoce3SWD/u0lUCiHNrEHlXHAlTrMtPf/GxeOg4RagZ5eZ3SJPzT/kpSnGBfo98fUueucS5Kx0vzzQur+Lpwn7jNmymZ9VyiLdR9Qqe0IID/yAbXgkB7wLuEkZWW0/mHjl7ioPL2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435944; c=relaxed/simple;
	bh=web6L5TPZtt08mmDaVYY7W2Sw34M19ouNiW4LSSozIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUNn3W8c5OJwifl+0HQwDhpDvhVDFJKhnpAJNKmFBnHOWLMR7tTrtSFloZHfI1wlQPP6PEtMz8rwA2s11goJ9GGZaepaRq09B5QpT3iUc15B3biWuYROgE5+ML5TmciU7608lYGkwAVKMVGOovXSSYe7cK4t4CR7uiyRvhY8eJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CW4Fk7su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD593C4CEFE;
	Tue, 14 Oct 2025 09:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760435944;
	bh=web6L5TPZtt08mmDaVYY7W2Sw34M19ouNiW4LSSozIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CW4Fk7su9ktygG9em7DYneoB5NZEhF1lHm6qbCu+Glsy/c/BN3c30aeBMbgwEv/RE
	 kFmBrCAtgTDaHTponbit3MU91WvDRrIHFX1BtJb1jWWm87OV3le2lgbeziOMfMtJ3n
	 WxSy3lnCrhiys6R0E1RsOdaKAXnK2MjvD42z5rzMLq1oESvB8QoDro5vDjqXpgEROP
	 HpgGtvLuiBn/UM1140634Z74Avx+Cv5N0WfRGEQO664AyP062nmzcPgLMkiF/x56mQ
	 CAIv9U4TZRomqdQ3tTakBkJcKPjCdjKypYs9mc04vRR8VnviUETrfFkCaDrfT1651z
	 ZOS6VC270CVnA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 3/4] PCI: iproc: Implement MSI controller node detection with of_msi_xlate()
Date: Tue, 14 Oct 2025 11:58:44 +0200
Message-ID: <20251014095845.1310624-4-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014095845.1310624-1-lpieralisi@kernel.org>
References: <20251014095845.1310624-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The functionality implemented in the iproc driver in order to detect an
OF MSI controller node is now fully implemented in of_msi_xlate().

Replace the current msi-map/msi-parent parsing code with of_msi_xlate().

Since of_msi_xlate() is also a deviceID mapping API, pass in a fictitious
0 as deviceID - the driver only requires detecting the OF MSI controller
node not the deviceID mapping per-se (of_msi_xlate() return value is
ignored for the same reason).

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
---
 drivers/pci/controller/pcie-iproc.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 22134e95574b..ccf71993ea35 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -17,6 +17,7 @@
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
@@ -1337,29 +1338,16 @@ static int iproc_pcie_msi_steer(struct iproc_pcie *pcie,
 
 static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
 {
-	struct device_node *msi_node;
+	struct device_node *msi_node = NULL;
 	int ret;
 
 	/*
 	 * Either the "msi-parent" or the "msi-map" phandle needs to exist
 	 * for us to obtain the MSI node.
 	 */
-
-	msi_node = of_parse_phandle(pcie->dev->of_node, "msi-parent", 0);
-	if (!msi_node) {
-		const __be32 *msi_map = NULL;
-		int len;
-		u32 phandle;
-
-		msi_map = of_get_property(pcie->dev->of_node, "msi-map", &len);
-		if (!msi_map)
-			return -ENODEV;
-
-		phandle = be32_to_cpup(msi_map + 1);
-		msi_node = of_find_node_by_phandle(phandle);
-		if (!msi_node)
-			return -ENODEV;
-	}
+	of_msi_xlate(pcie->dev, &msi_node, 0);
+	if (!msi_node)
+		return -ENODEV;
 
 	/*
 	 * Certain revisions of the iProc PCIe controller require additional
-- 
2.50.1


