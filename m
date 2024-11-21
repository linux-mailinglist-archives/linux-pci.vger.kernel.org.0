Return-Path: <linux-pci+bounces-17170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6789D4FA1
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 16:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BDC1F22E9B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 15:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF4713AD3F;
	Thu, 21 Nov 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJ3ASW38"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9765327447
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202615; cv=none; b=M0EK2hMokEc9eMbuGtNMYil6U97hltpraP1ustsAvytcOsV7kSgZ2BJSOCmjQtG8WfeVSBj1pqm34ZYW2HzcG6Amu0vh1pddgo9ntLG8W9J7OvG9iDWcf2Dsv/4fHcmOCDYn/3LhDNXWynSJXJch0meZ/cucdmdgp5q7kuVi66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202615; c=relaxed/simple;
	bh=rsNaHFbLeBwoCGa60pK1KRQjSKtnvcjdh9MW8Fgv7go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aklE5+HQw5sFJV5x+XIGQWnrz/z7wnv3gdwGKqnm8+m/fLmeHm8YHj9OXjpXF2lULW/wsqJKRxxpVe01YVgQC3Z4FyYSSH4Xi0+PG9QdSXOtjrP9yT4ed8e18hnk7uaHKcP0OTzqrya9vfzVKoGqrEbsZw8bO7wol2nawlzZcys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJ3ASW38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C04C4CED0;
	Thu, 21 Nov 2024 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732202615;
	bh=rsNaHFbLeBwoCGa60pK1KRQjSKtnvcjdh9MW8Fgv7go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJ3ASW386vS3ezmekHoVinsEZKrcweLV0w0wLi4PfPFdbgjthCFaIbH8B0XfNICe1
	 uX8XNc47v91b2R42XFRoKPei9HtePaipqjP3xlUKZwcvhat5WB9rk4u3EIQyA+Qu8A
	 hmNvA3Qm5VbMeLuoqVBVpVLiibYEWZt4gjCMAzLJ5Fo/tQxOlwFsPiEHubnT3+vHwK
	 rAKPRybYJ68IK0YkWTmE1jkEc76JYckyZmFwQnKQ2N88uCMAnEKT4me9Hwas9LLI9T
	 FwwUJ7E+exSr1xTXAp+T0iwuRRqyLo+b8nkEkfQ8NlxkarXJIAc2GHyyyxkPwrLO14
	 0ZL0whacY4tYQ==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 2/2] misc: pci_endpoint_test: Add support for capabilities
Date: Thu, 21 Nov 2024 16:23:21 +0100
Message-ID: <20241121152318.2888179-6-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121152318.2888179-4-cassel@kernel.org>
References: <20241121152318.2888179-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2787; i=cassel@kernel.org; h=from:subject; bh=rsNaHFbLeBwoCGa60pK1KRQjSKtnvcjdh9MW8Fgv7go=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLtA7I2MXJsYI/mlv8lGnbkTGdWZUTlWg2f1nu723+a7 Y7gXz21o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABMxU2T4XxficnjSnLylrR+2 r7LffCa9dfrLqUnvpvXtFlg/5Ut0oDkjw9Rz+SsfGS3+XvNl4bujbx5eKNre3N0RkpYY/ihF85X 0ViYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The test BAR is on the EP side is allocated using pci_epf_alloc_space(),
which allocates the backing memory using dma_alloc_coherent(), which will
return zeroed memory regardless of __GFP_ZERO was set or not.

This means that running a new version of pci-endpoint-test.c (host side)
with an old version of pci-epf-test.c (EP side) will not see any
capabilities being set (as intended), so this is backwards compatible.

Additionally, the EP side always allocates at least 128 bytes for the test
BAR (excluding the MSI-X table), this means that adding another register at
offset 0x30 is still within the 128 available bytes.

For now, we only add the CAP_UNALIGNED_ACCESS capability.

If CAP_UNALIGNED_ACCESS is set, that means that the EP side supports
reading/writing to an address without any alignment requirements.

Thus, if CAP_UNALIGNED_ACCESS is set, make sure that the host side does
not add any extra padding to the buffers that we allocate (which was only
done in order to get the buffers to satisfy certain alignment requirements
by the endpoint controller).

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee..caae815ab75a 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -69,6 +69,9 @@
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
 #define FLAG_USE_DMA				BIT(0)
 
+#define PCI_ENDPOINT_TEST_CAPS			0x30
+#define CAP_UNALIGNED_ACCESS			BIT(0)
+
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
 #define PCI_DEVICE_ID_TI_AM64			0xb010
@@ -805,6 +808,22 @@ static const struct file_operations pci_endpoint_test_fops = {
 	.unlocked_ioctl = pci_endpoint_test_ioctl,
 };
 
+static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	u32 caps;
+	bool ep_can_do_unaligned_access;
+
+	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
+
+	ep_can_do_unaligned_access = caps & CAP_UNALIGNED_ACCESS;
+	dev_dbg(dev, "CAP_UNALIGNED_ACCESS: %d\n", ep_can_do_unaligned_access);
+
+	if (ep_can_do_unaligned_access)
+		test->alignment = 0;
+}
+
 static int pci_endpoint_test_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *ent)
 {
@@ -906,6 +925,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		goto err_kfree_test_name;
 	}
 
+	pci_endpoint_test_get_capabilities(test);
+
 	misc_device = &test->miscdev;
 	misc_device->minor = MISC_DYNAMIC_MINOR;
 	misc_device->name = kstrdup(name, GFP_KERNEL);
-- 
2.47.0


