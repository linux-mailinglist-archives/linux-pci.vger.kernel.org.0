Return-Path: <linux-pci+bounces-4596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538A4874D2B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 12:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041C31F2157D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 11:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB5686AC5;
	Thu,  7 Mar 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUDHioKo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC8B1D699
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810127; cv=none; b=WkD/10D/OEq7NlFnTKV4gjugkEkQvOlko4ALn4i+jM5jYKe7szbmW50UlJk9+BDCTy91t+7UOVvtRI1ykM3g2lo92StEi+J9vo1UF2aXDZ1T1z7hpzk+OrRGf1RrVJnOMBAlY3rxiow0KTIvdQbh+c+bab4pJxULPZxNJVEyRDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810127; c=relaxed/simple;
	bh=qd0J8r2LTsheerhK3I9PaS9sT/RPiIv/Y0rpWOFwo6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHL8kYF/nZzw75QG+T782dOyN2qJR7D5dPOPdcTMLEpypUO7GLfzxHsr6rpCzlKH+ZkcDBR1JTcbiEjEM7sF35Lfckgt7t4DI0OD7Z2caPuitcCO3FaPN7QH1ApasMHX9m3cgVtrzd8IENQJpsMnj2YVl3nwerGkH32UyCbGMiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUDHioKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C474C433F1;
	Thu,  7 Mar 2024 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709810126;
	bh=qd0J8r2LTsheerhK3I9PaS9sT/RPiIv/Y0rpWOFwo6c=;
	h=From:To:Cc:Subject:Date:From;
	b=sUDHioKomgMzYbtsjm/sfQD4BpyS03dPDJXWmcNbj0QMIAbIfOb+T0pHWoR4Jj8jl
	 WM4S9+hhDFmz7AOrfjjbDPNjGKQUUiYzYjOfaw2TyqnpCDTE2wXVpJt7ArLqCA4Hw+
	 vZuXJ7rYg1jgfxMgK9WUuz1dhjA6Is60HPY+p+3AoWiWZSriCaLiEylRrhjhY35ETj
	 wIZi5UD00PKVifEqXZIuHuQ85taawB6EwGg8XsYPnrYmsKZR7b5djSEYq+XVddhD47
	 Ewl2CilD/ZkL9JZ3jXdczvqE+AY+F01qMftVhCmTsAv3QO4xJUHqkGWa/VfjOpViKh
	 TFkYnh/UAjhng==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: dwc: endpoint: Fix advertised resizable BAR size
Date: Thu,  7 Mar 2024 12:15:20 +0100
Message-ID: <20240307111520.3303774-1-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit message in commit fc9a77040b04 ("PCI: designware-ep: Configure
Resizable BAR cap to advertise the smallest size") claims that it modifies
the Resizable BAR capability to only advertise support for 1 MB size BARs.

However, the commit writes all zeroes to PCI_REBAR_CAP (the register which
contains the possible BAR sizes that a BAR be resized to).

According to the spec, it is illegal to not have a bit set in
PCI_REBAR_CAP, and 1 MB is the smallest size allowed.

Set bit 4 in PCI_REBAR_CAP, so that we actually advertise support for a
1 MB BAR size.

Before:
        Capabilities: [2e8 v1] Physical Resizable BAR
                BAR 0: current size: 1MB
                BAR 1: current size: 1MB
                BAR 2: current size: 1MB
                BAR 3: current size: 1MB
                BAR 4: current size: 1MB
                BAR 5: current size: 1MB
After:
        Capabilities: [2e8 v1] Physical Resizable BAR
                BAR 0: current size: 1MB, supported: 1MB
                BAR 1: current size: 1MB, supported: 1MB
                BAR 2: current size: 1MB, supported: 1MB
                BAR 3: current size: 1MB, supported: 1MB
                BAR 4: current size: 1MB, supported: 1MB
                BAR 5: current size: 1MB, supported: 1MB

Fixes: fc9a77040b04 ("PCI: designware-ep: Configure Resizable BAR cap to advertise the smallest size")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Fix spelling of advertise (Bjorn).
-Add lspci output to highlight the problem (Bjorn).
-Add specific section and version when referring to the PCIe spec (Bjorn).

 drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 9a437cfce073..746a11dcb67f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -629,8 +629,13 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
 			PCI_REBAR_CTRL_NBAR_SHIFT;
 
+		/*
+		 * PCIe r6.0, sec 7.8.6.2 require us to support at least one
+		 * size in the range from 1 MB to 512 GB. Advertise support
+		 * for 1 MB BAR size only.
+		 */
 		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
-			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
+			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, BIT(4));
 	}
 
 	/*
-- 
2.44.0


