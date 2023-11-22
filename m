Return-Path: <linux-pci+bounces-89-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2287F3DDA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92402B21A75
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF20154B3;
	Wed, 22 Nov 2023 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCjEvBM+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE16154AD
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11E1C433C8;
	Wed, 22 Nov 2023 06:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633056;
	bh=KWNPVKVPYqjly6eykHt+zYa040SbInFmJkimWSzApwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCjEvBM+fXdaAskOeA1444kp9KDBpD8E+U7hq6/4DiXuw5HTwIgav2HE/5tWj3rDY
	 kHtksmca8TZn3LEH1vszf2nLkjURqQVRtHGi8dkIB3qRMqYCRE5b5Rf2LdAzl9M2wR
	 d6FVN4NZtsiNT8ctg6VSC4LI/brPKoP6LpE5FJ5kHV4X1GeWezLHy5sr1BCvq2yQfN
	 uig0Z58wBQWzQtoHgT1adyHusYyIS5Zoe04r2HAvUATOofp1WR6fg91/NanfuUIfoJ
	 QbDhH0jsp/UaMzTKZFjIA2Ho8l5C/usWYxRrRdPR1cmiqahDRl7PLQH0VAJBhf9/+u
	 m84+RzCNY+FPA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 04/16] PCI: endpoint: Rename LEGACY to INTX in test function driver
Date: Wed, 22 Nov 2023 15:03:54 +0900
Message-ID: <20231122060406.14695-5-dlemoal@kernel.org>
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

In the endpoint test function driver, rename IRQ_TYPE_LEGACY to
IRQ_TYPE_INTX and COMMAND_RAISE_LEGACY_IRQ to COMMAND_RAISE_INTX_IRQ
to match the term used in the PCI specifications.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 9d39fda5c348..637a6a398203 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -19,11 +19,11 @@
 #include <linux/pci-epf.h>
 #include <linux/pci_regs.h>
 
-#define IRQ_TYPE_LEGACY			0
+#define IRQ_TYPE_INTX			0
 #define IRQ_TYPE_MSI			1
 #define IRQ_TYPE_MSIX			2
 
-#define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
+#define COMMAND_RAISE_INTX_IRQ		BIT(0)
 #define COMMAND_RAISE_MSI_IRQ		BIT(1)
 #define COMMAND_RAISE_MSIX_IRQ		BIT(2)
 #define COMMAND_READ			BIT(3)
@@ -600,7 +600,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	WRITE_ONCE(reg->status, status);
 
 	switch (reg->irq_type) {
-	case IRQ_TYPE_LEGACY:
+	case IRQ_TYPE_INTX:
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
 				  PCI_IRQ_INTX, 0);
 		break;
@@ -659,7 +659,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	}
 
 	switch (command) {
-	case COMMAND_RAISE_LEGACY_IRQ:
+	case COMMAND_RAISE_INTX_IRQ:
 	case COMMAND_RAISE_MSI_IRQ:
 	case COMMAND_RAISE_MSIX_IRQ:
 		pci_epf_test_raise_irq(epf_test, reg);
-- 
2.42.0


