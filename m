Return-Path: <linux-pci+bounces-92-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B355F7F3DDC
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46631C21010
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DE6156FC;
	Wed, 22 Nov 2023 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnYkIZ3n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C1156FA
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20133C433C9;
	Wed, 22 Nov 2023 06:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633061;
	bh=NZLlFvUu/YC64dXfLuysBNU9Vdsp80DglSX+lO6Gyr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rnYkIZ3nhs79sSvWV1Cvmy0BLGZJ4MPSAfwy+UvELeXS2zI4uQqxGq6UhZnAhPoKR
	 L6FS2fHYYbPfdYdyOIvzqF9tKucWpEDALvV0tOdsC9qeNhp3NKxSwdW/bE6wdPp9iw
	 ik57tausRpC4N0bCAnU6hXPYUPHXIi1hYc/rhHywjGYZUEVjZvU6qLWcrUGb9e8+JH
	 prQn/+tjrIv5nXIgvAQczN85hbYHfyXYPR3D3ixZ4dZQd7E4dYkmyYCE1QT8rwh05y
	 5EpZY/JGNKw++wlUD3Mgr6o69dFJQ/8z98/TW9ynig6qdTuWjXaxt6mMchbDS0t9Sk
	 RKx6Fw9dE+Y+Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 07/16] PCI: dra7xx: Rename dra7xx_pcie_raise_legacy_irq()
Date: Wed, 22 Nov 2023 15:03:57 +0900
Message-ID: <20231122060406.14695-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the function dra7xx_pcie_raise_legacy_irq() to
dra7xx_pcie_raise_intx_irq() to match the use of the PCI_IRQ_INTX macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index f257a42f3314..caeae5c9ca2a 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -386,7 +386,7 @@ static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
 	dra7xx_pcie_enable_wrapper_interrupts(dra7xx);
 }
 
-static void dra7xx_pcie_raise_legacy_irq(struct dra7xx_pcie *dra7xx)
+static void dra7xx_pcie_raise_intx_irq(struct dra7xx_pcie *dra7xx)
 {
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_INTX_ASSERT, 0x1);
 	mdelay(1);
@@ -411,7 +411,7 @@ static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	switch (type) {
 	case PCI_IRQ_INTX:
-		dra7xx_pcie_raise_legacy_irq(dra7xx);
+		dra7xx_pcie_raise_intx_irq(dra7xx);
 		break;
 	case PCI_IRQ_MSI:
 		dra7xx_pcie_raise_msi_irq(dra7xx, interrupt_num);
-- 
2.42.0


