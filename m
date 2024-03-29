Return-Path: <linux-pci+bounces-5384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094D1891572
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 10:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B01A1C2154B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C2636AE7;
	Fri, 29 Mar 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcUYOsPl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C122C6AA
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703403; cv=none; b=ozNt1GhHge6qy2UrWojcXlX3OkWHgkzvg0EJgFm2ehNteGtqjUAckO0oddq5gofNYLj82saiX6OInBZepgjGZTD+sXJmE32rRJhBy63EYVGJjt4KIZ4lg5At3yW/j1N/+Ih1k49cAkLRvLpYK2bqza3W2HruOArZsh1smvC82fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703403; c=relaxed/simple;
	bh=aUn36xuvuaMnSLvVIxSZrVLaOID09mKh7f0aChbzrms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyLSFiwddmdHtAf0s3lWJnRUOBOyQZvQRCfAyFtglKmTUnyNvSDQvVoM086kNXadP+xLDe9xwlAkOe5hlikSA9uncm4XzRAncOJySfFi+tx/2ZhRNi4K8aI429LpqrFFFa50or1HzxtiQCxUeLLqWlkQilEc6QHabg9yjQRv/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcUYOsPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131ABC433F1;
	Fri, 29 Mar 2024 09:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703403;
	bh=aUn36xuvuaMnSLvVIxSZrVLaOID09mKh7f0aChbzrms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UcUYOsPlM8nRJw00dIoGmQlUfCRnj4GqVbFuC9uHNT6bzcPOinci/SY5TJgKJw77G
	 P+YB1KCbf/Ul1Y5xh0hc+P9u5YINvKy/sDaJKrqGQS8lBrju0LGr2jd14q6nt1hABV
	 uwz81Td74Ca+gZBjF9x+RYDUpTuuN+5tw2TOYFUi21Hwd3uVKcjk4s0kfAd71heayM
	 5wLq4+++YvKzY9klIjRSbVNb5N41f4xl8O70CW/M8AI/3d9DTPKGzMbS/qbo9Q0JNG
	 IrFlF714JmcG9NICvgwdVPDeOe7sQB99FEbJXJ/qTfnWySOfy60fvYG++ue8ty3qbM
	 13iFHn2Ooe1zA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH 10/19] PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
Date: Fri, 29 Mar 2024 18:09:36 +0900
Message-ID: <20240329090945.1097609-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329090945.1097609-1-dlemoal@kernel.org>
References: <20240329090945.1097609-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

There is no need to loop over all regions to find the memory window used
to map an address. We can use rockchip_ob_region() to determine the
region index, together with a check that the address passed as argument
is the address used to create the mapping. Furthermore, the
ob_region_map bitmap should also be checked to ensure that we are not
attempting to unmap an address that is not mapped.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index f8c26606df58..296916d4a6e4 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -258,14 +258,10 @@ static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u32 r;
-
-	for (r = 0; r < ep->max_regions; r++)
-		if (ep->ob_addr[r] == addr)
-			break;
+	u32 r = rockchip_ob_region(addr);
 
-	if (r == ep->max_regions)
-		return;
+	if (addr != ep->ob_addr[r] || !test_bit(r, &ep->ob_region_map))
+                return;
 
 	rockchip_pcie_clear_ep_ob_atu(rockchip, r);
 
-- 
2.44.0


