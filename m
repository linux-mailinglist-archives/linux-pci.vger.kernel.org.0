Return-Path: <linux-pci+bounces-24035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 142A9A67160
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 11:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4AEF7AB2BD
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5875206F18;
	Tue, 18 Mar 2025 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MngzIVoH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B127E202997
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294085; cv=none; b=pGpunpPIjRT44aGF+LR4o5Q5mXZcwX0dDYvMrTyeNtDTFzmHamqOfd2rUp4KxJed6Icarf4v2CZPlRSKqR11FYardo4dYtgcJtbY80TtujrMg75R9EoHQREc4CwOwy42petWpS87eV959xTsglQEJWDZBbD9MR0ZaqMdr0D/zb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294085; c=relaxed/simple;
	bh=vWFbYZ4X7nT2H0Gc1jZ4SL8M29/PajaJvftiDxaBDr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOOVd+Qv8Tsy0eyIESfnNUwU/8a6wOHV61xacJOl1U58QRZYe4C0HKygfBcWbEBFj2SkcZxOG/byFfZnUDu7n9l5eTE0Yf+KKyPdcsnW8jHjunKzlQ11p3P088/EBakGwxttdIu+lyDG0/ru1AKCZsNdOFVH4X9tJSohjihHz4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MngzIVoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDB5C4CEEE;
	Tue, 18 Mar 2025 10:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294085;
	bh=vWFbYZ4X7nT2H0Gc1jZ4SL8M29/PajaJvftiDxaBDr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MngzIVoHxqVQFjyY4Ty9x9V3vLytdgbPhwJZbq1ALifMVNdHmLRBEzGg4fpsO2BW9
	 2oisLRm39SfzbITnLZHuhQxO17/DH3UrJZOMQ/z92QsUBZKNdwlzw8jk+0hMNbsYze
	 iU1SLOECAe6iluU3hXZTeb5pEmt2iRQwj/s2M7/lXV9mIXNKGR3iaxX8jQJnaFqbqg
	 YFU+toVHRUX94K47CZp0eNEXXz5/teGduhemf8FGamsts7XsEhjxBhGr4INLzTqCyc
	 0a3Um2SKhpUN5kAS32oaKoS/dPACcQxBSGVQ3Lf8iwUPZzBD7gf5lrXhWpDTV0dqd2
	 rIn5IsRr7tZFg==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/4] misc: pci_endpoint_test: Fetch supported IRQ types in CAPS register
Date: Tue, 18 Mar 2025 11:33:33 +0100
Message-ID: <20250318103330.1840678-8-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318103330.1840678-6-cassel@kernel.org>
References: <20250318103330.1840678-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623; i=cassel@kernel.org; h=from:subject; bh=vWFbYZ4X7nT2H0Gc1jZ4SL8M29/PajaJvftiDxaBDr0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJvev/b+3Dx3+X/2NM33y2czb3pTwjr3ntaFjkKZ7btP h/HHbCtuKOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATeVjJyPC/4uBBLe9DWk02 HNcV3Q6GH+bg8chuK73ZV5il9iUpvZ2R4djnPJeCzdk8updLPt5sK/WboyLn3Hsm2ePRvMUfGc/ +ZwQA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Fetch supported IRQ types in CAPS register and save them in struct
pci_endpoint_test.

The supported IRQ types will be used in follow-up commit.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 849d730ba14dd..3c04121d24733 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -66,6 +66,9 @@
 
 #define PCI_ENDPOINT_TEST_CAPS			0x30
 #define CAP_UNALIGNED_ACCESS			BIT(0)
+#define CAP_MSI					BIT(1)
+#define CAP_MSIX				BIT(2)
+#define CAP_INTX				BIT(3)
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
@@ -112,6 +115,7 @@ struct pci_endpoint_test {
 	struct miscdevice miscdev;
 	enum pci_barno test_reg_bar;
 	size_t alignment;
+	u32 ep_caps;
 	const char *name;
 };
 
@@ -892,13 +896,12 @@ static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
 {
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
-	u32 caps;
 
-	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
-	dev_dbg(dev, "PCI_ENDPOINT_TEST_CAPS: %#x\n", caps);
+	test->ep_caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
+	dev_dbg(dev, "PCI_ENDPOINT_TEST_CAPS: %#x\n", test->ep_caps);
 
 	/* CAP_UNALIGNED_ACCESS is set if the EP can do unaligned access */
-	if (caps & CAP_UNALIGNED_ACCESS)
+	if (test->ep_caps & CAP_UNALIGNED_ACCESS)
 		test->alignment = 0;
 }
 
-- 
2.48.1


