Return-Path: <linux-pci+bounces-43287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F36BCCBB75
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E4D23007E50
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 12:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F6E32E13B;
	Thu, 18 Dec 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxe0FiYA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A41432D7C8;
	Thu, 18 Dec 2025 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059495; cv=none; b=HVhZslKQjrM55uV9LyohxVe52bTn9eTOYrPZp57ur1pG1KX8bzhcyVKZZ2qVCRe7A2SMR9Lh4vJPcjqlo8VOyIX9OLUQ1y7jNorF95dqvEASgSHjSq8CuMYka/03sGcWvauhmxe/jwVeNDFdwXIwYq2DLFgG7bfHqB136+OaPmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059495; c=relaxed/simple;
	bh=kEAW493KahcKscqRPcFCD7IS36Rrl+jFykW0SAyMD68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFKiBIKi/yDJWokgvGp+mj601FzD3IGRoO/cup5aPNvxXuHYdTVut3g943vNOLkY7TMwU1xHy9SThp/Ef9Tz5McIjJcAuGJW7ml186lpka/ooaeVxCBsRT4KEvtr8xYGpPnbpFt/XO82405OnczvqnDG3MHiBb9f0732VKB0o68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxe0FiYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC95FC116B1;
	Thu, 18 Dec 2025 12:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766059494;
	bh=kEAW493KahcKscqRPcFCD7IS36Rrl+jFykW0SAyMD68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dxe0FiYAgxyHGs18/BM8oIrcWARWb00WBWLYflnJobBXkvTnZ3n5N4zFz9r62Ne83
	 8metoFmlbxPnXY9k0BmtV6jlr+wBhJv4QSKCZFHReM8U52Ee3okAx09XURSw/ktbOd
	 x39BXWctKYenrPYjah2HopqXoPD9DWlo1xNj6omHn1R/4n2RZN6sCD1zwWwbbBBtCK
	 Q6lAKA+SFUUyLSKFFx9iQoptMjskj9svErjTRd8G7B7UYeqjL3sfaYlHoJjHRSvcFP
	 XQW1+HfmWT1tDR4sdgHW+IEMfYj4Z5iGvuBw3vgZ++d8nGntWlITQRqr3gbXN5r1C4
	 UaSPg0GGsOjwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1DFD6ACF5;
	Thu, 18 Dec 2025 12:04:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 18 Dec 2025 17:34:52 +0530
Subject: [PATCH v2 1/2] PCI: dwc: Skip PME_Turn_Off broadcast and L2/L3
 transition during suspend if link is not up
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-pci-dwc-suspend-rework-v2-1-5a7778c6094a@oss.qualcomm.com>
References: <20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com>
In-Reply-To: <20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Frank Li <Frank.Li@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=zzm1js4g/wb9/28LZoMBiDrVq1+JGQ8PgCaGDVkxvSs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpQ+3laZ2TdGjXY+TPWcrdGBRDdPW7B7FcXIp27
 DNrZqWM4bmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaUPt5QAKCRBVnxHm/pHO
 9XTZB/4yPHL8Wjn52iy6qP+I1K8EXtv1sxI3nuQ+NSmi0q+YIqM8E04b/xCOgf6pvOLmcp+W3yV
 E7oNEl4+Eh0jGpJBUd2tueucmVGYODQDMBnNYAOAzHI7a/Q9y9QJ0Ax6czPZ4zP52tDpfpnlFp8
 h+8tuIf/L5DprSvFHPbYjxpmP/Tgrqbl8OZbo+hCVqLkWLmXZuRMXzbI0z26ywwWDdmkPANCt66
 qd9l6IWynASqsOntET8UJHhbMl5Rt6A0Qz2gf3lXW8WrUJf2zN7Giui7N5Llv7EGD0gV9M8Smcv
 PA7xqPWJ2SeJ6gL5j7O4N+fg2325R2HGbshrc3y2SIsEv70/
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

During system suspend, if the PCIe link is not up, then there is no need
to broadcast PME_Turn_Off message and wait for L2/L3 transition. So skip
them.

Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 372207c33a85..43d091128ef7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1161,6 +1161,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	u32 val;
 	int ret;
 
+	if (!dw_pcie_link_up(pci))
+		goto stop_link;
+
 	/*
 	 * If L1SS is supported, then do not put the link into L2 as some
 	 * devices such as NVMe expect low resume latency.
@@ -1194,6 +1197,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	 */
 	udelay(1);
 
+stop_link:
 	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);

-- 
2.48.1



