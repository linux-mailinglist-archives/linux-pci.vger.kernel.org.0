Return-Path: <linux-pci+bounces-17207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6144B9D5E77
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 12:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFBB3B24EB9
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 11:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEC01DDC0C;
	Fri, 22 Nov 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE7Zvj5h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2826D1DC05D
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276665; cv=none; b=uD92CVCMAv+B6PWItoqMJkQvhC+Dp3S5eBknJJkW2K2TQAV5eTtqjn2URD4ECJhgvNjsjsb4i9yuBP5Sm53t7uREJikImY2+BCNtcLbjG4EhrbdnG6qdSRzQz9GMDEBU3Q5AKkvC5Vp0znSlQJGtqcOUk1OAF2SN031/7wh/PPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276665; c=relaxed/simple;
	bh=9w4djXq5Jah2Ystn3ezgbNxbPZ4VlU3yHv4SKjG7O9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fl+EwfRRZGdWUMgIiFuTWZKr1JseiAUXDtuOnLFnHYvpleha7g1A3tUqI64uYfGLF8zvUMqEx9NbjfXU2HIXemkj7wVRsZpQmMImDSx1gf9lTwnPMrmasdP3kyrTZPC3cIycV4Z86dXgsMjxi2GTwjBG7k48/nQilb0EjMyCfJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE7Zvj5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3994C4CED0;
	Fri, 22 Nov 2024 11:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732276665;
	bh=9w4djXq5Jah2Ystn3ezgbNxbPZ4VlU3yHv4SKjG7O9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PE7Zvj5heSieWpD3s9oUalXBThbliSN8EHs0GLZiS/+1+xgT+Ta3nu1Oj2tZ8Kwbi
	 gjtFQ014dXL/SOgIK/3meDxvy/ZuNjj/+HdpHH9ZKHwh47y+ZVX2P4Oek/feIadINk
	 lJfqMxDOras/TJFPMUV9AIf8oXHTGfsk1B5gyYyB3fTbYqj8l2vCOz9tQ2aRUVckWG
	 TH2ToFTA17IF//VeMcdPbKrYT8h013vueTeEer5e3yMreElFe02w4syyym1MBHC7/S
	 IC70NgTqCxNwYLPKh8jSxfHVYM7odYR0+zPKEQRgiAUYi6aTqLcpUG+NeQoeyQWuE3
	 AR6//tPNbSTMw==
From: Niklas Cassel <cassel@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 3/5] PCI: artpec6: Implement dw_pcie_ep operation get_features
Date: Fri, 22 Nov 2024 12:57:12 +0100
Message-ID: <20241122115709.2949703-10-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122115709.2949703-7-cassel@kernel.org>
References: <20241122115709.2949703-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=cassel@kernel.org; h=from:subject; bh=9w4djXq5Jah2Ystn3ezgbNxbPZ4VlU3yHv4SKjG7O9g=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIdCmczlk9SMehply5kaZSbcu+a+/5Trw5NTFL68FF4w zz7RU7eHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiIyCVGhoaC64JrLz6M37/3 qo6GGIv4HnPemLX9d3LmXJz+26X3bD/DXwGvI9+6Vt7c5aX8uri25On61rzUY7uaDq7PCj/bEZV 6mg0A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

All non-DWC EPC drivers implement (struct pci_epc *)->ops->get_features().
All DWC EPC drivers implement (struct dw_pcie_ep *)->ops->get_features(),
except for pcie-artpec6.c.

epc_features has been required in pci-epf-test.c since commit 6613bc2301ba
("PCI: endpoint: Fix NULL pointer dereference for ->get_features()").

A follow-up commit will make further use of epc_features in EPC core code.

Implement epc_features in the only EPC driver where it is currently not
implemented.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 drivers/pci/controller/dwc/pcie-artpec6.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index f8e7283dacd4..234c8cbcae3a 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -369,9 +369,22 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+static const struct pci_epc_features artpec6_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+};
+
+static const struct pci_epc_features *
+artpec6_pcie_get_features(struct dw_pcie_ep *ep)
+{
+	return &artpec6_pcie_epc_features;
+}
+
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.init = artpec6_pcie_ep_init,
 	.raise_irq = artpec6_pcie_raise_irq,
+	.get_features = artpec6_pcie_get_features,
 };
 
 static int artpec6_pcie_probe(struct platform_device *pdev)
-- 
2.47.0


