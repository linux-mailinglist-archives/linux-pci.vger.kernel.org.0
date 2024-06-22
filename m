Return-Path: <linux-pci+bounces-9117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B953291342C
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 15:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D701F2229B
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 13:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3D14D701;
	Sat, 22 Jun 2024 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/i3KwmM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EFB9449
	for <linux-pci@vger.kernel.org>; Sat, 22 Jun 2024 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719062447; cv=none; b=NbNYXwqIxxsxibv561l9EDJJmt0+BeSB5SmJ+EZZFbrL8S5Wg9XDup4py+XB7VH/PzYAEgW508aV2AFknQJohE2Zd8va1+nsfUy3kj6bYQbk+3QTlZ36NJvPm+UbI1qTk3uyEVHZOCW8h6kk2NihQit+EToZ2J+uK5w7NdzHYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719062447; c=relaxed/simple;
	bh=vimpA/8njPUgu92Mj2yrauXhwt2PHMqiXCQ/XhdBnBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZJ2cjkyfgnBb/gse5QKPHcpG2amOCD+ctb/xfs3kuKLnCLNbLj3QlC0jfFoO29F+W4B28bq3eh5S2rw1skREl18nzkIwUkdqfJifkAPcEZIude14LjjqDIfRA9IkKvdn53mms8RkaVNdtEf4kjtSi0cOinuCUIuC7XfBZ52CRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/i3KwmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC92C3277B;
	Sat, 22 Jun 2024 13:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719062446;
	bh=vimpA/8njPUgu92Mj2yrauXhwt2PHMqiXCQ/XhdBnBw=;
	h=From:To:Cc:Subject:Date:From;
	b=F/i3KwmMa7mrytFAuIbvmzFpOK8Mu+hFeFFSvoHRdAEzxoHzg681hvSMr4vyPaDYo
	 xnLDNqo9VXl8TaxokNDQduv4druWpnrGC5oGYbCv1429ZVEMVhTBij1zbtWv046fKz
	 ZPFCjoe3nT0udu7JTtq+2p5sLZdmYcBka/OovQa9iqcC/T/PCiK0lOzq/tF7d2Kp9y
	 gVAi46g9IDvdE7nKBHsjKbnWQ+rQb32bSdQifIax3YwXb7iEug4wK0qy4Qc0tWSlFq
	 mPk02ZhzAjnbxO6iPtrsDoGdu2jmDKeDx41qt2v6XFH6f4dZ0IRxzKxsKlCohFCLwT
	 QKcwr1gwPyJbw==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] PCI: dw-rockchip: Use pci_epc_init_notify() directly
Date: Sat, 22 Jun 2024 15:20:25 +0200
Message-ID: <20240622132024.2927799-2-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=cassel@kernel.org; h=from:subject; bh=vimpA/8njPUgu92Mj2yrauXhwt2PHMqiXCQ/XhdBnBw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLKzs/42POz3ree47z5GdY2O05uRl3nHS4cB1bNe7AtJ SD7LNuVjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEykpozhv9/zh0fndj5q1L1f +VwsmL1+p+q6n1fO+ry/5h3Sq3brhSojw879KU/cxHb/331f0HjaPJkNu3r78nvEfsx80Svut8T tLwMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit 9eba2f70362f ("PCI: dwc: ep: Remove dw_pcie_ep_init_notify()
wrapper") removed the dw_pcie_ep_init_notify() wrapper, and changed
the DWC glue drivers to instead use pci_epc_init_notify() directly.

The endpoint support for the dw-rockchip had not been merged at that
point in time, so commit 9eba2f70362f ("PCI: dwc: ep: Remove
dw_pcie_ep_init_notify() wrapper") did not update dw-rockchip.

Do the same change for dw-rockchip, so that the driver will not try
to use a function that has now been removed.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 0a0fdfc66b91..1170e1107508 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -488,7 +488,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 		return ret;
 	}
 
-	dw_pcie_ep_init_notify(&rockchip->pci.ep);
+	pci_epc_init_notify(rockchip->pci.ep.epc);
 
 	/* unmask DLL up/down indicator and hot reset/link-down reset */
 	rockchip_pcie_writel_apb(rockchip, 0x60000, PCIE_CLIENT_INTR_MASK_MISC);
-- 
2.45.2


