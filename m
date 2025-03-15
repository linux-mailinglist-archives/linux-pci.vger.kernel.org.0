Return-Path: <linux-pci+bounces-23864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEFBA63265
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 21:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBFA1897191
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 20:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44482063FA;
	Sat, 15 Mar 2025 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgZMAFNN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEFD2063DF;
	Sat, 15 Mar 2025 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742069773; cv=none; b=andud3hOwHmgRIEPEsHdYF5rCpeoBMMOaXj8dF7mSfPhcur/b+wIrvkVGRa+UY+YsiJxC+bzMWUK9cE0XOyN4cnTKVpDG/weO/iCJgL9AaXrrq/1xePCfsEPQ5iKFhUSLZUvPrzM6M7bHhEsidiDazJtH38Wzl9JeoEVgMWqRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742069773; c=relaxed/simple;
	bh=uYC48WL7Lbr53Qr5HSPcWtBot9HNlzJ+bYzVHHYAEG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BxbNYhOd1TF3R3qDdmIKAqi/T39QxdMTQuyimyiuAm2Lxcj3U7jetFjZDg1zxmdT2iu6NijNVuyvCn8VdEXhlQtgkZtzvZjo5a2Blv3tQjZjdx6ffQu2JzUi6JYuxJrUXMBT5cYAh6w1y8v1034KAgAfl/KzkYmH1fsugWcOtgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgZMAFNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCB1C4CEE5;
	Sat, 15 Mar 2025 20:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742069773;
	bh=uYC48WL7Lbr53Qr5HSPcWtBot9HNlzJ+bYzVHHYAEG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LgZMAFNN3mO+jZwZewQ14F+/AW5m4DbKlyRBhVugtgFCzmFrfFwBDwufrF9nvtCrg
	 H/VxU1BT8JqR1HJ9XM91jo38LuOGwx3cs5S0P9kvvVu1WjvrIgtCZm0E7pu6+1kI2V
	 3MECYKoIh/tL7+bmlvaMfcY+kR+mPfK3q5aRleucMCxSJdp3X3ynkvvI+DxxzUWUCD
	 CG/OnhqvSemOTHkknapp3glwpmCtmsEJC/xSs8LtgXXCC6s2llGUG7oiOvvtWOYHsb
	 YqxZpH0lN49s2gfDwexeMm3MBNdNc0vRsgMbJ3pG4YTaTvaTWoeQLAVNpORkLjRst5
	 ZRiuERdjuCkGw==
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
Subject: [PATCH v12 11/13] PCI: dwc: ep: Ensure proper iteration over outbound map windows
Date: Sat, 15 Mar 2025 15:15:46 -0500
Message-Id: <20250315201548.858189-12-helgaas@kernel.org>
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

Most systems' PCIe outbound map windows have non-zero physical addresses,
but the possibility of encountering zero increased after following commit
("PCI: dwc: Use parent_bus_offset").

'ep->outbound_addr[n]', representing 'parent_bus_address', might be 0 on
some hardware, which trims high address bits through bus fabric before
sending to the PCIe controller.

Replace the iteration logic with 'for_each_set_bit()' to ensure only
allocated map windows are iterated when determining the ATU index from a
given address.

Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-8-01d2313502ab@nxp.com
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index bb87d0c5c665..2ef9964fa080 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -282,7 +282,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	u32 index;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	for (index = 0; index < pci->num_ob_windows; index++) {
+	for_each_set_bit(index, ep->ob_window_map, pci->num_ob_windows) {
 		if (ep->outbound_addr[index] != addr)
 			continue;
 		*atu_index = index;
-- 
2.34.1


