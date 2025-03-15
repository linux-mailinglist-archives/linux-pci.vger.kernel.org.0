Return-Path: <linux-pci+bounces-23854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6448A6324A
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 21:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698AD3AF3B8
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 20:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413371A08BC;
	Sat, 15 Mar 2025 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9hWYw9W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABF319D89B;
	Sat, 15 Mar 2025 20:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742069758; cv=none; b=o4HcSCYMXOnpXRIwaBaV2bI74whjlU0i+bKNqKZFZ6tCjRDWPqiyMn/AbxemGIiat5WWxK+0wTdvIAa7mU/2hBSZBxk8h4mAFaZZrXGIpKOE5+egtYzqBWXQlKnjbuCFuAWju5EqG+QzJ8o65QA3xbSW3ItZuUM8K7dRasDdUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742069758; c=relaxed/simple;
	bh=ce45hTdaEpFy2QpraH0ZrMeEMIsCGcxs2/r8PQnCB4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HZOcnZ4IAjbN/pUvo8iM61YYpUcLomqdqUq3s4HljFgcBvoCvAhzuchHiFfG7GS65OfqEPaR6PRf1C25IqYbwz6PFMdb7Hde3q4rwJKjpgr2penyReUP04p44nio8x9qPeVrjOZMDTeVHAmsYza5NCHckCKqAWkmYOoglpf0XAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9hWYw9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56371C4CEE9;
	Sat, 15 Mar 2025 20:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742069757;
	bh=ce45hTdaEpFy2QpraH0ZrMeEMIsCGcxs2/r8PQnCB4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9hWYw9WrbGTWUJaOVmESjkIwtQr902psTdxYdA+Kty7jkGwfjdLBPBxkh8PguMGd
	 4cOCqpZ7BwFVe+Kd/oPf0HFffeRnxRUCsYDDBBUpmJhwW+GATHh9r5TJU69qG8aPLR
	 /ptE87LGlu+ASzit/SZmFK5szS5CqH4c/q9y2gvoTRdiXY3w/FO4E1jsvQmSv7gxmX
	 SJuLJ9Mu+bwnm2Eb2KO23zSaPK/Afhd5ejL4KIP5Ou7AQDOy7nuYoJLgjKA2XUN3En
	 IdYeTeCTA1u9SJW6FeCYI+Kd/ii5ZR5ZrUEXtgcSlNKh57oc2ASFbKQMwaeiZ2Canu
	 SIJfTIKCyzB7g==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 01/13] PCI: dwc: Use resource start as iomap() input in dw_pcie_pme_turn_off()
Date: Sat, 15 Mar 2025 15:15:36 -0500
Message-Id: <20250315201548.858189-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250315201548.858189-1-helgaas@kernel.org>
References: <20250315201548.858189-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

The msg_res region translates writes into PCIe Message TLPs. Previously we
mapped this region using atu.cpu_addr, the input address programmed into
the ATU.

"cpu_addr" is a misnomer because when a bus fabric translates addresses
between the CPU and the ATU, the ATU input address is different from the
CPU address.  A future patch will rename "cpu_addr" and correct the value
to be the ATU input address instead of the CPU physical address.

Map the msg_res region before writing to it using the msg_res resource
start, a CPU physical address.

Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-1-01d2313502ab@nxp.com
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ffaded8f2df7..ae3fd2a5dbf8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -908,7 +908,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
-	mem = ioremap(atu.cpu_addr, pci->region_align);
+	mem = ioremap(pci->pp.msg_res->start, pci->region_align);
 	if (!mem)
 		return -ENOMEM;
 
-- 
2.34.1


