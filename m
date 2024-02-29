Return-Path: <linux-pci+bounces-4258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6BC86C9ED
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 14:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78831282EAC
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D927E0F0;
	Thu, 29 Feb 2024 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh8thTD8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061CB7E0EC
	for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212442; cv=none; b=d78UzBZRpnir4xZ6rk2RKDgl6EtyxAel5CgsFkjBJZJusX8+hIT6fUOxMrGIjwgPd86rTpB5GLndzXDMtFqgAzRYn+dzyv668iRMCTrvrjHf79NBuvXyBWKGe9SMl4IgZGwhm+lowjV6M5LDhMTmAfvuKU9Au0VrD/BgXx3+GnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212442; c=relaxed/simple;
	bh=FOhbF4m9VCW85h3lBEJZPwXxnXu4DigXHek5s2kXYvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQG8GmWGWPgt5mocGs7YpEB8FDKYVALW1N1g4yRrcqzKWsYMzN+Zciq/le1crRiSepzm+HNAwkBuatzDKJLG92mbaQpLzyyPOKZBPi+2wan6wxIZXQcNQ151ryOK0M2VQkzFOhu734XQXSlEzp6Ajw48+tsPeyZjtc8kFOiXvsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh8thTD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AB7C433C7;
	Thu, 29 Feb 2024 13:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709212441;
	bh=FOhbF4m9VCW85h3lBEJZPwXxnXu4DigXHek5s2kXYvs=;
	h=From:To:Cc:Subject:Date:From;
	b=Fh8thTD8CKNM7UFaRVVx89U1ax60Ch2RqYh1hgvo2dXmmP2XN9H2HpC/KmyfP7kAl
	 sDUl7lIb9h1nB0q3Y0A4tkBLjLvKd20dcUn/Hspf46tW38eTJubcK/UpyDc4BW3fdz
	 xXjC5+Gv0/fczJgKqL/rCkDjY/1JBFtv9CRDILOhK2uZfI2+1VSriXusl2X/hgDyzH
	 lFoNpwTQh186WKny3UgJF1CUbpVzqZEs4FLFzRuv1bnWhnP2+g/kRF9XaYQTaU/u2R
	 gszSB1+i7tDzs6LuNq5QXgC00qTWizLhaeGNFW7053DEnWxMZ21AkEsFW3mQ9SOEdZ
	 VRrsSRey+4wOw==
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
Subject: [PATCH] PCI: dwc: endpoint: Fix advertized resizable BAR size
Date: Thu, 29 Feb 2024 14:13:13 +0100
Message-ID: <20240229131313.1199101-1-cassel@kernel.org>
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
the Resizable BAR capability to only advertize support for 1 MB size BARs.

However, the commit writes all zeroes to PCI_REBAR_CAP (the register which
contains the possible BAR sizes that a BAR be resized to).

According to the spec, it is illegal to not have a bit set in
PCI_REBAR_CAP, and 1 MB is the smallest size allowed.

Set bit 4 in PCI_REBAR_CAP, so that we actually advertize support for a
1 MB BAR size.

Fixes: fc9a77040b04 ("PCI: designware-ep: Configure Resizable BAR cap to advertise the smallest size")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
I'm working on a series that adds proper Resizable BAR support, but it is
taking longer than expected, so I'm sending this fix first.

 drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b..bb759a7b5fc7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -627,8 +627,13 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
 			PCI_REBAR_CTRL_NBAR_SHIFT;
 
+		/*
+		 * The PCI Express Base Specification require us to support at
+		 * least one size in the range from 1 MB to 512 GB. Advertize
+		 * support for 1 MB BAR size only.
+		 */
 		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
-			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
+			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, BIT(4));
 	}
 
 	/*
-- 
2.44.0


