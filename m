Return-Path: <linux-pci+bounces-15270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6A9AFB8F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 09:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CCA2843CA
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 07:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7EF1C07F7;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/6DztWd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48B9193089;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842902; cv=none; b=uzkZw0RbJw4CDixAgXPeJgyCitCB58gGw9AthOfuMzXSNFkFV+kPbk9SAVzpzYgt8MT41cjxO7H5dJZHGbFN/hN/iqIxm7rIiBCvnUcfXhmbnkQxZXiHsvTEBngAFpzS3Sd9V4P73O+2Sq/qNB5cBuS5rfee6CtFjgcJka2fTuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842902; c=relaxed/simple;
	bh=ZPXEmnQxffSGRrG7FdHYnp1Yr705CCZ2f1l4xDtJb14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d3TY9Y2c+jUvya59dovGWBXkgOGiYJe5HbuCquwQzW7ucQI6XyhyAkETMIwbF35fVSCKc/Ttjwj6H2nSh1mgZ/MU3oM3ZSOXCtzLP+sPImesE5C1Zt/n/74v5QYasgtyNY/yGknhaN62xxO7YB257bizqRyymDOBoZ31KquADWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/6DztWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D0A2C4CEE4;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729842902;
	bh=ZPXEmnQxffSGRrG7FdHYnp1Yr705CCZ2f1l4xDtJb14=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O/6DztWdB0v0irAzlEJqmkge89LDV3w8j0lPl+aRskLVCE6SaNG46TAonsJD5uMCi
	 shXJHYQP9TeC+xnBTC0u1VClkbMreEE7KiAg1ij0Z+4/BE10I78Mx9mm8HW/FSjiug
	 gpY5LBtQ4QpILdASKACbqGsLVES4IUKZ5FyWMUN46WzSTH/+qNbvdL7GI9PW/0TPw8
	 kON0ZghiXInaQ4KOQPR0jM3pbApbdNI9+1OfLt5hBs1yqZpzmlcp3l46tyda2AaszT
	 +DBOMus4xy8vjvvfUy420yo1V/c6GTz8BAVqBQRbO0RGjkNXwja3dT/Hf336RVJemV
	 QPz25QywzWlNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F35D11717;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Fri, 25 Oct 2024 13:24:51 +0530
Subject: [PATCH v2 1/5] PCI/pwrctl: Use of_platform_device_create() to
 create pwrctl devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-pci-pwrctl-rework-v2-1-568756156cbe@linaro.org>
References: <20241025-pci-pwrctl-rework-v2-0-568756156cbe@linaro.org>
In-Reply-To: <20241025-pci-pwrctl-rework-v2-0-568756156cbe@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krishna chaitanya chundru <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1911;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=bQwt/wTH5U7vcbRycg6o15FZXsFwt0f+Sqj6aoPRom4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnG07TaqMG39ouPhAtQ/1hfbOR1a1q9jrf2+EHO
 qn1DwnNI5aJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZxtO0wAKCRBVnxHm/pHO
 9ZekB/9MkgETc9QdhjILs7JgkZY5fUcLEiB5I3JJ+b4pnCyel9S3vgWZMEAyT0X9TKU2B9oaT+y
 BV8/dxvPqyiElIAcPsg+PGpRICrJczC2ZiCej0znaTj1bWZLpzNGiZGNiba98B74NAS2n0vO7c1
 LNvoKZjqIpAfcJH/e09p5q6u+e0ujrfw6il1ALsv/cD5pSJkKTCGMWcBbK/VIrz8q3GAxNSmsus
 uXQiZg2LsDKb8ZLC6i8o3I6ylTCEA/ajJRqEIX5onH8w3O1R9EUaaB7K037jUYz/HgvBDk3lMS2
 cOXDjQOhsmcJA1f/mkl6dTh1AJm2CzEjwbctRa5ASY4w14vR
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

of_platform_populate() API creates platform devices by descending through
the children of the parent node. But it provides no control over the child
nodes, which makes it difficult to add checks for the child nodes in the
future. So use of_platform_device_create() API together with
for_each_child_of_node_scoped() so that it is possible to add checks for
each node before creating the platform device.

Tested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 55c853686051..9d278d3a19ff 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -13,6 +13,7 @@
 #include <linux/ioport.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -329,6 +330,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
 void pci_bus_add_device(struct pci_dev *dev)
 {
 	struct device_node *dn = dev->dev.of_node;
+	struct platform_device *pdev;
 	int retval;
 
 	/*
@@ -351,11 +353,11 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_dev_assign_added(dev, true);
 
 	if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
-		retval = of_platform_populate(dev_of_node(&dev->dev), NULL, NULL,
-					      &dev->dev);
-		if (retval)
-			pci_err(dev, "failed to populate child OF nodes (%d)\n",
-				retval);
+		for_each_available_child_of_node_scoped(dn, child) {
+			pdev = of_platform_device_create(child, NULL, &dev->dev);
+			if (!pdev)
+				pci_err(dev, "failed to create OF node: %s\n", child->name);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(pci_bus_add_device);

-- 
2.25.1



