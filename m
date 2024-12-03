Return-Path: <linux-pci+bounces-17563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19EC9E1370
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 07:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B3C28268B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 06:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAB6166F1A;
	Tue,  3 Dec 2024 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKxoWVAi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD53398B
	for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2024 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733207948; cv=none; b=TQngoFb3l32RZ+ubVhfZ4X+DVFFb7JEEsg2Peh8S4Ag7S0vL8GmzvZROSX65gQBOMaw8bA701xGxXi/rizgLpMBf3mrvzL9C74aOYuWYvgSfJnLrsbT3Huk6aDhHqZt6gp336hcbGovSNbL5A9Yhdm9LHK5uljWRACZO9Mz4shY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733207948; c=relaxed/simple;
	bh=ejRcFwuh6AGywDeO3Y5iPWCDgG38QWGgF5C1LolMNtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bx4TKRqiZmBh6GOFlMX9EkfOT77ibzXma48v/ddlQUtWAP6qRFQxF+FLyYqPCfmsKwjFi14ra6b6fVJSaeB3vghNPUtVfTU7n2LYAsSFmMhOfYOtbEjafWuULwbaLbooBNh+hxxMZOxkkh6INeEVzXcE+PwfJzRB33ox567IiRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKxoWVAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F6BC4CED6;
	Tue,  3 Dec 2024 06:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733207948;
	bh=ejRcFwuh6AGywDeO3Y5iPWCDgG38QWGgF5C1LolMNtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKxoWVAiC/JFqHzkn3OST9yU4BVAjQJC1T+XLRA9FL8rUmZVbwh+9CdsoL6COA6JM
	 ZWjeLpf9UJ9OYieBcfIlz5VyCm3qv5q4pXtkSDqbqYCu3BOg7iNn7pjnwiGy8YFcwx
	 1WscdinIuk6zrzOR4t31g2BBEwkt288DrOSbXLQSxHJC19I3zlPkMK5LbtGBapV3av
	 VWE9Yk6T949/ppJtwgsOQsoaRTzOuUzEudYeGksocgzId9LShnSF/AeTLktHFdh2JA
	 vm4KkKTM448CnY7E4Zldq5b2F/k4UlN/IE+VIYjqmzXJUqPn2+BCu2z/6HKsndRNxi
	 S3BYKGfz/VuUg==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 2/2] misc: pci_endpoint_test: Add support for capabilities
Date: Tue,  3 Dec 2024 07:38:54 +0100
Message-ID: <20241203063851.695733-6-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203063851.695733-4-cassel@kernel.org>
References: <20241203063851.695733-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2851; i=cassel@kernel.org; h=from:subject; bh=ejRcFwuh6AGywDeO3Y5iPWCDgG38QWGgF5C1LolMNtA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL9ljc2vdy55VFU6MTgPwX5ThXhCvMqn+clq16VvHZy5 i6hyfahHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjI9cmMDA/NZllMveHxb86Z q/cuuK5y4DGw077nZb8zRq3p6N/23kaGv+KfEytYWlZtapZfsH3iKjsJpm5FD4U3qT+/PWNKC4z q4wMA
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee..8a31bd4c237d 100644
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
@@ -805,6 +808,20 @@ static const struct file_operations pci_endpoint_test_fops = {
 	.unlocked_ioctl = pci_endpoint_test_ioctl,
 };
 
+static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	u32 caps;
+
+	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
+	dev_dbg(dev, "PCI_ENDPOINT_TEST_CAPS: %#x\n", caps);
+
+	/* CAP_UNALIGNED_ACCESS is set if the EP can do unaligned access */
+	if (caps & CAP_UNALIGNED_ACCESS)
+		test->alignment = 0;
+}
+
 static int pci_endpoint_test_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *ent)
 {
@@ -906,6 +923,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		goto err_kfree_test_name;
 	}
 
+	pci_endpoint_test_get_capabilities(test);
+
 	misc_device = &test->miscdev;
 	misc_device->minor = MISC_DYNAMIC_MINOR;
 	misc_device->name = kstrdup(name, GFP_KERNEL);
-- 
2.47.1


