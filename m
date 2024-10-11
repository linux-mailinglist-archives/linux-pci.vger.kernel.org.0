Return-Path: <linux-pci+bounces-14299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA47799A396
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71A6DB2523D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A717B217319;
	Fri, 11 Oct 2024 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s36W3gor"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16021500F;
	Fri, 11 Oct 2024 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648865; cv=none; b=mNgZ8vVtznxIhNjW0LN7C++zhBitSwUjNsk2OBESCjgxOEVXeJKpxQnH3ZEvEW40Tb9gv5evHlRX3a2LtHYnvBY2PHIavSOXAJO6iepE8nMvzvsR6I+7EtePxtOfkUh9XdStcdA7zMo8bLMNBUf96kQV13begDZF5BSTEDtmYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648865; c=relaxed/simple;
	bh=AtL3wqZlgNHrOyE2iIK25JTRKHMyE6T82EANDhLV1k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gozVLEKs50IPlPj3v3XDC+zNNx8znPFhAuaFg2hvhoQAnBtPuWx8vyKbBNQKZGDFraEaJiF37ho3tJG0e806RZT20AHMu4WwEzr2+aNQoGDvWZpQ+fulqOBFwq74717qDcH10+QCI0D1xxUPWpol1+2Bh61kNYEZJVwnH/WIRNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s36W3gor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6651FC4CECD;
	Fri, 11 Oct 2024 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648865;
	bh=AtL3wqZlgNHrOyE2iIK25JTRKHMyE6T82EANDhLV1k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s36W3gorBP7MwuE5WElXCLsAr4VH32ZIegMavgI0OayahQfteFzaTzPMsOIQzZ+XL
	 bwsdUazDdU6b6EqjMnJlbIeGsonfpVMUuRhyH4896qT8zm2E92h0amWCk/Yrrz2WyI
	 Di70eysnf3bR0rrinuP+H0qaSWzGBEkZyWQCL3Zcnudeys7mtzW4+mx7MUc3HPRMm1
	 Xm/5LEgb9nGNyx1qdkj+a07EVpQQNKc8YP1y3uWVB7F7XCctjUJs1yFWV/HuYH7JBD
	 8ZAszfX72PGWwcIqf99poPITjiGkudQVoPxbYYPPk5PdtiptqXixJtPsM1y22taKkp
	 8R+zlJf9XAcdw==
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
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 06/12] PCI: rockchip-ep: Rename rockchip_pcie_parse_ep_dt()
Date: Fri, 11 Oct 2024 21:14:02 +0900
Message-ID: <20241011121408.89890-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011121408.89890-1-dlemoal@kernel.org>
References: <20241011121408.89890-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To be consistent with the usual "get_resources" naming of driver
functions that acquire controller resources like clocks, PHY etc, rename
the function rockchip_pcie_parse_ep_dt() to
rockchip_pcie_ep_get_resources().

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index c9c2bb72771f..e8409106bfb2 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -489,8 +489,8 @@ static const struct pci_epc_ops rockchip_pcie_epc_ops = {
 	.get_features	= rockchip_pcie_ep_get_features,
 };
 
-static int rockchip_pcie_parse_ep_dt(struct rockchip_pcie *rockchip,
-				     struct rockchip_pcie_ep *ep)
+static int rockchip_pcie_ep_get_resources(struct rockchip_pcie *rockchip,
+					  struct rockchip_pcie_ep *ep)
 {
 	struct device *dev = rockchip->dev;
 	int err;
@@ -552,7 +552,7 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	ep->epc = epc;
 	epc_set_drvdata(epc, ep);
 
-	err = rockchip_pcie_parse_ep_dt(rockchip, ep);
+	err = rockchip_pcie_ep_get_resources(rockchip, ep);
 	if (err)
 		return err;
 
-- 
2.47.0


