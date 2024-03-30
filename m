Return-Path: <linux-pci+bounces-5441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13DD89294C
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 05:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3D12836BE
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 04:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359621FA5;
	Sat, 30 Mar 2024 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVEu0ICZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8F11C0DD5;
	Sat, 30 Mar 2024 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711772400; cv=none; b=sUJcouEqvxmIDT8EYX2Gs0P92FdApeD8eO9NPPp7pKYbGc5DbmmSuD3g3p56kFRrz5oBUsKFgPg8QyYpSBQU7HXSaOKaN+m5Iby5JYh8oVdoC5yJUdKUGmoL1G1cFUTj++oMP9DRECAXV0E3TRD6PiUtgHfmOKhYnLvAer1lnes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711772400; c=relaxed/simple;
	bh=AHRU08AWGRxB+Fqv67+pnAMmWjQzCx9M3EQLTVFxKzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GI9o99oShcEQn/OoCEg7e4j/Uh8VCqKCeElzM6bC1vd7MqW27mGPjKJ12Bz2k72i1J7/BUjAbd6H39XZbh78xpcKOPQ5m8GBoT8ZwmuxcGW+qO5uTCjPE31VMeZ7J80JZ/n1f2n+e5xODayPHeH4YqRTguWGT/FB5Q75u21Ilz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVEu0ICZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FDBC433B1;
	Sat, 30 Mar 2024 04:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711772399;
	bh=AHRU08AWGRxB+Fqv67+pnAMmWjQzCx9M3EQLTVFxKzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVEu0ICZCrtGtzWWJQeh1L986jHby9gZuEZAIvxIuirGuEr71Mg264ooyW0v1csCp
	 jznCpUGx49tsFZYuH/KTuh6qW17H9owW0raLHCuJNXDimddqNxXkw/YSTPx+C4x5Tt
	 8XlMzhU8pQ2JvkMD+5N+rdalubirMeqH+3t3IegNTPMqgITanPyZCa/R1XinbN+7zV
	 Sn4byoq3zZL6wQO6zsFKQM22umb1qmkWAJO+hODMIxv0+n5i+0PxRz0U1ieQJfjq6G
	 7/pTbu3Dr5pbS3JCQMsLvlFocPgpbPO+CINZE8ObhpNtfQ816mtXs7qSh3mTqzxran
	 ZBNY1+ia/ZeXw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 09/18] PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
Date: Sat, 30 Mar 2024 13:19:19 +0900
Message-ID: <20240330041928.1555578-10-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330041928.1555578-1-dlemoal@kernel.org>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
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
 drivers/pci/controller/pcie-rockchip-ep.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index f8c26606df58..93c2466d6fef 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -258,13 +258,9 @@ static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
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
+	if (addr != ep->ob_addr[r] || !test_bit(r, &ep->ob_region_map))
 		return;
 
 	rockchip_pcie_clear_ep_ob_atu(rockchip, r);
-- 
2.44.0


